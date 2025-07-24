Return-Path: <netdev+bounces-209602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD951B0FF52
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75AF166070
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7F223336;
	Thu, 24 Jul 2025 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdY5bQ6h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133191F0E25;
	Thu, 24 Jul 2025 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329215; cv=none; b=ZIsaapF7SRUFzRdFnjEgIPEBBcgjRsou7tfP3yQA44BczjfNskf6bcdnJPcMf3TOICO2PgxhyPKrRNXq0krCqlkVkd7EunntUfFirJJOrz8FSovSwt+kxGt3IwaWAB2pI6+mm+Zet6sd4LWCKv8oKH2DWczvfczKzH3YFhF6MBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329215; c=relaxed/simple;
	bh=HIElUqzs3zxIyz19PRiwLe0jeruLzTT0f1WnIjXKQB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEojSlgR/N7minK0CkFit6xWkbslAgA0edEww/+8TA0jd08ZkKrUugGsgVqSBHIPwthLyXtov7jEhe2uLS4HB14BHRQfZABznXO5oDxWL5tuF+vhj9YqU2ysYd8e+YT2p+gg+I3mFUw4VaiPyURwlq6ndO2bn1Sz9DyzxdupwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdY5bQ6h; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23694cec0feso4978785ad.2;
        Wed, 23 Jul 2025 20:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329213; x=1753934013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKioL68qXreNKW/7olSTjEn+ZmCuIt+/TbGrnJytAwg=;
        b=TdY5bQ6hVKcyCY0zKLr15S6PFHfPQTPMsBtx3tmeVmwnng8Nzb0WwO6NRgVC52USIj
         yhjxbHkSfI4O8m/gJZ6CmwssRV3C0Nn7TfNLNpHF/Q+THn4ZOjm6s0rSUJ6mmkF9ix6E
         pPcRS2JjvUqJrqlN+S5uAeTcpEuFa0ti5TDIvJTD7W3P6kYnw2cOi+5hKWRKX/qwjYNG
         eAiMmBzHpcNr4LKNjcgwx2U++ntASlf+2p/r1zkITfAiWn0hCrJIPiWiEOxrcRWqURJA
         4DaX3rPQBc1QwZaL55Z718mt5Fi3DMIO/CUHai12rOvdmCAGcBRpcn69wsmlB+HsLWSR
         3UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329213; x=1753934013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKioL68qXreNKW/7olSTjEn+ZmCuIt+/TbGrnJytAwg=;
        b=TOncbooTQfJe+u88Qm4sgZgVKfSF2esfyKv46irgQlVycXEKa3bCPJwCSWlNnKU0eb
         FE+3eS9UsrxKfzA9tDT5fBDMiAISjj3gwNFd0YscctVn4EFVZEdUb7Hd2L13A7O/qbZB
         8B8KH1mquz7tO12GxjgigEaJBE9MOC5hm+yW4lk//bcnQi0bNbOCYa5dziU+gb1Lh1qC
         mE6YZt8xOtd+dMjodWevI2JFUcbxGCWgtMMUxZ4wGiniEO/b6d8t3yo+2D1objpixuk+
         7hYGlpAxv2t0/mZN5wo4CH1unLrmFHsk0wFI0gMuex7plIrTgpTqrdVrKk23mwQOjDYd
         2ekw==
X-Forwarded-Encrypted: i=1; AJvYcCV3lMZYgyLg2ZkscKGMLcSiPg3tVyXTdR0ELJpE4FFqPMrLlpNaRI7mUOp2Wr9mXa6tinlvVy1E@vger.kernel.org, AJvYcCX1arMYq0mgaYyFRM7F8u4kLlsvKKNBP/YNbM3IasqLrkVbNncQiT82OwDu5UrSQc+8XRV9QH/W4VXH2plB@vger.kernel.org, AJvYcCXmMJ0XL3Cg7+gMAHCPvxnsMGeBFNy/pUN7E/nSI5JA6/xuS6Sulpdy9CDfNvhQEzISOxu3Nzh8c+7u@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfx9GFx4Zh+4QANx459pX+u+k78a587+M7vd5suHeAtA5zuQxQ
	v47yKxYHOFT/PpjTvcSRAh/ZZ/S8xZXZOtcGdl2uF0JLRHfcedgs3LB++xh30A==
X-Gm-Gg: ASbGncuQALPTLxI8YKfvjcIZCd9XUH4XgkZcxBU3Q9OqWEpwH459wOmy5yjjy4NQ5O3
	nHhWPoRA6mIDpfk0mEAHdQ2BeniKLEiJ3EQYw2FGq+U8Hp/3sfznCegT1IyYzEHm8KwcPaJE9pM
	WHyTCitYrr2n0UvVzL9sQ1d3SPzHdr6Ll2NLIJhBro+Sp9q7aQNpcCVACciJacR0ReJr0evQ+zu
	Q/Heyi12GCK5f7H81N2e1HqLAxbpSNRQTPswny2vpWLRvHQvlk/9otWw3nuKgz4dxpv8z+tOI5u
	dBu1GAuA0VvLWIxukmrTZ6agWg8KVSWVfb8gfMjU5j9kZNF0BJEx8mJw0gSTRXnj0eMRXtq8S8g
	aKRjp93cn30I2IsUSUmpzNC+TqJyTs+LrsEZ5VRCf
X-Google-Smtp-Source: AGHT+IFB2c6RsOa7Iveszl9ND8OKMnqKcaLzIi8cA+X4JqFaERHPs1xOpk1rXu2HZ15apk4oW5K72Q==
X-Received: by 2002:a17:902:e788:b0:234:11f9:a72b with SMTP id d9443c01a7336-23f9820281bmr77424935ad.50.1753329213495;
        Wed, 23 Jul 2025 20:53:33 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f883sm4458625ad.13.2025.07.23.20.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:53:33 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/7] net: dsa: b53: mmap: Add register layout for bcm6368
Date: Wed, 23 Jul 2025 20:52:45 -0700
Message-ID: <20250724035300.20497-7-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724035300.20497-1-kylehendrydev@gmail.com>
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ephy register info for bcm6368.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 51303f075a1f..8f5914e2a790 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -49,6 +49,15 @@ static const struct b53_phy_info bcm6318_ephy_info = {
 	.ephy_offset = bcm6318_ephy_offsets,
 };
 
+static const u32 bcm6368_ephy_offsets[] = {2, 3, 4, 5};
+
+static const struct b53_phy_info bcm6368_ephy_info = {
+	.ephy_enable_mask = BIT(0),
+	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm6368_ephy_offsets) - 1), 0),
+	.ephy_bias_bit = 0,
+	.ephy_offset = bcm6368_ephy_offsets,
+};
+
 static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
 
 static const struct b53_phy_info bcm63268_ephy_info = {
@@ -347,6 +356,8 @@ static int b53_mmap_probe(struct platform_device *pdev)
 		    pdata->chip_id == BCM6328_DEVICE_ID ||
 		    pdata->chip_id == BCM6362_DEVICE_ID)
 			priv->phy_info = &bcm6318_ephy_info;
+		else if (pdata->chip_id == BCM6368_DEVICE_ID)
+			priv->phy_info = &bcm6368_ephy_info;
 		else if (pdata->chip_id == BCM63268_DEVICE_ID)
 			priv->phy_info = &bcm63268_ephy_info;
 	}
-- 
2.43.0


