Return-Path: <netdev+bounces-188285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD33AABFB2
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27135015AA
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C5279793;
	Tue,  6 May 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B234eex+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB472279351;
	Tue,  6 May 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524014; cv=none; b=mBgp30QseEdZOWGSZ3hGOU1iPhVxrhHxdR8CL5fItp0G3KtAscgW7LgaXvEJL7gxK+mDKDoxMgp9vbxdCD91amrr59Xk0Sf1B/1DnzfIpzHiD5kvhu/wm+Ey2cinsFguHO6cJB/zMy/rrxDvhfYiqO40Xk2vWywjAZ2Rf5FuHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524014; c=relaxed/simple;
	bh=rwdXbDvobFP8gDrbsNPu0n4+UgFNdu2ZqlNO+dHj320=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmTYmqPN2deoRZ5XI3JDdka3/kgIzSJFzlyfN5Pf3SU6ZVTnwc1MaQ+xTs0TYU/UYUT0eXUlx6oXU9pTHYzVpGIpf7b7yaWHzWWR3i1bRLb+LtDQ+36wbUgZKARtHeeK6grJVa1cUwHhrKHPjtEoMjxMfL66fk6aVbz9vNjsKEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B234eex+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476b89782c3so66113601cf.1;
        Tue, 06 May 2025 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746524012; x=1747128812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b6FPH7tpbMtyDXufMUwUF6RvC02CLrBmvJ944Zgtpg=;
        b=B234eex+fExz8T2CaT8UKYX7Lz+V0/gRxaYQ0n5rt+QM/rdykgWfomSCVxmPPaVpJ+
         QPrjT9VVdiDkBsCMCJTzFVk7/Z1Y7FUxKiA3QUbwizUQ12YDiNCD1yFVB32dVwHEQA68
         JrC8yNQUIv85SsvL9XZKTeMoGvIFWntMO+mv24cGIQTJ1YyoTRJJ0yAaEqjXRGIvfInU
         ftRK5dMAy0gnU2XLd0QTD+pnxly4MR/nr5eRhxrzjFmTFQh8cVIVQ/3626lfmATE0fsC
         I4/pTtK+4cXPKW5hc+PHxtZZcoGzq7EKBYybdJTLqqdVT6tqW+oot1guFnzwtvdJk5L+
         ZPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524012; x=1747128812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7b6FPH7tpbMtyDXufMUwUF6RvC02CLrBmvJ944Zgtpg=;
        b=FO4GswwrjlCAe2Xyv3CU2wjFd+1pOh7VR+uwk+BC3XPsxi5jc3T6gsOVeAfsS/dQMK
         08JjcwGv2FLmrzr8UGvZ8J7M54rsKxWkyxlFslOIJeHtZg9Ri+Kq6CqnqVsVpJT6BQig
         FyanbPWNDi/AufiJCoAZsx7KT5mwQf3unoEIIRtzIMEvLajbrTEuDrAcFSF5gqfuGOT/
         pKTVxbM7H4cIX4kEDeNzpuFgLXTeuxgpvtTtElTqZWctsvXfA41pjfxUXepM3wtEuu36
         vNYeE+hJxMcl76hroxeV4q0aUiZOARa07Li9y4SPuqwk9lAUjHBVaTUjiYjctpUH6j8j
         iW+A==
X-Forwarded-Encrypted: i=1; AJvYcCVNDN4I0fdXP2cuSff5/Epy0dtsnXCHjGfumwEOaUD1AyB+dmdwnkVFA/sIF1BEcQDykyKRfW4IWEaYHKrf@vger.kernel.org, AJvYcCW6Nyd6BGzl60D/TdLt3KslCufa8P+cnloFzkesJw2Y5wUFBkjiLAEbpbfEnkiunFhnAU68CahbTULN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ds/AeEBNfq9flQKyreaUOk1AasOrRiGGjYb7JvVboJ1H5aVB
	GQy+PjMAvB5PEUUKpJBRCDLMRQADGKi6Upyp0LKJvCMzEEiaoAy3
X-Gm-Gg: ASbGncsI/mQWw10z4Fn4MXu0MsF4C96lgIAxTK5y8MLCUDlb0N7L+nZ6Rx6qj1w4BYj
	PfANbKbSvub0A+P3s07cd4sRx1DzTOdmRbhmtAB4PmUobfKTiP5cjUL6NCwrgs/BeoHWUzRzF4Q
	Iul1WrfGIxnJ1iAEHm0c74bLXsf6+Jic3eC1S0xE7XXbMDJzSA+pYwV9mmv4fRcAKL29dY32Z1J
	l0lI8P3S0NYhdHZzZGODYaSTH9cOSfufMaTPttp079Xwn0Tt+gqiypEWH/zmMBRTACsjvU3Cnx+
	YqThEDNO78lQvJyt
X-Google-Smtp-Source: AGHT+IFxXii2pf1jlW5RlCREc3ls2A9Oonn2wTcNloToOzLYm2iAZfy1uAN+qSi/0vm0NCoUaFddKQ==
X-Received: by 2002:a05:622a:199c:b0:48d:e36e:9836 with SMTP id d75a77b69052e-48de36ea26cmr138510361cf.35.1746524011717;
        Tue, 06 May 2025 02:33:31 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-48b987209f1sm69892791cf.52.2025.05.06.02.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:33:31 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Subject: [PATCH net-next 3/4] net: stmmac: platform: Add snps,dwmac-5.00a IP compatible string
Date: Tue,  6 May 2025 17:32:53 +0800
Message-ID: <20250506093256.1107770-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506093256.1107770-1-inochiama@gmail.com>
References: <20250506093256.1107770-1-inochiama@gmail.com>
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
index c73eff6a56b8..de3098a773ba 100644
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
2.49.0


