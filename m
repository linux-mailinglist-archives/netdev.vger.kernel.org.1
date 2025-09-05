Return-Path: <netdev+bounces-220344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67498B4580F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862DC1C224B0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5917135082C;
	Fri,  5 Sep 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljCAelo8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C024350835;
	Fri,  5 Sep 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076314; cv=none; b=JY5Q1BPeX0I9oACeuAR2//FG3eBjXQl70Ndaq9trs1qo/RZp+09eXQpzR1qfnQQY9gRRjnzLMDt26pP8fQAEuYsEx8qB2WHyK0Udz8LKvyi3SRkEyrnZxc6Xlzm8ccey76cvJeqvKD7yJBnb+ziYv/BRJii+SDUARTAPU4ULQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076314; c=relaxed/simple;
	bh=Q4aYE+/28Zk3cxIWzyKwA4XRMaaTAS1HFmm3jizFTO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddFk9MW6b0A0RNhL6g+UN2rKCXDQsf2tltoaNHShSwdvlRezZDcBb9Ug2Xb1ZnitV4cmo5XnII3em6WfF54wFqlKqpyEUQ8mZsAWOmHoIV8RXdgqIrmUsLuUFgyP8/yXWHuA2nmY8izar0Gk/HS8gQsvrvCPJ4aloiyD2BayJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljCAelo8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so2510130a12.0;
        Fri, 05 Sep 2025 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076311; x=1757681111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jim+DGKhJ9yJdp2bKdCG48Tska37bVGxJduvhOyRij8=;
        b=ljCAelo8/ZubpbNSDoWFZMVyCQSnIpg4+EmNsFz7+oI0CX5nryHazf2dgutx6F23Vk
         OX0/yrXlrZqitujaHB6OrSiPxJDECG/uDzn7EU+q4bIL4Cy6tpc0ADH5VK1wIlBQ9v/t
         frtfkuhOTAyERCLSd60O74iq1YZ/3W9h0gV1FTf+OFF8GCLcmRMMbzq93Xsv9NMV0P8M
         cDbZcitM9tFHSWl2YwFIKTofUfuxkbcrUzZe3degkNhr2u/veeYj9wKABNoqUs4cfgLr
         WCQO0PO04z+kAfG4k3CVgL/0J2k3NxJAej1tTojmuDGCmD6QqPmEoAPLljuJubgRWyui
         kQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076311; x=1757681111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jim+DGKhJ9yJdp2bKdCG48Tska37bVGxJduvhOyRij8=;
        b=kWEKXJr4N0Qgg1qbpQ6cGz3EmHevqvdPtHN1eElplySNw/qV4X4vf4c4pKxdbomqL2
         gDmubnibq8PL+I2d5W9UJkAMc4GOqpfm0h+wT7ZIkYCt+7rVbroyAjtO13lVBuPtLXOQ
         bEilkWtfVv9p3oelyuhk2WamsDmKaqcUCo71732EexY4Jz2UQrXbeeBLQe0joH2LTNB8
         z3rhHuoD4uUOyj0laZxwVWshP5u1Jg/Qe4GiDhmT+FSTQgcQzYl4qy2Cl7GOe4BnNQX+
         yxkhzB3V86eise3pnoX7oQPcL+v9N+/79hZ6w/LA0P0x8E4wFzDou2cba7umeD/fSLo1
         sQew==
X-Forwarded-Encrypted: i=1; AJvYcCW2BqZEplumluuFWqesc5+fJPtdX6JtbQz0X+LpaMKnJFkKj6ig05SEX1N6VgKmRgXaE/X4/9MFF0nGBJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/74j1neI6Kfb/+pVKy2dWuT5tmIlt0MONLvtgwoKcMDHuCYj
	aswTsYcIY4WPA3tFL++zmbJjzGsD6lCaahvlA6C5CC9Kpsy9KBsDLTDk
X-Gm-Gg: ASbGncstcbVLVp4a1U7yAqHeOZKVcIqcIOMZNYVVJOCCDsLMdlV5CUflBqNyvfVYvEw
	osPgmsr4dJ73oVogSQCZl1z4Lnna+VrdvDA/rDeoiL/UDeyq3FM7orh6NdWsB8gVYDPxZ4kASGA
	+PGfieJtkJTkrbEuj1OMofnuk1q5U7FBhOQ5A4dPNy1DkffDXnbGITHBxjyXk+1S+JKfWp02984
	La4W0Ru2I2j30BuXK4wddAXKvfDfE0gtH9B9K1+2ahOXcAbxt8LEkBeRJ9ha3bM5ii93TNn2w/v
	0Yo4f9q02Mq6J3KNCbcpJ21dIls1dzAv1dKc5C65LErh9g99/AkW8nnhxHdyg8j8k74JbTcOn4E
	INutQlXp7JwNIHQeH8zdXMe96FOs1R+/Q3rl89ZqLVSqOeGEe1cfPgXcpzazsmUcRSVuh+/7HS3
	xXqvbYrx2Zfuylcw==
X-Google-Smtp-Source: AGHT+IEcwBy1EqCDGqzqhC9MlYsukieJglJ84ZkDNqRA1pHjafwFbNpRwIt+08CjNPs40+7jdgIa0Q==
X-Received: by 2002:a05:6402:40ce:b0:61c:7b6e:b242 with SMTP id 4fb4d7f45d1cf-61d260cc398mr20009641a12.0.1757076310495;
        Fri, 05 Sep 2025 05:45:10 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214ec8sm16042058a12.17.2025.09.05.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:45:09 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: dsa: b53: fix ageing time for BCM53101
Date: Fri,  5 Sep 2025 14:45:07 +0200
Message-ID: <20250905124507.59186-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason Broadcom decided that BCM53101 uses 0.5s increments for
the ageing time register, but kept the field width the same [1]. Due to
this, the actual ageing time was always half of what was configured.

Fix this by adapting the limits and value calculation for BCM53101.

So far it looks like this is the only chip with the increased tick
speed:

$ grep -l -r "Specifies the aging time in 0.5 seconds" cdk/PKG/chip | sort
cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h

$ grep -l -r "Specifies the aging time in seconds" cdk/PKG/chip | sort
cdk/PKG/chip/bcm53010/bcm53010_a0_defs.h
cdk/PKG/chip/bcm53020/bcm53020_a0_defs.h
cdk/PKG/chip/bcm53084/bcm53084_a0_defs.h
cdk/PKG/chip/bcm53115/bcm53115_a0_defs.h
cdk/PKG/chip/bcm53118/bcm53118_a0_defs.h
cdk/PKG/chip/bcm53125/bcm53125_a0_defs.h
cdk/PKG/chip/bcm53128/bcm53128_a0_defs.h
cdk/PKG/chip/bcm53134/bcm53134_a0_defs.h
cdk/PKG/chip/bcm53242/bcm53242_a0_defs.h
cdk/PKG/chip/bcm53262/bcm53262_a0_defs.h
cdk/PKG/chip/bcm53280/bcm53280_a0_defs.h
cdk/PKG/chip/bcm53280/bcm53280_b0_defs.h
cdk/PKG/chip/bcm53600/bcm53600_a0_defs.h
cdk/PKG/chip/bcm89500/bcm89500_a0_defs.h

[1] https://github.com/Broadcom/OpenMDK/blob/a5d3fc9b12af3eeb68f2ca0ce7ec4056cd14d6c2/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966

Fixes: e39d14a760c0 ("net: dsa: b53: implement setting ageing time")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* Updated github URL to point to fixed commit
* added grep output for tick speed to commit message
* dropped extra empty line added at the start in b53_setup()

 drivers/net/dsa/b53/b53_common.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 829b1f087e9e..2f846381d5a7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1273,9 +1273,15 @@ static int b53_setup(struct dsa_switch *ds)
 	 */
 	ds->untag_vlan_aware_bridge_pvid = true;
 
-	/* Ageing time is set in seconds */
-	ds->ageing_time_min = 1 * 1000;
-	ds->ageing_time_max = AGE_TIME_MAX * 1000;
+	if (dev->chip_id == BCM53101_DEVICE_ID) {
+		/* BCM53101 uses 0.5 second increments */
+		ds->ageing_time_min = 1 * 500;
+		ds->ageing_time_max = AGE_TIME_MAX * 500;
+	} else {
+		/* Everything else uses 1 second increments */
+		ds->ageing_time_min = 1 * 1000;
+		ds->ageing_time_max = AGE_TIME_MAX * 1000;
+	}
 
 	ret = b53_reset_switch(dev);
 	if (ret) {
@@ -2559,7 +2565,10 @@ int b53_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	else
 		reg = B53_AGING_TIME_CONTROL;
 
-	atc = DIV_ROUND_CLOSEST(msecs, 1000);
+	if (dev->chip_id == BCM53101_DEVICE_ID)
+		atc = DIV_ROUND_CLOSEST(msecs, 500);
+	else
+		atc = DIV_ROUND_CLOSEST(msecs, 1000);
 
 	if (!is5325(dev) && !is5365(dev))
 		atc |= AGE_CHANGE;

base-commit: 157cf360c4a8751f7f511a71cc3a283b5d27f889
-- 
2.43.0


