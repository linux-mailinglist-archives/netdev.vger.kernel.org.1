Return-Path: <netdev+bounces-100834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368608FC344
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6418E1C21053
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B821C179;
	Wed,  5 Jun 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PiKQG1GB"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA9225D9;
	Wed,  5 Jun 2024 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717567370; cv=none; b=WEEOn8JiGHgxGmoznlx71RKOaDK7dFAnLDwjFdq0j7K1qCloLDMdgD/O+lPbg9tPvAOUlFqhAA1pHcAVgcKvmoLMO2cEISLgs9W/rZBEW9L2NfOufilmCN3TL05YwteqkcMGsMu6x4l7/jyvkPYkGtVt3I0DAigh/cUa63ac2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717567370; c=relaxed/simple;
	bh=ubAy5Sy4LtO8IqXdFZ0dzy0l5V0OzL4Dtf9LaTvCzzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MP4cQYa+RaweD2WeJxDjsWy4fMgnF1zKkCfuWHrOLlDzO+q0FHIUV7cUHonEgVt+UI4XG9RNEBRNBwsKw7GW1nrnOkNm+qt6mw4VgFrPImbvpmoJH5hWjfMWcJ5A1dCKXqv86H6+UUXhTnfoUY0vYIijCUO0B0j3Tv/276kOF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PiKQG1GB; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4550MaE5012962;
	Wed, 5 Jun 2024 08:02:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4DjnJoPbo30AhugHUqFSm27VE7pFMVJlJLwMT373m9s=; b=PiKQG1GBRo57aejO
	FnF4gTRb0IG3xnAWIAbBFCmvQH24hEykzo1zt84HDjp19atARc1OTRKd8Kc58H/K
	q3ChX++VjuDHyubscb2+TMPU6o0FTmfTjIAoC742vD+8NXRZWViipY0xtVEWqFlo
	qTG8IcvQwI9WKmj84cEmQKyLnWc/krPO+18HSfqSJ4I3YXzoWaxf5GFZHoQBtqQU
	cbvAOJPzfkt1e9CIX9mC4RwLEWQH9ei36Yiv8oYQFeQHR+cvwUBUjDM7gmUpXaYC
	SPax9jRQp9y5dMXNDWMbRqkiOqe1uW8uaeVP4NokCfUq5tKJW3lp0+WDTa0qpfa2
	vyHTOQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw3wq3fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 08:02:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 181B74004C;
	Wed,  5 Jun 2024 08:02:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7D2C20F2DE;
	Wed,  5 Jun 2024 08:00:52 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 08:00:51 +0200
Message-ID: <3a59b4cc-0c7b-47d6-8322-4ae12ddb3a4c@foss.st.com>
Date: Wed, 5 Jun 2024 08:00:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] ARM: dts: stm32: add ethernet1 for
 STM32MP135F-DK board
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
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-11-christophe.roullier@foss.st.com>
 <c2242ba3-3692-4c5f-a979-0d0e80f23629@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <c2242ba3-3692-4c5f-a979-0d0e80f23629@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01


On 6/4/24 18:52, Marek Vasut wrote:
> On 6/4/24 4:35 PM, Christophe Roullier wrote:
>> Ethernet1: RMII with crystal
>> PHY used is SMSC (LAN8742A)
>
> Doesn't the STM32MP135F-DK come with two ethernet ports ?
> Why not enable both ?

Hi Marek,

As already discussed in V2, second ethernet have no cristal and need 
"phy-supply" property to work, today this property is managed by 
Ethernet glue, but

should be present and managed in PHY node (as explained by Rob). So I 
will push second Ethernet in next step ;-)


