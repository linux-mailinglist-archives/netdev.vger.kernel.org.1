Return-Path: <netdev+bounces-52917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D6800B55
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549A5B21275
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087F2574D;
	Fri,  1 Dec 2023 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="ZAf64Aul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23110F8
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 04:58:50 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9d4740e1cso18781641fa.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 04:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701435529; x=1702040329; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ZtIZgqTj3rEA0I/YUjrAOcWoVwlj56B9868AHGBdis=;
        b=ZAf64Aul1JBmzMpEMbsfm+TT1K17gCdCc4Zr5ltAHuqvuFM60SezveqeA5Qbfivynh
         whnQvG9Zh9MFvVhnczJnGDgMaJ/giCsSaCPv2KmHRGfTRtpMwAEebcNXN/be4pI+avWW
         z5HRgNkECJVxR6XblyjDUAeCrHn4GUbj+aLYtwdFpCrXaEbrluVNna7nBmbF5I0iZ25e
         tYURHIU168HmsXduOxF7d5rjeo+t9rhuyMV4JiwQ8WJTEUdp97bSyX5CYyHMg8F3dO++
         2DdD4H9Dt86S8y5WNWgfhWXitOzfqKeansmumvB80a1yuiqlRb2Z7A12MwTeU7KcLDrZ
         QF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435529; x=1702040329;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZtIZgqTj3rEA0I/YUjrAOcWoVwlj56B9868AHGBdis=;
        b=pkC9ce9E3wo6S5lBmQkQQj4TSCx1czW/U3We0FFf+PEpUihxfBxcI4gpvCvvgYvhk9
         5ahJwuxIXRbFjNEj+tyEJdKLs63qW/EQyzgSfLP+FkYjRj+ejdwEhduusHDbZvfxnFRF
         yxdvsdb6LxK4moJBp210vC6wOoJ/8hoox2+9CNC5KgiwRCrbwvCFMMa7fAnFFT3EQLNY
         NAbzN5bdtsnNzirtGdRLwxtbUJCcZ6MfFqXVI59lBSbJg8LD68AxN0RYGZKs+KuDpFe6
         DSDuvlWtvGJNOhevLhiKTvACHeYBU3Q9VT2JB6vXCourJ3HCXz7bmf1OBbi692vh4nbq
         c9Kw==
X-Gm-Message-State: AOJu0YxpFeEFv3QeNNE+gZoF3YKrDI/z6ykj+4y6hwJHLeKR4A30W5vG
	TC+kii0bqC4ae4BF+FygtWFKAg==
X-Google-Smtp-Source: AGHT+IEgBiwidzG8ByH2iwN5dAfPS6+RGMljZD4DEHlk72N6ChBSJLk9ES5gBKM28pb3uJhtErHqwA==
X-Received: by 2002:a05:651c:221d:b0:2c9:dae6:4452 with SMTP id y29-20020a05651c221d00b002c9dae64452mr374594ljq.212.1701435528948;
        Fri, 01 Dec 2023 04:58:48 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b002c02b36d381sm417036ljo.88.2023.12.01.04.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:58:47 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/4] net: dsa: mv88e6xxx: Give each hw stat an ID
Date: Fri,  1 Dec 2023 13:58:10 +0100
Message-Id: <20231201125812.1052078-3-tobias@waldekranz.com>
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

With the upcoming standard counter group support, we are no longer
reading out the whole set of counters, but rather mapping a subset to
the requested group.

Therefore, create an enum with an ID for each stat, such that
mv88e6xxx_hw_stats[] can be subscripted with a human-readable ID
corresponding to the counter's name.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 140 +++++++++++++++++--------------
 1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ffd81174bda3..71c60f229a2f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -937,66 +937,80 @@ static int mv88e6xxx_stats_snapshot(struct mv88e6xxx_chip *chip, int port)
 	return chip->info->ops->stats_snapshot(chip, port);
 }
 
-static struct mv88e6xxx_hw_stat mv88e6xxx_hw_stats[] = {
-	{ "in_good_octets",		8, 0x00, STATS_TYPE_BANK0, },
-	{ "in_bad_octets",		4, 0x02, STATS_TYPE_BANK0, },
-	{ "in_unicast",			4, 0x04, STATS_TYPE_BANK0, },
-	{ "in_broadcasts",		4, 0x06, STATS_TYPE_BANK0, },
-	{ "in_multicasts",		4, 0x07, STATS_TYPE_BANK0, },
-	{ "in_pause",			4, 0x16, STATS_TYPE_BANK0, },
-	{ "in_undersize",		4, 0x18, STATS_TYPE_BANK0, },
-	{ "in_fragments",		4, 0x19, STATS_TYPE_BANK0, },
-	{ "in_oversize",		4, 0x1a, STATS_TYPE_BANK0, },
-	{ "in_jabber",			4, 0x1b, STATS_TYPE_BANK0, },
-	{ "in_rx_error",		4, 0x1c, STATS_TYPE_BANK0, },
-	{ "in_fcs_error",		4, 0x1d, STATS_TYPE_BANK0, },
-	{ "out_octets",			8, 0x0e, STATS_TYPE_BANK0, },
-	{ "out_unicast",		4, 0x10, STATS_TYPE_BANK0, },
-	{ "out_broadcasts",		4, 0x13, STATS_TYPE_BANK0, },
-	{ "out_multicasts",		4, 0x12, STATS_TYPE_BANK0, },
-	{ "out_pause",			4, 0x15, STATS_TYPE_BANK0, },
-	{ "excessive",			4, 0x11, STATS_TYPE_BANK0, },
-	{ "collisions",			4, 0x1e, STATS_TYPE_BANK0, },
-	{ "deferred",			4, 0x05, STATS_TYPE_BANK0, },
-	{ "single",			4, 0x14, STATS_TYPE_BANK0, },
-	{ "multiple",			4, 0x17, STATS_TYPE_BANK0, },
-	{ "out_fcs_error",		4, 0x03, STATS_TYPE_BANK0, },
-	{ "late",			4, 0x1f, STATS_TYPE_BANK0, },
-	{ "hist_64bytes",		4, 0x08, STATS_TYPE_BANK0, },
-	{ "hist_65_127bytes",		4, 0x09, STATS_TYPE_BANK0, },
-	{ "hist_128_255bytes",		4, 0x0a, STATS_TYPE_BANK0, },
-	{ "hist_256_511bytes",		4, 0x0b, STATS_TYPE_BANK0, },
-	{ "hist_512_1023bytes",		4, 0x0c, STATS_TYPE_BANK0, },
-	{ "hist_1024_max_bytes",	4, 0x0d, STATS_TYPE_BANK0, },
-	{ "sw_in_discards",		4, 0x10, STATS_TYPE_PORT, },
-	{ "sw_in_filtered",		2, 0x12, STATS_TYPE_PORT, },
-	{ "sw_out_filtered",		2, 0x13, STATS_TYPE_PORT, },
-	{ "in_discards",		4, 0x00, STATS_TYPE_BANK1, },
-	{ "in_filtered",		4, 0x01, STATS_TYPE_BANK1, },
-	{ "in_accepted",		4, 0x02, STATS_TYPE_BANK1, },
-	{ "in_bad_accepted",		4, 0x03, STATS_TYPE_BANK1, },
-	{ "in_good_avb_class_a",	4, 0x04, STATS_TYPE_BANK1, },
-	{ "in_good_avb_class_b",	4, 0x05, STATS_TYPE_BANK1, },
-	{ "in_bad_avb_class_a",		4, 0x06, STATS_TYPE_BANK1, },
-	{ "in_bad_avb_class_b",		4, 0x07, STATS_TYPE_BANK1, },
-	{ "tcam_counter_0",		4, 0x08, STATS_TYPE_BANK1, },
-	{ "tcam_counter_1",		4, 0x09, STATS_TYPE_BANK1, },
-	{ "tcam_counter_2",		4, 0x0a, STATS_TYPE_BANK1, },
-	{ "tcam_counter_3",		4, 0x0b, STATS_TYPE_BANK1, },
-	{ "in_da_unknown",		4, 0x0e, STATS_TYPE_BANK1, },
-	{ "in_management",		4, 0x0f, STATS_TYPE_BANK1, },
-	{ "out_queue_0",		4, 0x10, STATS_TYPE_BANK1, },
-	{ "out_queue_1",		4, 0x11, STATS_TYPE_BANK1, },
-	{ "out_queue_2",		4, 0x12, STATS_TYPE_BANK1, },
-	{ "out_queue_3",		4, 0x13, STATS_TYPE_BANK1, },
-	{ "out_queue_4",		4, 0x14, STATS_TYPE_BANK1, },
-	{ "out_queue_5",		4, 0x15, STATS_TYPE_BANK1, },
-	{ "out_queue_6",		4, 0x16, STATS_TYPE_BANK1, },
-	{ "out_queue_7",		4, 0x17, STATS_TYPE_BANK1, },
-	{ "out_cut_through",		4, 0x18, STATS_TYPE_BANK1, },
-	{ "out_octets_a",		4, 0x1a, STATS_TYPE_BANK1, },
-	{ "out_octets_b",		4, 0x1b, STATS_TYPE_BANK1, },
-	{ "out_management",		4, 0x1f, STATS_TYPE_BANK1, },
+#define MV88E6XXX_HW_STAT_MAPPER(_fn)				   \
+	_fn(in_good_octets,		8, 0x00, STATS_TYPE_BANK0) \
+	_fn(in_bad_octets,		4, 0x02, STATS_TYPE_BANK0) \
+	_fn(in_unicast,			4, 0x04, STATS_TYPE_BANK0) \
+	_fn(in_broadcasts,		4, 0x06, STATS_TYPE_BANK0) \
+	_fn(in_multicasts,		4, 0x07, STATS_TYPE_BANK0) \
+	_fn(in_pause,			4, 0x16, STATS_TYPE_BANK0) \
+	_fn(in_undersize,		4, 0x18, STATS_TYPE_BANK0) \
+	_fn(in_fragments,		4, 0x19, STATS_TYPE_BANK0) \
+	_fn(in_oversize,		4, 0x1a, STATS_TYPE_BANK0) \
+	_fn(in_jabber,			4, 0x1b, STATS_TYPE_BANK0) \
+	_fn(in_rx_error,		4, 0x1c, STATS_TYPE_BANK0) \
+	_fn(in_fcs_error,		4, 0x1d, STATS_TYPE_BANK0) \
+	_fn(out_octets,			8, 0x0e, STATS_TYPE_BANK0) \
+	_fn(out_unicast,		4, 0x10, STATS_TYPE_BANK0) \
+	_fn(out_broadcasts,		4, 0x13, STATS_TYPE_BANK0) \
+	_fn(out_multicasts,		4, 0x12, STATS_TYPE_BANK0) \
+	_fn(out_pause,			4, 0x15, STATS_TYPE_BANK0) \
+	_fn(excessive,			4, 0x11, STATS_TYPE_BANK0) \
+	_fn(collisions,			4, 0x1e, STATS_TYPE_BANK0) \
+	_fn(deferred,			4, 0x05, STATS_TYPE_BANK0) \
+	_fn(single,			4, 0x14, STATS_TYPE_BANK0) \
+	_fn(multiple,			4, 0x17, STATS_TYPE_BANK0) \
+	_fn(out_fcs_error,		4, 0x03, STATS_TYPE_BANK0) \
+	_fn(late,			4, 0x1f, STATS_TYPE_BANK0) \
+	_fn(hist_64bytes,		4, 0x08, STATS_TYPE_BANK0) \
+	_fn(hist_65_127bytes,		4, 0x09, STATS_TYPE_BANK0) \
+	_fn(hist_128_255bytes,		4, 0x0a, STATS_TYPE_BANK0) \
+	_fn(hist_256_511bytes,		4, 0x0b, STATS_TYPE_BANK0) \
+	_fn(hist_512_1023bytes,		4, 0x0c, STATS_TYPE_BANK0) \
+	_fn(hist_1024_max_bytes,	4, 0x0d, STATS_TYPE_BANK0) \
+	_fn(sw_in_discards,		4, 0x10, STATS_TYPE_PORT)  \
+	_fn(sw_in_filtered,		2, 0x12, STATS_TYPE_PORT)  \
+	_fn(sw_out_filtered,		2, 0x13, STATS_TYPE_PORT)  \
+	_fn(in_discards,		4, 0x00, STATS_TYPE_BANK1) \
+	_fn(in_filtered,		4, 0x01, STATS_TYPE_BANK1) \
+	_fn(in_accepted,		4, 0x02, STATS_TYPE_BANK1) \
+	_fn(in_bad_accepted,		4, 0x03, STATS_TYPE_BANK1) \
+	_fn(in_good_avb_class_a,	4, 0x04, STATS_TYPE_BANK1) \
+	_fn(in_good_avb_class_b,	4, 0x05, STATS_TYPE_BANK1) \
+	_fn(in_bad_avb_class_a,		4, 0x06, STATS_TYPE_BANK1) \
+	_fn(in_bad_avb_class_b,		4, 0x07, STATS_TYPE_BANK1) \
+	_fn(tcam_counter_0,		4, 0x08, STATS_TYPE_BANK1) \
+	_fn(tcam_counter_1,		4, 0x09, STATS_TYPE_BANK1) \
+	_fn(tcam_counter_2,		4, 0x0a, STATS_TYPE_BANK1) \
+	_fn(tcam_counter_3,		4, 0x0b, STATS_TYPE_BANK1) \
+	_fn(in_da_unknown,		4, 0x0e, STATS_TYPE_BANK1) \
+	_fn(in_management,		4, 0x0f, STATS_TYPE_BANK1) \
+	_fn(out_queue_0,		4, 0x10, STATS_TYPE_BANK1) \
+	_fn(out_queue_1,		4, 0x11, STATS_TYPE_BANK1) \
+	_fn(out_queue_2,		4, 0x12, STATS_TYPE_BANK1) \
+	_fn(out_queue_3,		4, 0x13, STATS_TYPE_BANK1) \
+	_fn(out_queue_4,		4, 0x14, STATS_TYPE_BANK1) \
+	_fn(out_queue_5,		4, 0x15, STATS_TYPE_BANK1) \
+	_fn(out_queue_6,		4, 0x16, STATS_TYPE_BANK1) \
+	_fn(out_queue_7,		4, 0x17, STATS_TYPE_BANK1) \
+	_fn(out_cut_through,		4, 0x18, STATS_TYPE_BANK1) \
+	_fn(out_octets_a,		4, 0x1a, STATS_TYPE_BANK1) \
+	_fn(out_octets_b,		4, 0x1b, STATS_TYPE_BANK1) \
+	_fn(out_management,		4, 0x1f, STATS_TYPE_BANK1) \
+	/*  */
+
+#define MV88E6XXX_HW_STAT_ENTRY(_string, _size, _reg, _type) \
+	{ #_string, _size, _reg, _type },
+static const struct mv88e6xxx_hw_stat mv88e6xxx_hw_stats[] = {
+	MV88E6XXX_HW_STAT_MAPPER(MV88E6XXX_HW_STAT_ENTRY)
+};
+
+#define MV88E6XXX_HW_STAT_ENUM(_string, _size, _reg, _type) \
+	MV88E6XXX_HW_STAT_ID_ ## _string,
+enum mv88e6xxx_hw_stat_id {
+	MV88E6XXX_HW_STAT_MAPPER(MV88E6XXX_HW_STAT_ENUM)
+
+	MV88E6XXX_HW_STAT_ID_MAX
 };
 
 static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
@@ -1043,7 +1057,7 @@ static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
 static int mv88e6xxx_stats_get_strings(struct mv88e6xxx_chip *chip,
 				       uint8_t *data, int types)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	int i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
@@ -1124,7 +1138,7 @@ static void mv88e6xxx_get_strings(struct dsa_switch *ds, int port,
 static int mv88e6xxx_stats_get_sset_count(struct mv88e6xxx_chip *chip,
 					  int types)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	int i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
@@ -1251,7 +1265,7 @@ static int mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 static int mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
 				     uint64_t *data)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	int i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
-- 
2.34.1


