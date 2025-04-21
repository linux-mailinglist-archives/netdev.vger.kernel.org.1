Return-Path: <netdev+bounces-184458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C2A95966
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB11175B15
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DF227574;
	Mon, 21 Apr 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBGv2S7L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1C21A435
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274521; cv=none; b=W85+cF4cuqubyLeDJ0ACw6jk0gKBO31bw3iPs2SgaHHEX9XRiEA3u1wvOPrcZubdrND/JgVuDrwOGNQb+QN5wZ6EbJfBtryio5Fvt9Srb4/XpAZ91ca/w7KlIyGrer1QJlcTLnju7kCKOebiuCuPxYRAHui2tV4R4QEjYa64eDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274521; c=relaxed/simple;
	bh=gd3UNsP6TNDseQJtLIR55y9TdWda/3/zJM7xpzwm8As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM8fLpOUXpXScXsUA/8CUMU0IE84Rj9kho3cVHzVN67MNDcsARoaRjL+pKTdOJORBcsLp0s6MAOkGqJoLDtDP7EgHeNgF/bbiKHAH5473xVNlMo4zqWGh4K+die0Y+5cQg0wUZ7/DTY9cdgYcAU8Ojr57jZgR5BgonTm4H1AWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBGv2S7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13FEC4CEE4;
	Mon, 21 Apr 2025 22:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274519;
	bh=gd3UNsP6TNDseQJtLIR55y9TdWda/3/zJM7xpzwm8As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBGv2S7Loo3SOv8krkvaoQ5/CN0ZXOo/6DkQIMEmaUfplDQW7Y32ct3X5qtymyrao
	 Li2Q2KVhSC4nAOrSPhqT4zcbarLKwO/gi6/f1aou/b9E7w0PRf04KFLsU6hKaeKgAu
	 I/EHyBi5gpdAu9YRwFpfzH8Xl+bPAWnabTKsNb5cH15b5RbLjm2wixp7U5KcAEbvfA
	 ZthfebYwoGlIhsvOV9BHOrwvYXY5zGdxIq9fGIP3RndrQz5rRklMsMUoDP5Km0Du3L
	 lQO+hrNUSFzeqsM4heZ1peXEvNswx73XRvA4ImtOU81lIenotzlRqVVGDoi+DlAFrc
	 Z/ObQJr/gXkxg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 08/22] eth: bnxt: support setting size of agg buffers via ethtool
Date: Mon, 21 Apr 2025 15:28:13 -0700
Message-ID: <20250421222827.283737-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt seems to be able to aggregate data up to 32kB without any issue.
The driver is already capable of doing this for systems with higher
order pages. While for systems with 4k pages we historically preferred
to stick to small buffers because they are easier to allocate, the
zero-copy APIs remove the allocation problem. The ZC mem is
pre-allocated and fixed size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 158b8f96f50c..1723909bde77 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -758,7 +758,8 @@ struct nqe_cn {
 #define BNXT_RX_PAGE_SHIFT PAGE_SHIFT
 #endif
 
-#define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE	(1 << 15)
+#define BNXT_RX_PAGE_SIZE	(1 << BNXT_RX_PAGE_SHIFT)
 
 #define BNXT_MAX_MTU		9500
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 48dd5922e4dd..956f51449709 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -835,6 +835,8 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
 	ering->tx_pending = bp->tx_ring_size;
 
+	kernel_ering->rx_buf_len_max = BNXT_MAX_RX_PAGE_SIZE;
+	kernel_ering->rx_buf_len = bp->rx_page_size;
 	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
 }
 
@@ -862,6 +864,21 @@ static int bnxt_set_ringparam(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (!kernel_ering->rx_buf_len)	/* Zero means restore default */
+		kernel_ering->rx_buf_len = BNXT_RX_PAGE_SIZE;
+
+	if (kernel_ering->rx_buf_len != bp->rx_page_size &&
+	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
+		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
+		return -EINVAL;
+	}
+	if (!is_power_of_2(kernel_ering->rx_buf_len) ||
+	    kernel_ering->rx_buf_len < BNXT_RX_PAGE_SIZE ||
+	    kernel_ering->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range, or not power of 2");
+		return -ERANGE;
+	}
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
@@ -874,6 +891,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
+	bp->rx_page_size = kernel_ering->rx_buf_len;
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
@@ -5463,7 +5481,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
-	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+	.supported_ring_params	= ETHTOOL_RING_USE_RX_BUF_LEN |
+				  ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 				  ETHTOOL_RING_USE_HDS_THRS,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
-- 
2.49.0


