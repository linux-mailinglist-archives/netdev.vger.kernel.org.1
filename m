Return-Path: <netdev+bounces-232683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F562C08161
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8663AF359
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648412F746A;
	Fri, 24 Oct 2025 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+jO4mtU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F42F6587
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338458; cv=none; b=C0tQz3qe460LZhPrQKxGSdJte1UcLiQq9eobrZF7YQJ9CFGeJZJV+RIfwZC4GY27I6DJyw5UNBa/7unII7UfDClU2qzzL/ZqlneLkF0GmQOvFIp5M6q5AJWUXzJll3mKdGT9oS97fycW2GG2B5OE5hiOWr6TIC1RfE0uwsfo/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338458; c=relaxed/simple;
	bh=MerOat1ornUq/VRTOfIsxteMIx7YlRJeB341bkofMa4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRWt8cSdjNBrpPz/8WKajRMKk3IKsPrXZ5vLYZ7Eq2TDH5702nWhWVXIWWFOm4T5RQoB0uy9X6cP48H0tWKHRok6R4K0pEYuLBuXmfibpEg0pb5iBAB/jTB8ZY3Yw8wftGS1D0tkWHR390XjS3Uhn28HYOQZJznlY9qyxQ1aSF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+jO4mtU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f67ba775aso3166200b3a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338456; x=1761943256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/W5IVU2yyiwKIMoPN+3RTRQfwz5HbWDlu3fkar4lsHU=;
        b=O+jO4mtUpXSY1cGzMYAaFPqrupI3fwscb42I2+zyIbI4UlpobWRljmbQG+daL30QmG
         RINwxdJaA/qqawc7VgC8c/el0lOGyUxHU8mjOrK8QhI1dBh7LWneNwRcdsgp4Zx+bk7A
         aeKbZe0J/ZMBQsOK9To1H6FalD9vVIu9htoF/bvapbGMK9lONswGMhXzSjO5p9NR78vZ
         0y/26xABK1Hqjyk9sYZHqJ0wqFXLLVW3JHjastpwNBqL/f76G3FP7Pxi4UVKHkaDoTxF
         AxKMMDiRrMh6hGXWhTSYztpkUXAAr/0xWmuodjjZ+D9o1WyIeFpfiHHOCGvbUvxLDHyB
         gVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338456; x=1761943256;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/W5IVU2yyiwKIMoPN+3RTRQfwz5HbWDlu3fkar4lsHU=;
        b=PFXLkoG+u6rP0dCcQNwpsQ5TKVZPhcQDhI7ddc9eoeEcfpx4AYrhRDRLlQL53elQsh
         H1YCj7MaQqVJoh/xbyBl89IFSEL7i99o/Qw1xIsZhbN5k3Bl/updWy09hKx3ENhKND5x
         xjjHbcLguBDBKQIcApGG1s+GuWDjdmXSeR7J3UPrdMJTcFxwm+D/oah7o6uxC9b/S1yn
         VeSJd7/zrCLgHxtjR6w6V/qMFMMYtgDxwHxofWG/iFuTGkBVZt1+2kXfG0arqw+yF3M7
         rtG+bKyERZSxbXC29it72wtk/xXLqISaCOyKZkjunF7MfJpWfViwzkn3OiAvilg5n0wU
         iyWw==
X-Gm-Message-State: AOJu0Yy86itoDCBvqatxZFeqMDo9ReoJ0N+Od1S6AehkXTQrLTIo59Iw
	2NfZzSzkIXseeulMhIx3C5B9tiijFz/iPrFkYkj8xXUgU8+SDCNHoj00
X-Gm-Gg: ASbGnctOP/Nc97cwhz8s2YjS50rfPj/NkPWdnyFAcNEUzPv18m47dJqJFkIGP+z8+rT
	ECYQ+p+pQB4uUJZDT6kG1CKpGkwaGkpBpUruf752wuDHzZ+bZa04YdBqur2muSlxYp1p7/3PLPC
	SM7nTDZSa97A5tTheq8p/R6e1FTfrHBhzjpfQebOSZTKl/JdJi+9s7emgvPoCW6D2BbY9xSB8Nd
	C+GVH1kVnmkNcHznRAbOJFod4cannJK4Ndes5d3hWbgbmfadSWgVd36u7evtT2XuEd0TwMPJ14P
	k1J8wEzEKRbfbImpzUGnKNI3kPzzSJH6fQxxA3aFYiQHtRCnPYvhbwd1LBkK6dnykrGcZEqLGDe
	zXKyRYosXE+2o/8LWjYxdpmbryVY/Xc98CoutFJAdamuWExRWYD5DMVUxV5gIK7Q8t/KMqhd7KF
	4jQZS5Pe29eA3UwXIp7dxIMDAIgiNd8VZ9OiHFhK7heuem
X-Google-Smtp-Source: AGHT+IFaOXU6vHHYzLI8YU8FaRpU6/6I5NBNAF925KYd3sW20cuXJ4cv3Bcy7N7nE/CImmdrcNpPoQ==
X-Received: by 2002:a05:6a20:7489:b0:32b:721e:ced1 with SMTP id adf61e73a8af0-334a8617237mr43187040637.36.1761338455661;
        Fri, 24 Oct 2025 13:40:55 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7bd08asm30652a91.3.2025.10.24.13.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:55 -0700 (PDT)
Subject: [net-next PATCH 3/8] net: phy: Add 25G-CR, 50G-CR,
 100G-CR2 support to C45 genphy
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 24 Oct 2025 13:40:53 -0700
Message-ID: 
 <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Add support for 25G-CR, 50G-CR, 50G-CR2, and 100G-CR2 the c45 genphy. Note
that 3 of the 4 are IEEE compliant so they are a direct copy from the
clause 45 specification, the only exception to this is 50G-CR2 which is
part of the Ethernet Consortium specification which never referenced how to
handle this in the MDIO registers.

Since 50GBase-CR2 isn't an IEEE standard it doesn't have a value in the
extended capabilities registers. To account for that I am adding a define
that is aliasing the 100GBase-CR4 to represent it as that is the media type
used to carry data for 50R2, it is just that the PHY is carrying two 2 with
2 lanes each over the 4 lane cable. For now I am representing it with ctrl1
set to 50G and ctrl2 being set to 100R4, and using the 100R4 capability to
identify if it is supported or not.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phy-c45.c |  114 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/mdio.h |   34 +++++++++++++
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 4210863c1b6e..65d6f45c898d 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -161,6 +161,38 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 		/* Assume 10Gbase-T */
 		ctrl2 |= MDIO_PMA_CTRL2_10GBT;
 		break;
+	case SPEED_25000:
+		ctrl1 |= MDIO_CTRL1_SPEED25G;
+		/* Assume 25Gbase-CR */
+		ctrl2 |= MDIO_PMA_CTRL2_25GBCR;
+		break;
+	case SPEED_50000:
+		ctrl1 |= MDIO_CTRL1_SPEED50G;
+		/* There are currently 2 supported modes for 50G.
+		 * The first is 50Gbase-CR which is in the IEEE standard.
+		 * The second is 50Gbase-CR2 which isn't. It is intended
+		 * to piggy-back on 100Gbase-CR4 and only use 2 lanes, so
+		 * we can use the interface type to identify which is which.
+		 */
+		if (phydev->interface == PHY_INTERFACE_MODE_50GBASER)
+			ctrl2 |= MDIO_PMA_CTRL2_50GBCR;
+		else if (phydev->interface == PHY_INTERFACE_MODE_LAUI)
+			ctrl2 |= MDIO_PMA_CTRL2_50GBCR2;
+		else
+			return -EINVAL;
+		break;
+	case SPEED_100000:
+		ctrl1 |= MDIO_CTRL1_SPEED100G;
+		/* For now we only have support for 2 lane devices, so
+		 * 100Gbase-CR2 is the limit. We might look at enabling
+		 * 100Gbase-CR4 in the future with additional devices to
+		 * test this code on.
+		 */
+		if (phydev->interface == PHY_INTERFACE_MODE_100GBASEP)
+			ctrl2 |= MDIO_PMA_CTRL2_100GBCR2;
+		else
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -958,6 +990,34 @@ int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_an_config_eee_aneg);
 
+static int genphy_c45_pma_40_100g_read_abilities(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+			   MDIO_PMA_40G_EXTABLE);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_40G_EXTABLE_100GBCR4);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_40G_EXTABLE_50GBCR2);
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+			   MDIO_PMA_100G_EXTABLE);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_100G_EXTABLE_100GBCR2);
+
+	return 0;
+}
+
 static int genphy_c45_pma_ng_read_abilities(struct phy_device *phydev)
 {
 	int val;
@@ -978,6 +1038,22 @@ static int genphy_c45_pma_ng_read_abilities(struct phy_device *phydev)
 	return 0;
 }
 
+static int genphy_c45_pma_25g_read_abilities(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+			   MDIO_PMA_25G_EXTABLE);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_25G_EXTABLE_25GBCR);
+
+	return 0;
+}
+
 /**
  * genphy_c45_pma_baset1_read_abilities - read supported baset1 link modes from PMA
  * @phydev: target phy_device struct
@@ -1016,6 +1092,22 @@ int genphy_c45_pma_baset1_read_abilities(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_pma_baset1_read_abilities);
 
+static int genphy_c45_pma_50g_read_abilities(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+			   MDIO_PMA_50G_EXTABLE);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_50G_EXTABLE_50GBCR);
+
+	return 0;
+}
+
 /**
  * genphy_c45_pma_read_ext_abilities - read supported link modes from PMA
  * @phydev: target phy_device struct
@@ -1064,18 +1156,40 @@ int genphy_c45_pma_read_ext_abilities(struct phy_device *phydev)
 			 phydev->supported,
 			 val & MDIO_PMA_EXTABLE_10BT);
 
+	if (val & MDIO_PMA_EXTABLE_40_100G) {
+		err = genphy_c45_pma_40_100g_read_abilities(phydev);
+		if (err < 0)
+			return err;
+	}
+
 	if (val & MDIO_PMA_EXTABLE_NBT) {
 		err = genphy_c45_pma_ng_read_abilities(phydev);
 		if (err < 0)
 			return err;
 	}
 
+	if (val & MDIO_PMA_EXTABLE_25G) {
+		err = genphy_c45_pma_25g_read_abilities(phydev);
+		if (err < 0)
+			return err;
+	}
+
 	if (val & MDIO_PMA_EXTABLE_BT1) {
 		err = genphy_c45_pma_baset1_read_abilities(phydev);
 		if (err < 0)
 			return err;
 	}
 
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE2);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_PMA_EXTABLE2_50G) {
+		err = genphy_c45_pma_50g_read_abilities(phydev);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(genphy_c45_pma_read_ext_abilities);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index ff8b6423bd1e..8f9a4328daf9 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -41,15 +41,20 @@
 #define MDIO_PMA_TXDIS		9	/* 10G PMA/PMD transmit disable */
 #define MDIO_PMA_RXDET		10	/* 10G PMA/PMD receive signal detect */
 #define MDIO_PMA_EXTABLE	11	/* 10G PMA/PMD extended ability */
+#define MDIO_PMA_40G_EXTABLE	13	/* 40G/100G PMA/PMD extended ability */
 #define MDIO_PKGID1		14	/* Package identifier */
 #define MDIO_PKGID2		15
 #define MDIO_AN_ADVERTISE	16	/* AN advertising (base page) */
 #define MDIO_AN_LPA		19	/* AN LP abilities (base page) */
+#define MDIO_PMA_25G_EXTABLE	19	/* 25G PMA/PMD extended ability */
 #define MDIO_PCS_EEE_ABLE	20	/* EEE Capability register */
+#define MDIO_PMA_50G_EXTABLE	20	/* 50G PMA/PMD extended ability */
 #define MDIO_PCS_EEE_ABLE2	21	/* EEE Capability register 2 */
 #define MDIO_PMA_NG_EXTABLE	21	/* 2.5G/5G PMA/PMD extended ability */
 #define MDIO_PCS_EEE_WK_ERR	22	/* EEE wake error counter */
 #define MDIO_PHYXS_LNSTAT	24	/* PHY XGXS lane state */
+#define MDIO_PMA_EXTABLE2	25	/* PMA/PMD extended ability 2 */
+#define MDIO_PMA_100G_EXTABLE	26	/* 40G/100G PMA/PMD extended ability 2 */
 #define MDIO_AN_EEE_ADV		60	/* EEE advertisement */
 #define MDIO_AN_EEE_LPABLE	61	/* EEE link partner ability */
 #define MDIO_AN_EEE_ADV2	62	/* EEE advertisement 2 */
@@ -187,9 +192,18 @@
 #define MDIO_PMA_CTRL2_1000BKX		0x000d	/* 1000BASE-KX type */
 #define MDIO_PMA_CTRL2_100BTX		0x000e	/* 100BASE-TX type */
 #define MDIO_PMA_CTRL2_10BT		0x000f	/* 10BASE-T type */
+#define MDIO_PMA_CTRL2_100GBCR4		0x002e	/* 100GBASE-CR4 type */
+/* 50GBase-CR2 isn't an IEEE media type, as such there isn't a defined
+ * value for it. However as it is meant to be a reuse of 100GBase-CR4 we
+ * will reuse the value here so that both report the same value.
+ */
+#define MDIO_PMA_CTRL2_50GBCR2		MDIO_PMA_CTRL2_100GBCR4
 #define MDIO_PMA_CTRL2_2_5GBT		0x0030  /* 2.5GBaseT type */
 #define MDIO_PMA_CTRL2_5GBT		0x0031  /* 5GBaseT type */
+#define MDIO_PMA_CTRL2_25GBCR		0x0038	/* 25GBASE-CR type */
 #define MDIO_PMA_CTRL2_BASET1		0x003D  /* BASE-T1 type */
+#define MDIO_PMA_CTRL2_50GBCR		0x0041	/* 50GBASE-CR type */
+#define MDIO_PMA_CTRL2_100GBCR2		0x0049	/* 100GBASE-CR2 type */
 #define MDIO_PCS_CTRL2_TYPE		0x0003	/* PCS type selection */
 #define MDIO_PCS_CTRL2_10GBR		0x0000	/* 10GBASE-R type */
 #define MDIO_PCS_CTRL2_10GBX		0x0001	/* 10GBASE-X type */
@@ -233,7 +247,7 @@
 #define MDIO_PMD_RXDET_2		0x0008	/* PMD RX signal detect 2 */
 #define MDIO_PMD_RXDET_3		0x0010	/* PMD RX signal detect 3 */
 
-/* Extended abilities register. */
+/* PMA/PMD extended ability register. */
 #define MDIO_PMA_EXTABLE_10GCX4		0x0001	/* 10GBASE-CX4 ability */
 #define MDIO_PMA_EXTABLE_10GBLRM	0x0002	/* 10GBASE-LRM ability */
 #define MDIO_PMA_EXTABLE_10GBT		0x0004	/* 10GBASE-T ability */
@@ -243,9 +257,14 @@
 #define MDIO_PMA_EXTABLE_1000BKX	0x0040	/* 1000BASE-KX ability */
 #define MDIO_PMA_EXTABLE_100BTX		0x0080	/* 100BASE-TX ability */
 #define MDIO_PMA_EXTABLE_10BT		0x0100	/* 10BASE-T ability */
+#define MDIO_PMA_EXTABLE_40_100G	0x0400	/* 40G/100G ability */
 #define MDIO_PMA_EXTABLE_BT1		0x0800	/* BASE-T1 ability */
+#define MDIO_PMA_EXTABLE_25G		0x1000	/* 25G ability */
 #define MDIO_PMA_EXTABLE_NBT		0x4000  /* 2.5/5GBASE-T ability */
 
+/* PMA/PMD extended ability 2 register. */
+#define MDIO_PMA_EXTABLE2_50G		0x0001	/* 50G ability */
+
 /* AN Clause 73 linkword */
 #define MDIO_AN_C73_0_S_MASK		GENMASK(4, 0)
 #define MDIO_AN_C73_0_E_MASK		GENMASK(9, 5)
@@ -436,10 +455,23 @@
 /* AN MultiGBASE-T AN control 2 */
 #define MDIO_AN_THP_BP2_5GT	0x0008	/* 2.5GT THP bypass request */
 
+/* 40G/100G PMA/PMD Extended ability register */
+#define MDIO_PMA_40G_EXTABLE_100GBCR4	0x4000	/* 100GBASE-CR4 ability */
+#define MDIO_PMA_40G_EXTABLE_50GBCR2	MDIO_PMA_40G_EXTABLE_100GBCR4
+
+/* 25G PMA/PMD Extended ability register */
+#define MDIO_PMA_25G_EXTABLE_25GBCR	0x0008	/* 25GBASE-CR ability */
+
+/* 50G PMA/PMD Extended ability register */
+#define MDIO_PMA_50G_EXTABLE_50GBCR	0x0002	/* 50GBASE-CR ability */
+
 /* 2.5G/5G Extended abilities register. */
 #define MDIO_PMA_NG_EXTABLE_2_5GBT	0x0001	/* 2.5GBASET ability */
 #define MDIO_PMA_NG_EXTABLE_5GBT	0x0002	/* 5GBASET ability */
 
+/* 40G/100G PMA/PMD Extended ability 2 register */
+#define MDIO_PMA_100G_EXTABLE_100GBCR2	0x0100	/* 100GBASE-CR2 ability */
+
 /* LASI RX_ALARM control/status registers. */
 #define MDIO_PMA_LASI_RX_PHYXSLFLT	0x0001	/* PHY XS RX local fault */
 #define MDIO_PMA_LASI_RX_PCSLFLT	0x0008	/* PCS RX local fault */



