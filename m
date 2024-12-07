Return-Path: <netdev+bounces-149927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710969E828E
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 23:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D281654DB
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98454155A4E;
	Sat,  7 Dec 2024 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekx9MtAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45701547C8
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733612359; cv=none; b=cBUDGxAqjXeesiWu/RDCvF4S2ClWUG2RKOmnJHIgc0heR2PTAHhuP/amz2tHGx7smEa3hnIxFgDKimvGCHPgyciE/Uc+dbz/OcAGInelYGEu7gFJHtjBiZ8uRgZkOiDCxtH274fUIb8TDqNN1TGCX6HHhmSx4PWYu0klZOWJwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733612359; c=relaxed/simple;
	bh=JsPgcvqjcwXR3eLvao21m+KwVFUlyu4JX3mgqnDeueE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X3gei8IfffL5ZlWxFf4JSmYsCN9q6RqI5X3zJ4w4IR6S3LuMAyx7AK34vmbj8jNZsqdbpt/UYYKRre9Xg/7Kt6yxrRduK0b8pElZ5XYvlSyWK6VK26tcjP7dQtdqSNGsZ4EAqPqoK1goX2wmGQK+EldFCCIO639oAeO6JGG6MiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekx9MtAc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434ab114753so21238325e9.0
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733612354; x=1734217154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZsLq5xlPrO9ocL4KifG2AcxOQh71zC9Ob0jUBL5eyA=;
        b=ekx9MtAcUSMBS356gOpXgchdMNbaIlFwmwDMSQracU8efUqlVw7WldreDSgmUDwC+F
         cPE4mz+rGojA0mHJrt4YgfXira3He3fs6X9q66XU7l0OjF/cxqQvIjYe260y5c792Yz1
         XSFsh5FgefbpEJE34emdBexu3Eo8fAfEwF7WFL1RwtSZ8UrIjjwt9lDjsRL48pmoKdN6
         9En6Rs6412TRS+bJ8hlQeg1r227FNOypNQRfnUJGDXFeOqQHUDAeLteA0VD/DCwjQ5bM
         DnnLlXA4bkhmP+rsUyUyHWuoB5W5++bynKX4fxCq4qpd0qxXVteyvDTuwECwh3aZgN0y
         jvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733612354; x=1734217154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZsLq5xlPrO9ocL4KifG2AcxOQh71zC9Ob0jUBL5eyA=;
        b=caH3EOffpIP+0qcX0rj7eMbYQ+5FKxX3fZvf0FmbN0KOlTnM9ADN4tqvwNqN+S4H6u
         jZWA96JrHIpTCrxLdlh5cAtliNjFHwBnTyZQZKq3W0FWX7ZNFGigMwFDs7l2LDCX3lqC
         TXjjjuyGN5G1eQveNjo/eF5SUvjeMCWCFYGKc27ATuUTOXK7bXeO6bI/hLN4Ytzfs7xX
         xzvEibPDo6PTvQBn5IMs1cHRo4GnOBf7pv32Oa59T1O3iI6eCt34ih5/xcg/OBbt10KB
         ampmq1SK7nuFkMj86SOYvHE70nLkuQqBVhmhygQa1GlNDmHbSYnXh/sxqv0LRVtQaM86
         GiRQ==
X-Gm-Message-State: AOJu0YzZg/2ZmS7+z0Pg504EDBHiDelnDgjAX5W/4neBJdIFLvybmlco
	iZT64TPgrMcs7rz8q9j9Ujs2duKtxkm44Vmenis3NQ5+Fn+nbIOvzP+IbQhAMss=
X-Gm-Gg: ASbGncsZVeCpIhx81k9T7bT7dtGteBR3Acjv3p9nFYBhzBRpbLNitGr/S0MfY/ZuWKL
	Q8gaLlPD3GjaZn6DceA66+wQuILCygfJVn4lzUmUH9SPiewOswTuYuGs/IXltfWRY5dCRkKwC8k
	h7WSHF/fzMWj2AC8meJVR8Xpfu4ni08rzWVdGzl4J5wblNohanjkGWZJFjuXRJzlFhhS2HiKxwX
	atzIEs7Czz5D3iGJXtPOIyFvAjaBunosU5ca9yA7tBW3A8yoK5/u+/ps1GRUjsRdBCL4CCQj3rG
	uYZZEQADzAvwubnMrnEPkzOaoMl6vkZ5lJufp9yOJRXoog==
X-Google-Smtp-Source: AGHT+IH1XQ1Vi2BUlSBDBDMiOx6WBfteKMT9Xke1JcezHwXzpqsNQXXdQptBkb7esnIOqQ+7EtHE1w==
X-Received: by 2002:a05:600c:4fd6:b0:434:a9a8:ad1d with SMTP id 5b1f17b1804b1-434ddea64a2mr59617285e9.7.1733612354288;
        Sat, 07 Dec 2024 14:59:14 -0800 (PST)
Received: from KJKCLT3928.esterline.net (192.234-180-91.adsl-dyn.isp.belgacom.be. [91.180.234.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f0dfc2a2sm17565625e9.31.2024.12.07.14.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 14:59:13 -0800 (PST)
From: Jesse Van Gavere <jesseevg@gmail.com>
X-Google-Original-From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: netdev@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: [PATCH net v2] net: dsa: microchip: KSZ9896 register regmap alignment to 32 bit boundaries
Date: Sat,  7 Dec 2024 23:59:06 +0100
Message-Id: <20241207225906.1047985-1-jesse.vangavere@scioteq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8d7ae22ae9f8 ("net: dsa: microchip: KSZ9477 register regmap alignment
to 32 bit boundaries") fixed an issue whereby regmap_reg_range did not allow
writes as 32 bit words to KSZ9477 PHY registers, this fix for KSZ9896 is
adapted from there as the same errata is present in KSZ9896C as
"Module 5: Certain PHY registers must be written as pairs instead of singly"
the explanation below is likewise taken from this commit.

Fixes: 5c844d57aa78 ("net: dsa: microchip: fix writes to phy registers >= 0x10")

The commit provided code
to apply "Module 6: Certain PHY registers must be written as pairs instead
of singly" errata for KSZ9477 as this chip for certain PHY registers
(0xN120 to 0xN13F, N=1,2,3,4,5) must be accessed as 32 bit words instead
of 16 or 8 bit access.
Otherwise, adjacent registers (no matter if reserved or not) are
overwritten with 0x0.

Without this patch some registers (e.g. 0x113c or 0x1134) required for 32
bit access are out of valid regmap ranges.

As a result, following error is observed and KSZ9896 is not properly
configured:

ksz-switch spi1.0: can't rmw 32bit reg 0x113c: -EIO
ksz-switch spi1.0: can't rmw 32bit reg 0x1134: -EIO
ksz-switch spi1.0 lan1 (uninitialized): failed to connect to PHY: -EIO
ksz-switch spi1.0 lan1 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 0

The solution is to modify regmap_reg_range to allow accesses with 4 bytes
boundaries.

Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
---
Changes v2: Correctly refer to the original commit fixing this issue for
KSZ9477 and add a fixes tag, explain the link to this commit for fixing the
same issue on KSZ9896 and provide the same explanation of the failure mode
that happens without this fix.

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


