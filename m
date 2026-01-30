Return-Path: <netdev+bounces-255185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF1ZHififGmpPAIAu9opvQ
	(envelope-from <netdev+bounces-255185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:53:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA214BCA98
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 664CD30160DF
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBC34FF63;
	Fri, 30 Jan 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcF6T1zE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37413202963
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792036; cv=none; b=XSntooxCV03gkZyiZMsLN/t6REWtNkyWVa7qtksdBX7YY87IQI0G7LEVcmbrV5K0I3cEtHLMv95NLiY9Z8RfkJFaJCHW2txUyD5flyNDtmI91urdmBdvt1wVAxm4XzB45JDw/xe+SJ6zZbzdXUbg//eLtJUAJvcXD0crmmj2yQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792036; c=relaxed/simple;
	bh=J6K+R2XhfcHEite8zYKlhrNa6BzO1FkrGVGU/m30fCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRyKiSsa9xN1uyxSrz8L1ZXKBaRAolDucGGINfjWs89lB8nIssqG2g1j9BAcQ52xz5RRXpvreyeE9DmZXrEbwrQz1fuW7NONkKecwpbVBTgrhCblRUI7wJ3RbZGAGLR0y+8bldIDamzfIjJy+7KkEvDqVmcVOVh2akWSb7otxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcF6T1zE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769792034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6tC1wi5dMVORuOYEgaYlYA0EwXoXG5oInK0fxZdxC9E=;
	b=CcF6T1zENfZGUEZg0cB8Pzp5FoQfyiqNcSHw0ktAORIHJBfV63nDD1fc4vCHd/oSi2i0gk
	4KLYdWkSEDWkCgUAuu2s0GeAdGraldXWFBLpgAA3Zel0HljltUeEv2Xnyn3PeePUwQcS6T
	Q6HcCQ24Jw7C1a1kJdljY8QMYcbCKD0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-a-Kvt5eXNMOR5kXebgYFVA-1; Fri,
 30 Jan 2026 11:53:49 -0500
X-MC-Unique: a-Kvt5eXNMOR5kXebgYFVA-1
X-Mimecast-MFC-AGG-ID: a-Kvt5eXNMOR5kXebgYFVA_1769792027
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9174719560A5;
	Fri, 30 Jan 2026 16:53:46 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.27])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E4871800109;
	Fri, 30 Jan 2026 16:53:39 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 0/9] dpll: Core improvements and ice E825-C SyncE support
Date: Fri, 30 Jan 2026 17:53:29 +0100
Message-ID: <20260130165338.101860-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255185-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA214BCA98
X-Rspamd-Action: no action

This series introduces Synchronous Ethernet (SyncE) support for the Intel
E825-C Ethernet controller. Unlike previous generations where DPLL
connections were implicitly assumed, the E825-C architecture relies
on the platform firmware (ACPI) to describe the physical connections
between the Ethernet controller and external DPLLs (such as the ZL3073x).

To accommodate this, the series extends the DPLL subsystem to support
firmware node (fwnode) associations, asynchronous discovery via notifiers,
and dynamic pin management. Additionally, a significant refactor of
the DPLL reference counting logic is included to ensure robustness and
debuggability.

DPLL Core Extensions:
* Firmware Node Association: Pins can now be associated with a struct
  fwnode_handle after allocation via dpll_pin_fwnode_set(). This allows
  drivers to link pin objects with their corresponding DT/ACPI nodes.
* Asynchronous Notifiers: A raw notifier chain is added to the DPLL core.
  This allows the Ethernet driver to subscribe to events and react when
  the platform DPLL driver registers the parent pins, resolving probe
  ordering dependencies.
* Dynamic Indexing: Drivers can now request DPLL_PIN_IDX_UNSPEC to have
  the core automatically allocate a unique pin index.

Reference Counting & Debugging:
* Refactor: The reference counting logic in the core is consolidated.
  Internal list management helpers now automatically handle hold/put
  operations, removing fragile open-coded logic in the registration paths.
* Reference Tracking: A new Kconfig option DPLL_REFCNT_TRACKER is added.
  This allows developers to instrument and debug reference leaks by
  recording stack traces for every get/put operation.

Driver Updates:
* zl3073x: Updated to associate pins with fwnode handles using the new
  setter and support the 'mux' pin type.
* ice: Implements the E825-C specific hardware configuration for SyncE
  (CGU registers). It utilizes the new notifier and fwnode APIs to
  dynamically discover and attach to the platform DPLLs.

Patch Summary:
Patch 1: DPLL Core (fwnode association).
Patch 2: Driver zl3073x (Set fwnode).
Patch 3-4: DPLL Core (Notifiers and dynamic IDs).
Patch 5: Driver zl3073x (Mux type).
Patch 6: DPLL Core (Refcount refactor).
Patch 7-8: Refcount tracking infrastructure and driver updates.
Patch 9: Driver ice (E825-C SyncE logic).

Changes in v3:
* Dropped patches 1, 3 & 9
* Other v3 changes mentioned in individual patches

Arkadiusz Kubalewski (1):
  ice: dpll: Support E825-C SyncE and dynamic pin discovery

Ivan Vecera (7):
  dpll: Allow associating dpll pin with a firmware node
  dpll: zl3073x: Associate pin with fwnode handle
  dpll: Support dynamic pin index allocation
  dpll: zl3073x: Add support for mux pin type
  dpll: Enhance and consolidate reference counting logic
  dpll: Add reference count tracking support
  drivers: Add support for DPLL reference count tracking

Petr Oros (1):
  dpll: Add notifier chain for dpll events

 drivers/dpll/Kconfig                          |  15 +
 drivers/dpll/dpll_core.c                      | 288 ++++++-
 drivers/dpll/dpll_core.h                      |  11 +
 drivers/dpll/dpll_netlink.c                   |   6 +
 drivers/dpll/zl3073x/dpll.c                   |  15 +-
 drivers/dpll/zl3073x/dpll.h                   |   2 +
 drivers/dpll/zl3073x/prop.c                   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 755 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  30 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  32 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 217 +++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  16 +-
 drivers/ptp/ptp_ocp.c                         |  18 +-
 include/linux/dpll.h                          |  59 +-
 18 files changed, 1347 insertions(+), 150 deletions(-)

-- 
2.52.0


