Return-Path: <netdev+bounces-96065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD98C42D7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EB6281008
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B06715380F;
	Mon, 13 May 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="r5DR/mAP"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BB50279;
	Mon, 13 May 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609297; cv=none; b=Jf0VIoZJV25Dp3k5lovc54Invr/vhNBdvtPDMLmBO7H/eQlnUHFE4tdUuv3VlxNEk7rIAWyU5Ot2PRSbtfbxRbKkMtiYWPglBJm2rPqbBNZh+GYK2I7v6CA/8r0dmlLCF7hW1IVXL3m5wXN+8Cx7rso1M/NRy4CmG9shFyx1rts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609297; c=relaxed/simple;
	bh=K5E+U1mJykH/GF+NxFkP/wtwFeDQzEeRkoFvRLpM2WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZR3Qwp5COrk3fTb53taueoGZK8lqvbIgIcSzqN8sCdGh5UlYh4Fi5X/zzAA+95ltDwfW3CmgwGUePacOjIbmdOFfjx4OT8pT8sSfItgwLoCpQzLV6QHvinmMSsJsBkGSZxT649Ka8KmAbAb8T/ZBc+Wb1sgBQNj2V5DOzsGSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=r5DR/mAP; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DBs1dp004575;
	Mon, 13 May 2024 16:07:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=IAj0zC/NmxIhXGebLMPF7t3BBODE7eX8o0Rp4kLw+l4=; b=r5
	DR/mAPfO0af1cfHGG8N/uerGaz91NZ08BGOZcx5GX59tZxkfka/tPdOhKVFF2tU5
	gbIhF6+lMSzPa4UKYyeo85vR8ETb+qmw3PutIOR+nuy09ct5Zd9WiVohL1Pwkv6R
	NURIk6T71vmtvmy2OM2+FfPgHvyFno484apDzTRBdkUZe6rIM1jOxlh2fUKZKyHZ
	vNr7Ufzf5mT9EDA7ZHtW8l0TzHgB801y0buH6SHAfugbQ1q17QBeCN+HjHmQAtG3
	NYf/fRxxU/vcx/pBKDQO3wcYtRB83J19U+WOLHVUSyi4BD64r2VrxbJS1XA/CfL9
	lP08LaX2lY8lPuSCH+Tg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y2j80n46s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 16:07:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BCBAD4004A;
	Mon, 13 May 2024 16:07:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 93D9F220B7C;
	Mon, 13 May 2024 16:06:19 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 16:06:18 +0200
Message-ID: <a2a631a0-9a16-4068-aed2-6bdaa71e3953@foss.st.com>
Date: Mon, 13 May 2024 16:06:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] dt-bindings: net: add phy-supply property for
 stm32
To: Rob Herring <robh@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-3-christophe.roullier@foss.st.com>
 <20240426153010.GA1910161-robh@kernel.org>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <20240426153010.GA1910161-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_10,2024-05-10_02,2023-05-22_02

Hi

On 4/26/24 17:30, Rob Herring wrote:
> On Fri, Apr 26, 2024 at 02:56:58PM +0200, Christophe Roullier wrote:
>> Phandle to a regulator that provides power to the PHY. This
>> regulator will be managed during the PHY power on/off sequence.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> index b901a432dfa9..7c3aa181abcb 100644
>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> @@ -84,6 +84,9 @@ properties:
>>             - description: offset of the control register
>>             - description: field to set mask in register
>>   
>> +  phy-supply:
>> +    description: PHY regulator
> This is for which PHY? The serdes phy or ethernet phy? This only makes
> sense here if the phy is part of the MAC. Otherwise, it belongs in the
> phy node.
>
> Rob

You are right, normally it should be managed in Ethernet PHY (Realtek, 
Microchip etc...)

Lots of glue manage this like this. Does it forbidden now ? if yes need 
to update PHY driver to manage this property.


