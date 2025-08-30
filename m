Return-Path: <netdev+bounces-218502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636C1B3CE10
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9283B35DE
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203CA27A460;
	Sat, 30 Aug 2025 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oDY/fJIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0030CD85;
	Sat, 30 Aug 2025 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756574589; cv=none; b=PdF65bxVPTFAOj0iQ8QClOFg6JkstWFAHzpTnlEPcStKphCSVWle03de/mhuKXFk5qBjDhFfNc1KhvCQtodCpGYmSuylFYpdczD3an8R+oha0NXlSWFb5UVBTNqw62BAU1BuZrmPddl3PLOag5wnFe5A2xPJqMEXi9PX/S74BJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756574589; c=relaxed/simple;
	bh=GDEf6P2LWJYMs+ydV4s3fgoSHiHRStGgW5xBJ9BGZ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/ZyUH7B3cm9a76nxi3Fekqg9Y3y4L7bdQHsc7AZed2kJzrCeAetBskZ1gZ8PzN49a6RePTeoHUl6mWvjlgPFzDVt9JGEbxj9VsZAycKsHschkbSe7YKiKNHVfJYNiNCmbwaIesP1yIii/J6DfLTL/VK5wR4wXbh2EbO9m1mk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oDY/fJIp; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id sP9RuuBTkbhcosP9Ru4q4A; Sat, 30 Aug 2025 19:14:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1756574048;
	bh=7b05OJImVDGdpWr2qdSSpne58sS8juqAprc2DtZui0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oDY/fJIpH3H1fsFHgYEOCEcbhd9w9SXmZbYvUmwERSxAqL0b9AucBKeVrOdkobTmU
	 MneZF9jVctqBYJig2w6ks8z2aFmyaeM3wgwM+XDlQWrmEeM+eLHpWi2/u0Np7/kmJn
	 +TGBhuf73RtGuVhCj228GmYEWHtB5CBQVVoGemScz2y5NhUrhsIAHRyUs9/p36tAAn
	 NPrN2U94bsyYnALZyqusyGY0aiMGSZTgtmuWEuqW4fVWNTx7ir6WIw37L0I095aBSE
	 EjqezbITzby1Z7b4HjGXhKO5tbN2ch0f33k/DbtPDFEkLCDem7G11bS1SIDKErze3N
	 1FYplBiaLsQHA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 Aug 2025 19:14:08 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Helmut Buchsbaum <helmut.buchsbaum@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: dsa: ks8995: Fix some error handling path in ks8995_probe()
Date: Sat, 30 Aug 2025 19:13:59 +0200
Message-ID: <95be5a0c504611263952d850124f053fd6204e94.1756573982.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after calling gpiod_set_value_cansleep(..., 0), it must
be undone by a corresponding gpiod_set_value_cansleep(..., 1) call as
already done in the remove function.

In order to easily do the needed clean-up in the probe, add a new
devm_add_action_or_reset() call and simplify the remove function
accordingly.

Fixes: cd6f288cbaab ("net: phy: spi_ks8995: add support for resetting switch using GPIO")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/dsa/ks8995.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 5c4c83e00477..debb2cd7ab61 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -742,6 +742,14 @@ static const struct dsa_switch_ops ks8995_ds_ops = {
 	.phylink_get_caps = ks8995_phylink_get_caps,
 };
 
+static void devm_reset_assert(void *data)
+{
+	struct ks8995_switch *ks = data;
+
+	/* assert reset */
+	gpiod_set_value_cansleep(ks->reset_gpio, 1);
+}
+
 /* ------------------------------------------------------------------------ */
 static int ks8995_probe(struct spi_device *spi)
 {
@@ -784,6 +792,11 @@ static int ks8995_probe(struct spi_device *spi)
 		 */
 		gpiod_set_value_cansleep(ks->reset_gpio, 0);
 		udelay(100);
+
+		err = devm_add_action_or_reset(&spi->dev,
+					       devm_reset_assert, ks);
+		if (err)
+			return err;
 	}
 
 	spi_set_drvdata(spi, ks);
@@ -834,8 +847,6 @@ static void ks8995_remove(struct spi_device *spi)
 	struct ks8995_switch *ks = spi_get_drvdata(spi);
 
 	dsa_unregister_switch(ks->ds);
-	/* assert reset */
-	gpiod_set_value_cansleep(ks->reset_gpio, 1);
 }
 
 /* ------------------------------------------------------------------------ */
-- 
2.51.0


