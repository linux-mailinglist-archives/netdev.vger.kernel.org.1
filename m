Return-Path: <netdev+bounces-57467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BDB81322A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772CB2815A4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EAE59E23;
	Thu, 14 Dec 2023 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="r6ZjUWjb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174C1111
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:53 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f72176cfso103279591fa.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561851; x=1703166651; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kVVuY6I+v7ha3taX7aBxdQGRb0A+S3ZzOPRoJC+jSXc=;
        b=r6ZjUWjbn/Y8hUQzX29eSEaZP22uHzrlxK0BldqVFGqoHsVffmOP6eiSouDDF4Rxt0
         Bw2M0m9sTBhrP9qArcQyCgMuNH04MOaqRTP90yiG2MAwjsXjsplnPNa69bJUiR41Yuj2
         FaNBxdHT2kwaUmz6LqVznY1XtodiacfXeZ2VYnSXbqwfec4XFeVh4H/+lZHWek2vvEM3
         iiClW879a+wr95emzSeJBkYy4fwKASk8Et1Lbe+D689VCB/e+1/FL2LTubhNxLNwTXLl
         mXZTr2F9Rh+dNScl9noaXG5g/2CZP1z31YfX9m1uoaV0l9XRJJkWyG4jy69HETeKy1HG
         v7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561851; x=1703166651;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVVuY6I+v7ha3taX7aBxdQGRb0A+S3ZzOPRoJC+jSXc=;
        b=NL2RtMcgx49cw3yFjdi50jJGVbXj5mETmfqmgau02J7Uzx6eh+oAUs7PBZ2Ev8gCDv
         R4aatPpw43J5OweCg7FxWKBmm0/yvSKUjmNrfOGSAuRGY2fZFJtRNLsNJ/+ysgoGC3Zy
         xSo1BU5pMnZYr8yciwyXxPtxxzM8sXRb1RgBDLx4fF/5GXMpWmyyvUn1d4OK1VknShBh
         bcBJYUpVda4IQT/XnaKnfKBEV0FmfCyCiEIgHGeGBBeT0ywXAGBY0pVXhReFZd9FPgGC
         K5GjnJVv4PWfALVRhx6uETYNb2IC2htbRq1Tizcin8wDcBeLYeZqgr/FJberK3YgFqfz
         IePQ==
X-Gm-Message-State: AOJu0Yy2IGCRCxnJ6uYxJ0OmRB4q8sJc30Tljhm234iHeQRXaEcAty7t
	bzJl8G7akENAsxqlmKYuaf638YAsEdcUXUgoTUI=
X-Google-Smtp-Source: AGHT+IE+LWl2UhEWdQSFR3LeckQv7AyxiNVspwRcZRZHh94SWcqYgajmJvKaDlASBFfyePn6WLoC5w==
X-Received: by 2002:a2e:8447:0:b0:2ca:ad:172c with SMTP id u7-20020a2e8447000000b002ca00ad172cmr2181623ljh.39.1702561851283;
        Thu, 14 Dec 2023 05:50:51 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:50 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v4 net-next 4/8] net: dsa: mv88e6xxx: Give each hw stat an ID
Date: Thu, 14 Dec 2023 14:50:25 +0100
Message-Id: <20231214135029.383595-5-tobias@waldekranz.com>
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

With the upcoming standard counter group support, we are no longer
reading out the whole set of counters, but rather mapping a subset to
the requested group.

Therefore, create an enum with an ID for each stat, such that
mv88e6xxx_hw_stats[] can be subscripted with a human-readable ID
corresponding to the counter's name.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 138 +++++++++++++++++--------------
 1 file changed, 75 insertions(+), 63 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 1f41479fd2a1..c1cfe4f72868 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -955,66 +955,78 @@ static int mv88e6xxx_stats_snapshot(struct mv88e6xxx_chip *chip, int port)
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
@@ -1061,7 +1073,7 @@ static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
 static int mv88e6xxx_stats_get_strings(struct mv88e6xxx_chip *chip,
 				       uint8_t *data, int types)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	int i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
@@ -1142,7 +1154,7 @@ static void mv88e6xxx_get_strings(struct dsa_switch *ds, int port,
 static int mv88e6xxx_stats_get_sset_count(struct mv88e6xxx_chip *chip,
 					  int types)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	int i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
@@ -1269,7 +1281,7 @@ static size_t mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 static size_t mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
 					uint64_t *data)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	size_t i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
-- 
2.34.1


