Return-Path: <netdev+bounces-190971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4336AB98EF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A76189808A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C5230BF5;
	Fri, 16 May 2025 09:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C222D7B7
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388055; cv=none; b=lWiGHJQheOuIWImt/g8ok5U/szjG0HIzyNWUZiFC/XxLINVXFYiG7oLE9gBgrk1g2Y0rgtG+DLULr85NmmbyCUYnBf2tsrrs9isKHjOdrhexO4W4+FEY3AKxNkD4VSDXU5WXhJKiLJLId+DniY51cOwqJ+9DwAmrvg9QzufkwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388055; c=relaxed/simple;
	bh=PDStExTMKRYaM4dDyBoZ+q00xWH3vQ4Rl0AWaVhSuSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR2c4r1gv2VP9XgavP2Poqh0Uo7SUmFgqm+YUw0v2BaAMkmT5YCehpFQntlKHrb5GWU8KIkTEH/E3caokbibQFAMDeFSF01CZlrjTrpqHHAiX7PVPloCoKlSnbvK/sUiOJJMXkS5/pzkaaM6hpQuMro+11Bp1FtGD38b2f0iAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387963tf66aac89
X-QQ-Originating-IP: dulJOv/ZDcM0Gqg7K0wzj8eRG0UNf3M8rT7VLfnUeSE=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2828208085710207915
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 2/9] net: wangxun: Use specific flag bit to simplify the code
Date: Fri, 16 May 2025 17:32:13 +0800
Message-ID: <328F8950017A7028+20250516093220.6044-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516093220.6044-1-jiawenwu@trustnetic.com>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OX/+6nY/vs4TXaJPXfoG6IOV1BbL1SQtaUCf4OJEkRnahi52/nFTAvl9
	7d+LOXAo9VdeaZoUO7kDIxI6ttZ9kClEEmpx/qJGzVJ5lLHEl6Ch1M63ERWh3fKrmSTeTHH
	lp6gCOACoMdlNoWAnTERyzmVSnd01qWEI0yS1MPG6Rdif3wYHfRam6Lh/mwRX8UwhZdtKuq
	3tqdSDxkc4sQlelfSeUub8nMChVUIomwU/bUCgfTXxF91VNwdUWhkkewAOekhX8+bbB5Mhk
	Q988ggliaUtq0S2Psemx14InC4mDxVdk/vdu3DWcZzBKqXz2pNo6UdD+njISHzhejV1xdjr
	LEtDaWEgj9svJ6M7ANkKgg11yXJfZexX4SyOPXllm04Tdnun1v5+EXJ7yl6kskfU9Y1ZjLF
	yz/u5zcTcsy87tqy8Z9T++h59nDhlr/YuC7ZaCg6/ugFLB9Uc4FhNP/5iRVMNWHLlUDxBI2
	zMMECA1NzxgKCmDWa+YwjAVfAGAVJ11pS/TxWCfI0NSXCzTZ9hfSxSCxW0XLa9WAotUmhVk
	/HPZrio4aiDLU6yzqmhmN1Err4yI3f26UivGO8jAGBFhSfTxuYtdFDW0Ek9Nbsq6SCf+B+J
	q5IdywSNeTcAQ2TKYrEK7TBoZ9e3vdJggbsm44K05Xov/FRGDQUIsOMvsix6PffydqsynFU
	qLZHFPcvO773tvH9wS8hkqylO+6+/VAK14Q7WCOXphvez0HdrhzCEmgTPz9V7FUEh5EID0Y
	pxJRCdbeBFiFoyFOgWrkBCFSoCImotXBrbbpIVe6vVli/+Imj1tPJ+5vrYpl2CZ5T6LSRun
	q+QMjbasVq2MpR6yHDfjL8BjsZ9OdTGpxeNKt5V5BQyYQW0qt626x1M1DDNitqP4RPG0rQT
	SsxdnBi61mMME1iGluKpE4ieyfULHbiHSZKqrE39n3AYkS5SrxomG4cAb+/8X8xRduYqv9F
	jJ6Sm+u1F0Jc4JbaoOQ4FlTah/INraUKH2LE/Y3n2Z82Zde3c3LHQbcdhx8BC+XxiH8MowG
	iznV5irsnw/r5ubPniklIsTtbCA798fbb1yM3IwQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Most of the different code that requires MAC type in the common library
is due to NGBE only supports a few queues and pools, unlike TXGBE, which
supports 128 queues and 64 pools. This difference accounts for most of
the hardware configuration differences in the driver code. So add a flag
bit "WX_FLAG_MULTI_64_FUNC" for them to clean-up the driver code.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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


