Return-Path: <netdev+bounces-183762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BD1A91D94
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86377AADDC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED40213E41A;
	Thu, 17 Apr 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho3gNK6F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D22F24
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895835; cv=none; b=kQnghdau9VwltRViJ01nl5tYMCwvHzoDszWf5FIVnBNnlrGldYKf8aB7eq1hD9nwO+qoOUJgzdni52KdsLYQMCdVIeBqINCnn/bblSDTV5sQ8htnMc0+/0D6hL5NFQQ46DoZIQHFwCeQeSNWQb4vPHxO6/pIIDNWnDUw6mbr2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895835; c=relaxed/simple;
	bh=w1gNiTdtro19oJd8N1VuhyxJwViS9e9fOs1UAKkND3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=com9WHsAVAYqOW6wLclkFksMiVsjHCNFxSXIlZFj9CWQkUgmtLeDm4GYw17fk+4gAQjjgcDsBGu3Wb0+ugob/+bnBuTb+dnkZZVr+wZ0aOpQ+tLPJcJf7XsdUCzcJGWBTFucqBiZShJjNTUys/amekvtqgWc1/RgLUxQj3UCkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ho3gNK6F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744895833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhyHByvuNmnkzLLWMwyPda0e7IshL4F1qmQONxtFvxA=;
	b=ho3gNK6F1OqnXZyyO18x8/iPiQKezVZVlUsGitHGqjXuvDQupUVI1RDovHIZQv7YOR5wtz
	v8CfyrDB48ho3uXQOvSgxbLBuiAlg4TojIdq0MO8XpIcnfBvA20D0X21liXJ3iKzOzH5dL
	mUDSy2Q98zpW4zqcQfCQ9GxXAWA/G+g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-G3F1mPfgPgSyu01t_UAo-g-1; Thu, 17 Apr 2025 09:17:10 -0400
X-MC-Unique: G3F1mPfgPgSyu01t_UAo-g-1
X-Mimecast-MFC-AGG-ID: G3F1mPfgPgSyu01t_UAo-g_1744895830
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ed0526b507so12209116d6.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 06:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744895830; x=1745500630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhyHByvuNmnkzLLWMwyPda0e7IshL4F1qmQONxtFvxA=;
        b=fL8gkvzVb4ii1sMH61FoLTWAYaMGBxbntx9UQF9PbBa7ZM32+hHzbnmO3fl5yf0h1x
         qXzpFgiQoZ6CQDXzlqaWEELNdM6dMDPyNjJWJRd2Qi0cb/AleBHx1/Hi6OUsFvE7UHJ0
         G0RWPFoju+9mJShm5FMmsO/0Pnae9u8orOI3XjhA0NscMBYql7SZuweRnI+FY1aBJwqF
         eAyy+4va7Gs71TvkhAXA7YY/Wi4AaHR3v1m64id5409pFyh+GKYt66qFVqAlSkywd0Ds
         wzuKMuOlhNkYFuImpWKQN8HNVXJYprRMnnESMnxStolWaRFu/ZkMZDqOc8IUFD/XpzSi
         zieg==
X-Forwarded-Encrypted: i=1; AJvYcCVgibMKa34SVv2ZL8VIu7O2GnYCBfPp36wi00xHNzIWFS1VsaCreMRKvQk5CbpHcXHJfB8xOc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLueLfWqJdgcGE0g/PBtBslr96nVlQ8ZGu1/O54/+AkZ1M7Ht
	CDkdAKMSQTzAQ3nZgfhUI3+1newfHcPvBhtBiIqZh+iLj9L1PBLFvwH38zFlI1+ldE38LcGMt2T
	HBqfDqDc0h42ruIwvqf40E9aV1cvhCOBiKL6W1HKwW27gLEDIuaIPQg==
X-Gm-Gg: ASbGncvurs/tzuhzHmWQEuJgiEIfCF0iRzJ5ykczA7knDgJWqOCIRKOsGzecvPL9TNK
	/cBG09ENx6O4iiXhVgOK1lnTsL4KhYv273GU9o8KZaQewYFZuGZByGL1rok3AZyJcfAZLReK0Rx
	tXQw/renaHASHGfzFLgsS+s4eMYm+CgTT73/7vXE5/3XC4VSO2diEIqpuko+CQhLudkYADEkb8Z
	nP7I0YEJxtfggRuy0LLbaTfUhzB2Ecijn7FFKKBGrw2DJHUyvyuEXbOtE2umsKMNNtYMLJ5RZra
	aa+FN9RK7BrUWY0wQZXtsRaqVTK91jUivaRRuZzvxw==
X-Received: by 2002:a05:6214:238b:b0:6e8:efd0:2dad with SMTP id 6a1803df08f44-6f2b2f4290amr78455866d6.12.1744895829929;
        Thu, 17 Apr 2025 06:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAmv1LbYEq+ryV1sjdA7s1b6xi/JjBxP7J1Dpv+giy9IaehE8vpbhOIDRrQSohSJsu2RT5dQ==
X-Received: by 2002:a05:6214:238b:b0:6e8:efd0:2dad with SMTP id 6a1803df08f44-6f2b2f4290amr78455536d6.12.1744895829629;
        Thu, 17 Apr 2025 06:17:09 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de973221sm126961266d6.42.2025.04.17.06.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 06:17:09 -0700 (PDT)
Message-ID: <0f67e414-d39a-4b71-9c9e-7dc027cc4ac3@redhat.com>
Date: Thu, 17 Apr 2025 15:17:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
To: Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 yonghong.song@linux.dev, song@kernel.org, kernel-team@meta.com
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
 <aADnW6G4X2GScQIF@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aADnW6G4X2GScQIF@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 1:34 PM, Breno Leitao wrote:
> On Thu, Apr 17, 2025 at 08:57:24AM +0200, Paolo Abeni wrote:
>> On 4/16/25 9:23 PM, Breno Leitao wrote:
>>> Add a lightweight tracepoint to monitor UDP send message operations,
>>> similar to the recently introduced tcp_sendmsg_locked() trace event in
>>> commit 0f08335ade712 ("trace: tcp: Add tracepoint for
>>> tcp_sendmsg_locked()")
>>
>> Why is it needed? what would add on top of a plain perf probe, which
>> will be always available for such function with such argument, as the
>> function can't be inlined?
> 
> Why this function can't be inlined? 

Because the kernel need to be able find a pointer to it:

	.sendmsg		= udp_sendmsg,

I'll be really curious to learn how the compiler could inline that.

/P


