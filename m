Return-Path: <netdev+bounces-188283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C322AABFB7
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352C77B02DC
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB827874E;
	Tue,  6 May 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU63xvvF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04857277028;
	Tue,  6 May 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524007; cv=none; b=gCCnA7xDwCKZOuhpfF+G/oBpRuP0N7El1tswq/QQwYrej6dFs9U2SKbZ9UdjH84x14V9tMAl4SDSMKBQvP0giTSnGNE30kPwreJGFuFyuQPYoxDTf73fZreVHz0eTcu1bqxMdjBgizrnJIGsR9mHVkF85eYX/bdCggm1SyzaqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524007; c=relaxed/simple;
	bh=NwVarQpNhav3l63GqAKBYjS6ppSh2Wig+n2alcg5C8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gx2Wo08E0X3zlJXqE77PrZUnXw21P/z831Xs95CZZgb7EwMQyS1GXt7SKf3I9lgmUM56L/iASBWQ9OZTSLxcydPFv5qPUPgHr6EAgAJGhnInt+m086uycYzZuP6IpEn/rOrPb+3vlZc8cT/GQLe/J0chQo0uOcmyhOLC0KVA/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU63xvvF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ecf0e07954so88199566d6.1;
        Tue, 06 May 2025 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746524005; x=1747128805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI4dRXqiKm6pX3kcqhFfwk5EZQ1NNLsZ7AEY1QlzP5o=;
        b=jU63xvvFTzxiy6voWYL47tTksFM1+X1B9kCGXgIexEpGd2kUBF5KVI6LQxNuujXpGi
         tV8nKm8a3+tfp4xZ75fPR1vPn0XCU8k2a1Oe/UwZLElPxFwoXsaaNp5ZzFuABwpbMRS8
         pxx1uCyEk8Ypkf7eyioLYoxS+lVRP+m4ugP4G9yBerKL4ZJ4xxcI8uBW+tJ04eJy2B0j
         aJzgIugyu/MqsJaDyHGaDIZdzvLOut7oI2ArazEC4uLzlJ+N1/iu8oFehWaUowk3fbQd
         IZTiTjj97UW8xa5klqVjddsFw0iVlExqfSI712RVBi66hL1qCULr0ojuiv+YdBmdvujX
         Tc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524005; x=1747128805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aI4dRXqiKm6pX3kcqhFfwk5EZQ1NNLsZ7AEY1QlzP5o=;
        b=t/IkZuTkvbThX73A+0g9i5eUvkMfwAjEIJJR06Eyj3Z3dP5NZ7ziVZdxzeqfRT/uaK
         xZl/ir+Lom23fYcAvPgaqil0jDTvujSw86amf39KihcUmw/nuP61PzofNSEkMPqk9t0i
         JJufNw9DnQ99Pa3p5kQxwLIkQtmYgO72EXUGie7mHvrj2g2hZLk/QPit5aFrkANwQ9sv
         BqWjCQLNBaVQw+EsY4K71A9vUNT+NMY4WrrJBQ3Q1CiJzJyg1oTzqm0L0QjKk9OW45dL
         CHR5r43RjrGtJ3RBIvC5Det4lE2ESh8zmMgHHEVyyhfChDm4H2bdqmAQPms1dCZ1i0cH
         XI5w==
X-Forwarded-Encrypted: i=1; AJvYcCW+70icbkIuPWwZDepU6Q5NfXSuGlQO7peaI2wrj+xGl5NJYhLv2qZaLY/b6x39ZyKr6o1QZp8wdVvu@vger.kernel.org, AJvYcCWkyAtsXXRQMmjSeSiGg45ltAnaXgIggR8zvWer6hpH0jbcJOfIY/TmzAUzAkwX3N0pSxfxmqxy4RD2jyDd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfq6i+scPR5MqHwANCtbBhdKkE02TNraPLPE3FilApCs177qx5
	emv4Z8HgKjXsducl6/Wfy4EoMTiLucbo+hRCwZjnTwdO9ZgE5V28
X-Gm-Gg: ASbGnctrUHbr0klB43j+XOyspmcwi67lOlb9ifNDAv6q1e9ILQPWIgDDfjrtxbIHplw
	XPqKBaR3sOpl3FsfiB8pHwNTsNHdBmnmAp2vn7myra2ZQVruwwYJqzhgv69TtHuVXMS1hz5/2Wq
	8dNjjaiVEXWe72MmG8N8li+f6cyDNp6DHo6AmF11m7pZcKMtaVENvu/1h1FaKfBcuCj+w4Z75MK
	28U94jtDc0jzH6w4Fh/Wijxl7CFPI+792r+v+bKmBVgTsc0eYlcTqSq/U6SiZvX0ZVkktpc0yfV
	x0RMIfEw/otLuEZ+
X-Google-Smtp-Source: AGHT+IHQ/VCvHq3Ers+/VvDGnzDvxmpNMck0lZ3995KP7lY9UpCWzOawDdcIMSjGwrUnb0SUUaU/qg==
X-Received: by 2002:a0c:d6c8:0:b0:6f5:3b8b:8d0d with SMTP id 6a1803df08f44-6f53b8b8e44mr12554866d6.20.1746524004730;
        Tue, 06 May 2025 02:33:24 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f50f3b1fbbsm67539166d6.15.2025.05.06.02.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:33:24 -0700 (PDT)
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
Subject: [PATCH net-next 1/4] dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac
Date: Tue,  6 May 2025 17:32:51 +0800
Message-ID: <20250506093256.1107770-2-inochiama@gmail.com>
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

The GMAC IP on SG2042 is a standard Synopsys DesignWare MAC
(version 5.00a) with tx clock.

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml |  4 ++++
 .../devicetree/bindings/net/sophgo,sg2044-dwmac.yaml  | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 78b3030dc56d..f16b49da6dbf 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -30,6 +30,7 @@ select:
           - snps,dwmac-4.00
           - snps,dwmac-4.10a
           - snps,dwmac-4.20a
+          - snps,dwmac-5.00a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
           - snps,dwmac-5.30a
@@ -97,11 +98,13 @@ properties:
         - snps,dwmac-4.00
         - snps,dwmac-4.10a
         - snps,dwmac-4.20a
+        - snps,dwmac-5.00a
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
         - snps,dwmac-5.30a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
+        - sophgo,sg2042-dwmac
         - sophgo,sg2044-dwmac
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
@@ -634,6 +637,7 @@ allOf:
                 - snps,dwmac-4.00
                 - snps,dwmac-4.10a
                 - snps,dwmac-4.20a
+                - snps,dwmac-5.00a
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
                 - snps,dwmac-5.30a
diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index 4dd2dc9c678b..112b0b2a1524 100644
--- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -15,14 +15,19 @@ select:
       contains:
         enum:
           - sophgo,sg2044-dwmac
+          - sophgo,sg2042-dwmac
   required:
     - compatible
 
 properties:
   compatible:
-    items:
-      - const: sophgo,sg2044-dwmac
-      - const: snps,dwmac-5.30a
+    oneOf:
+      - items:
+          - const: sophgo,sg2042-dwmac
+          - const: snps,dwmac-5.00a
+      - items:
+          - const: sophgo,sg2044-dwmac
+          - const: snps,dwmac-5.30a
 
   reg:
     maxItems: 1
-- 
2.49.0


