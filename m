Return-Path: <netdev+bounces-271993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLghKvcfxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:00:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C625334D94
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B515E301C3FB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F33F8803;
	Thu, 26 Mar 2026 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1zWMz/v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20E3F7A83;
	Thu, 26 Mar 2026 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525788; cv=none; b=feqyKmTcBgqy418pEELneAgv+Swe4ooQIrYaTEKIsL7/wRjkKKytmCfG9iS8HBwa984v9t1xJTuMcbTfVSPZT+8Y7rJc5/9dppokuGEjLJTK3LdiKB+VtcK3ZybdDZX35SSCfos0Mo/9sq0bwgNILwtx5tr+8wr8ZDkLl6CzchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525788; c=relaxed/simple;
	bh=PzBFdDhMquFEuDQF9TQj8dLh3ssgnCZMs5ANL6V0d74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1K5MT4z5kGeYg4VzQmUiUV9PbfE985WLeC7xospZcOzblRZz+I+9joA5zZmr2mUvyqgH7SmaENJx8AFh3umY6tROHAzjAznz80Xo3dDcNVu8Rei/uos4Rfeli3kYgXvdWDxF4Y2/ecYP4w9v9m2zMTxaMDK/6XI1xwu4Aiisek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1zWMz/v; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525778; x=1806061778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PzBFdDhMquFEuDQF9TQj8dLh3ssgnCZMs5ANL6V0d74=;
  b=N1zWMz/vKapxkhEqt0itB3CDBpxAF1Wx0II5egvagbwnmWdi/GbVd6V5
   N7Apz2XW8nU9aSL/pDWSanMmDPjYCi8mPOveOGgCGNpWi81wAl3h/8Yge
   ETUrWkUHmA6m2KnXLzYVysUkExysz0uUm608PyHA2hTSrttMEv3I7OCNq
   s+4n2SxrAbfKB7fiCF2aDg7rYTF6wyDFnxdnnzETjMAFRUaCll2M/Hzd0
   b6jSjMoy7+xVj0K5cJUlkimgEuCXA4pLKSwj/oV3aqZTeA0j9oTBCSi3U
   XuyfEA9iiSTRaZkKBbJBkXb1NPYSIrLRdm95ZTZs0V/mMRXCRZb+meqtN
   w==;
X-CSE-ConnectionGUID: U63LQadHTLiYxhtJAGL0aw==
X-CSE-MsgGUID: 38YkNZNJRNGkqHMFH7VJkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776238"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:37 -0700
X-CSE-ConnectionGUID: OahEZdzFQmWpBRqxkWCW8w==
X-CSE-MsgGUID: i6gqtILOS5KJ8aBStRTtMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029012"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:34 -0700
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
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v4 net 02/11] xsk: respect tailroom for ZC setups
Date: Thu, 26 Mar 2026 12:49:10 +0100
Message-Id: <20260326114919.519456-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271993-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 3C625334D94
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
zc and underlying netdev supports zc multi-buffer. Rely on pool->dev
state when configuring tailroom. xsk_pool_get_rx_frame_size() inside
ndo_bpf is usually called when bringing up queues and before xsk's dma
mappings have been configured, which makes it valid to rely on
pool->dev.

Typically drivers on Rx Hw buffers side work on 128 byte alignment so
let us align the value returned by xsk_pool_get_rx_frame_size() in order
to avoid addressing this on driver's side. This addresses the fact that
idpf uses mentioned function *before* pool->dev being set so we were at
risk that after subtracting tailroom we would not provide 128-byte
aligned value to HW.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b9ebae2dc95..dcf811c45b22 100644
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
+	if (pool->dev && (umem->flags & XDP_UMEM_SG_FLAG))
+		return SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	return 0;
+}
+
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return pool->chunk_size;
@@ -48,7 +61,9 @@ static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 
 static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
-	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
+	return ALIGN_DOWN(xsk_pool_get_chunk_size(pool) -
+			  xsk_pool_get_headroom(pool) -
+			  xsk_pool_get_tailroom(pool), 128);
 }
 
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
-- 
2.43.0


