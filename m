Return-Path: <netdev+bounces-117530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A484794E2D8
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C459A1C20829
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC17D1537BB;
	Sun, 11 Aug 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJI6Jz7q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1612B73
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723406885; cv=none; b=H8+q/cm1MMkBEYfJ+/mQwtN0Vph/6Nl+pZhsZNR8tNiB4av070QYFxPh6J2XySTOtpzzY/WD0Nsl5twzNowSRXpAIJOE06nqcWgFeHmybmdCJPlvJDDD6WWJgik8idmIyHRK+rmxBPkM2U4NR0cAX7CJD4aBaNN9gLVttH1t+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723406885; c=relaxed/simple;
	bh=X+wxbmlcEYoYLq8NEZnHHflD/dotEvBESvWdZI/P2wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MP9/W2bYsFFbcsF5v/eiGev9KtDLrkk2AyqB2KIsJM/JyaEJZKwZQVNpaIMqgd1Z/mUcik6f36S2B4AdXgjsBytM6ouCV5jAGQLdHJphoqn0GDgPnWrsgC/Ck1oSRTdQKayimQ8kye9NCnpx2GlOqoH5DbSHhbo9xsjIRzlw2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJI6Jz7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8A7C32786;
	Sun, 11 Aug 2024 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723406885;
	bh=X+wxbmlcEYoYLq8NEZnHHflD/dotEvBESvWdZI/P2wg=;
	h=From:To:Cc:Subject:Date:From;
	b=tJI6Jz7qvxz/N6Yev66E7GACqLvvV78Ixw+kNYXRw/GlzXUuwEwo/Jj0brqPlEIHm
	 0FFIFY8vt+GtFfWX7T9Gz8O1AA1P8NRVYhY01XBG0ntP2F3Q6606mkz3w7w1nd5uCh
	 /KA7xMaevlesqo5H2Wr/h2lQynIAPADN156gU73mjmtmQY9e1YlYg2ApSkkKHUQyHz
	 QEnmgHv3Q04Dr26F2uhs7oXgeHp8QiLRRPLKQeMIq1bSa1bHqdA0uuouAA9+ZcP9+q
	 mbglOJYpbaDDZTazxWPFhjMyaFM1TrAvJJHdd2nhhQDq4g7QdFTJVyaBri8wU5phXW
	 +1a2XwciOWFJQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH RESEND net] net: dsa: mv88e6xxx: Drop serdes methods for 88E6172
Date: Sun, 11 Aug 2024 22:07:59 +0200
Message-ID: <20240811200759.4830-1-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop serdes methods for 88E6172. This switch from the 6352 family does
not have serdes. Until commit 85764555442f ("net: dsa: mv88e6xxx:
convert 88e6352 to phylink_pcs") these methods were checking for serdes
presence by looking at port's cmode, but in that commit the check was
dropped, so now the nonexistent serdes registers are being accessed.

Fixes: 85764555442f ("net: dsa: mv88e6xxx: convert 88e6352 to phylink_pcs")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
resending since I forgot to add netdev to cc
---
 drivers/net/dsa/mv88e6xxx/chip.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5b4e2ce5470d..6e410caf9878 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -667,17 +667,25 @@ static int mv88e63xx_get_port_serdes_cmode(struct mv88e6xxx_chip *chip, int port
 	return val & MV88E6XXX_PORT_STS_CMODE_MASK;
 }
 
-static void mv88e6352_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
+static void mv88e6172_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
 				       struct phylink_config *config)
 {
 	unsigned long *supported = config->supported_interfaces;
-	int err, cmode;
 
 	/* Translate the default cmode */
 	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 |
 				   MAC_1000FD;
+}
+
+static void mv88e6352_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
+				       struct phylink_config *config)
+{
+	unsigned long *supported = config->supported_interfaces;
+	int err, cmode;
+
+	mv88e6172_phylink_get_caps(chip, port, config);
 
 	/* Port 4 supports automedia if the serdes is associated with it. */
 	if (port == 4) {
@@ -4618,11 +4626,8 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
-	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
-	.phylink_get_caps = mv88e6352_phylink_get_caps,
-	.pcs_ops = &mv88e6352_pcs_ops,
+	.phylink_get_caps = mv88e6172_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6175_ops = {
-- 
2.44.2


