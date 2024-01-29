Return-Path: <netdev+bounces-66881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E436684157B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CE21C23225
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F32159563;
	Mon, 29 Jan 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqBIN4vF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345E266D4
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566768; cv=none; b=uy/sQSbXf9KkxLCa3Znh9A+RKObuzLg1QK5/iHnL4J671yBB9LdhDNHSs5dcXiTyibA4w7M+vLD5yULX5VJ3jr1/I/fa0OAVvRmnHjpfSATlc7zWmdiRUwbw427vMkeutpvJjEcGs1igVibjwiikcOfk0cTv3RNjUQEN6ieRHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566768; c=relaxed/simple;
	bh=T1Z5NXqn8maar1O+nUDC4msJpL5MJLCeUgeJJwUPzV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=HLQ3qy9twt0TbVneLZRLKiTD2sbYLyN56/TJJuDhrjVpY85rufXJm9CV6gfremW18/aM61pAM/8ue2d0IfX7OIdqBrDYJ1e6fzLOlaFq2bVn1BrlfKsR5DyXtY3b7XyBIAPMw2PXYfbdlSmpZDdJwogw8OFHSd72OSe5Gx6pZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqBIN4vF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5100cb238bcso5829374e87.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 14:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706566764; x=1707171564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wGdqerrT3hOt2v0KW6s2sE9bTW+KHd4hd2SH+dwYrqM=;
        b=XqBIN4vFpB3ZnveZyN6CRTPce4TCcsmvceLeHEuu+P20rExUSy/te1Nnia9YDk9fWj
         EaJikjhqYbVwHwZStXIGNZyYXv6dbSK0P/CTEuPGsy9TbYMOo18IOMumgSEVOKeEMrbL
         dQre2jTZI+5p0CoMfflq5iTPughFsM+TDp+uhDanbNrUMxPNB9emNZJnm1evn6XLqLEV
         MZUcYP5CeJgnjF35TybbmKLQWlD4tkbdUD9RTQzWL6ttD7WH95JntjCQ70YGINz/6QB6
         hyKLeh+VejGyY5yIhOGVWmKqTR787R0FGlwD5y2PpE3IA2aHbsFDdRNVXgF6OdlRRxoC
         IlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706566764; x=1707171564;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGdqerrT3hOt2v0KW6s2sE9bTW+KHd4hd2SH+dwYrqM=;
        b=fTFB8cTp2aAfJkpscoRtBltojX7Y1bfTxb236PJUDx+Lfn392/M3YXlpcZTvHKaVaU
         LJp8iM3krndSpI+iiWVndiInpDN36Dnh1nIydO9NZzKCadZNyevjqkFxj61/45RaYzBZ
         sEO/2dmQzIg79VhTNRwWosBgJy0sg2zEdkmGIUh4QgnFGy+8YUTLPosu0nG3GNMhl+yw
         /9H8Y+9P7+4VrGpCBc+m76WF1JFYyoZEbPHYAVL0F3xCt5h9ttpk1M7rRH6MAPrCwamu
         iuy7EiizU66x9paLBz+zSnaiE1DZz2XNbFcKxlf4NVdb1Vmddta8uKyE87tC/J/qKLAg
         CaZw==
X-Gm-Message-State: AOJu0Yzv86AY48C7LhWmeGKouIjmtq0TlXkHrJMvBn93WreYh6SqiDei
	nuetVaiaY9+NQ1nRgp+bBLdO6Hk0/hIle0bFJNenJ+Zs35eOfbDEt1LEfQDN
X-Google-Smtp-Source: AGHT+IFDXIkq/ZJ3S9wmnX9SmqoqPbQtOsxhKAFAXUkxEX0Iq4g+C4y5mFoKufj2Xg6VlDa6SeAeFw==
X-Received: by 2002:a05:6512:752:b0:511:9de:ea8 with SMTP id c18-20020a056512075200b0051109de0ea8mr3115548lfs.23.1706566764066;
        Mon, 29 Jan 2024 14:19:24 -0800 (PST)
Received: from ?IPV6:2a01:c22:7314:6100:208d:961f:8466:926e? (dynamic-2a01-0c22-7314-6100-208d-961f-8466-926e.c22.pool.telefonica.de. [2a01:c22:7314:6100:208d:961f:8466:926e])
        by smtp.googlemail.com with ESMTPSA id fa6-20020a05600c518600b0040ee8765901sm9418442wmb.43.2024.01.29.14.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:19:23 -0800 (PST)
Message-ID: <42f72c0a-c600-4d86-9c29-0112040df050@gmail.com>
Date: Mon, 29 Jan 2024 23:19:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Module r8169 and the Realtek 8126 PCIe 5 G/bps WIRED
 ethernet adapter
To: Joe Salmeri <jmscdba@gmail.com>
References: <ab516cfd-24e8-4761-93a3-49f96a4e6b8f@gmail.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ab516cfd-24e8-4761-93a3-49f96a4e6b8f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.01.2024 19:31, Joe Salmeri wrote:
> Hi,
> 
> I recently built a new PC using the Asus z790 Maximus Formula motherboard.
> 
> The z790 Formula uses the Realtek 8126 PCIe 5 G/bps WIRED ethernet adapter.
> 
> I am using openSUSE Tumbleweed build 20231228 with kernel 6.6.7-1
> 
> There does not seem to be a driver for the Realtek 8126.
> 
> Here is the device info from "lspci | grep -i net"
> 
>     04:00.0 Network controller: Intel Corporation Device 272b (rev 1a)
>     05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
> 
> So it is detects the 8126 just fine it just doesn't have a driver for it.
> 
> I checked realtek.com and found
> 
> https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software
> 
> The download link still says 8125 ( and kernel 6.4 ), but I compiled the source and since I have Secure boot enabled, I signed the
> resulting module file.
> 
> The driver loads successfully and I now have wired networking and it has worked flawlessly for the last 2 months.
> 
> I submitted a bug in Tumbleweed requesting support for the Realtek 8126 be added and was informed that the r8169 kernel module
> is what is used to support the older Realtek 8125 device.
> 
> Since the drivers from Realtek seem to support both the r8125 and my newer r8126, the Tumbleweed support prepared a test
> kernel 6.6.7-1 for me where they added the PCI entry for the r8126 and I installed and tested it out.
> 
> Although it does now load the r8169 module with their test kernel, the r8126 device still does not work.
> 
> The only 2 lines that reference the r8169 in the dmesg log are these 2 lines:
> 
> [    3.237151] r8169 0000:05:00.0: enabling device (0000 -> 0003)
> [    3.237289] r8169 0000:05:00.0: error -ENODEV: unknown chip XID 649, contact r8169 maintainers (see MAINTAINERS file)
> 
> I reported the results of the test to Tumbleweed support and they said that additional tweaks will be needed for the r8169
> module to support the r8126 wired network adapter and thatn I should request to you to add support.
> 
> The details of the openSUSE bug report on the issue can be found here:
> 
>     https://bugzilla.suse.com/show_bug.cgi?id=1217417
> 
> Could we please get support added for the r8126 - Realtek 8126 PCIe 5 G/bps WIRED ethernet adapter added to the kernel ?
> 

Thanks for the report. Actually it's not a bug report but a feature request.
Realtek provides no information about new chip versions and no data sheets, therefore the only
source of information is the r8125 vendor driver. Each chip requires a lot of version-specific
handling, therefore the first steps you described go in the right direction, but are by far not
sufficient. Patch below applies on linux-next, please test whether it works for you, and report back.

Disclaimer:
r8125 references a firmware file that hasn't been provided to linux-firmware by Realtek yet.
Typically the firmware files tune PHY parameters to deal with compatibility issues.
In addition r8125 includes a lot of PHY tuning for RTL8126A.
Depending on cabling, link partner etc. the patch may work for you, or you may experience
link instability or worst case no link at all.

Maybe RTL8126a also has a new integrated PHY version that isn't supported yet.
In this case the driver will complain with the following message and I'd need the PHY ID.
"no dedicated PHY driver found for PHY ID xxx"

> Please let me know if you need any further details.
> 
> Thank you!
> 

---
 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     | 91 +++++++++++++++----
 .../net/ethernet/realtek/r8169_phy_config.c   |  1 +
 3 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 81567fcf3..c921456ed 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -68,6 +68,7 @@ enum mac_version {
 	/* support for RTL_GIGA_MAC_VER_60 has been removed */
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
+	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_NONE
 };
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e0abdbcfa..ebf7a3b13 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -55,6 +55,7 @@
 #define FIRMWARE_8107E_2	"rtl_nic/rtl8107e-2.fw"
 #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
+#define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 
 #define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
 #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
@@ -136,6 +137,7 @@ static const struct {
 	[RTL_GIGA_MAC_VER_61] = {"RTL8125A",		FIRMWARE_8125A_3},
 	/* reserve 62 for CFG_METHOD_4 in the vendor driver */
 	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
+	[RTL_GIGA_MAC_VER_65] = {"RTL8126A",		FIRMWARE_8126A_2},
 };
 
 static const struct pci_device_id rtl8169_pci_tbl[] = {
@@ -158,6 +160,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_VENDOR_ID_LINKSYS, 0x1032, PCI_ANY_ID, 0x0024 },
 	{ 0x0001, 0x8168, PCI_ANY_ID, 0x2410 },
 	{ PCI_VDEVICE(REALTEK,	0x8125) },
+	{ PCI_VDEVICE(REALTEK,	0x8126) },
 	{ PCI_VDEVICE(REALTEK,	0x3000) },
 	{}
 };
@@ -327,8 +330,12 @@ enum rtl8168_registers {
 };
 
 enum rtl8125_registers {
+	INT_CFG0_8125		= 0x34,
+#define INT_CFG0_ENABLE_8125		BIT(0)
+#define INT_CFG0_CLKREQEN		BIT(3)
 	IntrMask_8125		= 0x38,
 	IntrStatus_8125		= 0x3c,
+	INT_CFG1_8125		= 0x7a,
 	TxPoll_8125		= 0x90,
 	MAC0_BKP		= 0x19e0,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
@@ -1139,7 +1146,7 @@ static void rtl_writephy(struct rtl8169_private *tp, int location, int val)
 	case RTL_GIGA_MAC_VER_31:
 		r8168dp_2_mdio_write(tp, location, val);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
 		r8168g_mdio_write(tp, location, val);
 		break;
 	default:
@@ -1154,7 +1161,7 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
 		return r8168dp_2_mdio_read(tp, location);
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
 		return r8168g_mdio_read(tp, location);
 	default:
 		return r8169_mdio_read(tp, location);
@@ -1507,7 +1514,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 		break;
 	case RTL_GIGA_MAC_VER_34:
 	case RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_65:
 		if (wolopts)
 			rtl_mod_config2(tp, 0, PME_SIGNAL);
 		else
@@ -2073,6 +2080,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		u16 val;
 		enum mac_version ver;
 	} mac_info[] = {
+		/* 8126A family. */
+		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_65 },
+
 		/* 8125B family. */
 		{ 0x7cf, 0x641,	RTL_GIGA_MAC_VER_63 },
 
@@ -2343,6 +2353,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
 	case RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_65:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
 			RX_PAUSE_SLOT_ON);
 		break;
@@ -2772,7 +2783,7 @@ static void rtl_enable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_set_bits(tp, 0xd4, 0x0c00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0, 0x1f80);
 		break;
 	default:
@@ -2786,7 +2797,7 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_clear_bits(tp, 0xd4, 0x1f00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0x1f80, 0);
 		break;
 	default:
@@ -2796,6 +2807,8 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 {
+	u8 val8;
+
 	if (tp->mac_version < RTL_GIGA_MAC_VER_32)
 		return;
 
@@ -2809,11 +2822,19 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 			return;
 
 		rtl_mod_config5(tp, 0, ASPM_en);
-		rtl_mod_config2(tp, 0, ClkReqEn);
+		switch (tp->mac_version) {
+		case RTL_GIGA_MAC_VER_65:
+			val8 = RTL_R8(tp, INT_CFG0_8125) | INT_CFG0_CLKREQEN;
+			RTL_W8(tp, INT_CFG0_8125, val8);
+			break;
+		default:
+			rtl_mod_config2(tp, 0, ClkReqEn);
+			break;
+		}
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
 			/* chip can trigger L1.2 */
@@ -2825,14 +2846,22 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
 		default:
 			break;
 		}
 
-		rtl_mod_config2(tp, ClkReqEn, 0);
+		switch (tp->mac_version) {
+		case RTL_GIGA_MAC_VER_65:
+			val8 = RTL_R8(tp, INT_CFG0_8125) & ~INT_CFG0_CLKREQEN;
+			RTL_W8(tp, INT_CFG0_8125, val8);
+			break;
+		default:
+			rtl_mod_config2(tp, ClkReqEn, 0);
+			break;
+		}
 		rtl_mod_config5(tp, ASPM_en, 0);
 	}
 }
@@ -3545,10 +3574,15 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	/* disable new tx descriptor format */
 	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_63)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_65)
+		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_65)
+		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
+	else if (tp->mac_version == RTL_GIGA_MAC_VER_63)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
 	else
-		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
+		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0300);
 
 	if (tp->mac_version == RTL_GIGA_MAC_VER_63)
 		r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0000);
@@ -3561,6 +3595,10 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
 	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
+	if (tp->mac_version == RTL_GIGA_MAC_VER_65)
+		r8168_mac_ocp_modify(tp, 0xea1c, 0x0300, 0x0000);
+	else
+		r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xe0c0, 0x4f0f, 0x4403);
 	r8168_mac_ocp_modify(tp, 0xe052, 0x0080, 0x0068);
 	r8168_mac_ocp_modify(tp, 0xd430, 0x0fff, 0x047f);
@@ -3575,10 +3613,10 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 
 	rtl_loop_wait_low(tp, &rtl_mac_ocp_e00e_cond, 1000, 10);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_63)
-		rtl8125b_config_eee_mac(tp);
-	else
+	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
 		rtl8125a_config_eee_mac(tp);
+	else
+		rtl8125b_config_eee_mac(tp);
 
 	rtl_disable_rxdvgate(tp);
 }
@@ -3622,6 +3660,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
 	rtl_hw_start_8125_common(tp);
 }
 
+static void rtl_hw_start_8126a(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+	rtl_hw_start_8125_common(tp);
+}
+
 static void rtl_hw_config(struct rtl8169_private *tp)
 {
 	static const rtl_generic_fct hw_configs[] = {
@@ -3664,6 +3708,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
+		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
 	};
 
 	if (hw_configs[tp->mac_version])
@@ -3674,9 +3719,23 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 {
 	int i;
 
+	RTL_W8(tp, INT_CFG0_8125, 0x00);
+
 	/* disable interrupt coalescing */
-	for (i = 0xa00; i < 0xb00; i += 4)
-		RTL_W32(tp, i, 0);
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_61:
+		for (i = 0xa00; i < 0xb00; i += 4)
+			RTL_W32(tp, i, 0);
+		break;
+	case RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_65:
+		for (i = 0xa00; i < 0xa80; i += 4)
+			RTL_W32(tp, i, 0);
+		RTL_W16(tp, INT_CFG1_8125, 0x0000);
+		break;
+	default:
+		break;
+	}
 
 	rtl_hw_config(tp);
 }
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index b50f16786..badf78f81 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1152,6 +1152,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_53] = rtl8117_hw_phy_config,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
+		[RTL_GIGA_MAC_VER_65] = NULL,
 	};
 
 	if (phy_configs[ver])
-- 
2.43.0



