Return-Path: <netdev+bounces-269596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNAoIb44vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:56:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A002D05E6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C53D330268A2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62779372EC4;
	Thu, 19 Mar 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3M5+Fn0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C743F0AB0;
	Thu, 19 Mar 2026 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942951; cv=none; b=GP6z3VhZpzS0vGXpxN6wE6sIqCqKEJROXJrh5B4JqT64ZJz34Cs90xC3iXANFNoBUAxJl8VPRYt4xC6z36EGjLDvYZuSzkFRKTzfOP0DlP8Vk+X6smunVMddqzYVbI+JOTwJ2Jh54Va5/z58GAbEx5YVW5G6zjmWq6LJtNqtPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942951; c=relaxed/simple;
	bh=K3VMRXn0RtCNunu5alorXPn83DOyVuCSyaYG0LI4U6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7zzFW4vgENvQ5qYoLFQtcMFjx7sZVJbXybzSS4yHgqJJZ8clfy9CU8rWs3g9/4JccMV4eE9+sVYJhLG/0HcmshR91O711yrTV4xhY5aSLeTCKlNkkYlIGNRgVEOTk7qTzYvv841tK3Vo5drmxVP/FiLmV5AG06u1HNKJuw/yG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3M5+Fn0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773942949; x=1805478949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3VMRXn0RtCNunu5alorXPn83DOyVuCSyaYG0LI4U6A=;
  b=V3M5+Fn0J4ieztJm/UtF8r9rvScpPOXUMY6DF/OeXfJWe2G4ghna+F62
   jPwViO1Ix9C6R/RXJhEa2x2xE7h8keiQR/dqxU+Iu04+w9IqxCpaDEP1s
   frchvSyarP2U+3QuxaByeDKPGa3iM8bMT7NfknjeOo0GSt8kprdF8ca7T
   42yqIkr4hmPAR2Q3Z4dpHMDeexZOi73tqMbtM6PHywjaiE1kauSqu1X7b
   Oy65GCEXGkwEw0RrBLa3hVXByjEWbtsjxSGqbld1Xj0Z+gieDuSGEGLXw
   XCy3+klBn7rijShwui2PaMuGmAEm6bVprUkWPszR6vdByZIjUp/fBCwEd
   w==;
X-CSE-ConnectionGUID: myYyCuNpT2O/HV/FBVgx+g==
X-CSE-MsgGUID: iefcAdX4Rkqb/oHU2GdYlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74038587"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74038587"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:55:49 -0700
X-CSE-ConnectionGUID: T6w2qcbiQ7iOoVa7nUF6tw==
X-CSE-MsgGUID: 26f89hY+QdqXTf0fkV/2sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="246058561"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 19 Mar 2026 10:55:46 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 2/8] xsk: respect tailroom for ZC setups
Date: Thu, 19 Mar 2026 18:55:32 +0100
Message-Id: <20260319175538.479139-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
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
	TAGGED_FROM(0.00)[bounces-269596-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.985];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13A002D05E6
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

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b9ebae2dc95..bef4e1b91034 100644
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
@@ -48,7 +61,8 @@ static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 
 static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
-	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
+	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool) -
+	       xsk_pool_get_tailroom(pool);
 }
 
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
-- 
2.43.0


