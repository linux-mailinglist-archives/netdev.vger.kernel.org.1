Return-Path: <netdev+bounces-194226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13DAC7F83
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4265D50301B
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5C9215766;
	Thu, 29 May 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pQRhGPFo"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDAD213E77
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527350; cv=none; b=V+Pnjy/mUM6wscL8H0zHH3JycJJ2uX+8Qn0GEUwb7rkmNw0WG1fmCPX1aWSSZKvh64Rf4j5zG7GHtsk4EyvtaA7A5uOMjq3jUrON8GqinHVgylq5CqfC/lohOV4pX6NpGrokzr3JsfKPQ854u0NjxyYRY3WBLhuFvNqnUPuvKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527350; c=relaxed/simple;
	bh=yBKN8id0e8i0mID56sBX04JKOMEpNFcKtfCE5gt4YyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ZYNqTB4VpFfIA49EPKBgn1QHvQZ0BmHwEL4vvIJGTiJc8KNkTorYkJLV+rzjGU8JNyXVpBam7QxxK+0TYnNTce45nKtnxdrwFhFf27zuS4DWP5mFyXhMe6WmosRTH+LwntlA70jHZTKswKSM9l5rSYTVL8U/20ZjJGVSF3MzXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pQRhGPFo; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250529140227epoutp0249097a8fdf3333040467ca1d989aede9~EBFupEbKe1954119541epoutp02m
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250529140227epoutp0249097a8fdf3333040467ca1d989aede9~EBFupEbKe1954119541epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748527347;
	bh=gCzfbZekv4htNUijIC+SbkqBGyLEFOMaleFjXJEgatk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQRhGPFoL+9I1NyzEAuNZMzXCCh+59SIW5X+Soj1sPdR/Kb+oC4OO89NDIUAXx9bt
	 ojZh0s28UbNv4XP9xM/04xKAnL/ldctCENwxlKRiDy4xIWis8EmNPd5yA4pd9TafW8
	 I91Y5viLqoNBVZxeYBKmIKzR9XDaX8GgZuZM31Pk=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250529140226epcas5p25bdafdf609607873ca08557b6ad3a85f~EBFt-QyMW1140911409epcas5p2c;
	Thu, 29 May 2025 14:02:26 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.175]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b7Sjr3GW2z2SSKX; Thu, 29 May
	2025 14:02:24 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250529111718epcas5p4572d6aa7ae959b585b658d5a94f2b4ef~D_1iJ4i-t0282202822epcas5p4D;
	Thu, 29 May 2025 11:17:18 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250529111718epsmtrp1257cc470d2823aa85b322766527d6595~D_1iJE18d1149011490epsmtrp1p;
	Thu, 29 May 2025 11:17:18 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-35-6838423d6874
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.D0.19478.D3248386; Thu, 29 May 2025 20:17:17 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250529111715epsmtip16ae03b6cb035bd17825b1eb64d85c26c~D_1fb-zLZ2103321033epsmtip1G;
	Thu, 29 May 2025 11:17:14 +0000 (GMT)
From: Raghav Sharma <raghav.s@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	sunyeal.hong@samsung.com, shin.son@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chandan.vn@samsung.com, karthik.sun@samsung.com, dev.tailor@samsung.com,
	Raghav Sharma <raghav.s@samsung.com>
Subject: [PATCH v3 4/4] arm64: dts: exynosautov920: add CMU_HSI2 clock DT
 nodes
Date: Thu, 29 May 2025 16:56:40 +0530
Message-Id: <20250529112640.1646740-5-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529112640.1646740-1-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTtfWySLDYOMxK4sH87axWUz4EmGx
	Zu85JovrX56zWtzbsYzdYv6Rc6wWjTPeMFmcP7+B3WLT42usFh977rFaXN41h81ixvl9TBYX
	T7laHFsgZvF95R1GiyNnXjBb/N+zg93i8Jt2Vot/1zayWEw+vpbVomnZeiYHUY/3N1rZPXbO
	usvusWlVJ5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJWxf3InW8EDzoqrvVvYGxjf
	sncxcnJICJhIvGltY+5i5OIQEtjOKHFi12dmiISExL7/vxkhbGGJlf+es0MUvWWUaO7fD5Zg
	E9CSuLL9HRtIQkSgi0ni3L9XLCAOs8BOJom2x9vAdggL+Ess/vIKbCyLgKrEre2P2EBsXgFr
	iS+XN7JBrJCX2H/wLFgNp4CNxN2bz1lAbCGgmo/bzzBD1AtKnJz5BCzODFTfvHU28wRGgVlI
	UrOQpBYwMq1iFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECI4wraAdjMvW/9U7xMjEwXiIUYKD
	WUmEt8neLEOINyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qB
	idvibYjTjh3t77kylfP2Bt03DHy/lcnuflfZzI6fJV6Pftw7LKM2qzA+a8Nke72v5z/9nTd1
	u+DuQzdO7jd5YNB9WlAxd/7iz1OcfhdHMh2w8A3am/Vzts8u4/bc1WnPTDIOWcn+ivy9VVVp
	s/xtFRWV2X/v+uelL38i+UfFLUrhRl5Mw926w1V712uGzn+Wt3lZ9C3PD1M6TsfdXlF2+s7H
	7KvX3m2QUZZvTp6cqFQ89X/RJls//8SLHim80dsuVLP8O6GhFtuknO45qXrpPsO5cpdUr/V6
	7+3QnM7y6hzDGaW7zb+aLcNeeqQdSEiVWv8vqDrMPkj6icty1ZNfeVf01Ur+WPmn1MTU7IRH
	gRJLcUaioRZzUXEiAAc6exQfAwAA
X-CMS-MailID: 20250529111718epcas5p4572d6aa7ae959b585b658d5a94f2b4ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529111718epcas5p4572d6aa7ae959b585b658d5a94f2b4ef
References: <20250529112640.1646740-1-raghav.s@samsung.com>
	<CGME20250529111718epcas5p4572d6aa7ae959b585b658d5a94f2b4ef@epcas5p4.samsung.com>

Add required dt node for CMU_HSI2 block, which
provides clocks to ufs and ethernet IPs

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynosautov920.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
index 2cb8041c8a9f..7890373f5da0 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
@@ -1048,6 +1048,23 @@ pinctrl_hsi1: pinctrl@16450000 {
 			interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		cmu_hsi2: clock-controller@16b00000 {
+			compatible = "samsung,exynosautov920-cmu-hsi2";
+			reg = <0x16b00000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&xtcxo>,
+				 <&cmu_top DOUT_CLKCMU_HSI2_NOC>,
+				 <&cmu_top DOUT_CLKCMU_HSI2_NOC_UFS>,
+				 <&cmu_top DOUT_CLKCMU_HSI2_UFS_EMBD>,
+				 <&cmu_top DOUT_CLKCMU_HSI2_ETHERNET>;
+			clock-names = "oscclk",
+				      "noc",
+				      "ufs",
+				      "embd",
+				      "ethernet";
+		};
+
 		pinctrl_hsi2: pinctrl@16c10000 {
 			compatible = "samsung,exynosautov920-pinctrl";
 			reg = <0x16c10000 0x10000>;
-- 
2.34.1


