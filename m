Return-Path: <netdev+bounces-201437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA9DAE9767
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBAC5A1373
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612925F97E;
	Thu, 26 Jun 2025 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoNTxfAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B325F7A9;
	Thu, 26 Jun 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924881; cv=none; b=L/lp4X5MHEzOWdWWva5cidKQzIo3UbPGEqNPYnWupc4S6gqyUo+vlmUvLuepgzqPzUrpH5nU1aaEWPtEVKgATRMMuwCnSGN/OFazZh7UaRNlS10xx57bDKayvp1X4crea2HLqk89/b3f2mbrG3Qc+eXlnLh03Q3oASLbA8u/mGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924881; c=relaxed/simple;
	bh=fj+xPee/HF/mBDPxlPDL/LzsHQQkwlx0t0JHpZFbg4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo3hATh6AmO5ja+DSLkY8tkTNJLJk1BRdUdHi5I5XhzsJ2WH7KrRNJ02xdW9yFvI813qQN7mfQp8J5QAiVBNjtDJC1Kbv27cf0mGongZdkX1uoPEVb7ujHH/srlIKSBJHDv3O3EHJW+H1QRjoYoU5TBFncm9v34vArPy05AlhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoNTxfAJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234d366e5f2so10175555ad.1;
        Thu, 26 Jun 2025 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750924879; x=1751529679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFiZF96xm8hXJ6qEv7hyvXI+A/Fh5sgECxhLDPhb+6c=;
        b=DoNTxfAJUX/IT4lIsfAEOTPPHIhDi/WPPwi3tE92XjWWRZ8LoYYveQJ3eZjXTLIhsT
         pBt4pAXdttRzCO8vLevtOIghqCQHWNZbm4TEiI4L2QtUp/jqr06W9DLrmYdEylqkTZpo
         PeVYxqKp9ie6X/vqnw0VqQAoZb79UFFQ2ajCwb+ZsyJD3rMvJtk/VwalWq6z4lDRrDxd
         8acAEc/B5bN5aXh0kBKZ1T8YBTUOXrfZncHBrteF266W05LPaahTKtLtEqYDwfAQ7Wsg
         LsYN73G/qeEjEK2/GJ9FugcDF3du+mBzjA1KNMqy1gZhMLY05q8nQsfzfvTgM0yRcoAW
         dc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750924879; x=1751529679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFiZF96xm8hXJ6qEv7hyvXI+A/Fh5sgECxhLDPhb+6c=;
        b=Q7m2mQ1Q060KZmX6vmkE+GYpwhAeAxQhiof14mw2OC/g1uFtTRkLq/hPI5U21Nz0Eg
         rn4WVUUY+d6DYD3NCfzw3KjnfIG5iDMU+RN/qnoEOgjAk0wQOFHT8ojE+nCR4ITuDilV
         wDlKEoRiZplE4V4cLGeqWu551tVDejxbwhcDA5CLfVNrhDzWGR8E4yyZKaNVpdE5oflk
         /de6K4jDVhn9+oGD1nVIoKh8w6yOKLuQ7CJqg2H+IQLLIMVJw4nqS6yU1A0mXB9Dsu9V
         QqOhOsUiQzCjfJuirTq3vQwtBT4SS8UKR5TK8XkUv55/fRF9UM3h8gEJiK7QybuwGBzQ
         k4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVDEmJ5hubLFSKbzFa8hzOfu0InDdMFKMmrkgCjwnE6QbC9zErQKsy/fs04IQg4HXdETDLZL+0WEb/s@vger.kernel.org, AJvYcCVFUGA25N/XxTxRlXyvYn31IvOJkUfejQTIuDHIfFSFG9j/Id6bcPuGduHi16ilEIcZsEOLZ1yN+Tjf4G0k@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPUh+yEtGC9DHaeCzjnOK0KjmYS9YxyRdTQnYCGvsft2lY4Lq
	fpXGA0McWbQ+ldxKanGIJVLjWAwc/GK+vPT/VfTuqmcvZ9+ufKpXldri
X-Gm-Gg: ASbGncswtqEaFW5RJPfa+NOK2HJ9SikbeMu3yNtO6ERv1imwLRXtwdio18aV6eFQoJn
	DJAsaoV6xVM4G6DL8V7E6cPSBjZg4yoiMN8ice2NgiK8dTj4dKapzPCOKKC/fBWdhyo9JhBNRYM
	9xXxcV3QM78ZwvSYZz+3kgP/3RaGR+KW4rIcFlYqc8YenOQB4gs9R4YclYcRZJoXa504XWwndRt
	7JiOHt6z6mifoKec5HGgOw/AtPJdS/qWyXsjZBd3KU9S2oXbGZvNYfU78bS9dE2ofEL04erzXpz
	BjV1jHnI3kBZf0zsICTwj97K0EwG8T5qoz5z6ZrnhmAoqkAA1kI+LHTEanguRw==
X-Google-Smtp-Source: AGHT+IEa1Hm8a3WI+XQ+UR9EdbEMJuz6B0Te5cpmW0w6UUDcyQFF377cGhIUp8q+Q++YcoVyKJYXMg==
X-Received: by 2002:a17:903:22d1:b0:235:1706:1ff6 with SMTP id d9443c01a7336-23823e51556mr102958175ad.0.1750924879294;
        Thu, 26 Jun 2025 01:01:19 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d8393249sm149406985ad.14.2025.06.26.01.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:01:18 -0700 (PDT)
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
	Ze Huang <huangze@whut.edu.cn>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v3 3/4] riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
Date: Thu, 26 Jun 2025 16:00:53 +0800
Message-ID: <20250626080056.325496-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626080056.325496-1-inochiama@gmail.com>
References: <20250626080056.325496-1-inochiama@gmail.com>
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
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 7eecc67f896e..4c7335ff93a1 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -31,6 +31,33 @@ rst: reset-controller@3003000 {
 			#reset-cells = <1>;
 		};
 
+		mdio: mdio@3009800 {
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
+			reg = <0x3009800 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mdio-parent-bus = <&gmac0_mdio>;
+			mux-mask = <0x80>;
+			status = "disabled";
+
+			internal_mdio: mdio@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+
+				internal_ephy: phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0>;
+				};
+			};
+
+			external_mdio: mdio@80 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x80>;
+			};
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
@@ -196,6 +223,8 @@ gmac0: ethernet@4070000 {
 			clock-names = "stmmaceth", "ptp_ref";
 			interrupts = <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
+			phy-handle = <&internal_ephy>;
+			phy-mode = "internal";
 			resets = <&rst RST_ETH0>;
 			reset-names = "stmmaceth";
 			rx-fifo-depth = <8192>;
-- 
2.50.0


