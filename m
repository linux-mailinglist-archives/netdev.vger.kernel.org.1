Return-Path: <netdev+bounces-254686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBEAFX8ze2lJCQIAu9opvQ
	(envelope-from <netdev+bounces-254686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:16:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59363AE760
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B54430095D4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF7033D4F0;
	Thu, 29 Jan 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVVErEcU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DC27E06C
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681782; cv=none; b=cLuKzrPQJmfy3QnkEzrwl0fnbLji2AIpS7G7IN3QTuzKkLlnHEIDCPdJ8BHaDOx/tIhVYslndTUS1CG/pIIQT0e0gRCbu+xMwcqkvb3mextJ4RwnPIy4RMSqW3SXQUQv4KPxY9D1HqWs+binMjf65QSKPEBFubdScKVpSpXzurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681782; c=relaxed/simple;
	bh=8k8ot+AK7quELQCYAe1BT4CubsLLtkDchKFjzCCedWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4Xy97rK+YDl74JyG6ByNf/ba7dscnx7pPtBnhX38FeSycd7FchUOg3UP/qZkOhlt9m5R6B1FbyeuuTmGj2nse7w6kLL5rKipOEKhZGgbyKFHITcnZu8MmlqjK4gmSz2cWO9XsmOqcJ077GP6ZfFOuxRVx3O7Lrud7RtRzqIugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVVErEcU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4359a16a400so690799f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769681779; x=1770286579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15APCKiIxeuqVDfA7ICGOpjXKLO10lGgKVaUkFEEdI8=;
        b=GVVErEcUoVfv6wQuZ2OnJpUFd2917emmDMlWvwxxwX+wLP3H5AhrYAeUYgbWzPO39f
         ygtLdrYQMkxrc4eGcndP078OnLCcIW9Yk/Z+DRKMIwkhmkfI1OCtxb26mhNSiKhlTEL5
         A9QhM76ggwEOsnYOKrSyIxsc9nAsx3L3bvUITflgAoijT/KyBvfynYl8HJ/wvZW+cfj+
         JfK33VJTWAxOsGUzWRsXAubh0577aOL+oh3wACPLn4isteScKvDVoYiJlx7bQ7vWf69V
         p2ExQTKPlaWt4Q3gYFMpBplnXvtjRCJ+P/9cWo1ooufObch1SseEkBc0UoHeZfp47SBQ
         bjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681779; x=1770286579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=15APCKiIxeuqVDfA7ICGOpjXKLO10lGgKVaUkFEEdI8=;
        b=QcPtRyKdeaGcQis69La7elRjWjC7BTP5kLV2omCIhB4FUueloZI32P3JtawW5MkgoD
         x5+RJQnS351909xwMhueckAEAaIn871Iuh2saRbQK04NpwmVuZpoeTP8mTt+LOX/D1mj
         9mac/2Scrhl2ERNHAL0dVFUqFTPuU8qPCtT4nTay+cGXoEqdxtDDXkQFaAONJftRdmP5
         lJaMY50dZj/GMiFWknDJ6ACzKU96APQG115n/z/P981PMbI78Lvmo14ZsZw/OCZ7WdUA
         XLx1QdpTKYc7bdCPe10BvCg/2brJtm3U8H/MOp+G0XWoC5bqJLGzHmQXfMWG/GNFXWfe
         LCYQ==
X-Gm-Message-State: AOJu0YxAnTfkzELi2lcmgjnVzkAUew7v9oODEbQ0JfWtylOpM1E/Ed4Q
	cepXhHyw5FINnm+POYzV4pwAIjjuOiIbqgROuxWk9rnDAsCY4rwhV2FMC6Xhgw==
X-Gm-Gg: AZuq6aILQQMOA022L7bfIzB86Avidd31Oo39M7LpdU8yduUQYG+1rH0XEJfvSbObbxF
	3bHqtXXpBIOk4qdiADc1zInfqhmYNIRD9h2T+vaI33v6RnrAh1pNOYWWYaBx28ZJyJ5qoMXGwcc
	GO1B5jZVACXIE4rvVwLmVDdiJWsHB1s31LwT2JJ9PsymlqrIQGqvNNEeiXj3xm06nnR2acDmLG6
	7fWozRH71PADiB81hIsdIkqzoEI0OQnavFUHhDqwGOxfr63Il9wyHTKU8MAtvsE3gY+/M6LKQwj
	/4ydMOBfe+FwworVatfocgbrOKjdEnuGsV9T8+oS9A3vb1NAXO9fxkgdKbmyU4OmsanfxZ9hxaJ
	SPvyHUArRVtLjwdOU5u0Y8iJY2ZjdkBaSlpIYFgvLrQNW6xBfXArtTsUmXH4lQdKdqtAjfP9AW/
	CFZIQ9upyqXIc=
X-Received: by 2002:a05:6000:2012:b0:435:bd00:cb4 with SMTP id ffacd0b85a97d-435dd0737c6mr11799323f8f.23.1769681779368;
        Thu, 29 Jan 2026 02:16:19 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132303fsm13413662f8f.36.2026.01.29.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:16:19 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v4 2/4] net: phy: realtek: add RTL8224 pair order support
Date: Thu, 29 Jan 2026 11:16:04 +0100
Message-ID: <20260129101606.33972-2-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129101606.33972-1-dam.dejean@gmail.com>
References: <20260129101606.33972-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254686-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59363AE760
X-Rspamd-Action: no action

The RTL8224 has a register to configure a pair swap (from ABCD order to
DCBA) providing PCB designers more flexbility when wiring the chip. The
swap parameter has to be set correctly for each of the 4 ports before
the chip can detect a link.

After a reset, this register is (unfortunately) left in a random state,
thus it has to be initialized. On most of the devices the bootloader
does it once for all and we can rely on the value set, on some other it
is not and the kernel has to do it.

The MDI pair swap can be set in the device tree using the property
enet-phy-lane-order. The property is set to 0 to keep the default order
(ABCD), or 1 to reverse the pairs (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/Kconfig        |  1 +
 drivers/net/phy/realtek/realtek_main.c | 49 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
index b05c2a1e9024..a741b34d193e 100644
--- a/drivers/net/phy/realtek/Kconfig
+++ b/drivers/net/phy/realtek/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config REALTEK_PHY
 	tristate "Realtek PHYs"
+	select PHY_PACKAGE
 	help
 	  Currently supports RTL821x/RTL822x and fast ethernet PHYs
 
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 75565fbdbf6d..79c2762b610e 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -171,6 +171,8 @@
 
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
+#define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -1820,6 +1822,51 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return rtl8224_cable_test_report(phydev, finished);
 }
 
+static int rtl8224_mdi_config_order(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 port_offset = phydev->mdio.addr & 3;
+	u32 order = 0;
+	int ret, val;
+
+	ret = of_property_read_u32(np, "enet-phy-lane-order", &order);
+
+	/* Do nothing in case the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (order & ~1)
+		return -EINVAL;
+
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_PAIR_SWAP);
+	if (val < 0)
+		return val;
+
+	if (order)
+		val |= (1 << port_offset);
+	else
+		val &= ~(1 << port_offset);
+
+	return __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				       RTL8224_VND1_MDI_PAIR_SWAP, val);
+}
+
+static int rtl8224_config_init(struct phy_device *phydev)
+{
+	return rtl8224_mdi_config_order(phydev);
+}
+
+static int rtl8224_probe(struct phy_device *phydev)
+{
+	/* Chip exposes 4 ports, join all of them in the same package */
+	return devm_phy_package_join(&phydev->mdio.dev, phydev,
+				     phydev->mdio.addr & ~3, 0);
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -2392,6 +2439,8 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
 		.flags		= PHY_POLL_CABLE_TEST,
+		.probe		= rtl8224_probe,
+		.config_init	= rtl8224_config_init,
 		.get_features	= rtl822x_c45_get_features,
 		.config_aneg	= rtl822x_c45_config_aneg,
 		.read_status	= rtl822x_c45_read_status,
-- 
2.47.3


