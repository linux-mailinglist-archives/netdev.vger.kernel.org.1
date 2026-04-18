Return-Path: <netdev+bounces-279505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IMgOFSL42lbIQEAu9opvQ
	(envelope-from <netdev+bounces-279505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:47:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 472DB421402
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2387300F5E4
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA9B288517;
	Sat, 18 Apr 2026 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0/qo2VY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03A12CD8B
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776520018; cv=none; b=m70W/D9F7mxuZaWQPOomECQUN+VLL67S1n7YlcRDxQ2VA6HWgAXdhs1fQ98ffrcZ56KkUVJAmvAzY1d0xjd/cdoJITB5y3G80pF7rzi4nQ6ChcTRnRujZQr0KIlzoPFE5nqc3aAUYK7aee+npcD/fznQsEDkfE+MdlrbnR6oNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776520018; c=relaxed/simple;
	bh=/GE2h6pIcUFHsCAkC9Y5NQGn+nlHTF2BZ0r4HxmVlJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJZfcon7n/SAaSZd8xD0SVQDiSmOa2VM9gOS5iLTAm3rx2SUP7FBECmG1XSVFcd01BQ1r2b//7qnsYamODsdl83yCNq7XHhxm98Xn+VmvKa5jtKzQYPFq/0jGTeym7OqPJa1P2pA3AkH+4j+qtROtFMFFnQzkUveJgjlyIcfxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0/qo2VY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48909558b3aso1990785e9.0
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776520015; x=1777124815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2e4G/AFBNXmY50o2x5RV8tR64rvCCfZoxyprNIdgU4=;
        b=g0/qo2VY6vCcyjilIc86ego5oP5T49A7ZvMkjOvoLeFbixRLY5xwtBe9bFE0vSTW/c
         PGXu34/2wpreO38EJKZmocuTmSsh+g0qXXmJGRy1QlCptYAB/2PxnbyGzEaTAo8FkNma
         oLSXkBRU19gywPF9NUVGTlvcR1dILvrD18mXC+RkU0uueb2excfcq00G3ohUg1OMO+Hh
         6JAQVMem9xSOKMGe7e86BFFomluSEKw9+IkI0RNC9jTRFgp7MFCg+q5cmdGCu1sf7IPC
         z/Tunga8x46HDqZnktlREWfCjn8pxZ5JmbvK3MJwqPeu+SbM1jJbSIiVjjmy4uaA/GoV
         Pziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776520015; x=1777124815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2e4G/AFBNXmY50o2x5RV8tR64rvCCfZoxyprNIdgU4=;
        b=U+Ij8sLPZyDvikPlj1+mbC9p3jNSQvOCyHtRRfYsghmIv+/6fEc1ZlQAbMVxyJzx8d
         UFfzLaKClpNrF/7WRXO+HuQv22ru1JF7cZlVQYRjrxH279aKor6p40uCPviQolOfHPgz
         peJsbT5iVR7/y0sEBd4qpc4GHn4tdlfi7RsvXoaOQoBIVVqcnflVNQQ90TYP4CBkd0EH
         CAl/QEGci2axjfjr5F8WOGGViSvy/UwZ1NYdFrYu9qSvAGoFLJwbe9aVUi384p3KSeAk
         B7uN6nTDJ8Dgk74zXgkv+h56H3j48jKPZE7FH89RJO83VUsyk5k23vLyEFyWviBlYS9F
         C5pA==
X-Forwarded-Encrypted: i=1; AFNElJ8lyQBUMHMoWJvdIA4yjcKb6dHNjjDR7vodWwCW36YUqSwCxqvU8whV3WSlJK7ctSTKXfzWhgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYfBFFyczcqGn/F1tqWpENe0AOmddfxJSut4vYvP86m/mo36m
	XCkNzSbkfwEblhWHRA2RR4QuEZHNEYFxLcJME8GwRLv069GRNNK1gCZX
X-Gm-Gg: AeBDietXRFLajcIRl8OLGhZcRqOvCszSilXSrBJ0CVC37C6VewBdWdt5d9QX9YyB24v
	VWYDenC5df7gGqnzfX2VkiC44PEEXnLagCCNJZQHWqYLc7prfAWJ2XkyFGKoOUjlcvJuhG/L/nZ
	GapzlUTD4dDDLssHs5Pv9pk0JMSMOrh3xjvFKXhSPkY++GWozrImvQxw5m9HuwFj/5zg+SZp2gm
	d6LyOK89rpKyuJx/AffmONUb7w9fAX/TFILzfQ8pn2S/NZqpNl8HwZ56lKci+7E0/YV/a3CQ32z
	7UHqzPoR/wybz4TVBBKo7BEfNqH4blrQ4M/ibeD6dX40QNuvwqZI8F/VOwTNhuUcuV58z/GuXQy
	yuvXsJ2Khk4xE/HU7DHlwVGYcPPpUnV2Qr2I4VzwoxWjfVwQoLDh+AlJ/G/9WM1VkTrTYMJj86D
	RDLYVlw6QVZtFMf1CyF3Zx2XSgKXGHQyMyde445Zzhhqk6v9x2UlhDxab8/8rzHczenqHLkC8Ni
	A0gYPNfJVeScLFw
X-Received: by 2002:a05:600c:890c:b0:487:1108:48af with SMTP id 5b1f17b1804b1-488fb7389a6mr73881855e9.4.1776520015347;
        Sat, 18 Apr 2026 06:46:55 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5273:4380:96ab:9087? ([2a02:a03f:a75e:9a00:5273:4380:96ab:9087])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm119501635e9.12.2026.04.18.06.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 06:46:55 -0700 (PDT)
Message-ID: <75d98880-afcd-43f9-8bd5-b874fa5690f5@gmail.com>
Date: Sat, 18 Apr 2026 15:46:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
To: Eric Dumazet <edumazet@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org,
 dsahern@kernel.org, tom@herbertland.com, willemdebruijn.kernel@gmail.com,
 idosch@nvidia.com, pabeni@redhat.com, netdev@vger.kernel.org
References: <20260417171831.687053-1-daniel@iogearbox.net>
 <60b47924-dae4-4a10-b977-75b92e1094c0@gmail.com>
 <ae053593-907e-4891-90fb-03b4c5d8f5e1@iogearbox.net>
 <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
 <CANn89i+Y0jctj8=tCHFP5jDSJBAWR=RvNfagammc-WqU6EdPRw@mail.gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <CANn89i+Y0jctj8=tCHFP5jDSJBAWR=RvNfagammc-WqU6EdPRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279505-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 472DB421402
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 15:15, Eric Dumazet wrote:
> On Sat, Apr 18, 2026 at 5:50 AM Justin Iurman <justin.iurman@gmail.com> wrote:
>>
>> On 4/18/26 14:26, Daniel Borkmann wrote:
>>> Hi Justin,
>>>
>>> On 4/18/26 1:45 PM, Justin Iurman wrote:
>>>> On 4/17/26 19:18, Daniel Borkmann wrote:
>>> [...]
>>>>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>>>>> index d2cd33e2698d..93f865545a7c 100644
>>>>> --- a/net/ipv6/sysctl_net_ipv6.c
>>>>> +++ b/net/ipv6/sysctl_net_ipv6.c
>>>>> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
>>>>>            .extra1        = SYSCTL_ZERO,
>>>>>            .extra2        = &flowlabel_reflect_max,
>>>>>        },
>>>>> +    {
>>>>> +        .procname    = "max_ext_hdrs_number",
>>>>> +        .data        = &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
>>>>> +        .maxlen        = sizeof(int),
>>>>> +        .mode        = 0644,
>>>>> +        .proc_handler    = proc_dointvec_minmax,
>>>>> +        .extra1        = SYSCTL_ONE,
>>>>> +    },
>>>>>        {
>>>>>            .procname    = "max_dst_opts_number",
>>>>>            .data        = &init_net.ipv6.sysctl.max_dst_opts_cnt,
>>>>
>>>> NACKed-by: Justin Iurman <justin.iurman@gmail.com>
>>>>
>>>> +1000 on the need, but NAK on the way it is done. IMO, we don't want
>>>> yet-another-sysctl for that. Instead, we have (well, not yet, but it's
>>>> about time) this series [1] to enforce ordering and occurrences of
>>>> Extension Headers, which is based on an IETF draft [2] (FYI, draft-
>>>> ietf-6man-eh-limits is dead). I think we should enforce ordering and
>>>> occurrences in this code path too, instead of relying on a sysctl.
>>>> Let's keep both code paths consistent.
>>
>> Hi Daniel,
>>
>>> Hm, that series [1] should probably go to net instead of net-next, but atm
>>
>> +1, would make sense.
>>
>>> hasn't moved since a month. I'd still think max_ext_hdrs_number would be
>>> useful given it has less complexity also for stable, but I guess ultimately
>>> up to maintainers..
>>
>> In the short term, I agree. What worries me is that we end up with a
>> redundant, or even useless, sysctl once the other series is applied,
>> which will only increase user confusion.
> 
> Given the amount of bugs in this code, a sysctl is safe and quire reasonable.
> 
> No one will object when it is eventually removed (or has no action)
> 
> For the record,  I approve Daniel patch.

Fair enough. If there is consensus on this patch, then let me just 
suggest two changes:

- make it clear in the sysctl description that it mainly applies to TX 
(as opposed to the other series [1] discussed earlier that applies to RX)

- set the default to 8 (which should be the max value) instead of 32, as 
per RFC8200, Sec. 4.1

