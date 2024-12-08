Return-Path: <netdev+bounces-149966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3429E8470
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 10:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B90164B4F
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDF513E02E;
	Sun,  8 Dec 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="ukUsVD3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA66F305
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651414; cv=none; b=nepYvrH21ek8ZLY1DCR5OCBUWEy3phxSf0uttvgP0Ic+yZGaVo7M4mOLZ4qvXkbn5E+5gjKAypVXwOyjpRAVp6p3cbCQQV7Yw0Rof/Suc+tmhp3hSeowLFlSO9QVxJMTXLifkdRY2CrCK0PMHU5rXakF2ZCPv6RjpwMazRmbXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651414; c=relaxed/simple;
	bh=4VphnPQb+6q7qtjsx4nt5xZ/a0VCfHj4tzIsDx7BG8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fobnQPiTG91Q3npfpLj00SuBVW3Pkn8llpnzJNGZS5BjS6v98w7MQMfwOx2BuQ7PbovgGbhTus1cL/thxBOPm4YeWOD11PERrfxA+BoqMTzYWaF1DMQ5YRDfQo6/aoNJYzB0MXYtRM6NxpXHVApGNASPrRShVyrE61xL+38speA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=ukUsVD3Z; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so32322401fa.0
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 01:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733651410; x=1734256210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmsak1Ku2aVkAx8thMEta/V4E+yKJNfIXiujSGDstyk=;
        b=ukUsVD3ZXEfzDHR5yKoHG1bjTWV6RlMf3dw7ATgXlCKF7cZqqKu2ZXBC9ZDq5x6nJb
         ngE+H1cbq5j8HBCx9UsJaEpg6RQ/YaofTw84SK8tgiFL0qWi1xNbf1lEJQ155pAt79de
         fcz7jds4ZqNucd599GsDNqduTTf8WmCgMyox/TZ0YJT7XWomA6BBQbq9Gwu8oEUO1FUx
         1wXMbpLCa4v+Vdk61hpHe7geNcPl5rGgOHFjvzJpfTRHtctj0wClorwMtadY8HbcP/24
         1KK8w+Zzt2AkdDCTHRG1EuHSSbwjjn5Yn+h/dJYiLh9z3FN5hGA6zQiw3bnXWzjJ/LM/
         yfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733651410; x=1734256210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kmsak1Ku2aVkAx8thMEta/V4E+yKJNfIXiujSGDstyk=;
        b=gPx60er5SMmleskoYbduZl96/FfTvpcqkOrlQbJDmSW9HdMSpnAYTZyYoOQ4eA8B6s
         jW9vcd8O+3AOlrLf3yKSbjLtCcshanIzO+WhkDcWhU6lEHbPE/KUT/nJj+Wk9s1rw2D1
         O2coB3kdTM9UCS80IPKc458coL2vfRIlqS2ztLxr3zhgWrl8y7Yf/3vDzXuddJnEa+eR
         nez7KVg1YD2KkuSOfB01E3BWmpdRcUwhyvNJKsfMwRg2OAaFLaND6gl8ATyFkpwZYY8E
         HoNb8otDj2iGrN5XQWHLVXHdePsNlK7W9/yXS/McbFbdlHVTEBcM8trz8hnNX6xpGeo3
         4DjA==
X-Gm-Message-State: AOJu0YxLrSieKXGgC4PrJhCZpZo/Jwojz2PzHm99mrypsAPXwQwplw16
	lBRP7KhAL0GZ5pSJkl3BRmdVc0vRmnyvo90vfl2JNtsiK7YOUKH4CpfB6nXz77U=
X-Gm-Gg: ASbGnctrG2jxeYaufQekw+FTjjClwZ6KukWNFkQfPafgibHmnK9fWdCQmXPZgSOGYvA
	JT1sdrAK34C6RduMcPKQXkbDpC9o5u1EY5FqUPZ2ETCDNx/G6UNgIaVQ0idrb/IlU9HP2Wa8Lqq
	6m1HxHlhnPwq9lsr60tGquvJsZY7ioUiY6WrEUbcbyAshGk1a+xXyds7otV6UVl8UM1V1vgTl8O
	GuMWvyhG1/Es+9mRcX9mwLRlEoyLvu+luNoo5wd8jXb+7XNcawhA0mAhcpXfdQW
X-Google-Smtp-Source: AGHT+IE6074+O76DqP9gNjbyHYu1uvrO8N9MNpuHLhOBhgZMLbN1rXyI1oimwgf6csuc4BR7wvP0oA==
X-Received: by 2002:a2e:bc26:0:b0:301:2d8d:a3ba with SMTP id 38308e7fff4ca-3012d8da433mr10577291fa.23.1733651409856;
        Sun, 08 Dec 2024 01:50:09 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30031b80e7fsm6645311fa.120.2024.12.08.01.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 01:50:09 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 resend 0/4] net: renesas: rswitch: several fixes
Date: Sun,  8 Dec 2024 14:50:00 +0500
Message-Id: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several glitches found in the rswitch driver.

This repost fixes a mistake in the previous post at
https://lore.kernel.org/netdev/20241206190015.4194153-1-nikita.yoush@cogentembedded.com/

Nikita Yushchenko (4):
  net: renesas: rswitch: fix possible early skb release
  net: renesas: rswitch: fix race window between tx start and complete
  net: renesas: rswitch: fix leaked pointer on error path
  net: renesas: rswitch: avoid use-after-put for a device tree node

 drivers/net/ethernet/renesas/rswitch.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)
---
v1: https://lore.kernel.org/lkml/20241202134904.3882317-1-nikita.yoush@cogentembedded.com/

Changes since v1:
- changed target tree to net,
- do not include patches that shall go via net-next,
- added a new patch that fixes a race.

-- 
2.39.5


