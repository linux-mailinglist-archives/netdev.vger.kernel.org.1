Return-Path: <netdev+bounces-275399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hSUHHxhL0WmuHQcAu9opvQ
	(envelope-from <netdev+bounces-275399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 19:32:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E839BF69
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 19:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B84B2300BCA5
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978322FF22;
	Sat,  4 Apr 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZZLniMs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCD35893
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775323925; cv=none; b=tHiY+jaSL4sEp2P+avs+tbHi6kLK90wRjZJbCIz5A0qXgYdsCN9MB2yRRYcTlF1nNWVrLk1veOq7eZSMB3RJ9FgUlACeoFh5/Zzvckaj3078/zVM/+ypPT/k4aQhtnO2C1fY02ktuf5z7/bv/LLbgtvt4nbIP4lU9qIBEC6qjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775323925; c=relaxed/simple;
	bh=G5NO6/qbq4lLvoX8lplYG7qbuKvsCV+RTGtvHMwQuks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW2t426zZ5NyansCetUz8wxHsUeb0RqCoWfZEJrNrrgxUnPoc8Uyn7kEIOe6mPsoifoVrtPDIcB6jmXbFLrzL7ameQCZnkOMZ2+eegbERB9azAcm/A25jgLapg2JHwopykmfu8Y2VQDkKO9j9Sf0a3cTuXiHnvLrm8xwpn70Kuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZZLniMs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9841aecf72so362496766b.2
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775323922; x=1775928722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mdajg83cdhJb92fM4V8OwfYFMBlzwcGMuQcWmzCCTqk=;
        b=XZZLniMs8f2rTkQIS2Ef1kGVJ+CJmsH90TpDDhBXiPWu5n9uXuu1U2e9IKme7suXck
         KZkW5l5eisGAaZN6/Kvcu6s2sVXYyxmXrgDKQqPITpwqpjwlbgdeH2xpLeIQzlBEVfdB
         6bRF7LRAEN/slXUffn/83NxunY9diw7tNvPXcZVcR6owr5NwO7GI90GqwxB1p7EKh/wX
         KijwsK0exJ+X0s2HVLdEATVCy1QTSrWoEL0oDg/Tb8AaORigC4WMjO6u6pYVswN7qFqf
         NBtm1wBFlnoVgX5oc+iyuSaPpl6wt2Z4R203zaameK8RFLXamIgNbwfQCWAn2CHwVNlW
         v2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775323922; x=1775928722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mdajg83cdhJb92fM4V8OwfYFMBlzwcGMuQcWmzCCTqk=;
        b=GjIZ+XYTuwSVS+bkVxbsKiG9ojjZ35/Gmwsmm1/iBE//fGEhzLOeuYzZQot464lRBG
         lIvI/LSuHm4d4imvvcGjltv+XADRGx3KvBUm4Fy4MtHbES2kGlK2ciweVVx7MDMGW8v5
         OlYzY8CLF1lGlOPV05EOBAtn1SoCXe8eTeXY/i5MlWR6PAlfT1iM7vRYfIBgsC4Mb+4v
         iM8FmtbeqU/8t57b+aIc49IG0vR9hQNjoaaQUYeCBIVjPZUOGPNYO32UBjfz6ysDRvLM
         q8iV7foslVaaaPpa0S0a4017bbHY3mMjHx49hwDJRXk3E6s9hivte1sjbaOhRDKDeKrK
         J25w==
X-Forwarded-Encrypted: i=1; AJvYcCWcJRNVOxSR8ZUwCZbAE183NjMemYUs5FoSjvDOiXKKjeIM+qpqhcw/ocKF2hex20MY4ZtOgqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzB73pswWhJySLFGWTmzHcxhyAwgkFH501281f+bl05WwBmFsx
	nXdrixuSAoUflA92UPAOJa1frYWJoQwnb8fuHa43TvzqDfWdVRGB35XE
X-Gm-Gg: AeBDieujsTT3B9y46nVTxGETuLA3P6HeSh3WB7mssx7FhQ+x2ev06FfGoykOdrNDqb8
	tLXBsu4whm/CGnFkXjqhWalNohiEdSFcmuKFyVPRX+04GGdhPB500VLOqb9XMJNP5XZ7D7mSKb0
	0UNRHNv6ki/4ktZwWCzRNtHrWQqm7ElGLwO7gCg5s8REAOcm8Gj45iCA/ITofXgwslabbDXcgy1
	0VMLc6URpali2noTRIh8qB2W1rVtTrtgmH804cysSk32XydzZuqhrLge+eZwf6RNHi8m+LyR78o
	X4ERa9GEne0iVcTbifBTIl0ApR1hOViYcxxtT7bP9gk+quHGDwvHM5eGBnHCo+Emq8sfjVwoR1N
	BkP8W6bq7guPHy/0lpO95Iwl14KhajFVvOanlIw8nbismRJembss0bUanQmngW3ljfFkVPx3JxX
	ORPvOgHNqCE0qoUZcDIqJbAZcRDLUHYFYLeZR2oj3T1iGgZJAY624R8EqlHo0/N2I6QevZdvkzB
	Es=
X-Received: by 2002:a17:907:c003:b0:b9b:3a1b:e2ec with SMTP id a640c23a62f3a-b9c6766e7a6mr358073066b.14.1775323921613;
        Sat, 04 Apr 2026 10:32:01 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:eb80:1fe:7625:6ba9? ([2a02:a03f:a75e:9a00:eb80:1fe:7625:6ba9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff1298sm318079866b.54.2026.04.04.10.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 10:32:01 -0700 (PDT)
Message-ID: <5307ffc0-d72c-497d-9a38-dc77dcae5f52@gmail.com>
Date: Sat, 4 Apr 2026 19:32:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: ioam: fix potential NULL dereferences in
 __ioam6_fill_trace_data()
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, yimingqian591@gmail.com
References: <20260402101732.1188059-1-edumazet@google.com>
 <20260403214418.2233266-2-kuba@kernel.org>
 <CANn89iKUKTYZ7NVNidtdssZXUAa95LmRpTYUQ29uGE99jLmLOw@mail.gmail.com>
 <20260403145010.4b4e5865@kernel.org>
 <2de5a3d1-cc8f-48c2-a590-09bef92e9adb@gmail.com>
 <CANn89i+QK6cWseXBAbwZaWcUGG6n+CbuWV-4b97x2LmDJoGjTQ@mail.gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <CANn89i+QK6cWseXBAbwZaWcUGG6n+CbuWV-4b97x2LmDJoGjTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275399-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: BE6E839BF69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/26 13:44, Eric Dumazet wrote:
> On Sat, Apr 4, 2026 at 3:13 AM Justin Iurman <justin.iurman@gmail.com> wrote:
>>
>> On 4/3/26 23:50, Jakub Kicinski wrote:
>>> On Fri, 3 Apr 2026 14:47:32 -0700 Eric Dumazet wrote:
>>>>> If the ingress device has more RX queues than the egress device (dev) has
>>>>> TX queues, skb_get_queue_mapping(skb) will exceed dev->num_tx_queues.
>>>>>
>>>>> Since skb_get_tx_queue() does not clamp the index, will it return an
>>>>> out-of-bounds pointer into the egress device's dev->_tx array, causing
>>>>> dereferencing queue->qdisc to read invalid memory?
>>>>
>>>> This seems a different bug ?
>>>>
>>>> I mean, do we need to fix all bug in a single patch ?
>>>
>>> no no, sorry, i'm just sending this out for Justin or you as a separate
>>> thing.
>>
>> Thanks Jakub, I don't know how I missed that. It's not just about a
>> possible OOB: it's actually incorrect for IOAM to do that because we're
>> relying on a lucky assumption at best (i.e., if queue_mapping on RX ==
>> queue_mapping on TX). This unfortunately rules out the possibility to
>> have an accurate per queue visibility (which I originally provided for
>> flexibility). I've had a local patch for a long time to aggregate the
>> queue depth (i.e., sum of all TX queues). It is more expensive(***), but
>> it would kill two birds with one stone and solve both problems
>> simultaneously.
>>
>> Jakub, Eric, please let me know if the following plan works for both of you:
>> - (net) fix the OOB reported by Jakub (and, while at it, add missing
>> locks around qdisc_qstats_qlen_backlog() -> also included in my local patch)
>> - (net-next) after the merge window, add the new feature
>>
>> After that, the per queue visibility would be considered
>> legacy/deprecated and not the default behavior. Documentation would be
>> updated accordingly to explain why per queue visibility cannot be trusted.
>>
>>    (***) the advise to operators in such a case is (obviously) to reduce
>> the IOAM insertion (with the frequency parameter), especially at line rate.
> 
> Getting qdisc stats can be expensive for qdisc with per-cpu storage
> for counters like pfifo-fast.
> 
> If your plan is to sum MQ stats, this could have quadratic behavior :
> O(nr_cpus ^ 2)
> 
> I suggest rate-limiting this very expensive operation, or OAM will
> become a nice DOS tool.
> (Ie not depend on operators being nice, enforce this on the hosts)

Makes sense, I agree. But then rate-limiting would be redundant with the 
frequency of IOAM insertion, which acts as a rate-limit on its own 
already. IOAM is not (never ever) enabled by default, it must be enabled 
on ingress interface(s) explicitly, and configured accordingly. So it 
rules out the need to enforce anything on "hosts", as it is assumed you 
know what you're doing when you enable something (***). Also, IOAM only 
runs inside a limited domain (i.e., private/administrative domain 
operated by the same person/entity). Traffic must be filtered on the 
ingress of the domain (i.e., no IOAM injection from the outside), on the 
egress of the domain (i.e., prevent potential data leaking due to, e.g., 
misconfiguration), and the frequency of IOAM insertion actually is the 
rate-limit inside the domain (to each their own configuration, depending 
on performance). This is why I believe that documenting the whole thing 
would be enough in this case, since we already have rate-limiting thanks 
to the frequency of IOAM insertion.

(***) well, we may add another security barrier, just in case someone 
enables IOAM by mistake, by disabling the queue depth by default.

