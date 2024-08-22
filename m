Return-Path: <netdev+bounces-120964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C4A95B4C1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A05E2848FF
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0901C943C;
	Thu, 22 Aug 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gukoQh7V"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FAA17B418;
	Thu, 22 Aug 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328819; cv=none; b=JSrurHKfJCVRfexCvQ6Ei2B9eCLGPu2bfHBRrjeTnuJCFw459YWPJ87lUu9HNF3hW00uhM8p/10Q6XoRPngASflDjsEfHwYf29VXnUH7hZZG3h8grz1pejFw+Fj/x/mvOdpUlLdRVStanJarEvmgMIRiJPwwbXw+1/dTlfRMLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328819; c=relaxed/simple;
	bh=06Ovyxk7vDnjfhQ7z0yUyJ7mwFLH9IHSeLEPPlBaPUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SjIcu3OCHe4fBiPlyiQs0a/JUrKjiJ4O+/d+AEnnfgDwYlVcGuy9u6pdeualQSfV8fJ8F3uLEBS+EFAnnkRN2suUSnkif95/K2vbCoEFv26J6zAI10o/fH3azClCrhQcjHQoUAFpoZ4XwRfvqO7LTWzrfs+KNDOA0/UXI//VkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gukoQh7V; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47MCD35t038877;
	Thu, 22 Aug 2024 07:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724328783;
	bh=Xdnr4ZABxTZlcix8tONhecfUN7VsGV18kppaZyjL7O8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gukoQh7VVdPDUVIX8y8F/OOhEAyurmbPIZOwUzSwYNKpFRgerPSqmY1kiPEu4q1kD
	 /ThP5kBqOWGvljXC0/wHskKoo//6XbYtmIZcfu+KIQUj9JSRX1wKwaRYVnjv5ab2Jv
	 iKiXdzAkbI7EEmpCpCHMjyJupT/NXw0uj1gsWCqs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47MCD336029980
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 07:13:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 07:13:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 07:13:03 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47MCCtiU103054;
	Thu, 22 Aug 2024 07:12:56 -0500
Message-ID: <c26c0761-def7-48a1-973d-2c918689902d@ti.com>
Date: Thu, 22 Aug 2024 17:42:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
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
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-2-danishanwar@ti.com>
 <aee5b633-31ce-4db0-9014-90f877a33cf4@kernel.org>
 <9766c4f6-b687-49d6-8476-8414928a3a0e@ti.com>
 <ae36c591-3b26-44a7-98a4-a498ee507e27@kernel.org>
 <070a6aea-bebe-42c8-85be-56eb5f2f3ace@ti.com>
 <8ab571a7-6441-4616-b456-a0677b2520c7@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <8ab571a7-6441-4616-b456-a0677b2520c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/22/2024 4:57 PM, Roger Quadros wrote:
> 
> 
> On 22/08/2024 08:52, MD Danish Anwar wrote:
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
> 
> Bug fixes need to be posted earlier as they can get accepted sooner and
> even back-ported to stable. You also need to add the Fixes tag.
> 

Yes I understand that. The problem was I will need to send the patch
twice once as bug fix to net/main, once as part of this series to
net-next/main and drop it from this series once the patch gets merged to
net and is synced to net-next. Since I cannot post this series without
this patch as the HSR feature will get broken.

Or I need to post this to net/main and wait for it to be part of
net-next and then only I can re-post this series. So to avoid all these
I thought of only posting it as part of this series. This is not a major
bug and it will be okay from feature perspective if this bug gets merged
via net-next.

What do you suggest now? Should I post the bug fix to net/main and post
this seires without this patch or wait for the bug fix to sync then only
post this series?

>>
>>> What is the impact if IEP1 is not enabled for dual emac.
>>>
>>
>> Without IEP1 enabled, Crash is seen on AM64x 10M link when connecting /
>> disconnecting multiple times. On AM65x IEP1 was always enabled because
> 
> In that ase you need to enable quirk_10m_link_issue for AM64x platform.

Correct. But since for all ICSSG supported platform quirk_10m_link_issue
 needs to be enabled. Which in turn will enable IEP1. I think it's
better enable IEP1 directly without any condition.

IEP1 is also needed for Switch and HSR firmwares so I thought directly
enabling it instead of enabling it inside the if check
`prueth->pdata.quirk_10m_link_issue` would be better idea.

What do you suggest here? Will setting `quirk_10m_link_issue` as true
for AM64x will be a better approach or always enabling IEP1 without any
if check will be better approach for this?

> I understand that IEP1 is not required for 100M/1G.
> 
>> `prueth->pdata.quirk_10m_link_issue` was true. FDB learning and FDB
>> ageing will also get impacted if IEP1 is not enabled.
> 
> Is FDB learning and ageing involved in dual Emac mode?
> 

Yes FDB learning and ageing is involved in dual EMAC mode as well.

>>
>>>>
>>>>>> Always enable IEP1
>>>>>>
>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>>> ---
>>>
>>
> 

-- 
Thanks and Regards,
Md Danish Anwar

