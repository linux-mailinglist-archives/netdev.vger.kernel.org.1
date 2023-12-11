Return-Path: <netdev+bounces-56114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175080DE50
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AFE1C214EE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D4555C22;
	Mon, 11 Dec 2023 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="q6umyuRA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F3C7
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf82f4409so4907576e87.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702334044; x=1702938844; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZrrTuwlASyxmnjDUvYkrOzHlcqUEhfAqYQ8S4S5UL20=;
        b=q6umyuRAvkvJar+00lQvGqhZJ8dsihz62uftQbdTOHJV91ptWcD7NISHnxlOG9Lucs
         DJYHFkym15Dzn3Duc6v1MtTPTbi/jbTV8QVexQd4TLImGpuxEIIae70lpr7nsTCggn+4
         lhYKvt0vEKJh+00hnPOIUoEEzoSuTiZZoV7H/Z/HEG5x3SWdrnEx8MzpKNvdDIdtAj2h
         PjWxKWoYIyDfMS5M8SYSXXTcLmQFNd8xIXHPJc4n413buUBoV0R03OccKc7EksK9RaQ/
         qlSjnkoyvLvD+qCv07QI280wpRhq8FpZ9bWD3lhDyzUlVNkN/DaJQthcVbkkuIbAGSrm
         KIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334044; x=1702938844;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrrTuwlASyxmnjDUvYkrOzHlcqUEhfAqYQ8S4S5UL20=;
        b=KSJIdfBnL2Ccs/CitzAlhWMvzcp2SOZ2EbGGNAZawdBIZ+VzsK7i3FdYmXiXEA3PBO
         qo3Y20h9HLc3KuvsltMjYd8IgdbPa6FsGluwCAL/q5kpTkM8AIVmTiC57NmuxPYJ5N12
         S4iLt6Fk0FBW/4YLPu9pwlCAzr7PvzWs1wqynjK4szpqCqueEkuG741v1HbyJ6I09LZv
         b7ggxDek69CroOY+QYn6msTmvDGok5ljIEe+BtOQlgrojLD1x3qeLK2BayO0nLsfrkdA
         2D0Feum+hhr3mCElgqCRRqT+ss2VN5Wu+AoScDdLqh4snX5gpChuYkoxsFosu4UdkUVk
         +OFA==
X-Gm-Message-State: AOJu0YwEAtDgNG0hz0PJZJ6eoxpQb7Zg9NvMZvaZPU9eDjbJK7Vuhjob
	2fkzuOZcB4364e4RPpltktRJkA==
X-Google-Smtp-Source: AGHT+IHl5yE/6H28RtiEb4hqujv/o+sV7pUm2lnDzCPKGCl/7R494RgUxO3/BXzQGArTmWJrOF1zHw==
X-Received: by 2002:ac2:5e71:0:b0:50b:eadc:2cb5 with SMTP id a17-20020ac25e71000000b0050beadc2cb5mr2170039lfr.18.1702334044514;
        Mon, 11 Dec 2023 14:34:04 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b0050bfc6dbb8asm1217649lfg.302.2023.12.11.14.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:34:03 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 6/8] net: dsa: mv88e6xxx: Limit histogram counters to ingress traffic
Date: Mon, 11 Dec 2023 23:33:44 +0100
Message-Id: <20231211223346.2497157-7-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211223346.2497157-1-tobias@waldekranz.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Chips in this family only has one set of histogram counters, which can
be used to count ingressing and/or egressing traffic. mv88e6xxx has,
up until this point, kept the hardware default of counting both
directions.

In the mean time, standard counter group support has been added to
ethtool. Via that interface, drivers may report ingress-only and
egress-only histograms separately - but not combined.

In order for mv88e6xxx to maximalize amount of diagnostic information
that can be exported via standard interfaces, we opt to limit the
histogram counters to ingress traffic only. Which will allow us to
export them via the standard "rmon" group in an upcoming commit.

The reason for choosing ingress-only over egress-only, is to be
compatible with RFC2819 (RMON MIB).

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 6 +++---
 drivers/net/dsa/mv88e6xxx/global1.c | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6f1f71cb0de5..a3bd12ceba7b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1221,7 +1221,7 @@ static size_t mv88e6095_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 		return 0;
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
-					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
 }
 
@@ -1233,7 +1233,7 @@ static size_t mv88e6250_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 		return 0;
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
-					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
 }
 
@@ -1246,7 +1246,7 @@ static size_t mv88e6320_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
 					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_9,
-					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 174c773b38c2..49444a72ff09 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -462,8 +462,7 @@ int mv88e6390_g1_rmu_disable(struct mv88e6xxx_chip *chip)
 int mv88e6390_g1_stats_set_histogram(struct mv88e6xxx_chip *chip)
 {
 	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6390_G1_CTL2_HIST_MODE_MASK,
-				      MV88E6390_G1_CTL2_HIST_MODE_RX |
-				      MV88E6390_G1_CTL2_HIST_MODE_TX);
+				      MV88E6390_G1_CTL2_HIST_MODE_RX);
 }
 
 int mv88e6xxx_g1_set_device_number(struct mv88e6xxx_chip *chip, int index)
@@ -491,7 +490,7 @@ int mv88e6095_g1_stats_set_histogram(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	val |= MV88E6XXX_G1_STATS_OP_HIST_RX_TX;
+	val |= MV88E6XXX_G1_STATS_OP_HIST_RX;
 
 	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_STATS_OP, val);
 
@@ -506,7 +505,7 @@ int mv88e6xxx_g1_stats_snapshot(struct mv88e6xxx_chip *chip, int port)
 	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_STATS_OP,
 				 MV88E6XXX_G1_STATS_OP_BUSY |
 				 MV88E6XXX_G1_STATS_OP_CAPTURE_PORT |
-				 MV88E6XXX_G1_STATS_OP_HIST_RX_TX | port);
+				 MV88E6XXX_G1_STATS_OP_HIST_RX | port);
 	if (err)
 		return err;
 
-- 
2.34.1


