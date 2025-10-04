Return-Path: <netdev+bounces-227878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D8BB91B7
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 22:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B90DB4E5CDC
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9328688E;
	Sat,  4 Oct 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfOa2+43"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2861CEACB
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759609023; cv=none; b=E1sh2+xBS3GUEc21pM3A6hezJLusd1uGT8L4BUQ+7xJ005PA9C3tdPdrrYfnnvM5by70xl+jMRfdpYRcf1j5KRyNC6DLHtnyruQFslBqlo5dDswQH7lCkDKbQ+k0sV0sqJYIS81De6VHClsY9qiTv8H9E6UN5Sl3y0PPuyNkTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759609023; c=relaxed/simple;
	bh=BdFfROVCvdXRQgCvsxZzNn9MfAY3qCM9EmdjRWw7g5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvosbLJOoAu69gwn2Mj6M0Cbdu2LLFohfsp3h1Kg/NQM5JPdBFqVC8qtqnZBdjq8PWuFYlU61SAz+vWuBxfzlbRf8FK3gk0X1XLeo2fEgRUZBO8GxxALXshQTbvrUIk96y1nOIyWsp7ff7kGHO5gT9S70KXJ1WCd0Dk3UfCxmc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfOa2+43; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso28175975e9.3
        for <netdev@vger.kernel.org>; Sat, 04 Oct 2025 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759609016; x=1760213816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdFfROVCvdXRQgCvsxZzNn9MfAY3qCM9EmdjRWw7g5w=;
        b=PfOa2+43MOw7kiHsumegv6fj6sz4Wa1oSW1s5S+N69JP1YfHf3FlLZPYDU2my7XEHs
         H8bT9FoePtppM+DlUzr+6WUwrSLQVR5SjDIRGE6/z4wfm1g1QCDDYeO/5mOeSV6k8YqR
         iGuTJVAO/bIlAX9gR3fp3fWGCLgD+3tMOnx5aeNxaAHYVWl4VhMwyZFbKaALjpnQQ3R1
         8/KPPfVBEcriO5fxWtSge7PkSn0SKmM9XhLmLKnoYgSmUTmk6UIobL8tpradLSYOUeQO
         WYLlle1/8WG9OXyG39y930CdyK3REHV+odNjRvaXGcpMzSk6Xqfh8uypjxiOgGfE8pGl
         imXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759609016; x=1760213816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdFfROVCvdXRQgCvsxZzNn9MfAY3qCM9EmdjRWw7g5w=;
        b=CASQSOFtucaYIXOHCw+ROMhQLT/hyGMQBCF7WGHWQ6GiQ9CpfiDl4Vg45/Le2VkNDs
         O7ieOq0yOwA0/5zNsgGLJ2En/AlutccX6yReoumlxBXHhJcYwTT+qaTN1teZDVR2DbVU
         UhjYH9r50Ee5vO587L1AoyMdTM5C6JhKMXMb4q4KVAl/cVZlp+5mplBdVopAqmmBGbAO
         up0ny1ZTVG7c3JnOWWZ7UK4ukhIqaV6lybxqOvuiQX6WsTeark/CmM9fU9r3JIfdFpT8
         WdksIt8mMFjvXxkDBX812a+C2PnvebGWtwRBJZkhrhpBEqI6qw7otm4vS+TtJR8wdy/t
         CrTA==
X-Forwarded-Encrypted: i=1; AJvYcCUP2SYMrIJ5EJohpKNZqFiIQFuC0utbuzu3IuRF2uRo21ydB5B4Ws88BFOn7/osQGPrLNsXItg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxprELPV2BmEBVdVjPO4Tlfskd59mb1qIvZgEyn1B0uWwfura1J
	5OUaM/EzogXgUBDTk7Raiyi6sHpN05E69JTgSJW5m3kRZ1cFqZ38O5y/
X-Gm-Gg: ASbGncuslOqaoPw+V4m8wfRccyx97FXJqL3Zce9RkDv47gOOW3LkJpRWETEmi1ax5y5
	hdFFbBVZIrH6Ud6QMuZ46xOr964nIYq/O3QPbqF2Jsw5mWvEirSCy32f4Bm7RNfIqQ2cjqhm13w
	EUBsZDjFkUdUVYRSD9vLwoBoQ9hTtSp+AM9lddDRaNU7e4ONLeG/nCBS4xEV24mlTT22Nl8pMQF
	rKNg/20OP3bcStgwFPI7cI6764CxiIakBs2iSrVcuWu3gVSZ3+pfa/bnCKPvb5Af8JCaQQocs6a
	W3aepo6Pj7rAZw7Od749GY1t5LKK6PnVEARzGkwKXLmotF7agtyyQ3esoOfiyLoNLqHnVIF/rX8
	M6jPXNIfCyh7A2gPi9LKLYvcKDe0YPbfFtiPTE4NUo4CeO/DiAi0ZX0QLIKMk0HVfJPHrqUo=
X-Google-Smtp-Source: AGHT+IExe7C416OQsprj67uDRjHCi9mZ8Q6BCdRhRtkBdSEGHtuR9mrL8W8hiXPawZyrWsbQeiVQTA==
X-Received: by 2002:a05:600c:8b83:b0:46e:31c3:1442 with SMTP id 5b1f17b1804b1-46e7113ce87mr52258385e9.18.1759609015654;
        Sat, 04 Oct 2025 13:16:55 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72359e2bsm86790465e9.13.2025.10.04.13.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 13:16:55 -0700 (PDT)
Message-ID: <0d7f5ada-9e8e-4869-9daf-bf67f364b70b@gmail.com>
Date: Sat, 4 Oct 2025 22:16:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eth: fealnx: fix typo in comment
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251004125942.27095-1-benato.denis96@gmail.com>
 <20251004160858.GD3060232@horms.kernel.org>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20251004160858.GD3060232@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/4/25 18:08, Simon Horman wrote:
> On Sat, Oct 04, 2025 at 02:59:42PM +0200, Denis Benato wrote:
>> There is a typo in a comment containing "avilable":
>> replace it with "available".
>>
>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Thanks Denis,
Hello Simon,
>
> I agree this is a good change, but could you also
> fix the spelling of mutlicast in this file?
>

Sure thing! I didn't noticed it, I was fixing another driver, so I

searched for that misspell and found this, so I simply quickly changed that

without looking or touching anything else.

> Please do consider tagging patches for Networking for their target tree.
> In this case I assume net-next, as this doesn't seem to be a bugfix for net.
>
> Also, net-next is currently closed for hte merge window.
> And will reopen once v6.18-rc1 has been released, I expect on or after
> the 13th October. So please post any patches for net-next after then.
>
> See: https://docs.kernel.org/process/maintainer-netdev.html
>
Thank you for the guidance! I am pretty new to all of this.


