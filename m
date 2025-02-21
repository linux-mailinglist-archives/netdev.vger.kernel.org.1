Return-Path: <netdev+bounces-168401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0439A3ED31
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 08:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E386D1797BD
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8326E1FF1C2;
	Fri, 21 Feb 2025 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oF80Q8qZ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19D1FBCAF;
	Fri, 21 Feb 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122364; cv=none; b=JO2Lq22zO5/RlfozQYLmFNu6Hgr7mNl8I+I12XpOFRVy4Tg/FdKp+4lGR0yocZCzzKUW0pfG4qfX/hsIIM5VYTOSGRiS4CrJrYIA/FYgUHr/mrFE28Sfl1aMDv6GSVJUCWGg9Pugb1OWEGiAmUz18sRTB34c4Mku7XuaIBPexEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122364; c=relaxed/simple;
	bh=IWFjlCH/kLyoap2CM8IgWET+F6vKtvdYg6i397zwm1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDUtZl8geYzPgXPGCFm2xZP5Ek5HWqpfKWoc4mYfAyZsJz0BBuovEaCUJsWl4QB9dFa1kJtsP7y4eRz3YYJVY1Rgq2FoWwrbS2Xgug2ydlOskrnHF6Z2Hiy1QrVIxfC3FrqvmP+ZzU5cQ1LCo++KkFCmXcrJfmYVn5nAhMfZ0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oF80Q8qZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L7IgTlA1489835, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740122322; bh=IWFjlCH/kLyoap2CM8IgWET+F6vKtvdYg6i397zwm1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=oF80Q8qZ2Y6KHqRUg6UCRbOQl57Gb8qiYI1DC8rj0S3Nzxw0R3b/eOOUAo4NPkRjm
	 CSO+OduKfQ1Au3UDBcZwrrmDRHa4YRWFrhYI12eN8Y9M6Ij1mopHXpg0LLVtxAYxc1
	 3YCimHv/8+QQ2wUNxv/T9ynFdaOo39cbs/xw3/oL/NfgSrlY1eb7XXtUxEwNZnQfEZ
	 GMK846EvhV9wl+qS4JOEBpRaBxxQg9y3ETUaJYe8pXKLx4I6FNtqFRMgr4Nrq9vipt
	 n5VxhRwg96hZjUO6RWqCFgEH/ZySuFLTlV8lbCsk/e17KSV8vkD7q9nmTlKslULPvz
	 fQGt/ysqzn+oA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L7IgTlA1489835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:18:42 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 15:18:42 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 21 Feb 2025 15:18:38 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by RTEXH36505.realtek.com.tw
 (172.21.6.25) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 15:18:38 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 3/3] r8169: disable RTL8126 ZRX-DC timeout
Date: Fri, 21 Feb 2025 15:18:28 +0800
Message-ID: <20250221071828.12323-442-nic_swsd@realtek.com>
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

Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
device will exit L1 substate every 100ms. Disable it for saving more power
in L1 substate.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9953eaa01c9d..7a5b99d54e12 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2851,6 +2851,21 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
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
@@ -3930,6 +3945,7 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
+	rtl_disable_zrxdc_timeout(tp);
 	rtl_set_def_aspm_entry_latency(tp);
 	rtl_hw_start_8125_common(tp);
 }
-- 
2.43.0


