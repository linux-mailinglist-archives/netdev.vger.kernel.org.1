Return-Path: <netdev+bounces-50044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7237F479B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E81C20844
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF224D5B3;
	Wed, 22 Nov 2023 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j19ZbvAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050171A597
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB5FC433C7;
	Wed, 22 Nov 2023 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700659242;
	bh=7LwihJijMcBGsYICQ/FqBpaBHGRP+YQHQl9RI10ofT8=;
	h=From:To:Cc:Subject:Date:From;
	b=j19ZbvAkIKI2e/pIvAzDexOUQQBJltq13EahFGvqc3jIVBeXjpWLOFKsteLtkpnOz
	 i82zQb7dKI88/TtWWqj+xRN5rwUh9l4opwcCGUm1IQ9wZLconhlf1Gyg2o8hAAWyVe
	 Z2IDpIRA0CsvOM3ZX2AsKW9gqoNfM+6/6/xMIOCG9rIgjrI9rVmuaJWUU+lrlZa4xc
	 IjMr9P2PDx2z4Nfq1nUjkFLNyDxjtp06VYJVAMmWwCIKayysctt3yEMMyEX3tKUOSg
	 ku2LMsSOs0pABNURg+Kddbm4cDInStGB5+AU4+G79OzvUf5MKVLKUxHhrxzLihW2BJ
	 MnMfnyAkP4rig==
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
Subject: [PATCH 1/2] net: dsa: mv88e6xxx: fix marvell 6350 switch probing
Date: Wed, 22 Nov 2023 23:19:44 +1000
Message-Id: <20231122131944.2180408-1-gerg@kernel.org>
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
6350 to support its more different set of capabilities. Unfortunately the
6352 switch capabilities cannot be re-used due to their support of a SERDES
lane.

The Marvell 88e6351 switch is a slightly improved version of the 6350,
but is mostly identical. It will also need the dedicated 6350 function,
so update its phylink_get_caps as well.

Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 42b1acaca33a..e9adf9711c09 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -577,6 +577,18 @@ static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
 }
 
+static void mv88e6350_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
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
@@ -5069,7 +5081,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6350_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6351_ops = {
@@ -5117,7 +5129,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6350_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6352_ops = {
-- 
2.25.1


