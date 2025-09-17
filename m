Return-Path: <netdev+bounces-223970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724E7B7D0A0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD62463ADE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41B20E005;
	Wed, 17 Sep 2025 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ZtzQoxrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CC31BC86
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106883; cv=none; b=IGZTrH5v5StnQVT3phsTU6b+B5G2FI7dwrBPyXSSHUZZ143N1JvVb73v97qq3ONZnMBqp1LPg0ltBAJFZCbhoVd0W7bM7UTRIfABqgYBhgcPjf5QUCwQD8tUecKQ3tF8RDNi60Xajfxso66ikoramlxycxyVYaHyQtpU3T+DIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106883; c=relaxed/simple;
	bh=DXe+3PYozcWXl57aBr5WezaAMdVFPw3kN1QoS1BjuR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLG2NP0ZEJJ7OAAJy0I1whpGBXSXbgYtLP7aietj+iLHg0S+4JsTspRiF/lh79s05US6t52Ug9PakgA/xGHRYKSMSlR2CDgr8lzjWozsSIqROmKXAZ3otnFD0jFDtscJ6gCRQOWX7n+JOqiyz82HSwvvM82HbatGsq3U23ZYxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ZtzQoxrb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26058a9e3b5so32880275ad.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758106881; x=1758711681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMQsS7dEiEcn1XR+6VViCf5cMvlHhDrANmtU1f3oLC4=;
        b=ZtzQoxrbB/VnwBnWRvWG3K85BKlJGdwoNTM1+O0esT1jio4TWqZWs+yKdSV5yMouXY
         y1S4YXcJsNMzqwiiIiD0G+50MiAYCiSl3/Av13EyBpbjWczenQpABZMWeu4vcY44lryr
         d6s/5/3i9ZHFAcv2KqIXXkP5CUHMqv/XqGRrMwIcnNVNaSh8JSkJN/Zvx2XVEidroZM/
         Moiz9Zovqw1b2GeKTVrUibHz6Tti21WnzIcvAZmKevieerpgiV5eCa0ysqrOhySuMiwi
         qzNIQQ5yNBDImOHRWYxR3Fe7XKiTeA13YiG+F/m3f9o4YQFh9uBu9Q/AaCDztmdMRFzY
         6Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106881; x=1758711681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMQsS7dEiEcn1XR+6VViCf5cMvlHhDrANmtU1f3oLC4=;
        b=C8Dd2ACEQK9IiGdSESvilHMtFYzrd5dMZjntgLXnxUfzURA6XI+uqx3sjpDC1s19dO
         n7iBRpvb6o7gkwciG8zHhvrydq6qpAw6brrFe3rxzcq9L5JULuc5dlJn5UCfqut9uOD8
         fzv1snUrFOQX5VImBEU/mTROgEkQzOP/ggjtkeDEwzoGC5ruyJXMxqMJxPmOgIfPeYUQ
         z1egAYdhH5Tny8K4azuAw4RW65je8/gWRzFJUqTMwAB7i2Gngup+HXLtj84n66u2aci2
         GBqW5tCX4fe6Ve8Mo4BQlv3qMsy1kFMixdPb09YOpv3IYYuny4K5tXKxY2WJJVpTuiiZ
         raRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9cRnRKbB26S2TrUo0Cc9VZYt815WaSJLBKVwDePkShlWUgH6TF9jRQwAIhwMeLbPlZNo1vYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykcGe04IWs5+FDyH6SStxMb73S1eO7yiZUUiPD6BVnuR+dvzZz
	e11tWa63HUrDYz0LSZQfHOsgH3utgnc8OkR77putUNQpC5z4dnQQlocW1AvyiwOFXC4=
X-Gm-Gg: ASbGncu/iqtWWOq5gOLUjmAx7n0bWoc4+gjSPllFW2P52vmdSttcQss79lRyg3RS33X
	iNKz7u0HqqHnDTWJRrJIeOB6iD2Yi1eQ2oGnmmgqksfQvFgP5nHuxPbzNjcXTIxQUO+KK30IcIq
	IxAniXSlDX7oQb6bZ1t1lG6HT2X3x+hzMZLtVKhINmp5oK/jbPKGjTbNjaJ6/QDTmkLGfjNUJH5
	VNMPhR0Lwnm2mcGUd1Vu8GC2HEJxz2fY7JzDV8wYzLSXn7Sk1aWXT0oqUQs+xRfXnwky4ByOtqk
	kg0LasbEbSRaLIyQHbCLz8yCseWZni2uQU22VEsXqo7LUIqJDYqEk7wS0ARAShU9fjdRHIyqD5P
	X49kiYFBEgQR+JPGDLe3KWLr+/LNADYfz7lerj2XqX3ZSjqHbZOcTIx0i
X-Google-Smtp-Source: AGHT+IFzHlVzYa/q3MnbGUKmGNaxoTqhiBZhkinwoVOAqXMfYX6776FYQwngWLp/NNcoxyCfaQZaUA==
X-Received: by 2002:a17:902:d4c9:b0:246:eb4d:80c8 with SMTP id d9443c01a7336-268137fd08fmr17646195ad.34.1758106880901;
        Wed, 17 Sep 2025 04:01:20 -0700 (PDT)
Received: from fedora (cpezg-94-253-146-122-cbl.xnet.hr. [94.253.146.122])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-265819a6212sm94231445ad.57.2025.09.17.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:01:20 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: ethernet: microchip: sparx5: make it selectable for ARCH_LAN969X
Date: Wed, 17 Sep 2025 13:00:24 +0200
Message-ID: <20250917110106.55219-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x switchdev support depends on the SparX-5 core,so make it selectable
for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/ethernet/microchip/sparx5/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Kconfig b/drivers/net/ethernet/microchip/sparx5/Kconfig
index 35e1c0cf345e..a4d6706590d2 100644
--- a/drivers/net/ethernet/microchip/sparx5/Kconfig
+++ b/drivers/net/ethernet/microchip/sparx5/Kconfig
@@ -3,7 +3,7 @@ config SPARX5_SWITCH
 	depends on NET_SWITCHDEV
 	depends on HAS_IOMEM
 	depends on OF
-	depends on ARCH_SPARX5 || COMPILE_TEST
+	depends on ARCH_SPARX5 || ARCH_LAN969X || COMPILE_TEST
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on BRIDGE || BRIDGE=n
 	select PHYLINK
-- 
2.51.0


