Return-Path: <netdev+bounces-168402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1B9A3ED32
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 08:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F108179BB1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696F1FF1C5;
	Fri, 21 Feb 2025 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bGoSAQ9N"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C25F1FCCE9;
	Fri, 21 Feb 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122364; cv=none; b=YY6EPVsWpVAAz9eU3YAts8OS8Vo5fr3Q3u6b9LBkkOxjPCxK42nJM/khS6cEtzbdmv+dU+Y4jUxLrdAyAVIvHBxAbBMQqTpue9PTXkkIP2WytRMCfYWEyZyp1UT0O0KFvIfP2AhcgZyCQ4779UN4n60R2eXjugvLS6L8v75cMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122364; c=relaxed/simple;
	bh=EOqgPKfRw6fHKRcscN6V0azTs4N6D/BrVvwMtWWjraU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nc40hMYZIm78fXPfcnb4FLPU4nOuLqIpnJXezi2GudhaD1FpobdhYXVSurwJ4axFlcqEPgq50LChvUCzbwiuPuCMnf8wgj91fAVDK3G9PdchOcD2kcY71dvKBdr1NPFyRkdWtj/YDfoKQuPiTAeCN0hjehsoMDPbGdx6tbGaICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bGoSAQ9N; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L7Iek061489827, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740122320; bh=EOqgPKfRw6fHKRcscN6V0azTs4N6D/BrVvwMtWWjraU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bGoSAQ9NkKPiqJg7Hz+b3QDfgD51S3kzez/ZnKPSCrnVhZU2s5eMdKICd/VkUVayi
	 t41tBn5uMM/LSZkI8Wcljbn+3leyz593Y3Vd+hCPnLee+c9lk7l61HY/2draRthMzO
	 xpcBehbCEboiqB1saehiO0bA59CoT0p1DSXjCCulHpeWb0H1sUO6HHwsmrlnMT29Zo
	 qNFnykanL1IQWkpv5Cw1rFrejJ3hWKL0/1rqdO8kY5Icc3vploJzq/bjhXxe9cd1bc
	 MtGR20nJcKzDwVB7zs/NLRO4OtQpC3WaHrhrOu4SuRqc/iZGHeeuERVlSA3dhcP3pD
	 zfBJKtExzp1UQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L7Iek061489827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:18:40 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 15:18:40 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 21 Feb 2025 15:18:37 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by RTEXH36505.realtek.com.tw
 (172.21.6.25) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 15:18:37 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 2/3] r8169: enable RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR support
Date: Fri, 21 Feb 2025 15:18:27 +0800
Message-ID: <20250221071828.12323-441-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221071828.12323-439-nic_swsd@realtek.com>
References: <20250221071828.12323-439-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

This patch will enable RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR
support on the platforms that have tested with LTR enabled.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 108 ++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 731302361989..9953eaa01c9d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2955,6 +2955,111 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl_set_ltr_latency(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_70:
+	case RTL_GIGA_MAC_VER_71:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
+		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
+		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
+		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
+		r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
+		break;
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x889c);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c30);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcde8, 0x883e);
+		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdec, 0x889c);
+		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf0, 0x8C09);
+		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
+		break;
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_53:
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		break;
+	default:
+		break;
+	}
+}
+
+static void rtl_reset_pci_ltr(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	u16 cap;
+
+	pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap);
+	if (cap & PCI_EXP_DEVCTL2_LTR_EN) {
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
+					   PCI_EXP_DEVCTL2_LTR_EN);
+		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_LTR_EN);
+	}
+}
+
+static void rtl_enable_ltr(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
+		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
+		r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
+		break;
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+	case RTL_GIGA_MAC_VER_52 ... RTL_GIGA_MAC_VER_53:
+		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
+		RTL_W8(tp, 0xb6, RTL_R8(tp, 0xb6) | BIT(0));
+		fallthrough;
+	case RTL_GIGA_MAC_VER_51:
+		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
+		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
+		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
+		break;
+	default:
+		return;
+	}
+
+	rtl_set_ltr_latency(tp);
+
+	/* chip can trigger LTR */
+	r8168_mac_ocp_modify(tp, 0xe032, 0x0003, BIT(0));
+
+	/* reset LTR to notify host */
+	rtl_reset_pci_ltr(tp);
+}
+
+static void rtl_disable_ltr(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_71:
+		r8168_mac_ocp_modify(tp, 0xe032, 0x0003, 0);
+		break;
+	default:
+		break;
+	}
+}
+
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 {
 	u8 val8;
@@ -2971,6 +3076,8 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		    tp->mac_version == RTL_GIGA_MAC_VER_43)
 			return;
 
+		rtl_enable_ltr(tp);
+
 		rtl_mod_config5(tp, 0, ASPM_en);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_70:
@@ -4821,6 +4928,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 
 	rtl8169_cleanup(tp);
 	rtl_disable_exit_l1(tp);
+	rtl_disable_ltr(tp);
 	rtl_prepare_power_down(tp);
 
 	if (tp->dash_type != RTL_DASH_NONE)
-- 
2.43.0


