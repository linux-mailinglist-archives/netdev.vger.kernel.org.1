Return-Path: <netdev+bounces-54007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4620805972
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0EC281F50
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3063DEA;
	Tue,  5 Dec 2023 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="y4VDeulw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947861AB
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:04:34 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf32c0140so3117121e87.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701792273; x=1702397073; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xMdddzjnP7GhllYxAe3T7JpoJBJY99oU2geak9/1xp4=;
        b=y4VDeulw1++WSnIp47WA/ZTjrSVS/ZvFiJ+tObHo/uWvNBUmiymYL0rsvrC856quBr
         6zwF5cWwWRywPvs0gbR1qN5M1gWQJ+Cay+n/aEZM9G2G/h2+ePCTsT4Tz7PfXcE+M9wo
         kk9CnvIhGaD4TXTkNEdYp7PEdiHfyWJAJxsXbtYZTi8Xii5hhawUJLy+Qtl6clvYiUta
         PcD//qqQmgSVCHjL77UjvMj4ny+ZPt/LN/zMCwCpfztYHxiEGU7pxEXPtNq+5x6hZaHA
         z1ySC+w9RwsrMP0PcfZ8L1+g6hRJGNMy656ubrUyG2eplfEVMMDAUNxqutDWTCzUE6/c
         15Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792273; x=1702397073;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMdddzjnP7GhllYxAe3T7JpoJBJY99oU2geak9/1xp4=;
        b=ltp2cxhl/uVcdSoaq8Da+mG+sveanxrmucjNC2Jv4Np6P4OxhzpwKeIOR250vdVh/G
         B7Fj16aMOYqNnz7lMgXLAV7QwtI3pMKFlepojITt5mZkPDD/2AASGVG16EoDu15mN594
         zrrF6w2jOZdGBO/K2CwMusFIEh/MVLi8le1635Hh7qUm1bKrEVIXCxrYHEnGBz8nNOy6
         8Jbl3HDQzkf9G9KA9OVBL5PsMHyw4bI28uFkQYzJiD7JwRBZfxWZ90IwNgZb5n03mrhr
         T2vk15t09dSgW2u2TfF53bIiCL2oOwt+h+1UJZgWblEHEbKQUsuv2zT24Fn6tj97/EtP
         iF+w==
X-Gm-Message-State: AOJu0YyNBkUyMeXcdVpom0UQMyC0QFHhp/FgDjHOHQUEF0+IdiBlyERB
	Af9TZHtgWAKTR2iZhEzpLWgXag==
X-Google-Smtp-Source: AGHT+IEGTeeaCbHmw9tSFVMcy/QvxMwR4eT5V9k4Hv4/lMnt31/C5T8F3mRURE/XzTdedO3l5Ayxuw==
X-Received: by 2002:a05:6512:1327:b0:50b:d4c7:193c with SMTP id x39-20020a056512132700b0050bd4c7193cmr4459146lfu.24.1701792272900;
        Tue, 05 Dec 2023 08:04:32 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0050c0bbbe3d2sm171341lfl.256.2023.12.05.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:04:32 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 4/6] net: dsa: mv88e6xxx: Give each hw stat an ID
Date: Tue,  5 Dec 2023 17:04:16 +0100
Message-Id: <20231205160418.3770042-5-tobias@waldekranz.com>
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

With the upcoming standard counter group support, we are no longer
reading out the whole set of counters, but rather mapping a subset to
the requested group.

Therefore, create an enum with an ID for each stat, such that
mv88e6xxx_hw_stats[] can be subscripted with a human-readable ID
corresponding to the counter's name.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 138 +++++++++++++++++--------------
 1 file changed, 75 insertions(+), 63 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index bb18b47de49c..473f31761b26 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -943,66 +943,78 @@ static int mv88e6xxx_stats_snapshot(struct mv88e6xxx_chip *chip, int port)
 	return err;
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
+#define MV88E6XXX_HW_STAT_MAPPER(_fn)				    \
+	_fn(in_good_octets,		8, 0x00, STATS_TYPE_BANK0), \
+	_fn(in_bad_octets,		4, 0x02, STATS_TYPE_BANK0), \
+	_fn(in_unicast,			4, 0x04, STATS_TYPE_BANK0), \
+	_fn(in_broadcasts,		4, 0x06, STATS_TYPE_BANK0), \
+	_fn(in_multicasts,		4, 0x07, STATS_TYPE_BANK0), \
+	_fn(in_pause,			4, 0x16, STATS_TYPE_BANK0), \
+	_fn(in_undersize,		4, 0x18, STATS_TYPE_BANK0), \
+	_fn(in_fragments,		4, 0x19, STATS_TYPE_BANK0), \
+	_fn(in_oversize,		4, 0x1a, STATS_TYPE_BANK0), \
+	_fn(in_jabber,			4, 0x1b, STATS_TYPE_BANK0), \
+	_fn(in_rx_error,		4, 0x1c, STATS_TYPE_BANK0), \
+	_fn(in_fcs_error,		4, 0x1d, STATS_TYPE_BANK0), \
+	_fn(out_octets,			8, 0x0e, STATS_TYPE_BANK0), \
+	_fn(out_unicast,		4, 0x10, STATS_TYPE_BANK0), \
+	_fn(out_broadcasts,		4, 0x13, STATS_TYPE_BANK0), \
+	_fn(out_multicasts,		4, 0x12, STATS_TYPE_BANK0), \
+	_fn(out_pause,			4, 0x15, STATS_TYPE_BANK0), \
+	_fn(excessive,			4, 0x11, STATS_TYPE_BANK0), \
+	_fn(collisions,			4, 0x1e, STATS_TYPE_BANK0), \
+	_fn(deferred,			4, 0x05, STATS_TYPE_BANK0), \
+	_fn(single,			4, 0x14, STATS_TYPE_BANK0), \
+	_fn(multiple,			4, 0x17, STATS_TYPE_BANK0), \
+	_fn(out_fcs_error,		4, 0x03, STATS_TYPE_BANK0), \
+	_fn(late,			4, 0x1f, STATS_TYPE_BANK0), \
+	_fn(hist_64bytes,		4, 0x08, STATS_TYPE_BANK0), \
+	_fn(hist_65_127bytes,		4, 0x09, STATS_TYPE_BANK0), \
+	_fn(hist_128_255bytes,		4, 0x0a, STATS_TYPE_BANK0), \
+	_fn(hist_256_511bytes,		4, 0x0b, STATS_TYPE_BANK0), \
+	_fn(hist_512_1023bytes,		4, 0x0c, STATS_TYPE_BANK0), \
+	_fn(hist_1024_max_bytes,	4, 0x0d, STATS_TYPE_BANK0), \
+	_fn(sw_in_discards,		4, 0x10, STATS_TYPE_PORT), \
+	_fn(sw_in_filtered,		2, 0x12, STATS_TYPE_PORT), \
+	_fn(sw_out_filtered,		2, 0x13, STATS_TYPE_PORT), \
+	_fn(in_discards,		4, 0x00, STATS_TYPE_BANK1), \
+	_fn(in_filtered,		4, 0x01, STATS_TYPE_BANK1), \
+	_fn(in_accepted,		4, 0x02, STATS_TYPE_BANK1), \
+	_fn(in_bad_accepted,		4, 0x03, STATS_TYPE_BANK1), \
+	_fn(in_good_avb_class_a,	4, 0x04, STATS_TYPE_BANK1), \
+	_fn(in_good_avb_class_b,	4, 0x05, STATS_TYPE_BANK1), \
+	_fn(in_bad_avb_class_a,		4, 0x06, STATS_TYPE_BANK1), \
+	_fn(in_bad_avb_class_b,		4, 0x07, STATS_TYPE_BANK1), \
+	_fn(tcam_counter_0,		4, 0x08, STATS_TYPE_BANK1), \
+	_fn(tcam_counter_1,		4, 0x09, STATS_TYPE_BANK1), \
+	_fn(tcam_counter_2,		4, 0x0a, STATS_TYPE_BANK1), \
+	_fn(tcam_counter_3,		4, 0x0b, STATS_TYPE_BANK1), \
+	_fn(in_da_unknown,		4, 0x0e, STATS_TYPE_BANK1), \
+	_fn(in_management,		4, 0x0f, STATS_TYPE_BANK1), \
+	_fn(out_queue_0,		4, 0x10, STATS_TYPE_BANK1), \
+	_fn(out_queue_1,		4, 0x11, STATS_TYPE_BANK1), \
+	_fn(out_queue_2,		4, 0x12, STATS_TYPE_BANK1), \
+	_fn(out_queue_3,		4, 0x13, STATS_TYPE_BANK1), \
+	_fn(out_queue_4,		4, 0x14, STATS_TYPE_BANK1), \
+	_fn(out_queue_5,		4, 0x15, STATS_TYPE_BANK1), \
+	_fn(out_queue_6,		4, 0x16, STATS_TYPE_BANK1), \
+	_fn(out_queue_7,		4, 0x17, STATS_TYPE_BANK1), \
+	_fn(out_cut_through,		4, 0x18, STATS_TYPE_BANK1), \
+	_fn(out_octets_a,		4, 0x1a, STATS_TYPE_BANK1), \
+	_fn(out_octets_b,		4, 0x1b, STATS_TYPE_BANK1), \
+	_fn(out_management,		4, 0x1f, STATS_TYPE_BANK1), \
+	/*  */
+
+#define MV88E6XXX_HW_STAT_ENTRY(_string, _size, _reg, _type) \
+	{ #_string, _size, _reg, _type }
+static const struct mv88e6xxx_hw_stat mv88e6xxx_hw_stats[] = {
+	MV88E6XXX_HW_STAT_MAPPER(MV88E6XXX_HW_STAT_ENTRY)
+};
+
+#define MV88E6XXX_HW_STAT_ENUM(_string, _size, _reg, _type) \
+	MV88E6XXX_HW_STAT_ID_ ## _string
+enum mv88e6xxx_hw_stat_id {
+	MV88E6XXX_HW_STAT_MAPPER(MV88E6XXX_HW_STAT_ENUM)
 };
 
 static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
@@ -1049,7 +1061,7 @@ static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
 static int mv88e6xxx_stats_get_strings(struct mv88e6xxx_chip *chip,
 				       uint8_t *data, int types)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	int i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
@@ -1130,7 +1142,7 @@ static void mv88e6xxx_get_strings(struct dsa_switch *ds, int port,
 static int mv88e6xxx_stats_get_sset_count(struct mv88e6xxx_chip *chip,
 					  int types)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	int i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
@@ -1257,7 +1269,7 @@ static size_t mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 static int mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
 				     uint64_t *data)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	size_t i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
-- 
2.34.1


