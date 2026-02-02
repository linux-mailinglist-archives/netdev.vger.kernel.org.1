Return-Path: <netdev+bounces-256002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBzMC7YDgWnZDgMAu9opvQ
	(envelope-from <netdev+bounces-256002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:06:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C830AD0EB0
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41A9E302AD93
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4AA387358;
	Mon,  2 Feb 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo5nHW2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0D3803E0
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062671; cv=none; b=AdCzqV2mqbjlkaryJ1aV32eBTUqFCjGbMPW1yAnpIUaCXhbmvLEJkkaOie8ATpiKGLSKF4rJYl1J4g8x32qnQ0AsD15cQZSkd6fk0X8oU6LU7yF9Xn72JqKvn3uo1qYM5FAyUdzJwJIhIxkfEWGZaOPOR3opIRLwUblUjerOk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062671; c=relaxed/simple;
	bh=YwpGtXsVOooGRLfc1Rtzs1Qm+0ZUA3CssyiOSg+grvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZGfjlP3RXgcCE7zXc1ajl6+4vaW4kFukFD5Q8MVSa7nzUFh6nK6fzoO/1XI7+ZN49khw9JoR3AglgkKb4c/zMaCITh8OdW6I4FP4rt0TKqgAeUVK2JYrl3YlagR/5G97iKMaRcyCFHstc+b4N+0vUt/EfXMC47tb1JnZ3xznd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo5nHW2n; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-480706554beso52638915e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770062668; x=1770667468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa/bJX/vq1r2SyF6orBcmNNhb6Yq/BQBvk6y6TJ7kn0=;
        b=Lo5nHW2nsWjAEv0DhNZwPUYyyNNqpzdiVlpIZutDMxMQZ/XH5QkHUcbM3/WGYsH6gi
         utGTXrs5Lx3Quoj2tyXwEZ5K3dYzhVJv+a9EVgwIaY2wGhVJ+ZDM2Gp69/tuivIy6tQu
         Kq8K6Fxr5YPZFr8GQ6JGWAXkxQxE25XGhh+A4/yDIS39rjv1oHtGH4p1+Ev85qsyGREt
         tti6J/1BVMfBsVZ0kflMGQ6Qs5yMaqViKBpac1x4p15coVgHOgx3I+O1BX01MPAMT0zK
         +Nuy5LvhH67m+jYe7oWCZOV0T+69WvlUDJEv55u4Y0O/QtIuyUip8sQQN+OVP5xUiW6+
         28uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062668; x=1770667468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aa/bJX/vq1r2SyF6orBcmNNhb6Yq/BQBvk6y6TJ7kn0=;
        b=RqnfEk3xALuS94K2tY7RlM8PMED/ybXa5X1Onoi549YyUa9+dVK5wCHcve2Ob0yrdQ
         vNfiPiM7tPDtsBzx7lsIxbNWLstdaRFY3Eal5zBEMf0UyvColzWdTHukOnOKgJ8c7ZuN
         OztS9bOn9Ecubkgd/KnicVaCt5auOPLPWQNLylok0tvK3lAI5aVTJyEr5wIGkrrpnlkb
         AXTW5tCFkIyrZto+PTPCnf5eIRcRBigg64DSdRUb97kdYIxCn/57M192ojh39kzNZ8EN
         io6NwxefR9dq/S+7XYgVZ34bNzt72E6yoXc9RYkcNodJ47fRMQhqyZaMxqLMPnsBRtrf
         mDFQ==
X-Gm-Message-State: AOJu0YxQYh+5yqAxVP8rFwEVY1tZitibaKM6eRuFZ+odb+Xt/BRFENEp
	QEkvM/xcSwd2zHOfgULvccqmlGDxhg8s8GbQTnbIcjx3mVpMtkyHCXdu
X-Gm-Gg: AZuq6aKfkA/0UaqnhloBy6iW5DKPNS0BiAFGU3bh/FLmMORQ4qMC4v8H7B/SUpyh3RF
	GCKYnsSfCseaSigFiuCyT+jJT3rsLmTnRZMfVJXSGF/TzGjhehfIikCJkKwvQpbYBw1jDmflj9c
	HMJ1VWeXJLW2iElazrqKTSPMt5TszRA9XZMySGwuJFQVr/2L0oZ+FFmTR/6S+xcmuRfjnikDFLK
	jfNs4zmH24j1jV8P8IE7SAK0MMqImh5xOiCBACy8S/oBhkv+SXWOlBkGhuzDkMn5BHfqr/vfvJ8
	rDw5Kb8h3xuVIYEmZ5GSwrjF1RBmbYQ9ji33VHT9UDpRsGqKoTkwCwsqpnCJt/rWBI+KbhtnQjX
	rqVuiCBPfcwUFylRsNZ/gX4huR87PYupsFfbfUdoF1nFh2fRPd1k2eJ9+Om4r+hvwmrQPs8Rpym
	cyVCzXYJJuMgY=
X-Received: by 2002:a05:600c:a08c:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-482db493a7cmr155592385e9.18.1770062667742;
        Mon, 02 Feb 2026 12:04:27 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd3953esm120842955e9.4.2026.02.02.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:04:27 -0800 (PST)
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
Subject: [PATCH v5 4/4] net: phy: realtek: add RTL8224 polarity support
Date: Mon,  2 Feb 2026 21:04:11 +0100
Message-ID: <20260202200411.373161-4-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202200411.373161-1-dam.dejean@gmail.com>
References: <20260202200411.373161-1-dam.dejean@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256002-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C830AD0EB0
X-Rspamd-Action: no action

The RTL8224 has a register to configure the polarity of every pair of
each port. It provides device designers more flexbility when wiring the
chip.

Unfortunately, the register is left in an unknown state after a reset.
Thus on devices where the bootloader don't initialize it, the driver has
to do it to detect and use a link.

The MDI polarity swap can be set in the device tree using the property
enet-phy-lane-polarity. The u32 value is a bitfield where bit[0..3]
control the polarity of pairs A..D.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 45 +++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 85e928a0d3dc..d23672e33432 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -172,6 +172,7 @@
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+#define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -1861,9 +1862,51 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 	return ret;
 }
 
+static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 offset = (phydev->mdio.addr & 3) * 4;
+	u32 polarity = 0;
+	int ret, val;
+
+	ret = of_property_read_u32(np, "enet-phy-lane-polarity", &polarity);
+
+	/* Do nothing if the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (polarity & ~0xf)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_POLARITY_SWAP);
+	if (val < 0) {
+		ret = val;
+		goto exit;
+	}
+
+	val &= ~(0xf << offset);
+	val |= polarity << offset;
+	ret = __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				      RTL8224_VND1_MDI_POLARITY_SWAP, val);
+exit:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
 static int rtl8224_config_init(struct phy_device *phydev)
 {
-	return rtl8224_mdi_config_order(phydev);
+	int ret;
+
+	ret = rtl8224_mdi_config_order(phydev);
+	if (ret)
+		return ret;
+
+	return rtl8224_mdi_config_polarity(phydev);
 }
 
 static int rtl8224_probe(struct phy_device *phydev)
-- 
2.47.3


