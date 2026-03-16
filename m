Return-Path: <netdev+bounces-268231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOSLDgJDuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:50:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA329E89F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1288830417A1
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA841328B58;
	Mon, 16 Mar 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP2R0G+6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B5332EDE;
	Mon, 16 Mar 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683196; cv=none; b=Wp2zDMIV3FdIsC6ck2mpummbBWe/DwVxgQPefi4MIz0/txshTOAoRJnuFg2IzErpxWW+JqM07R1kNNdhbWna2NgSvJ/Wkzy+1PMB7Up3YmeiPbGOJdbm0h/sczWc/NffvRGmh7LcV+93tER7RXwuYUBlbBbcq6rZTf3TKKvh0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683196; c=relaxed/simple;
	bh=ZDmmVskI/RIZvZlDzNOtv5Z9r2lW4JCrGVgCgfd6WNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5h4FyNGKYgNmLJceWQHiNkOtpdLMxoUJARB8a5fEoQanrrwaZ028FmVPcxxIJ3+oeyOtdaqja6V1anPNe2WaluuYzQfZ5dNp1RapzUdMnYbcYN4hlNBr9hBv/Au+l4CiAM4HfKFywHnHZRvZbcW2c0HCC9i2zZukN4/jcUFI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP2R0G+6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683195; x=1805219195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDmmVskI/RIZvZlDzNOtv5Z9r2lW4JCrGVgCgfd6WNs=;
  b=HP2R0G+6KyBU/Pt1nZSx94sG/ZkhjWYAT7WHmbqSSzL8ye9UUVaZyjV+
   ku09qn6nk7Dh9SG3ygbJNfmoUM7wHDngmoztPgk7nd/3kIBxXjCetkhc/
   CmecSkTUPNhdYZR3ttFB9rQ8ws5md64S07k7tT/VWRCutZmLIQ6uuhhj1
   pCKWFdyWhqbh8WhTyHJUuArI8f7vKQvrvNjwNhuc+ZGGW47cK1pLh9K4T
   3n60u4dcsXENscvCSImrLTmy7+dix5sJOm0dy9q1GsfBrYNHnqoOWELc2
   gf+5UC5F/FBP1oqO2Q2+/O/asbHxxEs9CfDtYgtXrdlbUlZbd7E3luStI
   A==;
X-CSE-ConnectionGUID: ueljrThGRYSjewnbCLWGZA==
X-CSE-MsgGUID: Ck42ZHN+Qo++wP2rClDt0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62275694"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62275694"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:46:34 -0700
X-CSE-ConnectionGUID: 2xC5iwcMQI+TiOsooC8CFg==
X-CSE-MsgGUID: qM6F9WWGTTOUB/9MDg8Hhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222075714"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2026 10:46:31 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 1/6] xsk: respect tailroom for ZC setups
Date: Mon, 16 Mar 2026 18:45:45 +0100
Message-Id: <20260316174550.462177-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268231-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 8DBA329E89F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multi-buffer XDP stores information about frags in skb_shared_info that
sits at the tailroom of a packet. The storage space is reserved via
xdp_data_hard_end():

	((xdp)->data_hard_start + (xdp)->frame_sz -	\
	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

and then we refer to it via macro below:

static inline struct skb_shared_info *
xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
{
        return (struct skb_shared_info *)xdp_data_hard_end(xdp);
}

Currently we do not respect this tailroom space in multi-buffer AF_XDP
ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
configure length of HW Rx buffer.

xsk_pool_get_tailroom() is only reserving necessary space when pool is
zc and underlying netdev supports zc multi-buffer. Since this function
relies on pool->umem->zc setting, set it before ndo_bpf during zc
configuration, so that driver that actually calls
xsk_pool_get_rx_frame_size() inside ndo_bpf will get correct tailroom
value.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h | 21 ++++++++++++++++++++-
 net/xdp/xsk_buff_pool.c    |  3 ++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b9ebae2dc95..13b2aae00737 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -41,6 +41,19 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 	return XDP_PACKET_HEADROOM + pool->headroom;
 }
 
+static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
+{
+	struct xdp_umem *umem = pool->umem;
+
+	/* Reserve tailroom only for zero-copy pools that opted into
+	 * multi-buffer. The reserved area is used for skb_shared_info,
+	 * matching the XDP core's xdp_data_hard_end() layout.
+	 */
+	if (umem->zc && (umem->flags & XDP_UMEM_SG_FLAG))
+		return SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	return 0;
+}
+
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return pool->chunk_size;
@@ -48,7 +61,8 @@ static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 
 static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
-	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
+	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool) -
+	       xsk_pool_get_tailroom(pool);
 }
 
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
@@ -332,6 +346,11 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 	return 0;
 }
 
+static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
+{
+	return 0;
+}
+
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return 0;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 37b7a68b89b3..2cfc19e363e3 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -213,6 +213,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	bpf.command = XDP_SETUP_XSK_POOL;
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
+	pool->umem->zc = true;
 
 	netdev_ops_assert_locked(netdev);
 	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
@@ -224,13 +225,13 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		err = -EINVAL;
 		goto err_unreg_xsk;
 	}
-	pool->umem->zc = true;
 	pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
 	return 0;
 
 err_unreg_xsk:
 	xp_disable_drv_zc(pool);
 err_unreg_pool:
+	pool->umem->zc = false;
 	if (!force_zc)
 		err = 0; /* fallback to copy mode */
 	if (err) {
-- 
2.43.0


