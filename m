Return-Path: <netdev+bounces-258415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KoUOgaHjWkZ3wAAu9opvQ
	(envelope-from <netdev+bounces-258415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:53:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51912B0A8
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55E4530C58A4
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4212C0F89;
	Thu, 12 Feb 2026 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwD4pHov"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4BF3FBA7
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770882809; cv=none; b=cZVksPJjrru42+uvpZdspNYCIU7QKp53JV0UurgUTaPrz3UiMm63dtn8ZyKnOVqlvZrO+EhWGm740iaZLgATsyJUdXHYoLLI5uHMgrP9vped1JhHjKQaTRio89PdROMc6WpJE/XdXK8qZHqwhjLUQqdzDTCbDxY3TRrCjnwnkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770882809; c=relaxed/simple;
	bh=Mow4zmkr8CE3hoRKcZ6BbEVuJB5JMS7kyoM5Czy4icI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TnGzxDVAxd/uSeKyEspd9jKiRanehqnKtK9bEBXr4M7bcUWNE9hlVQoqRrS50qOy3qNQ3j1ddtcWtvkAOzILR0uRogrYRrvny+D0rKjNn+cClGJ6HdRf6fC7gmUzoci4JRIcrv9+YeTRad0HYsSrcGENTXuOlLzgXrr8n+/ETbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwD4pHov; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770882806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l0/e9zeYXG8z/u3O4hC/oU1DdGHJKYlimLvsT/jtTTU=;
	b=AwD4pHovWqT+UvTLUyOZNdddw8QNGAVy+C317mMByWpK4QTXut0CZuQkY4rnrnrKlDxykA
	/V2Qo6mzM0YtqpIS/crABCgp36NnhSELhV26wo43iYiQAITE2rREaJqmwEvaGI7K4OnQI+
	2apBeeDKJ28uGoVRKaurqr2l2fGf/gw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-h8SiWTshP5Wb4tDvq4HgUA-1; Thu,
 12 Feb 2026 02:53:22 -0500
X-MC-Unique: h8SiWTshP5Wb4tDvq4HgUA-1
X-Mimecast-MFC-AGG-ID: h8SiWTshP5Wb4tDvq4HgUA_1770882800
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC7B71955D88;
	Thu, 12 Feb 2026 07:53:19 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EF281956095;
	Thu, 12 Feb 2026 07:53:15 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 0/2] ice: fix representor stats in switchdev mode
Date: Thu, 12 Feb 2026 08:53:09 +0100
Message-ID: <cover.1770882260.git.poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258415-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C51912B0A8
X-Rspamd-Action: no action

Port representor statistics in switchdev mode are completely broken due
to two independent bugs:

1) ice_repr_ready_vf() has inverted logic — it returns "not ready" when
   the VF is actually ready, causing all ethtool and ndo_get_stats64
   callbacks to bail out early.

2) Even with the readiness check fixed, ice_update_vsi_stats() always
   returns early for VF VSIs because ICE_VSI_DOWN is permanently set.
   The stats counters are never updated from hardware.

Patch 1 fixes the inverted readiness check.
Patch 2 switches to ice_update_eth_stats() which reads the GLV_*
hardware counters directly, matching what ice_get_vf_stats() already
does for VF stats in legacy mode.

Petr Oros (2):
  ice: fix inverted ready check for VF representors
  ice: use ice_update_eth_stats() for representor stats

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 14 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_repr.c    |  5 +++--
 2 files changed, 14 insertions(+), 5 deletions(-)

--
2.52.0


