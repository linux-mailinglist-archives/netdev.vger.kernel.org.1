Return-Path: <netdev+bounces-151050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0C9EC910
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E6284ABD
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84C9236F99;
	Wed, 11 Dec 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCKKeI9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E9236F95
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909379; cv=none; b=dA9hn70C8pCz9T0S6pbIcKCOxQE2aRLPNZdyyg/XDOfBO33FzMkRrrmCOquUF6GGeVAk1nuxGrepWdLDNeHGSkb5caaGf1al84VnJFeJXE4HuDu/gzEr6RD9p2zJiofESejth6MDl7Nw6ZaNhCOw67HAVi2Bj9nH4IQjBGHmWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909379; c=relaxed/simple;
	bh=8CkjvGlU/fBuCos5TGYgpQa4dduY2oxTweTzNgPdp8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZZrIkzA2GDVMRt/IWg4QqnoV86QkRYRFSfLX1VzPtROuqhAvb26ZVt4KkFDWORr0Ib6oXg5ACuAycmBY4ktF8ggwLiXM3JFJIKCxMv0lYm4w/sW7CxmULTaT5YkS64VJlE+ulVl5ssOGVCTmg4j4Xua76yqn5zyeZ6IgM3EPIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCKKeI9f; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862b364538so254123f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733909375; x=1734514175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tNOGlFL3lkBktYd7Lrl5mLZiVQL9egL0/rCDhscr04=;
        b=dCKKeI9f7V5Uha1XIzgFjWX6um7SzEFT0SLqypAg4qWsqL+bwpkabWIv1HQE22OiUb
         47fR74eltZ5HtzywH8WDkQRmqanHD/vCC8qDLxslM/dJnGaylQL4Z+VqZag+xTJOKOAA
         1nVwuc35RPW8+ZxRegSzCVFoLPRBAbUY5SvSbu0/Nzj2FEVX9/etageSXyUEHjSd5Tuj
         FjDjIsUOS+WWsFxZVAvq++ly+64steMCPkRMCkvNzd6ZgMU8Cgqjcc8vZ+XGfFxZBjYY
         M++yM6RPXeDOZorBVefwRmew9kjXCJ7rEjz2Da8jhdEqd1cJEz9k1BNYrP7pkwGF45PJ
         d5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733909375; x=1734514175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tNOGlFL3lkBktYd7Lrl5mLZiVQL9egL0/rCDhscr04=;
        b=GmB7+UdF2QdmMg2Mqh8KRYcnw6gq/ewkRbhHTGHdsEmxpxKGzmQNftHzujbdllRv86
         YAGWC/4pz91VRsI5fvybVgKM4wAvR5I3IfhnKq2KmAiWwyLphPEuEIp4SqkS1CLd+DAJ
         vxbv8iSidB+IdQ/OFgRNzOp7DR6nARxqeH28tKBiACIBJ5sR93XIkAdqCLiVqWn7MS0g
         ibLAZJ9KeuOwVzwlVFM8vqSQ/BhAfLCcLc1+cc9We90p22B1pdTBwDMbHscHlpBtqayM
         DZdTf0dNbPDQWYPKHxqtE57/tasWtH/aLHWSdr67M0+v5bAowz9gPaw6cxSNO5YMnVCQ
         qF2g==
X-Gm-Message-State: AOJu0Yyh45ZH3V/eudSQPNsIj7DcYjNoxE/SGwbJ5fvmGmzsnUcNyhTz
	1s5anK5fGZ90HZlp3+gFtRAtbqRcqWvsiXrfW/ThbLM/oKAlxCYzM2yoO6numr0=
X-Gm-Gg: ASbGncv70ZCxXvHLLrsj2lCNUBeKA7amXUfHeE6OPq7vr2JVSmZ12Q26yVxGBU95knT
	xKReKDKnxDjGQrpRMfKwidYiegj6f0H7y80o32GldlIgYLuBCk2+aZ71thNh0kzCdptcsgErxYC
	/zF7b9ajYHYxH+utN575Myp/3PBQ+HVwl821sjgE6cbH1kzr2ylWlLDc3jZwvPw4K/kaXA242Jk
	p5inOj3Kbcqmvxo61rAD+sDfGMRIwrSsOEwI/nxJko9pEsUq0lBJRyFyJJJjCCCb/N8OO32YYql
	yHpOrg==
X-Google-Smtp-Source: AGHT+IFd++l/y9FE24LQkWnrwzNPDZ4djjUfh8P0ZGrlJe+F2bIQu77t6yd9qD7mSneNoguVHC+1Pw==
X-Received: by 2002:a5d:64e4:0:b0:386:1ab3:11f0 with SMTP id ffacd0b85a97d-3864df0817amr1470725f8f.28.1733909375176;
        Wed, 11 Dec 2024 01:29:35 -0800 (PST)
Received: from KJKCLT3928.esterline.net ([144.178.111.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514d97sm829853f8f.64.2024.12.11.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:29:34 -0800 (PST)
From: Jesse Van Gavere <jesseevg@gmail.com>
X-Google-Original-From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: netdev@vger.kernel.org
Cc: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Simon Horman <horms@kernel.org>,
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: [PATCH net v3] net: dsa: microchip: KSZ9896 register regmap alignment to 32 bit boundaries
Date: Wed, 11 Dec 2024 10:29:32 +0100
Message-Id: <20241211092932.26881-1-jesse.vangavere@scioteq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8d7ae22ae9f8 ("net: dsa: microchip: KSZ9477 register regmap
alignment to 32 bit boundaries") fixed an issue whereby regmap_reg_range
did not allow writes as 32 bit words to KSZ9477 PHY registers, this fix 
for KSZ9896 is adapted from there as the same errata is present in
KSZ9896C as "Module 5: Certain PHY registers must be written as pairs
instead of singly" the explanation below is likewise taken from this
commit.

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

Fixes: 5c844d57aa78 ("net: dsa: microchip: fix writes to phy registers >= 0x10")
Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
---
Changes v2: Correctly refer to the original commit fixing this issue for
KSZ9477 and add a fixes tag, explain the link to this commit for fixing the
same issue on KSZ9896 and provide the same explanation of the failure mode
that happens without this fix.
Changes v3: Put Fixes tag in correct place

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


