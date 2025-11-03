Return-Path: <netdev+bounces-235196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA34C2D620
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2DE424923
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5631D727;
	Mon,  3 Nov 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHgEpyj3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571A320A34
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189238; cv=none; b=biQS660RLp4YvxouEQAKbM0v4cQzWpOhybXfbQsRfZ2NK4y3o0RL7M37FMl1z9BR535OgZX++RQXZNa8oMABykgrrpD1jHWTcFws2H76rO4Wn/TNcvH3m4Jh8SFxBoPq0dblrditodkxw5tVgvLjPQP0qdPVS/8M/krH277ecqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189238; c=relaxed/simple;
	bh=PGzGzCF6UxgVNASQaBT/GaWXHMATUl3Sj4fnjhgEKuQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUZ476PsabEPnKsYMT8fifjnqBMc116/4luwhKTozYBAtqBnf4TXybZYMG6ghhVZosmrYb5QYlbpZk1OIGBSr3HQKmLJ/sVCp+VysBzjM9dsgdqLplZaJoLMGK5ellk1ugxRX83U9YH5IBRblYyrvkjRalWR6JrjTn6EiKjV6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHgEpyj3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aad4823079so1263490b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189236; x=1762794036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IUcb65gV3RVt7XYkCK3R6y1Rp5+wDyyVvZHmT9s6+hw=;
        b=eHgEpyj3IVE1f+j8Oq8h7b++TmyInd1/OQshDBS8vZXye87g5RpOX+hFO9bdR9I5m7
         C/Fj0hECitrlzWodixNoNhxq/1CBS+5AGX3V/DoR4vM5E2Ya5jhBV259vt42T8Elg9Aj
         UxAMOFX1HlMAGHBCMk6aYeR5VxgUzvvgbrgD68a30htvIbNQX8XEu1OYA0qoL31pgNdI
         cZgHTARa/2OiUFb7xDeMbbMUmW5TJU+1bCLtk0nbT7jOqqpZCUT3mi11UIhMpH1WEpuL
         1RJBS4YX94RZnrHnhlcC94Pm9cvgraYfj5+qyyT63Hlxxc5iiudMUFF8EeeAzQfg6gVL
         c2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189236; x=1762794036;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUcb65gV3RVt7XYkCK3R6y1Rp5+wDyyVvZHmT9s6+hw=;
        b=oN0p+PohLOp6mS0LIbDM3A3LzyQx00lkBsIP03OOzpF/aByJ7ka2K3A2120dWgmq3F
         OuJeXhrLM4HgxYJEllUOCpKhuPCSZWLiFCsPRNKWogvwe//bXow+54hyN5L42ONwL8K7
         A3vqDX3A7QAy3eEB+m4t/2IULVqByWnvHoJtU4UgA0NZdMUtyHR7HvZT5FlfoLT1qXye
         7vTV7vn8DI4AXYAC1GBZ5jV73vzzAfj9Ry4Y6UcFyZRPek79ySZrypBlKDDaNs32vcRK
         UJoPDv6G64xfBm3k+fQ9CED+N+OF2b8He+mOs7i8ZjtO/VEpF/XY8SlF+u5KZiUMAgmi
         8ICg==
X-Gm-Message-State: AOJu0Yw5M2sdHHcROuTAyocslUHh8MjyvI0lFqF8ElnHPtvZ0/6Wgdq3
	BlfI/rkLJNFmSVYi+EzXjPeHEo39JqD/C42R5HClU0bGpcl59/M13kt3wZcg6A==
X-Gm-Gg: ASbGncuCPdecZBs8JH+zrgmnRqDbHFct9KaQFC7GF4cE+AJZEgJHN5CdM0G6W0UjC3W
	cufy4R35VjQmHPBXZjCwacXghkknb7WIz0jObSK3GuCEF+kee5bYY9W4+lOa2aN4crkhNQlXIqC
	k9IfpUdEb6g+C/6QwSyn1btLfpw25rPCk3yNjKl+sje91GA49oPNDs6WMPaD+wmKmTmOqQkLhIt
	fi6AGB8wVvp+g+20DRjHh4RodUkVJEhbr+qP4M5feFuWo6W+o+0NRmpAmqrtHGAeNKfVHB3h3tZ
	VRvWxbs3mIMJj0QkKKv1zObWvxpd0s9+cMs48Y5iRmIZf5Ws2zG4lUGeyWy59w3JoitFosHdpyb
	qtRiGcFwcjRLGBbSo6o64geQ1FFAy93iRHiItQoFNbQZhB3v++eraWjY/N3yEMVuzzVGZk6ZcsB
	hdqROS+VtJN/B8CDMpndNlTq5Jsg314FgG1w==
X-Google-Smtp-Source: AGHT+IHjGlW6/nf7G6Um6NEYP2S0sCzId2VpIkIC+v+O+LayUcMhsPG+KnZ802j55WH+fbij4mAJgg==
X-Received: by 2002:a05:6a00:28cb:b0:7aa:4b8:179 with SMTP id d2e1a72fcca58-7aa04b80436mr5478755b3a.1.1762189235867;
        Mon, 03 Nov 2025 09:00:35 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db09f362sm11766661b3a.38.2025.11.03.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:35 -0800 (PST)
Subject: [net-next PATCH v2 05/11] net: phy: Add fbnic specific PHY driver
 fbnic_phy
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:00:34 -0800
Message-ID: 
 <176218923429.2759873.17230953529492488834.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
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

With this change we are effectively adding a stub PHY driver for the fbnic
driver to enable it to report link state of the PMA/PMD separately from the
PCS. This is needed as the firmware will be performing link training when
the link is first detected and this will in turn cause the PCS to link flap
if we don't add a delay to the PMD link up process to allow for this.

With this change we are able to identify the device based on the PMA/PMD
and PCS pair being used. The logic is mostly in place to just handle the
link detection and report the correct speed for the link.

This patch is using the gen10g_config_aneg stub to skip doing any
configuration for now. Eventually this will likely be replaced as we
actually start adding configuration bits to the driver.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 MAINTAINERS                 |    1 +
 drivers/net/phy/Kconfig     |    6 +++++
 drivers/net/phy/Makefile    |    1 +
 drivers/net/phy/fbnic_phy.c |   52 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 drivers/net/phy/fbnic_phy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab7e8746299..ce18b92f3157 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16712,6 +16712,7 @@ R:	kernel-team@meta.com
 S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/meta/
 F:	drivers/net/ethernet/meta/
+F:	drivers/net/phy/fbnic_phy.c
 
 METHODE UDPU SUPPORT
 M:	Robert Marko <robert.marko@sartura.hr>
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 98700d069191..16d943bbb883 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -230,6 +230,12 @@ config DAVICOM_PHY
 	help
 	  Currently supports dm9161e and dm9131
 
+config FBNIC_PHY
+	tristate "FBNIC PHY"
+	help
+	  Supports the Meta Platforms 25G/50G/100G Ethernet PHY included in
+	  fbnic network driver.
+
 config ICPLUS_PHY
 	tristate "ICPlus PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 76e0db40f879..29b47d9d0425 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_DP83869_PHY)	+= dp83869.o
 obj-$(CONFIG_DP83TC811_PHY)	+= dp83tc811.o
 obj-$(CONFIG_DP83TD510_PHY)	+= dp83td510.o
 obj-$(CONFIG_DP83TG720_PHY)	+= dp83tg720.o
+obj-$(CONFIG_FBNIC_PHY)		+= fbnic_phy.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
diff --git a/drivers/net/phy/fbnic_phy.c b/drivers/net/phy/fbnic_phy.c
new file mode 100644
index 000000000000..5b9be27aec32
--- /dev/null
+++ b/drivers/net/phy/fbnic_phy.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/ethtool.h>
+#include <linux/kernel.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/pcs/pcs-xpcs.h>
+#include <linux/phylink.h>
+
+MODULE_DESCRIPTION("Meta Platforms FBNIC PHY driver");
+MODULE_LICENSE("GPL");
+
+static int fbnic_phy_match_phy_device(struct phy_device *phydev,
+				      const struct phy_driver *phydrv)
+{
+	u32 *device_ids = phydev->c45_ids.device_ids;
+
+	return device_ids[MDIO_MMD_PMAPMD] == MP_FBNIC_XPCS_PMA_100G_ID &&
+	       device_ids[MDIO_MMD_PCS] == DW_XPCS_ID;
+}
+
+static int fbnic_phy_get_features(struct phy_device *phydev)
+{
+	phylink_set(phydev->supported, 100000baseCR2_Full);
+	phylink_set(phydev->supported, 50000baseCR_Full);
+	phylink_set(phydev->supported, 50000baseCR2_Full);
+	phylink_set(phydev->supported, 25000baseCR_Full);
+
+	return 0;
+}
+
+static struct phy_driver fbnic_phy_driver[] = {
+{
+	.phy_id			= MP_FBNIC_XPCS_PMA_100G_ID,
+	.phy_id_mask		= 0xffffffff,
+	.name			= "Meta Platforms FBNIC PHY Driver",
+	.match_phy_device	= fbnic_phy_match_phy_device,
+	.get_features		= fbnic_phy_get_features,
+	.read_status		= genphy_c45_read_status,
+	.config_aneg		= gen10g_config_aneg,
+},
+};
+
+module_phy_driver(fbnic_phy_driver);
+
+static const struct mdio_device_id __maybe_unused fbnic_phy_tbl[] = {
+	{ MP_FBNIC_XPCS_PMA_100G_ID, 0xffffffff },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(mdio, fbnic_phy_tbl);



