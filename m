Return-Path: <netdev+bounces-257749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAXCFYUFh2ngSwQAu9opvQ
	(envelope-from <netdev+bounces-257749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 10:27:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D3105595
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 10:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D6EA305C8BF
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D72314A78;
	Sat,  7 Feb 2026 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdFX7HPz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8C313E03
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770456359; cv=none; b=g4PeOjJIuKrOh/GzkE56LP7vRlsVQmrwxsS5v+qLBWSG6JZGp3FMUjU8bcFq2b5r9lGIaV7z6jI6sG7zfAuIMWxigMaY0dcpKD+D6NHXAH/0L3SZh9qxanUXnrFZ5UhE9b7qEAkkIVLXpv0n1ToA60SBvVqZTENS+18Hw7FZhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770456359; c=relaxed/simple;
	bh=VLhfHU49/sVD+E+rKGFLO7SNCPUGAYJdmnDJ7ys9UAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGpLEQm/ibWiIAxOlAUuy5VesDGr5Qo0IcmRHsYgW3Bl+WmmoShuz4ZbqJNnLMmrJfWrqifkHTGVDai2ZRisKZ2x57TDPtlhJQYXGnZhrRHSbkkNz7MtzraU0i1+SurKO/oa7ITnGYBgweDf7RoyfHPoWG5GyT50KuJ79SzGFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdFX7HPz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so16323855e9.3
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770456358; x=1771061158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXLmd+729jnlUoLtywtl8ZxICj0z/tD03OuaZjPPv9g=;
        b=TdFX7HPzEwmKkioxuo8gCmIDZTFukxw6dkA+LTjfJA07j5NU6SSnkW6doATOlh+ctY
         0PHUPgkFVzOSY1hnLKiwa7Tv3zs+J4pg/7IDWG9nSmvJmeKKskIaHI6tmA8iY9HNH6Dm
         Vq/JXCrpKtl881DAZWaK2SYvCIiZicKQ6kT8jhJykJUlgpOYE/T03DaWdAXHvuexbv6H
         VIIl6QFTp/xiDq121LJ/DFdtNOyV+2UYmSZlbX2hzm3Qd+L9MMWXWwHLeQ6l84XG+R1/
         wYUJJmyL/HdrQ8SckyWPyBenj+8ndFLXbr5FtNkcl3p0QOtg++HP6OQNHPKM6Qxtx4L4
         nd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770456358; x=1771061158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXLmd+729jnlUoLtywtl8ZxICj0z/tD03OuaZjPPv9g=;
        b=DQsjcI/DdbBxrJHZ/7ThDEmWr5CBrCGQGtzubKc228NSXspWe7pg1PX0TyfkKtzcTg
         b9bT1RbP7+BfXNzQ9TrxmB8AeyZTiYaIThcWu+Bq6c1IMPgaWtLhjJNBNGinyewJOSAp
         AulH8ulVFfK3FgVDKnc9IXjjE66MK/MNhn9Hquh5kLW6/qkrs05hn9VMSoyDL9ceUr3h
         C38tVLQXfC6IWHkE6oT8vI46zN6qPX5LY7UdHYXYNbUhqwJUba6KcD15cICP4MIVNGRl
         yjWx5KF0Vt+fsp43FWg/tDvgWGmdK8Ac4y66okXQQtn1VwoRMmzduqk4yARnlOLxkxPN
         Kilw==
X-Gm-Message-State: AOJu0Yx2pffbela6+gDEuzppMcjrp17xy5oXV6/57G/y0vGI8yx+IXEG
	BCVVD18hBwn51lxzCIQqKtr4uQkPVd+cOrTJuNCiPCW4Q5VQUmYZ+tji
X-Gm-Gg: AZuq6aJQyOejlar+XBkIUePsg393U9e/teQIPgAj+bdtLOyOXDzItSJuTEmfSeKhhvD
	g6H4LhelO5aAAryxqOxuJZ4voIhH4rKjpw8QqVa1aqaMVTAMo0NU56iQsaemkN0zDULqBaYk3bb
	ATqR04eJZX0MxhCG5R+mm9RIyoxRb1L2IGQ0glsfw2TU2/fSb9Vr0QkFth8kWE2UlXuCQzzzS1J
	fvl7myHOx+IEJPBAkEf/K+dB/gPgcnXoYxlGMy+cavoUGMNYQ/nfgBRsoJq9Z4FPUP5ktCRza24
	hGlQgPqqyKJvoTSDeTNk8p5EuR+YBGroqIZlQ0OafzXLlrog1o3bSC0cXQB3a7hPMefa4AFnkwo
	Tt0nXmUxalZ5xXA02J4xdq2KFUU3cBgWWvPtmwjRANtObKbUwiLwvhWIB6oyvd5Z6HNsxSBuH1H
	7DsyiLSf2jk34=
X-Received: by 2002:a05:600c:1e0f:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-48320212d90mr70777775e9.23.1770456357605;
        Sat, 07 Feb 2026 01:25:57 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320736953sm101034545e9.15.2026.02.07.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 01:25:57 -0800 (PST)
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
Subject: [PATCH v6 4/4] net: phy: realtek: add RTL8224 polarity support
Date: Sat,  7 Feb 2026 10:25:39 +0100
Message-ID: <20260207092539.647768-4-dam.dejean@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-257749-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 143D3105595
X-Rspamd-Action: no action

The RTL8224 has a register to configure the polarity of every pair of
each port. It provides device designers more flexbility when wiring the
chip.

Unfortunately, the register is left in an unknown state after a reset.
Thus on devices where the bootloader don't initialize it, the driver has
to do it to detect and use a link.

The MDI polarity swap can be set in the device tree using the property
enet-phy-pair-polarity. The u32 value is a bitfield where bit[0..3]
control the polarity of pairs A..D.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 45 +++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 4f0c1b72f7e0..d15d3b41e5d1 100644
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
+	ret = of_property_read_u32(np, "enet-phy-pair-polarity", &polarity);
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


