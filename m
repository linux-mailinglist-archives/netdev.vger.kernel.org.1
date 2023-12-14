Return-Path: <netdev+bounces-57465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBE813228
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D39DB21982
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA5A5954E;
	Thu, 14 Dec 2023 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="ycwV8pfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F9C8E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:50 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2cc45b24356so6264721fa.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561849; x=1703166649; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+GGcc9rqVItMplGgyLHiHs6BioKN6M05JzWXSs2V2E=;
        b=ycwV8pfyBOOF+sX0Lh7K960CYHuqb67hBApOeNiRfnIVPeKGluYbOh4x9Ip/ejw/1k
         nbvOSLWX9u70j1YMiYCXk6beddlhWaMXGVEKhEbmLZ78dtuXM9G6quX/54gL2chqtVrL
         wSGjqzl2wjMDD5NwspYpR6eLoAvUppoobZbB34Xlb3fMOw9ZZJ/IBJEtrmFRSOFI7ojp
         dUzo1qxZU3jHqxUvAnLAPurOooF//hojeaxJtHLC9sVLO4/IKT6ds9syahOULrOo/1l/
         qEinhV1+O/ANgDh79GrcCT0bQAfjWyPIu7BuJ7kCfiNRiTx1KvgBljv1R1pkqqMtGJUo
         jLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561849; x=1703166649;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+GGcc9rqVItMplGgyLHiHs6BioKN6M05JzWXSs2V2E=;
        b=Wj8LU9OXwzW+UaE9HXNZ5ekvB6IGKTdrcfOjWg0JXn3HrHBaSl022xDFrnj3+8aZul
         ANDShsF1q4omU85CGlCsSJ5D1gDynGv4ltEA02slYniL/JnHSFv3WsNz8FWVGPhlIpYB
         6IigHDNfgUinMmghg3Zk0zNguVQTzmErxYMrx9AXY/yqR3DYZpR/EBijxhCu0f44NdtG
         2pkGhZpPu3fNFkFVArK8lKw+jNcJ0+zvN2iITIoNAHE+9l139qjs1mN87YZBPrnroP0e
         SdEmRSCGx0wJ/1FS6KQQNkWVbRPT6aB+yT/xMVfqvWWYx2oJ+mgbuvhvWsw08SrR0I4Y
         BCoA==
X-Gm-Message-State: AOJu0YzwN23t/ElVZA8GFsA30IPqYsKvulHPR03yR2LXC5NYcL+lNdGb
	Ll0UVcllcxDekrKh0/62cPbFXpuXU0UnwluwyRQ=
X-Google-Smtp-Source: AGHT+IFzd1FxHcf3fDR+IlHuOFmrbUIsXn9XLiGvhuFAyBBhhUtG3NLbJVsq7rLzT1NI0WU0S073UA==
X-Received: by 2002:a05:651c:1a26:b0:2cc:1d5b:1a0d with SMTP id by38-20020a05651c1a2600b002cc1d5b1a0dmr3793366ljb.8.1702561848817;
        Thu, 14 Dec 2023 05:50:48 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:47 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v4 net-next 2/8] net: dsa: mv88e6xxx: Create API to read a single stat counter
Date: Thu, 14 Dec 2023 14:50:23 +0100
Message-Id: <20231214135029.383595-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135029.383595-1-tobias@waldekranz.com>
References: <20231214135029.383595-1-tobias@waldekranz.com>
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

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 162 ++++++++++++++++++-------------
 drivers/net/dsa/mv88e6xxx/chip.h |  27 +++---
 2 files changed, 106 insertions(+), 83 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 4bd3ceffde17..1f41479fd2a1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1018,7 +1018,7 @@ static struct mv88e6xxx_hw_stat mv88e6xxx_hw_stats[] = {
 };
 
 static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
-					    struct mv88e6xxx_hw_stat *s,
+					    const struct mv88e6xxx_hw_stat *s,
 					    int port, u16 bank1_select,
 					    u16 histogram)
 {
@@ -1201,59 +1201,82 @@ static int mv88e6xxx_get_sset_count(struct dsa_switch *ds, int port, int sset)
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
-				     uint64_t *data)
+static size_t mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
+					uint64_t *data)
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
@@ -1269,10 +1292,9 @@ static void mv88e6xxx_atu_vtu_get_stats(struct mv88e6xxx_chip *chip, int port,
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
@@ -3988,7 +4010,7 @@ static const struct mv88e6xxx_ops mv88e6085_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4026,7 +4048,7 @@ static const struct mv88e6xxx_ops mv88e6095_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.mgmt_rsvd2cpu = mv88e6185_g2_mgmt_rsvd2cpu,
 	.ppu_enable = mv88e6185_g1_ppu_enable,
 	.ppu_disable = mv88e6185_g1_ppu_disable,
@@ -4067,7 +4089,7 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4109,7 +4131,7 @@ static const struct mv88e6xxx_ops mv88e6123_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4152,7 +4174,7 @@ static const struct mv88e6xxx_ops mv88e6131_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4201,7 +4223,7 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4256,7 +4278,7 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4294,7 +4316,7 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4342,7 +4364,7 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4391,7 +4413,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4442,7 +4464,7 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4491,7 +4513,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4536,7 +4558,7 @@ static const struct mv88e6xxx_ops mv88e6185_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4585,7 +4607,7 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4643,7 +4665,7 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4699,7 +4721,7 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4758,7 +4780,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -4811,7 +4833,7 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6250_stats_get_sset_count,
 	.stats_get_strings = mv88e6250_stats_get_strings,
-	.stats_get_stats = mv88e6250_stats_get_stats,
+	.stats_get_stat = mv88e6250_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6250_watchdog_ops,
@@ -4858,7 +4880,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4917,7 +4939,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6320_stats_get_stats,
+	.stats_get_stat = mv88e6320_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -4964,7 +4986,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6320_stats_get_stats,
+	.stats_get_stat = mv88e6320_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5013,7 +5035,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5071,7 +5093,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5117,7 +5139,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5168,7 +5190,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
-	.stats_get_stats = mv88e6095_stats_get_stats,
+	.stats_get_stat = mv88e6095_stats_get_stat,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
@@ -5230,7 +5252,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5292,7 +5314,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
 	.stats_get_strings = mv88e6320_stats_get_strings,
-	.stats_get_stats = mv88e6390_stats_get_stats,
+	.stats_get_stat = mv88e6390_stats_get_stat,
 	.set_cpu_port = mv88e6390_g1_set_cpu_port,
 	.set_egress_port = mv88e6390_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
@@ -5354,7 +5376,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
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


