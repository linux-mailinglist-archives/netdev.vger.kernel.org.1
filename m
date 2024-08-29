Return-Path: <netdev+bounces-123517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D07965250
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2280B249F5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C471BCA07;
	Thu, 29 Aug 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtMknyxj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A81BC095;
	Thu, 29 Aug 2024 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968129; cv=none; b=qBvJfJfsAO+3YUiktpNXCSKTbyoaB1NlHWcXeV+6qnVtCkIfoqS/OXWXiGddas/UckiyL9bi3brv9OIfL3vrkm3V9LW/RqO9V4dnJCMlZArmXn8jkL7R8lyppVOCsL/HRIG1xuncguz8u2vaBU37Rqpxqq9sithODLqGcZjBsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968129; c=relaxed/simple;
	bh=COEFNtJE/tDMpWivQxG4U9BTAApJM5OcBlsBuAQtpmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CalNx4B40apilrwauMncetiEfDobovwEIQ4lL6g2t/ZCyAp5j0P9jGrC22ZqFhDUI8a0pyb0RJ2119yzKyv2zHUZHQwGlOQ4TG38b+8pZee9BShpvhgcF62bEyvaZYTXjjbtdCyP9CyDetEuixQMCQKlCrcLZftuHU86XbtukS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtMknyxj; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70f63afb792so419289a34.1;
        Thu, 29 Aug 2024 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968127; x=1725572927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8PzWOAEwy1jK6JNv1X2qJ9ewUQcE19rtAp/aQITesc=;
        b=UtMknyxjuW29E1mXyLHepIuCgowPiOnLDNhErl5dxtqA00mE3xa4tsNMovVLCJNlYd
         +M1+/+9TZW6gzyxccMvmA6Kbm8td1v7EUYL4kJMJ9/Fog5hyqQxcBgTtsPijFkukK4kl
         JuPm5gHySzlSWHRjQSizq5HtBtWxc2l1ZePd3zVAvpcKmELIB2VNFxnQW+O0CGfy6pLz
         eFvcVDTMEMdTnYf52XNHJx6VR5VkoTtTYiPRfYG/TGL4lPGuchiQWsSyb8RnEA50WcT0
         YWiLEv6s6VLwDpeVujy+9BvaOBa9Bx0eEAyhiM8QtLv0ktzWSbOP2Rm6RL+6FAMntTyL
         HmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968127; x=1725572927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8PzWOAEwy1jK6JNv1X2qJ9ewUQcE19rtAp/aQITesc=;
        b=OnTZTuAZ/ZRsp4vaIZ/+wqM3XCXl4zKD49M1YE+xFImSB/PgWJkSjP7M3WKoOSR1VO
         XJgGU+8ptUtsmpCcDJYRPDGxB/1u3KRTzx//4HBolc6bEdUThiffjmRw6+fg107uPLqr
         +iUdvgR8+3glOUZ0edbwjgLUaFeHhwXKYAfM93rWcnb6bR3oxwBZpDN5Aslyu2F3BPzq
         W/a4lYGQXNSl+Ia2qD7BFN/4Q3wITuWWQGVT98vbpL9SOPggJnaqp5R03w9GKaBp4mCe
         EBGY4J4vco9D1fewhAj9kko5StVs1JukXShreyyCiHS46x5+JwzdEwQ6QemcKZ1iBIpl
         4+3g==
X-Forwarded-Encrypted: i=1; AJvYcCWfyi6eg9+ss+MaNB2UmsqCxa7VXiAxn6E4OBv9koSHLPjzYEMpHzM+tC0wfbcyylkMD+8oGa0058SUYoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrMuD1DV0RoIQW5c2+d7PCrLB1z2fWSXWqKQ1Sgw1nG8J/AMD
	YEUs3Xc06NgoPkNFZ6ZjqBRfAvFbkyxVFE4YpHiuHcRSwkM9xtNCtPG0Ix20
X-Google-Smtp-Source: AGHT+IGV3ew2KHhGaK/ToTWhsph3sZnIVdRe7GDGkGdgUF+z3xmS3+Mp4IaH2euf3r+iDOxs1EfcpA==
X-Received: by 2002:a05:6358:6f01:b0:1b5:fb5e:f2d9 with SMTP id e5c5f4694b2df-1b7e37f1299mr17005255d.16.1724968126975;
        Thu, 29 Aug 2024 14:48:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77a7besm1708029a12.37.2024.08.29.14.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:48:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 5/6] net: ag71xx: remove always true branch
Date: Thu, 29 Aug 2024 14:48:24 -0700
Message-ID: <20240829214838.2235031-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829214838.2235031-1-rosenp@gmail.com>
References: <20240829214838.2235031-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The opposite of this condition is checked above and if true, function
returns. Which means this can never be false.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index d7d1735acab7..25e9de9aedbc 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -719,12 +719,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	mii_bus->parent = dev;
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
 
-	if (!IS_ERR(mdio_reset)) {
-		reset_control_assert(mdio_reset);
-		msleep(100);
-		reset_control_deassert(mdio_reset);
-		msleep(200);
-	}
+	reset_control_assert(mdio_reset);
+	msleep(100);
+	reset_control_deassert(mdio_reset);
+	msleep(200);
 
 	mnp = of_get_child_by_name(np, "mdio");
 	err = devm_of_mdiobus_register(dev, mii_bus, mnp);
-- 
2.46.0


