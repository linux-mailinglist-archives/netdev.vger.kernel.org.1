Return-Path: <netdev+bounces-269780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IVeDMZbVvGkk3gIAu9opvQ
	(envelope-from <netdev+bounces-269780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:05:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05DB2D5DDA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F338303C4DD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 05:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABBA2E6CA6;
	Fri, 20 Mar 2026 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJapzWGV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986951DF72C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983123; cv=none; b=LOSbaBqpzRrQ/qLOq7k1KoI4zN138OiTz4xtyaHnM6sJBGK2SqFqjm4gFuXTq4eQIYmtuOEUBrXwIYnUHXTSoSiDTzJYLn/UEQg0DvMFF2z2O4Oe3DVFTWojr6/N8wFHdYRRYHgPqcp2yMQlNDZuQ3ERYof0y7UChAviL/4ZSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983123; c=relaxed/simple;
	bh=DgrE2MwUT9sntQ/qvQ7JgAgAPRBneIx6aGJnv3XM8Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdZIwoD+77NLlbEc2m2aadKDLJxqYDH2rhd+DJsx+u513F0gWxC7pDEWZ8QSsoOXona/g9QLjp7XTU/TicL/N+47hwsCYB2f+OpUmji4Dr61XjEtO0yvJ3cTtvbBggDQzFgzquhhhYYq4hIIz8kaT6dj9YWktRiw7HNOqNTQ4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJapzWGV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983121; x=1805519121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DgrE2MwUT9sntQ/qvQ7JgAgAPRBneIx6aGJnv3XM8Pw=;
  b=VJapzWGV+nB9rqc/iBJ7qJTpCF5rhcZqWD2QFlByBEJR0wfzgX5bk1SU
   7deEKt60As/RamGG2OW+WoxiLV2X6+pzY2CPrtvRBsyzYyfJoOsptOr3U
   IzrqM5G52z0wDO+KcmF5g1qwkWrkBogcpKabfkVujyGulOsJ/+RVKAhXU
   37+Cfx3h3+B5gwH0nE0BUy7NBVQ4imTVZJtjudZ8LANOECEN7PWJ0wPK/
   2bcgKjaWcT/a2UTh8Hic/5UZt4nA8njIeQMrejwxcQGUchQikadPvsZaJ
   2mvCStldf2fK3eqJpUdAa2vHxO2xgkeNZ9p2qDveIwUr+VXIx2ogPO0/3
   w==;
X-CSE-ConnectionGUID: RTTIqOaZSweE/vVMljAoMQ==
X-CSE-MsgGUID: hJTIrmsZRY+JXifmIK6ZKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522669"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100522669"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:21 -0700
X-CSE-ConnectionGUID: lZ2lxThgT8Sme5q3KiCt4g==
X-CSE-MsgGUID: fwe+DApRSd24oV7xODS/LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227307229"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:19 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Subject: [PATCH] ice: add missing reset of the mac header
Date: Fri, 20 Mar 2026 06:05:18 +0100
Message-ID: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269780-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D05DB2D5DDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>

By default skb->mac_header is not set, so reset prevents access to an
invalid pointer.

Call skb_reset_mac_header() before accessing the mac header from skb.

Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2cd4cf..374b17f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2211,6 +2211,8 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 		goto out_drop;
 
 	/* allow CONTROL frames egress from main VSI if FW LLDP disabled */
+	if (likely(!skb_mac_header_was_set(skb)))
+		skb_reset_mac_header(skb);
 	eth = (struct ethhdr *)skb_mac_header(skb);
 
 	if ((ice_is_switchdev_running(vsi->back) ||
-- 
2.52.0


