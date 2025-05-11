Return-Path: <netdev+bounces-189584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2DAB2AB3
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F91175B65
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454322609E9;
	Sun, 11 May 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsqA+w2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B5A1C5D7A;
	Sun, 11 May 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994405; cv=none; b=lMuhfKuwtdrqjVcCHpcBWKeJn5pJsITJgk/0A7ZgP9zqvBycO0hg0gv/Tn+Oo2RukTWBR8Ba9gqrMHhOjk6sHfguJRMlDG+jRm6mm7g3ehtgqTNlpX8GGH7R1ct7x23eLKIRSEQLWBBEr6UXz973tH/AjwGhx01qLi2Da3gTlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994405; c=relaxed/simple;
	bh=RqTCHmbF245kSlH2k5rQcAnN0ey4gGVyGdxrK0XkQNs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMMA7hSA53mAQOEmBZxKyPiUggY5HFXU8BJy+YRQSOt3l+2xUBS0mulfkkbPba8TnjSMd6r2+TIOTaZyTQ7QH9FulGPXYvvdAavW1N00Nt1pqxH6XZQAv9co2/OrgSVXwTjQ7Ic/3JfnCmG5spScoEWnE3e3LM9jw9omQKgzrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsqA+w2n; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso40052595e9.1;
        Sun, 11 May 2025 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746994402; x=1747599202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oE1Ex4iGsssyaIBLKiOZrSIgezQkyez+G/tcna3LlvY=;
        b=DsqA+w2nEALeiWuoa2+B65RfMbXTOkxnsg9n6irCkS3bZa42w5EsN0UjKB8v4PArZm
         8XtQoV6UUalZTm9M8v2q/hwRS7y+7i4vJLEnDbGZ2zZ7pdGJ0i8a8hD5zW07AtEVDl/o
         iEY/9ra3/i84EHWN6oxWOdbWb/2rDGhu1ba+z8B9pJrsUm+Y1NB22iZXb50nnO8cLFlc
         QoLwcdIVZmC4CzINjUqEEDN0kSRYORuRr+ORD11HOjvpQRZqrbc6AaQoizrAvdHHHxAn
         fGdVT3lIwD6SspJqZ2kB3MNElu4J+KK/ptdJ2cEbC8CjIPP5MNiX1jrUztc5kjt+HGtg
         J8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746994402; x=1747599202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE1Ex4iGsssyaIBLKiOZrSIgezQkyez+G/tcna3LlvY=;
        b=aq65mk64gbYQDYAGc+povHARISrDPYwOy/XcREupSt7ehkUfLWjjnSRRU99Q2q49de
         DJGslUbUGwJhroxWlddEy5Moro3PAaHTe9yQVvVsQKedUdX5UfDoB5BwEMf15ymNY3f3
         BNvjBnhFfc0TN9pQpo2Q2GBjXsVcLxz+HdQDgElcARSyNGGH6V/q2BR/BU3EFaKqjsUd
         l1TYRFi5r8uZD4eHvVwSc5q+UCsGHFW1DivtFZc0w27iLMiK3NEC8ZpK3Zmpfo8aL+ou
         AhdNDscgHzMk+pb9SNzEyOaW24H3JOIjAN0Dq+R0SrtFdRorsMG8Ef1kj3WBeDhmdRB1
         8mLg==
X-Forwarded-Encrypted: i=1; AJvYcCUQqZGySndkFtT/vZimd6Pk/UCWVDBM9lPi4UazAggXdOqO9meuo6sDF+A6BdHBBMbHfQFIN7kg@vger.kernel.org, AJvYcCVOfAUYb9mJVgukdvZb5mcoClXKVZSpQaNCKbgJRrRuUVE9iIE/olf5TVO9OoChl0MLe5wlNw5BB6rY6pk+@vger.kernel.org, AJvYcCVdIp+Lr3eb2xaH0EQ8tyurZ3HVxLuWQEuxkWiVT9DYGdVNc9iZE37fG3IgedSxNZmdfDz2W5jHi6nL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyj9L12UOFS2CPQUxalwL3h/z2Ue5zPHomFh17324gz+9dS6SM
	SamoWQ1Wzk5+B7LyR2qHiiqGKnKn66vuVzlnotjgpn2THhrDOF4N
X-Gm-Gg: ASbGncvOzPj11nFSxUBeWuCFXcRivoZ7sJjzyy9CtIXjV39q8mlHC0rTpaUIZR6mzS2
	6wcr2Rj7ml6UD3Gai3ObnU8Zfu7umQaOri32uofAJhQ1pJ14MbjJuDaiFI1scvQG9a8nEjA2YVF
	05/sDuRohak+ngmAjbmT1ZWmoEE/nmPdrZ/bSuz8Nyt6gcROYYJnTiKxkPFp8hJkqRVdmbzzR0/
	U13PNNmK63wsipRoXtfTJk/sw+tdDioN6tREmyQINqJpYGkLt5TMhuXJMC5DB052dTDIDXPR3vw
	ZOF9U79tBzJiTaFq3dTzqQ1wcHSl2L0ORxvqA61pHlZTcfLocWRjeC7JFob7muP04qccsDx8u6A
	BqXyMCQoRXsvPKjiOO7Ws
X-Google-Smtp-Source: AGHT+IEnQwKcdJIIC9mWyLPQ3iul9zlKmb5PJkirLZR9E9nTVzO83g3zG+H4e+2LZ3puNkjMaAX+0A==
X-Received: by 2002:a05:600c:3e0f:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-442e1093222mr47153335e9.24.1746994401481;
        Sun, 11 May 2025 13:13:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm100615165e9.19.2025.05.11.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:13:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next PATCH v4 01/11] net: phy: introduce phy_interface_copy helper
Date: Sun, 11 May 2025 22:12:27 +0200
Message-ID: <20250511201250.3789083-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511201250.3789083-1-ansuelsmth@gmail.com>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce phy_interface_copy helper as a shorthand to copy the PHY
interface bitmap to a different location.

This is useful if a PHY interface bitmap needs to be stored in a
different variable and needs to be reset to an original value saved in a
different bitmap.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/phy.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index d62d292024bc..9f0e5fb30d63 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -173,6 +173,11 @@ static inline void phy_interface_or(unsigned long *dst, const unsigned long *a,
 	bitmap_or(dst, a, b, PHY_INTERFACE_MODE_MAX);
 }
 
+static inline void phy_interface_copy(unsigned long *dst, const unsigned long *src)
+{
+	bitmap_copy(dst, src, PHY_INTERFACE_MODE_MAX);
+}
+
 static inline void phy_interface_set_rgmii(unsigned long *intf)
 {
 	__set_bit(PHY_INTERFACE_MODE_RGMII, intf);
-- 
2.48.1


