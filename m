Return-Path: <netdev+bounces-125375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08096CF2D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1581F25246
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852F18E05A;
	Thu,  5 Sep 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KWB7lLrl"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975F18D629;
	Thu,  5 Sep 2024 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517494; cv=none; b=NKipS10q12wsH4H/X8bjWmMH8vPwEy1dT4umeq10xhWR9p1ktqZLVKTg2JN1s1Uv24SJBiRJ1j2OtATgp67O7fprSV37/yksQjHaKNDKtZYUZDO2t9fuWJWVBPRY6PFaDNonvnM7C7wl5iooADYHNTZLdDsu88efI5ehhTbjpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517494; c=relaxed/simple;
	bh=UesfbDNKmg44Mag5pVOM/JMASQ8rNSFLidWBuXvGgPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdivGbybYpE4pd+otC6Xw7gARunLrv6hkUqh05ac0DWfHdE4yWDs2vQYjEmKL0v7yoOxse/jEMI8N/F7i2vQLCXrgV2Z/nbmybGKCsLd/WJibtWP55twNYwdmAjC2nYeEtpJ9rW4UJv1PPgYQpVv50LFY70eESDUgosKMWr4pFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KWB7lLrl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4856OdQ0126456;
	Thu, 5 Sep 2024 01:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725517479;
	bh=QHY7aIQgu0/LpQAFB21rB6xj4hPz2sP1c8vqFpug2ks=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KWB7lLrldCMcrA4sDY8xo25+lfJ1OgStwEVc0EleuOBM8OqBM0NSTdyvIwX4lsyw5
	 AWZc1+ApAKUNYZaHMLgJRmnIifcsbFTlyCawmbqL/NcJ35ypKxWWqMVvsd0ypVf16l
	 2ZcCi/ZCqi5ni4z5USjIuDowtjwujIYNQ7SmC0ak=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4856OdEd026537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Sep 2024 01:24:39 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 01:24:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 01:24:39 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4856OcOX069679;
	Thu, 5 Sep 2024 01:24:39 -0500
Date: Thu, 5 Sep 2024 11:54:38 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ayush Singh <ayush@beagleboard.org>
CC: <lorforlinux@beagleboard.org>, <jkridner@beagleboard.org>,
        <robertcnelson@beagleboard.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder
	<elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <greybus-dev@lists.linaro.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-am625-beagleplay: Add
 bootloader-backdoor-gpios to cc1352p7
Message-ID: <20240905062438.ae2rajmcoiukjefm@lcpd911>
References: <20240903-beagleplay_fw_upgrade-v4-0-526fc62204a7@beagleboard.org>
 <20240903-beagleplay_fw_upgrade-v4-2-526fc62204a7@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903-beagleplay_fw_upgrade-v4-2-526fc62204a7@beagleboard.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Sep 03, 2024 at 15:02:19 +0530, Ayush Singh wrote:
> Add bootloader-backdoor-gpios which is required for enabling bootloader
> backdoor for flashing firmware to cc1352p7.
> 
> Also fix the incorrect reset-gpio.

A Fixes tag please?

> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index 70de288d728e..a1cd47d7f5e3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -888,7 +888,8 @@ &main_uart6 {
>  
>  	mcu {
>  		compatible = "ti,cc1352p7";
> -		reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_LOW>;
> +		bootloader-backdoor-gpios = <&main_gpio0 13 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&main_gpio0 14 GPIO_ACTIVE_HIGH>;
>  		vdds-supply = <&vdd_3v3>;

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

