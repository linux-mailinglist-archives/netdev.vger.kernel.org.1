Return-Path: <netdev+bounces-192169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962A4ABEC59
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443771BA35EE
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756D6239E9E;
	Wed, 21 May 2025 06:45:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20367239E73
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809955; cv=none; b=XuGVVLOhTqFz3INCTtfH8zYguNk1ZHrqAqA0Ck6kIMSnmsOEkfVWqTMCxfPInw9zxqdfmE3mGxlB8lC6OXjKSZUWGDQua9GURgxQp0wjNtjJQWJDn0bb9JaXHzUw3boct8E0Gr/QSlZV0QktoNvhEWHEksE7mowhrZBHr+EcNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809955; c=relaxed/simple;
	bh=FhsIHBqU1Xp8UxCF/jvt3eoIldzfqOrny0ARQiwRvF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itQnCwdNGmw7D23aq+/ANSVw4X6Brw4adOCmN5iLmozYeQ83r9KL0uvbvFDgzaKpT6i1+EZ9QGJYXMVTN7pws/04M+yV4eo6n1HZxDjF68Pgbe4lQvTt+hmn7cuQK7gfwh7kO0vSe6mgF4m6TF8bnO9nbxhotOQkwQAe6Q6aTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809867ta0e3630a
X-QQ-Originating-IP: ZGrHfisIbch6ynHWcfTan2nA/WJwcAMKqIgjNcq9B4E=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10489968241910633397
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 2/9] net: wangxun: Use specific flag bit to simplify the code
Date: Wed, 21 May 2025 14:43:55 +0800
Message-ID: <C731132E124D75E5+20250521064402.22348-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521064402.22348-1-jiawenwu@trustnetic.com>
References: <20250521064402.22348-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NpfbsqbTlzxUQUaLYkMxuBrfKtSaeL6u7mrvsmLlKqztBjTsMQuPRWB0
	RJIm4cbC+MyyhJcKe9hqhcaJWvR5VxsPB3tlvQrU6ss0/t9ZGRlCfXSoHSOYLyA6NtS8d3Z
	6Ax/mp6d2i+BAe0IfabPPsYg+NSYDXEApHrCqpCiDlhdsbByyGD1/XxX2i9d9cBp0EKR12q
	Cw/++tGBefC4qjm7uapLxJeYgxlBjDtyHDLpoFgA+uOO7g5w1Jst5atZ5yfi2rfkZ56Sz4t
	2vl8hoUVcmMLX+W4kSQc5PLJx5to6E2oA6e6PPGrASWUKvYTjPwvMRfk+Z2pta++YRDONA8
	h9Fj9xYliS17rnENUKnxMSf8RvJJH3orgh0HonJaqMcuSbkhdQpTf8h26B89YMAPQWi/kTV
	fgw6Q9IGSiyPKV/p2JEhpqamaxqSkO4qLzcJGE5kJDb/aDBcuQuAfzpPSnwg/eKFh3xlLPG
	i7lBSbhH7PbngzsDAnMyHIg41pL0QduB49sJ8jni+JrLHSyjYEcR2m4VE1eb90ZlfQxmS6S
	ll6OJgGp3ZAuGtuJqE8tkE5c05ATMQ7TpGpcZWRwqxIs8v1LjMuHy5wRmOwT7qjJ1OSRxcU
	b+Wep+GLY36fK1oXTb7ub+cLCx8+h5Z2KynrAoazxRSdw55gUjE27RGWMhv+LkxPshEWU1y
	pU0z0Z/n39y4PBn2KhAW8c9v/W565pxtTird2BeWTBksuRq6iFKnWaqW6Phv23mtNnBPtRC
	jJL5JJ9ze9eTe5xD65jm35z1yMDyVdq428tlTgMEcsRrbkJyTM8kDsJBqX+vAX9QKtKupqq
	CM5rtnATviuFuwodecE7NBJ1qA9OYy7izk0IXVtGKMuEKWDJFK1bFMllnEqXzYXpzJcEypM
	iRZIkF0KaaKlT/62pfWG/w+EuwVOnyeO02ptUHjaZTpbH3i1vzf8E1vIcJMCcl28mQIjARN
	iFcnXboUqTIMfbbLDLucZa4JwWboB7Zj5MbfO9RmX0+cGRMPD2PUdaFTiL5UbYCGFdSGjmE
	P2dmLqoBWjsCWxfhbWUKTSCfLuAJIVptmaPo6b+A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Most of the different code that requires MAC type in the common library
is due to NGBE only supports a few queues and pools, unlike TXGBE, which
supports 128 queues and 64 pools. This difference accounts for most of
the hardware configuration differences in the driver code. So add a flag
bit "WX_FLAG_MULTI_64_FUNC" for them to clean-up the driver code.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  9 ++---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 35 ++++---------------
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 10 +++---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  8 ++---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 6 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 43019ec9329c..d58d7a8735bc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -413,15 +413,10 @@ static unsigned int wx_max_channels(struct wx *wx)
 		max_combined = 1;
 	} else {
 		/* support up to max allowed queues with RSS */
-		switch (wx->mac.type) {
-		case wx_mac_sp:
-		case wx_mac_aml:
+		if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
 			max_combined = 63;
-			break;
-		default:
+		else
 			max_combined = 8;
-			break;
-		}
 	}
 
 	return max_combined;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 143cc1088eea..1c5c14ac61bc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -113,15 +113,10 @@ static void wx_intr_disable(struct wx *wx, u64 qmask)
 	if (mask)
 		wr32(wx, WX_PX_IMS(0), mask);
 
-	switch (wx->mac.type) {
-	case wx_mac_sp:
-	case wx_mac_aml:
+	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		mask = (qmask >> 32);
 		if (mask)
 			wr32(wx, WX_PX_IMS(1), mask);
-		break;
-	default:
-		break;
 	}
 }
 
@@ -133,15 +128,10 @@ void wx_intr_enable(struct wx *wx, u64 qmask)
 	if (mask)
 		wr32(wx, WX_PX_IMC(0), mask);
 
-	switch (wx->mac.type) {
-	case wx_mac_sp:
-	case wx_mac_aml:
+	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		mask = (qmask >> 32);
 		if (mask)
 			wr32(wx, WX_PX_IMC(1), mask);
-		break;
-	default:
-		break;
 	}
 }
 EXPORT_SYMBOL(wx_intr_enable);
@@ -774,14 +764,8 @@ static int wx_set_rar(struct wx *wx, u32 index, u8 *addr, u64 pools,
 	/* setup VMDq pool mapping */
 	wr32(wx, WX_PSR_MAC_SWC_VM_L, pools & 0xFFFFFFFF);
 
-	switch (wx->mac.type) {
-	case wx_mac_sp:
-	case wx_mac_aml:
+	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
 		wr32(wx, WX_PSR_MAC_SWC_VM_H, pools >> 32);
-		break;
-	default:
-		break;
-	}
 
 	/* HW expects these in little endian so we reverse the byte
 	 * order from network order (big endian) to little endian
@@ -919,14 +903,9 @@ void wx_init_rx_addrs(struct wx *wx)
 
 		wx_set_rar(wx, 0, wx->mac.addr, 0, WX_PSR_MAC_SWC_AD_H_AV);
 
-		switch (wx->mac.type) {
-		case wx_mac_sp:
-		case wx_mac_aml:
+		if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 			/* clear VMDq pool/queue selection for RAR 0 */
 			wx_clear_vmdq(wx, 0, WX_CLEAR_VMDQ_ALL);
-			break;
-		default:
-			break;
 		}
 	}
 
@@ -1512,7 +1491,7 @@ static void wx_configure_virtualization(struct wx *wx)
 		wr32m(wx, WX_PSR_VM_L2CTL(pool),
 		      WX_PSR_VM_L2CTL_AUPE, WX_PSR_VM_L2CTL_AUPE);
 
-	if (wx->mac.type == wx_mac_em) {
+	if (!test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		vf_shift = BIT(VMDQ_P(0));
 		/* Enable only the PF pools for Tx/Rx */
 		wr32(wx, WX_RDM_VF_RE(0), vf_shift);
@@ -1543,7 +1522,7 @@ static void wx_configure_port(struct wx *wx)
 {
 	u32 value, i;
 
-	if (wx->mac.type == wx_mac_em) {
+	if (!test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		value = (wx->num_vfs == 0) ?
 			WX_CFG_PORT_CTL_NUM_VT_NONE :
 			WX_CFG_PORT_CTL_NUM_VT_8;
@@ -2074,7 +2053,7 @@ static void wx_setup_psrtype(struct wx *wx)
 		  WX_RDB_PL_CFG_TUN_OUTL2HDR |
 		  WX_RDB_PL_CFG_TUN_TUNHDR;
 
-	if (wx->mac.type == wx_mac_em) {
+	if (!test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		for_each_set_bit(pool, &wx->fwd_bitmask, 8)
 			wr32(wx, WX_RDB_PL_CFG(VMDQ_P(pool)), psrtype);
 	} else {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 2a808afeb414..eab16c57b039 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1633,7 +1633,7 @@ static bool wx_set_vmdq_queues(struct wx *wx)
 	/* Add starting offset to total pool count */
 	vmdq_i += wx->ring_feature[RING_F_VMDQ].offset;
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		/* double check we are limited to maximum pools */
 		vmdq_i = min_t(u16, 64, vmdq_i);
 
@@ -1693,7 +1693,7 @@ static void wx_set_rss_queues(struct wx *wx)
 
 	/* set mask for 16 queue limit of RSS */
 	f = &wx->ring_feature[RING_F_RSS];
-	if (wx->mac.type == wx_mac_sp)
+	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
 		f->mask = WX_RSS_64Q_MASK;
 	else
 		f->mask = WX_RSS_8Q_MASK;
@@ -1853,7 +1853,7 @@ static bool wx_cache_ring_vmdq(struct wx *wx)
 	if (!test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
 		return false;
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		/* start at VMDq register offset for SR-IOV enabled setups */
 		reg_idx = vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
 		for (i = 0; i < wx->num_rx_queues; i++, reg_idx++) {
@@ -2354,10 +2354,10 @@ void wx_configure_vectors(struct wx *wx)
 
 	if (pdev->msix_enabled) {
 		/* Populate MSIX to EITR Select */
-		if (wx->mac.type == wx_mac_sp) {
+		if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 			if (wx->num_vfs >= 32)
 				eitrsel = BIT(wx->num_vfs % 32) - 1;
-		} else if (wx->mac.type == wx_mac_em) {
+		} else {
 			for (i = 0; i < wx->num_vfs; i++)
 				eitrsel |= BIT(i);
 		}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 52e6a6faf715..16c8fb246c41 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -106,7 +106,7 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
 		wx->vfinfo[i].xcast_mode = WXVF_XCAST_MODE_NONE;
 	}
 
-	if (wx->mac.type == wx_mac_em) {
+	if (!test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		value = WX_CFG_PORT_CTL_NUM_VT_8;
 	} else {
 		if (num_vfs < 32)
@@ -599,10 +599,10 @@ static int wx_set_vf_vlan_msg(struct wx *wx, u32 *msgbuf, u16 vf)
 		if (VMDQ_P(0) < 32) {
 			bits = rd32(wx, WX_PSR_VLAN_SWC_VM_L);
 			bits &= ~BIT(VMDQ_P(0));
-			if (wx->mac.type != wx_mac_em)
+			if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
 				bits |= rd32(wx, WX_PSR_VLAN_SWC_VM_H);
 		} else {
-			if (wx->mac.type != wx_mac_em)
+			if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
 				bits = rd32(wx, WX_PSR_VLAN_SWC_VM_H);
 			bits &= ~BIT(VMDQ_P(0) % 32);
 			bits |= rd32(wx, WX_PSR_VLAN_SWC_VM_L);
@@ -848,7 +848,7 @@ void wx_disable_vf_rx_tx(struct wx *wx)
 {
 	wr32(wx, WX_TDM_VFTE_CLR(0), U32_MAX);
 	wr32(wx, WX_RDM_VFRE_CLR(0), U32_MAX);
-	if (wx->mac.type != wx_mac_em) {
+	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
 		wr32(wx, WX_TDM_VFTE_CLR(1), U32_MAX);
 		wr32(wx, WX_RDM_VFRE_CLR(1), U32_MAX);
 	}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 5f024f5ac3a6..6563d30e60c5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1184,6 +1184,7 @@ struct vf_macvlans {
 };
 
 enum wx_pf_flags {
+	WX_FLAG_MULTI_64_FUNC,
 	WX_FLAG_SWFW_RING,
 	WX_FLAG_VMDQ_ENABLED,
 	WX_FLAG_VLAN_PROMISC,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ea0b1cb721c8..0c81d8fc2f7d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -318,6 +318,7 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->configure_fdir = txgbe_configure_fdir;
 
 	set_bit(WX_FLAG_RSC_CAPABLE, wx->flags);
+	set_bit(WX_FLAG_MULTI_64_FUNC, wx->flags);
 
 	/* enable itr by default in dynamic mode */
 	wx->rx_itr_setting = 1;
-- 
2.48.1


