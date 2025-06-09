Return-Path: <netdev+bounces-195651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC42AD19D5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 10:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD48166514
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137D22B5A5;
	Mon,  9 Jun 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GOoEi8dn"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6D2116F5
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749457979; cv=none; b=g+JnliJEwd5Q5MbJsKGqYZUEAJyKqm2fr1CV4nXm7ttyTsYP3jbxSM0gExU5Db9TNyUKIpKt1pSjBN+07cAsqn1a5nPtw+p4piZMvGYtIW9V6l63bfin0gB2F6/fkDF/JjpcrXF7XWZinRtSeYG6+zFnMkIAk6eamQQgrnK3bhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749457979; c=relaxed/simple;
	bh=YvbeRS0CNwTQZDVWn3o5Ny73fqKXWOdsBfUGNRzl0Jw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=mYSdmQdnBFFFsHWVavXi1oAnSCQnhrRL27KgZSv/+dGfZehNfZ3BgJLVrxwWTfkS0Qt5pOs8RVLiNTtbvyfO97OUsAgaYwkl8YIWQr3CnV6KOY+N6LH7AbeWeiikM6bbmw6UQR+v3d8HG1ITr/6AQYyXuOO0tMNylSoxAEa2180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GOoEi8dn; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250609083255epoutp044dadc014cb9ba096baad1cbfa51c38b0~HUsJ1FMvE3246332463epoutp04N
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 08:32:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250609083255epoutp044dadc014cb9ba096baad1cbfa51c38b0~HUsJ1FMvE3246332463epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749457975;
	bh=raYhcpxvaUZ+U3DFFXokA1FxIAXMkZbDHQQsHnlKWKI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=GOoEi8dngFVNeJONQ9mfq/T09fwR7WYEGOMbyQK+/rtoK0dGisjvx6pEr8hFVh6At
	 ZfK9QzcjKwu+ZraOf0+tatFdzdLep5bvLjWdCBJlcycDJocNu+xUafHoNDqc2Y42Vu
	 xv6kbPMU863HBsH29OktGcSRHPjWjLGG+hVYZ8j0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250609083254epcas5p4582a8ece71f15b0d09c96fde109aabc7~HUsJBovem0515605156epcas5p49;
	Mon,  9 Jun 2025 08:32:54 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.183]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bG4tX4gGSz6B9m9; Mon,  9 Jun
	2025 08:32:52 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250609083251epcas5p1380bd5ffe9b5b91f776a1c7f48b317df~HUsGa3UxF3208532085epcas5p1d;
	Mon,  9 Jun 2025 08:32:51 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250609083249epsmtip1185a8a7cdb024a1a522bad1061beae6f~HUsEApVOx2620026200epsmtip1X;
	Mon,  9 Jun 2025 08:32:49 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Raghav Sharma'" <raghav.s@samsung.com>, <krzk@kernel.org>,
	<s.nawrocki@samsung.com>, <cw00.choi@samsung.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<sunyeal.hong@samsung.com>, <shin.son@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<chandan.vn@samsung.com>, <karthik.sun@samsung.com>,
	<dev.tailor@samsung.com>
In-Reply-To: <20250529112640.1646740-5-raghav.s@samsung.com>
Subject: RE: [PATCH v3 4/4] arm64: dts: exynosautov920: add CMU_HSI2 clock
 DT nodes
Date: Mon, 9 Jun 2025 14:02:47 +0530
Message-ID: <047901dbd919$16a39270$43eab750$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRyuXPQglR2pg1tLiplohNF2WAzQHWb0Q+AhHSDDezb1SDcA==
Content-Language: en-us
X-CMS-MailID: 20250609083251epcas5p1380bd5ffe9b5b91f776a1c7f48b317df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529111718epcas5p4572d6aa7ae959b585b658d5a94f2b4ef
References: <20250529112640.1646740-1-raghav.s@samsung.com>
	<CGME20250529111718epcas5p4572d6aa7ae959b585b658d5a94f2b4ef@epcas5p4.samsung.com>
	<20250529112640.1646740-5-raghav.s@samsung.com>

Hi Raghav

> -----Original Message-----
> From: Raghav Sharma <raghav.s@samsung.com>
> Sent: Thursday, May 29, 2025 4:57 PM
> To: krzk@kernel.org; s.nawrocki@samsung.com; cw00.choi@samsung.com;
> alim.akhtar@samsung.com; mturquette@baylibre.com; sboyd@kernel.org;
> robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> sunyeal.hong@samsung.com; shin.son@samsung.com
> Cc: linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org;
> chandan.vn@samsung.com; karthik.sun@samsung.com;
> dev.tailor@samsung.com; Raghav Sharma <raghav.s@samsung.com>
> Subject: [PATCH v3 4/4] arm64: dts: exynosautov920: add CMU_HSI2 clock DT
> nodes
> 
> Add required dt node for CMU_HSI2 block, which provides clocks to ufs and
> ethernet IPs
> 
> Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/exynos/exynosautov920.dtsi | 17
> +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> index 2cb8041c8a9f..7890373f5da0 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> @@ -1048,6 +1048,23 @@ pinctrl_hsi1: pinctrl@16450000 {
>  			interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> 
> +		cmu_hsi2: clock-controller@16b00000 {
> +			compatible = "samsung,exynosautov920-cmu-hsi2";
> +			reg = <0x16b00000 0x8000>;
> +			#clock-cells = <1>;
> +
> +			clocks = <&xtcxo>,
> +				 <&cmu_top DOUT_CLKCMU_HSI2_NOC>,
> +				 <&cmu_top
> DOUT_CLKCMU_HSI2_NOC_UFS>,
> +				 <&cmu_top
> DOUT_CLKCMU_HSI2_UFS_EMBD>,
> +				 <&cmu_top
> DOUT_CLKCMU_HSI2_ETHERNET>;
> +			clock-names = "oscclk",
> +				      "noc",
> +				      "ufs",
> +				      "embd",
> +				      "ethernet";
> +		};
> +
>  		pinctrl_hsi2: pinctrl@16c10000 {
>  			compatible = "samsung,exynosautov920-pinctrl";
>  			reg = <0x16c10000 0x10000>;
> --
> 2.34.1



