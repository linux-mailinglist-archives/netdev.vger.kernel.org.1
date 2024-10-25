Return-Path: <netdev+bounces-138910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632D19AF675
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866871C213F1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9523D3B3;
	Fri, 25 Oct 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjZUWLPF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1B39FF2;
	Fri, 25 Oct 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818631; cv=none; b=f8YFi3l5ONlSsRMXpKjai8y87mt5m2XXWIO61ssSwPbWgNMFSF/j8+wal+fokxHlR1SVPN14DNPqBh3mzOTwIfvXERBVFk9ZvwM1jpdOUoLjccsE24H/Mm9d41Ot2m0O+wCC8/GtvuRefTkeRpvD2aaiugYFl+CBVgmk23TjHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818631; c=relaxed/simple;
	bh=vMFMrXzztda6HoheqmQ7CEavZSRuUMIpXDfn/S5dXa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LioRQS6v1Rr90I9ea3txK3Yxz2QMzPSktpYbNexqw6dFTjeRm6K/o6cMYsb8MsE+Fu9bHAP92UdEo2k2mWlotWYjr2R11gSQjZem5y+3j3v4O8dq1Vv575HK/+rHsg7f3teHFtOTT28k2ByNo17SBM2sgvOlKHEUu6Q/A5R2zhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjZUWLPF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c714cd9c8so14559175ad.0;
        Thu, 24 Oct 2024 18:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729818627; x=1730423427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgTXpRaa0CS94DWebND0XpyXT65bwzGX/MVLfeTayUc=;
        b=FjZUWLPFNORuUerQI4FMLFXUaGXyGlsKAlFrMHnjMght5mwaRTMzGyBNDJn34nDM4y
         8V+Gzluv7sNins/S8eqZ48CoKygdhe441q6C+RRUVF4J6lsBIApCWAkJU1XeNUxX+9f0
         XV0kXTi8Tc3bXDGQfmppeJDggYXUoQ4Eu4g8caXA2CB1rJZhUtAdHkjX2AnA4tTDPtXs
         FlW5pdLHeA+VwNyY0sfvDFLVFaOZLw0WlCMUWMqn7e9Su9pvGinp9lIL8PMXJsjhkd3V
         pfckT68tTn/+RnZc+JJ52TkbK6m14KeqN0in+GoJRWsopLeF8GRpy3su/7C6wlMt9CHY
         xHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818627; x=1730423427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgTXpRaa0CS94DWebND0XpyXT65bwzGX/MVLfeTayUc=;
        b=lHeJTxDAAUBmc/YsACubYRuvxUHrcGWbOyTmLt4r3zFQnmTEb4GxEJ+7xVjKB80bEY
         0w4ahTi1DHLq3156xblYkqIutTumvNj0SHNhVDROzeIzAnv/dkKwA1V2mQ1ANgfg0Cvb
         Sh0y8hdtUB6YcjInUPei686DsjaOBd3KXc8qb9mIVDioc5JcXSbKQA/VGVLKiVLvdKGh
         NgRQEdfTqexsINoOtzlENs/zuT/DRSXMWzv95OA35h7ZoCWJTRUXXrGu+r3hybJNaUgG
         7mZbK2/WZ1xuEupzIGD7cMyfjSTQvhMkFgpbR5t7w5DFgGhL8SWjhHIjex1F98OmhS48
         FQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBsFUbUHKf8OReYxpmagaffB2YhOhK1LbA9mFYeFIgWruGT280m2ovs/3dhapbevLdCDhfHxAY8PSBT1B+@vger.kernel.org, AJvYcCWblKzd2DZLGkWOv2pSrsoFuSENyUfvaiZLxSHZQgzEXwAGDr5KMxwrDjpfX7JGTsPMRjJpzM1z@vger.kernel.org, AJvYcCWk2d6dKMvCVCN2kAjFZS4WRGLchIaVMaV8FVag0HUSgk/rIzTkW64GPqMAWVQllEWYXzzJFI/uwRS9@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFsvteAYtTqehPsj9RaCtUfJVvsfQaw+aBuPxijQAKYApUri7
	bHstTdExOivI51jjCt90WGl47Z64K8mYH0xevYwMD//Td+1qRUbW
X-Google-Smtp-Source: AGHT+IFuYgb27DRjo53S1PNy4oCfKnzd8OhJaIYDcpXqGHoe0olM8cbsYPvMtmxuGJEtJGwjOabQfw==
X-Received: by 2002:a17:903:22c9:b0:20c:b090:c87 with SMTP id d9443c01a7336-20fa9e5e485mr115146405ad.29.1729818627304;
        Thu, 24 Oct 2024 18:10:27 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc08676csm557015ad.304.2024.10.24.18.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:10:26 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/4] dt-bindings: net: snps,dwmac: Add dwmac-5.30a version
Date: Fri, 25 Oct 2024 09:09:57 +0800
Message-ID: <20241025011000.244350-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025011000.244350-1-inochiama@gmail.com>
References: <20241025011000.244350-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for dwmac-5.30a IP.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4e2ba1bf788c..3c4007cb65f8 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -31,6 +31,7 @@ select:
           - snps,dwmac-4.20a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
+          - snps,dwmac-5.30a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -95,6 +96,7 @@ properties:
         - snps,dwmac-4.20a
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
+        - snps,dwmac-5.30a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
@@ -627,6 +629,7 @@ allOf:
                 - snps,dwmac-4.20a
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
+                - snps,dwmac-5.30a
                 - snps,dwxgmac
                 - snps,dwxgmac-2.10
                 - st,spear600-gmac
-- 
2.47.0


