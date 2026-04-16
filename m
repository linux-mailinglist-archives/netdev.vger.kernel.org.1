Return-Path: <netdev+bounces-279017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKHXNWDL4GkdmAAAu9opvQ
	(envelope-from <netdev+bounces-279017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBE140D980
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E599A3006B56
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7954A396B73;
	Thu, 16 Apr 2026 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfBTMqzU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33A3932CE
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339609; cv=none; b=Cl184ERebxMRcXfI0IgyS3NGAX6Mc2UWcWAGMYU/2L/9S6KZ34LTdcXSORcAnou8urc94M5MjW8slMjbrW7h5dwORve4vzi9OmCG9AXQwx7ckBzF6tgx5t0f3loQaw6s1S+TmnuHvRbnETU48DbQajGsz7PFdzRo7M8T6sLrMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339609; c=relaxed/simple;
	bh=KsafRWYizcidBGwrwitp6VISrgMBgFfJMsgnRXQOr5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4RxbWugcqGxISi6RAQ362fCw4L2GsYDlJD+XHRQfN96dar4jRfYr0xKSEtDEbVZyU+6rnQ5qxOemPlxJjl98r0h2E3pbul3YHJXSAwsdP23Bhk9w8Cf7GqXQFoyjIrN2NGvO2pRrBY1X0xtQn1o3X0W2QG+jBQ62nPl1zNo70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfBTMqzU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776339607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gPELNDldpf97R0KV4JjuN3zxWJ7Io8gIfV7XUJjMv6c=;
	b=bfBTMqzUY2FzAMCbx0D4/afeh3hFBt+l5hVkKjWkbok49/dO2WB/LSThLyfamjfRsTPR2T
	cxQWwKps9unf/Z8Kgg7qpfC0t2XLxCr2rjz2LJRsjokHCwbFTtNtF5+jrkgc1tRdIpv4JM
	UW4kjmecV4bXpzK9QCRrp7H9iZCbfRI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-SaU8kfhZPKeGf_IKr-5oAA-1; Thu,
 16 Apr 2026 07:40:04 -0400
X-MC-Unique: SaU8kfhZPKeGf_IKr-5oAA-1
X-Mimecast-MFC-AGG-ID: SaU8kfhZPKeGf_IKr-5oAA_1776339602
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54BAA1800473;
	Thu, 16 Apr 2026 11:40:01 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAAA21800577;
	Thu, 16 Apr 2026 11:39:55 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v6 0/2] ice: fix missing dpll notifications for SW pins
Date: Thu, 16 Apr 2026 13:39:50 +0200
Message-ID: <20260416113952.389405-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279017-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CBE140D980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SMA/U.FL pin redesign never propagated dpll notifications to the
software-controlled pin wrappers.  This series fixes that by adding
peer notification for paired SMA/U.FL pins and by wrapping
dpll_pin_change_ntf() calls in the periodic work to also cover SW pins.

Patch 1 exports __dpll_pin_change_ntf() so ice can send peer
notifications from callback context where dpll_lock is already held.

Patch 2 fixes the notification gaps: periodic work HW-to-SW
propagation, SW-to-SW peer notification on PCA9575 routing changes,
and SW pin phase offset reporting.

Ivan Vecera (1):
  dpll: export __dpll_pin_change_ntf() for use under dpll_lock

Petr Oros (1):
  ice: fix missing dpll notifications for SW pins

 drivers/dpll/dpll_netlink.c               | 10 +++
 drivers/dpll/dpll_netlink.h               |  2 -
 drivers/net/ethernet/intel/ice/ice_dpll.c | 80 +++++++++++++++++++----
 include/linux/dpll.h                      |  1 +
 4 files changed, 79 insertions(+), 14 deletions(-)

---
v6:
 - fix deadlock reported by Michal Schmidt: dpll_pin_change_ntf() in
   peer notification was called with dpll_lock held, causing deadlock.
   Move the peer notification calls out of ice_dpll_sma_direction_set()
   and ice_dpll_ufl_pin_state_set() into their dpll_pin_ops callback
   wrappers, after pf->dplls.lock is released, and use
   __dpll_pin_change_ntf() because dpll_lock is still held by the dpll
   netlink layer (dpll_pin_pre_doit).
v5: https://lore.kernel.org/all/20260409102501.1447628-1-poros@redhat.com/
v4: https://lore.kernel.org/all/20260319205256.998876-1-poros@redhat.com/
v3: https://lore.kernel.org/all/20260220140700.2910174-1-poros@redhat.com/
v2: https://lore.kernel.org/all/20260219131500.2271897-1-poros@redhat.com/
v1: https://lore.kernel.org/all/20260218211414.1411163-1-poros@redhat.com/


