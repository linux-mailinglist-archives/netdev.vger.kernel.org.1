Return-Path: <netdev+bounces-274612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB79MZyQzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:51:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4938B7C2
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0320B304F31B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC643E2745;
	Thu,  2 Apr 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FentGxwN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C63E1CE0;
	Thu,  2 Apr 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145042; cv=none; b=DhIfmhQlqQRonRtm1mJJk7OgT6TcD+oBwCdam963ElqAUC0+kFdY+hBKEG1UOGY1A2R8RmELsxVWuuCPJdt8e3tCKJ0+PQQsW1nGSor3s5QEE9WVIYKHl5sjKrO1FXnuTyNVhMjwtV1sV3lDXGw9DVc7XpW3PSDrAeRtfoRjevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145042; c=relaxed/simple;
	bh=Lj5Y8VRQwo0KZfbKCBz9aL5Toc6ueMlt2CudlSeGsPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdHm/YrQ0t6rB7iARQmhaEiNbQ8WCxJW8xujpzTvQTXNA//jl8+dAOUtN5Bx3no2gpq0j6xO5Ku+3jrHECS2B2QwumDFkZkrqSzeIbVTxDfUottdrJrDi/o7mLqtdbLrkH9mv56yg6L4lNB0GLneiIrWS1d/rlchoVpW8AR/yDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FentGxwN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775145042; x=1806681042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lj5Y8VRQwo0KZfbKCBz9aL5Toc6ueMlt2CudlSeGsPA=;
  b=FentGxwNMABCXD63IU6m5ScFIYBLO+TL8g9o2kWvbOD2kfEow9CEflu7
   OG3kP9DncpxDE2pUvyNpDlui8wVcB00duqIBe3z022+qhDmcKXZ6jW7i2
   /34sWDP5vrM6TjezSSanF4CZTsd/v5dPs/b9NeX8Gn4jpstMPf7bKBH0E
   e3GP9ZaBoCj9CLeYfINE7AQYp4/AxB+hvvkxwVfxQhquZ4MTAG5d2dUjS
   VoG1++uhtRirdQMAfYZKIRx/YJYcQ4LMIs4gXB9whBsoUWctx07nK/G1V
   VUi482WlBdgO2SzL5Vqmd2e7M8MgTsQDJUCfUGPGYLbD9CIiOMxOdrkAO
   w==;
X-CSE-ConnectionGUID: mP3Rs8DDSaGQwfIS59zdhQ==
X-CSE-MsgGUID: fQkoIIrHTVWxpQWkPAEv/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75927978"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75927978"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:50:41 -0700
X-CSE-ConnectionGUID: jxxPEH+3TA+Kn8OKWSsOnQ==
X-CSE-MsgGUID: 5BtdU2ZnSDGm9cs9/Y68sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="224157670"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2026 08:50:38 -0700
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
Subject: [PATCH v6 net 4/8] xsk: validate MTU against usable frame size on bind
Date: Thu,  2 Apr 2026 17:49:54 +0200
Message-Id: <20260402154958.562179-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274612-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78C4938B7C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AF_XDP bind currently accepts zero-copy pool configurations without
verifying that the device MTU fits into the usable frame space provided
by the UMEM chunk.

This becomes a problem since we started to respect tailroom which is
subtracted from chunk_size (among with headroom). 2k chunk size might
not provide enough space for standard 1500 MTU, so let us catch such
settings at bind time. Furthermore, validate whether underlying HW will
be able to satisfy configured MTU wrt XSK's frame size multiplied by
supported Rx buffer chain length (that is exposed via
net_device::xdp_zc_max_segs).

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_buff_pool.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 729602a3cec0..cd7bc50872f6 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -10,6 +10,8 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
+#define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
+
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
 	if (!xs->tx)
@@ -157,8 +159,12 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 int xp_assign_dev(struct xsk_buff_pool *pool,
 		  struct net_device *netdev, u16 queue_id, u16 flags)
 {
+	u32 needed = netdev->mtu + ETH_PAD_LEN;
+	u32 segs = netdev->xdp_zc_max_segs;
+	bool mbuf = flags & XDP_USE_SG;
 	bool force_zc, force_copy;
 	struct netdev_bpf bpf;
+	u32 frame_size;
 	int err = 0;
 
 	ASSERT_RTNL();
@@ -178,7 +184,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		return err;
 
-	if (flags & XDP_USE_SG)
+	if (mbuf)
 		pool->umem->flags |= XDP_UMEM_SG_FLAG;
 
 	if (flags & XDP_USE_NEED_WAKEUP)
@@ -200,8 +206,24 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
-	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
-		err = -EOPNOTSUPP;
+	if (mbuf) {
+		if (segs == 1) {
+			err = -EOPNOTSUPP;
+			goto err_unreg_pool;
+		}
+	} else {
+		segs = 1;
+	}
+
+	/* open-code xsk_pool_get_rx_frame_size() as pool->dev is not
+	 * set yet at this point; we are before getting down to driver
+	 */
+	frame_size = __xsk_pool_get_rx_frame_size(pool) -
+		     xsk_pool_get_tailroom(mbuf);
+	frame_size = ALIGN_DOWN(frame_size, 128);
+
+	if (needed > frame_size * segs) {
+		err = -EINVAL;
 		goto err_unreg_pool;
 	}
 
-- 
2.43.0


