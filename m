Return-Path: <netdev+bounces-248868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6C8D10601
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8588530021CA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1C2FFFB6;
	Mon, 12 Jan 2026 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="ao7isnKp"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC58634F;
	Mon, 12 Jan 2026 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185991; cv=none; b=p9a3v3IzxkCqObU8aSVpJPLrS89pQ24ukahUQROlhPJplkpJr8YgcKsJKYctU2HOZry7oGx8MWEsNMtRWpTAsw0c213yP3vEtBDzowZIeKE5PVV4m/OdMahO6BfWSJ063pTZzmX1ft0JwqYXfNRpi1h4HuzaOpZY4Ub1NzuVuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185991; c=relaxed/simple;
	bh=JFE2Uy28/Fyajiebu5unxsSTP/WHsIrQJV+GAQ0IW/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWhGOpXtVLbXoK7zcBaOpf5gQwvkSpqYWBGSljpWimN6btsgJ1m68cT15lpOVRA/DKYjjrhNUu84F3fxypMFi63A9QkJE1jsmuu0KM1GdO80WZY86uHiq2hMurUsig9BHm3mlmPjNcD9lKu3eIpkKSkov+mPLvN/Npm+dTp+yLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ao7isnKp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60C2jjyG74128687, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1768185945;
	bh=4/a1T+VhEubM75m2jeLU4QR0PZlJpN5DuHktbJ45OHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ao7isnKpZkZsgPmUxKJJZAYbdIF5IXD9mB4B6otRtfBU8rEpUsopfD8vjP6kSJ6Q+
	 nDN9X6755n5OqvyDvYLBRN0ItOgjkzxqj+1cMxoe1wAXuanKWscWtUGg6QD6Pk8S5c
	 MfbUVyICnNtWZwQY9ASb66bbZRNrmsM5fqNGyWMamAH35UsFhAM5lGLaYUWAkJrYzc
	 7+8K/1/WLt2DNQt3oU3xtGIE/H1vQ2GlYHBhW9YgP6oxeqkMQ1kexB5sz/C33Yxfge
	 MaNzjaQPJwz3jojQJdxlFLOc6mvRvRARC+pKkQQZJbNq+EeruJBZFdz3Z2kVnDMyd9
	 pAhuQMMZm+iUQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60C2jjyG74128687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Jan 2026 10:45:45 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 12 Jan 2026 10:45:44 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 12 Jan 2026 10:45:44 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 3/3] r8169: add support for chip RTL9151AS
Date: Mon, 12 Jan 2026 10:45:41 +0800
Message-ID: <20260112024541.1847-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260112024541.1847-1-javen_xu@realsil.com.cn>
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for chip RTL9151AS. Since lacking of Hardware
version IDs, we use TX_CONFIG_V2 to recognize RTL9151AS and coming chips.
rtl_chip_infos_extend is used to store IC information for RTL9151AS and
coming chips. The TxConfig value between RTL9151AS and RTL9151A is =0D
different.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169.h      |  3 ++-
 drivers/net/ethernet/realtek/r8169_main.c | 28 +++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/re=
altek/r8169.h
index 2c1a0c21af8d..f66c279cbee6 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -72,7 +72,8 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_70,
 	RTL_GIGA_MAC_VER_80,
 	RTL_GIGA_MAC_NONE,
-	RTL_GIGA_MAC_VER_LAST =3D RTL_GIGA_MAC_NONE - 1
+	RTL_GIGA_MAC_VER_LAST =3D RTL_GIGA_MAC_NONE - 1,
+	RTL_GIGA_MAC_VER_CHECK_EXTEND
 };
=20
 struct rtl8169_private;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index 9b89bbf67198..164ad6570059 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -95,8 +95,8 @@
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
=20
 static const struct rtl_chip_info {
-	u16 mask;
-	u16 val;
+	u32 mask;
+	u32 val;
 	enum mac_version mac_version;
 	const char *name;
 	const char *fw_name;
@@ -205,10 +205,20 @@ static const struct rtl_chip_info {
 	{ 0xfc8, 0x040,	RTL_GIGA_MAC_VER_03, "RTL8110s" },
 	{ 0xfc8, 0x008,	RTL_GIGA_MAC_VER_02, "RTL8169s" },
=20
+	/* extend chip version*/
+	{ 0x7cf, 0x7c8, RTL_GIGA_MAC_VER_CHECK_EXTEND },
+
 	/* Catch-all */
 	{ 0x000, 0x000,	RTL_GIGA_MAC_NONE }
 };
=20
+static const struct rtl_chip_info rtl_chip_infos_extend[] =3D {
+	{ 0x7fffffff, 0x00000000, RTL_GIGA_MAC_VER_64, "RTL9151AS", FIRMWARE_9151=
A_1},
+
+	/* Catch-all */
+	{ 0x00000000, 0x00000000, RTL_GIGA_MAC_NONE }
+};
+
 static const struct pci_device_id rtl8169_pci_tbl[] =3D {
 	{ PCI_VDEVICE(REALTEK,	0x2502) },
 	{ PCI_VDEVICE(REALTEK,	0x2600) },
@@ -255,6 +265,8 @@ enum rtl_registers {
 	IntrStatus	=3D 0x3e,
=20
 	TxConfig	=3D 0x40,
+	/* Extend version register */
+	TX_CONFIG_V2	=3D 0x60b0,
 #define	TXCFG_AUTO_FIFO			(1 << 7)	/* 8111e-vl */
 #define	TXCFG_EMPTY			(1 << 11)	/* 8111e-vl */
=20
@@ -2351,6 +2363,15 @@ static const struct ethtool_ops rtl8169_ethtool_ops =
=3D {
 	.get_eth_ctrl_stats	=3D rtl8169_get_eth_ctrl_stats,
 };
=20
+static const struct rtl_chip_info *rtl8169_get_extend_chip_version(u32 txc=
onfigv2)
+{
+	const struct rtl_chip_info *p =3D rtl_chip_infos_extend;
+
+	while ((txconfigv2 & p->mask) !=3D p->val)
+		p++;
+	return p;
+}
+
 static const struct rtl_chip_info *rtl8169_get_chip_version(u16 xid, bool =
gmii)
 {
 	/* Chips combining a 1Gbps MAC with a 100Mbps PHY */
@@ -5543,6 +5564,9 @@ static int rtl_init_one(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
=20
 	/* Identify chip attached to board */
 	chip =3D rtl8169_get_chip_version(xid, tp->supports_gmii);
+
+	if (chip->mac_version =3D=3D RTL_GIGA_MAC_VER_CHECK_EXTEND)
+		chip =3D rtl8169_get_extend_chip_version(RTL_R32(tp, TX_CONFIG_V2));
 	if (chip->mac_version =3D=3D RTL_GIGA_MAC_NONE)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "unknown chip XID %03x, contact r8169 maintainers (see MAINTAINER=
S file)\n",
--=20
2.43.0


