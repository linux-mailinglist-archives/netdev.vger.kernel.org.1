Return-Path: <netdev+bounces-102814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09394904E87
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 10:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E8A2849ED
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422C18E02;
	Wed, 12 Jun 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KYdqvY1m"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4716D4C6;
	Wed, 12 Jun 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182463; cv=none; b=FuNFJARPrVqnfuRyF+btbLWVfLEdz50ydih4NH7Pk4l1cizBBDQrLzmKAQvM08vhrv79adMZ85L6mawqS42dEipsjsG/zyd3Z3UhykLCBQsiZoV90EnuTCC2LWJMSao6dkHdHFJDq19sAtdSSxpSwJGu6N6v4ve48bX+ViPDuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182463; c=relaxed/simple;
	bh=hP63E4TASV1+Uv/0PkxYrK3fzyfWbtsZWpz+GbZTLVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b1jQbLd78lObgFEG9OlRQQHDgTFPOLvY0R6ZyAm+bwWwZjjOzGIFzYBSeGAOk/6Ul2DBAQhspwwE9d4YkrpD000Y/8CLnpT1COET/jCayzpexMBRN+2v699VjKT9krBnHKUxisYnLQe/B9KqVhzskBcnTOFk7ztxbmBqq2YENqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KYdqvY1m; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C8s6Rl002895;
	Wed, 12 Jun 2024 03:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718182446;
	bh=vJNYdR2j//KbQKq4HcwL6NVVly03pg9r2h7GvCgB6fI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KYdqvY1mM7hnuY+7UDDzw4wf2bUqbSZJhMYOPw8vbeBrTN5vasubggkcNp/WbPfzt
	 pqIB5ep8xa0v06ucSSMCRyqM9x55W1SqADpea1Z2o3lwycWmyhRKQDrC+kle9dUXnY
	 yxVGh8reuQKJdiKsbHYbm7+7TtYzaipzse9BDaTQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C8s6RL068119
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 03:54:06 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 03:54:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 03:54:05 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C8rxD3020355;
	Wed, 12 Jun 2024 03:54:00 -0500
Message-ID: <b82f7f1f-1180-406f-87a7-da46b3778bf7@ti.com>
Date: Wed, 12 Jun 2024 14:23:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/4] arm64: dts: ti: iot2050: Add IEP
 interrupts for SR1.0 devices
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240607-iep-v3-0-4824224105bc@siemens.com>
 <20240607-iep-v3-4-4824224105bc@siemens.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240607-iep-v3-4-4824224105bc@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 07/06/24 18:32, Diogo Ivo wrote:
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

I dont see these documented in the binding:
Documentation/devicetree/bindings/net/ti,icss-iep.yaml

> +};
> +
> +&icssg0_iep1 {
> +	interrupt-parent = <&icssg0_intc>;
> +	interrupts = <56 8 8>;
> +	interrupt-names = "iep_cap_cmp";
> +};
> 

-- 
Regards
Vignesh

