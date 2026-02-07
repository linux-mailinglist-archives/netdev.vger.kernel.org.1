Return-Path: <netdev+bounces-257747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHwxBEEFh2ngSwQAu9opvQ
	(envelope-from <netdev+bounces-257747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 10:26:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C4105562
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 10:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 864AA302158E
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FDE30F526;
	Sat,  7 Feb 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dELeeCst"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936D2FDC26
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770456352; cv=none; b=i7yVbZ0zd4IVEBZFr/0gKeVmdSDy7fUQSESSfXUpPCZxRx8r4GHNLFTkK4RsJkc++Rzi8pY4rNzb1+iHxsU/ZxcjPKjpujvvPSSc+KqMqEitPGaGHPue3RcZtveEw+WiTONbgbhspzH5LoFx4gxXpxpJpq6npOhUuz6oeGe+Ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770456352; c=relaxed/simple;
	bh=RU92uS+DYv5bSLkinoz7UBqkLFdl0Unma/HtnFQ0nEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhSIAk3WCloMH8yl8bx6B7rRO52g8GVOs7AOGoRFg833GZjKhZt2ymkQQokDmkszHU85XzX9axcPuYIqixsoDLRYig9EJwu4MtUX7dHfMLLeTC1ZGzGXu/Y6/cRYblg3apCt6R8uIHH2FnvyG1J1ndKsecZuCSY2p123pL/zOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dELeeCst; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so16323245e9.3
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770456351; x=1771061151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UtSzjb69Xa+hs2qYvlVH5KlrXvEWqJEp4fy3uEo+g4=;
        b=dELeeCst4UuDJI0g0CyGVwnnU27eEjk9ym/RyRg9hH8jC4KoClI46fnVx2sl/uRU6C
         nlu6OU93Pkm1l5jeMpu8USFNuGJmIn8WI8qOZvpVCK/cgrfN7dlhe3mz7iFAFI2UDoWt
         DVzCnNsv7yjUfC/gUhECNTrj8YUS5Y/7afY1KHnyE9peAEl6QSqwzypF0l0Z1JZnOMNq
         3BSOXnW6ghXrNiEEWYse9EsxCXoHntQZwsWZbl9W03QpFkU5p6JDiNEk/xNzwH329MEZ
         4khRjWgsdxfz3si2P5e911fUdjN/YMBrL8BKIxNlc20OXDuGWFipESxOYbukixNMyf5r
         41IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770456351; x=1771061151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UtSzjb69Xa+hs2qYvlVH5KlrXvEWqJEp4fy3uEo+g4=;
        b=CLzjNSQLRb5TnL0XbKre7ftpmXlwjcIJ83IJbTDscUsJirc13gsW//ZYd7Qe2gKO3M
         8UFplI9EHwlHQmCYs7kIS57a3R2QrqjF72V8VXLhonVn1JX60oZ0+Z71JQ0E2wua8wb3
         Igu8OTD9JIAohN0KS2fxsb05g8pDyUy96ZRhuGBFkJ9FI2kAgl5XKRqsYvuZYuK9VsjS
         ya/yqiuVslTrOLog2/A6KR7+uaZzsJrDIK55qvtbZ+PFOe45ZcYiHsMo07gD3F1Zxjis
         5YvN0LofCcXkoaUVsX5XRuEU70epFHQkytG3GgsGjvx8hpkTYE26IHD3ZiV56hHUMfKr
         LUIQ==
X-Gm-Message-State: AOJu0YxBBB7m8aEQbSkHLY5gTiquMYaMnmVNits2swBATrF0YIPWFLKw
	yr6PyL5B7BNldyadBs6ZpKZbTEVXMXUcYcovyj4LlsqMOhGzUFX2F127
X-Gm-Gg: AZuq6aK9hftuof6eSt8PK8dRGLL/yYN968atrtYHBi7ZOCKJhrNc61IrHofLy30jkwe
	7YxOcL3ACBsKOYkiFQ6jwhsbjRzxgqFb0eBIEQb9jdvRoK9GvsgEdf4it72lZRdepT4ECRgmzvW
	Xyd97uEHyrrB28pd5so7uqpLl+08G5jKZ9F2b+H+kK0zaoRbQlTDyl5+5uHFP0JR4k36yBDM745
	iFgQjGIm70yI2e7LX/2heVAOkHGoNpMv3nXGv2FDk0DT8ULKv/Za1hqkIprdZSyei7b/Lhr6k3x
	0HSjglLniD0+T4DgQfCDrgBX2rEl6ytNhQOTM7fu18+nFD386RtAiEpzRf5W4Z0NVXC+JYWUfp6
	Eozz5jrHRrJFaJtjFhKLGIegsVvEIREaYJnNjzlO1HKKrK5/UC0GeNegIxsqDqIB3a9p5qEt5cw
	C+iY2zyXDu5x0=
X-Received: by 2002:a05:600c:314a:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-48320226715mr65253035e9.32.1770456350495;
        Sat, 07 Feb 2026 01:25:50 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320736953sm101034545e9.15.2026.02.07.01.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 01:25:50 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v6 2/4] net: phy: realtek: add RTL8224 pair order support
Date: Sat,  7 Feb 2026 10:25:37 +0100
Message-ID: <20260207092539.647768-2-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207092539.647768-1-dam.dejean@gmail.com>
References: <20260207092539.647768-1-dam.dejean@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257747-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 741C4105562
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
enet-phy-pair-order. The property is set to 0 to keep the default order
(ABCD), or 1 to reverse the pairs (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/Kconfig        |  1 +
 drivers/net/phy/realtek/realtek_main.c | 55 ++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index 75565fbdbf6d..4f0c1b72f7e0 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -171,6 +171,8 @@
 
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
+#define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -1820,6 +1822,57 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return rtl8224_cable_test_report(phydev, finished);
 }
 
+static int rtl8224_mdi_config_order(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 port_offset = phydev->mdio.addr & 3;
+	u32 order = 0;
+	int ret, val;
+
+	ret = of_property_read_u32(np, "enet-phy-pair-order", &order);
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
+	phy_lock_mdio_bus(phydev);
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_PAIR_SWAP);
+	if (val < 0) {
+		ret = val;
+		goto exit;
+	}
+
+	if (order)
+		val |= (1 << port_offset);
+	else
+		val &= ~(1 << port_offset);
+
+	ret = __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				      RTL8224_VND1_MDI_PAIR_SWAP, val);
+exit:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
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
@@ -2392,6 +2445,8 @@ static struct phy_driver realtek_drvs[] = {
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


