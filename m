Return-Path: <netdev+bounces-218238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50566B3B94F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9E416B88E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1330FF21;
	Fri, 29 Aug 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="I9PG/Tts"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B513093D2;
	Fri, 29 Aug 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464854; cv=none; b=MawZo9S7FnftC+1A0T112scmxDv6uA+6I+tgzxuL9ZzNCfcr+1JwZishSvW4mP05Nk1LHYT9yb/Uj2lfVqg/9t3X/NguIl4nS9NwOaPaaYfsB77rySoBBAImKYjXidvHoyf5iAochdhJN9/PgHAKNM36wWqR6/92O/MtgXGt8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464854; c=relaxed/simple;
	bh=H7e5O8hFLj7cfALyJeFiJ/ilsTsRPlbygRn4FoQsbAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dNitK9SUrOhOOkNGqzPEyjJGh3OAwBQufaiaHdyuBvVnG+o3wFx1WyiQ6IanPvYGOcSaPye9MBnmeOjOu+oO7xb6kXmvm5PPaIgbq3xiScFwhVB30pDen/9tVEhOlrdQxVVZ86BbPMqBXDX9bc7GWoz1FF55+q6ZYSF26xg0Uwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=I9PG/Tts; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TAmX4E017538;
	Fri, 29 Aug 2025 12:53:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4xaeXPbiHj1WXGO3LyY/YVYaZRplgC67AGgIQ0JaCzQ=; b=I9PG/Tts+8+sWE0v
	iB/btJghfuyYmvscjR0cyoH4rHTCxk3tjAXGOQmMIqZCIHS9vQkpuo0jjDoO/W6h
	REgP/7WCuTQT3ACMTJzhKXt91r0VOP7Bt7dbQljGhUR0IVxGAU13DL4VGKx9mpnY
	cwQI1tRdhGuOddgHKvR4/WluY3ueD6PExzDb2G50G/D3rK8VORpDh74IMAzVKT3Q
	1dmuf2mEwKN7qHtn8M4GYwz9NO75zx0EvPpWBUaK99s6m1l+MS6PBS6bt5g4AEv0
	NTfAyBYvbmTAAwmOjlKz3OiN8AtGn2OUoT+lxxdMJAiWuNHbsVq8r/rLBOahuP2T
	wcQukw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5v0h561-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 12:53:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6D07E40045;
	Fri, 29 Aug 2025 12:52:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFFBA78F630;
	Fri, 29 Aug 2025 12:51:45 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 29 Aug
 2025 12:51:45 +0200
Message-ID: <57196414-5ab5-41b7-b2e3-ff6831589811@foss.st.com>
Date: Fri, 29 Aug 2025 12:51:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20250827-relative_flex_pps-v3-0-673e77978ba2@foss.st.com>
 <20250827-relative_flex_pps-v3-1-673e77978ba2@foss.st.com>
 <20250827193105.47aaa17b@kernel.org>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20250827193105.47aaa17b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01



On 8/28/25 04:31, Jakub Kicinski wrote:
> On Wed, 27 Aug 2025 13:04:58 +0200 Gatien Chevallier wrote:
>> +		curr_time = ns_to_timespec64(ns);
>> +		if (target_ns < ns + PTP_SAFE_TIME_OFFSET_NS) {
>> +			cfg->start = timespec64_add_safe(cfg->start, curr_time);
> 
> Is there a strong reason to use timespec64_add_safe()?
> It's not exported to modules:
> ERROR: modpost: "timespec64_add_safe" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] undefined!

Hello Jakub,

you're absolutely right. I don't know how I did not encounter the build
error while performing some tests, that I'm getting now as well.

The handling of overflows is already done in that function. Either
I can make a patch to export the symbol or handle the computation in the
driver. What do you think is best?

Cheers,
Gatien


