Return-Path: <netdev+bounces-236681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1AAC3EE4B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598993B0625
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC021313E2A;
	Fri,  7 Nov 2025 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTpYIB2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A03313532
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502895; cv=none; b=erc40Syu2VkEUZYA1QRfEQL04JyqP16fYv5FnvrWSrGXsX+OE/pBsKIiMVCfYtZhF2TDgjJChWR2OWHOIkpQYgUKsQtF1LhaAT7ZWHBjVoMhpwbZtfzmlf7Th0bLqIiXxMZbPdy4PdL8gc1Sd8AzBr1yEQixKlpP4LGh5aY3Mrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502895; c=relaxed/simple;
	bh=fn0piwHHX8ir16QQNvantQ27c+ublvYdiUMR9gXOvsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3nhbNNEVEa2x8TCtT60dH704aoSi1ROYwQTFelWklVpED1iL0vMREXg7A6HFPDO/4XujF8nzibNMvDqhl1svjiUb1Qzvc8hFBPsJW5qkefxsCTX9o5eB2hGIljeHzrUKGc8gheP0GKCqD0XGbFJCNHmpHS29WLRGTG68w4v1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTpYIB2r; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso743070a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502891; x=1763107691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAbW6u5pPeCbc23UbdkfRXIbK91z4t3E/qRGXTD33Cg=;
        b=lTpYIB2r8Tc1tAJar0S6vc8bOofb7u/vZeLk9Jz/4WwafmWm8MosywMxsJtLhfEHG6
         4X490o1VZwpHbWfabp9q92YtVc/JfK7R5aMRDKMlbcpTL3lvIqoNVREeNSJs+lNdwt6p
         RTQfUZ8p2Rzr9Q569KYQs2Dm6pmiQ96Fo+H7k38J8tMCSqe0OpTLR0wbzZ/em9djbSxy
         QFDcXbhMZPPt9PCx7bWcRz6rCK6ledPpDDFUnU8x9x2FLwL8pOyyDQlm6o3IWytBECHK
         oAcWBH5zln92kMmG8AgDcR9e/CoR0SA8pleto5pa47tUb31CUPH5cO2dYmtuhqL/ZUu5
         xV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502891; x=1763107691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAbW6u5pPeCbc23UbdkfRXIbK91z4t3E/qRGXTD33Cg=;
        b=dqasOIKBTJhuPiHIvWfy6j+XQOFYQdfJZ0w64mxlUHVPPSgBQusLj7RpH4UosoIKfD
         vsVOvcw1Kr59tLegj36kwF7LhbOuIAV4I0AW1csg3cVsZ5Yke+Pd+Sj/sZrp6rhXSTOS
         a5w9cqbP6H7oBb3p6W/GtsRTcN1+Juf5d/0NxNuUmwFtIS17xoaVtDhXqmJEkvjtg6bn
         wfBgrpy9HcHF5BKPPyLbfyUps9uaj3Vs+xgSvrf6SsSjd+ZJad/FlbkrXPp2/gsB1+C0
         yv+rMQ+QAC0CV2nTtV0XZb1odm3K3+cgNN3N918OXi7JQ2oujtwfiwU8e5lLdm+04NPo
         pN1g==
X-Gm-Message-State: AOJu0YzivbeHxC6WR2I7FiG8uVDpqhP0LPDkGL6GLvRcZ5yFUGQwLtrF
	ar9Q9CCTzGCIErW0y79uZVpFDGNiE0AN89dmhWxSP9WEh0u51GxZVTVE
X-Gm-Gg: ASbGnctfH7RGUAJrWyzfeQ7MTOAGQa6ZCFnzzjHC3J30uDIS7pcXAXmA2rGnqzIfwWb
	XRtxXCgrXFLJC35qkS2senxhrgtKfZeEhy53Lbl4CDdA0zf9Q/FGvRvqR+UTRy6qoLhfLvkevGH
	DgrFZmE0bBcq1UnH+vHxrB8IecE1DfDL1KhhIzEh1eQFm8GU7xoDrqiYWF3YqUgu/C16gEEWVL/
	GqeqtjcUC7fRcCeHwP2w69gQiAdN1uYd7EGkSDHhxXn2F9GOzjnCZTotOkHodEN6VRuoqmKRhf8
	vWCyi5JSh1OjWMF8hlgl8ZJoHS9KImtoNkUvsB7bHkE1jkLkDo8uB8k1plSl6QGwTQGwaF0xC5n
	MbkQL/o5dMwXuJ6DgUA8bKBXmN6JP14uyq9CCzvjhto1OLy2tqLCrhPWbfRNi6EPQ+arl7cAKWt
	7FQd87alwX7xUidnuQ15nAJ7ZE9LvthoIpc5qtZtcOEyrzt8BWGco51vU+xu2PpTJ0C3A=
X-Google-Smtp-Source: AGHT+IF7O7QJ2kAFACQQzwx2SwACX6580PsjZQMl5XtCZs1f6ZD3zs+9sKXPqkpiDb12JYf6ussacw==
X-Received: by 2002:a17:907:3e88:b0:b5c:6e0b:3706 with SMTP id a640c23a62f3a-b72d0a3a93bmr100861766b.13.1762502886219;
        Fri, 07 Nov 2025 00:08:06 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d43bsm179882466b.45.2025.11.07.00.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:05 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/8] net: dsa: b53: move ARL entry functions into ops struct
Date: Fri,  7 Nov 2025 09:07:47 +0100
Message-ID: <20251107080749.26936-7-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the differences in ARL entry formats are neatly contained into
functions per chip family, wrap them into an ops struct and add wrapper
functions to access them.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 67 ++++++++++++++++++++++----------
 drivers/net/dsa/b53/b53_priv.h   | 30 ++++++++++++++
 2 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index fa4cf6ceddb8..c69022cc85bf 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1910,10 +1910,7 @@ static int b53_arl_read(struct b53_device *dev, const u8 *mac,
 
 	/* Read the bins */
 	for (i = 0; i < dev->num_arl_bins; i++) {
-		if (is5325(dev) || is5365(dev))
-			b53_arl_read_entry_25(dev, ent, i);
-		else
-			b53_arl_read_entry_95(dev, ent, i);
+		b53_arl_read_entry(dev, ent, i);
 
 		if (!ent->is_valid) {
 			set_bit(i, free_bins);
@@ -1995,10 +1992,7 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	ent.is_static = true;
 	ent.is_age = false;
 	memcpy(ent.mac, addr, ETH_ALEN);
-	if (is5325(dev) || is5365(dev))
-		b53_arl_write_entry_25(dev, &ent, idx);
-	else
-		b53_arl_write_entry_95(dev, &ent, idx);
+	b53_arl_write_entry(dev, &ent, idx);
 
 	return b53_arl_rw_op(dev, 0);
 }
@@ -2109,17 +2103,6 @@ static void b53_arl_search_read_95(struct b53_device *dev, u8 idx,
 	b53_arl_to_entry(ent, mac_vid, fwd_entry);
 }
 
-static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
-			      struct b53_arl_entry *ent)
-{
-	if (is5325(dev))
-		b53_arl_search_read_25(dev, idx, ent);
-	else if (is5365(dev))
-		b53_arl_search_read_65(dev, idx, ent);
-	else
-		b53_arl_search_read_95(dev, idx, ent);
-}
-
 static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
 			dsa_fdb_dump_cb_t *cb, void *data)
 {
@@ -2153,13 +2136,13 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 		if (ret)
 			break;
 
-		b53_arl_search_rd(priv, 0, &results[0]);
+		b53_arl_search_read(priv, 0, &results[0]);
 		ret = b53_fdb_copy(port, &results[0], cb, data);
 		if (ret)
 			break;
 
 		if (results_per_hit == 2) {
-			b53_arl_search_rd(priv, 1, &results[1]);
+			b53_arl_search_read(priv, 1, &results[1]);
 			ret = b53_fdb_copy(port, &results[1], cb, data);
 			if (ret)
 				break;
@@ -2688,6 +2671,24 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.port_change_mtu	= b53_change_mtu,
 };
 
+static const struct b53_arl_ops b53_arl_ops_25 = {
+	.arl_read_entry = b53_arl_read_entry_25,
+	.arl_write_entry = b53_arl_write_entry_25,
+	.arl_search_read = b53_arl_search_read_25,
+};
+
+static const struct b53_arl_ops b53_arl_ops_65 = {
+	.arl_read_entry = b53_arl_read_entry_25,
+	.arl_write_entry = b53_arl_write_entry_25,
+	.arl_search_read = b53_arl_search_read_65,
+};
+
+static const struct b53_arl_ops b53_arl_ops_95 = {
+	.arl_read_entry = b53_arl_read_entry_95,
+	.arl_write_entry = b53_arl_write_entry_95,
+	.arl_search_read = b53_arl_search_read_95,
+};
+
 struct b53_chip_data {
 	u32 chip_id;
 	const char *dev_name;
@@ -2701,6 +2702,7 @@ struct b53_chip_data {
 	u8 duplex_reg;
 	u8 jumbo_pm_reg;
 	u8 jumbo_size_reg;
+	const struct b53_arl_ops *arl_ops;
 };
 
 #define B53_VTA_REGS	\
@@ -2720,6 +2722,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.arl_buckets = 1024,
 		.imp_port = 5,
 		.duplex_reg = B53_DUPLEX_STAT_FE,
+		.arl_ops = &b53_arl_ops_25,
 	},
 	{
 		.chip_id = BCM5365_DEVICE_ID,
@@ -2730,6 +2733,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.arl_buckets = 1024,
 		.imp_port = 5,
 		.duplex_reg = B53_DUPLEX_STAT_FE,
+		.arl_ops = &b53_arl_ops_65,
 	},
 	{
 		.chip_id = BCM5389_DEVICE_ID,
@@ -2743,6 +2747,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM5395_DEVICE_ID,
@@ -2756,6 +2761,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM5397_DEVICE_ID,
@@ -2769,6 +2775,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM5398_DEVICE_ID,
@@ -2782,6 +2789,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53101_DEVICE_ID,
@@ -2795,6 +2803,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53115_DEVICE_ID,
@@ -2808,6 +2817,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53125_DEVICE_ID,
@@ -2821,6 +2831,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53128_DEVICE_ID,
@@ -2834,6 +2845,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM63XX_DEVICE_ID,
@@ -2847,6 +2859,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_63XX,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK_63XX,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE_63XX,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53010_DEVICE_ID,
@@ -2860,6 +2873,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53011_DEVICE_ID,
@@ -2873,6 +2887,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53012_DEVICE_ID,
@@ -2886,6 +2901,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53018_DEVICE_ID,
@@ -2899,6 +2915,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53019_DEVICE_ID,
@@ -2912,6 +2929,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM58XX_DEVICE_ID,
@@ -2925,6 +2943,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM583XX_DEVICE_ID,
@@ -2938,6 +2957,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	/* Starfighter 2 */
 	{
@@ -2952,6 +2972,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM7445_DEVICE_ID,
@@ -2965,6 +2986,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM7278_DEVICE_ID,
@@ -2978,6 +3000,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53134_DEVICE_ID,
@@ -2992,6 +3015,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 };
 
@@ -3020,6 +3044,7 @@ static int b53_switch_init(struct b53_device *dev)
 			dev->num_vlans = chip->vlans;
 			dev->num_arl_bins = chip->arl_bins;
 			dev->num_arl_buckets = chip->arl_buckets;
+			dev->arl_ops = chip->arl_ops;
 			break;
 		}
 	}
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 458775f95164..ef2413509b5d 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -58,6 +58,17 @@ struct b53_io_ops {
 				bool link_up);
 };
 
+struct b53_arl_entry;
+
+struct b53_arl_ops {
+	void (*arl_read_entry)(struct b53_device *dev,
+			       struct b53_arl_entry *ent, u8 idx);
+	void (*arl_write_entry)(struct b53_device *dev,
+				const struct b53_arl_entry *ent, u8 idx);
+	void (*arl_search_read)(struct b53_device *dev, u8 idx,
+				struct b53_arl_entry *ent);
+};
+
 #define B53_INVALID_LANE	0xff
 
 enum {
@@ -127,6 +138,7 @@ struct b53_device {
 	struct mutex stats_mutex;
 	struct mutex arl_mutex;
 	const struct b53_io_ops *ops;
+	const struct b53_arl_ops *arl_ops;
 
 	/* chip specific data */
 	u32 chip_id;
@@ -371,6 +383,24 @@ static inline void b53_arl_from_entry_25(u64 *mac_vid,
 		*mac_vid |= ARLTBL_AGE_25;
 }
 
+static inline void b53_arl_read_entry(struct b53_device *dev,
+				      struct b53_arl_entry *ent, u8 idx)
+{
+	dev->arl_ops->arl_read_entry(dev, ent, idx);
+}
+
+static inline void b53_arl_write_entry(struct b53_device *dev,
+				       const struct b53_arl_entry *ent, u8 idx)
+{
+	dev->arl_ops->arl_write_entry(dev, ent, idx);
+}
+
+static inline void b53_arl_search_read(struct b53_device *dev, u8 idx,
+				       struct b53_arl_entry *ent)
+{
+	dev->arl_ops->arl_search_read(dev, idx, ent);
+}
+
 #ifdef CONFIG_BCM47XX
 
 #include <linux/bcm47xx_nvram.h>
-- 
2.43.0


