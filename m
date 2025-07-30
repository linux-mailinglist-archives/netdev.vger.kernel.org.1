Return-Path: <netdev+bounces-210919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21708B15761
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 04:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3415A13A6
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 02:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6C1C3F0C;
	Wed, 30 Jul 2025 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCRqCNsV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B601A08AF;
	Wed, 30 Jul 2025 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753841037; cv=none; b=Q3zTvmECmMGW6L2t4z7hg/3M5avTcjRgY3M2TxbIM4vP1NQuqndAmQ6i+aGEBz/ASVGXJm2QMc85nxB0Qaetlwzg9p3Pq/VajfVyE6Z56zIn2tdmu8Fy25w948lXDAGGUbNEZn1t4tE87rh+HDCDssHpPw8EVFdbixazOrISGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753841037; c=relaxed/simple;
	bh=tNOTgk5cfYeSQllwHgJcVSu1dnlCIYEJFneIXtu13DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1YwxM616kypCMzn8FM08z8qopTyAr9rf/1iUtw8+r/q1YzM5pkyUOqfpyeLpuRcYbr21v3yeTWMJYg0g+ycjxBWfC5EDijSrlNN6afTRylcRAtWDkj7f2xnIDcdBj1uh0nziiz4HJPPqxofhqw0J79v8wu3rDh6WbM0YNS60iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCRqCNsV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so26875865ad.0;
        Tue, 29 Jul 2025 19:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753841035; x=1754445835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0S88vWrDX/3D2Y7EDbkxT+YT68XYSBJ8EPwA4fAnxA=;
        b=fCRqCNsVdpqDWfxCEBtN5k4j8qRwQj2+B47oFlwMLDh4uDNOmUYNVKZ1ZrJ1A+Q4sQ
         ITuClh89MuMmXI7zyP3wwdZwRQGiZ7UobAuo+NsFriAwN4vr6N9FBSjHqO+EmOapXRgM
         j1KCamENtLoFaTBJ1eGjYoTkjHiPSXKk2mhSQuMU2z2u6ph4XrhvxONDamEOABw0QLqa
         a6Gexa+LO5HVgXvBYZrawKvOC+fGxI31FPlPRitbCj3vxk8AqpA+OJlGoUbnpoti0ONU
         jXnPWUcq8MRjRj9Rt2u5zbH/vBKinbhP+HOXDNOfARqm+59qE2rTorVSqIyUz2RHcecY
         So/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753841035; x=1754445835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0S88vWrDX/3D2Y7EDbkxT+YT68XYSBJ8EPwA4fAnxA=;
        b=ON7/q3PdlNOAWSBWu0rupfOsJvby0GIlA+koAifotgqCTKxLe22Ea4WHaZIuUzA5wk
         EEqHa74shX262ZFcUNYa4QICs4/MpRSwM61IVdflmucAeJFJjXVT589mHyaTseZ5AV+w
         a/A8dru+8wPwFgxO0XMW8pR9VhCGxxO7Wepc1CJ9RGUd08zaHL0hCLm7EHkLl7eccuOh
         p1lqBop7V84zFNko19dvp/OBlbzn3iwTFDm/5iHZMV+q2F8cLbEYqSnBJSYA4U98yyqY
         pRsgJ6p2XTTtc2Hz2Wmw6MeeSPW4fubU/kOm9M0DqjFcHhhXb3q7c0LrrMT84BVpUoDD
         6ELg==
X-Forwarded-Encrypted: i=1; AJvYcCW7DyYYPhk7ISsu+lkVVazUcAD1MZCYsSHR9B4UFEBjETFU+PCUDBns5sjKedz3I1ZzAASgB+loezpXN0w=@vger.kernel.org, AJvYcCXRmi42QuJA9+HTc2QqY7S0W6UuyC61jyXl2KDDVwcvf4QvBMVGx9kGPsEZOykwyimXBPGXeMvp@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/3tLDilWKPFbuEoJpr6RzmrpQVpf0mW31nBI9miEOXlSkxPk
	MeI0eIfzZLOg7TIw8izDyw4JW0hc/zImr0Fou9OU2h34Xjl7iN4duqtp
X-Gm-Gg: ASbGncupaOr7oGIZTfXeCMvzo0hzSH4ZRBRoTmxETeFGPZ5ybN0YIB7Af8IIuNyVOAb
	yfE1JxUrzkS1vGujEqGg6Cr20HyemT8C08jrQ0eOXBCg5/9m3lwfQq58ulsPLWTGIIvlCAJx4X6
	8FU2pGGIrqcZbRp5D+MEm8Gwsi3qHL2B8qXwCMCvTYDgDnKSym+9Hv9yJ/nqZbT6qI4s/1dMnL9
	PmY5Hv2xRSbEJ3uZGpiglkSZgty6DOJyEpBeF0aiJsHhYMNQuvr7wK9wNR0ET41+/xaLmsbPLke
	dtAIMr1hu2yv0PybSg2vNWJydwZzdC8IK6vRZo2Z6kVQ+B8Ip2KU7cibfBfFqBq7AAyK0phOBDs
	w1rQIrK98oA7FqgHu1ZHWvkSVtTl5cISPjxMnMffF
X-Google-Smtp-Source: AGHT+IGFz1sZfCaDU13tJ8zvi642WaPCAq4x3qMpIBkVfEi+n+tlqP60YkOX5s7TxbX1Vj1rLfU5yw==
X-Received: by 2002:a17:903:32cd:b0:240:7753:3c07 with SMTP id d9443c01a7336-24096b0548fmr17816615ad.33.1753841035492;
        Tue, 29 Jul 2025 19:03:55 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff71916f0sm70349845ad.147.2025.07.29.19.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 19:03:55 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: dsa: b53: mmap: Add gphy port to phy info for bcm63268
Date: Tue, 29 Jul 2025 19:03:35 -0700
Message-ID: <20250730020338.15569-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730020338.15569-1-kylehendrydev@gmail.com>
References: <20250730020338.15569-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add gphy mask to bcm63xx phy info struct and add data for bcm63268

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index f06c3e0cc42a..87e1338765c2 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -31,6 +31,7 @@
 #define BCM63XX_EPHY_REG 0x3C
 
 struct b53_phy_info {
+	u32 gphy_port_mask;
 	u32 ephy_enable_mask;
 	u32 ephy_port_mask;
 	u32 ephy_bias_bit;
@@ -65,6 +66,7 @@ static const struct b53_phy_info bcm6368_ephy_info = {
 static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
 
 static const struct b53_phy_info bcm63268_ephy_info = {
+	.gphy_port_mask = BIT(3),
 	.ephy_enable_mask = GENMASK(4, 0),
 	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm63268_ephy_offsets) - 1), 0),
 	.ephy_bias_bit = 24,
-- 
2.43.0


