Return-Path: <netdev+bounces-110229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA99B92B869
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B8DB20CBE
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750AA154C07;
	Tue,  9 Jul 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="d2loxx/h"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07AF55E4C;
	Tue,  9 Jul 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525001; cv=none; b=NK1iob4xMEvJRQOuzjm4S0l6b20e7m6611ZFQaej9GuEKbxRTpj+I/Vof4uCczp7C8VSHXh9CZO+sGn+muDH0mlpZwuZurZ844dj6Ac1VbYI1Bmsb7vx9LH8DZErAiCfE/lh/CRTrd0lurVdl++wAj5k5/Y17rylTQg1LUI8D7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525001; c=relaxed/simple;
	bh=Pc/rqjlttqr+PCV9ImPrFTWhlgboE1tEVME5GA4Zrms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IJUrDQASAKsASHFKgzajX9Hb49ziRONjgdPLk+FmxmFO8xqjIoiDdLcM1kU2Z3uLNGVhOIvUuRDA7p2h7VvJ6nYo90psx1EFdCx0H7KApS/FsY6Btd0jUAD5Wi3x4EQvpzEmiKCdkcuY0xJYdmE+/pLUm4NimuEwwaHMrG+8iY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=d2loxx/h; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 8AC3D100003;
	Tue,  9 Jul 2024 14:36:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720524976; bh=kEQAy2ywQE4RRBAZOINuz1m3hhrqeBwGx9IhcBaBH1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=d2loxx/hJi5yUfkmk1Um/3sj8IpRQ+3HhAv7SB8YGgqMNf52Au1Qq9mGfmGdaabM/
	 wZhAuIc7qrTo2TTvWKsPTgWz1Fpiee8i+XhvALG1xlxXhH+IJY2QR5QyBNHKsShZH0
	 OJV/1m3xmYd2qP3lHVm0AQ/jv/qH/MXZ5a3Ya/H3uzCBP9nwre40n6Msh5PLL69Djp
	 AycK53QVAGvfsxpciH2IgqS+YSZnHaip+zcKB+Ci6gi1uDh/z/BsZoRz0PUB8Z7eVJ
	 R/zCmEirCjS+OPNDykw9hFQAJq9yObd8lNTA0Hjm8rL33+PRYj3HkK12CVJigTxmAo
	 6M07fM61tyLpQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  9 Jul 2024 14:35:00 +0300 (MSK)
Received: from [172.17.214.6] (172.17.214.6) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 14:34:40 +0300
Message-ID: <99fcfba3-7cac-42c8-9113-2340d5a485f8@t-argos.ru>
Date: Tue, 9 Jul 2024 14:35:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] ice: Adjust over allocation
 of memory in ice_sched_add_root_node() and ice_sched_add_node()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
CC: <lvc-project@linuxtesting.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, <intel-wired-lan@lists.osuosl.org>, Simon Horman
	<horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240708182736.8514-1-amishin@t-argos.ru>
 <033111e2-e743-4523-8c4f-7d5f1c801e65@molgen.mpg.de>
 <23d2e91c-4215-4ea5-8b3c-4dd58a1062af@molgen.mpg.de>
 <190d0cdc-d6de-4526-b235-91b25b50c905@intel.com>
 <56160e13-662d-4f7e-86d3-1a88716f01d9@molgen.mpg.de>
 <14683709-212b-43cb-a110-bb184fcff775@intel.com>
Content-Language: ru
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <14683709-212b-43cb-a110-bb184fcff775@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186390 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 23 0.3.23 8881c50ebb08f9085352475be251cf18bb0fcfdd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;docs.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 09:10:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/09 07:08:00 #25923556
X-KSMG-AntiVirus-Status: Clean, skipped



On 09.07.2024 13:25, Przemek Kitszel wrote:
> On 7/9/24 11:50, Paul Menzel wrote:
>> Dear Przemek,
>>
>>
>> Thank you for your quick reply.
>>
>>
>> Am 09.07.24 um 11:11 schrieb Przemek Kitszel:
>>> On 7/9/24 10:54, Paul Menzel wrote:
>>>> [Cc: -anirudh.venkataramanan@intel.com (Address rejected)]
>>>>
>>>> Am 09.07.24 um 10:49 schrieb Paul Menzel:
>>
>>>>> Am 08.07.24 um 20:27 schrieb Aleksandr Mishin:
>>>>>> In ice_sched_add_root_node() and ice_sched_add_node() there are 
>>>>>> calls to
>>>>>> devm_kcalloc() in order to allocate memory for array of pointers to
>>>>>> 'ice_sched_node' structure. But incorrect types are used as sizeof()
>>>>>> arguments in these calls (structures instead of pointers) which 
>>>>>> leads to
>>>>>> over allocation of memory.
>>>>>
>>>>> If you have the explicit size at hand, it’d be great if you added 
>>>>> those to the commit message.

One pointer instance size is 8 bytes.
One structure instance size is (approximately) 104 bytes. I'm not quite 
sure for that number, because structure is complex and includes another 
structure, which includes another etc. So I could make a mistake in 
calculation.
Memory allocation is performed for multiple instances, so this ~96 bytes 
should be multiplied by a number of instances to get final memory 
overhead size.

>>>>>
>>>>>> Adjust over allocation of memory by correcting types in 
>>>>>> devm_kcalloc()
>>>>>> sizeof() arguments.
>>>>>>
>>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>
>>>>> Maybe mention, that Coverity found that too, and the warning was 
>>>>> disabled, and use that commit in Fixes: tag? That’d be commit 
>>>>> b36c598c999c (ice: Updates to Tx scheduler code), different from 
>>>>> the one you used.
>>>
>>> this version does not have any SHA mentioned :)
>>
>> Sorry, I don’t understand your answer. What SHA do you mean?
> 
> there is no commit cited by Aleksandr in v3, IIRC there was one in v1
> 
> I agree that mention would be valuable, and we still want v4 with my
> Suggested-by dropped anyway :)

I'm working on v4, but I must wait 24 hours from v3 according to netdev 
rules: https://docs.kernel.org/process/maintainer-netdev.html.

In v4 I'll drop "Suggested-by" :)

But I'm a little confused whether to include "Fixes" tag into v4, 
because this is not an issue for the users as Simon and Przemek wrote?

I would be grateful if you could tell me what else to change to avoid 
later v5 release :)

> 
>>
>>>>> `Documentation/process/submitting-patches.rst` says:
>>>>>
>>>>>> A Fixes: tag indicates that the patch fixes an issue in a previous
>>>>>> commit. It is used to make it easy to determine where a bug
>>>>>> originated, which can help review a bug fix. This tag also assists
>>>>>> the stable kernel team in determining which stable kernel versions
>>>>>> should receive your fix. This is the preferred method for indicating
>>>>>> a bug fixed by the patch.
>>>
>>> so, this is not a "fix" per definition of a fix: "your patch changes
>>> observable misbehavior"
>>> If the over-allocation would be counted in megabytes, then it will
>>> be a different case.
>>
>> The quoted text just talks about “an issue”. What definition do you 
>> refer to?
> 
> I mean that there is no issue (for the users), thus no fix.
> Example of recently merged "not fix", with more links to other "non-
> fixes":
> https://lore.kernel.org/all/b836eb8ca8abf2f64478da48d250405bb1d90ad5.camel@sipsolutions.net/T/
> 
>>
>>
>> Kind regards,
>>
>> Paul
> 

-- 
Kind regards
Aleksandr

