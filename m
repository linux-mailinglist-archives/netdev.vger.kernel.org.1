Return-Path: <netdev+bounces-56113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B780DE4F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099E71C2154D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0DC55C1D;
	Mon, 11 Dec 2023 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="W3EvdEAB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE8BE
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50c222a022dso5378027e87.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702334042; x=1702938842; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TuUz/G/hsssJ2i28bQik8a5rVzXoX4DNcAtMHuGSA7A=;
        b=W3EvdEABatZpNBMAV4lfYYV5JRjO7nmSIqkyz6BMSehTWBQGr277HyJWJm4pIqP4Zz
         P4ntfx9jdZ/Eiz2Y1QK2m4jI2aMYbYK+lrPllKAP89Ahd9Jw3YOD3THZayHrobV2H3uU
         9MPupOQxne9M5mzjt/nHAcfiljaoyh68oQ7yGWoxDU66W59D/YJrinOxO88JW5+UFWBJ
         kci41x/uF0MnrjvRdiv6X0VBmvxy2zO3KeMQ7XYzPpYqiP9i3qU6AeovRkwKsJUhSeLb
         VszS5E8pKe1FPv7qD1tK9y1xeuq8Y2m4sciVkbXkXqyepj8/QMbS6ggS5T/B4r9MfqbJ
         +6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334042; x=1702938842;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuUz/G/hsssJ2i28bQik8a5rVzXoX4DNcAtMHuGSA7A=;
        b=urJr99E0XYcbxJ6BE+Ue6urGvcPHlhiyrPxnhVjs/BgwxFDbOeggA+V9ZNigNJjnc/
         TVOC0GQzSdShoTx+n9UUjkluxVnUxEsB8V3COLJbmHjqMs3E5rQbU6HnZaKE97VA+4n0
         mecJHiJguL267gWKvx7mgmGB5iM24Sa53mHF2g1+Q3p0a1SKVzlbk2Ee9CrhGc7E44ji
         wsYjiD9ObP+PDfFoLwwbMV9tY28NKQ5y4HVj71QRo+yPGkdQYhUYZ1+sX9aQbGG46lpc
         vHNe8Nc1oAX8GAnwEykUFFkTdRx5vGVEv3Gztc2fEBU98cvkBvJUOjYHDDcjtg7ie1CY
         13vQ==
X-Gm-Message-State: AOJu0Yzp+jI+L4t7i3Vmy4APmfdKi/v26Y90G5pT6pB3CyzfPlbFndGX
	kZ0Xmf9OKpZNmibrW3w5kQ4BmA==
X-Google-Smtp-Source: AGHT+IEpqtw0u+zF8R1KsJnMXodpBxCCmznqCc7ikLKCnknA826b6uloKLfajgafrYJYZPOw8r2RKQ==
X-Received: by 2002:a05:6512:15a0:b0:50b:f05b:3e0c with SMTP id bp32-20020a05651215a000b0050bf05b3e0cmr2622245lfb.79.1702334042388;
        Mon, 11 Dec 2023 14:34:02 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b0050bfc6dbb8asm1217649lfg.302.2023.12.11.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:34:01 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v3 net-next 4/8] net: dsa: mv88e6xxx: Give each hw stat an ID
Date: Mon, 11 Dec 2023 23:33:42 +0100
Message-Id: <20231211223346.2497157-5-tobias@waldekranz.com>
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

With the upcoming standard counter group support, we are no longer
reading out the whole set of counters, but rather mapping a subset to
the requested group.

Therefore, create an enum with an ID for each stat, such that
mv88e6xxx_hw_stats[] can be subscripted with a human-readable ID
corresponding to the counter's name.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 138 +++++++++++++++++--------------
 1 file changed, 75 insertions(+), 63 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index d0cce23c98ff..cbbaf393ed28 100644
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
 static int mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
 				     uint64_t *data)
 {
-	struct mv88e6xxx_hw_stat *stat;
+	const struct mv88e6xxx_hw_stat *stat;
 	size_t i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
-- 
2.34.1


