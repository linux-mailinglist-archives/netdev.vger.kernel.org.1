Return-Path: <netdev+bounces-194497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F90AC9A75
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AFB1BA2D1E
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B723C4E1;
	Sat, 31 May 2025 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiEmPxme"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004A23A58E;
	Sat, 31 May 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686402; cv=none; b=sCQy+ToX5O65mZcW6BY7RaDF/lF2rfMjt/gCEa/nbx6k+KBzbJg5var5a29D+1JMp4WQK2idg9VZ3ohUV6DPVLuoIHhJ7Bv+Rcnw9vawKBMJnUIM2pTN2wFqvD3/huWGFYsRPubARJQAixuX85WVt7nFZRzf6EKBZd7arFj232M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686402; c=relaxed/simple;
	bh=iYL0kWo8C57OTblWURhzlRKwScVsjVOvYR5N2tjG1Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqU20lmKg+Vok4lorrrnK4cnkb4VVkXJ8nTI71LMMgA9nhUtmyuzNxwZOTp7bM3YWTAASSuPnta0iq++Ika3UF04zGkJBnmUH7WvgiBLw1PSl0fAg8AGdGmEMGtaSEq6odixj9+kyHNZl0YIxyeXH7InHfFjYaJM23Oo0rRYxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiEmPxme; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450dd065828so6688695e9.2;
        Sat, 31 May 2025 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686399; x=1749291199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh3R/TzUelfavHKA781XSSQcCKCc2NKqjhPYGHehZcc=;
        b=UiEmPxmefcd+3NxDM1nA5AN1T2skmC+XamSwR31/qY4tZLG1XSGYDLlR/WQMMnCpDA
         z/zSPBh2vRrvwgSUht8yL7XFKGuqBTwGDpOcAF/Ww/WZWFVnjl1UsD9sySg1zLPvv1SC
         5gRB6bXghyThI6ZOt99P7gbwu3EJTNhUAq7ROYpWXAUjYh9ZOGZYqlBGzP6TI9hl1xb4
         aNAtMeycnNhmr0AUX6hgbRNnYbPhS2Ju2Uyy6tPSgNlcf3zhfFdLLCKB1Bl6bMgRDiko
         07hy8Moj0k0pnogkzzTaHFQyxHw6KmVXJ5uzCY+Tv/dBDjWy3gjtUp8U0X+POdcG6ys+
         xgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686399; x=1749291199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh3R/TzUelfavHKA781XSSQcCKCc2NKqjhPYGHehZcc=;
        b=cXrNUmJyNO3zAub3x/SqMxBuVnK5iJzDam2Me4YM2FjH31xqqIp8E09AJcyRwhtOgw
         5BMteY2s1lPvZ96Zl962/gIc858AxqW4AG1xDWVgO8Nhiqx2Tws3ZiK0OmbiZ98BMSX2
         V0k+h4a/6Bkv1QM0ulVUZKXIrhO4wHiv+FLaaIknBD9jUMJVUSIsEmbqM76aG2UY/LEg
         gVDyCRi4+CzE6ZwzLySoRhFYc5njPBAwMSQFk9UhBr+Qy9gA6SGrkd8vgFAavpWc0eZw
         GtQobbXXo3wFqWLy9Q1PWvNydKXedI0u5D3ekyUIv9USTQem3/EUx0XL4Pea57SE5yul
         CDjg==
X-Forwarded-Encrypted: i=1; AJvYcCVD8BIy4qO1DzEIApxyI0LmubzPtd/7P+LCgyQxtYbOAW8Gs6FLiq8CGE/A9T1X/gki43cva+eolf1A+Og=@vger.kernel.org, AJvYcCWnHohYgGBCtxaE+IpnFzJFfbecFLpxG1Tj6dsbHoXlecX7ZCnfTHlJ55/2l/M2/Yj02BCTY/4u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hnr21u8Rcka72nrX6pW3nSjdxa2hEyhcNtNu3aJYEwlho5M+
	xnK92rxj6yg4ssN4tZv8+NK9LDX0h9TEVO17UuujgNR1Nl7vCcxnnBp0
X-Gm-Gg: ASbGnctJUdDvxJv93XxTxLoaW/OWLqjsC56HfavkRDkCacCiwS0oM0vJzAGND+UQU7D
	Re6OEcD7IM/uLKKSiPcSe6LYK/cpaWtej4fiCqWC0u7FeuYVUWXWWxyKlp0HGgJM2F4QU8Goy45
	6dL+4w50KbmYtIfCYLT34Upg44BV/UxyPzCEIIeXBplacpqBBu5yR6p1PpplMSvLrQGJaTCZ7gL
	XSB86Bp50uuyIDZtR3H/F2tThP8Ewt6FqrtP7nby0h0cFg6vDGL5aCo1zHG823htChZy4WTeSmj
	hOg+f3Lhwv3OpvzBZRWkNpnY7kz600syaWCEiOgjB2dRttVhm/wbWFJ7ybauzv3wM7d6yR34i1e
	yuPLHMAxiLyZN87BIC3kcjGVxikW2mC886JEz3vJlwxA13ERyM6cC
X-Google-Smtp-Source: AGHT+IGDsr6ifFUyjtVi70suMX9WCC3/QjJkvaQj2LDwz1Cbt6kd6e/IrJ8tt5SNLKqHnQNZc6Y9pQ==
X-Received: by 2002:a05:600c:5294:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-450d883b9admr47493285e9.13.1748686398975;
        Sat, 31 May 2025 03:13:18 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:17 -0700 (PDT)
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
Subject: [RFC PATCH 04/10] net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
Date: Sat, 31 May 2025 12:13:02 +0200
Message-Id: <20250531101308.155757-5-noltari@gmail.com>
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

BCM5325 doesn't implement B53_UC_FWD_EN, B53_MC_FWD_EN or B53_IPMC_FWD_EN.

Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 13 +++++++++----
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index f314aeb81643..6b2ad82aa95f 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -367,11 +367,16 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
 	}
 
-	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
-	 * frames should be flooded or not.
-	 */
 	b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+	if (is5325(dev)) {
+		/* Enable IP multicast address scheme. */
+		mgmt |= B53_IP_MCAST_25;
+	} else {
+		/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
+		 * frames should be flooded or not.
+		 */
+		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+	}
 	b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
 }
 
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 1f15332fb2a7..896684d7f594 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -106,6 +106,7 @@
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
+#define  B53_IP_MCAST_25		BIT(0)
 #define  B53_IPMC_FWD_EN		BIT(1)
 #define  B53_UC_FWD_EN			BIT(6)
 #define  B53_MC_FWD_EN			BIT(7)
-- 
2.39.5


