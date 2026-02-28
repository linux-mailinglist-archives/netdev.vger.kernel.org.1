Return-Path: <netdev+bounces-262263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF1tFhJ5o2lvEAUAu9opvQ
	(envelope-from <netdev+bounces-262263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:24:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CF31C9ACA
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC23F30292D1
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DC33E5568;
	Sat, 28 Feb 2026 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMhisKHN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4B3E0C72
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320991; cv=none; b=gUBNTtjrQQgFunU2J48KuEKM3H8BI/M1DxcjZ70BA2HTSYCLFwFi3DUQql5RZPiLmmAKTf81BU/SZ8CxX6khhewMwcMMx2uSjA8m1Pugtergom2uk4mA47R573uWggxS7qdFUzVFFZh26GrNLR1E8c/rQtFKZ0h+1GBDusgJllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320991; c=relaxed/simple;
	bh=/E00kd06ARqV1EiG6J7bbJMQs/AdElwvl+AD4goyHi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYlGxVvgILkJzlIptiU2WKW7mryUGbj7oAaJSJvt55/5J+xiD6Gz26Myg8IGGG89fTK99eR4ryIQPpDb3NZk08HQ9fIyT2sdpbw2fQhmQ93FLcHpLT5ShMeyLKqSnC11GY7+DoUxUwY9viwZ1ktULD/bKyjbhyrMGTtMGXVmL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMhisKHN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b2965d4bso67841f8f.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 15:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772320989; x=1772925789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7E353CUJwnGyuCmm4n5uTZxUZWsHiLJYSS1cugMXcw=;
        b=HMhisKHNsCap3F38Px4IfUG4LXbhDM37+U5jdmOJ5TCuMNZ6KyEG5VdNuZl9Szztah
         4i8N+iaPOimo263DldltdsyDv7iAfEEIGnbDHrd/Z5NqcZEGZGlB8NlYbIV+uBwdBTx+
         8CMd2MtMxwGnkl9jFzUPbIrCjeQ23Pozf8CKUDxLM+9jzolPZ82QEquWa/ts63NpXuyX
         d/VfDrFRe3+ARFLC3dN3K7cjO2+9BNRjxbf13+YX2/sM1fZjV6G3+RaO9hRDhSvaf0cS
         q0j3yebzt5VEkQW2CCzZddRW9TA66qurEaCkjx4XesCULjRmUUnhgOLCYNiX1ZFIVu/+
         mFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772320989; x=1772925789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7E353CUJwnGyuCmm4n5uTZxUZWsHiLJYSS1cugMXcw=;
        b=WdP+Eobf97WIvAmkiel7Psn48tpXKou0yrMHvTycCDkKkecjneuPkkMdxe+g08yOlQ
         vUO7qn9lsW0gnVGYZIswWnN+0RQom1TNZdCGijjyr5uCiQpHlsWoybpKjKKf5IIjTaVN
         LTxn1N1AWCQQIUzYk6irNMi+bg2IqD65METmUU/TUQDwzRxmzOho0mT7bNTf+z5J0cgr
         dPw8mQ08twVm6Xpltknzq5nTXH5j3b+YmYSuUFYUkUv/wlje/fJyi89D9J0vTMlJNfn/
         e4Q1oLOQLGe2QYRTy1SZ3/0xhXo46v4Vp1dKEWHBUOjThHTMMUpNwPDsaTZ79x8jasyz
         8zVw==
X-Forwarded-Encrypted: i=1; AJvYcCWLV/gRkYSVCn4rD3XQaA3s85vEagVuIPIUxOPHoIFDTbHnks1MBCRBIpx4N3fggjgfP8OISsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qktTrKUOuWYXQb+iZ/j5E0+BRAeFVdW/VNYnXZvXDjMMuAgN
	nvDwSB8iI/okJIKf628vchC6iSQ8EzLTnC/+pt/G+lREYi8cPlCNvCGJ
X-Gm-Gg: ATEYQzz+0GJH5DlSEyUOWey1FsfhF4UjYcL75iHtdCJs86HL7WtTMdGZ1f/nuSzym3E
	W5EE5emHqtkFjN/GUealh3DkXFwGG5E4KLW/gbQTaMBiKulKLx8wyzACU/YcaRPHOwa66ubvKK0
	OH1uL+nrySqDoAIEOM0AYu+JFPPj+C+OqMfQxR35akc2SgD36syEZjhjDp6aIPVfaKL1eFtmDlp
	g2VPykANheP6n8Unvmi1ok9m+YbFBuO60L2jNh2Cyt5EAK6I7aDjzQXnGX1BNUgnPcbSXYSUS5Q
	G04sjPTph9QzFKfU/a2Xsyo30DurYT1poXHpF4XkmSOeBpFQpAyjL1JcPjozxLQFXRtEERYLap7
	T2M73OxRBb4astDKZLAPyB8A1RiYMLNdblP/rt1qvednyr0dubO3zuv7o8X7GtzVOQXqlT6lu8Q
	tam3klv3WGNsLxvH3w1C55CIErUGrVpiT185QPS1fN6S/Oe4FBKc6U8eTfvw1bAQER555MNggi6
	79+Txs=
X-Received: by 2002:a05:6000:2903:b0:439:9312:4b72 with SMTP id ffacd0b85a97d-4399de20ad6mr12654417f8f.30.1772320988508;
        Sat, 28 Feb 2026 15:23:08 -0800 (PST)
Received: from pc-kuba-l13.. (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70ed47sm18515680f8f.11.2026.02.28.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 15:23:08 -0800 (PST)
From: =?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
Subject: [PATCH net-next v2 5/5] net: phy: motorcomm: yt8821: Disable MDIO broadcast
Date: Sun,  1 Mar 2026 00:22:41 +0100
Message-ID: <20260228232241.1274236-6-linuxtardis@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228232241.1274236-1-linuxtardis@gmail.com>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262263-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7CF31C9ACA
X-Rspamd-Action: no action

By default, the YT8821 responds at two MDIO addresses: the address
selected by its strapping pins and the broadcast address 0.
This causes problems if another PHY is legitimately configured
at address 0.

Disable the broadcast address using two mechanisms. The PHY fixup
prevents collisions during initial MDIO bus scanning.
yt8821_config_init() then re-disables the broadcast address if the
PHY goes through a hardware reset (this happens if the PHY has a
reset GPIO on its device tree node, and the interface is brought
down and up).

Link: https://github.com/openwrt/openwrt/pull/21584
Fixes: b671105b88c3 ("net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy")
Signed-off-by: Jakub Vaněk <linuxtardis@gmail.com>
---
 drivers/net/phy/motorcomm.c         | 29 +++++++++++++++++++++++++
 drivers/net/phy/phy_common_fixups.c | 33 +++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 4d62f7b36212..e1503fab568a 100644
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
@@ -2764,6 +2767,28 @@ static int yt8821_soft_reset(struct phy_device *phydev)
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
+ * respond only at MDIO address 0. If the YT8821 also listens on address 0,
+ * it may incorrectly react to transactions intended for those PHYs.
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8821_disable_mdio_address_zero(struct phy_device *phydev)
+{
+	return ytphy_modify_ext_with_lock(phydev,
+					  YTPHY_MDIO_ADDRESS_CONTROL_REG,
+					  YTPHY_MACR_EN_PHY_ADDR_0,
+					  0);
+}
+
 /**
  * yt8821_config_init() - phy initializatioin
  * @phydev: a pointer to a &struct phy_device
@@ -2799,6 +2824,10 @@ static int yt8821_config_init(struct phy_device *phydev)
 		phydev->rate_matching = RATE_MATCH_PAUSE;
 	}
 
+	ret = yt8821_disable_mdio_address_zero(phydev);
+	if (ret < 0)
+		return ret;
+
 	ret = yt8821_serdes_init(phydev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/phy/phy_common_fixups.c b/drivers/net/phy/phy_common_fixups.c
index fa51c6d7b25f..5a60721b56d6 100644
--- a/drivers/net/phy/phy_common_fixups.c
+++ b/drivers/net/phy/phy_common_fixups.c
@@ -4,6 +4,32 @@
 
 #include "phylib-internal.h"
 
+#define PHY_ID_YT8821				0x4f51ea19
+#define YTPHY_PAGE_SELECT			0x1E
+#define YTPHY_PAGE_DATA				0x1F
+#define YTPHY_MDIO_ADDRESS_CONTROL_REG		0xA005
+#define YTPHY_MACR_EN_PHY_ADDR_0		BIT(6)
+
+/**
+ * yt8821_disable_broadcast - Disable MDIO broadcast on address 0
+ */
+static int yt8821_disable_broadcast(struct phy_device *phydev)
+{
+	int rc = 0;
+
+	phy_lock_mdio_bus(phydev);
+
+	rc = __phy_write(phydev, YTPHY_PAGE_SELECT, YTPHY_MDIO_ADDRESS_CONTROL_REG);
+	if (rc < 0)
+		goto unlock;
+
+	rc = __phy_modify(phydev, YTPHY_PAGE_DATA, YTPHY_MACR_EN_PHY_ADDR_0, 0);
+
+unlock:
+	phy_unlock_mdio_bus(phydev);
+	return rc;
+}
+
 /**
  * phy_register_address_0_fixups - Register fixups for disabling MDIO
  * broadcast address 0
@@ -22,5 +48,12 @@
  */
 int phy_register_address_0_fixups(void)
 {
+	int rc;
+
+	rc = phy_register_fixup_for_uid(PHY_ID_YT8821, 0xFFFFFFFF,
+					yt8821_disable_broadcast);
+	if (rc < 0)
+		return rc;
+
 	return 0;
 }
-- 
2.43.0


