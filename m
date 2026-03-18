Return-Path: <netdev+bounces-269193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAFtNH0fu2lofQIAu9opvQ
	(envelope-from <netdev+bounces-269193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:56:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA72C32D8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDB431947DD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D6C36680D;
	Wed, 18 Mar 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex37gTtX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C8346795
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870910; cv=none; b=HE1cbgB92YDw+HP+wUt5piR494JTHVMtTir/sCSXba9VH+f35iEpRZcXzOLgiQg3O4owMEaoDOzW5bt3fd1jjoELTbwXgtqNSsKAFtHV3+aIyhT2tG3c9u29MbwDKcoPManSB12kldnvAZqGulK9dlrTXmwKw0ygd4Ihs/Z/Sh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870910; c=relaxed/simple;
	bh=S/RhJnzS81TpYiJxm8RqeCtmAiLI4W6UmQTEyLwMEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjaKsSC1FaYCXD1mCDjhcjML/pi+Yfm83ZYG0zeQacAN1AnffhcFrh+42y75dopjmElxSNuv6kGK3WSdsoM7NYE6694f4cEWT/Weiju5aSPKzgEcbxrQWmFV+g2ZPZCY81dzEky1Rvients9O/VXGlOdBbesEMABebCdrtNYsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex37gTtX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b7c2788dso181756f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773870908; x=1774475708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxnQrg34XYw02BI8HXDNaula82Z0PNll3rpcD4G9L3I=;
        b=Ex37gTtXlhOk7aFwkufSdEGoY8E6h9aKKsKtARjASDkWDuNWq7HjOLJfdw1am50CIz
         b4Qu4EnWWl1ghUZ2tCpYn+aHZWgSeFl9q0CSAitTwMXiyppM6FEzzn4SJIjTvZfw7lCA
         UMpjIZKHLpdKl5ZQsA+WuNDxcBIljWUPlEEuGgzOqHi3Sciageev43K8mIQilXE3svJF
         G1JG0IkmY3e/l/suduJG3BnnE/brLzycZMui0gK9N1D9/0AQiJVhbOQ+cZJ8GS4WRru2
         WiNPKToZTGkrFaiyoCmgFW5+h9WHIuEK63/xEiXyRHOI/IphouPjeb0gQimwESVtx4hj
         baiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773870908; x=1774475708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxnQrg34XYw02BI8HXDNaula82Z0PNll3rpcD4G9L3I=;
        b=ShExUQbqZiSJQiY8SnXyhhZPVNz6YWPTNNMfulU11a4XFn1YPKsdK9aVMkbIEQN1VC
         z6weskH4Z54vZgyXYTuQvn3giLLeGjMv1+VepVYWj1+mq41rOWTIW5aU7r1FBWgS5sNf
         fxMjJ3cRQVU/p0hBpY3JsQI21PV0VyZ78ug2woxXoctrgB1X6o435CGJ5KjDWgP9YZBn
         wl3dKSpKXk2LuCvbL8EgA3ZDBUd2/wA+XSlqh5NNPeNBevl77aBjBvPL3hJMR34M+RlS
         vkKt8wwvzRDm0CU93htbvfCREL3OjdZ8QMy1hXbuGXw8pX+ryCHxYhWOk/sysAAkVHsW
         A+Sg==
X-Gm-Message-State: AOJu0YwNp3+DKaDYUfMaLq30xhElP5xREfNg30dJsOmbMgK5bkZ/w+Rl
	iO+fOh9HikP3ydJnEyhvttlI0E9TIn1tklpReSg61EOaZnzLBCofVaiq
X-Gm-Gg: ATEYQzx0BhPTC0CNuFz+BgOhbort6tb861YCJvcd+FNHSZDsncueWX3h5QBr5fSmHQP
	HiqmqqyVSdTovs9eVImNczhwNXoYJ5ttxn1hVOlATb9/YjI97dopdj7cr8aCSGuOOrEDoOy2Ygc
	7xjg1AQ6kLRzna1xz8AzSP0VRgoAUmE35XXVZN6zXtCxwAWxsctkz/jorm0F23M0kNtCezaZP+N
	uLptzL4hVrr69293eOU6cW5HU83oARZJ9z2scYB0yjeUnLMt9Sc5XxRkyzGR8eBGBmlOfN+YzuS
	Ivut+P8ce7rtQiEuGeSJbJGqReqG56vXdQ0WF9A4pAyBPOvU2pq8TU/NeW6ARJEMb6n3YRvY5JH
	8+EBoj5XIlRMhz2PzQLYbYkyFjj6BJAiSvKeaeoIqSW99xwNRiLCeh5oia5+wvFRN4+HQ6aH6UR
	EQU/lYX+z6KU9ywJYNeBUCpSw=
X-Received: by 2002:a05:600c:c8f:b0:485:2ce2:4c75 with SMTP id 5b1f17b1804b1-486f442206emr92342215e9.1.1773870907488;
        Wed, 18 Mar 2026 14:55:07 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e10:c662:37ff:fe09:94df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c292e2sm19373735e9.2.2026.03.18.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:55:07 -0700 (PDT)
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
Subject: [PATCH net-next v9 2/4] net: phy: realtek: add RTL8224 pair order support
Date: Wed, 18 Mar 2026 22:54:59 +0100
Message-ID: <20260318215502.106528-3-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318215502.106528-1-dam.dejean@gmail.com>
References: <20260318215502.106528-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269193-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.775];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35AA72C32D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/phy/realtek/realtek_main.c | 64 ++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

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
index 530b4e26d16e..63134e300c33 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -171,6 +171,8 @@
 
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
+#define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -1820,6 +1822,66 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return rtl8224_cable_test_report(phydev, finished);
 }
 
+static int rtl8224_package_modify_mmd(struct phy_device *phydev, int devad,
+				      u32 regnum, u16 mask, u16 set)
+{
+	int val, ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	val = __phy_package_read_mmd(phydev, 0, devad, regnum);
+	if (val < 0) {
+		ret = val;
+		goto exit;
+	}
+
+	val &= ~mask;
+	val |= set;
+
+	ret = __phy_package_write_mmd(phydev, 0, devad, regnum, val);
+
+exit:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+static int rtl8224_mdi_config_order(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 port_offset = phydev->mdio.addr & 3;
+	u32 order = 0;
+	int ret;
+
+	ret = of_property_read_u32(np, "enet-phy-pair-order", &order);
+
+	/* Do nothing in case the property is not present */
+	if (ret == -EINVAL || ret == -ENOSYS)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (order & ~1)
+		return -EINVAL;
+
+	return rtl8224_package_modify_mmd(phydev, MDIO_MMD_VEND1,
+					  RTL8224_VND1_MDI_PAIR_SWAP,
+					  BIT(port_offset),
+					  order ? BIT(port_offset) : 0);
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
@@ -2395,6 +2457,8 @@ static struct phy_driver realtek_drvs[] = {
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


