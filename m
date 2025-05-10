Return-Path: <netdev+bounces-189449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78054AB22E4
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218DA3A70D0
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C71EDA0E;
	Sat, 10 May 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlUz5FBU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EC1E9901;
	Sat, 10 May 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746868961; cv=none; b=S1NB+Uwcd4GAOvIV4sve7Xpa2p7hZYFYm3MpkcGVME+2k6GVRfKEO1XuAve+HhQ5sgQ6mjrUsvYLyIpQtQR3PzF/XsDwwwrxQyWwUoHT7RZmYv8lDkMVfovWiHtRMfzu2u/4P4IrqF1NRx1RIQnr28ZOg4VuQ8v7BdxErhnPuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746868961; c=relaxed/simple;
	bh=inV0RfRccOu6V+1k6bacnU/OZqds2ZuOK2S735pm+GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzvTuFmEnR2oLDeuIlZqW0Rbf58Cd9ZxlekXkJWW8wfRVoSs0pBlBh0OySXL3ePQ84S4oRjbubojlreevNFUrdR0Qp3B7ZlAeUcp5WOFD11mubSRfnAQAxpMXPacNYd0X5oVFLCeUhvMMASEA4/ncuAY9iAlOCjyVHtfMwMr21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlUz5FBU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fc8c68dc9fso5148645a12.1;
        Sat, 10 May 2025 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746868957; x=1747473757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LwVXbI/uaImz8Mia1ZxOyXkkvE03E1h6lfweWlCf3c=;
        b=QlUz5FBUW0ObBel7or+bu/OEOEWFBRmq/dj609FtrK6ZsVp+DrxYnJrir6Rr9bHtv1
         RBHQXWsha1j5uuQy3lfkjb1WXwGrw/VWzwMmCipWwauXvV3xuKocnFh9V6XmUeUeNFwS
         efnA17SZ43S0hPhB5ngwTi7cTA2vrskQrkBKL94M45vJ4jo2ZauxYZP25phKDl/3yfIn
         Rvdmxf5xZZlUNCddh3owwED5/ZNISrPIUyPfXTcMVZLG5vvm6EFC1uAnTOTo3SbEexEQ
         2+3JwRpY8Jn9NSt1mf9uRlD11BheVwhNlk1TyQkzFX2HIEemhmawRZ/Dx8upRmjzgMZh
         sYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746868957; x=1747473757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LwVXbI/uaImz8Mia1ZxOyXkkvE03E1h6lfweWlCf3c=;
        b=J8gy3dyV0UVwRIomwJsq0uFcmOh+ho0HIJ/tYEFqG7OZUowXcuj9c5YznklqJOI0sv
         7HmVV9EoLT4QTJ8e9jEQlIvLGDc1UUfjGsAxMXGJYjA9XcUiJkpz/iZ19KBDDrESt3x0
         Nm8I3pO0asUVE/2L5/W63C/V4lwp5611kLrOaUmecPJduNCH6+kUo2Uc4Kh8Z+3UNZ4D
         lJNu5FqOboUYa7tY9jkEKkS4J0Wc1u50WTwuaMxP78c7PNnGaemAbeKF5zTDctQUeu5t
         CS0Q4mYOyIWrDqAr3h1hGKF0w0+fHv1NysGgeGDb2uPHyfEkWSf07qhYUxYHpUy3bNAz
         RWYA==
X-Forwarded-Encrypted: i=1; AJvYcCXNiBJJKK+3+Q3G7MPFHvVgsLD6iugBr4OSuBFgKj1WYVIdeHgvnI59CLZjCArNdGF8XSBORbKUT5xWpvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYUd/jL++39SZLUKtK5OKQvA6lm0Fdfj4GA/K2Pg+RNVX+xya
	dAl5ZjO0DH2MNrD0afGk4h+uz24+R1QleChtg1fyacN0eYY+rlX1
X-Gm-Gg: ASbGncssP1hfLx8B2fh5VvsoRLxGDEjTv+nd+UcUvqJ/oinxV30WcYMFphjck2601pm
	XKtahFw72t1Q9OQ7YBglBgmg+Bq00Pom00axDkbbVJRzqiW0TBTX8aY2KPrADomrAYCAb9dIziw
	c9QvkxhON3wOcarIXxkM69CzpCaoF/mGnvwFvKvi/6W/jd4dp99eXkrE7nKo6WZ3/J77BwCrXMs
	ptDD6TiygfaxqsmqE5DJGSEFdjewbnCp/DiBRrrQDQ4ldO98u3kANXGTGYcCu9RsuB45UBmEszk
	I8EHw4tES8Qwy9K04DPuLkRaUBI++VfrbIQbTyBP1cuUxKSar9rkPKA7cSI6SVUchFycVSHcXHV
	dLSeEwfakf0ZuIozHkhP/rPlvtJEJTq6kbHBSO/b7cA==
X-Google-Smtp-Source: AGHT+IEAh+Cd49qeeWCkpvlkc1ALXf2DHLU4upT+4OE22rHLh1z9xQl0vI1i+IoUeb/AHRE96Bl/FA==
X-Received: by 2002:a05:6402:348f:b0:5fa:9222:e875 with SMTP id 4fb4d7f45d1cf-5fca0792de0mr5385001a12.18.1746868957161;
        Sat, 10 May 2025 02:22:37 -0700 (PDT)
Received: from localhost (dslb-002-205-017-193.002.205.pools.vodafone-ip.de. [2.205.17.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm2643188a12.12.2025.05.10.02.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 02:22:36 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: b53: implement setting ageing time
Date: Sat, 10 May 2025 11:22:11 +0200
Message-ID: <20250510092211.276541-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

b53 supported switches support configuring ageing time between 1 and
1,048,575 seconds, so add an appropriate setter.

This allows b53 to pass the FDB learning test for both vlan aware and
vlan unaware bridges.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
With this and the standalone port isolation patch applied b53 passes all
test from bridge_vlan_aware and bridge_vlan_unaware.

Fun fact: According to the BCM53115 datasheet its default ageing time is
300 ns. Luckily that's just a typo.

 drivers/net/dsa/b53/b53_common.c | 28 ++++++++++++++++++++++++++++
 drivers/net/dsa/b53/b53_priv.h   |  1 +
 drivers/net/dsa/b53/b53_regs.h   |  7 +++++++
 drivers/net/dsa/bcm_sf2.c        |  1 +
 4 files changed, 37 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9eb39cfa5fb2..2cff88bc7a1f 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -21,6 +21,7 @@
 #include <linux/export.h>
 #include <linux/gpio.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/platform_data/b53.h>
 #include <linux/phy.h>
@@ -1175,6 +1176,10 @@ static int b53_setup(struct dsa_switch *ds)
 	 */
 	ds->untag_vlan_aware_bridge_pvid = true;
 
+	/* Ageing time is set in seconds */
+	ds->ageing_time_min = 1 * 1000;
+	ds->ageing_time_max = AGE_TIME_MAX * 1000;
+
 	ret = b53_reset_switch(dev);
 	if (ret) {
 		dev_err(ds->dev, "failed to reset switch\n");
@@ -2373,6 +2378,28 @@ static int b53_get_max_mtu(struct dsa_switch *ds, int port)
 	return B53_MAX_MTU;
 }
 
+int b53_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct b53_device *dev = ds->priv;
+	u32 atc;
+	int reg;
+
+	if (is63xx(dev))
+		reg = B53_AGING_TIME_CONTROL_63XX;
+	else
+		reg = B53_AGING_TIME_CONTROL;
+
+	atc = DIV_ROUND_CLOSEST(msecs, 1000);
+
+	if (!is5325(dev) && !is5365(dev))
+		atc |= AGE_CHANGE;
+
+	b53_write32(dev, B53_MGMT_PAGE, reg, atc);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(b53_set_ageing_time);
+
 static const struct phylink_mac_ops b53_phylink_mac_ops = {
 	.mac_select_pcs	= b53_phylink_mac_select_pcs,
 	.mac_config	= b53_phylink_mac_config,
@@ -2396,6 +2423,7 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.port_disable		= b53_disable_port,
 	.support_eee		= b53_support_eee,
 	.set_mac_eee		= b53_set_mac_eee,
+	.set_ageing_time	= b53_set_ageing_time,
 	.port_bridge_join	= b53_br_join,
 	.port_bridge_leave	= b53_br_leave,
 	.port_pre_bridge_flags	= b53_br_flags_pre,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 2cf3e6a81e37..a5ef7071ba07 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -343,6 +343,7 @@ void b53_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 void b53_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data);
 int b53_get_sset_count(struct dsa_switch *ds, int port, int sset);
 void b53_get_ethtool_phy_stats(struct dsa_switch *ds, int port, uint64_t *data);
+int b53_set_ageing_time(struct dsa_switch *ds, unsigned int msecs);
 int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 		bool *tx_fwd_offload, struct netlink_ext_ack *extack);
 void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge);
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index bfbcb66bef66..2f7ee0156952 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -217,6 +217,13 @@
 #define   BRCM_HDR_P5_EN		BIT(1) /* Enable tagging on port 5 */
 #define   BRCM_HDR_P7_EN		BIT(2) /* Enable tagging on port 7 */
 
+/* Aging Time control register (32 bit) */
+#define B53_AGING_TIME_CONTROL		0x06
+#define B53_AGING_TIME_CONTROL_63XX	0x08
+#define  AGE_CHANGE			BIT(20)
+#define  AGE_TIME_MASK			0x7ffff
+#define  AGE_TIME_MAX			1048575
+
 /* Mirror capture control register (16 bit) */
 #define B53_MIR_CAP_CTL			0x10
 #define  CAP_PORT_MASK			0xf
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 454a8c7fd7ee..960685596093 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1235,6 +1235,7 @@ static const struct dsa_switch_ops bcm_sf2_ops = {
 	.port_disable		= bcm_sf2_port_disable,
 	.support_eee		= b53_support_eee,
 	.set_mac_eee		= b53_set_mac_eee,
+	.set_ageing_time	= b53_set_ageing_time,
 	.port_bridge_join	= b53_br_join,
 	.port_bridge_leave	= b53_br_leave,
 	.port_pre_bridge_flags	= b53_br_flags_pre,
-- 
2.43.0


