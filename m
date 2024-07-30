Return-Path: <netdev+bounces-114132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C596E941196
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986A3B2A03E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13319DFAC;
	Tue, 30 Jul 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="grlfVSz5"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14119DF8E;
	Tue, 30 Jul 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341327; cv=none; b=RM3RQc/CMhZoy97DZCXIaPQyEURQ29qqh1FmysTbJrAelOpTzdFTL7KYPsrA6ZcelXQE/WJc2S7P8kpSNUCt3FVpyMCg+9PKLriw3Z/azlB4k20X4XapsRekezINHXD4QmU903cCPlPUKqjd6/7OXVQ8FvL1KgU/YIgD3/PMwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341327; c=relaxed/simple;
	bh=G59Nwd7Jc6ZEt5wUtpcbCBpDf2emnwJYpQzoa37E3FM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsX9yL/mk3+rwPFy0lu9VkL92Ya91i84+ciOh7LyZ8gpkeZGMVS5wYhNnxTco8SP8rhQMqhf3RhRpj1QGrfXhlwytTme9qrJqpRAMLVkoj0+KwXHF8IUgHqI3/H26wbpnN1g+f8kyzIRbm5wUe+pu3NsJvGuyk9zlx4XIUeVJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=grlfVSz5; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UC8GmE067205;
	Tue, 30 Jul 2024 07:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722341296;
	bh=/lXOg0L8dVXlkFZBdB+ojALd2ZihbFA/rRCnQXeEcRc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=grlfVSz5AYT/ms0te+8Iytf5z+av8tHkfIdv4srmU3+Dug5Xuu4cuS0KDjBSLDsUD
	 Hy4pCk8+03Q2I4s4FKHCQQRF39ZEgFEzNzPKd04vXec2J0P7Qav+Woi1S0XNBdUW7+
	 G9puQgW5ihsefTCDnnKTLC5f0iLrealD3wEKHcy0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UC8Gea028049
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 07:08:16 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 07:08:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 07:08:16 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UC8GHe012926;
	Tue, 30 Jul 2024 07:08:16 -0500
Date: Tue, 30 Jul 2024 07:08:16 -0500
From: Nishanth Menon <nm@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
CC: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger
 Quadros <rogerq@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>
Subject: Re: [DO NOT MERGE][PATCH v4 6/6] arm64: dts: ti: k3-am64: Add
 ti,pa-stats property
Message-ID: <20240730120816.unujbfewvcfd3xov@geiger>
References: <20240729113226.2905928-1-danishanwar@ti.com>
 <20240729113226.2905928-7-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240729113226.2905928-7-danishanwar@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 17:02-20240729, MD Danish Anwar wrote:
> Add ti,pa-stats phandles to k3-am64x-evm.dts. This is a phandle to
> PA_STATS syscon regmap and will be used to dump IET related statistics
> for ICSSG Driver
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 6bb1ad2e56ec..dcb28d3e7379 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -253,6 +253,7 @@ icssg1_eth: icssg1-eth {
>  		ti,mii-g-rt = <&icssg1_mii_g_rt>;
>  		ti,mii-rt = <&icssg1_mii_rt>;
>  		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
> +		ti,pa-stats = <&icssg1_pa_stats>;

Follow:  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
for ordering properties.
>  		interrupt-parent = <&icssg1_intc>;
>  		interrupts = <24 0 2>, <25 1 3>;
>  		interrupt-names = "tx_ts0", "tx_ts1";
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

