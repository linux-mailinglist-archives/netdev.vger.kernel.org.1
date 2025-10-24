Return-Path: <netdev+bounces-232366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD90C04AFD
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0193188D23B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7CD2D29C7;
	Fri, 24 Oct 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ieagnIED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95F2D3209
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290264; cv=none; b=bQ0ibEP5IvEIPlN9+g5YhbASTOcLdEiD2uLzXx3MDFx2ZAWbAERSiPhKjETx6H6hrfxzJshpL9gWVA9ALAHS+DQ8LS+4xiawwsk7cYmjIE7HxraQi5CM7RvfQX5zkvdZI+h0Bu7Y2VyiFQZVIHuDwQ1kZLIaixKp5T4eV56t/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290264; c=relaxed/simple;
	bh=/vAznBeLVSf1fIQdGF3gIoPc+bCQ6I0UEraNQ5bHgic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFtGhwoGyk9gCDziymhxfwEyf/+Z3RXZDMJSiQGSNFwYD5F3qaVqdnhnJohZBnYCH19xPn1Z6fAj4J5e/DeANATlfxHrtirqTy/Nv+leL5/jq4qNeCCATLZ+eAGBPYRMOfjfyxbBLncoKyoQb1+GVfzy5NNxtClxPHv7aXgq2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ieagnIED; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47105eb92d8so1361135e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1761290261; x=1761895061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nzRoDe7JxiIaZSieAhU8KUFNLm8qyp4RTfSomhZxiUQ=;
        b=ieagnIEDhoNVNoPi71Kr4uX1tiEKcF2mY1lw2ZXrULKA4ED8bNTGkJPf3ECkdD8h0K
         0ngiVm1ZQ/Y1ql6T+T69ziyUi71bAdmOy5x5yPY/lQYplpNuO1kip0Un4fBGfsJNnrVl
         dy5F3kcqoOSxn5UehChoZkrCFX9uedSuEcoZ+URp19aPldWFxLOz4F4Zy2008tpQd+bH
         Noq7abQTnV7yufviMGWlt1xWpQ4AtmbdtMx0uL6zd8TPj5HZORLWc16SkXjAXzZ0FvMN
         oF8cHi4uaNb+Kqjonbe97JNpxjinfaaHnh7Ip8YlwUOkNb6ALqdeD+yoxDEkSghPSRcN
         iXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761290261; x=1761895061;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzRoDe7JxiIaZSieAhU8KUFNLm8qyp4RTfSomhZxiUQ=;
        b=VnycFTB1F0Ll2wKUuKaV7TiyJN1+G8qICEKchsU4X2mqDs9ir7yvhgjHCaMft6DX6F
         tSz3LibMErk2WNIXW4vVsb1Ig6CX6t2zUECzP7SzVewMgJ9pOw1msfC8+5S0Mx/SgIh4
         VKDzWoQvKb3qvm1Y+dDzxDPwn2WAAgE7Oc4I0VRZJ+ApLlsSdd/Xi+92177k2QREC9eD
         24eJ9a587VMikQpi5LQOWQLzuLCAbtp0zZHC4A/lFRPvcSuJLr6xJ1uYLuGsVe6RxynR
         Ws+6ImnTGRTAElE5mQUleIl1TCyOA7g2qYE4w6aX2GF+DEc6+ROx2YxgVsWj62f0w1kt
         un5g==
X-Gm-Message-State: AOJu0YyXeJPSexmV+aX3sNByo/M7TnA/Xmti//yQ7IssYAizo89LDrdd
	NaxVmymc54xY+RV9+TgnLoIK5SHwYb4lpz4iEEiOqfrPzLIdQu8Ff3deAmJV7Cr3hpwfiabgqa3
	4nuR0C4k=
X-Gm-Gg: ASbGncusOuF0Ev/I8IlMPjqx8941EyLPcLHrsBqdZTVOPJAfBsL5gSaWMX1SgdWXOah
	QdRnQtq/FoCqdA38lqse508dR6xjwHKCjXXS3TUisbGYxLzmOSJEbEeDcnGh8/yjv102HAp20DH
	DxjIzpNsQv+ItdoymNz56wHbllmxjuC45dmTAYxX74xmoKHSqS/HfVRhgbOkdX1PLXuTS4dwrBM
	ghehjtF3xjs9VWf5SRFb/PJ+xjqFcQn9H9Nz7WNZxrCUX/UxT6aqT0K+2MM5EFQW+Roa9m6Y6xt
	uNVtzYTpw39SYEcFpLsXggdf1DvStXrVmJoIA8qvOLW4yardEw960/OXJjopPVQd63D76CynP8i
	H/SfP8PQUadZbc10Jm9ClvKKp3jF4kpkbuCZ+bpFwhcDGi/8h1/jYtHNF2tdSWXRyBMjxMOiNxO
	LdybnhLbfQyp/U23utTrv9iAwwdHGZ94F36jhtg8EDHjNwcbmAFrtD
X-Google-Smtp-Source: AGHT+IENA6LMv6mF9AoXOJpa+z0U1R9vSizvsixtxKMhld0NdJIx6+Q1jNumDA/zT+rJ0NAyOaOcCw==
X-Received: by 2002:a05:600c:548c:b0:471:5c0:8d71 with SMTP id 5b1f17b1804b1-471177bd51dmr106750625e9.0.1761290260090;
        Fri, 24 Oct 2025 00:17:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298d4a49ffsm3838281f8f.13.2025.10.24.00.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:17:39 -0700 (PDT)
Message-ID: <475d1b3a-53d2-4778-ab56-0df25847c50a@6wind.com>
Date: Fri, 24 Oct 2025 09:17:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
To: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, toke@redhat.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
References: <20251023083450.1215111-1-amorenoz@redhat.com>
 <6a2072e1-43be-49a3-b612-d6e2714ec63e@6wind.com>
 <CAG=2xmNBZ1V7kh7Y0425NPTLJCVyhLB82zNC6GpUN6cXJoyBMw@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CAG=2xmNBZ1V7kh7Y0425NPTLJCVyhLB82zNC6GpUN6cXJoyBMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/10/2025 à 09:05, Adrián Moreno a écrit :
> On Thu, Oct 23, 2025 at 05:39:09PM +0200, Nicolas Dichtel wrote:
>> Le 23/10/2025 à 10:34, Adrian Moreno a écrit :
>>> Gathering interface statistics can be a relatively expensive operation
>>> on certain systems as it requires iterating over all the cpus.
>>>
>>> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
>>> statistics from interface dumps and it was then extended [2] to
>>> also exclude IFLA_VF_INFO.
>>>
>>> The semantics of the flag does not seem to be limited to AF_INET
>>> or VF statistics and having a way to query the interface status
>>> (e.g: carrier, address) without retrieving its statistics seems
>>> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
>>> to also affect IFLA_STATS.
>>>
>>> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
>>> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>> ---
>>>  net/core/rtnetlink.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>>> index 8040ff7c356e..88d52157ef1c 100644
>>> --- a/net/core/rtnetlink.c
>>> +++ b/net/core/rtnetlink.c
>>> @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>>>  	if (rtnl_phys_switch_id_fill(skb, dev))
>>>  		goto nla_put_failure;
>>>
>>> -	if (rtnl_fill_stats(skb, dev))
>>> +	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
>> Maybe parentheses around this first condition?
>>
>> The size could be adjusted accordingly in if_nlmsg_size().
> 
> Good point! I'll adjust the size. Regarding the parentheses, I can wait
> a bit to see if someone else weights in. I don't have a very strong
> opinion about it.
No pb on my side. I was asking myself what the preference is on netdev :)

Thansk,
Nicolas

