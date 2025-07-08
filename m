Return-Path: <netdev+bounces-204820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37DAFC2ED
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366064A4F0A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A38224B04;
	Tue,  8 Jul 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrwM/ilu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6F22422E;
	Tue,  8 Jul 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956869; cv=none; b=rYcP0I+L9POljv1fSusvPdFirxz1jjU3TyKOeaL5iQ1IK9HXpf3Iia42TYN4B1X4jcdsIxmhLU+LkctJsQ7mbDHw54IEIfA30itVYcx1f1FspXyLHnRFRdrM/lEBd0alVOXaYuIUbU/+L+aj+Ptdb1kkTJds4s6YVxc6YcRpjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956869; c=relaxed/simple;
	bh=75xX/EXc4PVXHWWW71cCo19H/tMvd1VYPGknOwQ/RCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POxbmzRIcS8oNMYANMBLAXGGV59JjnUsRyX5jJH780ibSipxtfgpiVahg6uW41vj1hyy6Jk/i8g6rmX5/deX+Zu4acsS2VQxTaoKeKDI4rygvgi47xrIARD87hvTj/NkxdZgsmAm+mb731BPkfFQaT706F1DpxzfvfoHQMEoZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrwM/ilu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso5062944a91.0;
        Mon, 07 Jul 2025 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956867; x=1752561667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3j/1wK63BWsGUKsDNrpQgGtCBr1VsAlvbOLyb+XR7k=;
        b=ZrwM/iluszPPGpzsQVOwDh0+k+Y8KVe8WpnnYZImu80KOz8oDQH3yaGixX4YUXMuZc
         u94c/e95Eb1BYyQmZFTy6A2fb+ScAzzXZCWLNjY8GKYTGPhc68PYaD4sOOZFSsgZuY/Z
         vdFby85Sxts8mASuoLfHZ1snzOFmtxVVHP7+hbpNdKBBeNh3UjEMgZROFK3BNmOsbL2i
         TRbJ7l5We8qYXXaGABFtr3yU0zzxzBT7txrAQL3zzdl4RY/n7A0OLClwtEU+Ql/lFkB/
         GboaHDrubyx0THfjcn45Li3Y22Y/kyN6z3DxHdL1SWpfTJ6SyLOuIK7QJdkfexyMs4GZ
         lPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956867; x=1752561667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3j/1wK63BWsGUKsDNrpQgGtCBr1VsAlvbOLyb+XR7k=;
        b=SqaYp6Yho8CYtAbcfQgrwHX53GpM3mwXwSZbfHwDm1ZLi9FJS+DtiUzzZBg8a43QgK
         h6NsOEmJudVR0yOs8hH0KARrq8IJ0eRsdRGxfXf1LZY/IfhdZlyGKm1GSnunWeVLjorA
         IH2+tyihxy6ig6Vh+2aM1XhC4+4k3mktNxjGgYH+gnzGiu0Fqnv+j0POHoy20b4VsGf4
         zfEHr3Fwa8+XvCsWYMv+fpiOkSo+Xrn7BlC36AapKXnspbehZ0MUT80exE8ZPIrD/11g
         EOYpi11gHobGFhDisoxZSRvPg1Ev1DlX1VfNzf2f99HOTyObcnDJ4TozgNlF3elRP46W
         /6tg==
X-Forwarded-Encrypted: i=1; AJvYcCVjw4R7UyWoZZAlcWzMsp5HusU5VE8ozr4Ix0mHtUcYgjKma1bEO/XmfO9ZMFOzzrhAitKBReS9gq7fK9yW@vger.kernel.org, AJvYcCWZvJZzHE2TCIn0AhaKiBs5onqBhZAmogjZiE0pAhB84jELjE8gxIN1aTzTMjnUuG94Cl/sEUFmzRxd@vger.kernel.org
X-Gm-Message-State: AOJu0YyDn9CbUQDNnhcWuNAcRnZXzZQm3iUZzubiLb4IgMIPkyPnHKMf
	CyqPu5ExzsOm385XMWITFhtfWiXwnDsElIOxhIdBfvlZ5GeVZLmk+ZEs
X-Gm-Gg: ASbGncuBQCxlfzRcJkuMIvoCNI2BC++k0+u+ns9vomU4HcrKTlYk27nNt/r3L/JCYLC
	puNxj2qFARQatfoBlZDQpRgBJDPKIldSTnoGIP8IbrZNWokXvWaKHNcEMQydS601u5ey2Y65/vs
	zOXhgS/wfgHS1RlWgIHGJdtCq8zIvj/xN2bD56v6IKbif440r2L75QA9pECl8x2fyvrm65MDnct
	Yd/E8yk6x9e/1nRJ2dv16SE739Vtyofu1X407flXPkXU4xPgj5pRfwZHj59sp7hBEr1Yu4DWNT/
	6j1qE/atEIIHiIfc4KamNbIaJrbcZRji1W5/s5Cvw4lrkTa2sg/DhjeVMJbjEV2RSR168txE
X-Google-Smtp-Source: AGHT+IFucR+T9yvI79HtHogx0QhFDSYy7llkys4A780hO83hxrf2HV5i0axwF+kJgvPkACEuBN1BIw==
X-Received: by 2002:a17:90a:d00f:b0:31c:15d9:8a5 with SMTP id 98e67ed59e1d1-31c21d8adbfmr2332382a91.19.1751956866836;
        Mon, 07 Jul 2025 23:41:06 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c21d2e948sm1323277a91.5.2025.07.07.23.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:41:06 -0700 (PDT)
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
	Han Gao <rabenda.cn@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v2 1/3] dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac
Date: Tue,  8 Jul 2025 14:40:49 +0800
Message-ID: <20250708064052.507094-2-inochiama@gmail.com>
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

The GMAC IP on SG2042 is a standard Synopsys DesignWare MAC
(version 5.00a) with tx clock.

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml |  4 ++++
 .../devicetree/bindings/net/sophgo,sg2044-dwmac.yaml  | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 90b79283e228..4e3cbaa06229 100644
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
@@ -98,11 +99,13 @@ properties:
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
@@ -641,6 +644,7 @@ allOf:
                 - snps,dwmac-4.00
                 - snps,dwmac-4.10a
                 - snps,dwmac-4.20a
+                - snps,dwmac-5.00a
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
                 - snps,dwmac-5.30a
diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index 8afbd9ebd73f..ce21979a2d9a 100644
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
2.50.0


