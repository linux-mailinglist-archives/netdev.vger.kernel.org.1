Return-Path: <netdev+bounces-229296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03679BDA58E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E5C189F4E6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF07301463;
	Tue, 14 Oct 2025 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i7fzRxWk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43C3009F0
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455550; cv=none; b=s/85UsxjXYjuY/ju5MkEP1YIxLvipGSRxFvHe5z0zhMUKbEgLhQJ1L33p4yvcUAKNQgDug293sufRjagPGukzxDO128wYMQd8gVfN1QZ8Hekxojrb6nbo0VkVkVOQyOfN7JOu+y7vfGkEprptJyTZC8K7v++WY89QdJcglKepa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455550; c=relaxed/simple;
	bh=LXKtVHtrjn/Y93tHUKx4CLQ7qPHWsaeqDfv2dCXQdR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F61Xw8RzQD5YFNVmI2j7omvf5fvwGb9Vsi5f2umyDhkCRDLrCWWnV+Ea1O8EsZcKtS09uWVWwhL4jOCfQrYr+uuCO3EjOJxQ8UkJ5XlZKragd9dYp35Qn3In7VdLC2qNf0fpYKFCAUdfuAHN8kOzzK+DBU2wcMoqCj3FCUipQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i7fzRxWk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 41F1BC09F95;
	Tue, 14 Oct 2025 15:25:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B69A606EC;
	Tue, 14 Oct 2025 15:25:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F1F0102F226E;
	Tue, 14 Oct 2025 17:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mv9T3yxgqUuWX7rYJ1ZRmVULnCZTSFp2tCALvNXB5xM=;
	b=i7fzRxWk2NPhDEztVMgm6Mg72HbEPkTU0N8beo3/weFGQWMfE5lNN3YLCDfnw/RFS492PP
	bXD8kTrJM7iI6bFGHeKD2vYm36vQKBKD/EwiI5Ewsr+HHdufWUnG+EJTFo725zNQvEC+S0
	L1sCv4A4O9jWdoZdptM9PmwsauOW57V8DL7GHoYckyXRqJu8ialUiBpJFm1o4cm1gHqObJ
	b7fdLcj7C6J1Oe2t73K/C7+XVZ/axpbwG1RY8rALetBYje6yFq85gS1GgdYEYCZGc9FEzV
	sz+qqLrfoArs2SIzp4uz7z4UAirgo3VwUOdS0fybpEQjNHZboOCjKaZ8GBduAA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:04 +0200
Subject: [PATCH net-next 03/15] net: macb: remove gap in MACB_CAPS_* flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-3-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

MACB_CAPS_* are bit constants that get used in bp->caps. They occupy
bits 0..12 + 24..31. Remove 11..23 gap by moving bits 24..31 to 13..20.

Occupation bitfields:

   31  29  27  25  23  21  19  17  15  13  11  09  07  05  03  01
     30  28  26  24  22  20  18  16  14  12  10  08  06  04  02  00
   -- Before ------------------------------------------------------
    1 1 1 1 1 1 1 1                       1 1 1 1 1 1 1 1 1 1 1 1 1
                    0 0 0 0 0 0 0 0 0 0 0
   -- After -------------------------------------------------------
                          1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
    0 0 0 0 0 0 0 0 0 0 0

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 869d02284707cb771233276a073e1afdeeba43ce..9d21ec482c8c62da28f9d5ff35d5ca46f293eb64 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -769,14 +769,14 @@
 #define MACB_CAPS_NEED_TSUCLK			BIT(10)
 #define MACB_CAPS_QUEUE_DISABLE			BIT(11)
 #define MACB_CAPS_QBV				BIT(12)
-#define MACB_CAPS_PCS				BIT(24)
-#define MACB_CAPS_HIGH_SPEED			BIT(25)
-#define MACB_CAPS_CLK_HW_CHG			BIT(26)
-#define MACB_CAPS_MACB_IS_EMAC			BIT(27)
-#define MACB_CAPS_FIFO_MODE			BIT(28)
-#define MACB_CAPS_GIGABIT_MODE_AVAILABLE	BIT(29)
-#define MACB_CAPS_SG_DISABLED			BIT(30)
-#define MACB_CAPS_MACB_IS_GEM			BIT(31)
+#define MACB_CAPS_PCS				BIT(13)
+#define MACB_CAPS_HIGH_SPEED			BIT(14)
+#define MACB_CAPS_CLK_HW_CHG			BIT(15)
+#define MACB_CAPS_MACB_IS_EMAC			BIT(16)
+#define MACB_CAPS_FIFO_MODE			BIT(17)
+#define MACB_CAPS_GIGABIT_MODE_AVAILABLE	BIT(18)
+#define MACB_CAPS_SG_DISABLED			BIT(19)
+#define MACB_CAPS_MACB_IS_GEM			BIT(20)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01

-- 
2.51.0


