Return-Path: <netdev+bounces-120965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6795B4C3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00F21F216A6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A8E1C9437;
	Thu, 22 Aug 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SwNGSdh4"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926A1C9429;
	Thu, 22 Aug 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328860; cv=none; b=A9QMf7h2/vh1CjMPYwYpabGZvrX7oNjYpHB2V29grhxVHRezIwNK90SKI5GGtDRsiu6Z3+F5QDfimiCzbtUPdqbliCZx0D1ihRK0KyFtCHG21zHsCBHN31Qp6XqzEaMApK1JefwrjcCNtfdEKcHJm0pp0wvWMMTnLA8JZSdreMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328860; c=relaxed/simple;
	bh=eUKfdNJ+Xy29sLBwpRq0FiEDuyeXE/U8xYZqHm4IJSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LarFdvPjVVLth5PGykvJgvEy3q7oqpSgrHVI1cEUlpgF1RvM+1a4WJ4HTWDyTUJCwds77KDR8SJVeNKozgK1j512yRWgBrfBHzhtae3GgljWx+nlJK7gz3qK37Ty+dnqsw440TqwMbnLzEJuUO6jk5J261swGLbIMxGDsWNMuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SwNGSdh4; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47MCDnjn118743;
	Thu, 22 Aug 2024 07:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724328829;
	bh=wxiAtiX65GOtF/rgKMkuOeK/omSzziZxLbsWMVqGLtQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SwNGSdh4rb3/wm4bAlCEB22dNyaACugUEIiE85fVbKYlmXlLr0XAD/HmD0O+40iEW
	 nfxGxtWz5ZMwpqpFe30wmrZmZQwuV9ghwxsLNUGP0z+rg5su0WcEE8ya00jWjpuun/
	 LquedQlt2rJGvRiTkOQWNYbRTYO1x4JQz4SsiQUw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47MCDn8a010205
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 07:13:49 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 07:13:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 07:13:48 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47MCDeig103713;
	Thu, 22 Aug 2024 07:13:41 -0500
Message-ID: <eeba6255-910e-43e3-b623-5b7fddb0ea1c@ti.com>
Date: Thu, 22 Aug 2024 17:43:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
To: Dan Carpenter <dan.carpenter@linaro.org>,
        MD Danish Anwar
	<danishanwar@ti.com>
CC: Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-2-danishanwar@ti.com>
 <aee5b633-31ce-4db0-9014-90f877a33cf4@kernel.org>
 <9766c4f6-b687-49d6-8476-8414928a3a0e@ti.com>
 <ae36c591-3b26-44a7-98a4-a498ee507e27@kernel.org>
 <070a6aea-bebe-42c8-85be-56eb5f2f3ace@ti.com>
 <5fa6c2e5-19e9-49fc-b195-edc5c6b3db7c@stanley.mountain>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <5fa6c2e5-19e9-49fc-b195-edc5c6b3db7c@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/22/2024 5:02 PM, Dan Carpenter wrote:
> On Thu, Aug 22, 2024 at 11:22:44AM +0530, MD Danish Anwar wrote:
>>
>>
>> On 21/08/24 5:23 pm, Roger Quadros wrote:
>>>
>>>
>>> On 21/08/2024 14:33, Anwar, Md Danish wrote:
>>>> Hi Roger,
>>>>
>>>> On 8/21/2024 4:57 PM, Roger Quadros wrote:
>>>>> Hi,
>>>>>
>>>>> On 13/08/2024 10:42, MD Danish Anwar wrote:
>>>>>> IEP1 is needed by firmware to enable FDB learning and FDB ageing.
>>>>>
>>>>> Required by which firmware?
>>>>>
>>>>
>>>> IEP1 is needed by all ICSSG firmwares (Dual EMAC / Switch / HSR)
>>>>
>>>>> Does dual-emac firmware need this?
>>>>>
>>>>
>>>> Yes, Dual EMAC firmware needs IEP1 to enabled.
>>>
>>> Then this need to be a bug fix?
>>
>> Correct, this is in fact a bug. But IEP1 is also needed by HSR firmware
>> so I thought of keeping this patch with HSR series. As HSR will be
>> completely broken if IEP1 is not enabled.
>>
>> I didn't want to post two patches one as bug fix to net and one part of
>> HSR to net-next thus I thought of keeping this patch in this series only.
>>
>>> What is the impact if IEP1 is not enabled for dual emac.
>>>
>>
>> Without IEP1 enabled, Crash is seen on AM64x 10M link when connecting /
>> disconnecting multiple times. On AM65x IEP1 was always enabled because
>> `prueth->pdata.quirk_10m_link_issue` was true. FDB learning and FDB
>> ageing will also get impacted if IEP1 is not enabled.
>>
> 
> Please could you add the information mentioned in this email into the commit
> message?

Sure Dan.

> 
> regards,
> dan carpenter
> 

-- 
Thanks and Regards,
Md Danish Anwar

