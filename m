Return-Path: <netdev+bounces-259844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKoTCgFEmmm6aAMAu9opvQ
	(envelope-from <netdev+bounces-259844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:47:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C616E47E
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB17301BF4E
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 23:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B08311C11;
	Sat, 21 Feb 2026 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4dZAZLA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9CE246BC5
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771717619; cv=none; b=RQsJ+cIhrY0DJH6iicZmY0zfqtlxUSi9KNUmlQ03uyxFYxkDHJ7PXWT+hAmChjQaA+N68aq+6UsAOpIm3fE3ljby7JN38J8Qmq7mAcKz6oP+DRh0RuYgDzcUsZpGYCcB15rkSVKb3vsDioM8AqDmkchS53Q0S2u13wTCJ9IjVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771717619; c=relaxed/simple;
	bh=CI6Ld/360tcKW0f2CDu5G0ZhUB63qMbtjaTz06jRPkU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BB4Ivof41uA2dIpjduXNhAKXFP1IXZZlxVM6trzYSit0a529Zx4VflX4YBILoz1gVppP7hcnxSBRqmOs52ElLKIAiNrdio6scTetsPiod3RwUK92pUTZXbenrMWxSsCV8o+raSJrk4HJ7/puuo8MxnsV7KFTyoSv1rFUO/4XxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4dZAZLA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso27053385e9.3
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 15:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771717616; x=1772322416; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsFpBim+U9AJYeIWZrEcXBta4FenG5ZBWPSwsN8cexA=;
        b=T4dZAZLAnRoKX0EKSzvemPRhGLHwhIYVpdtMbJCr6a/+jtY0hDNIlsXIFK9wnDP4Lw
         WJk0GH+o6zwoZMV0LHIhm+IaQ2aczYqn5vfa7r1RR+gF3ABtSx4pfzistVOBuyfQIUGA
         vDo3b+hApkmc71FFJdCnxrY4PCRllxQzMCqYzA6pzcKGH0nXDMa02gPRUugQqJlwkAZn
         ro7k5xHRF3DAFI4LUNfUAiwvWY1gqhyn4k25owCdEu62sb0xtPPkk4pGLapmxYnaB524
         SMmgcAwP0QPAae3B4mGmQkRupTDHkwT9B9ZvieCyyyR+ypusQe+3OskKRf6f7bLHfiyE
         3DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771717616; x=1772322416;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsFpBim+U9AJYeIWZrEcXBta4FenG5ZBWPSwsN8cexA=;
        b=S4SW6QB5OwlkLOuUXcn077xzEBjIyYpTVucUV2Rm4l52+5Sst24ZaIsVGrAjvVmmf7
         x5Q1bpufQWNInf8sZMNm8qneAfm96PXRQM697c9xDXS8XC5QoDQ4Oh402A/nxlE9a87A
         T+A34dhx+DHPoJgh+S2LaVkppKjyNMyyodJWyUM+fXVpglllQkzW+VtI666UbyXJDEv+
         lKs4l+Jb2+8XIMNXBuZlQhFFq77eOjBdYd5p3ghzOuAgqltK8Agt3wdFJXXEppxYnjZj
         xm/a0aVawMo17l9WMLv6MqiiYjlefEiVGPN8LqbII/jIgnj9pym9k/5Go/POMjaPzMyj
         KV1A==
X-Forwarded-Encrypted: i=1; AJvYcCXaO1sorMCpK2jO0bcKfehz06nxXbPNJ/VoZ0wJNRU3oq2QPDmw5vcb8YNhiXHF4mTrfvxDkAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUyPmlAtYere/CehXbpYBjr8ZWgwVQSNFTYfTXPq3lHCyorwu
	2HQKIJyB9JVdJ6FlyUsFPtHT/U6ozcg3KDjNuDaGgz3qFbKcr1klkk8t
X-Gm-Gg: AZuq6aJNkmv6u8u2Z4hFYUXQxvDXY3y2nZ1TilGAQUDHVcKS8ZxqVq+Pae6793IEd3L
	OYJLKmLXDxo3YsaEyONYAhDni8/ZxU+9km2R8w46TSsZYrC6T+Paxt4M0U57E6s6OxOaR4n9PE0
	6w8jLFkmZtTOdw9XOTZnaMd4aq9pgiio2iv/PWdxC6R8t18yrNro2nxOZ8Ibl5ljAV/KSevG/kx
	iTAYIbio02xDCNWlmRjCNr1qnMGNz5n16Fs2RBo7G9vmvf/w0LI4sFkLzJfIg4SpU4RPQ7zjsMJ
	tt4FQGUgqTImNPhG1yFzZc3GjRHvhRNMzSRCv6IL9NDYmfRpXmWizgn4ojrEHDGhvJzsM9+UvTs
	HNPFuaBVaFFsC7n2IgDij78TwGuS+284GGNGrL2ysxz3P8QhQvzjJIAGPwNXB8jPH6idaL8u/Ys
	kirH5qPt74WD9lZ5L7LwGQeOMwc+5Ef7jNstNrAPLwH0PaWdAGDlUYqJZ1+yFdHEz/8y0Nbg6ii
	TVI
X-Received: by 2002:a05:600c:4e12:b0:480:39ad:3b7c with SMTP id 5b1f17b1804b1-483a962e465mr80910425e9.16.1771717616137;
        Sat, 21 Feb 2026 15:46:56 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm8271637f8f.6.2026.02.21.15.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 15:46:54 -0800 (PST)
Message-ID: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
Date: Sun, 22 Feb 2026 00:46:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Frank <Frank.Sae@motor-comm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxtardis@gmail.com
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
Subject: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO broadcast
 address 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259844-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F3C616E47E
X-Rspamd-Action: no action

The YT8821 PHY responds on two MDIO addresses by default: the address
selected by its strapping pins and the broadcast address 0.

On platforms where another PHY is hardwired to respond only on address 0
(e.g. the internal Gigabit PHY in the MediaTek MT7981B SoC), this can lead
to MDIO bus conflicts. The YT8821 may incorrectly respond to transactions
intended for the other PHY, leaving it in an inconsistent state. The
following issues were observed on a Cudy M3000 router:

- Achieving just 100 Mbps speeds on gigabit links. Dmesg would show
  messages like

    [ 133.997177] YT8821 2.5Gbps PHY mdio-bus:01: Downshift occurred from negotiated speed 1Gbps to actual speed 100Mbps, check cabling!
    [ 134.009400] mtk_soc_eth 15100000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off

- Having the PHY report that the link is up, yet no data would flow.
- The YT8821 would be affected by an "ip link set dev eth1 down"
  command aimed at the other PHY.

Avoid this conflict by disabling the broadcast address 0 early in
the PHY configuration process. The .probe callback is called early
enough to stop the issues from occurring. The .config_init callback
re-establishes the workaround after the PHY undergoes a hardware
reset.

This change makes the YT8821 work reliably on the Cudy M3000 router
when running the current OpenWrt main branch with a small device tree
patch.

Link: https://github.com/openwrt/openwrt/pull/21584
Fixes: b671105b88c3 ("net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy")
Signed-off-by: Jakub Vaněk <linuxtardis@gmail.com>
---
 drivers/net/phy/motorcomm.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 42d46b5758fc..bcb60d0bcab5 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -227,6 +227,9 @@
 #define YT8521_LED_100_ON_EN			BIT(5)
 #define YT8521_LED_10_ON_EN			BIT(4)
 
+#define YTPHY_MDIO_ADDRESS_CONTROL_REG		0xA005
+#define YTPHY_MACR_EN_PHY_ADDR_0		BIT(6)
+
 #define YTPHY_MISC_CONFIG_REG			0xA006
 #define YTPHY_MCR_FIBER_SPEED_MASK		BIT(0)
 #define YTPHY_MCR_FIBER_1000BX			(0x1 << 0)
@@ -2760,6 +2763,30 @@ static int yt8821_soft_reset(struct phy_device *phydev)
 					  YT8521_CCR_SW_RST, 0);
 }
 
+/**
+ * yt8821_disable_mdio_address_zero() - disable MDIO broadcast address 0
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * The YT8821 responds on two MDIO addresses by default:
+ *  - the address selected by its strapping pins
+ *  - the broadcast address 0
+ *
+ * Some other PHYs (e.g. the MT7981B internal Gigabit PHY) are hardwired to
+ * respond only on MDIO address 0. If the YT8821 also listens on address 0,
+ * it may incorrectly react to transactions intended for those PHYs.
+ *
+ * Disabling address 0 on the YT8821 early avoids such MDIO bus conflicts.
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_disable_mdio_address_zero(struct phy_device *phydev)
+{
+	return ytphy_modify_ext(phydev,
+				YTPHY_MDIO_ADDRESS_CONTROL_REG,
+				YTPHY_MACR_EN_PHY_ADDR_0,
+				0);
+}
+
 /**
  * yt8821_config_init() - phy initializatioin
  * @phydev: a pointer to a &struct phy_device
@@ -2795,6 +2822,10 @@ static int yt8821_config_init(struct phy_device *phydev)
 		phydev->rate_matching = RATE_MATCH_PAUSE;
 	}
 
+	ret = yt8821_disable_mdio_address_zero(phydev);
+	if (ret < 0)
+		return ret;
+
 	ret = yt8821_serdes_init(phydev);
 	if (ret < 0)
 		return ret;
@@ -2812,6 +2843,22 @@ static int yt8821_config_init(struct phy_device *phydev)
 	return yt8821_soft_reset(phydev);
 }
 
+/**
+ * yt8821_probe() - early PHY initialization
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_probe(struct phy_device *phydev)
+{
+	/*
+	 * Disable the MDIO broadcast address (0) as early as possible.
+	 * This prevents the YT8821 from responding to transactions
+	 * intended for a different PHY that is fixed at address 0.
+	 */
+	return yt8821_disable_mdio_address_zero(phydev);
+}
+
 /**
  * yt8821_adjust_status() - update speed and duplex to phydev
  * @phydev: a pointer to a &struct phy_device
@@ -3073,6 +3120,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8821),
 		.name			= "YT8821 2.5Gbps PHY",
 		.get_features		= yt8821_get_features,
+		.probe			= yt8821_probe,
 		.read_page		= yt8521_read_page,
 		.write_page		= yt8521_write_page,
 		.get_wol		= ytphy_get_wol,
-- 
2.43.0


