Return-Path: <netdev+bounces-154881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81007A00306
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 04:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BC23A37C9
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641B819DF8D;
	Fri,  3 Jan 2025 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="LZIrt48n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D081957FF
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735873545; cv=none; b=K1TofBmxR9feCZzYff1IIeOa9RcJW7mRWTE4COiUjf3NkM5FLcYH3MzXAVYZFP7uqRwLddfRYRVZ9v3GFHE3nfRGpGlXKpQMC+M/h+vLj0Ktp89roZSfcWIf6aevYQ3njTHhG0YszvVME3JcWdLnUXog6Y7YmiPb+6v3B4mv0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735873545; c=relaxed/simple;
	bh=D8ACTmySjx2qCb2gwARSd7OOJA1snbqkFycABMMJvCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHKMdqwlhZzH5mYUATE7eXNBxa9pfbAOV3vp6Pj7+a8X1twD4Tv0mrQV0fnUjyH4Kjs/xephVgkUcmDSPtmlItoLvDNsQtUicFZwL4vMsp1YDEEJu9fLLu8/zI42l1pgD5NEkSnpaV37Kl03k1t8HhuOJ4M3p2V6KeQpzMyCmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=LZIrt48n; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2167141dfa1so160395105ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 19:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1735873541; x=1736478341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wBt5uTEWitMwxCv7dEqy1zPrPTtgCQI6rxOHe/aejk=;
        b=LZIrt48nWWQhPZwcdW25FKeftcqqhR0jY7Qv0PKEREuT/ZCWhU6M5dN99sEhQ6/1jj
         Z9AAgZ44ZJoTUlZpW0NeuiVTflIwtTF/yeK2Zi4lybNFUuyiKWYceYN5LFkVaUCoyRRK
         bhu7BGwP/zYYowJHvluhZn9rpXGwFmp3koWKX5L+hy1cnhI8JShgDU6OQyzGIzC6Dw2X
         nAJHEZL55vFRMeI4hR+9pEU1KY30555vdBXJNycATDCYU+etIXhdGfW/uU54UvsBZbJx
         cVwmQ7V8IE9Xw1oCOZMdIito6aHYlfaC/VPq8k1lEpYPqrqSA2+n0qDrF+U4M1z/rvrq
         mHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735873541; x=1736478341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3wBt5uTEWitMwxCv7dEqy1zPrPTtgCQI6rxOHe/aejk=;
        b=rE8AbZZaE7ZtvJGoff5mFQzyFz6FPWbhE2g63mUdj+DPhV6v3D7wj/gFNOD+1n12iR
         t9Y7KahMVMIgOJq84U8I5NILlgklmhDqJHeuvywE3hCGuUpQtzY5Qz/4B6p5tWGjF2In
         bMQS4kQpLhOM3Tpkha7h1btQvAIlLbsffU/1SYhYNIkYQGE6irmcVi2aSVR1ulG6deDX
         PwdUZ6Ob6FYYu+Js9LH/InJzcWhyeo8hNkfkpjfP8QZjW/AYDYCKYPNTSVA07O6zDa7+
         keeIWhqn9RG2Y8Xd9c2zTYc6KP47W2IaAnexrLDf8QFj7LB8/JcCNeoKyJFqOV8k/4gw
         aN/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQyabcaf7UYObgBjEIlvw83CW+rNEoibEOckwd+a8F62nHdYjCqAIPN0ARYVQ92DBe0w6FzE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrfCtHLIAFwFi2tNjKPv7YbWp/wRooGGDFFrM47j1FwTi8++n+
	MwGi8FWj5MzFM8PeURHkPb6tRTVDB7tl7KRlPBQYrl6JXmv/D5NZ1xM8MkMldvY=
X-Gm-Gg: ASbGncuNGgY87dGrJH9tDeDYkF9KpI4eoQlYCK1y0XM89Lfgdlk0QccJ22ipzMYf/Op
	EY7aGDnEQgXI6UzQphNtjAtrCSJR0TX/rk3HuNq5Skm691VA0o7Y6FFBbHULOa8fBDLF0DGEuU7
	tCTD3HAYiqpBJUXVw5JYE5NZRns/H4yphdd+Zuq625s8cUUEzH8aWI3C4wWoaaSoo80IMwhHtRB
	GqwoRJ/dnxIUCMLNPlHXrHkIExfxo34U4itUVezcVpqZ2mm7PThdHFcGvkFHF2hCpoiKA==
X-Google-Smtp-Source: AGHT+IEIrhZaPpLfiwgQfu7MPj7/kD5r+srTbB+HLQv3XgPmHgWQdWvO/uvPNzXwevlemGkbvdnaLA==
X-Received: by 2002:a17:902:f689:b0:216:39fa:5c97 with SMTP id d9443c01a7336-219da5ce0b4mr800763245ad.11.1735873541620;
        Thu, 02 Jan 2025 19:05:41 -0800 (PST)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4fe30f525sm2877782a91.12.2025.01.02.19.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 19:05:41 -0800 (PST)
Message-ID: <0d98fed8-38e3-4118-82c9-26cefeb5ee7a@shopee.com>
Date: Fri, 3 Jan 2025 11:05:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
 <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
 <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
 <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
 <87e945f6-2811-0ddb-1666-06accd126efb@gmail.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <87e945f6-2811-0ddb-1666-06accd126efb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/3 00:01, Edward Cree wrote:
> On 02/01/2025 11:23, Haifeng Xu wrote:
>> We want to make full use of cpu resources to receive packets. So
>> we enable 63 rx queues. But we found the rate of interrupt growth
>> on cpu 0~15 is faster than other cpus(almost twice).
> ...
>> I am confused that why ixgbe NIC can dispatch the packets
>> to the rx queues that not specified in RSS configuration.
> 
> Hypothesis: it isn't doing so, RX is only happening on cpus (and
>  queues) 0-15, but the other CPUs are still sending traffic and
>  thus getting TX completion interrupts from their TX queues.
> `ethtool -S` output has per-queue traffic stats which should
>  confirm this.
> 

I use ethtool -S to check the rx_queus stats and here is the result.

According to the below stats, all cpus have new packets received.

cpu     t1(bytes)       t2(bytes)       delta(bytes)

0	154155550267550	154156433828875	883561325
1	148748566285840	148749509346247	943060407
2	148874911191685	148875798038140	886846455
3	152483460327704	152484251468998	791141294
4	147790981836915	147791775847804	794010889
5	146047892285722	146048778285682	885999960
6	142880516825921	142881213804363	696978442
7	152016735168735	152017707542774	972374039
8	146019936404393	146020739070311	802665918
9	147448522715540	147449258018186	735302646
10	145865736299432	145866601503106	865203674
11	149548527982122	149549289026453	761044331
12	146848384328236	146849303547769	919219533
13	152942139118542	152942769029253	629910711
14	150884661854828	150885556866976	895012148
15	149222733506734	149223510491115	776984381
16	34150226069524	34150375855113	149785589
17	34115700500819	34115914271025	213770206
18	33906215129998	33906448044501	232914503
19	33983812095357	33983986258546	174163189
20	34156349675011	34156565159083	215484072
21	33574293379024	33574490695725	197316701
22	33438129453422	33438297911151	168457729
23	32967454521585	32967612494711	157973126
24	33507443427266	33507604828468	161401202
25	33413275870121	33413433901940	158031819
26	33852322542796	33852527061150	204518354
27	33131162685385	33131330621474	167936089
28	33407661780251	33407823112381	161332130
29	34256799173845	34256944837757	145663912
30	33814458585183	33814623673528	165088345
31	33848638714862	33848775218038	136503176
32	18683932398308	18684069540891	137142583
33	19454524281229	19454647908293	123627064
34	19717744365436	19717900618222	156252786
35	20295086765202	20295245869666	159104464
36	20501853066588	20502000738936	147672348
37	20954631043374	20954797204375	166161001
38	21102911073326	21103062510369	151437043
39	21376404644179	21376515307288	110663109
40	20935812784743	20935983891491	171106748
41	20721278456831	20721435955715	157498884
42	21268291801465	21268425244578	133443113
43	21661413672829	21661629019091	215346262
44	21696437732484	21696568800049	131067565
45	21027869000890	21028020401214	151400324
46	21707137252644	21707293761990	156509346
47	20655623913790	20655740452889	116539099
48	32692002128477	32692138244468	136115991
49	33548445851486	33548569927672	124076186
50	33197264968787	33197448645817	183677030
51	33379544010500	33379746565576	202555076
52	33503579011721	33503722596159	143584438
53	33145734550468	33145892305819	157755351
54	33422692741858	33422844156764	151414906
55	32750945531107	32751131302251	185771144
56	33404955373530	33405157766253	202392723
57	33701185654471	33701313174725	127520254
58	33014531699810	33014700058409	168358599
59	32948906758429	32949151147605	244389176
60	33470813725985	33470993164755	179438770
61	33803771479735	33803971758441	200278706
62	33509751180818	33509926649969	175469151

Thanks!

> (But Eric is right that if you _want_ RX to use every CPU you
>  should just change the indirection table.)


