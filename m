Return-Path: <netdev+bounces-111060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA4992F9FB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59575281E3F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 12:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE65816B3A5;
	Fri, 12 Jul 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PNBbyBW2"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424ED512;
	Fri, 12 Jul 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720786164; cv=none; b=lfLUfWhndyJAx9g9cqyOxLfIFJ8XRIpvHFZ8T4s2ofL090II2fwx7vfAYUEn2aQKAItaGJdFBoNV7U+KQ2mvCjRstYGCUh5sJFRm0d+NncegfB6+u4FIyHevXcK3jwNw1Xs0kBP1OZbtEyAUQJRDdmO/F4ReTpC83joYYr9jx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720786164; c=relaxed/simple;
	bh=96rwmz4PyAZTvLi+N82OXvuHTULqmo4k8XWFdYjYqWw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=U70SQJSKT3M1/ILXe5uGQmPL/PNj+XUbRmslWYBeRKY6+1RUKu3kzH2wIVPmHQJEseIOOQE+Z53xlwegoCLHLRuWy8MHF2SeNhIQHD9w4AVv/j9j3MuW7tlIgfuJqXpau1cyjWKi7Z5u6o2UjINqWl8fKHhAwsHzAaMTltY0P0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PNBbyBW2; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46CC8euN005579;
	Fri, 12 Jul 2024 07:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720786120;
	bh=XtTTi2TZFxa9xW00fV6xd7qy5RMAFZNkrA47vtE/kHA=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=PNBbyBW2E66A1rTEBy/+/m6b0kNtsYhBO8zztESdlj2u+onEt8GoIpYCeTnUptx4R
	 WZHHgjIKuXqgaOv3CujfTybsWLM+nxYLu7BuaFdFk0J9u2NxfOrT1tupPhNDC8TUgQ
	 01LFsDftDUFoZXHhbPOy57oYKQLKrvlWMoms6MzA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46CC8e46117208
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 07:08:40 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jul 2024 07:08:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jul 2024 07:08:40 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46CC8ZHD085511;
	Fri, 12 Jul 2024 07:08:36 -0500
Message-ID: <b0a8501f-a6e8-412e-bc0f-33e8585790e3@ti.com>
Date: Fri, 12 Jul 2024 17:38:34 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Split out common
 object into module
From: MD Danish Anwar <danishanwar@ti.com>
To: Thorsten Leemhuis <linux@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Roger Quadros <rogerq@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>
References: <20240606073639.3299252-1-danishanwar@ti.com>
 <66b917d6-3b72-41c5-9e30-e87cf5505729@lunn.ch>
 <c720c13d-de0e-440d-a10b-717f6012bf56@leemhuis.info>
 <ca53f2e2-6cc5-42ea-8faf-7d9b7d14421d@leemhuis.info>
 <4cdcf7af-fb0e-47a4-b38a-b8ad98c90188@ti.com>
Content-Language: en-US
In-Reply-To: <4cdcf7af-fb0e-47a4-b38a-b8ad98c90188@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 12/07/24 5:10 pm, MD Danish Anwar wrote:
> 
> 
> On 12/07/24 4:42 pm, Thorsten Leemhuis wrote:
>> On 26.06.24 09:19, Thorsten Leemhuis wrote:
>>> On 06.06.24 17:54, Andrew Lunn wrote:
>>>>> +EXPORT_SYMBOL_GPL(icssg_class_set_mac_addr);
>>>>> +EXPORT_SYMBOL_GPL(icssg_class_disable);
>>>>> +EXPORT_SYMBOL_GPL(icssg_class_default);
>>>>> +EXPORT_SYMBOL_GPL(icssg_class_promiscuous_sr1);
>>>> [...]
>>>> Please could you clean up the namespace a little. icssg_ and prueth_
>>>> are O.K, but we also have arc/emac_rockchip.c, allwinner/sun4i-emac.c,
>>>> ibm/emac/, and qualcomm/emac/ using the emac_ prefix.
>>>
>>> Just wondering (not as a regression tracker, just as someone that ran
>>> into this and carries the patch in his tree to avoid a build error for
>>> next):
>>>
>>> What happened to this fix? After above feedback nearly 20 days ago
>>> nothing happened afaics. Did this fall through the cracks? Or was some
>>> other solution found and I just missed this (and thus can drop the fix
>>> from my tree)?
>>
>> That inquiry lead to a review from Roger (thx!) more than two weeks ago,
>> but that was all afaics. Makes me wonder if this regression will hit
>> mainline soon, as the merge window might open on Monday already.
>>
>> Ciao, Thorsten
> 
> 
> Andrew L has given comment to clean up the API names. I will rename the
> APIs being exported from emac_ prefix to icssg_ prefix and re-spin this.
> 

Posted v3
https://lore.kernel.org/all/20240712120636.814564-1-danishanwar@ti.com/

-- 
Thanks and Regards,
Danish

