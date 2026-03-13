Return-Path: <netdev+bounces-267412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNdLLdjus2m4dQAAu9opvQ
	(envelope-from <netdev+bounces-267412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:02:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62E281DE5
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3230D3028ED5
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B94375F6D;
	Fri, 13 Mar 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fqFU3l+1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5B305E3B
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399588; cv=none; b=EKX6JPDZFS31/r+pNJm0E699KDIfVM3edbn+L0kO2djwoKd450Uhe0KB2FQ1hV1wFkWjhqdRPnek14WVpB0lbWOifAOmncgyLiFnJS8Z5GxKk0WYpVtKswsMhB6SM5SQfn6WWIxHws0UHe4xQVrRHQIw96zLKvfAINB/hods3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399588; c=relaxed/simple;
	bh=/DeGgks7prAMGk95laFynNNmC70BjO3fWEyuVcxeDvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmKf7JmNaA49g73s1lw/S54cjTjut/oEMks7Tezi2KZPsIBZRJ0AUS3VJJJ9zRq6jwXxbnlipLARH+xYYoBIgJ4Ag0iA7mxFPDDSPeD/cE1MycS0OyozgVsZlryKpPz28CBciiAK3zBoZFs5dpg4aWPjAm//W+ase6wSuINyJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=fqFU3l+1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439bc1a201fso225009f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773399585; x=1774004385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m20ydtFr7k5vZRbqByGEDREDyMamYEcaHGNZVt6cmWQ=;
        b=fqFU3l+1CQTx9FVAcu7wJJiCbdZlkOZidNBPVfdZ/PQ48McD0KeGLjHVyngGr3DMNW
         8pc+Qht/E3pkHQCqHv2deltZ/jELVXeVKRs9AlM/OA7mGwfz1ZVJC1Shwd0m7qcdiQjR
         5rMsyQEWJ6Hvqnp97QSAUvIrEx7W9fWPnbd8eTCxjyKMpDXYwMtbtFQURwvqyzvlh7CX
         X+Dbbx6A5mVoBsYzJ+ELAzogRcMsmMIxUCWjChrTA+4y8ZyO9KpTv6739SVJHwjIJNxz
         QMvvdUDGgULHj/tG4tUpcqPLz0fdKvErhZXpwTYVRBreqtzdocUOhY+XM8Ykc9ErH0Yz
         kj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773399585; x=1774004385;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m20ydtFr7k5vZRbqByGEDREDyMamYEcaHGNZVt6cmWQ=;
        b=baXB0iPuN67Mz0BXsB1KRH26qRVv8SBPwTQcdnuIcjq55dudYhDqF5OjHu0DxgFSxF
         R1g4/jok4S/ql+rAr4zoPTwS78VApOLG6yi79KwOrbZKrQPIrJ5QK32zdx00numTrT7s
         yDgJw2Fze56RxMUZRXf2gevC4EiVpn4vkgElmPYUE/E4/HvDawmOS66O0hoseKhEHt/G
         l7pg+E0lFToVdlnSSJC3Gx68jcfUiYGP5ULFq/LGxUNZ3GtaTLvwf6iczUGU2WFuDd5D
         hJaXax5kkn7pWSaqix6VzI1xzgJwQpV77NYngCjA2yFE9Z5JC1DC+FYcjviVA7PAVA1t
         4/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVu6tGrELnV97O6p5FE+7DPsG4rgx3+GrokokFjItpap+PvjNVgYI1BovLv6owaFdQHlRbvGzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbpG21NPrVRq4C19xTRGKYZRrtkZCac/HULes6eWiI9Yw8ePOz
	A2329mCo5zXx2tWXlIWNAOsVHRGrT+GmHfQvyyIV2GYWjy8haE1OuL3lNbERtTpPajA=
X-Gm-Gg: ATEYQzw49io9FKKx0Sg+tEHPcxiAGHItx7R06A/paK6PrrMEOMnqoFtBsWcN662dn4P
	2fVCjtiJf3hGjo4GfeFhQFyhN1vFduBvynGMkQN+Y4zCjFAlDp2+Lvz/Ny5rbcD4zKchMigNFHg
	t5BZrxb5+hcGbfAH8CfDQixmjjXkmvLqJ2vYuQUJWr2HV2jeMXBJEtvp0kJnXkMyrxfx9Dameqo
	3/3eXiUmNbpjTjlJpGvL6HIpnamO0c/xr6O4sT2dWn+9hKg2dkeM7Ce0PY2Qy0KTlPJBOcTkpNy
	zLfw2pdQRl4ycHBx104svrYPiXx09qqmKayowru2eQZXGYdZNVK7LTjcqMEEt15k/Yr3n2eaDg1
	NBoHP/VGcg5nuPBIl2B4piSbhDCh3DwpV0HjUsyiqO4SvJvHBUSPr8n8VmL+leTUU51MgvImA6M
	IcZpty28F+7v6vrf/63cl0Bku2h9X3eiVlH7ykpT/agqjAUrmFZERqQn3S3BMcJ8xvX3UduJe7w
	fIh
X-Received: by 2002:a05:600c:c4ab:b0:485:39a1:bcb3 with SMTP id 5b1f17b1804b1-4855670f7demr25687385e9.6.1773399584954;
        Fri, 13 Mar 2026 03:59:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6c24sm182910485e9.5.2026.03.13.03.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:59:44 -0700 (PDT)
Message-ID: <3d9d384f-d001-4293-b7d5-7a88596ffc1d@6wind.com>
Date: Fri, 13 Mar 2026 11:59:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] seg6: add per-route tunnel source address
To: Justin Iurman <justin.iurman@6wind.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 justin.iurman@gmail.com, stefano.salsano@uniroma2.it
References: <20260311152845.278354-1-justin.iurman@6wind.com>
 <20260313030220.af70f3b5f2c5d2cb7b4a840e@uniroma2.it>
 <CAOY2Bqz8_8iT2Auw=sWob0-XUQg-sPmdAFvzRLg+KszrU6LMqA@mail.gmail.com>
 <43e16e45-5fb1-4413-bbd1-4752bbcdec7d@6wind.com>
 <CAOY2Bqx6jjBc5FCoRg+64v2L17bBsaAE8sy7P4JCwVXc+1n7_Q@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CAOY2Bqx6jjBc5FCoRg+64v2L17bBsaAE8sy7P4JCwVXc+1n7_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[uniroma2.it,vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-267412-lists,netdev=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[6wind.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:dkim,6wind.com:email,6wind.com:replyto,6wind.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D62E281DE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 13/03/2026 à 11:20, Justin Iurman a écrit :
> On Fri, Mar 13, 2026 at 9:47 AM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
>>
>> Le 13/03/2026 à 09:44, Justin Iurman a écrit :
>>> On Fri, Mar 13, 2026 at 2:02 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
>>>>
>>>> On Wed, 11 Mar 2026 16:28:45 +0100
>>>> Justin Iurman <justin.iurman@6wind.com> wrote:
>>
> 
> [snip]
> 
>>>> Whether to also reject link-local is debatable: ip6_forward() does
>>>> drop it, but is there a legitimate use case where a link-local tunnel
>>>> source would actually be needed?!
>>>> I'd argue we should reject link-local addresses as well.
>>>> For instance, using them as a tunnel source violates scope boundaries and
>>>> breaks ICMPv6 error reporting.
>>>
>>> IMHO, I also think we could reasonably forbid LLs.
>>
>> Why rejecting LL? It's legal to use LL as a source address of a tunnel (and
>> forwarding packets in this tunnel). Is this forbidden with srv6?
> 
> Well, this is indeed legal (at least nothing prevents it), but they're
> not routable. So question is does it make sense at all? We're talking
> about two nodes on the same layer-2 link as the only valid use-case
> here. I'm not sure it makes sense, especially in the context of SRv6.
Yes, you're probably right. I'm usually uncomfortable with a configuration being
forbidden without any real problem/reason.

