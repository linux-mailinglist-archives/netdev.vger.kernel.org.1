Return-Path: <netdev+bounces-297182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SiroFXJMKGpGBwMAu9opvQ
	(envelope-from <netdev+bounces-297182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:25:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D4D662EB9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Yyy6CNf/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297182-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297182-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E13D303DAAC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC344ADDA7;
	Tue,  9 Jun 2026 17:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43294A341E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:01:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024476; cv=none; b=eRwy5sCuRWnJXXWh+lHT1YBxpX1M8wjGOJVROYudtJ6dDar0e0KuRlp5AJtYYoUS9tubKK8MLO/ZftaxQGJriaPqs9bNnIOlmCLIr+NNNsP9Y839Xab8qN6WNZjaSpLDHa5ygW8noEhxMmsQHpc5qkalHrcw+CCBIq+l3sOKkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024476; c=relaxed/simple;
	bh=JASw7Uc4klmotXzbY7lf/BYtivzVBrCr8+zwLgDE7mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrnJX3lgCgtpQQ4lXmnXeezGkEZ6eTLQ96IIARDZ/v4+ZN/g5Z173L6YPF72W61dpboMy/D/M8wpejps0KcrMC8fDjqqoWj/xw4L8Rt/uX+D6VNNBAq4qFfcw3X9VhlXOdFBoOL0ukvqG+gCIFLQREkWu8IF2IlmonYUjXBgcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyy6CNf/; arc=none smtp.client-ip=209.85.218.65
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-bec43eea342so46151466b.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781024473; x=1781629273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPOtRVB9Jc0eGv63GKGHPuidlbtDTypX2bkjNHtGnSg=;
        b=Yyy6CNf/dEKJ2pLiJwZUllB0nohlzgOBxVsMXhEFsKFqEMLwPfPPbHfkmSnHqSVFP6
         g7zCMfVP6fugHq11B0XtjTfKaw4HMrzRyBunR0yqzul8Fm2b7jnJEONjbVkEtBw549Cd
         dXFcOIJ9YKo7VDTdWcl3LuSIhsQ8O+MNlNE4CUGLj9aLgj4c4UQFBEloraW6MetW5mac
         I+vi4EFUr8MNEmOSJbesZ8Us9ACBuQmxQuYSFxCBHxo4ntKCtvvvIhKguY3hNUPS6wH/
         zshmO66tPmm+h5UN4YQCmKJYWh6R3J0G0Xc7duS8DM79+P+DRYpCFI0Pa8IOSQP3lH4W
         lIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024473; x=1781629273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPOtRVB9Jc0eGv63GKGHPuidlbtDTypX2bkjNHtGnSg=;
        b=pIx2tNgXeVffSrEUmhLgTVYFImeCECuyjP8TsSrbiDD/WFIsAQ9Sh/kt2yFe6DtfHO
         8cXHKtZVt0LlTiBEXQaj4pwwwCheDQGKuwc6/aOeORqRPiwqRc1QDOQRgvinAJRtyDK+
         phiALdAWuLpUeujCr2QN98oPvK7zhAJZ5KlnUHFgSs/jS1hdGuTOoYODvfTwLmKx2FQb
         YIet10EZXuevrefUi7D8tzAF5ww/tUcePQNtD71PJdHGr2bFe9kmcbp0/8X6yEapA62O
         0DMklnBpQI+VqzUMnWAJxDu/1WcFC5ZidGiuo6eFr2CByY+ACQuD3LyFqCWSSSBbmRzL
         iOkQ==
X-Gm-Message-State: AOJu0YwGzPo5Nrj5QL+7GRsf2Zq9thuKP9kov1t8L2PpFyoN4CsqSMPV
	vGsC692kXiMJT0+kGzeXIV6V8mWy7Vv71S27bIpPHEgGpOdjOS7DVbTv
X-Gm-Gg: Acq92OGgV4JAOm270EYVym05iKIsz3VDwAcGFTyGQu4IP5QHZv4Xi6mBT/y/E/xnol+
	rOFlJkRWeGYmTFLkKAOjXB8YuLJfKkkgftacs2Y0C27nHGS/cYHkeRiuDPC+KOQpwW6JA3PC6Nx
	S1svtAhcHS+eQ1BPdCkdFyru2Or2gXJJKjHtIhzhRx+8wBGSFPbmp710Iy+QaRVCBmo7TKuB2BO
	ucB9coqljbQPw9h6gqFHUFA2ko/I+PdZU01upjqADNv3/iCcICpm6RRbsHul2KZypQS5ecusc13
	8WK9EsTUGj8Pega4MagiTUYSZirQN7NID1uRJBkbYO9klts76VrQjlC6uZk4T/38uB9X3F0NZwW
	Zm+ZyjmkyfjMzTj1OpaUKbU9F5SgaqIisX5vF5BLAN9ouyxTwuMDa2ceuOWR75hI+xRXqZGQIR0
	ucX67FhH4XIaX732q489XPRaw3Nbymc2w=
X-Received: by 2002:a17:907:3f1c:b0:bd8:26e5:d7a1 with SMTP id a640c23a62f3a-bf36ff8eff6mr504052666b.2.1781024471389;
        Tue, 09 Jun 2026 10:01:11 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1f62sm1095756966b.57.2026.06.09.10.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 10:01:10 -0700 (PDT)
Message-ID: <715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com>
Date: Tue, 9 Jun 2026 19:01:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 ncardwell@google.com, shuah@kernel.org, kuniyu@google.com,
 alice@isovalent.com
References: <20260608130755.5626-1-maklimek97@gmail.com>
 <CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
Content-Language: en-US
From: Mariusz Klimek <maklimek97@gmail.com>
In-Reply-To: <CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297182-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3D4D662EB9

On 6/9/26 03:15, Eric Dumazet wrote:
> On Mon, Jun 8, 2026 at 9:35 AM Mariusz Klimek <maklimek97@gmail.com> wrote:
>>
>> This series adds support for sending TCP jumbograms over MTUs above 65535,
>> and adds support for setting such MTUs on veth devices.
>>
>> The TCP stack is already capable of receiving jumbograms and (up until
>> recently) sending GSO-jumbograms that get segmented before exiting the
>> host. However, the TCP stack doesn't support sending regular jumbograms
>> over high MTUs as described in RFC2675. Specifically, the TCP stack doesn't
>> support an MSS greater than 65535.
>>
>> No device currently supports setting an MTU greater than 65535 but there
>> are some devices that could benefit from higher MTUs and that can
>> theoretically support it. For example, IPoIB in connected-mode can support
>> MTUs up to 2^31. Virtual devices such as veth have no physical limitations
>> and therefore could also support such MTUs.
>>
>> This series only adds support for setting high MTUs on veth devices, with
>> support for other devices being delegated to future patch series. Allowing
>> jumbograms to pass through veth devices is useful for testing jumbogram
>> functionality, and also increases throughput when compared to BIG TCP (see
>> the benchmark numbers below).
>>
>> In addition to removing the upper limit on veth MTUs, This series adds the
>> missing pieces that allow the TCP stack to send TCP jumbograms. This
>> includes a bit of code removed recently by Alice's patch series [1]. Most
>> of the patches in this series are rather trivial. The main problem
>> addressed by this series is that the TCP stack conflates the TSO segment
>> length with the MSS, but the TSO segment length is a 16-bit integer, which
>> doesn't allow for MSS > 65535. This series decouples them.
>>
>> Running iperf over veth on an Intel Core i9-12900K CPU shows a 5%
>> improvement in throughput.
>>
>> Commands:
>> iperf3 -s
>> iperf3 -c -l 500KiB ${SERVER_IP}%veth0
> 
> You are adding code to TCP fast path, for a narrow (and possibly
> dangerous) use case.
> 
> I am sorry, I will not review this patch series coming from a first-timer.

I understand your concerns and they're reasonable. I would still like to
proceed with this series, though. What can I do for you to consider this
series? Would it help to submit a few less-significant patches first before
resubmitting this patch series? Should I resubmit it as an RFC?

This feature is opt-in, so even though I'm adding code to the TCP fastpath, it
should be relatively straightforward to check that it doesn't introduce any
bugs in the regular MTU < 65535 flow.

-- 
Mariusz K.

