Return-Path: <netdev+bounces-279507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOVjKyeS42nSIgEAu9opvQ
	(envelope-from <netdev+bounces-279507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:16:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C8B4214E9
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD721302A183
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB7389102;
	Sat, 18 Apr 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdn1q+sf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D62BAF7
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521754; cv=none; b=NNJ9E/BpMIDvBz4iDDlbdjg7+eMwxFwb10lARXOLbnHOKJh+zDYbiEaVAaHo255YXvA5Dd+51K+wwx6K5rBR8gfjOQstGt6o1VYnOamu7lUYo5uFt43ONdwQDeuU9efuhWSxQLDiYabCcV7TQU26Vi2VGoFYFvklEvQfR3Fypbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521754; c=relaxed/simple;
	bh=z1Z9va+k5oiXolg0K6b+9VtA1bb0HW1IKLOpAaeXFc4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HuoFHG54HTyc8aFhb3Plzb9185HROe1KWmuyqqbEcTEGgrjyGvUIEoWQVMMrjyXBeNa7Uwd8D0F+onh0K5JbFtig0U/mPrj0gaX2enfrflNguZTC7I+hh5ePAwuapwkSjhY5MGM4gg40d+HKgO8dwGKgK1WFoq1VioC5m5MAtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdn1q+sf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so22450225e9.2
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521751; x=1777126551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+xLRaFcPXM43gqcq/eDY0E3lFTDPiIJY+IePpFdU9D8=;
        b=bdn1q+sfEZQmdJiexKCkxg484f1aYrLVBMJgzCh0Tq/402pBXT0Tn0PvxaVrZ+d/QJ
         GcnsHy/tntWpAQbCTulvSxfbVe8wEQic/hfar/AipQF9cITqG3LPQ8nCQUtF7ywO9SZB
         ZEekFLv/K27vKRCYq4un9yAh8amcnT1gKIg68418ox2t/NkQkSkjzflsr5vUoCgUVvxR
         581DK7xeNxIVEj/JRs87vht77V4KxRl3N7x/FVMR2Rl/wtKgz+rJzD3I5qWL/4pOfJ1M
         CfsXAXBPddeuIAvrFh88OO4FtP4PqygxE6V0K3GbflDRBcbmLCFI/RlykM67oxMHhg10
         jP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521751; x=1777126551;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xLRaFcPXM43gqcq/eDY0E3lFTDPiIJY+IePpFdU9D8=;
        b=BYCLemL6VkkyybMo7Fjnf7unHiVHyPc1n0mSkSxyeopQmvXDY1kpK1l3AnPfC+UXcT
         HhrgvJcCLx5f2G07xtejDBXN6y2VUGznEZdOcF1I8xYVyi0W2DtnHEg8XdrwDnGj7cH/
         auFmHLoVLe950AEiumXry0lFMUpSNriaySPb8uRxBw2Q5CRVRJMWxq/j+QP9ZZJ8iqdw
         WsDg1IC3Bbr5klgIFsAhOIHcyY2JeRLqyDcEAKYdfW5i65ky7oQtMvxFK7/f6oolN1yE
         nDn6WcKAlfF3pPu3NccXBxeaKAS8YsK0ZhCiRqrGddNMuOD3yVq66VgmF4D5SvxCDtSv
         Opag==
X-Forwarded-Encrypted: i=1; AFNElJ9ZlIezDd14gqo45XwGS9seq4NmbyV/1J5CHo0PtFbI83TJgefoHiwvMClo8ghi0ZRFxhTWivQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2YUqDuzjhNliIzs6YUJz6eRt7kPvLEAYNLpUxVx3sMg5B+j1
	9q5cS9dcCwPV6ojTX3S5+TjgO1ApgIoW+oYNC/VldJuU7cF7xRYKu4YK
X-Gm-Gg: AeBDies5vS/JukqUP4IZkBXWqPWFdSnPaY1dxbLCZri+ZsuglEw9Y6DpGzTkaYB36Tu
	xo5us6Io0BDes9gJhhJVFHjheQXUz0RGqJlHVNtA2kTSqQmtyonZyBZXisDMNDmOrRe76tMTzAL
	ybJg9UDqd6FWjlkTX+/vHyzInCqYxrlbr45YuB96lSbQMEh/v+eLRiwQYieFDShyY7KGmB14Aur
	+Y2o5MaOnbqSWpf7sU5ofJNcPdqxndJDwm+yyBJk6R4hMUDrugoWIyt4VXwQVOYQTIuyWyw/87j
	kIGYfTZbFoTBTc58KGbs0T8AmODlGcL1Rn0ESoJ+w1x+gjSGyaSRs9TLF0A8dy14A6pLRfVahKl
	5H74oGxPJLAlttw6BaC95hY6p28eJqd28yhu8I4UgJjf7ImVJHlHDPxvSRhtCy+1gAyhn5VWszA
	wgRuEkmNDlgsYXpe6rhP5tpu9ti/5zVyRHTzlFj7ZdtJuF3JTyok52w5unfUhMETRwzw31eQfKH
	YljtWZ7YPrRK9HTP6hJMJZzpdc=
X-Received: by 2002:a05:600c:154e:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488fb74fc02mr103657105e9.10.1776521751124;
        Sat, 18 Apr 2026 07:15:51 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5273:4380:96ab:9087? ([2a02:a03f:a75e:9a00:5273:4380:96ab:9087])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f93dsm202408585e9.3.2026.04.18.07.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 07:15:50 -0700 (PDT)
Message-ID: <e084bf5d-99bf-4e23-8dc1-3e7e13c58a2e@gmail.com>
Date: Sat, 18 Apr 2026 16:15:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
From: Justin Iurman <justin.iurman@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org,
 dsahern@kernel.org, tom@herbertland.com, willemdebruijn.kernel@gmail.com,
 idosch@nvidia.com, pabeni@redhat.com, netdev@vger.kernel.org
References: <20260417171831.687053-1-daniel@iogearbox.net>
 <60b47924-dae4-4a10-b977-75b92e1094c0@gmail.com>
 <ae053593-907e-4891-90fb-03b4c5d8f5e1@iogearbox.net>
 <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
 <CANn89i+Y0jctj8=tCHFP5jDSJBAWR=RvNfagammc-WqU6EdPRw@mail.gmail.com>
 <75d98880-afcd-43f9-8bd5-b874fa5690f5@gmail.com>
Content-Language: en-US
In-Reply-To: <75d98880-afcd-43f9-8bd5-b874fa5690f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279507-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46C8B4214E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 15:46, Justin Iurman wrote:
> On 4/18/26 15:15, Eric Dumazet wrote:
>> On Sat, Apr 18, 2026 at 5:50 AM Justin Iurman 
>> <justin.iurman@gmail.com> wrote:
>>>
>>> On 4/18/26 14:26, Daniel Borkmann wrote:
>>>> Hi Justin,
>>>>
>>>> On 4/18/26 1:45 PM, Justin Iurman wrote:
>>>>> On 4/17/26 19:18, Daniel Borkmann wrote:
>>>> [...]
>>>>>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>>>>>> index d2cd33e2698d..93f865545a7c 100644
>>>>>> --- a/net/ipv6/sysctl_net_ipv6.c
>>>>>> +++ b/net/ipv6/sysctl_net_ipv6.c
>>>>>> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] 
>>>>>> = {
>>>>>>            .extra1        = SYSCTL_ZERO,
>>>>>>            .extra2        = &flowlabel_reflect_max,
>>>>>>        },
>>>>>> +    {
>>>>>> +        .procname    = "max_ext_hdrs_number",
>>>>>> +        .data        = &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
>>>>>> +        .maxlen        = sizeof(int),
>>>>>> +        .mode        = 0644,
>>>>>> +        .proc_handler    = proc_dointvec_minmax,
>>>>>> +        .extra1        = SYSCTL_ONE,
>>>>>> +    },
>>>>>>        {
>>>>>>            .procname    = "max_dst_opts_number",
>>>>>>            .data        = &init_net.ipv6.sysctl.max_dst_opts_cnt,
>>>>>
>>>>> NACKed-by: Justin Iurman <justin.iurman@gmail.com>
>>>>>
>>>>> +1000 on the need, but NAK on the way it is done. IMO, we don't want
>>>>> yet-another-sysctl for that. Instead, we have (well, not yet, but it's
>>>>> about time) this series [1] to enforce ordering and occurrences of
>>>>> Extension Headers, which is based on an IETF draft [2] (FYI, draft-
>>>>> ietf-6man-eh-limits is dead). I think we should enforce ordering and
>>>>> occurrences in this code path too, instead of relying on a sysctl.
>>>>> Let's keep both code paths consistent.
>>>
>>> Hi Daniel,
>>>
>>>> Hm, that series [1] should probably go to net instead of net-next, 
>>>> but atm
>>>
>>> +1, would make sense.
>>>
>>>> hasn't moved since a month. I'd still think max_ext_hdrs_number 
>>>> would be
>>>> useful given it has less complexity also for stable, but I guess 
>>>> ultimately
>>>> up to maintainers..
>>>
>>> In the short term, I agree. What worries me is that we end up with a
>>> redundant, or even useless, sysctl once the other series is applied,
>>> which will only increase user confusion.
>>
>> Given the amount of bugs in this code, a sysctl is safe and quire 
>> reasonable.
>>
>> No one will object when it is eventually removed (or has no action)
>>
>> For the record,  I approve Daniel patch.
> 
> Fair enough. If there is consensus on this patch, then let me just 
> suggest two changes:
> 
> - make it clear in the sysctl description that it mainly applies to TX 
> (as opposed to the other series [1] discussed earlier that applies to RX)

Sorry, I meant it does not apply to core RX (ip6_rcv()), which is what 
series [1] does.

> - set the default to 8 (which should be the max value) instead of 32, as 
> per RFC8200, Sec. 4.1


