Return-Path: <netdev+bounces-194495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C26AC9A71
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F89D9E5F98
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358223A990;
	Sat, 31 May 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOLGSBDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B8239E93;
	Sat, 31 May 2025 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686401; cv=none; b=tsI6+yAHdGGvYcTRSYK7e+jCK+k7iaXrzxm5IZ3stUBoPJryjRyTNISu7pmA/n/A64wVM65uFOzlisvspdJATs5jeU14q1vUvyyU9glWTYd26NBkEnnZGaOS3+AbNeewL1q8WAH5rxwsEJQKY84mYGdYggeoFwAJ+byM8CCuFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686401; c=relaxed/simple;
	bh=8n3S98UFWmOvMsz5XubR+q5X7g2DT4KTgWdfDMAxh0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkT+2/hPZ4ug6ZROXrhJjSEaa8RfevvQ9xrZgiJ1Cmcz/gFXuEKa9whErpoNCng9hgzJWH3C5MM1v90K4mYR3pxnukunUYQYpJBy4WlJHHNdvHc2wqxkSYZ+SM4geiRpGAUdiVNl8Ay/HPQPlPgJ8dwjHogyl3llP/5NbrqhstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOLGSBDf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4fdc27c4aso198450f8f.3;
        Sat, 31 May 2025 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686397; x=1749291197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkE4jy2942B4PnMPCXZQ5ZLTCeZc8Bh/eDtFkQLFjmc=;
        b=UOLGSBDfz8Zn0alCmTaY/hMphhyOf9L/34+wHDxEJxXDmrS5vnFvAVg5Lh7qxR0xmz
         H96T2+Iz+pAVbY8Eo4/gaZ/mO3qLJPrVbaBtVAFq1zLFT8EX8mhstit8qD6CrGRK/Og9
         C9GLb9zmFInI5Th31+Zb+RYtkJ1vU4qy5E2YWb5kmkucu0tas3hluTfmevanoHmdXRGY
         1Dxeg7D5b9FyliKiSbJSKd4Eane5jWX17I+DFVGczzu2WP7y0Jj8idmqjiWj960xGeR0
         CF7rPtHpWn+exAJXznT7Hx3L/6uOL0AiG7r96vrdqfL/t4kuMjftU0n+mvWo+C/4WBT6
         FsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686397; x=1749291197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkE4jy2942B4PnMPCXZQ5ZLTCeZc8Bh/eDtFkQLFjmc=;
        b=J7ZSVzd5C37+Vl0hhxGex8A6hQpXApTZBq/m8ieN3mOnv2h4Zf44X+F6T0rou1JxZ9
         y2+XQ4JYsD8CDIzIfS18AUXjoOOKs8Sa8wr5IhbknxqGYsjf6sOrC01KHSAeKVyg+RgD
         1gFHLXu/bEvy9EawOxPAnbyijaCJkQssVUg6nX23BPM7yXI/Qk9CuSdH8Vjy4kItZpDL
         a3B8wGsL8eKjH1mJ4VEB5AtCNKd86C14ZfTxUqi3DdHgAixt+zt21hTl25PPa8CcsqAQ
         XlAB1s6GuELLMVVwhA48CXQO0KAugKTrKmH0SmpiU9oYGQOGny2P6cXJLC5ypBmJ/AxI
         NWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlULyhL5eBucp2hCBF9iJMsAl8eZsYhoGEqC8enhH+8BTuSBXu85BpOOvMCdjJtsSpZFdW5+pxA4OG6rg=@vger.kernel.org, AJvYcCXu4LVcSTkJQWAyGd2jlq/5xKicbsu4gEax53Gj0zST50xG9tfRANWd1brZBtMj8AhIKya8qlgO@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGgpqYJEV9ogCSIYdUOc/5eXa3BRsV9bxCxzN+PLoHLpw5YdI
	gx74ElLPz3rDDHfHGFb9JoHw0b9DysQGtIa6blZk9N2wdFG2DbC9qM+F
X-Gm-Gg: ASbGncuvQNz5x25TwxrVVK4gwNEbx1FGvy4IYmcnTsy8MZ+TphOMDNJmxhP9ntoOYiu
	AF/1GGAAzX/K54avtf9CH6xzN0DvO+MTj4eas4Vb+OXL5oU4UJlPJxvgagu0gTdtrY/jXZ2xSzp
	s+Z8j+WDi0BoOugRyYVYtQZFZ+GJMeinfgrdDQIVrVvuhf2cDyhfu8Xw3edHvcsKVTBvzQOsctJ
	j2HGQGO2oMoiLbxsQA4s5zUjuJBnyipC/Nk0yQAF7a1muugauw8WMa9XSO/QxMzHvpGk+rpbqhG
	Dei+pN30h62zGMFau4nAyGCv9fdz5c3Zv2t6L3jVcsKCriGegjRvIH6NW67UYsrx4laynpRETHC
	QEfdkHK3ItM7tEKj/fwiFM1TDksXtkFJPT9FgfdvsJbGX67R8CpgEi08EH72hckg=
X-Google-Smtp-Source: AGHT+IExHMXwbfE+UDOP1fVswoEhC7rRyPuZatr9IuJMgWYcJJZVvO95zoN3HlOGW5ZuuH/pE6nh3w==
X-Received: by 2002:adf:a152:0:b0:3a4:f8fa:9116 with SMTP id ffacd0b85a97d-3a4f8fa9122mr3048641f8f.8.1748686396837;
        Sat, 31 May 2025 03:13:16 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:16 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 03/10] net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
Date: Sat, 31 May 2025 12:13:01 +0200
Message-Id: <20250531101308.155757-4-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement SWITCH_CTRL register so we should avoid reading
or writing it.

Fixes: a424f0de6163 ("net: dsa: b53: Include IMP/CPU port in dumb forwarding mode")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d1249aac6136..f314aeb81643 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -360,11 +360,12 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 
 	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_MODE, mgmt);
 
-	/* Include IMP port in dumb forwarding mode
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
-	mgmt |= B53_MII_DUMB_FWDG_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
+	if (!is5325(dev)) {
+		/* Include IMP port in dumb forwarding mode */
+		b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
+		mgmt |= B53_MII_DUMB_FWDG_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
+	}
 
 	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
 	 * frames should be flooded or not.
-- 
2.39.5


