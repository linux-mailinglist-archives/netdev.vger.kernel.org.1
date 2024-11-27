Return-Path: <netdev+bounces-147657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D947C9DAF35
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A8B281D85
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536322036FC;
	Wed, 27 Nov 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McL0Ch6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318C202F9C
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732745504; cv=none; b=ixoqgOpFtTxWgBS+EcHy1sPUAmp2hd0IsdaD2sCoeXTW9ywNyFO2beVdVAxH4fc8/bOUUpLUkX6hfR2IhSLSohfdGpdaEDkcyuxP7aFmIrMh2/rFixn+lrTGJnf8kX3JuwPsdHxgx+PBRrglvQ/2SbfSIMigXgqnmCoJ4w12QCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732745504; c=relaxed/simple;
	bh=QgHLQ6FcSiVaTG+yqlYqVzXAkIsyC1KAE6Tx8Uz1oSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mHeb0iI0JG/wRok6SzaVq51c88gDoK3TrwYhG4gF9wiRC/wQgYcnK3FVn9KimuTZyKYn8uo7M+brUinq5konKdvG9xTyX6a/YeOB50Y9yWmvZ8KNwJfuNLqLzSWtZVkX0dCahVaOUrXHUwEF2yo0aAv4kta5PtJ0CM5hExfpIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McL0Ch6W; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3824aef833bso146716f8f.0
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732745500; x=1733350300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8xCeSsXB1SGqsvkne3bx5tW5DoZL/BuIVhnmqcxnuk=;
        b=McL0Ch6WVVdz2rZM9btMaQg4PST1DY8knX2zzWmLhc7zfr7k1USoyHHAHA8X6OHoDM
         L8P+w2HG6PecZVv25zJm+6DGpgMbwgjiOEWnPNcV7FTh4R4AihA/Ck63voT6/FYHyjsC
         x9iKjJcTe40pd5dDZzNwxdYkehQaqV3mKEI5nZuVwZfxZzpeeqWI1J0qWZ+WMP8NZhjx
         YtBJgEDvULA14cicsrGhkmpJlOre0tpkUxgok/gV3n2dQoFmh4Y/vG2aTWhxIihwMS+4
         hvp6bJDGejnEWh8yygltisfX1TII0+sqJkC4CiP3mY73kGJkmPZHehxiRhz5AVDZWktc
         Bf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732745500; x=1733350300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8xCeSsXB1SGqsvkne3bx5tW5DoZL/BuIVhnmqcxnuk=;
        b=b7SymUoDM5ayKQ6YXI1g1z/0P5OQYiVOz6OzrCT0lJuKBfomPlpNcOrmSAIfAeI2Iu
         Gtlh5Kb7Q2kUcb0WpEzDdRH5ocYZOuVwWqETPxdvf3bEC6JnRYWHVoQBLFU4uSPUsYqd
         u7EhvBKMmjKx1fo8OnRbr93ALj1+LA5j2WlnMiTY9sW+HWxc01MZnjuQ5wPh2/N4M3cj
         0l7FTCgtJ5uefq2bCws/SNJguLgGO8IJSctBm5tV7YOy04YtKJb8feo+Tn1gZ2U37dOm
         1Dw3sSKZtFHAaHSrG4efgbhyEKgaI7eIK23EMqmhSzcWVC/hVNNCUYqrgHV3encAFFjm
         WS0Q==
X-Gm-Message-State: AOJu0Yz+NlCDcWh7344bin55XRxtPeMFXTmdC/ziNJb5qUfRFsbsXUsc
	06XDOYk12KoE9VZ5TqljvOq5Td2oDWHBqS+pObCYMsvFqbWFyev2vx6nX4yJ
X-Gm-Gg: ASbGncuLXyh6stnp1/q40/xIXXGR/UPKOMZaC/sQL9FkWqaX1uPBmLOzB0fVOalNCXr
	F7O54QE8Cl6RU7sxGoJY8mTjWGhXDdnuhVKLNTOy9HJpy9GRQ63zF5vpdmBIAaxgt7A7URQYqm+
	9TPpNIYWUSuuTbCvzCVvoQ1BK67Mu6ojUGOAkapSsXNDPrLMUJM33HLZEzRBfwTcfPu43YsDdy0
	t42WYMOz4qPSER+4/g9ljqekeVRZfF6W2JwL1V45irJtFFN6LJL1NW0UHzzmKdbfJF5Y9Z+mQl8
	NweU67Vt7L8K/jwLq14NFxC0DkW9pdl26XDZi2uyRCckcw==
X-Google-Smtp-Source: AGHT+IGFpTTV3u8kbqPnbetZaJlhjuK87233drO9WK28dtdpdMW5UoVX+/r5cabr9ZU2DH0xowzJfw==
X-Received: by 2002:a05:6000:1787:b0:382:4ab4:b43c with SMTP id ffacd0b85a97d-385c6eb736dmr3304555f8f.21.1732745499796;
        Wed, 27 Nov 2024 14:11:39 -0800 (PST)
Received: from KJKCLT3928.esterline.net (192.234-180-91.adsl-dyn.isp.belgacom.be. [91.180.234.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36c44sm96f8f.38.2024.11.27.14.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:11:39 -0800 (PST)
From: Jesse Van Gavere <jesseevg@gmail.com>
X-Google-Original-From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: netdev@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: [PATCH] net: dsa: microchip: KSZ9896 register regmap alignment to 32 bit boundaries
Date: Wed, 27 Nov 2024 23:11:29 +0100
Message-Id: <20241127221129.46155-1-jesse.vangavere@scioteq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit (SHA1: 8d7ae22ae9f8c8a4407f8e993df64440bdbd0cee) fixed this issue
for the KSZ9477 by adjusting the regmap ranges.

The same issue presents itself on the KSZ9896 regs and is fixed with 
the same regmap range modification.

Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 42 +++++++++++---------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 920443ee8ffd..8a03baa6aecc 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1100,10 +1100,9 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x1030, 0x1030),
 	regmap_reg_range(0x1100, 0x1115),
 	regmap_reg_range(0x111a, 0x111f),
-	regmap_reg_range(0x1122, 0x1127),
-	regmap_reg_range(0x112a, 0x112b),
-	regmap_reg_range(0x1136, 0x1139),
-	regmap_reg_range(0x113e, 0x113f),
+	regmap_reg_range(0x1120, 0x112b),
+	regmap_reg_range(0x1134, 0x113b),
+	regmap_reg_range(0x113c, 0x113f),
 	regmap_reg_range(0x1400, 0x1401),
 	regmap_reg_range(0x1403, 0x1403),
 	regmap_reg_range(0x1410, 0x1417),
@@ -1130,10 +1129,9 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x2030, 0x2030),
 	regmap_reg_range(0x2100, 0x2115),
 	regmap_reg_range(0x211a, 0x211f),
-	regmap_reg_range(0x2122, 0x2127),
-	regmap_reg_range(0x212a, 0x212b),
-	regmap_reg_range(0x2136, 0x2139),
-	regmap_reg_range(0x213e, 0x213f),
+	regmap_reg_range(0x2120, 0x212b),
+	regmap_reg_range(0x2134, 0x213b),
+	regmap_reg_range(0x213c, 0x213f),
 	regmap_reg_range(0x2400, 0x2401),
 	regmap_reg_range(0x2403, 0x2403),
 	regmap_reg_range(0x2410, 0x2417),
@@ -1160,10 +1158,9 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x3030, 0x3030),
 	regmap_reg_range(0x3100, 0x3115),
 	regmap_reg_range(0x311a, 0x311f),
-	regmap_reg_range(0x3122, 0x3127),
-	regmap_reg_range(0x312a, 0x312b),
-	regmap_reg_range(0x3136, 0x3139),
-	regmap_reg_range(0x313e, 0x313f),
+	regmap_reg_range(0x3120, 0x312b),
+	regmap_reg_range(0x3134, 0x313b),
+	regmap_reg_range(0x313c, 0x313f),
 	regmap_reg_range(0x3400, 0x3401),
 	regmap_reg_range(0x3403, 0x3403),
 	regmap_reg_range(0x3410, 0x3417),
@@ -1190,10 +1187,9 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x4030, 0x4030),
 	regmap_reg_range(0x4100, 0x4115),
 	regmap_reg_range(0x411a, 0x411f),
-	regmap_reg_range(0x4122, 0x4127),
-	regmap_reg_range(0x412a, 0x412b),
-	regmap_reg_range(0x4136, 0x4139),
-	regmap_reg_range(0x413e, 0x413f),
+	regmap_reg_range(0x4120, 0x412b),
+	regmap_reg_range(0x4134, 0x413b),
+	regmap_reg_range(0x413c, 0x413f),
 	regmap_reg_range(0x4400, 0x4401),
 	regmap_reg_range(0x4403, 0x4403),
 	regmap_reg_range(0x4410, 0x4417),
@@ -1220,10 +1216,9 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x5030, 0x5030),
 	regmap_reg_range(0x5100, 0x5115),
 	regmap_reg_range(0x511a, 0x511f),
-	regmap_reg_range(0x5122, 0x5127),
-	regmap_reg_range(0x512a, 0x512b),
-	regmap_reg_range(0x5136, 0x5139),
-	regmap_reg_range(0x513e, 0x513f),
+	regmap_reg_range(0x5120, 0x512b),
+	regmap_reg_range(0x5134, 0x513b),
+	regmap_reg_range(0x513c, 0x513f),
 	regmap_reg_range(0x5400, 0x5401),
 	regmap_reg_range(0x5403, 0x5403),
 	regmap_reg_range(0x5410, 0x5417),
@@ -1250,10 +1245,9 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x6030, 0x6030),
 	regmap_reg_range(0x6100, 0x6115),
 	regmap_reg_range(0x611a, 0x611f),
-	regmap_reg_range(0x6122, 0x6127),
-	regmap_reg_range(0x612a, 0x612b),
-	regmap_reg_range(0x6136, 0x6139),
-	regmap_reg_range(0x613e, 0x613f),
+	regmap_reg_range(0x6120, 0x612b),
+	regmap_reg_range(0x6134, 0x613b),
+	regmap_reg_range(0x613c, 0x613f),
 	regmap_reg_range(0x6300, 0x6301),
 	regmap_reg_range(0x6400, 0x6401),
 	regmap_reg_range(0x6403, 0x6403),
-- 
2.34.1


