Return-Path: <netdev+bounces-253111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJWZDUc5dWmUCQEAu9opvQ
	(envelope-from <netdev+bounces-253111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:27:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD287F0DC
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE84F300B074
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAB27EFF7;
	Sat, 24 Jan 2026 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9joe/1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EEE24503C
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769290048; cv=none; b=SIXERywtQ/AqV1KRmqnD5HN6PO2YCHvxFhowGg+3TJaHbJvcARwYZFeYVKAGql581xyiXG5XtQlbgj4Ows9y3Edxrowapi/5nl8zpl1HDtcnGFs2Ta+6+jGX55iC4UpqKEmHBgKGeoEyGdNJx/gT/keO9okiOR84k0eOXVQV7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769290048; c=relaxed/simple;
	bh=u9so5uw5sbJRz1QmT5J+U6O5nohn7TiBvHfSOusFfwk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lPidS/dwvLhBb7BNC+eCAmHTIPPVlNwlpU/jEvJ0CsDp/KStKzUe9jHB9jlr41jP7xwr/shR//zpc8u2HGLmSjAIVXJfNRurvVzPB3+t2Jf7CQ8fChDck7sU0LFKJl8ggzvAp4ueFPmrxpWKgOxEzutep6bTUKqzIG0rMRcQAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9joe/1X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee0291921so27835565e9.3
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 13:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769290046; x=1769894846; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq3G2t8FYCgyfqeMh2uVYTMvr7l3tUQ5tglbC/gwaz0=;
        b=i9joe/1X8DUZjUO06Xse15UYM++n0DhRn8bDMzMy6AhKIGwndgoTv7XzlPR1GIjHv8
         8PIS9Ich0MXs7npZnaJiQT5w9ohCIC89DilNBWCABZEJtiN0z3hLV6FQdT03OEZASbem
         htvUNlj46iVR+qzB5+rTjpF31V8Cg2594G733m7i3EvKsqIV8pJd6TywxyrBYMMofsAr
         adSL1oKb+uiRoRCiWcZfyIZ5rrptfG/WG1Ynt6AJ5TTBKBDtvwcQoC5vXT228Bd5RR6g
         MsNVc6Yma7tWuznQ4TD+fWwe199qHhW911qOljGrmGWLR+b3dYauiY7VHcQwdaauA2mp
         rq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769290046; x=1769894846;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq3G2t8FYCgyfqeMh2uVYTMvr7l3tUQ5tglbC/gwaz0=;
        b=SrOCEdWqjfoQyWJR/45k4jddsN7VYPnuZb0GboxuFgnqCWuV/CCHeM9l8BuF52efpA
         UNSGNt3ILK4DelVrXmI8hvcVriNfiv+d/5U99TkzNdc9NP7SGsKjnJNQagj9OfRJf804
         Tg1WkfxYybxaSKo2pLs3t0jwc/9nBm1fJMsj+g/u3m96QoHcXMO4UoaWdz5XjkDF/jeh
         MMlazzJsUg6M8a91lVAfI/+VudhUtarXnx3vxeQFvaA7eYsHRySuGHwlgsUGsuMfvycc
         xlSJUgktal7M59kGLbMFZllHtbwaKrpEfeTrGij9Cy9Qo4G+MMY2o/Kt2B7wyhZh31yj
         mCrQ==
X-Gm-Message-State: AOJu0YxrKaJLf/VO8H8mjL+qPGyNjm+t6KDrkJlaaCEXEUNxhX4efopE
	DxG5Yi3Om3aCCOUexh7N6ovJMMg//I3DazvVe0P4GnAgFNOP0+cmkoz3
X-Gm-Gg: AZuq6aKPYIhdkPOy2ucEdd5dAiQrvi5CpYfG8mpzt6st7TEMR7j3MGUY6sJbft8bVn3
	X+TtF4S6toGwwG3yqK4Sf6biTZfGiokFjm2qxyb1XA3/5Bmx3dE8OK5o0HbuA9aX53xiBAdFhTA
	y3vy3i7j+UPV7pxS5GYcfI2dH6sxvf0E1h2FFN9Lrs+OAmY51tKvBxxTh47cs7Y9q+hxDrUhHyS
	vLh5FpPT46Rcp/pU5XtR0BL5VTsYx9i9NvXsAQxnKpu5GqTAdYLIyRgeglT7oca3pM9+oshBHmA
	r3MrBKXey43zpf+2WKyiqLcG15sZPPg2idi1ZqmWJbxeAqrF2CMk3Wp0gxksxaL0pGKv32P3XRp
	VSA0Ib16e48ljwaTehzW1hCDLUhjewv+KhXrYsHqvxsn7R3Fv4zlpwqROC70ZIzSPyKX6rl1JZ1
	zf8Zihlo5AB0ysYenft4ix/vyJ4+Wq0ZJAoLu7zlIbISkiyoXx8okRwSSXgXWqh0XpPnNn3g70t
	kjgnSo+kyh/HU8fdoS23pPpWGlBSCZehtHBXZjlGYBlnQybVE0NrnlnXy2CmnDK
X-Received: by 2002:a05:600c:4f4b:b0:47e:e71a:e13a with SMTP id 5b1f17b1804b1-4804c9c9a3emr122761525e9.32.1769290045539;
        Sat, 24 Jan 2026 13:27:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2c:b000:9cd8:dac0:8b53:119f? (p200300ea8f2cb0009cd8dac08b53119f.dip0.t-ipconnect.de. [2003:ea:8f2c:b000:9cd8:dac0:8b53:119f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02cd8sm16000480f8f.8.2026.01.24.13.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 13:27:25 -0800 (PST)
Message-ID: <a3525b74-a1aa-43f6-8413-56615f6fa795@gmail.com>
Date: Sat, 24 Jan 2026 22:27:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Javen Xu <javen_xu@realsil.com.cn>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add support for extended chip version id and
 RTL9151AS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FD287F0DC
X-Rspamd-Action: no action

From: Javen Xu <javen_xu@realsil.com.cn>

The bits in register TxConfig used for chip identification aren't
sufficient for the number of upcoming chip versions. Therefore a register
is added with extended chip version information, for compatibility
purposes it's called TX_CONFIG_V2. First chip to use the extended chip
identification is RTL9151AS.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
[hkallweit1@gmail.com: add support for extended XID where XID is printed]
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h      |  3 +-
 drivers/net/ethernet/realtek/r8169_main.c | 45 +++++++++++++++++++----
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 2c1a0c21af8..aed4cf85209 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -72,7 +72,8 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_70,
 	RTL_GIGA_MAC_VER_80,
 	RTL_GIGA_MAC_NONE,
-	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
+	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1,
+	RTL_GIGA_MAC_VER_EXTENDED
 };
 
 struct rtl8169_private;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3075391853f..2f7d9809c37 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -96,8 +96,8 @@
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
 static const struct rtl_chip_info {
-	u16 mask;
-	u16 val;
+	u32 mask;
+	u32 val;
 	enum mac_version mac_version;
 	const char *name;
 	const char *fw_name;
@@ -206,10 +206,21 @@ static const struct rtl_chip_info {
 	{ 0xfc8, 0x040,	RTL_GIGA_MAC_VER_03, "RTL8110s" },
 	{ 0xfc8, 0x008,	RTL_GIGA_MAC_VER_02, "RTL8169s" },
 
+	/* extended chip version*/
+	{ 0x7cf, 0x7c8, RTL_GIGA_MAC_VER_EXTENDED },
+
 	/* Catch-all */
 	{ 0x000, 0x000,	RTL_GIGA_MAC_NONE }
 };
 
+static const struct rtl_chip_info rtl_chip_infos_extended[] = {
+	{ 0x7fffffff, 0x00000000, RTL_GIGA_MAC_VER_64, "RTL9151AS",
+	  FIRMWARE_9151A_1},
+
+	/* Catch-all */
+	{ 0x00000000, 0x00000000, RTL_GIGA_MAC_NONE }
+};
+
 static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_VDEVICE(REALTEK,	0x2502) },
 	{ PCI_VDEVICE(REALTEK,	0x2600) },
@@ -256,6 +267,8 @@ enum rtl_registers {
 	IntrStatus	= 0x3e,
 
 	TxConfig	= 0x40,
+	/* Extended chip version id */
+	TX_CONFIG_V2	= 0x60b0,
 #define	TXCFG_AUTO_FIFO			(1 << 7)	/* 8111e-vl */
 #define	TXCFG_EMPTY			(1 << 11)	/* 8111e-vl */
 
@@ -2426,7 +2439,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
 };
 
-static const struct rtl_chip_info *rtl8169_get_chip_version(u16 xid, bool gmii)
+static const struct rtl_chip_info *rtl8169_get_chip_version(u32 xid, bool gmii)
 {
 	/* Chips combining a 1Gbps MAC with a 100Mbps PHY */
 	static const struct rtl_chip_info rtl8106eus_info = {
@@ -2452,6 +2465,15 @@ static const struct rtl_chip_info *rtl8169_get_chip_version(u16 xid, bool gmii)
 	return p;
 }
 
+static const struct rtl_chip_info *rtl8169_get_extended_chip_version(u32 xid2)
+{
+	const struct rtl_chip_info *p = rtl_chip_infos_extended;
+
+	while ((xid2 & p->mask) != p->val)
+		p++;
+	return p;
+}
+
 static void rtl_release_firmware(struct rtl8169_private *tp)
 {
 	if (tp->rtl_fw) {
@@ -5573,11 +5595,12 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_chip_info *chip;
+	const char *ext_xid_str = "";
 	struct rtl8169_private *tp;
 	int jumbo_max, region, rc;
 	struct net_device *dev;
 	u32 txconfig;
-	u16 xid;
+	u32 xid;
 
 	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
 	if (!dev)
@@ -5625,10 +5648,16 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Identify chip attached to board */
 	chip = rtl8169_get_chip_version(xid, tp->supports_gmii);
+
+	if (chip->mac_version == RTL_GIGA_MAC_VER_EXTENDED) {
+		ext_xid_str = "ext";
+		xid = RTL_R32(tp, TX_CONFIG_V2);
+		chip = rtl8169_get_extended_chip_version(xid);
+	}
 	if (chip->mac_version == RTL_GIGA_MAC_NONE)
 		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "unknown chip XID %03x, contact r8169 maintainers (see MAINTAINERS file)\n",
-				     xid);
+				     "unknown chip %sXID %x, contact r8169 maintainers (see MAINTAINERS file)\n",
+				     ext_xid_str, xid);
 	tp->mac_version = chip->mac_version;
 	tp->fw_name = chip->fw_name;
 
@@ -5767,8 +5796,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			tp->leds = rtl8168_init_leds(dev);
 	}
 
-	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
-		    chip->name, dev->dev_addr, xid, tp->irq);
+	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d\n",
+		    chip->name, dev->dev_addr, ext_xid_str, xid, tp->irq);
 
 	if (jumbo_max)
 		netdev_info(dev, "jumbo features [frames: %d bytes, tx checksumming: %s]\n",
-- 
2.52.0


