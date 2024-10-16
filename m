Return-Path: <netdev+bounces-136278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26809A1251
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B551C24B73
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E28C1865ED;
	Wed, 16 Oct 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlEAwMGV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926912E75
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105773; cv=none; b=qAE4vLS7tWSmUtimVVdC4c/jSjmnGvrscYSD+uYk+sb6DNXWdVIqWLmPmAgLT7pZwv3w/I40KLvT5r0lmgXa15p9IgdFOC77D4jW0nXeWq95u8YKV17zClIAnUFcJHnm8vlDv0ZwhNCWu41/IvoOaJHzMhiLEQmiATughwnzA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105773; c=relaxed/simple;
	bh=GqMYgf4N7bZf1Y6parhvCLrv1mraXWM1ryjXO+pQbxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sonCR0flLTLjH5sdipGl8B+MSIOs45ydMAiyKKObaNvZrCjnrRi6gM6nnbqZnk9pD7xVA93BkLF/qHsODoRqSvce/OZRQOhySYivunshcYlB1O2NDwmLlt/yfTpPZP7kfYzdnRbRxMbXwJergVE/H1t3CjdJVkPkTxWlmJK7XiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlEAwMGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B43C4CEC5;
	Wed, 16 Oct 2024 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105772;
	bh=GqMYgf4N7bZf1Y6parhvCLrv1mraXWM1ryjXO+pQbxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OlEAwMGV5L4/B5nZj7dMzNuA5HYATt8loS1v5YB93iXgus/CeDoe5tWZRj0Mzqest
	 MQF9567PZrUEf51W2ZlR66wHCfKn+PTsM91hFObt8SN4xzg1BxmEagMmRNi4YpMmDG
	 raRs+kBpybMk4wFngzwZW1Llq52NtqnbsZpfgY/aUhAN5dH42cO0FmfvxNZTddO/9V
	 sjmC1i5iH2OlYpcaWV9gTargNMrhOFNV3N77YDlOWqzQOdhhqQci71DxfUUu5+KW8t
	 ST910eAWgWc1YkZEFUOHt3qu/W/0yfOimTOJ5jHq27jHTjemz5bycptnzqPalM98oo
	 X9r33M086/1SA==
Message-ID: <bcc229bb-d059-4184-9d82-c013566dc51d@kernel.org>
Date: Wed, 16 Oct 2024 13:09:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 13/14] rtnetlink: Return int from
 rtnl_af_register().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
References: <20241016185357.83849-1-kuniyu@amazon.com>
 <20241016185357.83849-14-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241016185357.83849-14-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 12:53 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index d81fff93d208..2152d8cfa2dc 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2812,7 +2812,8 @@ void __init devinet_init(void)
>  	register_pernet_subsys(&devinet_ops);
>  	register_netdevice_notifier(&ip_netdev_notifier);
>  
> -	rtnl_af_register(&inet_af_ops);
> +	if (rtnl_af_register(&inet_af_ops))
> +		panic("Unable to register inet_af_ops\n");

why panic for IPv4 AF?



