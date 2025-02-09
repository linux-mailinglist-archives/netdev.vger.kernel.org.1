Return-Path: <netdev+bounces-164388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4ECA2DA3B
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 02:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F3C1886BDC
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CCC2CCC0;
	Sun,  9 Feb 2025 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnM/WUm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F47249F9;
	Sun,  9 Feb 2025 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739064672; cv=none; b=iUwGgx7H7m9X054rCWBmGDv8t5AHK0qdmtzO0eXIDW8OKynntpjEhdA8kOT+zG3EGueX5ExEsHpdDOb3mtZcKqTRVa/+m9pPOYeEw95W0ntfPvzg5z6Tm12KTKTLlOM3S9/pTu1tb3LgMKNp2h/hWzDe2eGAnNJ5Rgq8ZL4M7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739064672; c=relaxed/simple;
	bh=iBikpQq8yQwFE1O80fDjD7HKlovFb2Lt3L82Wz7M9dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdMF5iPd205tp5Z7P4eHNB5g+SW1+EzoSQ/VT9GXxSTNSK2w2uyvwDkgJLI902kCrfMR5qcIs4LWB4NJOGqqMGYNFH+nUB8vyO+5LFqkq4o5DVz+F5UZX0q5rgpXlkhbtv7BSHMxWGPJawEqSoy5L8/R+bIdrVtEJwiQGtiHurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnM/WUm4; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so33806216d6.3;
        Sat, 08 Feb 2025 17:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739064669; x=1739669469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qd0y+cEEGSMDbTU6v7Sk4WhfgrAmRd2NDHVF935DK4=;
        b=JnM/WUm4mzINuAqs9cZaDnDmfZH2ZK+KxCBDaS3JXObn5t0t8+WnbQws1wg8IYmtuC
         ny7xm4Z2viwRliMXyNG2H4BwN4VP6g35I383AVSCQeIxczOWqsjuLyrUD8kZRsykdynx
         XJOrqfQ/3WYxQWh2HSM9sC0Bi6uy0jpRhOoxooMPVFkZr2tYa6jxHrw5rWVllRfOgrcH
         G8kYXyKYHygQ5v2kh//0IyI85yfms4+yJEAyI8Lcn0PlJnHwMdIoxtHWGtyLBayL72A6
         vt0ccutyhvNNOGM/ZiomndXABCyWFHZ/jqPBY+SKO+mF8roGaLf5V0cQqQE+TBo7LJEa
         gaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739064669; x=1739669469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qd0y+cEEGSMDbTU6v7Sk4WhfgrAmRd2NDHVF935DK4=;
        b=BWE3a0sJqU2y+WfK1a3U/6APD6yd03RmvR1M5rkVaT9R/rk0R3s4XJlepmfg6VHpa/
         qPmaYPXZhd1V0WJkzYUASYmfkAYZFgY7dbfhz/u2T32hT7v/8GnFAuu3tua6bK8Ha4BA
         aFkfDuC/RgQp3wAJLVVLzfeOSBFKFmRCylFjX+RgdlbGJayDZSSmbcZeGLJ0pFle2uxi
         9W6kZwjyogcNK3xqF5UIwD2H/N8Gx8wVvdOJnyOACQxn5P/s+EO37TTJ1IpH8s0/WIE1
         G62BhAPuS9z+obQ3PKN0G6du3Faoq9h429k5iF0c8ekiLdNUS7ApC90a6HHJiJsqJ2aE
         CgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIt60I8S1e1FxGrTHZxzu/L0L3XPmBKeg5E5ZYFuvtsqJAqzVGCrSSCA2bYmga27jRUYQBevyq@vger.kernel.org, AJvYcCVaNemd65gBR7v/17zXs9y7ch6RpZZQ2MK+HSiRTmcepgTmYIT1ERgUR9z/o/ZshsClDuLE7+E45pbZREyv@vger.kernel.org, AJvYcCWP3ZDhqJ/op2Oh+7OuavQVb3EVmL+E0stEKziZLnudd+lBcQGwmBOvLnMhkm3efE1vnN1v6Dbh/eMR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzir/0oHWwLCwSQh+8bBEOpLrnHC2UVUyLZmOcrAY7QrePXVDa8
	vPdcX4k5vV1DUgjLLxycqrM9GT0eg7qo3pw6ZSPmNU3HgCTBMm0G
X-Gm-Gg: ASbGncuJdbxjrTKWYsBx6GLVqZDs/mAzjVZZTtLLrQYexZ2VnQi7lIBuL9+xA3/TI+x
	MNe7bFfbIzZnICpesTh36bozYNxlld9+RkZkpL8QnmE1snJ63UtHJgI5vcVefNttj12lOIa6KWt
	aHbyMy+Vu7Dukiv4+TU8bLxop5qWFqPWfAH/gu3Cvp4HwYyAwWbW4Kd4c3Av7ux+T2CwXbDdLR3
	SvibBs+h+J1dTC+1n1URmX5FcuiIAk/7RS3x0ovsLq4sqeanv+AqAMKdNxAdvOhkug=
X-Google-Smtp-Source: AGHT+IH5+7+WkkExgAKmn9GKbPwQMm+ZPXl5sXT9N8Ac3xNoPPbBjTifXy61nquwVLVZDKiyddYDZA==
X-Received: by 2002:a05:6214:1bcc:b0:6d4:27fd:a99d with SMTP id 6a1803df08f44-6e44564bad9mr147118886d6.19.1739064669217;
        Sat, 08 Feb 2025 17:31:09 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e43ba36d5csm31699576d6.26.2025.02.08.17.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:31:08 -0800 (PST)
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
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
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
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v4 2/3] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Sun,  9 Feb 2025 09:30:51 +0800
Message-ID: <20250209013054.816580-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209013054.816580-1-inochiama@gmail.com>
References: <20250209013054.816580-1-inochiama@gmail.com>
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
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index d0e61aa1a495..8dc3bd6946c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -405,6 +405,17 @@ static int stmmac_of_get_mac_mode(struct device_node *np)
 	return -ENODEV;
 }
 
+/* Compatible string array for all gmac4 devices */
+static const char * const stmmac_gmac4_compats[] = {
+	"snps,dwmac-4.00",
+	"snps,dwmac-4.10a",
+	"snps,dwmac-4.20a",
+	"snps,dwmac-5.10a",
+	"snps,dwmac-5.20",
+	"snps,dwmac-5.30a",
+	NULL
+};
+
 /**
  * stmmac_probe_config_dt - parse device-tree driver parameters
  * @pdev: platform_device structure
@@ -538,11 +549,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->pmt = 1;
 	}
 
-	if (of_device_is_compatible(np, "snps,dwmac-4.00") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.20a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.20")) {
+	if (of_device_compatible_match(np, stmmac_gmac4_compats)) {
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-- 
2.48.1


