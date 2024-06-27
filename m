Return-Path: <netdev+bounces-107299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132D91A7BE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2D3B27131
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35152192B8B;
	Thu, 27 Jun 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cWVTLFjY"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B741922F4;
	Thu, 27 Jun 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494426; cv=none; b=s2cIGg/QAJ1Z1xSxV6fFkSh6mY5+rpwJTJz6bm7UzDUqE+phpM1x5cq7rJHt3lygDyVHLR4oW3h1ZASfIm0ouYLJTpBBTOdk4/pRO1Z2nigGxVt4N8Jsr7AP28mS/ll5ROJ4IKXnT2EO+B5shs9vpbtC+PEdTOa2zPf9ppKZPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494426; c=relaxed/simple;
	bh=ecpLC43kFB3CYyVlJl5+YEUB1QqT90ETR7ab91rVC+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n4hFsqsEkfYv/k8iWB++HWKTqfZ/kJye7mX0+eVU+9vNLGNindTmZy5T7A9GbIWd6insTm0dkPdCHV5wL4G3TI84S5Fq7qpVRuKSFLjVO5CHDmpFAKuogE1r0e23P/vWFIxGR1CKSLJSTY72KqWdPhe7Vt9Zm9hHed/x1CLSTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cWVTLFjY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RDK103112486;
	Thu, 27 Jun 2024 08:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719494401;
	bh=MweCfJaxnH2SO8CuzOOrmYpHxuetL+U+V3vgylpajt4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cWVTLFjYcrl0sHqLwoBFJWvirTY0ulDHlLDF6AfnPB1MCJ04oe8XQPS4PCTpTzrxT
	 aO+ykNxKvTI4CN/oFCijNA+UU1sIt/MDYRHf0FNxdZDFnXSz2W+5HAcIj0iZ5/s5sN
	 SLyJYHXHqnxpTCb0oYw69o+k4voefeCwXHJoAwGA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RDK1gj114996
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 08:20:01 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 08:20:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 08:20:01 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RDJsoX052505;
	Thu, 27 Jun 2024 08:19:54 -0500
Message-ID: <2e6a4d73-7438-4f00-8b6e-74aa327ae3c5@ti.com>
Date: Thu, 27 Jun 2024 18:49:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] arm64: dts: ti: iot2050: Add IEP
 interrupts for SR1.0 devices
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
 <20240617-iep-v4-5-fa20ff4141a3@siemens.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240617-iep-v4-5-fa20ff4141a3@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/17/2024 8:51 PM, Diogo Ivo wrote:
> Add the interrupts needed for PTP Hardware Clock support via IEP
> in SR1.0 devices.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> index ef7897763ef8..0a29ed172215 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> @@ -73,3 +73,15 @@ &icssg0_eth {
>  		    "rx0", "rx1",
>  		    "rxmgm0", "rxmgm1";
>  };
> +
> +&icssg0_iep0 {
> +	interrupt-parent = <&icssg0_intc>;
> +	interrupts = <7 7 7>;
> +	interrupt-names = "iep_cap_cmp";
> +};
> +
> +&icssg0_iep1 {
> +	interrupt-parent = <&icssg0_intc>;
> +	interrupts = <56 8 8>;
> +	interrupt-names = "iep_cap_cmp";
> +};
> 

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Md Danish Anwar

