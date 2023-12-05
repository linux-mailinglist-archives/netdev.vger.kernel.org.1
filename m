Return-Path: <netdev+bounces-54006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB97805971
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A161F21867
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AAA63DE2;
	Tue,  5 Dec 2023 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="F35t6TWL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552FAD3
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:04:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf7bc38c0so2881517e87.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701792270; x=1702397070; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KXS428TMb13FqGO4ZQdUBP0UxkaMR0iGWSSrPjuydI8=;
        b=F35t6TWLCIDBaakaCYtPV1SD8C6xB2p7+yWSICJ71SowBKYucudNW+GcQ+vrMHSuIX
         yaqGhf9dTMjaIHnTh20BEdF0Jq3si+BLipAeXRBY29rP91QBBZfn+KD5qGCqTxwcI1Eu
         h3gblQzcsUBILMW73oKSpLcTx0+p6WVFO741T5dyd/DQDuTUR2/R9EM00iHbDrhYaCYj
         e2vtfZrDpZYnUrwJNBxA8lDOpvp7M01C64fuh7jUkk6zStlZ0KlbTaKfw24aHzwA//Aq
         0/n+EH/07R7y/0J/qUUNMpWBM0mrDNrnh96rjHfhTf05wMGnHwAVWK4L34T/8JP7TE2B
         g2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792270; x=1702397070;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXS428TMb13FqGO4ZQdUBP0UxkaMR0iGWSSrPjuydI8=;
        b=ckKIjijehEzv0NjtffxYI3VpOf90twC6itf99+N6q6BGqueLH9nkw2uzc6WDYYUp1k
         n8a/Hr/AY42eBCOKQmfkW0VJfdnmMezEtltMDJ0Y8Rg+ioa/kuDX4k68RtcXVuX81qFM
         vho+zdgiaLsogzXmULAhXzaDSdKZF63qubs1fma2YNXXD6FZTDM2pL9UDggKcgicTK/7
         JgfIFIPRTK32WIzgvwKrbQPL1urRt/C9K204DtaSCY8U3E1mE/TnYHoFiM3U597gvLO3
         PsuSamRDCEi2fLm/O0mdqvESXjGjkSv3D5wiM/JcHhYnCj5PGZRCfeDOAtmGEwXIY0Q+
         dFlw==
X-Gm-Message-State: AOJu0YzEDGASzp8BQjz9IgDUwJ+lZ4lqm3CrJqP6YQBnDTQauJtY9QF9
	PuCqZKXF5w6huS0Udwlr6HuR7w==
X-Google-Smtp-Source: AGHT+IG9YPLy8yyuJuwYegw+S07ORPZo+3p53Zo0FycgKo2p0McLchCSr2UX/g8Wl1BEhfOTXJcX6Q==
X-Received: by 2002:a19:711d:0:b0:50b:ec9d:be61 with SMTP id m29-20020a19711d000000b0050bec9dbe61mr2126919lfc.39.1701792270521;
        Tue, 05 Dec 2023 08:04:30 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0050c0bbbe3d2sm171341lfl.256.2023.12.05.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:04:30 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 2/6] net: dsa: mv88e6xxx: Create API to read a single stat counter
Date: Tue,  5 Dec 2023 17:04:14 +0100
Message-Id: <20231205160418.3770042-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205160418.3770042-1-tobias@waldekranz.com>
References: <20231205160418.3770042-1-tobias@waldekranz.com>
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
index 95a9dbd60aa6..bb18b47de49c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1006,7 +1006,7 @@ static struct mv88e6xxx_hw_stat mv88e6xxx_hw_stats[] = {
 };
 
 static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
-					    struct mv88e6xxx_hw_stat *s,
+					    const struct mv88e6xxx_hw_stat *s,
 					    int port, u16 bank1_select,
 					    u16 histogram)
 {
@@ -1189,59 +1189,82 @@ static int mv88e6xxx_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return count;
 }
 
-static int mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
-				     uint64_t *data, int types,
-				     u16 bank1_select, u16 histogram)
+static size_t mv88e6095_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				       const struct mv88e6xxx_hw_stat *stat,
+				       uint64_t *data)
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
+static size_t mv88e6250_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				       const struct mv88e6xxx_hw_stat *stat,
+				       uint64_t *data)
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
+static size_t mv88e6320_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				       const struct mv88e6xxx_hw_stat *stat,
+				       uint64_t *data)
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
+static size_t mv88e6390_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				       const struct mv88e6xxx_hw_stat *stat,
+				       uint64_t *data)
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
+static size_t mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				       const struct mv88e6xxx_hw_stat *stat,
+				       uint64_t *data)
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
+	size_t i, j;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
+		stat = &mv88e6xxx_hw_stats[i];
+		j += mv88e6xxx_stats_get_stat(chip, port, stat, &data[j]);
+	}
+	return j;
 }
 
 static void mv88e6xxx_atu_vtu_get_stats(struct mv88e6xxx_chip *chip, int port,
@@ -1257,10 +1280,9 @@ static void mv88e6xxx_atu_vtu_get_stats(struct mv88e6xxx_chip *chip, int port,
 static void mv88e6xxx_get_stats(struct mv88e6xxx_chip *chip, int port,
 				uint64_t *data)
 {
-	int count = 0;
+	size_t count;
 
-	if (chip->info->ops->stats_get_stats)
-		count = chip->info->ops->stats_get_stats(chip, port, data);
+	count = mv88e6xxx_stats_get_stats(chip, port, data);
 
 	mv88e6xxx_reg_lock(chip);
 	if (chip->info->ops->serdes_get_stats) {
@@ -3974,7 +3996,7 @@ static const struct mv88e6xxx_ops mv88e6085_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4012,7 +4034,7 @@ static const struct mv88e6xxx_ops mv88e6095_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.mgmt_rsvd2cpu = mv88e6185_g2_mgmt_rsvd2cpu,
 	.ppu_enable = mv88e6185_g1_ppu_enable,
 	.ppu_disable = mv88e6185_g1_ppu_disable,
@@ -4053,7 +4075,7 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4095,7 +4117,7 @@ static const struct mv88e6xxx_ops mv88e6123_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4138,7 +4160,7 @@ static const struct mv88e6xxx_ops mv88e6131_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4187,7 +4209,7 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4242,7 +4264,7 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4280,7 +4302,7 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4328,7 +4350,7 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4377,7 +4399,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4428,7 +4450,7 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4477,7 +4499,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4522,7 +4544,7 @@ static const struct mv88e6xxx_ops mv88e6185_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4571,7 +4593,7 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4629,7 +4651,7 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4685,7 +4707,7 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4744,7 +4766,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4797,7 +4819,7 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6250_stats_get_sset_count,
 	.stats_get_strings = mv88e6250_stats_get_strings,
-	.stats_get_stats = mv88e6250_stats_get_stats,
+	.stats_get_stat = mv88e6250_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6250_watchdog_ops,
@@ -4844,7 +4866,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4903,7 +4925,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6320_stats_get_stats,
+	.stats_get_stat = mv88e6320_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4950,7 +4972,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6320_stats_get_stats,
+	.stats_get_stat = mv88e6320_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4999,7 +5021,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5057,7 +5079,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5103,7 +5125,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5154,7 +5176,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5216,7 +5238,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5278,7 +5300,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5340,7 +5362,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	/* .set_cpu_port is missing because this family does not support a global
 	 * CPU port, only per port CPU port which is set via
 	 * .port_set_upstream_port method.
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 44383a03ef2f..c3c53ef543e5 100644
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
+	size_t (*stats_get_stat)(struct mv88e6xxx_chip *chip, int port,
+				 const struct mv88e6xxx_hw_stat *stat,
+				 uint64_t *data);
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


