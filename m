Return-Path: <netdev+bounces-100503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245158FAED0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5171F21CEC
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B3143C42;
	Tue,  4 Jun 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lgN16F3X"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E913B29F;
	Tue,  4 Jun 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493448; cv=none; b=N4rPKaJ6UUkOmT4ud+pHuRARS6n601FIFYmeq7v93smKF/MGp2eb+ncCUAXYDByTqpt94KReFw5OM0DUY9IA5crcep8BIH6hE40IFGrDEPlH3Di42xmMRBactJTA7GJQB/ykeEkbVqyCTDwhqnRcgm3MF6GaW0yBDZkt6yjQr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493448; c=relaxed/simple;
	bh=k1g971Tx/2W69VSIyC3TwflBinpV7z2wsyPh03w2UQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i6/xwoCyWN9ua7hlprOCL24XZBDQw9KiTx1Zrfvyp6W4I4ikW79rAuFNWIehKXkutlAlbMPN4YHtSXFR5bcn55NjtAUM8GXEFRDDxhUWMNNbDO1cySl7Ys9tU4V+6Ydu8ZZW+4luVCGv8XYko0mJi/i9yh/lxyr6qeiIsuINEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lgN16F3X; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45497h2R013288;
	Tue, 4 Jun 2024 11:30:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	nL+rhL80plHAcEqKjNGqWtyZ+38IgXO/WuU8AB/QLPk=; b=lgN16F3XwY/en8eV
	S+Clu03gknP5ZcnFoJ3CGlsouOzCsH5UtbdVylggQxkp5O8gEb/cI4v0B6/YrFqp
	NMz3efOOoAMRP+H5bN2b4wE6TzEzVnv2h11lg4jaaAWRO1PMAqGkKqc7kSwx2gCJ
	71OkiXdubiYXRmS3CcjYz+JpRjPaYGQr3zb71V4U9ZNVY2VfSElDJEWkHvIk4o59
	M4Z2GWAQMJSNdGov6zkKwUqoc6cEDS77Aanr6hIuTK3KTerks86uUxsYsFsV8cHe
	zmkQ0yzaXnk/z9fpwNVxDNSV/GvSO/TpBcD5HRAVcr5rKYVH/c8D/oxw9z+49Fa9
	8DGyBg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw30au3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 11:30:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4412640044;
	Tue,  4 Jun 2024 11:30:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46683216EDE;
	Tue,  4 Jun 2024 11:29:15 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 11:29:11 +0200
Message-ID: <c41e4379-d118-4182-8a7a-f6cf6c789be0@foss.st.com>
Date: Tue, 4 Jun 2024 11:29:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
To: Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-9-christophe.roullier@foss.st.com>
 <e753d3fa-cdfd-426c-9e66-859a4897ec3b@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <e753d3fa-cdfd-426c-9e66-859a4897ec3b@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01


On 6/3/24 15:03, Marek Vasut wrote:
> On 6/3/24 11:27 AM, Christophe Roullier wrote:
>> Both instances ethernet based on GMAC SNPS IP on stm32mp13.
>> GMAC IP version is SNPS 4.20.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>
> I think it would be best to split off the DT patches into separate 
> series so they can go through Alexandre and have the netdev patches go 
> through netdev . In the next round, please send 01..07 as separate 
> series and 08..10 as another one , and I suspect 11 as a separate patch.

Hi,

I prefer to push documentation YAML + glue + DT together, it goes 
together, further more patch 11, it is also link to MP13 Ethernet, so 
need to be in this serie.

Regards


