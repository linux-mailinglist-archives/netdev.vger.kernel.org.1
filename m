Return-Path: <netdev+bounces-240469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56749C7560F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3BCC353825
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69678366DB5;
	Thu, 20 Nov 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwYdWZhJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E199376BC3;
	Thu, 20 Nov 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655990; cv=none; b=gcpnjLrpqnn1232FogVUwBmYPWbTq4K5QvXMN16N7oTMG/7KZl/jIRkHuRmF9pqJz8r0xiaZUScTyWrpcIK5hzMUimUJe5qYybjH3j16jwVRWCZE3bkI/galv6+tV+L2d94HJiIjEpljDVWQ4tEEdAtO0h3lf1TfIdTFPl9w0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655990; c=relaxed/simple;
	bh=9bWXO/rkH5hXXpMBCIUifaVfnaubGBQH6NPhUvWS5Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLaJ3CIv/Zkx6G78GHB4yHlPrRxc/TvxivHYF1RnRVGAzGHJCkd1+ZJcdzeK+YUHfPsE76BHtCnFRVXYvJSuT/aUNzvWy0mHNpiQzQ8YbIt8q5gVjXx+1I8yy5FAgQABPWMuBTZ+Szl4nl9NUjKkG/RKfBVlE2oek6H2IErUc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwYdWZhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C339AC4CEF1;
	Thu, 20 Nov 2025 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763655990;
	bh=9bWXO/rkH5hXXpMBCIUifaVfnaubGBQH6NPhUvWS5Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwYdWZhJDaU1ii5P7JCnre7uCG1ODITkC1bOXYS1NAm2hgT8ql1m8TRvudhqMZDnm
	 gUyJ8m6N4a/xBuYSUmyYsdbkW9m6cMO35OwKLEUSFYZxiq66gUT96VYCbC6+1Q9ZO7
	 bOqFDe2JWtcHiAtpj8fwsoNpQymYgi6qHYHUsll0BpMxkUpVIUjpxWR7GVRyDx8or2
	 dEVymLuDjD+gnvqI+MiUb6Mnm1YqNArbVCUb6nWf90fDBCaQJvwh9XPm3QOCKTC/tL
	 qSUfRI0Ek58WJt7bZi8COoFoPQ30v01bKLWOu8jb8M40QpMaS3xjaLj3kzAKuB/a3p
	 t74jQx3T7riNA==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>
Subject: [RFC net-next v1 1/7] riscv: dts: microchip: add tsu clock to macb on mpfs
Date: Thu, 20 Nov 2025 16:26:03 +0000
Message-ID: <20251120-ahead-filth-d4d9c560d213@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
References: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3446; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=G/EjKmDyaKdtOf0TBw6CiN96scA4kHOYzQWM+SxTmwY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnyjlLGp6IdPmo3nMrNv7VewcYvMuKQ74F+oymWgRdWz PE/Wri7o5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABOZ1MLwP2VZg2P99MzedW+/ TSjexfNHo/T7Dp4qWTbBJJl6o0WLJjIyLGhm/GFovJiJlVtzDeepK/Pcy+cX/XpdKfGp6DufRFk VMwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

In increment mode, the tsu clock for the macb is provided separately to
the pck, usually the same clock as the reference to the rtc provided by
an off-chip oscillator. pclk is 150 MHz typically, and the reference is
either 100 MHz or 125 MHz, so having the tsu clock is required for
correct rate selection.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile.orig | 26 +++++++++++++++++++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi     |  8 +++----
 2 files changed, 30 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/Makefile.orig

diff --git a/arch/riscv/boot/dts/microchip/Makefile.orig b/arch/riscv/boot/dts/microchip/Makefile.orig
new file mode 100644
index 000000000000..e94f4096fd40
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/Makefile.orig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+<<<<<<< HEAD
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-disco-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit-prod.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
+||||||| constructed fake ancestor
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
+=======
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-beaglev-fire.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-m100pfsevp.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-polarberry.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-sev-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-tysom-m.dtb
+>>>>>>> riscv: dts: microchip: remove POLARFIRE mention in Makefile
+dtb-$(CONFIG_ARCH_MICROCHIP) += pic64gx-curiosity-kit.dtb
diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 9883ca3554c5..68e130550130 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -445,8 +445,8 @@ mac0: ethernet@20110000 {
 			interrupt-parent = <&plic>;
 			interrupts = <64>, <65>, <66>, <67>, <68>, <69>;
 			local-mac-address = [00 00 00 00 00 00];
-			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
-			clock-names = "pclk", "hclk";
+			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>, <&refclk>;
+			clock-names = "pclk", "hclk", "tsu_clk";
 			resets = <&clkcfg CLK_MAC0>;
 			status = "disabled";
 		};
@@ -459,8 +459,8 @@ mac1: ethernet@20112000 {
 			interrupt-parent = <&plic>;
 			interrupts = <70>, <71>, <72>, <73>, <74>, <75>;
 			local-mac-address = [00 00 00 00 00 00];
-			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
-			clock-names = "pclk", "hclk";
+			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>, <&refclk>;
+			clock-names = "pclk", "hclk", "tsu_clk";
 			resets = <&clkcfg CLK_MAC1>;
 			status = "disabled";
 		};
-- 
2.51.0


