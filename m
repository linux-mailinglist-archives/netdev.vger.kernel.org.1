Return-Path: <netdev+bounces-285172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFpFJFRE/GnMNgAAu9opvQ
	(envelope-from <netdev+bounces-285172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9824E4E443E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D24733002F79
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECC5370D5E;
	Thu,  7 May 2026 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="GCcGIk1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737B370D44
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140239; cv=none; b=XV+u294VVfLxaZLUnuoC8co6Ry/f2CZp50vsXzMzrZn4yiE4Usot5NgRIxd5InNzou2IItiz6fD+llcScspwVelYPei3rV5GUfY0tG5zmgkKMNWBIQGATAXgMwUbOdq46xDtn5tm+5OPqhIZXkHNlsTq7jbTinp9/65WfrQqWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140239; c=relaxed/simple;
	bh=CXifJGsbhENDtyiTlyzKA1BRv3ZdpcOlUQiYadmnCT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/Pg4eKXQkRYPzQq5Fco9yGDv8yfa8faXyosKKgkJmw1S+MwahaZDA70L3dl3dagwypi/oYP4/cRNJNmBuwHmxpPSR2yU+1F2cG2xH/TAEMEUbnNcixx8QfCZeg8uN+TgLbKi6A9dBrv9xPofZZ+2adx3HCvsVtzBc3fqVbM2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=GCcGIk1g; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-130a4aae5ccso1808913c88.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778140236; x=1778745036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQaH4VE6zKt+ePtRJskHRhgkSbQv1EciQK3ci86kyl4=;
        b=GCcGIk1g7jXXgIl5QK0y+LQMl6qRP9GHY3cCD2olKvIg4HaOp5kKrTEa1rhIIiPX1R
         9vhgf1i+FGxECeEMcofffSb1eP/SvVnIMnP1dGenurL4fOSGiqj+2kCaNZJhpTvPl//P
         3rfKVLTCRMvFgkDSM1QvZ145iuuxM8Ey8i88gPnwdWwE3bfrbyVNac0qOWY/QaHOOEUa
         TS6DdIRiT6q+dxTaFdx1AqznRKt/K1795cIrdqzgBUCXpMVm9U0vcKU7fLkJWvTxpX0R
         ZV5QaKRT0h5I+4hzUuZLVnZNC7Z+p+foj/BfMcm39IMR8W1A6Z1LPdWKY6zQTO39zU4m
         UFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778140236; x=1778745036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQaH4VE6zKt+ePtRJskHRhgkSbQv1EciQK3ci86kyl4=;
        b=U/y06BgomOYtPfYu9ffBzw+yd+GAnuzJSSo4ZeR+lJogxhlakpoe8P1FegF58pO6EN
         w8pKvw/gExOU4Ld31JOQjjG8CRtRMMcZrR3Fwe5Nik8u8l9eD90eqIIYyZ6yTntXoMVF
         k/Zokh3gEDLU96AgtqPLjO6LDOXYVgNLvjQAK2HtVOYH75t0Wcy84z6BCIa3o/qNO3K1
         FLhdgf3sixkGSmvPfg3VjWydwK7ipSXlfE7oufzEtTywOwqu3nF9E6NdFszZVzMeMt1m
         wJhs8q0WYfIF/xr61vIUG3v8dKJuVdSTdYowzD1Aa6Ibd+IEE5FhM7FVPdQgupF5tLOe
         DYoQ==
X-Gm-Message-State: AOJu0YwTzVWX9Zn+wBZ0fl+NAz5XlE4VrxnVCJCU1VMV5dNy7AxRhlTQ
	CFiW+3d4yANlL6MkBqtlTirDo74+xnel7Pn642ZzpeA516222plIlgSCMJFVE+9ldf0=
X-Gm-Gg: AeBDievzx67H/sEotdcCCdtaFY8SSu7wK5DSxOWFWXgV5FiN8hWQOkAt8lz79fxhAOz
	GOATvu8S09zk+bsPh6TVk6bYdG3tl/UNy6GG139e+PZMkAsHVhxzHSXvKcg18F7LA9wbMU9KK16
	K10qPkbpTOf9xHNVsleY0op5MTL0pp7fDCG26GNkwhcHjQPWS9Cr87b8d9+c7Dlh+zE/SyYI8aw
	Uf6DYxWcgRoB8uJKrlz59a8kqUO6yL4QEBe5sznjOEARndp0tKVK8waq0cJuZ0xv4xdeBiqja7B
	F0nAkQPupT61xBOi/nMtUhl5xGVWZpteqT9WSpzP2yL+2WCpGj9c7cpBpWK62DdK+W4BVN5mIQZ
	BrL7EXSz5jKX+y3qk7gIE28qCtg9HQLp/r2BO80EwAMnj81zEVIB2qTXMPEdfXJ8ClqvQBEfO3+
	DLMAklc9wvKRKDAtETzChmzeLI5Vu8vgzFygQ9OvT4zULlsreWXLgKIN8ibDyFKmlDzC+YSJhXk
	gSPRE4MhNVRayvGaSKNnkO/gw==
X-Received: by 2002:a05:7022:4184:b0:12d:de3e:86a7 with SMTP id a92af1059eb24-131964ae31amr3759315c88.37.1778140235937;
        Thu, 07 May 2026 00:50:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:5ae0:228c:e58:7bff:fe94:34ed? ([2600:1700:5ae0:228c:e58:7bff:fe94:34ed])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13202db1914sm8372702c88.11.2026.05.07.00.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 00:50:35 -0700 (PDT)
Message-ID: <83fddb43-72ff-4176-aeac-3c65faac811e@wkennington.com>
Date: Thu, 7 May 2026 00:50:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mctp i2c: check packet length before marking flow active
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wolfram Sang <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260423001517.79219-1-william@wkennington.com>
 <61bb1b3838609996600f46ccb2c4ff89d085ee6f.camel@codeconstruct.com.au>
 <c94fc7c9-279b-4b4b-92f3-7f1b88bc0c64@wkennington.com>
 <1651e98dcc86f38a0b39679b1a6f9ef604e0812a.camel@codeconstruct.com.au>
 <0c396f24-366b-49ed-ae84-9f1982866a99@wkennington.com>
 <88cb1f245485d991b845886827876f27f11792ae.camel@codeconstruct.com.au>
Content-Language: en-US
From: "William A. Kennington III" <william@wkennington.com>
In-Reply-To: <88cb1f245485d991b845886827876f27f11792ae.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9824E4E443E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[wkennington-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wkennington-com.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wkennington.com];
	TAGGED_FROM(0.00)[bounces-285172-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william@wkennington.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


On 5/6/26 01:01, Jeremy Kerr wrote:
> Hi William,
>
>>> Just to clarify my understanding of the state: "being held by two
>>> owners" would indicate a violation of the lock itself. Or is it that
>>> there are two threads blocked waiting to acquire the mutex?
>> I think it’s actually this, 2 threads are waiting on acquiring the lock.
> OK, that's good news!
>
>> There was a theory that it was a lock underflow that allowed 2 threads
>> to acquire the lock that lead to this patch.
>>
>>> For NVMe-MI, you're likely using manual tag allocation, where the tag
>>> allocation (and hence flow state) is entirely controlled by userspace.
>>> It may be that the NVMe protocol-level errors are causing that tags to
>>> be held for long durations, perhaps?
>> Yeah, this is very plausible given the device(s) stop responding
>> correctly. I imagine we are getting stuck with manual allocations and
>> not releasing locks. Can we reset the state machine back to NEW instead
>> of holding the lock?
> Not sure what you're referring to here; if the userspace application is
> not releasing the tag, we have to keep the i2c bus locked, otherwise we
> may not receive a response from the device.

Isn't this inherently an approach asking for trouble, where a 
potentially buggy userspace can starve out other applications which need 
to access the bus. For us we have FRU devices on the that are 
periodically rescanned or accessed for various reasons alongside the 
MCTP endpoint on the NVME device.

> The one case I can think of (in upstream infrastructure, at least) is
> that this might be triggered by the device reporting a long MPRT value,
> and then a response gets lost. libnvme is respecting the MPRT, and not
> releasing the tag for that (excessive) duration.
Yeah, I'll have to look at the specific firmware bug more but I don't 
think it's been oot caused it fully yet.
> However, the tag -> i2c lock associations are only useful if you have
> muxes in the i2c topology. Is that the case on your platform? If not,
> perhaps we could elide all the bus locking when we can detect that...

We have at least 1 layer of mux before each NVME and FRU device.

> Cheers,
>
>
> Jeremy

