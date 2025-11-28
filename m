Return-Path: <netdev+bounces-242593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5CC9262B
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C494534B7E3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E13329C7F;
	Fri, 28 Nov 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cr4oPQ4a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BahnnhJ0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8132ED3D
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342115; cv=none; b=ArpQwJDUrbrjQxZ7Gb3MG1evMTmbAhB896RqbNA2j4LgJLr8ciOFucl7xtfvXELP8uXRvp71NF+i0WfE/OBcvqccks8/37PpnpD+enRGlayhFbEYmL+Jb8bOFshUwGLvA9upiExoOKk2Qr24lxSFi1tohC/N61R0lume4LPy+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342115; c=relaxed/simple;
	bh=KDs3ep7CXasOuqiuJKR8FpJdCxKw98JqC8dJhvClga4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTyouuHzmnrgZDioVkkufK+D8Et6bHPjVbi2eX0/rzvhe6G2DGNBZGoCizgqr4M+a8/UicrElvWh8tWbhwm07qJrU8W4W1BAlwSewZQhwBC8dEyfAl0mTB9Zd7+0DRf0H0gYpnCXFkv9kuPFYTGXpHxVp7mc+Kv7XUsXLn361sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cr4oPQ4a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BahnnhJ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764342113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/pQqBAPq3vU8DBviKSh7Ys6+IvHfB+6QxuWYuBevTs=;
	b=Cr4oPQ4aAlQJFGKmzeuCB8AO6Nu2Jz2qR2j/td0+zKF4MhqfEg5tdThFm0L6b2ACAbbZdB
	5Hpwk6mgw9YTFwRiGdY70ljG1quNLqXm/+751cWhxsYDbnNkP1VuG6IA65arIZqJ3KwgCm
	F01m2BT8V8bvfo/r+o2gKxVBCV88gl0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-Vr22IJxBP4K1Xc3bpbYG9Q-1; Fri, 28 Nov 2025 10:01:51 -0500
X-MC-Unique: Vr22IJxBP4K1Xc3bpbYG9Q-1
X-Mimecast-MFC-AGG-ID: Vr22IJxBP4K1Xc3bpbYG9Q_1764342110
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779981523fso15317725e9.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 07:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764342110; x=1764946910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/pQqBAPq3vU8DBviKSh7Ys6+IvHfB+6QxuWYuBevTs=;
        b=BahnnhJ0ETxkxT93hZfe1C+5RMW2lRIY0A+VuijsQusYdsdwWT0ciZGCZ5kuhQbIge
         /Fyt3WvID8bLUxSCchOnbmF8P2xkFt0dJQVXshDovetnrf/TmSP3c+6Gm+POZkpA3cOF
         DFAMA9G+ezf+WUPiekKhl2g4TZFISBiQmF8D+O9k7733M0XCoA/rGiUSYhYW8PerQkM7
         bahAXA+T8khPWuTTWWopE9rPhdXQytxK4IMM5SnPJtsA15URX2P31Auwv5hq4slTuRWk
         U0agYgw7oqkeE6yF7d5v7qBsZqTST0V12JlJSxouYpYf7METvw0HxccJwOwDTOZLh2G7
         o0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764342110; x=1764946910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/pQqBAPq3vU8DBviKSh7Ys6+IvHfB+6QxuWYuBevTs=;
        b=SPi8yw9qa9KOCmtJATecOSt2ldvPLMCbeT68s0VvkI+orguqvTTaiV/LdR4jegsFCY
         IdQgEtUiBmF69GsKknqxWl+amCNMrpL8vJswFAIDnmsA1BwoPnUVIoaEkT9v2i8roJ1x
         O0XS7+VUydK7D5VRRSVUlEa9EmkhvHwAcq8yFoldgIOagxkuVb70uk1fBaAm5+J0bDXT
         +hDTMQgQtvl0stojG92KD4VxBi5/z5Wq9B02G2cUtgu7yOCU5Ujy0fBZpgQK5qsmAdUU
         3qH7i5DDHkUaTR0IL5Iu7xni9MkdpT8QrveZyWErNq+fINZNu/Ob/C+XqMsPG4aMEQOB
         oAew==
X-Forwarded-Encrypted: i=1; AJvYcCUwz5AtTceoqJDLBGN30yykhkTf5lFVbLbtzSY3l/JW+qPhdUgOWCKqh1DDSG540wZWe6QNiDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkk8O/ldoLIAsxEJxMfLjbUWRYO5fYOUMjFHIIuAqUk6FrkFov
	uwlinU+xAmrT5N1ANdL5zXv5kKoMS3aTvImRIUfOhObsceQNKc1nv7tzg70uuLUi2a4DiJ+xNUg
	2EpQqRZk1yySRFHz9uGWpAYArxn3nvmNxTQqZuzZGNShYVT7/+HB1Hbyfaw==
X-Gm-Gg: ASbGncvGK542ykqa7djU87B1mR2lIsxzWy9PFRJ5JpMTmeyCAhusH3Nr34NtUFUtqN0
	kHrHqIUfxWFYzH5QqvDBOsHNeDckfvgcedJrxADoqGeArgoUIN0/02Q/m0LdhfgAKrzgpdVe9M/
	EuBknDMuHyA0bJ9w1dQLPudEL4nV+JKrX9fARThCBmqniu0JlmYN3iw1nk8wwdFULpJw64yRths
	LLz/d/oH8t1FQ/koLlYJql0wEPdobyc0XerJdZnoROfeAKoEF0RKoywoFn6uZlB7Mf+Z8AsAsvQ
	IdOQg4Zz/fbyaLWqwSnuuUS7YdQUFrOV0/rZQ06MwPapPHch0tned6oOEMTUpFY14YFL+rC6T3m
	1rwj5BysFHngLIQ==
X-Received: by 2002:a05:600c:4f82:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-477c111605cmr244812065e9.20.1764342110387;
        Fri, 28 Nov 2025 07:01:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEXctpRi0LI8K7QlBMNmqZNl2CfdTtmWNQ5kuKkOwn1Ip8BOqLNpFfWU19g8Z/qfbvzj0F3g==
X-Received: by 2002:a05:600c:4f82:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-477c111605cmr244811615e9.20.1764342109897;
        Fri, 28 Nov 2025 07:01:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3016sm10367039f8f.1.2025.11.28.07.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 07:01:49 -0800 (PST)
Message-ID: <ad0fedfd-e25b-4054-aabf-ebac46dbbcd1@redhat.com>
Date: Fri, 28 Nov 2025 16:01:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tls: check return value of
 strp_load_anchor_with_queue
To: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Hui Zhu <zhuhui@kylinos.cn>
References: <ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 1:55 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In tls_strp_load_anchor_with_queue(), when first is null, strp->anchor is
> not successfully initialized. Accessing strp->anchor afterward will result
> in a memory access error (for example, BUG: KASAN: slab-use-after-free in
> skb_copy_bits).

tls_strp_load_anchor_with_queue() has:

	WARN_ON_ONCE(!first)

and AFAICS all the tls_strp_load_anchor_with_queue() call sites ensure
that the receive queue is not empty before invoking such function.

Hitting the above condition is a symtom of a prior issue that must be
identified and fixed. Please try to solve such problem instead.

/P


