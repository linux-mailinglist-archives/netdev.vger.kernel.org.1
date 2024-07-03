Return-Path: <netdev+bounces-108763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED39254A9
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 09:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD08B248A6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BA71386B3;
	Wed,  3 Jul 2024 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="PZz37Lo8"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798C135A72;
	Wed,  3 Jul 2024 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991891; cv=none; b=ds3mgAnWj3hxciQJdzlI5fOLMN0JbKyCyftolqU7bi9U34Az32qbRr/GSzyXQvsfr5R5qaKwnwfqIBT3YoQuCO/SLe5F9EhNXUrzlvfYVM2kt9RHjVPSVtB46iqjDIrNODQOSQ7wszRo7r1c9QqCcLStBnW4E5JMoSqaoK6qzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991891; c=relaxed/simple;
	bh=+ufCLk3L4afA7WNfJNVkYuLuil+6lW0D0k9TINsLIOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JfxhEBKfdzsQQialbCqZEXURa9lzNClTbJ6SOnjrpzM9B0K1P3OBMmgh2GCOD4tM4hSFvESImEoY2NugIVFjzKglGiuq4BO30o63KJFJDL6/7S8g0x/OXaGWuUfftG+xAOF4I9chFubOoxF2VpniD1fGPrvHz5dmOU5WAU8tLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=PZz37Lo8; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id E2496100004;
	Wed,  3 Jul 2024 10:31:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719991861; bh=bIX620jLOF+Iw8vjvO0I99ZpNw2RI/rI7+3XwTT5SIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=PZz37Lo8IaCDiwFCsxDeScm5HXofPT5RothY8/u3MLdaWffjJZXTJXPZ8zhUWTIyx
	 /tOVfHlSOBbODWRFV62xkc9coqukMvvi1ZUjKdpAytmRdYIG9aj/62wi/Hup9W2BSp
	 AxAwk2Esp4hu23NMF55Y9phpv6wgmqzVs55+waLn58WUlRGfsomeJ5qXV4S+bJFzYL
	 gvYWl+L4xzsxfmvahyqVi+vn2h8nt0ZOut2qLneBLs8FyVKlxHl7QUnvPCERcGd0bX
	 H2ybtG2qFPbKQxXd0ceocvzSfJ4ncuZKg7YYnvjBlXAmpMFJ/T8GfgSSA3TGAIIMGV
	 CR60zHYiIgGEg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  3 Jul 2024 10:30:26 +0300 (MSK)
Received: from [172.17.214.6] (172.17.214.6) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 10:30:06 +0300
Message-ID: <4899faf4-14cc-4e68-86e5-8745b38e5ab1@t-argos.ru>
Date: Wed, 3 Jul 2024 10:26:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: pn533: Add poll mod list filling check
To: Krzysztof Kozlowski <krzk@kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240702093924.12092-1-amishin@t-argos.ru>
 <d146fb2c-50bb-4339-b330-155f22879446@kernel.org>
Content-Language: ru
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <d146fb2c-50bb-4339-b330-155f22879446@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186296 [Jul 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/03 06:28:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/03 06:16:00 #25818842
X-KSMG-AntiVirus-Status: Clean, skipped



On 03.07.2024 8:02, Krzysztof Kozlowski wrote:
> On 02/07/2024 11:39, Aleksandr Mishin wrote:
>> In case of im_protocols value is 1 and tm_protocols value is 0 this
> 
> Which im protocol has value 1 in the mask?
> 
> The pn533_poll_create_mod_list() handles all possible masks, so your
> case is just not possible to happen.

Exactly. pn533_poll_create_mod_list() handles all possible specified 
masks. No im protocol has value 1 in the mask. In case of 'im_protocol' 
parameter has value of 1, no mod will be added. So dev->poll_mod_count 
will remain 0.
I assume 'im_protocol' parameter is "external" to this driver, it comes 
from outside and can contain any value, so driver has to be able to 
protect itself from incorrect values.

> 
> This patch is purely to satisfy (your) static analyzers, so this should
> be clear in commit msg. You are not fixing any bug but adding sort of
> defensive code and suppresion of false-positive warning...
> 
>> combination successfully passes the check
>> 'if (!im_protocols && !tm_protocols)' in the nfc_start_poll().
>> But then after pn533_poll_create_mod_list() call in pn533_start_poll()
>> poll mod list will remain empty and dev->poll_mod_count will remain 0
>> which lead to division by zero.
>>
>> Add poll mod list filling check.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: dfccd0f58044 ("NFC: pn533: Add some polling entropy")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>>   drivers/nfc/pn533/pn533.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
>> index b19c39dcfbd9..e2bc67300a91 100644
>> --- a/drivers/nfc/pn533/pn533.c
>> +++ b/drivers/nfc/pn533/pn533.c
>> @@ -1723,6 +1723,11 @@ static int pn533_start_poll(struct nfc_dev *nfc_dev,
>>   	}
>>   
>>   	pn533_poll_create_mod_list(dev, im_protocols, tm_protocols);
>> +	if (!dev->poll_mod_count) {
>> +		nfc_err(dev->dev,
>> +			"Poll mod list is empty\n");
> 
> Odd wrapping.

Just like other messages in this function.

> 
>> +		return -EINVAL;
>> +	}
>>   
>>   	/* Do not always start polling from the same modulation */
>>   	get_random_bytes(&rand_mod, sizeof(rand_mod));
> 
> Best regards,
> Krzysztof
> 

-- 
Kind regards
Aleksandr

