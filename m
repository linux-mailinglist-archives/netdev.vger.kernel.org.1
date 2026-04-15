Return-Path: <netdev+bounces-278650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF0XLSMl32lcPQAAu9opvQ
	(envelope-from <netdev+bounces-278650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAF40088D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB47F308DC34
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C0F37E2ED;
	Wed, 15 Apr 2026 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvFZqfAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5943803C1
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231671; cv=none; b=ohx3V76n8aTKmoV7LAcl7OOlNJASFadQqDbwyvin+OkUr9dsBiRI3/NsZ0AlDoO4CtEH/Qe2Jq+NNAjMLwfSNUF2hm6dyKjn7q186yAPwrImF3hrnaX1Pt12Kl+oYaRHB7dON5gDEqXOWHEoFe/5DHLysJ1FOVAjOQiF2+PCzf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231671; c=relaxed/simple;
	bh=eCKwA+qiIqZQlfpRKzHylf5F6sp/2pJwdf1EC9B0u+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgdAcN6ELh18/7JsOwHVuY+Spxdz297dkFnxOfImHyDA729pwZlTpTpV07z2MCdmfqbOt9U17OsLa4P9SKZEUYVRjtltWk3YM8wWNeeeY4QWevDzCOuf2emnSqRWjBdbiU+pyKyZVrFf0EBUPcRv207kEHXe4BzPHa/vot3Qts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvFZqfAV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso4107492b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776231670; x=1776836470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuVV5te/UoQgVIHGlgzu/ETtLjtQKCtAInlwfOwxg8w=;
        b=IvFZqfAV0u8C0uYS9jKNSXCreVAWAAFQCZJX0tQgJDf8LcFHgAJIt6Z19sfS98Ad/A
         nB+0ACgV4lmQ2E8D8w4DBjZn5Q0NIngalv1ilTxKWUqtadFxw8IE2+M6TuDiYMTWXAib
         DIZszUgghkSocQH/LLY6Z19FednB+KIEkgQ6/giNb9Xvgpd4B6LMnVaVnQLRzjmRwGvF
         n6emK7gp0Scw4/lTknO+FgcfyC945VDnGvm16dd7OyXKcsFPurHogI/vPlCDpfp8iPAX
         Iyx2c6Ab3x7D7Pqa1LPdbwSfCnAGbSZfb73MPqrTEPokitgHGIy3M79MJvWFAAtzFvF2
         22Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776231670; x=1776836470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuVV5te/UoQgVIHGlgzu/ETtLjtQKCtAInlwfOwxg8w=;
        b=L7VYAmQi09Po9Bf9xPnq7ym+EVRenrQSMPUS0KiI0QX5BQuT6dsgBvAgJEAR5C0dgB
         cLeO6U7JiFCedB2hlYKB+9qqY7EEk+MPt1+oJ54u0190cUFAMpDDZvWxyDAxS23PD5ug
         +G5eOEK3rKcQZ828J/I2kGPjJkRu8tW+WUecHYskQxlZesBFf6dZirI1hDq9TdJH1v4J
         ifxAmanmr+pR/XzAYz21fVj7JEnOGn2C+LRq8eTCAm4PFYQ5Nqs6xCiSAIc44QydKTF9
         kUciJ5p40fZMAy7vVOVGWJmNQcbqII/Q7InTB9NKew6YV76DtPvUf900zcIvc6S41XwK
         IDXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ldgr7RVG1LmywELVUXXGNqXw5KkL3PltIvct0hluOueaiMABATa/St+FBq9rUaU9PPG+LMwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iu1Nk3PuhgwK8iyD9zF6u7tblTQIEUeLTsIgbi7m3K5eBOCC
	opWWZD3hBtQ+sthviHffu16JGfZz5e6nNwUbkAI/VTl8Ye93fB9FYqXt
X-Gm-Gg: AeBDietxUHkbU0BnmB0Vej+87JwxCf8PfE/SzEMfqTluo1rz0t+tVamDsC1lZWKbWIo
	tGsOvXvn6GJPBrkps9+rwj56PFl0+d87tSzIxdFTf0KFWqiOPAOYDJlphvEWobH3EpmHIF1wEQO
	OD1PkddlflU8u2bd1CvVFMoZU/1gJqahHtNytSdPfmQm60wKji8wQeZ5Izn+F0Vdnph6b/YWCDy
	hiVsyasUj86FLC9mQQi3M7gZgNlCUBlAJc19TKSejm44GpMovsIFxKMG55OjmcWpv78u+Hyi8HS
	bb3nTpzd5KI7rOB4VYRI8tBw4bQ0c/PoLWHwEu3RVRwGTPjnpntOTQ6rT20m1ikBgVb5NC93kgP
	wUazSypB5w9hsqwlEROe9dgcmDqYudZM3vfWlb/QeBRlEaIuZCKNOvqLxx31V6Wn11VX4F37rZh
	cm8U6+VzfKk66HrWyjMl085uzvu1qOUY4P/XWb8fQU4MbB2dOE6/M/+BU4rGxT66awaDLUqvgM3
	aa5hv6MUfYj588KACK3
X-Received: by 2002:a05:6a00:1947:b0:82c:70a8:faee with SMTP id d2e1a72fcca58-82f0c1d9e1dmr19993166b3a.6.1776231669692;
        Tue, 14 Apr 2026 22:41:09 -0700 (PDT)
Received: from ?IPV6:2405:6e00:634:7891:2b45:7371:96b8:aba1? ([2405:6e00:634:7891:2b45:7371:96b8:aba1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67411135sm804502b3a.42.2026.04.14.22.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:41:09 -0700 (PDT)
Message-ID: <d525b70d-ada5-45a9-be5d-2377a1707aef@gmail.com>
Date: Wed, 15 Apr 2026 15:40:58 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, "kuba@kernel.org"
 <kuba@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
 <dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "sd@queasysnail.net" <sd@queasysnail.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
 <20260309054837.2299732-3-wilfred.opensource@gmail.com>
 <abQOGm6BqAE5eEln@krikkit> <20260314073919.2f92b966@kernel.org>
 <9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
 <20260316180355.37d45785@kernel.org>
 <8f29d43fc1fd7e6feec4c24131eb2c0292a8c0fd.camel@wdc.com>
 <20260316183023.2fb38d84@kernel.org>
 <64cb821cc09226155059807cb0bcdbc51ae8d0d6.camel@wdc.com>
 <49513ee4347536e7c8419e9e65b8c619a8c665bb.camel@wdc.com>
Content-Language: en-US, en-ZM
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
In-Reply-To: <49513ee4347536e7c8419e9e65b8c619a8c665bb.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,davemloft.net,vger.kernel.org,gmail.com,queasysnail.net,redhat.com,linuxfoundation.org,google.com];
	TAGGED_FROM(0.00)[bounces-278650-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilfredopensource@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkeley.edu:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01EAF40088D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>>> Sorry, I realized when i hit "send" that I phrased my previous
>>> message
>>> poorly. When I say "potential" I mean someone actually presenting a
>>> PoC
>>> and a CVE is issued for it. Have we seen any of those?
> In 2014 a group at UC Berkeley used HTTPS traffic analysis to identify:
>
> "individual pages in the same web-site with 90% accuracy, exposing
> personal details including medical conditions, financial and legal
> affairs and sexual orientation."
>
> They used machine learning to help and that was over 10 years ago. So I
> suspect modern day machine learning would make this even easier to do
> today.
>
> Obviously that is HTTP traffic, which is different to the NVMe-TCP
> traffic this series is targeting, but it does still seem like a real
> concern.
>
> They talk about a range of defences in the paper, with tradeoffs
> between all of them. But the linear defence seems like the one that is
> applicable here:
>
> "linear defense pads all packet sizes up to multiples of 128"
>
> The linear defence seems to reduce the Pan attack from 60% to around
> 25% and the BoG attack from 90% to around 60%.
>
> On top of that the
>
> "Burst defense offers greater protection, operating between the TCP
> layer and application layer to pad contiguous bursts of traffic up to 
> predefined thresholds uniquely determined for each website"
>
> Which to me sounds like the random padding proposed in this series
> would provide more protection then the basic linear padding used in the
> paper.
>
> To me analysing TLS traffic does seem like a plausible threat and
> something that randomised padding would help with. Leaving it up to
> userspace to decide based on their threat model seems like a good
> approach as well.
>
> 1: https://secml.cs.berkeley.edu/pets2014/
>
> Alistair

gentle ping. Are there any further thoughts on adding this support?

Wilfred


