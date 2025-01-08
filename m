Return-Path: <netdev+bounces-156148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A3A051A3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 04:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E733A89CC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD81919E99A;
	Wed,  8 Jan 2025 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="RyUmT8ow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730419E98D
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307397; cv=none; b=gUAa9OwGbDtIzTk4riTHc4LaNxaLv+biO1+ehXLKVrdRM8NYvUWkV0q4wEZUP00UWUp2L0e5hNlVSQhNEZaM8ZiSYwwUCIbJKOaVtMrLnX4ih9bCtlYIKbfqE8T2pX20Qvg+W49pDf0DHqypIkkLQAU/TgtDL9p+smFRgCOdrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307397; c=relaxed/simple;
	bh=/3/iok7HwOqRCzZKpCvO54WDp2UBRoc8sQRmc3TtEkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHsS7t3mjQ7d4k9DOL7PLnyu1QAtXuQQWqXRi4rgfHsXIIlJR4Z0PU9bLl7DnBoQes9kMNV/Ert6DOqptdseX47sFb4tfKgvyMupxMqwiOfvE3JP/qYIgSUYHJ0bpwoYF8JmHzcLhlmQJAzu2AA+LawBlEDBj/TUQ9oe5y8LnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=RyUmT8ow; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso18377171a91.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 19:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1736307395; x=1736912195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFV8s79Nga7NDIW/gJmI4LOGAth/rXHkgvoLqs7F05E=;
        b=RyUmT8owTz2FGoRXcZA+xIl/G147rlqMIhumbN4+VuwoosO7p2BN1rTeG/TvgNkvDt
         xlb4zM728rRNYp5BYoZKZrNx6th17lJQFyaDNzBrakEk2dSskveXyTZ/Nh6Aaj7RA0Mo
         gHWziwuEPp3IvgHjJ/Iw+69chdvwUSyQZuAsLPP832dMKFhI9B0viRiR01WwVusNf/KY
         ykO7N3Lu4Eocii9k9hw+gEwcuhVOKHEAwOV2d6zKqCwnpukVC+QZhJIGGcKvkO5wIpBg
         JGx48vMX4CxHNhCdMdDPiT7+BWUgrnm6/F5ldrR8UwwmVOVSH3uE5n9Sj/BmVgCMSEpl
         87aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736307395; x=1736912195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFV8s79Nga7NDIW/gJmI4LOGAth/rXHkgvoLqs7F05E=;
        b=MrZxsLxR1Z9Km5rw4oxAZcNT8TFLEG+1GF6OwJOlBTilxmSE07jiBZ57eq5CnrGZX4
         2xFzLU+imh+MjNBRKVw6q7cQD/ClInH4c8m8cMaCnZ4CG09xYIKz/L9uyfzV5iCCQO5J
         J9IxCqDbNDYTGGKSBvAI50IBycCOVOPtxquvfkZlMdDzcskOikAMjJM+QxKkE2p33o3y
         AgEJqlOlLVQP8FmasIQh0LVIP8vw77Xoab8OTBHKJc9HYuB2AC2pbLomjkTL2F3taEKT
         RTkBhWIhttUJ4PKAjjMGHki6T2cQbEQXkPVNgoT/VE6JvGn7Z2xdKyvTanc5OKV0KUIJ
         hWVg==
X-Forwarded-Encrypted: i=1; AJvYcCXbvdcjrM5pe5ZN174Ta29ufnyPt87iJtae6ARnCPmGv/jhceROKmAhti0fvg3atprzoHW0d5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqI6vTqge/L5zAs03d/h4O1oyDaAOiXpQq58Ywg3Bbs3RY0NL
	OAP/P8HMVzJS5glgs7IQDRgAzqGPFb7AkpieFeqjeozXWdI1mUp7/D1G+XLdOMU=
X-Gm-Gg: ASbGncvEwV66B3zUkQF04WVSpX7rnq2TK5MTMdZ3kZYAGstDdfvK96p11JVaZmijuWA
	yFYJV5xZZ2ZDzbmxQsFuwZZhcWvzCtSK/kELJpKLA1tczDtndM7cx2/GkGGj25uFzphnKIOjcul
	NZ+CPbqTJJpOAVm7mIE7XB34NvW6ipAqCdaWAOyufHURBxR9IgRJXEwWQgZiidekj68BizTsaaT
	fSn1N2ri19TQyyDHTdNt4HHXKN+O4sX9Q06kt0xiP5Ulut9znB9agvpfXVyg4eAAS9O0C8GDpw7
	Kn/UWHrhlW5Uqeb7BHEzQpAezFH59Ja1GpBUTrrj
X-Google-Smtp-Source: AGHT+IGfVtup3OhOJVyTvNsjTvoE/uLh2hpokJfWEg3IVDEUsG0+iu0Ck99MuxHSfhIZrcQZrovudA==
X-Received: by 2002:a17:90b:3a08:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2f548eabdc8mr2536114a91.12.1736307395223;
        Tue, 07 Jan 2025 19:36:35 -0800 (PST)
Received: from [10.54.24.59] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964a67sm317484405ad.27.2025.01.07.19.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 19:36:34 -0800 (PST)
Message-ID: <1ade15b1-f533-4cc6-8522-2d725532e251@shopee.com>
Date: Wed, 8 Jan 2025 11:36:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
 <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
 <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
 <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
 <87e945f6-2811-0ddb-1666-06accd126efb@gmail.com>
 <0d98fed8-38e3-4118-82c9-26cefeb5ee7a@shopee.com>
 <32775382-9079-4652-9cd5-ff0aa6b5fd9e@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <32775382-9079-4652-9cd5-ff0aa6b5fd9e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/1/8 01:16, Tony Nguyen wrote:
> 
> 
> On 1/2/2025 7:05 PM, Haifeng Xu wrote:
>>
>>
>> On 2025/1/3 00:01, Edward Cree wrote:
>>> On 02/01/2025 11:23, Haifeng Xu wrote:
>>>> We want to make full use of cpu resources to receive packets. So
>>>> we enable 63 rx queues. But we found the rate of interrupt growth
>>>> on cpu 0~15 is faster than other cpus(almost twice).
>>> ...
>>>> I am confused that why ixgbe NIC can dispatch the packets
>>>> to the rx queues that not specified in RSS configuration.
>>>
>>> Hypothesis: it isn't doing so, RX is only happening on cpus (and
>>>   queues) 0-15, but the other CPUs are still sending traffic and
>>>   thus getting TX completion interrupts from their TX queues.
>>> `ethtool -S` output has per-queue traffic stats which should
>>>   confirm this.
>>>
>>
>> I use ethtool -S to check the rx_queus stats and here is the result.
>>
>> According to the below stats, all cpus have new packets received.
> 
> + Alex and Piotr
> 
> What's your ntuple filter setting? If it's off, I suspect it may be the Flow Director ATR (Application Targeting Routing) feature which will utilize all queues. I believe if you turn on ntuple filters this will turn that feature off.

Yes, our ntuple filter setting is off. After turning on the ntuple filters, I compare the delta of recieved packets,
only 0~15 rx rings are non-zero, other rx rings are zero.

If we want to spread the packets across 0~62, how can we tune the NIC setting?
we have enabled 63 rx queues, irq_affinity and rx-flow-hash, but the 0~15 cpu
received more packets than others.

Thanks!



> 
> Thanks,
> Tony
> 
>>
>> cpu     t1(bytes)       t2(bytes)       delta(bytes)
>>
>> 0    154155550267550    154156433828875    883561325
>> 1    148748566285840    148749509346247    943060407
>> 2    148874911191685    148875798038140    886846455
>> 3    152483460327704    152484251468998    791141294
>> 4    147790981836915    147791775847804    794010889
>> 5    146047892285722    146048778285682    885999960
>> 6    142880516825921    142881213804363    696978442
>> 7    152016735168735    152017707542774    972374039
>> 8    146019936404393    146020739070311    802665918
>> 9    147448522715540    147449258018186    735302646
>> 10    145865736299432    145866601503106    865203674
>> 11    149548527982122    149549289026453    761044331
>> 12    146848384328236    146849303547769    919219533
>> 13    152942139118542    152942769029253    629910711
>> 14    150884661854828    150885556866976    895012148
>> 15    149222733506734    149223510491115    776984381
>> 16    34150226069524    34150375855113    149785589
>> 17    34115700500819    34115914271025    213770206
>> 18    33906215129998    33906448044501    232914503
>> 19    33983812095357    33983986258546    174163189
>> 20    34156349675011    34156565159083    215484072
>> 21    33574293379024    33574490695725    197316701
>> 22    33438129453422    33438297911151    168457729
>> 23    32967454521585    32967612494711    157973126
>> 24    33507443427266    33507604828468    161401202
>> 25    33413275870121    33413433901940    158031819
>> 26    33852322542796    33852527061150    204518354
>> 27    33131162685385    33131330621474    167936089
>> 28    33407661780251    33407823112381    161332130
>> 29    34256799173845    34256944837757    145663912
>> 30    33814458585183    33814623673528    165088345
>> 31    33848638714862    33848775218038    136503176
>> 32    18683932398308    18684069540891    137142583
>> 33    19454524281229    19454647908293    123627064
>> 34    19717744365436    19717900618222    156252786
>> 35    20295086765202    20295245869666    159104464
>> 36    20501853066588    20502000738936    147672348
>> 37    20954631043374    20954797204375    166161001
>> 38    21102911073326    21103062510369    151437043
>> 39    21376404644179    21376515307288    110663109
>> 40    20935812784743    20935983891491    171106748
>> 41    20721278456831    20721435955715    157498884
>> 42    21268291801465    21268425244578    133443113
>> 43    21661413672829    21661629019091    215346262
>> 44    21696437732484    21696568800049    131067565
>> 45    21027869000890    21028020401214    151400324
>> 46    21707137252644    21707293761990    156509346
>> 47    20655623913790    20655740452889    116539099
>> 48    32692002128477    32692138244468    136115991
>> 49    33548445851486    33548569927672    124076186
>> 50    33197264968787    33197448645817    183677030
>> 51    33379544010500    33379746565576    202555076
>> 52    33503579011721    33503722596159    143584438
>> 53    33145734550468    33145892305819    157755351
>> 54    33422692741858    33422844156764    151414906
>> 55    32750945531107    32751131302251    185771144
>> 56    33404955373530    33405157766253    202392723
>> 57    33701185654471    33701313174725    127520254
>> 58    33014531699810    33014700058409    168358599
>> 59    32948906758429    32949151147605    244389176
>> 60    33470813725985    33470993164755    179438770
>> 61    33803771479735    33803971758441    200278706
>> 62    33509751180818    33509926649969    175469151
>>
>> Thanks!
>>
>>> (But Eric is right that if you _want_ RX to use every CPU you
>>>   should just change the indirection table.)
>>
> 


