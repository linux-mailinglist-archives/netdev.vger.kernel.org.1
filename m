Return-Path: <netdev+bounces-172727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3CA55D05
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621141886AD2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82018A92D;
	Fri,  7 Mar 2025 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTsVq3AC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F93188CB1;
	Fri,  7 Mar 2025 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310231; cv=none; b=TIVuWgMdi/+cEo8Fdm/UhamzJRe8kJ24MMeGPKFVt3fBGjEBTitpS8R+CPzSnHIG/5MoK/zw4I7JoNWvsvicHQhiYzCDdAOXuVPC4+cQ5vEf0rsKtuS1+yh/qCf16H2enjR9x1jzhDxZRglVdoPKwooO8Zi1/r7kLBySg4Deo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310231; c=relaxed/simple;
	bh=kmVtyRIsp60GI1eJ+DXHiPcXJHc/x7HJlATseKAAuY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLn1y1L8j4EspggiFLwsH2x1ma03cTtWqgVQ6snmFRUj4O5AInLb3eYCfFC1Bz4h/M8o7tTNc3arbLODa9nsURzwq8SyAccePWe+BLVa7KsrH9k7uMUjU2kiQne76kUhuRhzdrqB/TYaIM7sHn6oPOvrKXhKbEzjeCar/O5NUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTsVq3AC; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so9072176d6.3;
        Thu, 06 Mar 2025 17:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741310229; x=1741915029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nls7kmdirsxklQsEsdMD6n3p+K9nTnYY1CAEZgsVHU=;
        b=dTsVq3AC7lGEnhM6qdisgKFUvZ9i4mmib9z66k1VgGBAuJ55Vupq7eBdYWoeR5IG3W
         i2ZPI2zriKU/f8IMHcQGeIThveSsZMqw+1xA897nw8zdbQlvePu7U21iAvFvRnLYiPXU
         OYjyVxbd5KmYfM/kF4S3q0+bfoNLUGBIqXSXdBjiXSvhgkM1mCkSK8pKpb0lEWl/WVik
         6R5MSfS8u5cUIOjfE/uRcUPGG24nN0gmSWMbQq8Kd+DKV1xUuDWHlfvSvpb+mG4AcL8+
         wIOmkPUWR3kSwBux+7ccMA3jLyGwTy5rcz/Mp/BQ9vpCN2+eFsUckMHp3ac8QxbKSbT9
         vQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310229; x=1741915029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nls7kmdirsxklQsEsdMD6n3p+K9nTnYY1CAEZgsVHU=;
        b=NAT/9R5hKYfzhHG7lTqiWlEgSc+LcKHd9ywTnZxlh6otl0f5mfbZkYzlZG9k+5GaUJ
         B6BPSRJ4UE0AcyIoGgGDFWIPmiLX/lKCGRNeipkUlTRjEc4/mjHWDWAVzSRP2fxpFZsC
         afo6j92XeDaonGLu4aoRJZdUX31DKGSc8DNVBWdDeQed7xFUJ3vf+CWDvM93VICByier
         wFxH2JOoHLM8bp/FroaJxxgPbhxXuAbX8RUg8dy0HpguKVCEJ+gElJ2M8AEOxI1xsun8
         Hyl5ks4FdeAlBHfWoaOACm2OWBxPAKnixm4g81N9r3d/5QqLUTShFAJWSG8TRd0AdatZ
         JT8g==
X-Forwarded-Encrypted: i=1; AJvYcCUs9DIhjbHQhrEpjes6TS45yyTcudqIrtexFoKOaDILU+pHJjonJCNSIFO6itfbdhb4Rca6Vk/m@vger.kernel.org, AJvYcCWsGJfG5HAdlIqs0m8ldyLzLmzCcew3HN4GRj1pllEZtRC84X9zN9kiGTdWiKxZGOXaFo2FZkIPOAYwtV8A@vger.kernel.org, AJvYcCXbn4GFWAwBannvL5D8gRZHsBb/KazkJeFGS7FUrqhXes9tzxje0gkiQaZvuOdNVr9vSQKFfKHPkjcn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Yh+YyjwbH77Krx29fRUtxEZzvfnUL+X4WIQDW1cN9uBJxW3+
	BGdb6qxoMR9S6RogAPTKi8OHnrEeUdC0+jajjxQEnBO6dgBrNJiz
X-Gm-Gg: ASbGncs2KAmdhkjOpNNNOQTHevxXSnS8IS0vYNRBDkRTtjbQgLz4WdCPw6zwleBtz04
	BsnCM3+oefEeViEGPxiX+X8cPm/+WhsS6yKs7MtDu64QVJpeXWc5rU4Q4DYnGk6oti+nzw3yQr6
	yGMtRUFYXLmrYx5FvWWHluRGG+DAvoaZMde2bT1l34WPciuDu4ksbagi09aSJDvO2arXOBvLg+Q
	wp99zL4kSA642Ka7yZGb7H4vE9G5uOzz8YMcEHkz+Qvk4qO6Kj47Y2cze7LZdjvtBkoqP9cktW4
	qCyba5ranzR6rOTX42uZ
X-Google-Smtp-Source: AGHT+IEnrSWy5fjmLrRLRXpT+vxP0RMfjP0l1E+1UYAsKLj6QeQ3FFyDDhycz4+StwMi79ZnygBHvA==
X-Received: by 2002:a05:6214:2428:b0:6e6:698f:cb00 with SMTP id 6a1803df08f44-6e9006942bamr20372866d6.42.1741310228685;
        Thu, 06 Mar 2025 17:17:08 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8fa5cff36sm10687056d6.68.2025.03.06.17.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:17:08 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v7 3/4] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Fri,  7 Mar 2025 09:16:16 +0800
Message-ID: <20250307011623.440792-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307011623.440792-1-inochiama@gmail.com>
References: <20250307011623.440792-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
to define some platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 4a3fe44b780d..8dc3bd6946c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -412,6 +412,7 @@ static const char * const stmmac_gmac4_compats[] = {
 	"snps,dwmac-4.20a",
 	"snps,dwmac-5.10a",
 	"snps,dwmac-5.20",
+	"snps,dwmac-5.30a",
 	NULL
 };
 
-- 
2.48.1


