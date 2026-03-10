Return-Path: <netdev+bounces-266271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHVzK0VYsGkJiQIAu9opvQ
	(envelope-from <netdev+bounces-266271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:43:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DBF255CCE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88A83215007
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF13D8100;
	Tue, 10 Mar 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewLvNoc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F613D47D9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164342; cv=none; b=bK8dFx/c1OlbrucADd/XMsRdPz5eFbimT0RcI9dkbLj8guaCLyuy2WeMTcnLY+PMPJWulHa840xDmWMGaayhm5fsWNw6GzI7pvQ7vBuElVcD4aMrcQEJOQiBMu4b7dV0FiX25thaD7uRQ4po9E/ov9kxLC22OxI60h+PozjJodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164342; c=relaxed/simple;
	bh=S9MVxUdttG8o05atQZl0YpqlKZSWRqYDbcQVO9DdmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho+m1O14oj35FBtDchyU9qoDKquObBwM7vnpWrsq+BFmBtz86xaNFOp/4dz5mdtfHhLgjx9zPwmE5PFdirDu5xWLm5J1n0SIs/l5Femd+ki6wXIjPs2kB4OfrOYkqrnuQWRpaIlj+aEimhqQWJe1oxgD5nX25JusEVgxmsddON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewLvNoc0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so29871035e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164336; x=1773769136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS709NAGhf0disYguyiNmVG2M10QAbrxgrjPR1Vq2C0=;
        b=ewLvNoc0BThiNen9C9AyQgb1gg5Om0ZAeF3VMLDfV0aRqXZMguH83n2MW3AG0RFZLX
         jOnVERQ03zRqPkFEMLYrPK9at5BUQdrzREQ7s+RBlSgLIASXF5qXib6xpNHxMG9EV0vp
         1GMQ+Pr1cqO+/+rRCHPVfSzzO0hXa9H8Yh2xhV8iHSUVB953jqGVqdmacmarGAxY2GEa
         BFalMKDzazmzF29Fp6KGFnaRxirBc9IN5Qe5ecIETNcCawbKbqIwzgBEa9K7Vls9tYfi
         fD4xzgCFKW2qObmZwHPY8Rk7JT4mKEYx/qPGigJCR3zY3uD3WCCgtfio3L54KySq4OPg
         1Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164336; x=1773769136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS709NAGhf0disYguyiNmVG2M10QAbrxgrjPR1Vq2C0=;
        b=JuoEXvlGljhuW8S/Eu+hlbpWqW8+H8soTCZ7yjQVvA1CE0RaZhTFEjMTrls5g2w1Ai
         ADgMwxH8+oCDTB6/Wl03JpCxQBdBr9D2esjlkJUB2y3AyFZdt3/7Cu1c6Aog9F3RPJia
         PPjef7oBNOdZ1xepMm88q2z8sbszzZ+72D3fmSKuDPmMv2K9qCoBF5MpmDpuq5MGZwAB
         owOgb/Zf6IAaX3dHwpj8lYBJc1IlyDMngCCDLFRb+jqPDelqxjsJcjXFOPr/pwJzBLB9
         B/cJWDFmeSV3Q5wYY6/b5CpM7YcMAH5nqwNbLthRDILXQyKLHZgcffVqauUNpn8WnKWn
         B8KA==
X-Gm-Message-State: AOJu0YxcJanWFWbip/fQ6vRoYjOT/MxVOHQvJMVUxFRTPNhDWBKFPjHj
	zDYADt0juqlLniCalB/l4Mb21Eyv/brq6LmK4NwHu4FBl006mWdGfX3W
X-Gm-Gg: ATEYQzw6y5ld0oK12kgIpm2ZdyYeKPySLLMEOUpM06MBd1D9MFU1NIklDIdQJYHl52e
	P6yeveDDOuRd/sVL6rIRvTbo5Udas4oPNBkgko6b3XuMaoyKAflrgbxrH2V508otwlI9XT0g2pr
	xIRExb3bpvj459a1kpIZebyMEqZZU8sip8wG2hcQ8lSJoeI6OExRvDmvcu3A3jDk1WQ1PN5WuLp
	potsLOg1SynmngGIq3hO9coI19rrh/7B6ZpkI6TogBueIs4JlkA0W5SRwd+RlPqfCD6g+oXz95d
	adtlnsHjHulUX67fzs3lszA+G5wwRnX/Du+s1HDDBn3ZE+sRrJRgJGJn1gBgEkck7YS9SplHMOB
	yNHhZ5OHNBeaiBJbEduY+eWKTGHlWdPFHKLQvkrcELL1Fut8+ufnSh6IzaQuXLrxoLJWSf1NS68
	5IFmfYGTwTi++GqtSrLiDUNIs=
X-Received: by 2002:a05:600c:46cc:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-48541c4e46fmr71576715e9.23.1773164336195;
        Tue, 10 Mar 2026 10:38:56 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a900easm103239295e9.9.2026.03.10.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:38:55 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v7 2/4] net: phy: realtek: add RTL8224 pair order support
Date: Tue, 10 Mar 2026 18:38:44 +0100
Message-ID: <20260310173846.230923-3-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310173846.230923-1-dam.dejean@gmail.com>
References: <20260310173846.230923-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2DBF255CCE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266271-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
index 530b4e26d16e..ee3f7318e933 100644
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
@@ -2395,6 +2448,8 @@ static struct phy_driver realtek_drvs[] = {
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


