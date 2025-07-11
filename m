Return-Path: <netdev+bounces-206039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B43CB011B5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 05:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306117618F3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816019F130;
	Fri, 11 Jul 2025 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aS4QgywR"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A613B29E;
	Fri, 11 Jul 2025 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752205503; cv=none; b=DFIHncJzpzpYIhnjx3mg/4KlIrBaxHQqzYh9gKX3nUZVzO/7Ip0Y45lciTDIzsuNnHtJSRJ/MCTBCLe8m5w0kGmTDE4bCMC8UgUSEhdW/7g7psewEqOt74Su75A9Ny9PgUlBb/rR1XSmUYItmlXXzliVo+GuRu02Xe72s9/OZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752205503; c=relaxed/simple;
	bh=fKVaJFpVS+Qu1usQhbWsHzMrlpX3hXV+4426E8tMgVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOh/BEk55UbFPRBDXML2rLKQJo+ZZX/y4bCKT8X2HHuRVN49JXEcGdIFmEd2CVGqOC+5C/pWhTeG8vq0bM/hsytG81ntnZa14uKyfp0yh8pwq7ROxqWY0YtMDDtq8mzgjCvBmeO+N7y7sZ5aekU8g84D0dtetPzMfAh6R0Lw/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aS4QgywR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56B3iO291365152, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752205465; bh=ayZYAbJZg3N2/2F4s0xsPpLo7I6jNpmCnOWQOuwnJ/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=aS4QgywR7C2KoweS1Ytw9AA6bHc1Xsab000McLkqZatA4kJyzJsNFycBedRvFfYe3
	 L5n03eVZufWcjyfVD2fB5x4SscytAw6k47lfVuwJD2rT9gKargS7EJHBErGg2lhGp5
	 YhLfWJAeegCCatjpjsBceR/HYAdK7zwhAZ51AmKtpPw2HnaKOIffqx92a5e8OLMYLY
	 pW/EaJtZEIulUmB2IcF9f7Ouc44uz8UAp5r1bqa4ouZEhBBOkZGWGwOJW/p0Z3H+eV
	 /EgwZeGuhIVyQHtm6PsX6YEpxSINmTs1b4INRAxqeGO7Z25c5EguPkVk9IOLfZteBZ
	 DKuJFz5TNFaCw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56B3iO291365152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Jul 2025 11:44:24 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 11:44:24 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Fri, 11 Jul 2025 11:44:24 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next] r8169: add quirk for RTL8116af SerDes
Date: Fri, 11 Jul 2025 11:44:12 +0800
Message-ID: <20250711034412.17937-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8116af is a variation of RTL8168fp. It uses SerDes instead of PHY.
But SerDes status will not reflect to PHY. So it needs quirk to help
to reflect SerDes status during PHY read.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 40 ++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271c02..2f9e9b2e9d49 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1192,6 +1192,34 @@ static int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
 	return r8168_phy_ocp_read(tp, tp->ocp_base + reg * 2);
 }
 
+/* The quirk reflects RTL8116af SerDes status. */
+static int r8116af_mdio_read_quirk(struct rtl8169_private *tp, int reg)
+{
+	u8 phyStatus = RTL_R8(tp, PHYstatus);
+
+	if (!(phyStatus & LinkStatus))
+		return 0;
+
+	/* BMSR */
+	if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMSR)
+		return BMSR_ANEGCOMPLETE | BMSR_LSTATUS;
+
+	/* PHYSR */
+	if (tp->ocp_base == 0xa430 && reg == 0x12)
+	{	if (phyStatus & _1000bpsF)
+			return 0x0028;
+		else if (phyStatus & _100bps)
+			return 0x0018;
+	}
+
+	return 0;
+}
+
+static int r8116af_mdio_read(struct rtl8169_private *tp, int reg)
+{
+	return r8168g_mdio_read(tp, reg) | r8116af_mdio_read_quirk(tp, reg);
+}
+
 static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
 {
 	if (reg == 0x1f) {
@@ -1285,6 +1313,13 @@ static int r8168dp_2_mdio_read(struct rtl8169_private *tp, int reg)
 	return value;
 }
 
+static bool rtl_is_8116af(struct rtl8169_private *tp)
+{
+	return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
+		(r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
+		(r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000;
+}
+
 static void rtl_writephy(struct rtl8169_private *tp, int location, int val)
 {
 	switch (tp->mac_version) {
@@ -1308,7 +1343,10 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
 	case RTL_GIGA_MAC_VER_31:
 		return r8168dp_2_mdio_read(tp, location);
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
-		return r8168g_mdio_read(tp, location);
+		if (rtl_is_8116af(tp))
+			return r8116af_mdio_read(tp, location);
+		else
+			return r8168g_mdio_read(tp, location);
 	default:
 		return r8169_mdio_read(tp, location);
 	}
-- 
2.43.0


