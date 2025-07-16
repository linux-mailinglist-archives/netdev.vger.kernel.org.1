Return-Path: <netdev+bounces-207330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61347B06A7F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69407AF15B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7491C8633;
	Wed, 16 Jul 2025 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksu0QXoK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405A1C6FFD;
	Wed, 16 Jul 2025 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625792; cv=none; b=kkqzqH5rRdwj7i/NVQ0yWC80NKV7XaL8ruJjTVORr6oXW28NFVkcxxbXzHKZVxvynx8JSZUMm0MX36JzlusXZ8yTKDZySH1510+saZozwzCnqZCn5+DGuXhWI2jNYO1arhL943IdOoiiwZ5WhVbV4ZKpbD7UUSYhjPiShjsCHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625792; c=relaxed/simple;
	bh=b5exiPper4j3NqPaYMcACUGi6QpRWGD4v3ngfhawrmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUuM+DfwlMBaBxTjiwVwH2hibcQ/ZlwV45putZv7wd0SGj0mb1wbERv9V/ZBfpTfm+NXG3JUJjGdU/K1MycdDgoQyPNEnum84Mv+H8b4B1590B7/yDGxrF5Wew53dXB8fiA8m4EoTSnLXcimwkwBiM5WkV8IQJiqcNTU4NojO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksu0QXoK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so7354635b3a.2;
        Tue, 15 Jul 2025 17:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625790; x=1753230590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC/7o+oTeJeB8efXE3ue0IvOfpjdPkkA7L4afw/mfVI=;
        b=ksu0QXoKnywEIIPGTJ+M+fcPQ8LE8/NUqM/bmOQkyvWhX/+KKgUSS7rrC6d+7z3uZD
         /RvmAk+n+81UPHE0o9PsEfZSfTrHKt9sufRWtclsu8WbvQ/cuWnbAFD6PieYyYHxC13z
         3vlkCeHranzaAti1nVZV1FfD6Rxs+f2K9ppn/nbB9WgLVuIs54wuG4n6giE5IvCW8USd
         jK3neIUkFnDCC+mK+iQV4oWxndKZbPzz+ZJW8a7eTwv/h4onXQPdDKegiF1H3/LxoAtP
         xq+0SSc/eQEthoX7nyLbHSLbFwOGh+Cgg+uP0qTBykUUaaDlNCSIPR7U5x6Mad7CBAK6
         LzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625790; x=1753230590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC/7o+oTeJeB8efXE3ue0IvOfpjdPkkA7L4afw/mfVI=;
        b=Mv+hxXCNjJ4tBJB320z1C1NdNuMBdjD/tP4jsm/iqPcRPwW+5fsVyIZFuoUg1Qgwg/
         DFSZGX9TAe2aZhXGI+pbHmPOAzlNZdfr9xRDWgjPpo0l9yqhKSJqBjUDQThXtt6GU+dN
         1UTbHOUZ7s624EO/BAj78tocVHCmqxgsMb9lg9RsnWoAYaRUSX/l8TQb6ALo3JKZ36ld
         DiN3Cqh5RL5L2dVFrrqTh+zZ6nZ2EOf/Qq5IQWlQe2ci8CAsP1q3larHZz8RAnC8u4X/
         +KHoj5vycAwdAy/2sXwHiXZ7ZY/NaI+mDL/AhpMceaoJVZeTQyMpG9QIx6iMqrFUPXNt
         eBWA==
X-Forwarded-Encrypted: i=1; AJvYcCUqSJVeetmU7/n0+nUAYbFnYpMdGNS6T3i/NZKH/ByoZaHFx6bkm+etBOWrbLnB1YK9b9cKFCktbU1s@vger.kernel.org, AJvYcCVGgX+hgVg1XgtBieuEd8IoTCTWEtGGAf9D2U0D5Uxiu+5K1VAQUbqab269+s98cA6ulYMjbeWFJZ+QUjaE@vger.kernel.org, AJvYcCXNEsyMElA1URSziNYgEbswZ1YG1Is9GSBZJCfPnTqAkyw8ZYDvdggOV2pl/26xAOp8LIPK9C3d@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1w5Q4qojKSZfdFMi1ysdkozGrLXPOoarM2FUQ8nVXiNkmXGJ
	U+AnX0F9uPoEwt7qKf9E/fpPxJPPLJyL9Azt5oTa6QwQEIYA5c2qL49Zs1BAVg==
X-Gm-Gg: ASbGncv9l/YJq4U0a+4SH+iEA7FAJyf3Zl59UXgSo23XuPPr9P0AuCE0Yp0c8RZOEpi
	IqtF8UT9U+P9zvhhD36jEqZgH+CORl3jLMuAmlQGBmrEzx+g9fv2XEPyy4iL3SU3G+9HIlE+60J
	532sM4FHJS5GVVkJ3lhHNpSxX3lOk4MxvdoZ3f5cQt20bymFaDJn6NCkdvivCV2iT3ToBD/DSiY
	hMw6cLa+80xFSwlBOLaGJPmGaY6xOlSYOhgcFcJTlKBJAE8WnBse/1i/UdHPlIBadDJ70RqMFtY
	8xA1aa5Z6LizSWu3xLJyjtakYaoV3tFpx71KN2rQOKKVoDg2P/fbNWxarB3uKpgylP9nWBmCy0E
	s5KC2rqQe+6ucAty19CGTvKhxpTA5KUOGLsUYqBON
X-Google-Smtp-Source: AGHT+IFUgHtOn8ng6V3rqRCL+Sq85PYOceZrhx/rvahXmjHQCbf0Ae/XYqwoAT9c8ECibvtKXCjJvw==
X-Received: by 2002:a05:6a00:2e92:b0:74c:efae:ff6b with SMTP id d2e1a72fcca58-75723585a43mr779094b3a.7.1752625790281;
        Tue, 15 Jul 2025 17:29:50 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:49 -0700 (PDT)
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
Subject: [PATCH net-next 6/8] net: dsa: b53: mmap: Add register layout for bcm6318
Date: Tue, 15 Jul 2025 17:29:05 -0700
Message-ID: <20250716002922.230807-7-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716002922.230807-1-kylehendrydev@gmail.com>
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ephy register info for bcm6318, which also applies to
bcm6328 and bcm6362.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 35bf39ab2771..51303f075a1f 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -40,6 +40,15 @@ struct b53_mmap_priv {
 	const struct b53_phy_info *phy_info;
 };
 
+static const u32 bcm6318_ephy_offsets[] = {4, 5, 6, 7};
+
+static const struct b53_phy_info bcm6318_ephy_info = {
+	.ephy_enable_mask = BIT(0) | BIT(4) | BIT(8) | BIT(12) | BIT(16),
+	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm6318_ephy_offsets) - 1), 0),
+	.ephy_bias_bit = 24,
+	.ephy_offset = bcm6318_ephy_offsets,
+};
+
 static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
 
 static const struct b53_phy_info bcm63268_ephy_info = {
@@ -334,7 +343,11 @@ static int b53_mmap_probe(struct platform_device *pdev)
 
 	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
 	if (!IS_ERR(priv->gpio_ctrl)) {
-		if (pdata->chip_id == BCM63268_DEVICE_ID)
+		if (pdata->chip_id == BCM6318_DEVICE_ID ||
+		    pdata->chip_id == BCM6328_DEVICE_ID ||
+		    pdata->chip_id == BCM6362_DEVICE_ID)
+			priv->phy_info = &bcm6318_ephy_info;
+		else if (pdata->chip_id == BCM63268_DEVICE_ID)
 			priv->phy_info = &bcm63268_ephy_info;
 	}
 
-- 
2.43.0


