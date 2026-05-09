Return-Path: <netdev+bounces-286120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB85ECz1/mlv0AAAu9opvQ
	(envelope-from <netdev+bounces-286120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:49:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CED4A4FED57
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E0133025F6E
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ADA3921D6;
	Sat,  9 May 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7MRkn0R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E3390CBF;
	Sat,  9 May 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316552; cv=none; b=SwlRn207tlm/g5u6o+wUvrsWWB28+a8/Yeg/p4wbuy2dvIrDEAzts0vG2XNQjl/Aw7uzwz+7CbzsIxQcYZSLEwqa6qIuxPfyCuMt4rn8fnX0X/kC7Ak5fQAzXYaXOMiZL3YcGOxP8MOCaL8EW19AxG0qxzslyXWSEFT5Stklrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316552; c=relaxed/simple;
	bh=sm48uSVsqxNrU8bhqo89V6a2zb/Kw5l++GPf/akJaps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnY/B1Fa7bzqEqhbO/3KzZgV5rum2s79z4olrRrJ+5Jcw9PcJgMMx6iKeXs5Oyia5nvDKKV5NDjPlMHTYrznA6fG7TWpEef4PU5Vj9r0j2671XafYSIE11CAcrX6WnRApSey/a1HhvRnnWBIudeQ6qOpJpXB+93aEc/LDb9eRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7MRkn0R; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778316551; x=1809852551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sm48uSVsqxNrU8bhqo89V6a2zb/Kw5l++GPf/akJaps=;
  b=S7MRkn0ReauyWqrufOpNNYC4xSbcgOO1VMu7se8dmerOyKWzc9W9G6XO
   NHkmhnzaJYEWf97E5lhAnwt5bkZhRjivgyBjU3ljlQXXshCbsgPhwsgG2
   t4914T6V4P3NhN7/dZVBfMs6/YHUbW5TFQyWJy0uMo+3I7eCl5O4/uBnq
   8gVhNNxT0hcdMKLzYoVDJoqT4tsgqo+fYBYJ9bwEXHNhXRPoKO5zupBiI
   kMbWyJh/z3bCX1SaVSZcuZx5y5wairctDZzyCdp4FQKxm0QncWGcMt8+a
   8QuP2N/ajboF+d+QOHHG8oXvXdiuUNgVP8Rygg60uOzQ/gwND+vC5TJM0
   g==;
X-CSE-ConnectionGUID: YJXSSuj8Rrq+pTkH0o8/EA==
X-CSE-MsgGUID: hKILGG37Rn6Ov045PgA6jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90748735"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90748735"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:49:11 -0700
X-CSE-ConnectionGUID: rZL8z6BDTeWaIOB1Wv92Eg==
X-CSE-MsgGUID: k8RcWPixReilysJ7BN7uKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="237088160"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2026 01:49:08 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	lorenzo@kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH RFC net-next 2/4] xdp: return status from generic_xdp_tx()
Date: Sat,  9 May 2026 10:48:56 +0200
Message-Id: <20260509084858.773921-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CED4A4FED57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286120-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Once veth will start to use __do_xdp_generic(), this will be helpful for
correct stats values being incremented - otherwise we would not have a
knowledge whether XDP_TX succeeded or not. With this being implemented we
will only bump xdp_tx stat when actual transmission happened.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/linux/netdevice.h |  2 +-
 kernel/bpf/devmap.c       |  2 +-
 net/core/dev.c            | 11 +++++++++--
 net/core/filter.c         |  2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 47417b2d48a4..473b18b0bb63 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4255,7 +4255,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog);
-void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
+int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
 int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 3d619d01088e..b7a4a0266345 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -714,7 +714,7 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 		return 0;
 
 	skb->dev = dst->dev;
-	generic_xdp_tx(skb, xdp_prog);
+	(void)generic_xdp_tx(skb, xdp_prog);
 
 	return 0;
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 6cc2a5bed20f..09012cdea376 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5628,11 +5628,12 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
  * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
  * queues, so they do not have this starvation issue.
  */
-void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
+int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
 {
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq;
 	bool free_skb = true;
+	int err = -ENETDOWN;
 	int cpu, rc;
 
 	txq = netdev_core_pick_tx(dev, skb, NULL);
@@ -5640,8 +5641,12 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
 	HARD_TX_LOCK(dev, txq, cpu);
 	if (!netif_xmit_frozen_or_drv_stopped(txq)) {
 		rc = netdev_start_xmit(skb, dev, txq, 0);
-		if (dev_xmit_complete(rc))
+		if (dev_xmit_complete(rc)) {
 			free_skb = false;
+			err = 0;
+		} else {
+			err = -EBUSY;
+		}
 	}
 	HARD_TX_UNLOCK(dev, txq);
 	if (free_skb) {
@@ -5649,6 +5654,8 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
 		dev_core_stats_tx_dropped_inc(dev);
 		kfree_skb(skb);
 	}
+
+	return err;
 }
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
diff --git a/net/core/filter.c b/net/core/filter.c
index bf9c37b27646..d6d14e0a1e35 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4619,7 +4619,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 
 		skb->dev = fwd;
 		_trace_xdp_redirect(dev, xdp_prog, ri->tgt_index);
-		generic_xdp_tx(skb, xdp_prog);
+		(void)generic_xdp_tx(skb, xdp_prog);
 		return 0;
 	}
 
-- 
2.43.0


