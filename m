Return-Path: <netdev+bounces-196449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6554AD4DF7
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B41BC13F3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7A23C39A;
	Wed, 11 Jun 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hahy49w7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5F2356D8;
	Wed, 11 Jun 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629314; cv=none; b=D6ZcSvkhaQ4P4C46MJ5JZmmvrh2x8LmUNKuOfxWZtAN8gDzCtjJfMtc82ZX7tPZXABxjXfvmsaTVeBICBvlK1x++71vmg1VDn2vbjBJVVOi+NwwkxWSEOUL4s6Cf2jBDmD5oY2qFWgPioMvLy+CLgWsci+mGchRJBge56dwpFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629314; c=relaxed/simple;
	bh=pJPHTm0/+S33mVp0TlQhj25Xaq6F3IiOCyiKOTojx/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suO1tg8nju/Ikwe+vS4v2wXVFAVQpC87SFeYiR5ka9sbvK+V96mcZq5fSpWxgZ2jM/0GQWhDF4NTUv3DRkel316QHGCV8UB+VfTdNClzMn98QNC9NRkiO0IF905zA+ZSakbcj9GVcI4y+shx2p3+PqQ4e54L1N1B98s8x00o0ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hahy49w7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d09ab17244so594640785a.0;
        Wed, 11 Jun 2025 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629312; x=1750234112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eawpl1GdnYK/zxQR8KIApQjP6GTI21JKF4EJB3XYg6o=;
        b=Hahy49w7atTrG7+aUUFGSlvAWwxDD+bDab3qTqPGRbI0rTTyrLN9RKCif57QFUEAbf
         YkB77GRY4YnRW3uDWXNiXreiCVVeXxnINOX0QXQl84JTfg3MqThShMbSZm8omshciaWN
         xqnUPqBonClnDEWV1hqwrQrawvN3lYtlBRCK/xI//9UnvRgAq3p7TjAm9RyGbrcxTecy
         FwWtQbtWuk9MlGaOVp9/VpOTE51xejMODSltJQRUhlVbThV4Q1lVjA51FF2Iq6h+l85b
         s/hzUlbslL5YPAidqtlIB+fjUFr0u2CfqxOd6xzHPhy/gP+Agk1TvxpwuYUiQ12w1J6E
         9hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629312; x=1750234112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eawpl1GdnYK/zxQR8KIApQjP6GTI21JKF4EJB3XYg6o=;
        b=DmEA9S2nTRaoOcEyJUfkvyPI1fzD6k6+5x3PPLXeCaAhDu83PyVQBjvwXPuB0JooYP
         3NOxkWj7Gvk2eXxAh5G8DsvQw3JX+jtib3V48GBzC4wTdELm1/q76Fc3th2BPKOfjRoF
         TpbOBD5iNRxtzWIYxm0oOrlMWwfnMP+KXWYfuWebLbYmYtaFfCSH8cepMckYUSpRYH1x
         5QkiI+vknXEtw4AYX9vLn4h5l7D+vfShaMOdNkOEoJKBkic6YfBnZNnzeJyBi7+ALtRK
         iPOSJIY7MOD6xpkxxiPhozZ6QHnkdYrXuu+i1nJ5/Y3rPYsp0BqZy2KJMttFXpjFyYCg
         T6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2FW0MmON711IUSOxzDd/MSqizdnX3SCg2sYAHnsO5xjz2GqNDXLT80kL1W9e7O+rEF588BWfahhhJ+STm@vger.kernel.org, AJvYcCUO9KMCWJ5S/CfbTn0Nn1FoCeKu06imc+AhGUsnHNb8QDlnBt7fleV74bxzA/klFCixTFSGlAiNy0V0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn0U6nR1gNrfmodJ81/5sTpXXEEX+bHyI7W9Zz5LX+xBKuS/lr
	2TdpIjP9fS7NV8q6GwZOQAadVB2PTrPLhkMTxna32w/1DZ6BSaYmJzEB
X-Gm-Gg: ASbGncvKiAH8FuzoRmXogVz7spaJeyHTKQoeNSHxPGtKdAdF65EmD4ZSXOr4UL5/DmG
	XDU1pL0SuP2XbR9Ooygfq7XN2e54xYyMyUQYMlMZr5YOw3ttNEXoQCDUKM8Bp5r9jTaTrDrKtFp
	trTLgXVvRSEXt2U3ROr2AcwEiLyV94p3sydxET/qB0//Vzd3ZPHJrWLpIkB0RbNu5wKJcW3od1v
	uBt9NKqvewRp7Ub3Q3EiTo8iu2v5ao8YosPOJZnG/dtgAWU7gTBacsGLFjKsB2cIL6jUpe8/36u
	A6WTZJilHATe1WKnZHu2SKyR1p2K+81iONqPIReDw4gzHpW7
X-Google-Smtp-Source: AGHT+IFnczEgxOSGRihWUwZv2+9Bzf8GJGZO6uYjLD1BPRfJ866LMMcxtdUJOLNxegks0WI+Vt4oPA==
X-Received: by 2002:a05:620a:468f:b0:7d3:9203:206c with SMTP id af79cd13be357-7d3a9546cddmr304354485a.9.1749629312081;
        Wed, 11 Jun 2025 01:08:32 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a6198669b7sm85188931cf.67.2025.06.11.01.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:08:31 -0700 (PDT)
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
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC 3/3] riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
Date: Wed, 11 Jun 2025 16:07:08 +0800
Message-ID: <20250611080709.1182183-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611080709.1182183-1-inochiama@gmail.com>
References: <20250611080709.1182183-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT device node of mdio multiplexer device for cv18xx SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 7eecc67f896e..929864ba1b26 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -31,6 +31,32 @@ rst: reset-controller@3003000 {
 			#reset-cells = <1>;
 		};
 
+		mdio: mdio@3009000 {
+			compatible = "sophgo,cv1800b-mdio-mux";
+			reg = <0x3009000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mdio-parent-bus = <&gmac0_mdio>;
+			status = "disabled";
+
+			external_mdio: mdio@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+			};
+
+			internal_mdio: mdio@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+
+				internal_ephy: phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0>;
+				};
+			};
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
-- 
2.49.0


