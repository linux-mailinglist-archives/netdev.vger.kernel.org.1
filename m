Return-Path: <netdev+bounces-197724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C31AD9B21
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01FA1BC1204
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88874204C36;
	Sat, 14 Jun 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgtqgyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB174201004;
	Sat, 14 Jun 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888015; cv=none; b=Wx5DWwVLtIim1tGZ6ewAmXCqqf3TSII50u4hR+kVefwiYTQShJ2MJTbV2JeEqCZ/xQL/vLVmw9gP0s094UgzohzQGlHpC7PUPrm67sFn1M/RpdCnPSvBb3VPLCc4OQNZy6o9aFYBM90I8f/SjHBCfwV9qYFxOZpfKcCGgvw7UjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888015; c=relaxed/simple;
	bh=6WD9RkbNl8iD3s6c1qnhGGLhPwZn4qXPORx1Maw7pIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2bQp7a5abe948G7QGa99iAgOBwGKptEseVN1PDUhyUet+TmlzynJl1SRqfd1vC9GZ4RKOXg+bzlhCWEihF9VUWMngdXJivLw805w1sqhDv2gCN3NbFxevibM2qwkjKyGwsvXFxZ438vTWrJOgetDsiKguO9SSsru6uYactOiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGgtqgyi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441ab63a415so31890985e9.3;
        Sat, 14 Jun 2025 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888012; x=1750492812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ucToUG/VQ7WYTQ0UWzqAQfUODZusMjPjtsC9OuJzoQ=;
        b=NGgtqgyiZ5cRIlm3qu4VUdtsvxGHuMDNrPGu7U++TjsRdAMrrSxLpjRjLt26nOvYxy
         QwmUpAI8+2g1i6eJrfQhSGlt4SLI/tO6r7fG403pqof03P9iJSWTP31VZ2O17NpXo6uJ
         w26SKKV+qwIlD4YHJLxz2bvyA2fwfJMy8W/y3s37s2/IsLSZAdmqAcYN/NvAa3m+VbYK
         nMurtZBBPbz8CgWgqqFI+yRMM0+5KwNBLpC8vtfPKhpamMqmN3Whjw/EwsExkUBv6lum
         z5tGchZs1v6RCf65MJm2Br8XyQr8sCMif7xeubhKzhVfcXVm9/ZL0fA+9k83+fFKG7dP
         Athg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888012; x=1750492812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ucToUG/VQ7WYTQ0UWzqAQfUODZusMjPjtsC9OuJzoQ=;
        b=WwWofA8+1t0JfSZhm2T8i2ozfgOv17dq444Yaa/tC16odo9jXDdwDeae0F2xCeknjf
         0wmSgg8/posB8RPrdwe3O3HIC++VwfygDfxph2FOTXQ3emfZky9jSYqtu96QuY5hU90s
         ZeHByZnI02VV/+3knNECejVSKVcYc/boZqKm0UKL4GB4B+qtB+MBExJ3QxcmBX7MhSKn
         yvSCqmuh2QWzt7g2cEIOnWDWwXxmglbVgjlOF+jyVQKAJo4BZk+cWT219buXKa3Jwuuq
         pxY6BEED7Mve7Ms4PxCyJMLMEcS3i6X187dVQ43XVr3F3W/S7xlD8CdM/Qm1IMh7+RQ5
         PVig==
X-Forwarded-Encrypted: i=1; AJvYcCUlT9qKoNw6FHGLRzSaEqYPFITNnhx2q0A1V/e6A5yhxGInDGLpvH3l5smwmAkoLscX0G/Eed2o@vger.kernel.org, AJvYcCXY0rAObgenaUQKHDqIfoQQTY4KyuCm0D/crwR0304yLyN4UM/oUX5AeyuxcAh+jQDNbZjHdDFEcJyBSyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10Qfmc8Q2233nYt2lwVXREPd+619yVytigRiWa8BlwrgB5PSJ
	4zT6dBoJaUO1xassdT5gQ1gouJc5cSVcMi8kwc6aLVvAc8w871YwXpbI
X-Gm-Gg: ASbGncs/jAB4/0QXLfbBIhT04LCURgKPrSWLtrTmsf9SC3oFfoOVod+PYcIG9LnELhM
	wZwZhC6gKoyn0y4YJU0ZOa1XYAUSGXfXf9OOWA7bLa8ORluumljTnkHCJxrm9A7F3kSTKph2Or+
	/V6Ix71adeBEpjoVhxMcNw49aXtzWmpyq9jPRfk64O9TS1NNvh6Vdda28Ajn0KfIz5TtW1pCLXc
	XO78SD44pfNq19WhITBLyz+0TThuSjzJqbh0L19tCC/UCOHnrwPo1Y9iiaOa9dClXMPPZFjrGeT
	SjrZXX6SS3hPjGQ/1Yw6Qupk+gFW96gOxnTJz1B1GdoXu/ok2amrkDDxMOYQi++DUVqmRou9JZb
	fTle9WU+uCT/5FkwnEXKUjr1dlz9IvJRIqoLMGRWMhI9dwIJdtbcDtLfjiCis9Ys=
X-Google-Smtp-Source: AGHT+IFrkGXtk45CXP6MTr2VfLO5k7wC++dC9n1e/kg639cum3XQAH8V3EYylqO1QwiOwdowsKGXDQ==
X-Received: by 2002:a05:600c:4f56:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-4533cab8eb4mr23271045e9.27.1749888011962;
        Sat, 14 Jun 2025 01:00:11 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:11 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 06/14] net: dsa: b53: prevent FAST_AGE access on BCM5325
Date: Sat, 14 Jun 2025 09:59:52 +0200
Message-Id: <20250614080000.1884236-7-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement FAST_AGE registers so we should avoid reading or
writing them.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

 v4: no changes

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 033cd78577f7..e4e71d193b39 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -487,6 +487,9 @@ static int b53_flush_arl(struct b53_device *dev, u8 mask)
 {
 	unsigned int i;
 
+	if (is5325(dev))
+		return 0;
+
 	b53_write8(dev, B53_CTRL_PAGE, B53_FAST_AGE_CTRL,
 		   FAST_AGE_DONE | FAST_AGE_DYNAMIC | mask);
 
@@ -511,6 +514,9 @@ static int b53_flush_arl(struct b53_device *dev, u8 mask)
 
 static int b53_fast_age_port(struct b53_device *dev, int port)
 {
+	if (is5325(dev))
+		return 0;
+
 	b53_write8(dev, B53_CTRL_PAGE, B53_FAST_AGE_PORT_CTRL, port);
 
 	return b53_flush_arl(dev, FAST_AGE_PORT);
@@ -518,6 +524,9 @@ static int b53_fast_age_port(struct b53_device *dev, int port)
 
 static int b53_fast_age_vlan(struct b53_device *dev, u16 vid)
 {
+	if (is5325(dev))
+		return 0;
+
 	b53_write16(dev, B53_CTRL_PAGE, B53_FAST_AGE_VID_CTRL, vid);
 
 	return b53_flush_arl(dev, FAST_AGE_VLAN);
-- 
2.39.5


