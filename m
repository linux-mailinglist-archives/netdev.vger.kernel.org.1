Return-Path: <netdev+bounces-152000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556049F2510
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6D518864CA
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B221B4150;
	Sun, 15 Dec 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tyYMImCc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC11465A5;
	Sun, 15 Dec 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283864; cv=none; b=O5XIYBQsqpcebJb8B+WqLY27eTLP8DDlWYdfuzZcLkN3nHzulWfrU614/LmWmpYYgNHwQ+3S81YELDsuA6KSno1anhLcOyw7n3jmm5YLaYrBZdVcLG3ommwJy5hmGcQwclfwhB0+K9rBktwiuUh/6/UIhgLuO+lh2475zZlBA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283864; c=relaxed/simple;
	bh=uDkd9DRKWwfwDiFry+RrQNtzZxTSWFdATTUE/Bz4UyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDjQMLTsWFqFBhHbaSum5kPLPmjdOS+vCfr5VpYuFKVDQPOPGpVoODu7tmaNF2u0Y+NgozeR5kg0GYtxXbVcxk43CzC964qYoa9gfSYaRr3H28oqXb094hrat9iXBi3l0q1EKL/x9zpAHfedeKI++WgQ9PVa5RaIn/kUon++GkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tyYMImCc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zFclJrr4bHg7wXO/GCWuXtI5PXPkqXynOZ4ufpYDM20=; b=ty
	YMImCcYTuxL9kKgqjmHQNy+646/nhPd+WGYhCyUJYajBbK3eA7Z0YgHX6rJEQhUJ1PdRKN4YIXYUV
	770ffPqA/fmw/uFZmGuAbFFTnufy8PlWZDzZyjPMENo+yWHHK+DktrcMzAhwQ2Y/QQJeO7BeO1TJv
	0xVNsQ1QakyLdN0=;
Received: from [94.14.176.234] (helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tMsS1-000WHi-TG; Sun, 15 Dec 2024 18:30:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 15 Dec 2024 17:30:04 +0000
Subject: [PATCH 2/3] net: dsa: mv88e6xxx: Enable RMU on 6165 family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-2-87671db17a65@lunn.ch>
References: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
In-Reply-To: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4354; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=uDkd9DRKWwfwDiFry+RrQNtzZxTSWFdATTUE/Bz4UyU=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBnXxI9W2uANgXai7AuoTjkY09lqCKtWR9cuiFSy
 1Cr6p+F7QuJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZ18SPQAKCRDmvw3LpmlM
 hJpAD/4i7cfiaWvhJ7T5r4okvL13gBf0dWfYVwXM2ER1VvEcqyxyK9iCkHQgb5ylRUSikUH0Ouo
 FAwzyMqyHcvizE8Wmy1uuzNM4r2idu0z77lz4hefiqa28WHPT5UK01rEFfo2Uplot9FmAiIlRwf
 gi0pS2H4kpJud7FgxW2O+LtCua38vi3TULjog2C/CJ7EEjSSTlMwK88CeRUPdjGbpTXinTRJ2Gq
 /nFH//rW3T0EJELNGM4rbFmztZ/j1lKgHKI1ZeCNLelsjxSU9n0xDpoPZRtI+/LfiHDfXgoCHLV
 DK+j6kezIqd0SFX4u/eb874fpcdpKVNoO1KD6IJ73hSFNcMEcnKqd3TTpIN133tBE89i1+nEztO
 RIwP7WucRq7iQjBmKJM5Ch/2Cbj9XXW8VGWn44Ty1nVnej3ensndILDsu8LtAuI0etKtqw0+jc1
 tyqXFOGlbE64+XaPv+lABcXhpaysIXRWxvx3ntbtB+bAscGG3KH4PVJEjSEiUrZ5PngcTdMk6oE
 B0QOJZbKSzLHVomNA0EQZskD2exX/C/COjR9F4mPOZc07yy+2Vn/Vdl7xdoDZLUSiNtXV/cOGcX
 qmPkkoeoPBRuDvAJB7jRG5esFpTHhycANP8GUkh83/tbpoeKmuux0e+HR87wnBOEf2ZYtSntd9X
 PRAUwBGSWk6mrWg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The 6165 family allows the use of the RMU on ports 5 and 6.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c    |  6 ++++++
 drivers/net/dsa/mv88e6xxx/global1.c | 25 +++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  7 +++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 46f81b925208024b9029d6d674ebb5816a615e68..fe471ff4cd8ea8bb6654c61d0b95bb66c2e12157 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4317,6 +4317,8 @@ static const struct mv88e6xxx_ops mv88e6123_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6165_g1_rmu_disable,
+	.rmu_enable = mv88e6165_g1_rmu_enable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
@@ -4467,6 +4469,8 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6165_g1_rmu_disable,
+	.rmu_enable = mv88e6165_g1_rmu_enable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
@@ -4505,6 +4509,8 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6165_g1_rmu_disable,
+	.rmu_enable = mv88e6165_g1_rmu_enable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index ae0b6e5628184042404c208273ece55650cbc433..fcddba505ca3b8ddc0bc1a1e0576a5e08a51ef0e 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -555,6 +555,31 @@ int mv88e6085_g1_rmu_enable(struct mv88e6xxx_chip *chip, int port)
 				      MV88E6085_G1_CTL2_RM_ENABLE, val);
 }
 
+int mv88e6165_g1_rmu_disable(struct mv88e6xxx_chip *chip)
+{
+	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6165_G1_CTL2_RMU_MODE_MASK,
+				      MV88E6165_G1_CTL2_RMU_DISABLED);
+}
+
+int mv88e6165_g1_rmu_enable(struct mv88e6xxx_chip *chip, int port)
+{
+	int val;
+
+	switch (port) {
+	case 4:
+		val = MV88E6165_G1_CTL2_RMU_MODE_PORT_4;
+		break;
+	case 5:
+		val = MV88E6165_G1_CTL2_RMU_MODE_PORT_5;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6165_G1_CTL2_RMU_MODE_MASK,
+				      val);
+}
+
 int mv88e6352_g1_rmu_disable(struct mv88e6xxx_chip *chip)
 {
 	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6352_G1_CTL2_RMU_MODE_MASK,
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 4624d1bdfc2430d51be747662a25e7b5325e8c79..b8a28afcdcd695c519679976d1361fb7235411a6 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -235,6 +235,11 @@
 #define MV88E6085_G1_CTL2_DA_CHECK		0x4000
 #define MV88E6085_G1_CTL2_P10RM			0x2000
 #define MV88E6085_G1_CTL2_RM_ENABLE		0x1000
+#define MV88E6165_G1_CTL2_RMU_MODE_MASK		0x0300
+#define MV88E6165_G1_CTL2_RMU_DISABLED	        0x0000
+#define MV88E6165_G1_CTL2_RMU_MODE_PORT_4	0x0100
+#define MV88E6165_G1_CTL2_RMU_MODE_PORT_5	0x0200
+#define MV88E6165_G1_CTL2_RMU_MODE_PORT_RECVD	0x0300
 #define MV88E6352_G1_CTL2_DA_CHECK		0x0800
 #define MV88E6390_G1_CTL2_RMU_MODE_MASK		0x0700
 #define MV88E6390_G1_CTL2_RMU_MODE_PORT_0	0x0000
@@ -317,6 +322,8 @@ int mv88e6185_g1_set_cascade_port(struct mv88e6xxx_chip *chip, int port);
 
 int mv88e6085_g1_rmu_disable(struct mv88e6xxx_chip *chip);
 int mv88e6085_g1_rmu_enable(struct mv88e6xxx_chip *chip, int port);
+int mv88e6165_g1_rmu_disable(struct mv88e6xxx_chip *chip);
+int mv88e6165_g1_rmu_enable(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_g1_rmu_disable(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_rmu_enable(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_g1_rmu_disable(struct mv88e6xxx_chip *chip);

-- 
2.45.2


