Return-Path: <netdev+bounces-194514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEDCAC9C5C
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 20:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B5D9E110C
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDDF1A8419;
	Sat, 31 May 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMYs4Rzt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D81A5BA2;
	Sat, 31 May 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748716798; cv=none; b=lcoFoD5+JfmsJgPAloJF14Zf5ciH8UdBRy2//c/e3srxsdLf0GW8WT71wM+keX2VrO0YtZHF/V2V3GjvHoI1lcg8bH7KvhlsciQ20aR44TKs8cRQYN3VmyR6Lj1iZdkfZKejjHyYkjJNvtOpqm5208OOGFTdEHn0qRNYuNEtkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748716798; c=relaxed/simple;
	bh=jB+SAxV67/XkLO7Ja8VKYB3BnV/TpONenLjNMpQ2DpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAlnmbLjwu9cy3ZA/AThoBmgOJZoVXEU9EHeXTBVaVsM8Ac0cOt3L+tGJDI5hMGg7AmQehg/hgLeG2hE9v1ScYQkoP1Mhn8QEAZPV1ReByRPRjTiZl5sH9Cau2FjDqvATv4tqB9lObmwt0Vjh4G3Xb5WXWJ7VBjRzn6zNETWxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMYs4Rzt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74267c68c11so2343847b3a.0;
        Sat, 31 May 2025 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748716796; x=1749321596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNmAyfWjthm2OoYu5rb89I5Fn5ozA8/1Vp5gyVNMnWg=;
        b=GMYs4Rzto4OHd1K13J0oXDTlEmrT9QkL8halgQtcK5CO/r894EkV805JE5m6xbIVIi
         Q9KnYJWVnLglVQVyPXrDcm9sRm0VujTYjvSbWVMBbDzi+n3djbAWjYEZFYm/Ms9bvh7M
         IsMqN+BT9dpLRZUWwKnuFed0xEcIR1XDcF1c1/VVFWq8UCb7zIfng0XLLTabLWTzEZP7
         4sBJtk1lGsRH5K+C6byNanpA31tWXFskiGz4LeXqm+TkRwCaBnrWV4Q7WU8hooui8fFg
         o/2nFaW6MwDiq8IjUGOFa277au4e0dTUJW62EOsw9PLGD5wTewOkkLzU+3JHNd5V8AKe
         9Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748716796; x=1749321596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNmAyfWjthm2OoYu5rb89I5Fn5ozA8/1Vp5gyVNMnWg=;
        b=KxEgorm0lRgNFZHOev/xmNbvPOjiELKQkKnmBwrbnECvFCZygmOk+kB3S4f1nBJny/
         yS12dQo2KND3bWcU8RkDQPQHPW9hHzi99c13/KS8Rs2dJTkPDAGLQ5/kBxmr9YrfTt6W
         q4Z8FIwgoNnDJGvtXJOHH4slvT7NdJG4frR4pjjBqxGE3FBNeB2qvIcJ0aQR06dP/YO2
         I97cwTZtG/vTGjmcfiTBzj+r6z5mDNNZRi1tpcoLNYlxG1yyOZIFSi9wdplhRqtjM4ca
         ybY3eY3X12U61SnC2+OgcPl2MJg8GKPXxtqe82t5BlCtNrU2vVWNJXYseqARIuNboQ9l
         NzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrTBaBIe+i4HHZA4/dEmIOiGVx90q34QvYFet8j0lQCIB9RPfnvkLFdAW2l1mufAof2yJQn25l1TK9@vger.kernel.org, AJvYcCV2pu9g3YpnE/7kWtSmbWj2Sqhnu1ixh9jiSdJyLehkucAqdHVz3nsf8s5GEja/DtpMeOsXAGXh@vger.kernel.org, AJvYcCW7Xcb2/WcNIv+7F8XLBob6ipsniVPk4UxawGoIIU9vcQ9b5drJM7rAxQ0whElPo5Rep+gPNA7ITFQh6Fr/@vger.kernel.org
X-Gm-Message-State: AOJu0YwFb94yEnSgBbXFWgqm5fNhgXCxcyb8jrqoh8lxvcnSs2jeOgo7
	Eu5Kda+PaTKhehFjj3QxAUrvSTKahdki4qf+V6K8CiH8fnJXno+dz5/K
X-Gm-Gg: ASbGncu0VKsQ8XI2IN6DEq78HLhwglRYVq5X+/y6iuNhCVrUy2BqZF3gPYKbj1Ah5GY
	ny6WsGTIYWPZhv9jN+40js2/tV2Dmpp/JDytgPYFYYzKTlFDRvWEfkmGjRb/rtfhgw9EiWrkg+R
	1yGaBPaasgfOXF25S40lrxNc14oSQgRI9YtdK3Fz0heGD/AnP4pu9szI4af+nXy6UDbTrAmWD40
	qIr1rV1W0vMl8ZVrch1MY7dVsCKDDRzB0o2Zz1WmmXYJmDpu/EcsVqw0ZsMmK4H4v0LYCdVfgE4
	ld5zecyk3oDsNa62IRU4mKIYqS0ccuSre3fj3wLU87WYuzXh9b4i5qn3OAEg8PEVrlWH
X-Google-Smtp-Source: AGHT+IGnokTqe2k6JjA0Dh07tmyGJBv4+/KSD4G2Vt+oE6wT2goM5tOBSfJWZO/rloJULn1dCj+Cjg==
X-Received: by 2002:a05:6a00:14c8:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-747c1a1f412mr9111124b3a.2.1748716796351;
        Sat, 31 May 2025 11:39:56 -0700 (PDT)
Received: from localhost.localdomain ([64.114.250.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed34fdsm4888915b3a.75.2025.05.31.11.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 11:39:55 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next v4 2/3] net: phy: enable bcm63xx on bmips
Date: Sat, 31 May 2025 11:39:13 -0700
Message-ID: <20250531183919.561004-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250531183919.561004-1-kylehendrydev@gmail.com>
References: <20250531183919.561004-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the bcm63xx PHY driver to be built on bmips machines

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 41c15a2c2037..0f2956ba472d 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -156,10 +156,10 @@ config BCM54140_PHY
 
 config BCM63XX_PHY
 	tristate "Broadcom 63xx SOCs internal PHY"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
 	select BCM_NET_PHYLIB
 	help
-	  Currently supports the 6348 and 6358 PHYs.
+	  Currently supports the 6348, 6358 and 63268 PHYs.
 
 config BCM7XXX_PHY
 	tristate "Broadcom 7xxx SOCs internal PHYs"
-- 
2.43.0


