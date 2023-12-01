Return-Path: <netdev+bounces-52916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E7800B54
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704B7B21273
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BD525572;
	Fri,  1 Dec 2023 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="EJSILsgR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465CF10F3
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 04:58:49 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9b5b72983so27925531fa.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 04:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701435527; x=1702040327; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W20/R/2/lPxahq8QRbTSIQuYC5cfYA58c59XK3Afbak=;
        b=EJSILsgRJCPpsp69uhLI/ahqhBRGvrvjMVfjS3lbdCCl2qP6m0u9J55YkVKg4AQudl
         nCYDYMR9eDZujYKQdr8iVH/7RSV5FcdPe6uZDYvVuhJ45E63aO45F0L4gsDkmW2D0i0C
         FIZyBQkqDn/4LHdIlOdX8EG6tm90g7AbxE13dAYVJprZ6aYiDD4rIMBd8gI/ldbC+bRL
         Px2hu1mL5vDTD3n734m6/E2/D+lwfIDY0IwbsDLRkTrRZ3HOXab4p6efg/8v1NZiFcCc
         TTF/GX/xHgKLhl8v6GbwG191Sm7S31NwpPu847q/BZN37pcMp2896Mp2polw9pIuXDHI
         c1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435527; x=1702040327;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W20/R/2/lPxahq8QRbTSIQuYC5cfYA58c59XK3Afbak=;
        b=TH0BrlR3wA6pXcOhf6gAVF4C8Wtf7BzZsASopl0UA1kJmkPAdvMMlFtkw2m2YJM08o
         V8K+QuafmDkk9BlrPupJpYV2fE/ZMrrQWB2vRKCwroUzikTZWch5YpsWCYUL/4i2dZdF
         nql6jZ86e60LliLIUdpfqcPwuGFPvfFEeR8UJIRY9RfujAInBi6symdzoDAT6/nnGPGg
         slgi9/Hjt3VrXlxTeg27lwxxyrWI9Ey0LbOmdcmkr3H9HYzRftE8Cg938M/uY4QOaT/3
         wit/vzl4bNJID777KRTI1ZafwYf9/5f7PUgtA7XkHoblNGJUIsHCFDXWZfsuKBzjccsN
         KkMA==
X-Gm-Message-State: AOJu0YzHlyAwLY+a7TVbrOMVnvuL56nlG2nadancdDY1KzEJG8W4UfPS
	hMlOep0c3RXcyrtHd16qBJnRIA==
X-Google-Smtp-Source: AGHT+IEJSH9H45M/LqcBB65V8y60blxmvxT+cn2BuOj+blZ8mU4i28smSH4eYN0SG21SPRTKI+WZ4w==
X-Received: by 2002:a2e:b0e4:0:b0:2c9:d863:2c3c with SMTP id h4-20020a2eb0e4000000b002c9d8632c3cmr763302ljl.101.1701435527381;
        Fri, 01 Dec 2023 04:58:47 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b002c02b36d381sm417036ljo.88.2023.12.01.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:58:46 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/4] net: dsa: mv88e6xxx: Create API to read a single stat counter
Date: Fri,  1 Dec 2023 13:58:09 +0100
Message-Id: <20231201125812.1052078-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201125812.1052078-1-tobias@waldekranz.com>
References: <20231201125812.1052078-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This change contains no functional change. We simply push the hardware
specific stats logic to a function reading a single counter, rather
than the whole set.

This is a preparatory change for the upcoming standard ethtool
statistics support (i.e. "eth-mac", "eth-ctrl" etc.).

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 160 ++++++++++++++++++-------------
 drivers/net/dsa/mv88e6xxx/chip.h |  27 +++---
 2 files changed, 105 insertions(+), 82 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 42b1acaca33a..ffd81174bda3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1000,7 +1000,7 @@ static struct mv88e6xxx_hw_stat mv88e6xxx_hw_stats[] = {
 };
 
 static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
-					    struct mv88e6xxx_hw_stat *s,
+					    const struct mv88e6xxx_hw_stat *s,
 					    int port, u16 bank1_select,
 					    u16 histogram)
 {
@@ -1183,59 +1183,82 @@ static int mv88e6xxx_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return count;
 }
 
-static int mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
-				     uint64_t *data, int types,
-				     u16 bank1_select, u16 histogram)
+static int mv88e6095_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				    const struct mv88e6xxx_hw_stat *stat,
+				    uint64_t *data)
 {
-	struct mv88e6xxx_hw_stat *stat;
-	int i, j;
+	if (!(stat->type & (STATS_TYPE_BANK0 | STATS_TYPE_PORT)))
+		return 0;
 
-	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
-		stat = &mv88e6xxx_hw_stats[i];
-		if (stat->type & types) {
-			mv88e6xxx_reg_lock(chip);
-			data[j] = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
-							      bank1_select,
-							      histogram);
-			mv88e6xxx_reg_unlock(chip);
+	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
+					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+	return 1;
+}
 
-			j++;
-		}
-	}
-	return j;
+static int mv88e6250_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				    const struct mv88e6xxx_hw_stat *stat,
+				    uint64_t *data)
+{
+	if (!(stat->type & STATS_TYPE_BANK0))
+		return 0;
+
+	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
+					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+	return 1;
 }
 
-static int mv88e6095_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
-				     uint64_t *data)
+static int mv88e6320_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				    const struct mv88e6xxx_hw_stat *stat,
+				    uint64_t *data)
 {
-	return mv88e6xxx_stats_get_stats(chip, port, data,
-					 STATS_TYPE_BANK0 | STATS_TYPE_PORT,
-					 0, MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+	if (!(stat->type & (STATS_TYPE_BANK0 | STATS_TYPE_BANK1)))
+		return 0;
+
+	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
+					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_9,
+					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+	return 1;
 }
 
-static int mv88e6250_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
-				     uint64_t *data)
+static int mv88e6390_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				    const struct mv88e6xxx_hw_stat *stat,
+				    uint64_t *data)
 {
-	return mv88e6xxx_stats_get_stats(chip, port, data, STATS_TYPE_BANK0,
-					 0, MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+	if (!(stat->type & (STATS_TYPE_BANK0 | STATS_TYPE_BANK1)))
+		return 0;
+
+	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
+					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_10,
+					    0);
+	return 1;
 }
 
-static int mv88e6320_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
-				     uint64_t *data)
+static int mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				    const struct mv88e6xxx_hw_stat *stat,
+				    uint64_t *data)
 {
-	return mv88e6xxx_stats_get_stats(chip, port, data,
-					 STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
-					 MV88E6XXX_G1_STATS_OP_BANK_1_BIT_9,
-					 MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+	int ret = 0;
+
+	if (chip->info->ops->stats_get_stat) {
+		mv88e6xxx_reg_lock(chip);
+		ret = chip->info->ops->stats_get_stat(chip, port, stat, data);
+		mv88e6xxx_reg_unlock(chip);
+	}
+
+	return ret;
 }
 
-static int mv88e6390_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
+static int mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
 				     uint64_t *data)
 {
-	return mv88e6xxx_stats_get_stats(chip, port, data,
-					 STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
-					 MV88E6XXX_G1_STATS_OP_BANK_1_BIT_10,
-					 0);
+	struct mv88e6xxx_hw_stat *stat;
+	int i, j;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
+		stat = &mv88e6xxx_hw_stats[i];
+		j += mv88e6xxx_stats_get_stat(chip, port, stat, &data[j]);
+	}
+	return j;
 }
 
 static void mv88e6xxx_atu_vtu_get_stats(struct mv88e6xxx_chip *chip, int port,
@@ -1251,10 +1274,9 @@ static void mv88e6xxx_atu_vtu_get_stats(struct mv88e6xxx_chip *chip, int port,
 static void mv88e6xxx_get_stats(struct mv88e6xxx_chip *chip, int port,
 				uint64_t *data)
 {
-	int count = 0;
+	int count;
 
-	if (chip->info->ops->stats_get_stats)
-		count = chip->info->ops->stats_get_stats(chip, port, data);
+	count = mv88e6xxx_stats_get_stats(chip, port, data);
 
 	mv88e6xxx_reg_lock(chip);
 	if (chip->info->ops->serdes_get_stats) {
@@ -3973,7 +3995,7 @@ static const struct mv88e6xxx_ops mv88e6085_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4011,7 +4033,7 @@ static const struct mv88e6xxx_ops mv88e6095_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.mgmt_rsvd2cpu = mv88e6185_g2_mgmt_rsvd2cpu,
 	.ppu_enable = mv88e6185_g1_ppu_enable,
 	.ppu_disable = mv88e6185_g1_ppu_disable,
@@ -4052,7 +4074,7 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4094,7 +4116,7 @@ static const struct mv88e6xxx_ops mv88e6123_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4137,7 +4159,7 @@ static const struct mv88e6xxx_ops mv88e6131_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4186,7 +4208,7 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4241,7 +4263,7 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4279,7 +4301,7 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4327,7 +4349,7 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4376,7 +4398,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4427,7 +4449,7 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4476,7 +4498,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4521,7 +4543,7 @@ static const struct mv88e6xxx_ops mv88e6185_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4570,7 +4592,7 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4628,7 +4650,7 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4684,7 +4706,7 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4743,7 +4765,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4796,7 +4818,7 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6250_stats_get_sset_count,
 	.stats_get_strings = mv88e6250_stats_get_strings,
-	.stats_get_stats = mv88e6250_stats_get_stats,
+	.stats_get_stat = mv88e6250_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6250_watchdog_ops,
@@ -4843,7 +4865,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4902,7 +4924,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6320_stats_get_stats,
+	.stats_get_stat = mv88e6320_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4949,7 +4971,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6320_stats_get_stats,
+	.stats_get_stat = mv88e6320_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4998,7 +5020,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5056,7 +5078,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5102,7 +5124,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5153,7 +5175,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5215,7 +5237,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5277,7 +5299,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5339,7 +5361,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	/* .set_cpu_port is missing because this family does not support a global
 	 * CPU port, only per port CPU port which is set via
 	 * .port_set_upstream_port method.
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 44383a03ef2f..b0dfbcae0be9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -318,6 +318,17 @@ struct mv88e6xxx_mst {
 	struct mv88e6xxx_stu_entry stu;
 };
 
+#define STATS_TYPE_PORT		BIT(0)
+#define STATS_TYPE_BANK0	BIT(1)
+#define STATS_TYPE_BANK1	BIT(2)
+
+struct mv88e6xxx_hw_stat {
+	char string[ETH_GSTRING_LEN];
+	size_t size;
+	int reg;
+	int type;
+};
+
 struct mv88e6xxx_chip {
 	const struct mv88e6xxx_info *info;
 
@@ -574,8 +585,9 @@ struct mv88e6xxx_ops {
 	/* Return the number of strings describing statistics */
 	int (*stats_get_sset_count)(struct mv88e6xxx_chip *chip);
 	int (*stats_get_strings)(struct mv88e6xxx_chip *chip,  uint8_t *data);
-	int (*stats_get_stats)(struct mv88e6xxx_chip *chip,  int port,
-			       uint64_t *data);
+	int (*stats_get_stat)(struct mv88e6xxx_chip *chip,  int port,
+			      const struct mv88e6xxx_hw_stat *stat,
+			      uint64_t *data);
 	int (*set_cpu_port)(struct mv88e6xxx_chip *chip, int port);
 	int (*set_egress_port)(struct mv88e6xxx_chip *chip,
 			       enum mv88e6xxx_egress_direction direction,
@@ -727,17 +739,6 @@ struct mv88e6xxx_pcs_ops {
 
 };
 
-#define STATS_TYPE_PORT		BIT(0)
-#define STATS_TYPE_BANK0	BIT(1)
-#define STATS_TYPE_BANK1	BIT(2)
-
-struct mv88e6xxx_hw_stat {
-	char string[ETH_GSTRING_LEN];
-	size_t size;
-	int reg;
-	int type;
-};
-
 static inline bool mv88e6xxx_has_stu(struct mv88e6xxx_chip *chip)
 {
 	return chip->info->max_sid > 0 &&
-- 
2.34.1


