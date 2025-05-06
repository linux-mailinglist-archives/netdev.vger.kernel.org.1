Return-Path: <netdev+bounces-188282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A82BAABFAE
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0633A86CC
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC52750E2;
	Tue,  6 May 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFura01T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29926C3AA;
	Tue,  6 May 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524004; cv=none; b=YTa5wENBeQVsmBw+y/hwfE6dfgRVCMWg5uxdYEJBMrVdfaIHmrvLH1a7Xe8M/4E8eLT4cbIYbGhVeAt9jYo4uHVZ4dLgw59Kc1aQhBpb2LCQ78Nw6uelCJl4l/zOxbuhr8U7oq3zQU0l0wn3NVlGvG3Bw92eorHD3ncW4RTZyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524004; c=relaxed/simple;
	bh=pB4UnMehzDghVR5OwDqwfddSZnWmBw/uJ1d6JAmYPSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUk0k8gAbFl34jT6RLBd7BiC7gfzwEiMFz7aF07YUDgn1/6juzXYrmzGHZrGD3cuJkHwtsjInOpJUp1bKTAC6Bm2ttmx6v7L/iedoXOxmxbiguM5IHhwtWK/TCyhSXO3uD8uQLAOXWK1D0aYT3i4aGyI/6tMtP6GxulMySrQl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFura01T; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8efefec89so54659046d6.3;
        Tue, 06 May 2025 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746524001; x=1747128801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oX660r49SMPlsIsK7beVHLYMkPYM6F+6v7W4PhVK2ks=;
        b=CFura01Ty+KdLjl8hZnhjkhdjM9gMkftb+9ITqPsjwNDDguGBzH9yYhNO2woMDBdIK
         3N8QS+qrCR47JggR5BnfA9eaoXwsliPr2ezMGvWy2awqamFjR+XfjvOTbxo+HnOFF74+
         zhVfCbomWkngGNy98wsNtmhndtlMgLUTN2BedlbYOjAAZ+pFK8i7BXelsgdpTllM40xX
         g09K8E9Gzk+Z1IMwi9BMSz1y8oYNf4gHau9htaGu4WiZ0DlTnvbvjwewxrg8Jsjr4qNa
         tBYkFKytu1aLdmDE1ri5JZ1YE7sWOnyXKW8lqHoDsPSlwlhXXsMAlGERlxRwjkTrfdT7
         HKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524001; x=1747128801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oX660r49SMPlsIsK7beVHLYMkPYM6F+6v7W4PhVK2ks=;
        b=I+dPvj2tpCuClznj7b47YvdgUa46IPt3AvcOlV01cSguMtw4RLSVf05sQtB0a4VZpo
         0KBiXH5YcjYfF6CmVQTbYhdGxiiWkVm/gvhJ+MrjWeckYh3LXpRcZp2HjuS3CA9N+gJA
         UgjUn7MY3MxPW34WTaeZafk3p9ZCsZ/Q8oQmKRxwdkeF7XgQwKlYQ6yqNYRNKSx+EBjX
         asgXV5fQvqsSGThy3S74zB3oKmJSAj9JDk2d5bsC79AVA6wFf+OYDLjDzf5tupK0jtML
         BWk1GxjAw9FwtugTdtsPtXc01ckRKyIvOL+KId5aiDyIcSgU/AyYOcOEbVF3fnIfxu7d
         PZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhgl4M5zqNOztCshoBIGmee3a1lrdWq4/GsW+FCJo3ENJp3mbLVrszsZG3m838UVhTHMOVRMuaiITPqqkA@vger.kernel.org, AJvYcCV5CaGk0pimjEneKvRyXT8zMj4JSCk6QRARtHwLbpSH8iigtmKnVSVqYuuckA1ebErm5Nk/bN0VMbi9@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4/nEI7Ymj0LT8JUrLVx5W2j6L78x1oecdZ9NRA63l5XlWW9f
	cNUcp+r5MfPOglJu+nNbp8jR4x6FMcrvKKuRH+Qitqz8/kITeno6
X-Gm-Gg: ASbGncvGpOZpLQwB4XsP8zQ4hJUJVkycODx89jnJlDLaqRJ9F+6RXxLiqXvj55YMpBx
	S09wJdwcc4X5h5AvRUcwsriP6xkL+1IkkEf8aAswh1nz/k9065tJTu1Gh2MK0YZrid57cpsHnCi
	c2I9eCV7wVeR3fRY4KMv3GbvG4Ga/9d0YhYcD76hgC874RGCLkRjPHx9SATF371SJbJZocbty3D
	yEiJYfVhJrGz6jZqW9Lt6p2b2tJ68swascnm4Q47Tuu6bxAaY+VbSxz32f/LfI5BbXFgQfNOcPP
	3uPbM67gmPx8qHAW
X-Google-Smtp-Source: AGHT+IG0tpbViwqp9IJzfEAZpGJYiDuvgoMTMj0cgQ10I3tT7p2nWJKoF5IKgXDVmrvJ8d3QbJqUDQ==
X-Received: by 2002:a05:6214:20a3:b0:6f4:c824:9d4a with SMTP id 6a1803df08f44-6f51574c329mr249376586d6.13.1746524001422;
        Tue, 06 May 2025 02:33:21 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f538316c12sm6219536d6.0.2025.05.06.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:33:20 -0700 (PDT)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next 0/4] riscv: sophgo: Add ethernet support for SG2042
Date: Tue,  6 May 2025 17:32:50 +0800
Message-ID: <20250506093256.1107770-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethernet controller of SG2042 is Synopsys DesignWare IP with
tx clock. Add device id for it.

This patch can only be tested on a SG2042 x4 evb board, as pioneer
does not expose this device.

Inochi Amaoto (4):
  dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042
    dwmac
  net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC
  net: stmmac: platform: Add snps,dwmac-5.00a IP compatible string
  riscv: dts: sophgo: add ethernet GMAC device for sg2042

 .../devicetree/bindings/net/snps,dwmac.yaml   |  4 ++
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 11 +++-
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 62 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    |  1 +
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  1 +
 5 files changed, 76 insertions(+), 3 deletions(-)

--
2.49.0


