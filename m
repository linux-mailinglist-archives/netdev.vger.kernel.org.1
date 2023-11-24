Return-Path: <netdev+bounces-50690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DBB7F6B2F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 05:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF351C208E5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 04:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4515B7;
	Fri, 24 Nov 2023 04:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD8k6P2t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EC138C
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78EFC433CB;
	Fri, 24 Nov 2023 04:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700799336;
	bh=YX1TkjMPxLK0fswT4wCKqfG/KgkFruC9mi+Qx1fvsls=;
	h=From:To:Cc:Subject:Date:From;
	b=DD8k6P2tpKEQlLhdeFjYHHh5mXMEAI5bVSjWszS3an/d0B0sAJCn/H9k1A5l0E+wy
	 jecA6p7/rwN47k4KDTyuq1PwNG+QeWy4H97xLvhNxAmEURrs8gb0cWFTVy+/fOdlNh
	 /7XmkfGNkBfcGLhdgImD41S68S803wHc4LdLrwMMbciOEzD0vmsLY3g0KrG4RDxPfZ
	 3MpBm8hg7ZdasvPMR3o5Vl4+/+sjJ4oVLbJfIdYImSgZULttfBWCYrvpdnrQ0TgDCY
	 e3GGEh6AAs/AjF/MR/ErSzv0QMH8/RfchiiMEHzszn0l7eupDL3NjdlfuWVDHa24RL
	 mOtYNBrPWYCbA==
From: Greg Ungerer <gerg@kernel.org>
To: rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Greg Ungerer <gerg@kernel.org>
Subject: [PATCHv2 1/2] net: dsa: mv88e6xxx: fix marvell 6350 switch probing
Date: Fri, 24 Nov 2023 14:15:28 +1000
Message-Id: <20231124041529.3450079-1-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
be filled") Marvell 88e6350 switches fail to be probed:

    ...
    mv88e6085 d0072004.mdio-mii:11: switch 0x3710 detected: Marvell 88E6350, revision 2
    mv88e6085 d0072004.mdio-mii:11: phylink: error: empty supported_interfaces
    error creating PHYLINK: -22
    mv88e6085: probe of d0072004.mdio-mii:11 failed with error -22
    ...

The problem stems from the use of mv88e6185_phylink_get_caps() to get
the device capabilities. Create a new dedicated phylink_get_caps for the
6351 family (which the 6350 is one of) to properly support their set of
capabilities.

According to chip.h the 6351 switch family includes the 6171, 6175, 6350
and 6351 switches, so update each of these to use the correct
phylink_get_caps.

Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

v2: rename to mv88e6351_phylink_get_caps
    set phylink_get_caps for 6171, 6175, 6350 and 6351

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 42b1acaca33a..d8a67bf4e595 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -577,6 +577,18 @@ static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
 }
 
+static void mv88e6351_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
+				       struct phylink_config *config)
+{
+	unsigned long *supported = config->supported_interfaces;
+
+	/* Translate the default cmode */
+	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
+
+	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 |
+				   MAC_1000FD;
+}
+
 static int mv88e6352_get_port4_serdes_cmode(struct mv88e6xxx_chip *chip)
 {
 	u16 reg, val;
@@ -4340,7 +4352,7 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6351_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6172_ops = {
@@ -4440,7 +4452,7 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6351_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6176_ops = {
@@ -5069,7 +5081,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6351_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6351_ops = {
@@ -5117,7 +5129,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6351_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6352_ops = {
-- 
2.25.1


