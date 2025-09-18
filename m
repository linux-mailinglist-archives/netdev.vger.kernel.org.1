Return-Path: <netdev+bounces-224571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A0FB8647C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59421CC42C8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6703195F9;
	Thu, 18 Sep 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wBVSRMiH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AE31A81D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217212; cv=none; b=tBINLgUXG7S1iG+tv1DR4BF4OnncdlfobBi6gDwXd1P9/VSw/1cSMG3voz7+r4i1ON7LpDZTb/1J1UTg/uEOZyGFxBiqKXl/NW3zc22jrA9JaGqy1oEwqPR/RAJPgA8B0ISmITUMPU+bDSvebGuwsGeGDj8sEPGu+8Vomi5XOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217212; c=relaxed/simple;
	bh=43Yu8UrBVXYba7kW52JNUj3B36EB++X3EMpkdZKPJQU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=UmlsnECkDAauOxeTH/d401GFpjgJYQbDYzMdg44Q6IJ6J8CgqYtNdU8qUhG/WY3W+MKokTl2S9VFE9bZ2a0NNBQQU6haYO3GvG/mFSGHfB7LDTtudDYcflaQkoi1Rdn6Q1M9H41I5frf09PzrYQYBW9Ze+sRWIaLFjos5cen+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wBVSRMiH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tf54Gr7QsylIBwWG++4g2Fy/bmMFN7kCA1LKAFxuv4Q=; b=wBVSRMiHfKkhgzy8i1W+0ebaLG
	3JvcqcUJANSHIRfa3r6Q/hbO1GkqyinyZidRnMrYDjdjVmCrdbA4Re0e45l5o7Xo1W21MwJLRxCiz
	5oquodN35nSQmDM1s7+vKdgL4GZXiedW/iv7Nw9S8ZZy3K4VBeeX1si76VwrxqhqHaLxfTmJlSy8M
	XEZPr5Hxb/AABxaR8q24/LrNDyIuKQ1Lg3ISOsgI/Y0IgYFY1dR1OlVOQFEpda34SqLYCOWemOPNr
	hNahsUSNjGOuSKCoOMDL5pZuufPJ1/MdAOpu2MQJM52YlqLNIVaIhwfteakZqTenqhwVs96EjUL8i
	lKmjy+tQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48436 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIc0-000000001d8-20wi;
	Thu, 18 Sep 2025 18:40:04 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbz-00000006n0Z-237i;
	Thu, 18 Sep 2025 18:40:03 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 14/20] net: dsa: mv88e6xxx: convert
 mv88e6xxx_cc_coeffs to marvell_tai_param
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbz-00000006n0Z-237i@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:40:03 +0100

Convert the coefficients to struct marvell_tai_param.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 40 +++++++++++----------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 87a45dc6b811..acd17380e7ea 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -16,13 +16,6 @@
 #include "hwtstamp.h"
 #include "ptp.h"
 
-struct mv88e6xxx_cc_coeffs {
-	u32 cc_shift;
-	u32 cc_mult;
-	u32 cc_mult_num;
-	u32 cc_mult_dem;
-};
-
 /* Family MV88E6250:
  * Raw timestamps are in units of 10-ns clock periods.
  *
@@ -31,11 +24,11 @@ struct mv88e6xxx_cc_coeffs {
  * clkadj = scaled_ppm * 2^7 / 5^5
  */
 #define MV88E6XXX_CC_10NS_SHIFT 28
-static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_10ns_coeffs = {
+static const struct marvell_tai_param mv88e6xxx_cc_10ns_coeffs = {
 	.cc_shift = MV88E6XXX_CC_10NS_SHIFT,
 	.cc_mult = 10 << MV88E6XXX_CC_10NS_SHIFT,
 	.cc_mult_num = 1 << 7,
-	.cc_mult_dem = 3125ULL,
+	.cc_mult_den = 3125ULL,
 };
 
 /* Other families except MV88E6393X in internal clock mode:
@@ -46,11 +39,11 @@ static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_10ns_coeffs = {
  * clkadj = scaled_ppm * 2^9 / 5^6
  */
 #define MV88E6XXX_CC_8NS_SHIFT 28
-static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_8ns_coeffs = {
+static const struct marvell_tai_param mv88e6xxx_cc_8ns_coeffs = {
 	.cc_shift = MV88E6XXX_CC_8NS_SHIFT,
 	.cc_mult = 8 << MV88E6XXX_CC_8NS_SHIFT,
 	.cc_mult_num = 1 << 9,
-	.cc_mult_dem = 15625ULL
+	.cc_mult_den = 15625ULL
 };
 
 /* Family MV88E6393X using internal clock:
@@ -61,11 +54,11 @@ static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_8ns_coeffs = {
  * clkadj = scaled_ppm * 2^8 / 5^6
  */
 #define MV88E6XXX_CC_4NS_SHIFT 28
-static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_4ns_coeffs = {
+static const struct marvell_tai_param mv88e6xxx_cc_4ns_coeffs = {
 	.cc_shift = MV88E6XXX_CC_4NS_SHIFT,
 	.cc_mult = 4 << MV88E6XXX_CC_4NS_SHIFT,
 	.cc_mult_num = 1 << 8,
-	.cc_mult_dem = 15625ULL
+	.cc_mult_den = 15625ULL
 };
 
 static int mv88e6xxx_tai_read(struct mv88e6xxx_chip *chip, int addr,
@@ -242,8 +235,8 @@ static int mv88e6352_ptp_pin_setup(struct mv88e6xxx_chip *chip, int pin,
 	return mv88e6352_set_gpio_func(chip, pin, func, true);
 }
 
-static const struct mv88e6xxx_cc_coeffs *
-mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
+static const struct marvell_tai_param *
+mv88e6xxx_tai_param_get(struct mv88e6xxx_chip *chip)
 {
 	u16 period_ps;
 	int err;
@@ -386,15 +379,14 @@ static int mv88e6xxx_set_ptp_cpu_port(struct mv88e6xxx_chip *chip)
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
-	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
-	struct marvell_tai_param tai_param;
+	const struct marvell_tai_param *tai_param;
 	struct marvell_tai_pins pins;
 	int i, err;
 
 	/* Set up the cycle counter */
-	cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
-	if (IS_ERR(cc_coeffs))
-		return PTR_ERR(cc_coeffs);
+	tai_param = mv88e6xxx_tai_param_get(chip);
+	if (IS_ERR(tai_param))
+		return PTR_ERR(tai_param);
 
 	err = mv88e6xxx_set_ptp_cpu_port(chip);
 	if (err)
@@ -402,12 +394,6 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 
 	mv88e6xxx_reg_unlock(chip);
 
-	memset(&tai_param, 0, sizeof(tai_param));
-	tai_param.cc_mult_num = cc_coeffs->cc_mult_num;
-	tai_param.cc_mult_den = cc_coeffs->cc_mult_dem;
-	tai_param.cc_mult = cc_coeffs->cc_mult;
-	tai_param.cc_shift = cc_coeffs->cc_shift;
-
 	memset(&pins, 0, sizeof(pins));
 	pins.n_ext_ts = ptp_ops->n_ext_ts;
 	pins.n_pins = mv88e6xxx_num_gpio(chip);
@@ -422,7 +408,7 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 		ppd->func = PTP_PF_NONE;
 	}
 
-	err = marvell_tai_probe(&chip->tai, &mv88e6xxx_tai_ops, &tai_param,
+	err = marvell_tai_probe(&chip->tai, &mv88e6xxx_tai_ops, tai_param,
 				&pins, dev_name(chip->dev), chip->dev);
 	mv88e6xxx_reg_lock(chip);
 
-- 
2.47.3


