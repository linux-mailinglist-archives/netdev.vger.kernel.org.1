Return-Path: <netdev+bounces-123762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA19666FB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383231F23731
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778418E34F;
	Fri, 30 Aug 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OtbZu1T3"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB514B949;
	Fri, 30 Aug 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035517; cv=none; b=iQ1kDynyix1EPs7kNk6j63fKlQISkDruHtSw2wc0eWZRfpft4FQqYpVEKpNfNB95fPf+KMtwV7Y5yWHALL68f8vf15ycTDeLF49NYVBhN3WpiVraliYIGIWYMDeTqCJoeY2KviS8adl/uDUaG8prfgWNxVri9qmaE6m7ORzEtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035517; c=relaxed/simple;
	bh=3BJIlDR+E6wpbgaIMfqeLxo7CRcaljbWFDg6cgsfwhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=myzbVTdHlcUJ5jrp+Mqhi8Uz2aRFrpQOFtXI+FZDOvY5VTNsw+VSwfobxtdYRFcF0P1Aclb/VfeJcYLPVbtpruzOeokB35t2gQStPPUcgpsz8YieZuWokiYe2c0CgwAFYOpA/j8BaawK7CFCdIJToXK3Wo92ggbsOFurx7Ron4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OtbZu1T3; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UC9Gn2029818;
	Fri, 30 Aug 2024 18:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	c55TnbAQcwEgANv3HCyH02RkCKFOHECJ/MLSerth/Vc=; b=OtbZu1T3bv6bIYrM
	YH0HaKycTAdjRZ+QfOArDjgnyCuET++v1a/df1HPttksgFl5gMUJzEBvv1B19HIc
	R8MFNjPpQlLABnBPCxVlQrm15sTIVyN6xgfqnzRCzvtVurxyXFXbNO9ZUiqhF7dG
	EQIKa13ThNP7MoqCkEtC1Ufn6+1XJp+3VP5KbfmAo4SOo9eJrfNBJ18OQdZw3Zlz
	BJ/ISbOFvy8WjUdoGs6oBfLeXU1b6bM81ZOOJqQKDQW74qi+NXdEimRHtJZXuLRb
	JyIgC4b5gI96N/8kkKxw/8UxAGpBz01mqZX+lG27s/ov019+0ar2gnzIfIuDmzeS
	J3e0lw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41b14tbrbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 18:31:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3CCC34002D;
	Fri, 30 Aug 2024 18:31:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8188F27F641;
	Fri, 30 Aug 2024 18:30:38 +0200 (CEST)
Received: from [10.252.12.18] (10.252.12.18) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 30 Aug
 2024 18:30:37 +0200
Message-ID: <44ad0f01-4701-45e9-a3cb-e89222f8c60e@foss.st.com>
Date: Fri, 30 Aug 2024 18:30:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: stm32: Add compatible strings
 for Protonic boards
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>
References: <20240809091615.3535447-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240809091615.3535447-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01

Hi

On 8/9/24 11:16, Oleksij Rempel wrote:
> Add compatible strings for Protonic MECIO1r0 and MECT1S boards to the
> STM32MP151-based boards section and Protonic MECIO1r1 board to the
> STM32MP153-based boards section.
> 
> MECIO1 is an I/O and motor control board used in blood sample analysis
> machines. MECT1S is a 1000Base-T1 switch for internal machine networks
> of blood sample analysis machines.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index 58099949e8f3a..703d4b574398d 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -54,6 +54,8 @@ properties:
>         - description: ST STM32MP151 based Boards
>           items:
>             - enum:
> +              - prt,mecio1r0 # Protonic MECIO1r0
> +              - prt,mect1s   # Protonic MECT1S
>                 - prt,prtt1a   # Protonic PRTT1A
>                 - prt,prtt1c   # Protonic PRTT1C
>                 - prt,prtt1s   # Protonic PRTT1S
> @@ -71,6 +73,12 @@ properties:
>             - const: dh,stm32mp151a-dhcor-som
>             - const: st,stm32mp151
>   
> +      - description: ST STM32MP153 based Boards
> +        items:
> +          - enum:
> +              - prt,mecio1r1   # Protonic MECIO1r1
> +          - const: st,stm32mp153
> +
>         - description: DH STM32MP153 DHCOM SoM based Boards
>           items:
>             - const: dh,stm32mp153c-dhcom-drc02

Applied on stm32-next.

Thanks
Alex

