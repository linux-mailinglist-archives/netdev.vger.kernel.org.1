Return-Path: <netdev+bounces-259318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LNMNLvUlWnFVAIAu9opvQ
	(envelope-from <netdev+bounces-259318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:03:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B191573E8
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37E443049158
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBCC33FE0D;
	Wed, 18 Feb 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD48LkDp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D334028D;
	Wed, 18 Feb 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426816; cv=none; b=h2V3wkFTD7xJJ1ZBPO2mh+L1kcHhT5Q/rXDk8WjG2f+XCaJw03w1od2yzHk+SqhaEWHFox0a+yKagzLh1RPDCnW51RFTxbWjeh9POU4bpAWZuGa+LwgRjEYrEpMFnFQtZAIRdidDXYb2oebndwrMxzs+mXvmkWyhj6kd/+lUQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426816; c=relaxed/simple;
	bh=YJ02StziDm+Wa1X8sTQb8fCKfkoWcRuVr/b40mVVPak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uvsbi5tg0hhO6n3VzmAKXX6UcWFALgPEFGC2DfaI1gJmpRtpKSGEwe0GdeXXbsC9L/0MKlCr5o4GSBkrWTsGClfcmCls87pelP15R8zfXvI/b3GYfiBLpZSB0KJuMKfPOKC3VcWMi532PfanwUDfAyGU+swtZfuiIq6nUZGGE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD48LkDp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771426814; x=1802962814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YJ02StziDm+Wa1X8sTQb8fCKfkoWcRuVr/b40mVVPak=;
  b=dD48LkDpL7PGuA4Qyz8ocnyGI61VzIaZPSOdzcnfsqB8pRBf12MxFG3e
   oj6Mma4xLvb1vau8+M6X8criHkhT1EpGYO97kwGZUkpakNZZoZlPqHSMB
   182HWsVr7BkaPHsyAKHniV7qFq8N7qVRye65Z7P9L2upn4tUrydKaVfgq
   Lejj9Qv3RLASXn+E61MnR8wH/74+qInjhO/cg2whVbvcC2oieOntE5RD/
   fUeoumCgkEkyR5CqPGRRgkegXj3B3rbZ8So6N+E3+vboqUS7kqt0LniDZ
   XOiCCMt7z/QX1YkkUcQav+/Tb1zHYJevUSwJsPFccrrOmqMrIyTdLp1Lw
   A==;
X-CSE-ConnectionGUID: PoMU3PpzQRyPs9YaB3SXjw==
X-CSE-MsgGUID: dRI0V5sKTzmqCpafgWTpWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="97962924"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="97962924"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 07:00:14 -0800
X-CSE-ConnectionGUID: 84f300loT4OYKMx37TRddg==
X-CSE-MsgGUID: MyuPfAJOTIawbpau2V0Fxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="213402680"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 18 Feb 2026 07:00:12 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next] xsk: avoid double checking against rx queue being full
Date: Wed, 18 Feb 2026 16:00:00 +0100
Message-Id: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259318-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64B191573E8
X-Rspamd-Action: no action

Currently non-zc xsk rx path for multi-buffer case checks twice if xsk
rx queue has enough space for producing descriptors:
1.
	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
		xs->rx_queue_full++;
		return -ENOBUFS;
	}
2.
	__xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0);
	-> err = xskq_prod_reserve_desc(xs->rx, addr, len, flags);
	  -> if (xskq_prod_is_full(q))

Second part is redundant as in 1. we already peeked onto rx queue and
checked that there is enough space to produce given amount of
descriptors.

Provide helper functions that will skip it and therefore optimize code.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c       | 14 +++++++++++++-
 net/xdp/xsk_queue.h | 16 +++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..aaadc13649e1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -160,6 +160,17 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
 	return 0;
 }
 
+static void __xsk_rcv_zc_safe(struct xdp_sock *xs, struct xdp_buff_xsk *xskb,
+			      u32 len, u32 flags)
+{
+	u64 addr;
+
+	addr = xp_get_handle(xskb, xskb->pool);
+	__xskq_prod_reserve_desc(xs->rx, addr, len, flags);
+
+	xp_release(xskb);
+}
+
 static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
@@ -292,7 +303,8 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		rem -= copied;
 
 		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
-		__xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0);
+		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
+				  rem ? XDP_PKT_CONTD : 0);
 		meta_len = 0;
 	} while (rem);
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1eb8d9f8b104..4f764b5748d2 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -440,20 +440,26 @@ static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_de
 	q->cached_prod = cached_prod;
 }
 
-static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
-					 u64 addr, u32 len, u32 flags)
+static inline void __xskq_prod_reserve_desc(struct xsk_queue *q,
+					    u64 addr, u32 len, u32 flags)
 {
 	struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 	u32 idx;
 
-	if (xskq_prod_is_full(q))
-		return -ENOBUFS;
-
 	/* A, matches D */
 	idx = q->cached_prod++ & q->ring_mask;
 	ring->desc[idx].addr = addr;
 	ring->desc[idx].len = len;
 	ring->desc[idx].options = flags;
+}
+
+static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
+					 u64 addr, u32 len, u32 flags)
+{
+	if (xskq_prod_is_full(q))
+		return -ENOBUFS;
+
+	__xskq_prod_reserve_desc(q, addr, len, flags);
 
 	return 0;
 }
-- 
2.43.0


