Return-Path: <netdev+bounces-232905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B427EC09DAF
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C28C834CA9C
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3CF30274B;
	Sat, 25 Oct 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD6FIVWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F05A302170
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761412408; cv=none; b=g7K/7VpSnjklZmX935u1Vh+LjnXSQu/aPy/Ln47kqP/ZvHePACEypGKGyo+VnbX4WLkyv5dSwrbZraYhUCARdGqu6oVuQtFC7Or3dJUtDvGVlr3ugiAxRSVxFOTayiSsh7LAnG3ok1INKD2gqu1qR/BGQGDYpd5fnF9U9+bxmoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761412408; c=relaxed/simple;
	bh=e7A26unbaP9hAYoj1SkxhsFZbhJCuCK4u8p+jfhPlZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn2VjETGB4A34/EAZRqR4UzGWs+PrgF5UwE1dlTdkRB7Wbkbt87DK2NQDiMa+kkWIGq+6G7j7eZjd+xNMyRNpfRFHU3xQrnqGFLV9u40XLEYFOWM9+ssDcr9DknoC/3qRhzh8rMhBBu2e9b6EkeZREPgd/kN5ERom5zgsl9zZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD6FIVWP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a2852819a8so1738958b3a.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761412406; x=1762017206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHgAdAQC2Eo5vV0FXAPtfwzgCMbFl4JzyNeiEAhdKbs=;
        b=TD6FIVWPV2KvSRpF0/GWYxTSY3ppRVKG1tkxHD65aIatmDWuPgUMkR0yyJ7KvmAW9h
         3zxdiqt0sVCa8pISmRJzKKL/EAiE9AFj2g6WSaamZWsTiz1Y4TqXiCPQKFOr3JMHWDtE
         YxqnQmOZo43wTtKgsJVOtK6KBx/f/+J7mBBvUwZfCeJ4PN2FcOOqTAFBcYKaiq5HR/7x
         xXwBB37r8czfiMzPFVWgzs2BAahiSf6kWJInRPzOyw2U/pqyz7NjDdNhMtAn1ZC83YwG
         SbELZfhnonnX+em/ThlnXbE9mSjWTZfZGVKTiJJSRwwvHXJNzZ8junuWTNvW6ct1CtPl
         brrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761412406; x=1762017206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHgAdAQC2Eo5vV0FXAPtfwzgCMbFl4JzyNeiEAhdKbs=;
        b=LX6BGHt0Y0z5bNyaNIsftyHwz4W0jW8HnZw/sLg4Q049ZobOqLLukVNoAjczY7O+qj
         GCKoJMJgK+HXR9ziY79XrerZVjHEln4tUFkCU3q44DG8hBKCYvrQEWO6xEr+HKCIAFDN
         ZzcPQf22rXQ2S+knUxIt5cnUsoANjmhrTfGWh8n1uNfypwbWQhWubtPKVHgijqN12nnc
         jhM5KSqL7cEyGkS02guynoHxGj1eKHPS5Gg1QzFwiB5B3xzDKY1sBF043Htb5vZVPfFt
         zsypuhhyFlXOUL5Vu+utCglqAor9QoPd2DLGbX6beuAxvSQR5Dzoe2LDiOnLrBD3SU/N
         2S3w==
X-Gm-Message-State: AOJu0YylzSVgoOdfv9gBhWaTPoSpJ89rF5rm3HCs+VR0PDL4kg9xiM8L
	vHWcf6YgLGPFul1Kmy/saJAJHtW7f6PlzjjOB8FNM32LTfB9SaBBkJEbw3Lu/AP1
X-Gm-Gg: ASbGncsKCMWPAoPHNFUwtwJh2ZMQgbxh+dXs+Eq3lEpvh656auDUB8SjtuPfXf8qzDL
	9kUramkxGUhUezZLFdvFiNMGcCQh+GlB5rHVOfto6jV0b57E6OIGB8rKHPVW4hprUHNLujdGFU/
	xdh7sutXJx/oeF70aX7oMVDYHVdaSkzTAgiXbkpXLBzRqRymQf5jGShbdtTrydC4NpofD9kTVe8
	aYVbn1HyMGFtfoNhgfAvQ+ZZc4aj3Xn1oLBygJ9RF6xe7ATXVDA57XfooH6H93z1RFfODRYKR1F
	4J3Blv/pzfuzlRYVhOK1K8pTe6bnkdOdQI79ClOhEcFdrRGMhLnOUjraBfOBeECIYKfyDviU6DM
	SNy/0sL3btTbmW3Mx4HdSMhQYEuQDWMK2TKf/M4wA34jythX46a/z2i+9Yqx54eIC1tzlc9Wk91
	ERltbmYKQexB+tv7bVSA==
X-Google-Smtp-Source: AGHT+IHfToilxDihPAF+e6IlMbKYVG4dZh2XU8lYpWC/85adxFkFY8/ZMNS44ontsF/nLpMQ7bFdpw==
X-Received: by 2002:a05:6a00:23c2:b0:780:f758:4133 with SMTP id d2e1a72fcca58-7a274ba91d9mr11356205b3a.10.1761412406107;
        Sat, 25 Oct 2025 10:13:26 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bcesm2850481b3a.8.2025.10.25.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:13:25 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next v2 1/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Sun, 26 Oct 2025 01:13:10 +0800
Message-ID: <20251025171314.1939608-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025171314.1939608-1-mmyangfl@gmail.com>
References: <20251025171314.1939608-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by the following Smatch static checker warning:

  drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
  warn: was expecting a 64 bit value instead of '(~0)'

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ab762ffc4661..97a7eeb4ea15 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -687,21 +687,22 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
 		u64 *valp = &((u64 *)mib)[i];
-		u64 val = *valp;
+		u64 val;
 		u32 val0;
-		u32 val1;
 
 		res = yt921x_reg_read(priv, reg, &val0);
 		if (res)
 			break;
 
 		if (desc->size <= 1) {
-			if (val < (u32)val)
-				/* overflow */
-				val += (u64)U32_MAX + 1;
-			val &= ~U32_MAX;
-			val |= val0;
+			u64 old_val = *valp;
+
+			val = (old_val & ~(u64)U32_MAX) | val0;
+			if (val < old_val)
+				val += 1ull << 32;
 		} else {
+			u32 val1;
+
 			res = yt921x_reg_read(priv, reg + 4, &val1);
 			if (res)
 				break;
-- 
2.51.0


