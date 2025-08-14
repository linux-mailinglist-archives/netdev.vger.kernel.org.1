Return-Path: <netdev+bounces-213862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31C8B272BE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0697A1BC89F5
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6A286D45;
	Thu, 14 Aug 2025 23:06:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D8274FEA;
	Thu, 14 Aug 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212802; cv=none; b=PlgeoqK75HR/vb4ZxxIwu43ZF3AQcW8fc0XvXGQKgZAFx26jPgOLwCzHVNsjyHM6kPcSyB6e5qlUuzoNL8MACLYIyu1zI1fkFKnn0txWS2Tai1ejBShRAh1pdI4Hl88soxFkWbTh5HWCoygu36CXM1NB89Ugfy0n8wCRFz/CI0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212802; c=relaxed/simple;
	bh=sdXzmWWpUlwjFCDA70V4N1bivKnfUxgYxUSJ9qZHMMQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YUrNlqAWlrFD3v5IDC2RSF5Hzy4a1s9YCcm8L75VBWZSabhshv6X1HAC/RC9gvsGAuBnYSt3V9XIEMY1CkdJJtsEuofvbYDT4ww2u0CNrPR25/gEwoA7sgy/+K9zwVcLDT7iGipqmNXS5vGcxIU11vHRzifDKmbpKZQIpLP5D1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-afcb732eee6so263305266b.0;
        Thu, 14 Aug 2025 16:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212799; x=1755817599;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXnplGlkyDTeaox6X00V6jxLfRKeFukcmIXH2iD7ztc=;
        b=stWGbiws8pMCsH4eF6hYrTMytKRE4ur8ez4gvu4gx53YCergwZXcHSDowLkIdv8bzk
         3PsFIBJNMPuY2K7Ysp+dU52b7xS2q0BcuJXggFdGQQd3gw6yleltVkLVWCvSim1FgvqV
         QCTlzEpFMgqnYslGdnt07astyVr34nxBnKEobYSyAuQbSO3LZ55QRlK00kavF6ZK349H
         yi5H/7P1ANC9MXBqalNPfPqiWREhwp/SULwdHMcXMnS67byWNQ0aJtrMsRQxiQRyI6lR
         CJo3gN+jcO2AtMVp18mgh+2CYz1xD9Jm3QcjYHTIfFf3y8i9srpu8tcQz+cX8S4y38aq
         +ZAg==
X-Forwarded-Encrypted: i=1; AJvYcCUIDGcumZ7Bio1tQhSiz/q1mUADHwhed+2osvI5ey+AB5FOla7cyGvSDw5wozlOgYlJIldRbNBR@vger.kernel.org, AJvYcCXXV4M5nMuoMpeQKVs4bF4f5LbM6TP6dnYgQCfymOkORcFeIgffqUSEDbIYLb41vg4bN4XnNfLzeq9ochs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwimU1aHhl10XmGXcaFyiorrQoR6M7DAdt0R4RXq+Bl+i5g5HME
	T7xSxblT6opcFmzu6fhnq3rjSAzhX7CW7/Ca1LBMSJoTCvtD8tSMmYO9
X-Gm-Gg: ASbGncu9bcTid+BfI0p3oQG0B6iVglQVUzG8Nixjnbmwf/bsAoRFIOoIIo4oINu0ntY
	Q0g4WCi5ooSPgHPwJDZMzlTV/m+0jtXCCqeXS00mqC7/4cOSkyGqjRw83LUZHS8bII3UvDzxxNB
	MAMQJdx81qZBpjkSqddBkxc2oN19vB1e+Bj4TlIGjaP+BlfCmcuLZI4M9wNcW12Dai94FFI6Z8z
	f/xh4N9hrJs3nw/H2OsU7c+RH+VcUlBZr99BzB3tUc7xclyKHlGtUnmANhqlkLyiJbjiS8wZY6G
	yBfnI18+CZsdYbcAR/f45xc2o5zvgYZ2c63SV/B5W6sN5T6euZahyjEIwfXO/8v0UrOxqnZjG70
	m70vgapWIIHAWRvkPsm2PobHaDvPpR+FJsfL9+32B/GdEuHKLkPLXcLzi+ItObA==
X-Google-Smtp-Source: AGHT+IG0ztIcudX5Ts7T7x1WT1fvBSmROh+7VLwZ2hEu3cSOlSUdEL923mzHLnPPhfxsGVNkg/P2lA==
X-Received: by 2002:a17:907:bd0c:b0:aeb:3df1:2e75 with SMTP id a640c23a62f3a-afcb98fdcd7mr450702966b.46.1755212798868;
        Thu, 14 Aug 2025 16:06:38 -0700 (PDT)
Received: from [192.168.88.248] (89-24-36-92.nat.epc.tmcz.cz. [89.24.36.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0afsm2662920366b.117.2025.08.14.16.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 16:06:38 -0700 (PDT)
Message-ID: <71e91e70-57c2-47c9-8a00-88a8ff008fff@ovn.org>
Date: Fri, 15 Aug 2025 01:06:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: openvswitch: Use for_each_cpu_from() where
 appropriate
To: Yury Norov <yury.norov@gmail.com>
References: <20250814195838.388693-1-yury.norov@gmail.com>
 <c5b583a8-65da-4adb-8cf1-73bf679c0593@ovn.org> <aJ5Pl1i0RczgaHyI@yury>
 <2dc70249-7de2-4178-9184-2d50cc0dffe9@ovn.org> <aJ5XJmDa-Ltpdmn3@yury>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <aJ5XJmDa-Ltpdmn3@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 11:37 PM, Yury Norov wrote:
> On Thu, Aug 14, 2025 at 11:21:02PM +0200, Ilya Maximets wrote:
>> On 8/14/25 11:05 PM, Yury Norov wrote:
>>> On Thu, Aug 14, 2025 at 10:49:30PM +0200, Ilya Maximets wrote:
>>>> On 8/14/25 9:58 PM, Yury Norov wrote:
>>>>> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>>>>
>>>>> Openvswitch opencodes for_each_cpu_from(). Fix it and drop some
>>>>> housekeeping code.
>>>>>
>>>>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>>>> ---
>>>>>  net/openvswitch/flow.c       | 14 ++++++--------
>>>>>  net/openvswitch/flow_table.c |  8 ++++----
>>>>>  2 files changed, 10 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
>>>>> index b80bd3a90773..b464ab120731 100644
>>>>> --- a/net/openvswitch/flow.c
>>>>> +++ b/net/openvswitch/flow.c
>>>>> @@ -129,15 +129,14 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
>>>>>  			struct ovs_flow_stats *ovs_stats,
>>>>>  			unsigned long *used, __be16 *tcp_flags)
>>>>>  {
>>>>> -	int cpu;
>>>>> +	/* CPU 0 is always considered */
>>>>> +	unsigned int cpu = 1;
>>>>
>>>> Hmm.  I'm a bit confused here.  Where is CPU 0 considered if we start
>>>> iteration from 1?
>>>
>>> I didn't touch this part of the original comment, as you see, and I'm
>>> not a domain expert, so don't know what does this wording mean.
>>>
>>> Most likely 'always considered' means that CPU0 is not accounted in this
>>> statistics.
>>>   
>>>>>  	*used = 0;
>>>>>  	*tcp_flags = 0;
>>>>>  	memset(ovs_stats, 0, sizeof(*ovs_stats));
>>>>>  
>>>>> -	/* We open code this to make sure cpu 0 is always considered */
>>>>> -	for (cpu = 0; cpu < nr_cpu_ids;
>>>>> -	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
>>>>> +	for_each_cpu_from(cpu, flow->cpu_used_mask) {
>>>>
>>>> And why it needs to be a for_each_cpu_from() and not just for_each_cpu() ?
>>>
>>> The original code explicitly ignores CPU0.
>>
>> No, it's not.  The loop explicitly starts from zero.  And the comments
>> are saying that the loop is open-coded specifically to always have zero
>> in the iteration.
> 
> OK, I see now. That indentation has fooled me.

Yeah, it is fairly puzzling. :)

> So the comment means
> that CPU0 is included even if flow->cpu_used_mask has it cleared. And
> to avoid opencoding, we need to do like:
>         
>         for_each_cpu_or(cpu, flow->cpu_used_mask, cpumask_of(0))

We don't really need to do that, a plain for_each_cpu() should be enough,
because 0 is always set in the mask at the moment we allocate the flow
structure, see:

net/openvswitch/flow_table.c: ovs_flow_alloc():

   cpumask_set_cpu(0, flow->cpu_used_mask);

This is true since commit:

  c4b2bf6b4a35 ("openvswitch: Optimize operations for OvS flow_stats.")

The open-coded loop is just an artifact of the previous implementation.

> 
> I'll send v2 shortly.
> 
> Thanks for pointing to this, eagle eye :).


