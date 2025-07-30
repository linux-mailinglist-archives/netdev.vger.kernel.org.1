Return-Path: <netdev+bounces-210934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEEBB15B30
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B469818A457F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6822673A9;
	Wed, 30 Jul 2025 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Gkpi26d/"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B967224FA;
	Wed, 30 Jul 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866268; cv=none; b=FrZkop+GrelQDALfpWTMSvfD8XuWuCHIrW1eyIa30oy0UaN17ROCAY39Pcc+YYIH38F6D3DO1uUq7NuOZInOT9MYoz5LYi3/us7S6miHoMmO4NObxfkOrTR1fzM/hHXvb7/o/k+nWIfSxZG/coeuMyJXJcNZVJUDyFdNdKtbkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866268; c=relaxed/simple;
	bh=drdi2avYzKNthiWQapyQinbB9K4Y+4W8DGqPT0eQNnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D1KWFDR9H/2NGUr5Uf87ly+fStls/IUa/R83yO3T+ZmMge67FXsBUykkigmNDJ/8pfgfg+ykcVQZwBo7/GbuajQ3h6L9FtHT+Qv+T0hU0XIjgVArFUsFScPld/6tNRXpeMrJWfsQID5KDVCf476bggXQ5MzGmSIeopN0jb3h4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Gkpi26d/; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U90ZwH015675;
	Wed, 30 Jul 2025 11:04:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9VbTH2W3u5ioDyKORDEdzP1zd1teQirIScT8kKouMVU=; b=Gkpi26d/cU6kGwzS
	RaHVHF6R+CgDH03dRcLxQnuPSdSbnaQwEqeq/XUx5wMtmyxud0MxROgwM66sTOfp
	5jzeq/9eOagTW6E8sPOUDIdKdorLOQvOilRAL+Sp1XfAGWV4fT6JwO1AQOrlFGth
	/23w2KaXy0qIxfrKBAt0KLHNIp6q/A744axLS0NMFPzzqv/snY+NbMaT+TfqbYI7
	ObkpTMowurSwCe1gq7X9ihSjTC616WdurvhrF9zxWHl5i8Ib6ZgzIBT3nqcXue1s
	uZWre/0euNkQRVzgbYLbbn6PkVPX+A4fQovt03w+XHhQF08RBpWcOE2kpr9g899q
	x0CkCQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4858k56kfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:04:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5FA1840059;
	Wed, 30 Jul 2025 11:02:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 543BF6B8C9F;
	Wed, 30 Jul 2025 11:01:26 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 11:01:25 +0200
Message-ID: <e485d74c-198d-48ee-a889-a4f2831506b9@foss.st.com>
Date: Wed, 30 Jul 2025 11:01:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
To: Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20250729-relative_flex_pps-v2-0-3e5f03525c45@foss.st.com>
 <20250729-relative_flex_pps-v2-1-3e5f03525c45@foss.st.com>
 <20250729165810.GG1877762@horms.kernel.org>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20250729165810.GG1877762@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01



On 7/29/25 18:58, Simon Horman wrote:
> On Tue, Jul 29, 2025 at 04:52:00PM +0200, Gatien Chevallier wrote:
>> In case the time arguments used for flexible PPS signal generation are in
>> the past, consider the arguments to be a time offset relative to the MAC
>> system time.
>>
>> This way, past time use case is handled and it avoids the tedious work
>> of passing an absolute time value for the flexible PPS signal generation
>> while not breaking existing scripts that may rely on this behavior.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 31 ++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> index 3767ba495e78d210b0529ee1754e5331f2dd0a47..5c712b33851081b5ae1dbf2a0988919ae647a9e2 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> @@ -10,6 +10,8 @@
>>   #include "stmmac.h"
>>   #include "stmmac_ptp.h"
>>   
>> +#define PTP_SAFE_TIME_OFFSET_NS	500000
>> +
>>   /**
>>    * stmmac_adjust_freq
>>    *
>> @@ -172,6 +174,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
>>   
>>   	switch (rq->type) {
>>   	case PTP_CLK_REQ_PEROUT:
>> +		struct timespec64 curr_time;
>> +		u64 target_ns = 0;
>> +		u64 ns = 0;
>> +
> 
> I think you need to wrap this case in {}, as is already done for the following
> case.
> 
> Clang 20.1.8 W=1 build warn about the current arrangement as follows.
> 
>    .../stmmac_ptp.c:177:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>      177 |                 struct timespec64 curr_time;
>          |                 ^
>    1 warning generated.
> 
> GCC 8.5.0 (but not 15.1.0) also flags this problem.
> 

Hello Simon,

Ok I will comply for V3.

> Also, please note:
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.17 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
> 
> Please repost when net-next reopens after 11th August.
> 
> RFC patches sent for review only are obviously welcome at any time.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> 

Thank you for pointing this out.

Best regards,
Gatien

