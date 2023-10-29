Return-Path: <netdev+bounces-45047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FDE7DAAD2
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 05:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504FD1C20A71
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 04:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCEC1870;
	Sun, 29 Oct 2023 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RBPXQz2G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC06108;
	Sun, 29 Oct 2023 04:28:12 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80193171E;
	Sat, 28 Oct 2023 21:27:55 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 21E036607340;
	Sun, 29 Oct 2023 04:27:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698553673;
	bh=AC+Ls3ytNnSvtsq4GFfS8dc+BFMLEfoCVREKO8KW7lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBPXQz2GQGNqffqr51uwLxSOhlWrlkDw3YEFs3NbSf/nxgGJOX1fcRb6/DIhxT13w
	 gNjyWhoEGy6ckmKdXx87Nqn6KdlEUhVgboS5Gy40r6ymqy5eYtuWeajVDgkqWHVOJg
	 I9Eq0d8Wil0pk8/ZKzljUpTNKrufiMAVWlMujcY4jig24W4WVWezOr+TOm0ymEetan
	 +wqbErUZw9mkSdnV7eMBlLLnQohAi+RhCwneJRwQUHnmc2A1YWDiyDF/Dz2EApxyW0
	 gE2lcXa3TgbG+ktNl+mvhxtR5uG5p7bAN6zMkjQ4hj6Sc9sw7PqWb6bzfFLk0r7nza
	 Our6kpSl5wJ0Q==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 11/12] riscv: dts: starfive: visionfive-v1: Enable gmac and setup phy
Date: Sun, 29 Oct 2023 06:27:11 +0200
Message-ID: <20231029042712.520010-12-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The StarFive VisionFive V1 SBC has a Motorcomm YT8521 PHY supporting
RGMII-ID, but requires manual adjustment of the RX internal delay to
work properly.

The default RX delay provided by the driver is 1.95 ns, which proves to
be too high. Applying a 50% reduction seems to mitigate the issue.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../starfive/jh7100-starfive-visionfive-v1.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
index e82af72f1aaf..e043a27f7612 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
+++ b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
@@ -18,3 +18,20 @@ gpio-restart {
 		priority = <224>;
 	};
 };
+
+&gmac {
+	phy-handle = <&phy>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy: ethernet-phy@0 {
+			reg = <0>;
+			rx-internal-delay-ps = <900>;
+		};
+	};
+};
-- 
2.42.0


