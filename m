Return-Path: <netdev+bounces-242509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90AC91189
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C39DE4E3A66
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F512E6CDF;
	Fri, 28 Nov 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS5pi9Kh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F72E612F
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317206; cv=none; b=YGWlSq6KRhGLk5BjsoQZu8pOnXhCVxC2CypOSLELvnrg2dTLJMPjqMKokdgXtwdcN2T5X+UdNDPy46ZKto+ifcPFmFCChrxP+ir+FYGQL9gGAJRkulaKGNz6MIVAIyO22pna3vpACqKQ6cZcVX1NAg/WLj+LDRrkCAQOzcI1syE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317206; c=relaxed/simple;
	bh=X1qVuWKg5LC+5uypLN15clhqTXgv9kChaTduyUvJVR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJL6tvowGloWscxSDAWq2c+Vtp9D3MqgNmmYzYZZieGqbc8rw0ebCErbsttXyPkLCULjPO14XaHrx+YolC615Ikoz9Fgo6wSoyGWTuaY7A1tJ7VU5s0SrGpliPHMk/CLOl90pDG5BKbaW8JmjxCenD7MFyvWh+iQRJpqziBdMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS5pi9Kh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b737502f77bso227010466b.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317203; x=1764922003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ47mTHbDublsrTgcLLBlmXBqqs45G74NvDIa1WW3Tk=;
        b=YS5pi9Khi91V3wfuaLBTv7xyNia1t5ZMI8rjVTLMPd47HH+Sz6vtfo3i16TsRozG66
         07CygW8NUNnOd6I6Vk65NnqgTLfU4EN+39KZJqYfI+mA0GDhQgQCrR/rdffBHGvaS9RD
         lkRwdcAd7h7ReQnBwZM5wLuQ2sNhbZIaxCRhH8r7RXRSZJXBCyJ9Lyqf63/Dl3D4z2og
         Z85PGttb5yECldl4b85sNyBEEFAK3CyotMUqaTmut6tJtVsLoQQrOj+8PZnfqNhOi6DH
         MdLOCpct0eVCE24Xi0DmqSQA8S9SztDcCBAIAD8U1wlrTbQrP8Sa7vJqujqDijbIR5rQ
         4Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317203; x=1764922003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZ47mTHbDublsrTgcLLBlmXBqqs45G74NvDIa1WW3Tk=;
        b=wJARBQF32JdwTF2beH+BiEOd4DGMs8sauU4PEtSIotFumL5Fdna9YoKOaICYYTQ+/a
         GmLXDrYnIDAbOWIqKjWd9gjBhkhRMvi2gu83Uby+9a0oaZqXaVjkVs9CW8VGhb1Q1fLG
         xLaiFc2YbXM4lhx6y49BJF3jQtfjmo7rQ3auQcv8b7PMV/5jF3g8YODKo6qFyWA19+Yz
         6IDR4CxSAfG7UtT0Q9Cq82bTTy/11G4n5CZHhxtM9Kza+fMGf9vXbHwCMb55gFnVpvzZ
         RNePK91TZrX+s2dO41kjTyi0hWX40iVh5BKdf+gt/JvDbq9KEoAMNDt5zN3RGe+tR0GM
         1Dfw==
X-Forwarded-Encrypted: i=1; AJvYcCV+vPeDv4Gsg1NeVM37dAbjvnkvKI59iYuSTxpRwkFGTH5aEZqpHL9lWLvLLUvkVyMCHRCie6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQegFg4J7csKvzudwN5OFmqSucGV8+jJ0nAL1paQBUzCSmsm98
	P8W2FUwWNfvLTr3DLG5iVJRvPRDYoZzzQsq7owO1FPFEcsM+43AhFrwnCOaabg==
X-Gm-Gg: ASbGnctzmshtCcE0CAHTrA/YF6Ip20M3sFD7S6e3nam9DXMViMXTcxixDzn349kFGtF
	WDt1BYVM1cTJ5x7NjnL8BzdyzyT1cv48CVSiUwf/ctlAkX0/GEjRVT1eMwOzn7krEc/VNjwju6f
	ruVaYTmT3bBRP3Uvquk4PH/5fhYkEmavi8W30+ZzBJEmYRjJtrNM4XMdMK3CIkU6jT46oVvNf6p
	61RLMfYCSE+v/R9YftKydQTGJPGGL3TcJd9auq95ILccr5qz9qVmhGB42twzXTsL3c9tJ0Iu6PZ
	XqEFH1vGRPJ5e0dmnRTtJy7mk0yvn+htIfV9jPwTDrGlmfZXHF/gw0O1Hz+YUTw0irP99yKqh4/
	EZTtLqCniMK/cgQNURoxgJF+E4cy39eAcpUTWC1uXneH9biJEXUCW+mt5HbFOUP/BG59b6isDtF
	kAsmRVbjslAs+tSGR3oujgx547qsTM3pTA8RW5ORfPB303nKgsQwbke2EgtCtdJPElETQ=
X-Google-Smtp-Source: AGHT+IHW2siV5ckYcc742NVWvgMIg5CmtN8EU9VkV7iP9Ug8rnAA56XOvy1t5p+p5iKICt4JzTZkhA==
X-Received: by 2002:a17:907:94c1:b0:b72:de4f:cea6 with SMTP id a640c23a62f3a-b76c555e67cmr1634710866b.48.1764317203063;
        Fri, 28 Nov 2025 00:06:43 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59eb3f6sm370860266b.55.2025.11.28.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:06:41 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/7] net: dsa: b53: use same ARL search result offset for BCM5325/65
Date: Fri, 28 Nov 2025 09:06:21 +0100
Message-ID: <20251128080625.27181-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128080625.27181-1-jonas.gorski@gmail.com>
References: <20251128080625.27181-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5365's search result is at the same offset as BCM5325's search
result, and they (mostly) share the same format, so switch BCM5365 to
BCM5325's arl ops.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
 * added Review tag from Florian
 * added Tested tag from Álvaro

 drivers/net/dsa/b53/b53_common.c | 18 +-----------------
 drivers/net/dsa/b53/b53_regs.h   |  4 +---
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 7f24d2d8f938..91b0b4de475f 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2125,16 +2125,6 @@ static void b53_arl_search_read_25(struct b53_device *dev, u8 idx,
 	b53_arl_to_entry_25(ent, mac_vid);
 }
 
-static void b53_arl_search_read_65(struct b53_device *dev, u8 idx,
-				   struct b53_arl_entry *ent)
-{
-	u64 mac_vid;
-
-	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_65,
-		   &mac_vid);
-	b53_arl_to_entry_25(ent, mac_vid);
-}
-
 static void b53_arl_search_read_89(struct b53_device *dev, u8 idx,
 				   struct b53_arl_entry *ent)
 {
@@ -2746,12 +2736,6 @@ static const struct b53_arl_ops b53_arl_ops_25 = {
 	.arl_search_read = b53_arl_search_read_25,
 };
 
-static const struct b53_arl_ops b53_arl_ops_65 = {
-	.arl_read_entry = b53_arl_read_entry_25,
-	.arl_write_entry = b53_arl_write_entry_25,
-	.arl_search_read = b53_arl_search_read_65,
-};
-
 static const struct b53_arl_ops b53_arl_ops_89 = {
 	.arl_read_entry = b53_arl_read_entry_89,
 	.arl_write_entry = b53_arl_write_entry_89,
@@ -2814,7 +2798,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.arl_buckets = 1024,
 		.imp_port = 5,
 		.duplex_reg = B53_DUPLEX_STAT_FE,
-		.arl_ops = &b53_arl_ops_65,
+		.arl_ops = &b53_arl_ops_25,
 	},
 	{
 		.chip_id = BCM5389_DEVICE_ID,
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 69ebbec932f6..505979102ed5 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -376,10 +376,8 @@
 #define B53_ARL_SRCH_RSLT_MACVID_89	0x33
 #define B53_ARL_SRCH_RSLT_MACVID_63XX	0x34
 
-/* Single register search result on 5325 */
+/* Single register search result on 5325/5365 */
 #define B53_ARL_SRCH_RSTL_0_MACVID_25	0x24
-/* Single register search result on 5365 */
-#define B53_ARL_SRCH_RSTL_0_MACVID_65	0x30
 
 /* ARL Search Data Result (32 bit) */
 #define B53_ARL_SRCH_RSTL_0		0x68
-- 
2.43.0


