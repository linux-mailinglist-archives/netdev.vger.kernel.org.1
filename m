Return-Path: <netdev+bounces-268121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKEINUnlt2mzWwEAu9opvQ
	(envelope-from <netdev+bounces-268121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:11:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5321829884C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B679D3016812
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5958277037;
	Mon, 16 Mar 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vm+TjLuR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83927281E
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659414; cv=none; b=ZQjKcLdGlqee7N7QZruzmVhYaeaqaf+3tpkcwtloHlXZFd81RwA9fH0gcj8XzrbpJXmanFEIDqK6alZkUx9zGce1/IgSnfjfsG314WE+f/JoDJFo6WdGrlaqk0pJiscIS1YjGGIj6RKTE/x9MZTN10ocxi8Zx66FsOnR47nPZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659414; c=relaxed/simple;
	bh=OhZgKUNEVf43PWXIQbs80iOzFGCsvCK2gp3yomkS/zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlsdUJdWyfrdFCszeQHAU8fqEenTGaP5o/87DvkrxPBumpzrKJTqkv+LRNf6Wdbbz+aVqxGIiWkKEK9EcoOt1rTL//Fma1c1WeWRsfcnvFf7PiEwGmKDeb7V9egvM0s3TlfEpEDHXN6baZiHXh9+U31ZqPsp81h4sAilHg+Xoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vm+TjLuR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4836fc075d2so2876835e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773659412; x=1774264212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWqJdKmHKk7PJeuYVaTskZ3cGYWK9ZLVy7ZFX3Q/Nv8=;
        b=Vm+TjLuRxViZFEax1nzduDPwc2rn5qw2m9sWzP6tRM+MYWjZE8lP6dZ292V3+0Exsw
         0iG6/LQThkPI/8+yqx8CWAjjyBAFavW5+QYTfMTsgitYhTLVmYlDdg0VhSzvYrN23kl6
         X6/4YB8QljFSq+3w3p4VuAaQdvfE67rYLiJCqrcZdupMYG5rsPG8hpBzP0/s2fkicAo2
         TFKsm8yYSxrcljWbef3NSVTkdEHcZFB/4KH3HzJ1I1ApM8091mkDyXm8LFrp4WQUrcec
         IeoweRoBsSx2MmSazSlOfw5b4swLWAYMUfRUfYo3uP3YD2YNSkDqMCmOit13X8nz/Og2
         sPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659412; x=1774264212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWqJdKmHKk7PJeuYVaTskZ3cGYWK9ZLVy7ZFX3Q/Nv8=;
        b=fjeM4kopSMxrbGMbDEquKkVrbmmx1qcP/TmjU9nobOrvjwScxRrP4Nv/JnRzwHLicb
         7P0ZPc9PMTuKvrMub7DjllnhuP7fe3ilaP+xc6t3mycFIFpsi5La5JOqpVSHOC2YKe4d
         tKiRAom5mk34umg/qAFaADVn3Z3BmmgtmGhD5LJBk3lpmPWgiKyKvDv13Oylie56Dynm
         egrUIFIbjjorHxo/uN/iwYQ2bgU/JUHjYAaojUq7DwamsXwENDmDGKBHgWTvbH43Z+eL
         FBwRRAz1UCIOWjsY+Mh8tqxTl2PzwU7LO+ZmnPSadmbxMXrKxNp8VoDbuoxCJpPAjOni
         pRaw==
X-Forwarded-Encrypted: i=1; AJvYcCUT/K3+71RM66Hn6zUOFKt9tkc6hE/2P8PHz43ZjUGe5QgQEbQj30/ScLt8DumCHmr4j2LcP+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIhvyUjbSLKuj+uAX3G54W3pSVvLleTPhl49PJ4wmqQ9ABsKpv
	kefjTPrwYw7icMtF5KOUp7rIeLxE1OMlg7CBmEo+jR8M1Qyo2XK/p9uVMTNhivAAIBs=
X-Gm-Gg: ATEYQzwkcCMpHpw0s2xVoY1nAdYW8K9CJD3Rt8qp9mmeV+Z3INmTJCCc5UDeI4xfdQr
	kC3mpreK19ioW/G2+o+nEmDpxZWWQ/3mNdd266j0DSSHDi4nM7lZWnGzJiob2ZD74zTbtyGD613
	BGRKlGSvw2uPbB2m+m6eHbEbAybxr57mZwXrlUKK+09PbiY6/V59y9TASRmxQie05Zg3wnYOrJt
	zAVHGZk2M3mZKNftepykJ4HByS5tQ06YWT8xfBBUrxdiUWa/YI9S6wahi9CyIstfUKz+aCOSRtC
	Q3lLhDh8kx3xDnGmOOKojM+QAKnaY+OyfSZnx7viUVymBVCENE6RsZC+vFdtfd7jA1PuIAKKcX8
	2/PYms55f6hhKb7m74U2ouL6Z+VILiE6DH3TpjPYJ8FRUCG57/ktFeRDaDKflJP8VYlW9UUwDkq
	xdIsa5SN99suMWw1gftfZ8tRcvQ3K1g9jBoy46OuKBnu/fmwIcUO5xLhyoVw==
X-Received: by 2002:a05:600c:8b70:b0:483:7d93:9f8a with SMTP id 5b1f17b1804b1-485566d2ca8mr110386035e9.1.1773659411631;
        Mon, 16 Mar 2026 04:10:11 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bed6ffsm116910026d6.16.2026.03.16.04.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:10:10 -0700 (PDT)
Message-ID: <97d85c42-5ef3-4912-abb9-8d4fe6fa54df@suse.com>
Date: Mon, 16 Mar 2026 12:10:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove
 stubs
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <cd87ed46-b774-4896-b25e-4806eec9e0b3@suse.de>
 <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
 <51102620-fb8a-467e-9144-786d1fe27e31@iogearbox.net>
 <4e3cd289-2b7a-4f64-99f6-05eb9d67c0fc@kernel.org>
 <c28d7cba-3805-4e6d-8051-d12e923c1973@lucifer.local>
 <a1dc7907-39a0-4417-8589-c48a4a7cc839@kernel.org>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <a1dc7907-39a0-4417-8589-c48a4a7cc839@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-268121-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 5321829884C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:33, Krzysztof Kozlowski wrote:
> On 16/03/2026 11:24, Lorenzo Stoakes (Oracle) wrote:
>> 
>> If I'm wrong and somehow Amiga isn't legacy in 2026, then SAY SO instead of
>> giving an unnecessarily mean, dismissive and frankly embarassing response
>> like the above.
> 
> Calling something legacy in this thread is not really appropriate
> because it is diminishing its important or requirements.
> 
> Till we support given hardware, we are supposed to consider its
> requirements. If you do not consider these requirements, then you do not
> consider that hardware as worth being supported and this means you
> should first propose patch to remove that hardware.

I don't think it's so binary. AFAIU (and recall also Linus saying that) it's
ok to make things less optimal for older/less common hardware, if that's the
cost to make the kernel better for the major ones. So that's why we're e.g.
discussing removing CONFIG_HIMEM which could limit how much physical RAM
some 32bit  architectures can use. Or we can have new features e.g. 64-bit only.

We can call that older/less common hardware "legacy" or "museum" or
whatever, I wouldn't say it's diminishing it, just stating a fact.

Of course the devil is in the details so that probably to some extent
depends on what exactly you mean as "requirements" above. AFAIU the
conclusion here was already that ipv6=m isn't consired one for Amiga to
stay, and it's enough to have ipv6=n there.

> If you do not want to care about that hardware, don't use arguments
> "legacy" in discussions, but simply drop it. We do such with "legacy"
> architectures.
> 
> Best regards,
> Krzysztof
> 


