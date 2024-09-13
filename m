Return-Path: <netdev+bounces-128060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DEE977C00
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E01F2735B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD131D6C68;
	Fri, 13 Sep 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="hcW6oCG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72118A6D6
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218938; cv=none; b=FzmHLW3gnpQ3Oh9EQu50Vjd1YotKX1o8Y1ZvHRfRsK0qcBrWBas+s+9rcLF+cvdAWBwkK9WdBJtiEQ7p0Rpb+Lsi1XWwdQuLLcD4eJ5IDUdp6rd7YJJ7C9KP7DSsajiBJElcMOM3SzkSQjqsDReKIZf4vmCouhD3ylWQbWWdASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218938; c=relaxed/simple;
	bh=yjxj0FSJpzDqTDqbkb+Ys5lDxT533fcsCSKxOxLDXqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czNilRDgTFjEKZcI4ETJB5mb7c6LxmMQbVa3LzjeSuCwcOIi8WkU5MiLuJsVoS0+NDBptgYyGXnbNI4AEWuEdshkwWG7aTK7u1WTNWUpTi1uoDCgPwouhNkiH1K+kEK2bFZ2Efj2pAS0TynaJmy8rkIK6GmyKR2l0ciCKnDMNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=hcW6oCG7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so2478740a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726218935; x=1726823735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zP7o2lXiLqDCW/l4Y6N12juw+Nevs/iHS84Bz9Lspa0=;
        b=hcW6oCG7UsWg8lqj1SfpbfEYgFYHzvc8MRSQFB/afVCmLbLYKL3MiCqkl0d2emVWYd
         nvRqV4ojd/+Jau6JFuxvGJQ/zAcn/TBhb30ud/kQU0eMb7Syuge/REB/v+24vztNWFQf
         oPaCyMD344Upcg6J8Hz/T0hGkfk0G423DJ6z3OEjZkU+UGNtPTgX8MxtjITkyWu8OByq
         ZJSitXmGPA08O1Z+lpNt3Qfkew2x93D1PmszK16drxktOqGBp3kKx4CzlqY/3o44X35c
         deotYhfUvTwHgmYn3VNqPtXGtRdfKuFoA6b/7OJ1O/aWJcJRNKrPSx1mVk/UtVnhEOF2
         eB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218935; x=1726823735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP7o2lXiLqDCW/l4Y6N12juw+Nevs/iHS84Bz9Lspa0=;
        b=kspf40GYfPg9mWU7xvA6YUdfvidWOAz1LOkf0Adp1rFCCNsA5B7BTiY3E29W92TdDp
         HooSx3MRCIQaGd23nWEqWdV3EetUoHPEz1Idn/zaE7/7Y1ew81YwVYqhIxrfOLHHBaYa
         bRbXzvRRMwvNdhpxNB2ElrBWvUW4EInqT/KGT/69hokq6Wm66DfPziEJgoS8+5ffL5FV
         0ILSoFtOgLuPUkbZWogiue6nyq8TmLvuIunixrMqIzeFSjd5iIQ0ocPCLdbKmyGTuz/D
         9XR2UElFUodwDlyAfdZdO/cGlc2xLNgUEJSk4zMHGvfT0OGt4ZOcjYsu21DDacTV/afJ
         GP6A==
X-Forwarded-Encrypted: i=1; AJvYcCWGm2kdnWlxehSVrByglbhx4J5neUp89KRQbE4lH4+U1SSfUji5jrtQuKLCae0zXb7BQWeCa9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOTeD8xBusgnlN8hnsTngWGG5yyOKt4VwZIZa/t1eSlEwTPJ6
	jEroz13e8rFHupmmg28OUvrMbWCTAPD3sohp08ozJKF2kMs+mm/FtBQDKq9zktc=
X-Google-Smtp-Source: AGHT+IFVFni4KQY31tZpsekaGm1UaBb7ZpdiuaYbjs6baOy/7SSOoWK2lsopYFzaF0hFcAvrJOrKow==
X-Received: by 2002:a17:907:3e1d:b0:a83:8591:7505 with SMTP id a640c23a62f3a-a902966f459mr584642266b.59.1726218933949;
        Fri, 13 Sep 2024 02:15:33 -0700 (PDT)
Received: from [192.168.0.148] ([93.93.8.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e9asm849536866b.115.2024.09.13.02.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 02:15:33 -0700 (PDT)
Message-ID: <8cf0b25f-2b7f-478e-af14-b0ebd5905a79@blackwall.org>
Date: Fri, 13 Sep 2024 12:15:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netkit: Assign missing bpf_net_context
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: vadim.fedorenko@linux.dev, andrii@kernel.org,
 "open list:BPF [NETKIT] (BPF-programmable network device)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240912155620.1334587-1-leitao@debian.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240912155620.1334587-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/24 18:56, Breno Leitao wrote:
> During the introduction of struct bpf_net_context handling for
> XDP-redirect, the netkit driver has been missed, which also requires it
> because NETKIT_REDIRECT invokes skb_do_redirect() which is accessing the
> per-CPU variables. Otherwise we see the following crash:
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000038
> 	bpf_redirect()
> 	netkit_xmit()
> 	dev_hard_start_xmit()
> 
> Set the bpf_net_context before invoking netkit_xmit() program within the
> netkit driver.
> 
> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/net/netkit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



