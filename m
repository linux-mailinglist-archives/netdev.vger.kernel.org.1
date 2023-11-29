Return-Path: <netdev+bounces-52177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAB77FDBBA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD0D282891
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891238F86;
	Wed, 29 Nov 2023 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Qu+XOJqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93808D7F
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:42:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b552deba0so4850665e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701272529; x=1701877329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAAXjfMF22wmNcQ+s0IdrozkzcalgKiO4M1qR7njTVA=;
        b=Qu+XOJqtH2wUCFR346HMDrgW5TYqA6wK9HntzV2tp0ytB3Ix5wbF6is+znjSyAPS8o
         yef3Mqon+uSMjf4KzOh9gQdp0HeHHkwHgQ8AaqUBl74OkLMEC4PxqIEU9mhGYwPDlGHP
         BoLh5DxI3KZW8mxOPQ8AJFjB4+iMdYjDrVzftOogXWm2Ua+zOFsHjLVU95JrD9vkXxPK
         cC2VE3zNkAh1KpeOgWoTyybz+lX0leOHeGRrDOUmgfBdq06cp6PmwZjNF3g0J9wUX8wl
         UNcuRScP4U4qD4OJWO2bM3WlLEU44FBa18IfjrI/MyfJiDfj8uQ6+lwWs1MzQ2AnavLJ
         T1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272529; x=1701877329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAAXjfMF22wmNcQ+s0IdrozkzcalgKiO4M1qR7njTVA=;
        b=Pj6fwQJWNwceHsllinr1pT0xQyFREIBjgIx/zoLjBCBHUm5abiDwQOSFAzjSsee88Q
         r9VgW5fWryFGnLcGz22svBf2Hq8KO51PcNEq/rVAarui15ZOgAAGhBooZyo2Nn0nQTSi
         o52gKCpCD1zvd5bLuQU2Bw+fnZruf8qHov7pTfLjjdGbfMKJw4lLDBOGmfeVQlJTI35q
         9r4yeZcRv2PAcZNsAE137cFzuvAXmmv+mKhAnKlGy+oblpfPLXRIB/0lpzRmuVyEft68
         gtR8jZtdLOQNE9QKxXH0TybLvuYS44qiOmT0oo+/dprZtVr3JDWwr1KQE066g6d1rXYS
         8btQ==
X-Gm-Message-State: AOJu0YyAk3jYHZAbl8wi7nsiyc99twct/CxV6vzq0EZWAdMk/oCZT/bH
	g0tZkjXdOCipIydp8q+CZWq0+g==
X-Google-Smtp-Source: AGHT+IH4TzrRfDgsZod0caVz5r8wR1GQWm/j6x+x3almVBQZsjsddYvc+zPovzCXLzvr/SkYpPf2cg==
X-Received: by 2002:a05:600c:4e8b:b0:40b:4c1a:f5b2 with SMTP id f11-20020a05600c4e8b00b0040b4c1af5b2mr4370574wmq.35.1701272528922;
        Wed, 29 Nov 2023 07:42:08 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000194a00b003330b139fa5sm5316980wry.30.2023.11.29.07.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:42:08 -0800 (PST)
Message-ID: <30fe685f-d09b-48b7-840d-9d19d6c183db@arista.com>
Date: Wed, 29 Nov 2023 15:42:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] net/tcp: Don't add key with non-matching VRF on
 connected sockets
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20231128205749.312759-1-dima@arista.com>
 <20231128205749.312759-6-dima@arista.com>
 <eb9a46a5-d074-445a-9e18-514ef78395d7@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <eb9a46a5-d074-445a-9e18-514ef78395d7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 11/29/23 01:34, David Ahern wrote:
> On 11/28/23 1:57 PM, Dmitry Safonov wrote:
>> If the connection was established, don't allow adding TCP-AO keys that
>> don't match the peer. Currently, there are checks for ip-address
>> matching, but L3 index check is missing. Add it to restrict userspace
> 
> you say L3 index check is missing - add it. yet ...
> 
>> shooting itself somewhere.
>>
>> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  net/ipv4/tcp_ao.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
>> index bf41be6d4721..2d000e275ce7 100644
>> --- a/net/ipv4/tcp_ao.c
>> +++ b/net/ipv4/tcp_ao.c
>> @@ -1608,6 +1608,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
>>  		if (!dev || !l3index)
>>  			return -EINVAL;
>>  
>> +		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
>> +			return -EINVAL;
> 
> ... this is checking socket state.

Right you are, it should have been under check for
: if (bound_dev_if != cmd.ifindex)

Currently it's warning for all sockets (which can be re-bound), but for
sockets in the connected state it doesn't make sense as the key lookup
is not expecting non peer-matching key post connect()/accept().

In this patch version the check will restrict adding a key on a
connected socket with VRF regardless if it's matching the bound VRF.
Will fix!

Thanks for spotting this,
             Dmitry


