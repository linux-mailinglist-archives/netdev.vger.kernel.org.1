Return-Path: <netdev+bounces-125372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F246B96CF1D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88484B21979
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E931891BB;
	Thu,  5 Sep 2024 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WehjcMOe"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F762BB15;
	Thu,  5 Sep 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517405; cv=none; b=R0aq6oNguD/sPsmkU5KU3SJ23I0YLy2CypWK+QoTB23w6apDY2j3PIOU8xJFIIv+PckYlAd35xcFU4VI5APunDGc4Q9RfFtsfIme7lDP5JZBqQUieDaKT9VevCUR3WEdUj270q3VuCQWsbHBbs4hS3Ny3tdl6DF6TkNy9i9xvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517405; c=relaxed/simple;
	bh=qGvK0wCPGic+2o44R/ACnW5fY+LDJgBf2A10C3O3pH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElrKtx0sccmPUaUVRpghKOKO3PXlLh5l854nnl1mSvo5ier7QaiYkapTSVb0uYu8sU18IyI64a6FQh99nhpnW0mPJLT197NYHKtjjO0G4Bz5TnGXrB/7fGbxJx50V6d9OLVAxnpjyYRGzLxId+FW4mH0IyPgwQZC9QsiRvCvv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WehjcMOe; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4856N8Pp022957;
	Thu, 5 Sep 2024 01:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725517388;
	bh=UgRkeRKo8aNhdHkE0OeVuJXjkmkbfZJTnFKZwGbwR5s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WehjcMOesFtvniK+MasRNdZKuTAopEcpXylop2YAgZe7K6yD2pKCoz7cPIrhKFtYY
	 bGk7/DhwBE+SBUkQ9IstbmEvLGwpyIw1v9jqURnUujd/GZmWg/LVe8DH9gHGTcIkOy
	 hS/HhYYm7pNcvdB8RvP6PRUTWCUzpXvg72B+Ccco=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4856N8CS076053;
	Thu, 5 Sep 2024 01:23:08 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 01:23:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 01:23:07 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4856N7MK068122;
	Thu, 5 Sep 2024 01:23:07 -0500
Date: Thu, 5 Sep 2024 11:53:06 +0530
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
        <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: net: ti,cc1352p7: Add
 bootloader-backdoor-gpios
Message-ID: <20240905062306.lm4jgr7yp2enldt3@lcpd911>
References: <20240903-beagleplay_fw_upgrade-v4-0-526fc62204a7@beagleboard.org>
 <20240903-beagleplay_fw_upgrade-v4-1-526fc62204a7@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903-beagleplay_fw_upgrade-v4-1-526fc62204a7@beagleboard.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Sep 03, 2024 at 15:02:18 +0530, Ayush Singh wrote:
> bootloader-backdoor-gpio (along with reset-gpio) is used to enable
> bootloader backdoor for flashing new firmware.
> 
> The pin and pin level to enable bootloader backdoor is configured using
> the following CCFG variables in cc1352p7:
> - SET_CCFG_BL_CONFIG_BL_PIN_NO
> - SET_CCFG_BL_CONFIG_BL_LEVEL
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  Documentation/devicetree/bindings/net/ti,cc1352p7.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> index 3dde10de4630..4f4253441547 100644
> --- a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> @@ -29,6 +29,12 @@ properties:
>    reset-gpios:
>      maxItems: 1
>  
> +  bootloader-backdoor-gpios:
> +    maxItems: 1
> +    description: |
> +      gpios to enable bootloader backdoor in cc1352p7 bootloader to allow
> +      flashing new firmware.
> +
>    vdds-supply: true
>  
>  required:
> @@ -46,6 +52,7 @@ examples:
>          clocks = <&sclk_hf 0>, <&sclk_lf 25>;
>          clock-names = "sclk_hf", "sclk_lf";
>          reset-gpios = <&pio 35 GPIO_ACTIVE_LOW>;
> +        bootloader-backdoor-gpios = <&pio 36 GPIO_ACTIVE_LOW>;

Did you mean &gpio here and even in reset part?
Looks good otherwise,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

