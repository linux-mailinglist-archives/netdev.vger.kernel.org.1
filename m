Return-Path: <netdev+bounces-174815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DFFA60A5E
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F40A3BA667
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC70193435;
	Fri, 14 Mar 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ENDL1+us"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EB1624D5;
	Fri, 14 Mar 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938641; cv=none; b=gkWkzsuEbn4c5HVgTy0sakw2qeX3PGxzlxFIf8h2u5c8zARAqr0g5yuHt5n/761BNvgLS53OXxrpzGsyaBfMj8ckxxu7NzWroF2vMsMkxjMKL6dEUy9q8qssc30AL6h3J4VSb2MMNvFJP+kf8bto7i6KnW6wODEHQdIQejcW5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938641; c=relaxed/simple;
	bh=aQjXEQ8xTAoz6zWYVXh6uFmAGtClnkdA6dbM3mcyPy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugdq3DVc2KPOsk8/lLxPqTHw1gpEmY0nCN++uEIY9l5L8MiMTe0XZuLJeTqBY82UmcTNHzP6Zu4tGKjLJOu+DlwESuRCH89a7Lc1jOZlJOFgig6PPAJ2lQb2+JZ75+TS6jscdTDwk16Wlb1yD5nRmFFyRmsu/yOfWZWbIrKALzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ENDL1+us; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E7oLnY52715804, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741938622; bh=aQjXEQ8xTAoz6zWYVXh6uFmAGtClnkdA6dbM3mcyPy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ENDL1+usaXRcc+/bPZQxCa0swY6Jt79PI4VEuFY0U0bm1idnCuZOa149iy2ujr76d
	 BDgSSU4uKIpZ3gRvF1tcNU8Y9B6SeZA3XjiY8dfzbzU8f8IJ4GWpS7lEnbUnIBYIhJ
	 aaH1QHORFvXbJm+Sv0n/iUHc5JV7deulp5Y2HWOF14kWaiy1j5p0zyx2ikhtS85AvR
	 tPazZ6Lwrn5m3fc1Edx2v545aU2IBxIiqkbA6J8NaQKGJaTEyVG//ML1cZNkX0MBFn
	 Sg2NM/gjrGPdfmCuaP9lic4lpuYQY0iWRs3KywDMWLJ8zPAUHVYm+//pzaGh3UmIGw
	 M1JZhiLKS2mLg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E7oLnY52715804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 15:50:21 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 14 Mar 2025 15:50:21 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Mar 2025 15:50:21 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Mar 2025 15:50:20 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 2/2] r8169: disable RTL8126 ZRX-DC timeout
Date: Fri, 14 Mar 2025 15:50:13 +0800
Message-ID: <20250314075013.3391-3-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314075013.3391-1-hau@realtek.com>
References: <20250314075013.3391-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
device will exit L1 substate every 100ms. Disable it for saving more power
in L1 substate.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3c663fca07d3..dfc96b09b85e 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2852,6 +2852,21 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
 		RTL_R32(tp, CSIDR) : ~0;
 }
 
+static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	u8 val;
+
+	if (pdev->cfg_size > 0x0890 &&
+	    pci_read_config_byte(pdev, 0x0890, &val) == PCIBIOS_SUCCESSFUL &&
+	    pci_write_config_byte(pdev, 0x0890, val & ~BIT(0)) == PCIBIOS_SUCCESSFUL)
+		return;
+
+	netdev_notice_once(tp->dev,
+		"No native access to PCI extended config space, falling back to CSI\n");
+	rtl_csi_write(tp, 0x0890, rtl_csi_read(tp, 0x0890) & ~BIT(0));
+}
+
 static void rtl_set_aspm_entry_latency(struct rtl8169_private *tp, u8 val)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -3824,6 +3839,7 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
+	rtl_disable_zrxdc_timeout(tp);
 	rtl_set_def_aspm_entry_latency(tp);
 	rtl_hw_start_8125_common(tp);
 }
-- 
2.43.0


