Return-Path: <netdev+bounces-64403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FEC832F06
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 19:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE411F2670E
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C223C6BA;
	Fri, 19 Jan 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BTNVVvKV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF2537F4
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689558; cv=none; b=oJvfxOxuKjTeMZE3pwq6+1+UMOEPd8QBuqzM+7typIReDtVXhrC3C93jOnkGEIZodHWtAYgPvioW1a4C4AaZS790LMq/iXIkaOPsmP4pk5tK7qyvbGgVuuOWfDbdJkaIgb+JqIlTpCQy3p1k2uLkl40nyg9p5TqSzSKPAmKOjoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689558; c=relaxed/simple;
	bh=iwCxCVOR4jnaYfbcOzF5/VStJ4/WlUg5Op4I2ZEX0bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMWl0aqVddAVG1uuYYlA14GK0sFxiTlTin0Qmm0UOcbSz1OumAdA0jYOklyLk54ig/yx1b6plRDDbe0O1y7S2b0Ra/rOsl2Q6y4ZQhRw+J4pjmj2fXt8vakpPa58KopTYocOr1jnjZiNZ08JGDB4dDmu1EAVPOqDrIBnQ82lu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=BTNVVvKV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e9d288f45so11298195e9.2
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 10:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705689555; x=1706294355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLVqtZB7ksYYlMI57Z8Vk1wj7Ou0Yg42oFkvW8eSN7U=;
        b=BTNVVvKVnnwZIO1rjg07S7czlWYeL1yUKJCYkH2ziKdFdj/IO6WrpUoIsGSIZjCnis
         kaMvYNSDNsWItqRQe8TzrpR194F5aNlCrrDMX3AqOQn5uduLSasgpab38FSk/OMELWvW
         1Ny467Q2LwfY9SAqxXygCtBnl6Ezp3mU1Wd+eD/8yr2PXNLOfHKp9CcTHKDsCdacySfs
         DnpQKdn6eXluVlE1QM1RQN3GZjobZHAQDgIQBzrTHpED+4n+w8DRnIUXwTjgCIo+xMRl
         bGP1Gg7sQ8dlm9yCY4h2MUAT37EgMla28r9tFBtuRP2zPVvsMTv/wDSk207d5fVyHFJN
         xc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705689555; x=1706294355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLVqtZB7ksYYlMI57Z8Vk1wj7Ou0Yg42oFkvW8eSN7U=;
        b=m7KevHnHKbSu57sZ2c6m49JQLkxtJhY7vVwAOvolJ8UnPODtEFs2i+gaJQCYIGH3qX
         vl55ot5x1SOWFezF1NmahFo42loe7VGiXnsujW6Arz1LTguN8M+XZzyfE1jmStn3OHp+
         QUO0sVE2PibSnCAbiQ00milz85my5ZsYLorNc8CO3cE/iC/vqXb7eZ7iRlH1QGbz1H59
         awswyp8zbFhPwaJv1V5HB4UURGYjhwSafiCmnf+Wg9rR8eA8gKJaNpiUbX0oy9bYa+2g
         T7y3nCxxCNxM8vmb88v3nDXLzCf0mBYzFrRxRBrEqZYxeqMucVAPM+qFZgtHMbCcmlWx
         1K8A==
X-Gm-Message-State: AOJu0YxliAQzBTDGdbNAZITUCZhxQDR6E4VfKs6cSTXOvMAW21DcY0LF
	IoNeOveEa+gUGi4H1geXakT2pU0D6lYbfMEXEo4B1FkbsiQD/OlXWXGuqO4tWw==
X-Google-Smtp-Source: AGHT+IHkkqi0sUUubDAyF8otPSakjzR/c2b01NQkAkzs0OiKsZp5Af3JwmWc9wV2g7ywhLc+hABc3Q==
X-Received: by 2002:a05:600c:15c3:b0:40d:3afc:9263 with SMTP id v3-20020a05600c15c300b0040d3afc9263mr77497wmf.104.1705689555259;
        Fri, 19 Jan 2024 10:39:15 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040e5951f199sm29697280wmq.34.2024.01.19.10.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:39:14 -0800 (PST)
Message-ID: <a9a5378d-c908-4a83-a63d-3e9928733a3d@arista.com>
Date: Fri, 19 Jan 2024 18:39:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118085129.6313054b@kernel.org>
 <358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
 <20240118091327.173f3cb0@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240118091327.173f3cb0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 17:13, Jakub Kicinski wrote:
> On Thu, 18 Jan 2024 17:04:25 +0000 Dmitry Safonov wrote:
>>> Somewhat unrelated to these fixes but related to the tcp_ao selftests
>>> in general - could you please also add a config file so that it's
>>> easy to build a minimal kernel for running the tests?
>>>
>>> Something like:
>>>
>>>   make defconfig
>>>   make kvm_guest.config
>>>   make tools/testing/selftests/net/tcp_ao/config  
>>
>> Yep, sounds good to me.
>> I'll take as a base tools/testing/selftests/net/config and add any
>> needed config options on the top.
> 
> You probably want something smaller to be honest.
> tools/testing/selftests/net/config has a lot of stuff in it 
> and it's actually missing a lot more. I'm working thru adding
> the missing options to tools/testing/selftests/net/config 
> right now so far I got:

Thanks!

I'll send a patch for it in version 2 (as I anyway need to address
Simon's feedback).

> 
> # tun / tap
> +CONFIG_TUN=y
> +CONFIG_MACVLAN=y
> +CONFIG_MACVTAP=y
> +CONFIG_NET_SCH_FQ_CODEL=m
> +# l2tp
> +CONFIG_L2TP=m
> +CONFIG_L2TP_V3=y
> +CONFIG_L2TP_IP=m
> +CONFIG_L2TP_ETH=m
> +# sctp-vrf (need SCTP_DIAG to appear)
> +CONFIG_INET_DIAG=y
> +# txtimestamp
> +CONFIG_NET_CLS_U32=m
> +# test-vxlan-mdb-sh etc.
> +CONFIG_BRIDGE_VLAN_FILTERING=y
> +# gre_gso.sh etc.
> +CONFIG_NET_IPGRE_DEMUX=m
> +CONFIG_IP_GRE=m
> +CONFIG_IPV6_GRE=m
> +# ./srv6_end_dt*_l3vpn_test.sh
> +CONFIG_IPV6_SEG6_LWTUNNEL=y
> +# local port something..
> +CONFIG_MPTCP=y
> +# fib_test.sh
> +CONFIG_NET_CLS_BASIC=m

Thanks,
            Dmitry


