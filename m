Return-Path: <netdev+bounces-204822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB50AFC2F5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185827AAB9A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5CB221FBA;
	Tue,  8 Jul 2025 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr8N6MiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829E22B8CB;
	Tue,  8 Jul 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956875; cv=none; b=gfs0CuQUA35+SizTaK4JCURGr4qWwxyC0wEMXax8m4XXQskQZW/vQKKHdOm38AxQKCKjllYrr7gGxxaqmqly2S6M/039CDr9W1h7gQeO8NxX6HEsQem4bfAaUqTmQbuCQABiPlTVFWEWf4o68B77u+JqsLgKbrQc7NwmgzI2caA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956875; c=relaxed/simple;
	bh=/sRu8XgOB223jLFD3unbjdJLgthr0CulTEGpn5wRRFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBYrO7G9gynhap8xnjoKp1sbXwvKkPUrv5Ic8SpReCQQGU3BvEeNa0mP6E7mGNXR1Ay/aLKwmRyyM08k7U5boGftuRP3WP2YeX0FUjLtArPwFVHmDb7/6JUUN/aVlF1RWuqqSL0uaiRlC5v5fEUm7eVV+f7q55TDlyBNxAp5oIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hr8N6MiB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so4001075a12.3;
        Mon, 07 Jul 2025 23:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956873; x=1752561673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8NWQCR/vjjoocQDKQ3G4Y+84Q55VY5nfXeYI6Rtw6A=;
        b=Hr8N6MiBB+0tMgNM+CRkXMxeHsT5G1NBKL/x0mDK+bjZKFKHKbCEBD7tzS8NMcaBop
         eon3lch+AzCCzY1V/m9eb1rvAb0DniZlpO1qy+jfNBy/wa/RAgMLVXx+gXLzUIS84LLT
         VxaztVEcxLY/W9BDxUpgYxnWqDk5UV1EnT7T09JoOld1K1ajKPpXxKE56p+wWIBu7wcW
         nEZsr/3b+F+PSIIOHcKdQOoyOiytDNy8QASNnPCBI4SVilQzMxeyp9qJmtKE/dR0c/5g
         0Y9QMvBcu2cy32yIV/XEPVaGBOg+t46m3BRDFWeMrwjGhrvOr7KdCd4FOf+SNvX8GAKP
         F1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956873; x=1752561673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8NWQCR/vjjoocQDKQ3G4Y+84Q55VY5nfXeYI6Rtw6A=;
        b=Ve2v71mNMbPgMgQ5xdmc8Ka9UU67J74Bcm0Z9mYchAm5gIN99uZoApCsnFYxq5vx4G
         1SirXn+g+9in213LCf+pFnXkyRCo//Kj1WeubbWJ0uupoIjL4CnjeFkYmNHAV5OIrKZQ
         bQB1aby34iqc6oj1pvgVWcQS1QO+Rj1tXCkXvH7VQd43FLuh9eeM57YC5JKNhv5P504a
         gNyTM5e8S0D6yR5ccXtK2ibGdVIWA/PpR4gNJY9JIDWHk9DBXS69I+1ef4KWpopQl4iP
         rrxpf0gUBU0/3ib7ZSFgIXdC3f18chGqoy6VOu+MPFYY35Dy7MEU3zXipIJ/USi2ohyG
         jNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURvnnkCBdEaIgVWW1B5YGbQ20sNFsD9jFGGZQxmwoYi5gX0qiKh1xXlQcXquXvUFBW0vpH+CukoZrraIsH@vger.kernel.org, AJvYcCUgIEzC11bDzPxzgZRRAj+fWUQ1GPa5f7JukZT+jU6Z8jkwiz9vO6FB1f3djEcaUdpnChkQ8yi//j5V@vger.kernel.org
X-Gm-Message-State: AOJu0YxHd/ocgXn4qh+ZxS2lBpYlmpt4MgfZwVD0ozbVK2XiWu/tO3bv
	j1Ol/7SkBCqekX8u4jVztCi83+NzZWHmoqLOT8mm4N2AyeWc2FiAu4Uz
X-Gm-Gg: ASbGncur5nRw7xH1t0fJXikodBqJb5y739pY9WGaLRa9DlN6HACq/wDJkmEo6MF+k2o
	yUWACrgJanYY5nYcxLb1NZJfMh8kg80aA9X/nIAwm425oWn2qOVQYxv6KU+d5sIYeGwEXXdE9Kn
	y1hIAGs54Bw+RmekI/SkPVJN0y72thyV/cOrhhyXj1QR0wJ+LFunSpiyGolBW6tq36qOZBLVriK
	9SkNXvvLB10QtzkHtPIK9gUxciuZQmM+wsbD/bDV9PamC4FDrJ1EjWSR1QxDhb007TsANQLY9wd
	aTWe+pd0np+Rmkdfo5nvTTYQ/Z0K0G+dQPqk5+BfzGL3ymA9wbRvN+L4s0hLAQ==
X-Google-Smtp-Source: AGHT+IGi3okrZezMQqZWaDno0rnyTSGvjOHwFQZN6i9UVU/ZSCdmvAAsyqq8FHCig1FFJj0ZJIxfOg==
X-Received: by 2002:a17:90b:1c0a:b0:30e:3718:e9d with SMTP id 98e67ed59e1d1-31aac552db1mr23882560a91.35.1751956873397;
        Mon, 07 Jul 2025 23:41:13 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c22055c99sm1328425a91.9.2025.07.07.23.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:41:13 -0700 (PDT)
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Subject: [PATCH net-next v2 3/3] net: stmmac: platform: Add snps,dwmac-5.00a IP compatible string
Date: Tue,  8 Jul 2025 14:40:51 +0800
Message-ID: <20250708064052.507094-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708064052.507094-1-inochiama@gmail.com>
References: <20250708064052.507094-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "snps,dwmac-5.30a" compatible string for 5.00a version that
can avoid to define some platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index b80c1efdb323..399d328b3b11 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -410,6 +410,7 @@ static const char * const stmmac_gmac4_compats[] = {
 	"snps,dwmac-4.00",
 	"snps,dwmac-4.10a",
 	"snps,dwmac-4.20a",
+	"snps,dwmac-5.00a",
 	"snps,dwmac-5.10a",
 	"snps,dwmac-5.20",
 	"snps,dwmac-5.30a",
-- 
2.50.0


