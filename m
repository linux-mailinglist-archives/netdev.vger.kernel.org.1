Return-Path: <netdev+bounces-29593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81B9783EEA
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F00628104F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3016125DA;
	Tue, 22 Aug 2023 11:31:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AF1BF1B
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5D5C433C8;
	Tue, 22 Aug 2023 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692703901;
	bh=ZHKM3hRSgNWpeg8hIoYJwYTpvWpYAvqjsOpYcY1+6PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcY6gHLwd6jCjV7jG3QRIcEYCFRKpljVCcD+8+Lo3NW3qScQEvN/GzH/69UAOlxrE
	 BlzOw+9c7TCsBqz10AKG6+4y98VB9c65KcmFDSpXjwJjsa0TGbI0FoUw7nEzixvz/b
	 ZdwNyXZORunNjNAbyJvAb5THFOIZOCW6JrJSYfDQbRpe4bDMQwF6y1ijyFNgvSI0MQ
	 q8P9gCkrDfQd+b6vucJ2WhaPChBSKSZLu0mKhOQC1VUlTqHsWwJ/Kj3SeeMGdXiMv7
	 0o5pht7bme3N4Ta4bDTPmSwdHJdI+F//97PDWMFp3rJdHFTd5NceLv7u5SWNc717XZ
	 dFPcsiu3aSBVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lukasz Majewski <lukma@denx.de>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 5/9] net: dsa: microchip: KSZ9477 register regmap alignment to 32 bit boundaries
Date: Tue, 22 Aug 2023 07:31:26 -0400
Message-Id: <20230822113130.3550050-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113130.3550050-1-sashal@kernel.org>
References: <20230822113130.3550050-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.46
Content-Transfer-Encoding: 8bit

From: Lukasz Majewski <lukma@denx.de>

[ Upstream commit 8d7ae22ae9f8c8a4407f8e993df64440bdbd0cee ]

The commit (SHA1: 5c844d57aa7894154e49cf2fc648bfe2f1aefc1c) provided code
to apply "Module 6: Certain PHY registers must be written as pairs instead
of singly" errata for KSZ9477 as this chip for certain PHY registers
(0xN120 to 0xN13F, N=1,2,3,4,5) must be accesses as 32 bit words instead
of 16 or 8 bit access.
Otherwise, adjacent registers (no matter if reserved or not) are
overwritten with 0x0.

Without this patch some registers (e.g. 0x113c or 0x1134) required for 32
bit access are out of valid regmap ranges.

As a result, following error is observed and KSZ9477 is not properly
configured:

ksz-switch spi1.0: can't rmw 32bit reg 0x113c: -EIO
ksz-switch spi1.0: can't rmw 32bit reg 0x1134: -EIO
ksz-switch spi1.0 lan1 (uninitialized): failed to connect to PHY: -EIO
ksz-switch spi1.0 lan1 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 0

The solution is to modify regmap_reg_range to allow accesses with 4 bytes
boundaries.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 35 +++++++++++---------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 8c492d56d2c36..dc9eea3c8ab16 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -590,10 +590,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
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
@@ -624,10 +623,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
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
@@ -658,10 +656,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
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
@@ -692,10 +689,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
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
@@ -726,10 +722,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
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
-- 
2.40.1


