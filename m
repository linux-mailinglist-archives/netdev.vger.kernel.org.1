Return-Path: <netdev+bounces-218668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACDB3DDD2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD6F3A3914
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D23043BD;
	Mon,  1 Sep 2025 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gr6i08uh"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B22FABF9;
	Mon,  1 Sep 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718211; cv=none; b=ZPqHkcrOXb9tfq16I9IVIjq/JnUTDrh/9RPqaWuULSSt5Z91fWLEU7W9vU/Fu0jJz13E0HnasPvpeq55ykLpf+zNClwbFG/osrMm8s7L37jgvU3J5m+wAdgcbnKM+/SczIjFRE2AmkhSeIiqlGLQ5dqBqMrxow5nCcbUPl1ygvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718211; c=relaxed/simple;
	bh=OftSgiL4UTkgXN7i1XR2xvfUsGm52/F6zYUJU4C9dlo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=i9rS6yzIXULrZ/q6znUmf6A8eCAmj203lBIekCl2bmTeF2N4xN/553ZPjsOWQSKDlIQGbioJoAiI+zOHqeXQubi0XFh2V//pS7LxyOgRcRqgYXFJ3JTq72eGQhMnEJGtwq7ZL3l6sdXjVpDCxwlFCTO62f9HE7H1rqz2KFhqZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gr6i08uh; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756717896;
	bh=39FAD1QerJTJ2wPDicB9GX9umyPWc2w9EF21fWNdZbI=;
	h=From:To:Cc:Subject:Date;
	b=gr6i08uh+u+JSOiWQFZ0kR2D3J9VIOk2B83/oOpNiit5i89bzV083vCTKluRmavm7
	 qp72TfcP/Ab/2IpiuaArr/tZPo9qysheurgB3doG0K6JI1gfU5Vyd9j5P/rAjFKpQO
	 j9LGIcO5/V6uAFApM8OTgwLuhAJH/YmaIjnx0dqM=
Received: from localhost.localdomain ([112.94.77.11])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 15734035; Mon, 01 Sep 2025 17:05:23 +0800
X-QQ-mid: xmsmtpt1756717523tsm2mneqs
Message-ID: <tencent_57056C4B1E98EF5C0517A5685B2E4D060508@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO63+vEsiWKluVtiIBpWewsVodXuXNWp0lHvtfnS4+Vm87kD/r3Bc
	 mjc6f8ekkcGEW4icjagtQHy81zLTTjkvjLddFHuPZndRa0A8LWmQoF/Kbjtda+R3ofzOmXRLgmAO
	 oqJ0EMYzUMBh1ctrX5RBzYs/hQ4cPfFkPXqWm9NqNagz1IRYnKvYa2k9J14nb8UEldzrdAnbLiU6
	 E5j3y4pGCwTZNnn+9MoB6CwpbTr8OS33PVB1s3+qRlbM9ABvRxwDjDY34LraRL7UueSLo3NpyV6x
	 uQCWUeO1qH1lvpxdVS305wEa+yxSiYwrZuNyBozNdZNyS1fGTDy7JJjembuK4tVOmaK9Op3LHfh3
	 jd0rfJ7au5NvskOH8h2vwz1sQZtYcKorr/U6E/fyFEkl+75YvFxQJUINKtAcJfByxgL0cY6Bpxgk
	 PM47gjuv3kQryFJ8N/f2B+Z6Byzv4OzGhHcZcY0GtcYG3P6y+Ri1fIptaQx6PUNaI2x2aI3TT4dA
	 //J/fRe0FWCrUJJf+6VejxIi56CuNKQouNwdUlz8H6s5xUCB69nvvZ9vATzlfU/QyA6ZMI9QY639
	 w5/cljq1pV3G5NKksm4ggDB0Gv6R9HTH2tgNeCuoJqEyUGsQqfC8MMRf57Vo0395ddmsQCC3g4v9
	 5pM5GdGxK49xJFO9QO8C3Zr/6HOPu0unvmyvYlcb3spk2oCT5DTwJ+HcMZSO666HcP7prRQzCnsX
	 NugM8H4NPlexqiQBOaprITLJ9JqZWR+3s5evsDMXUIPZGE5fV1wY5chaRn25NePhwjrlZiZuaBj2
	 fPYMBQx/GnrqwBIHieVumdRTbZ5+ScCQV5agE4TcM1eotn/s6+X1mMtxcGY7Gl4BQw73IDxhCGo2
	 sK7ZoFMAM8eClZrrMKqt3UddMshgRozo9C+PRzsjG7jUATC+9lgOxuIRVanrQzLWaeirH3Lu9uYL
	 TZaV4KuW6eacif1Y/DWSzT/HrxLCg+SPS8SL4hKnWSsTphdGEvnMXaqDdetRSPVZ5ckcK+/ZC01U
	 cKVLfteP3R2AAvB55eJCUH9nMt5FOtMvjfm7Ebyw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Conley Lee <conleylee@foxmail.com>
To: andrew@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	wens@csie.org,
	mripard@kernel.org
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Conley Lee <conleylee@foxmail.com>
Subject: [PATCH] arm: dts: add nand device in sun7i-a20-haoyu-marsboard.dts
Date: Mon,  1 Sep 2025 17:05:21 +0800
X-OQ-MSGID: <20250901090521.533710-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Haoyu MarsBoard-A20 comes with an 8G Hynix NAND flash,
and this commit adds this NAND device in the device tree.

Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 .../allwinner/sun7i-a20-haoyu-marsboard.dts   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-haoyu-marsboard.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-haoyu-marsboard.dts
index 097e479c2..62d775c4f 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-haoyu-marsboard.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-haoyu-marsboard.dts
@@ -118,6 +118,58 @@ gmac_txerr: gmac-txerr-pin {
 		pins = "PA17";
 		function = "gmac";
 	};
+
+	nand_pins_a: nand_base0@0 {
+		pins = "PC0", "PC1", "PC2",
+		"PC5", "PC8", "PC9", "PC10",
+		"PC11", "PC12", "PC13", "PC14",
+		"PC15", "PC16";
+		function = "nand0";
+		drive-strength = <10>;
+	};
+
+	nand_cs0_pins_a: nand_cs@0 {
+		pins = "PC4";
+		function = "nand0";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+
+	nand_cs1_pins_a: nand_cs@1 {
+		pins = "PC3";
+		function = "nand0";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+
+	nand_cs2_pins_a: nand_cs@2 {
+		pins = "PC17";
+		function = "nand0";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+
+	nand_cs3_pins_a: nand_cs@3 {
+		pins = "PC18";
+		function = "nand0";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+
+	nand_rb0_pins_a: nand_rb@0 {
+		pins = "PC6";
+		function = "nand0";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+
+	nand_rb1_pins_a: nand_rb@1 {
+		pins = "PC7";
+		function = "nand0";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+
 };
 
 &reg_ahci_5v {
@@ -180,3 +232,18 @@ &usbphy {
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
 };
+
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins_a>, <&nand_cs0_pins_a>, <&nand_rb0_pins_a>, <&nand_cs1_pins_a>, <&nand_rb1_pins_a>;
+	status = "okay";
+
+	nand@0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0>;
+		allwinner,rb = <0>;
+		nand-ecc-mode = "hw";
+		nand-on-flash-bbt;
+	};
+};
-- 
2.25.1


