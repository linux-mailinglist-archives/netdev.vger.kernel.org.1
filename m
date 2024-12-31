Return-Path: <netdev+bounces-154617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A863F9FED77
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 08:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCCD3A2C24
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACEB187872;
	Tue, 31 Dec 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="B9Ex07Og"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE126EB7D
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735630294; cv=none; b=KqW6dlNul5dushHLQsRT33p+9MrEEy5CsLzRSoWtvBdpfc3DZ3vU4oRpbcPmHFmO6ZTwkjMrC0GVO/2Ixo9c2b0NA8LaXJAQD9qQUcnuW+xDn7uPl2NLewYfTCRen8K62crtLfX0ceXQcFIgfqSpt1L48jvTXNMvG9YTK3cKdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735630294; c=relaxed/simple;
	bh=kocXQ4vX+fsyfMpu7cj2L4odexaq1pRgsS3a37FCZPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ts7ru7wDH+qToPRZz/0h4L5ci+nBs3EmMRquKipdezjMpII1vKjwX3In9CUMIAO2WFdYTGjCTCndiEAxh7wfRPmcu3isd2Xm2R5qr4XU1iy8ujL56xkdU+sTr5NYbtPQi+A3m3zZt/onMl0qOhvliD8jR+WJ6ncR2gS024XE5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=B9Ex07Og; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa67f31a858so1738938866b.2
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 23:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1735630291; x=1736235091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeVSalQ53GlGqy7ywxW1+UN+SYgePVnFipyEE8iNzLY=;
        b=B9Ex07Og40TbfgpL1KITMRL1YdLSCT4d50slIwAadXQnhibVAaJx3eR5fkQw/10/LP
         MqXIBiidZ9VY2K0qJsVz8FLKXAV70it1bxODZKGIGWjbWqUbuJDSuXZO9zV1qfj2damC
         jD+stPsFE5lOibJqa6HcP6EQ5dIprd/VUWacs5S7k1EfOrgs8/g6na5Fvskeb9daI4+k
         FIhG95WPZl7LdpE3P80R8vKYJ9dVNd01KYzeu4mMektdIauYojpKPJq0BmF5L6R3RLnC
         utN0lJ6jLcI4xX1+iDwZFlQ8DfBkcHWP1HcKAByGsP0/caBZ2nq44vhmO4oKHulIYtle
         5W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735630291; x=1736235091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeVSalQ53GlGqy7ywxW1+UN+SYgePVnFipyEE8iNzLY=;
        b=f+q+kJKEzLPh5g4g60BJNuxY0APMwfKdF8eprZOh+n8CyUcZfENUvnIEp/iSB/UhT8
         S8E0yNK7RmXx82Z/jw7FyjxV3zkJ3WaO1mEXjXtb2egYtR76GOjw8DUqpvU9bci2O9dc
         YWeDOoRGawF2QWuKYrGOjTtsZ3xLyNlCpSX3FCzz1OjY2i+reWfcmDtAI63YpEHd2q4r
         2AmJJDhqgDzVekmwtmtr1Qdq9msXyTWi2uYxpA+2WbCugfnKLtcGD2fIR4qRt0shfEJS
         3FfpppuQMYj7V/o/TM9KL6H5DhUccvmFARABX+f2WycgoOaYLu94jk2FNgH9tl/mXehp
         TD7w==
X-Gm-Message-State: AOJu0YymR27xGJngYJmu1JDJlWKS9C5GSCCOLV4qbT7IlhNRT1I+ESLj
	nZW6i08Dd+n2HEUIgXrbCbO6Ffy8dzQIrlGBywdLX828So2wK9xH1Z6Dc3uqn2o=
X-Gm-Gg: ASbGnctxb0SHlSfNlh/Iz0S0ZghbD/S51BbS5BJ5e1XsMXutsG3VU5s0sx4He4i4auy
	TYb6ST21B6RUm3f2m+7rBsJhFBdWJBeqIx83yd1WDneqPTaZqb0SfyZijTAj8XcFAix6m1fT3BU
	jMN7L39ThqcyFwLFqsAdY2MBXVTUHJyDZfEUgS6rqzG1//nr3g2ssgePgPGydcCf1i3bWUt0Kit
	U04WHMAtV9kf4yXOHxg3t6Fui2erdVxT0/pYGV7TVm+6kIMerOmF48FYaflO1rq9w==
X-Google-Smtp-Source: AGHT+IHixdQps3Wsr2NFRaJfLKeVKOF4fumaMfhFlnKa/4hFejpWrGXeJUEKHnsQKRjjxtjT5Q2Raw==
X-Received: by 2002:a17:907:7f8e:b0:aa6:9198:75a2 with SMTP id a640c23a62f3a-aac334e51afmr3388350766b.44.1735630290965;
        Mon, 30 Dec 2024 23:31:30 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1000::1001? ([2001:67c:2fbc:1000::1001])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaf57c2e24esm246326566b.205.2024.12.30.23.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 23:31:29 -0800 (PST)
Message-ID: <12b0dab0-600b-4d0b-8b0c-881d92d8ae7c@openvpn.net>
Date: Tue, 31 Dec 2024 08:31:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 06/26] kref/refcount: implement
 kref_put_sock()
To: Will Deacon <will@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
 <20241219-b4-ovpn-v16-6-3e3001153683@openvpn.net>
 <20241219172040.GA25368@willie-the-truck>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
In-Reply-To: <20241219172040.GA25368@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Will,

Thanks a lot for chiming in and sorry for the delay.
See below.

On 19/12/24 18:20, Will Deacon wrote:
[...]
>> +/**
>> + * refcount_dec_and_lock_sock - return holding locked sock if able to decrement
>> + *				refcount to 0
>> + * @r: the refcount
>> + * @sock: the sock to be locked
>> + *
>> + * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
>> + * decrement when saturated at REFCOUNT_SATURATED.
>> + *
>> + * Provides release memory ordering, such that prior loads and stores are done
>> + * before, and provides a control dependency such that free() must come after.
>> + * See the comment on top.
>> + *
>> + * Return: true and hold sock if able to decrement refcount to 0, false
>> + *	   otherwise
>> + */
>> +bool refcount_dec_and_lock_sock(refcount_t *r, struct sock *sock)
>> +{
>> +	if (refcount_dec_not_one(r))
>> +		return false;
>> +
>> +	bh_lock_sock(sock);
>> +	if (!refcount_dec_and_test(r)) {
>> +		bh_unlock_sock(sock);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(refcount_dec_and_lock_sock);
> 
> It feels a little out-of-place to me having socket-specific functions in
> lib/refcount.c. I'd suggest sticking this somewhere else _or_ maybe we
> could generate this pattern of code:
> 
> #define REFCOUNT_DEC_AND_LOCKNAME(lockname, locktype, lock, unlock)	\
> static __always_inline							\
> bool refcount_dec_and_lock_##lockname(refcount_t *r, locktype *l)	\
> {									\
> 	...
> 
> inside a generator macro in refcount.h, like we do for seqlocks in
> linux/seqlock.h. The downside of that is the cost of inlining.

Does your suggestion imply that I should convert already existing 
functions to this macro?
In that case I believe the change would be too invasive and other devs 
may not like the inlining, as you pointed out.

Secondly, I thought about moving this function to net/core/sock.c, but 
if you look at it, its logic is mostly about refcounting, with a little 
touch of sock. Hence, sock.c (or any other net file) does not seem 
appropriate either.

I guess for the time being it is more convenient to keep this function, 
and is kref counterpart, inside 'ovpn'.
They can be moved to better spots once they gained another user.

Best Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


