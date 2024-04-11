Return-Path: <netdev+bounces-87175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CFE8A1FB1
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ACC1C23DA2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D01117741;
	Thu, 11 Apr 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr7/mO5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98F1773D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864745; cv=none; b=uJGBvxwZZXQgYTE4kFdeEkWh7Yc0Lf5grQFhugBiZo/2bLSdVEIRc8RZvMPvyPmBXdiKWSy7BdgnaKHK4rtjvSXg+yTI7b6w81DtrW1r6mhSGIZCKjQTIALrJ6K/ZB2ss3fBKgmrztYOKUunZAqUzE/kQ/F+UsrOEdpp+deBWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864745; c=relaxed/simple;
	bh=qu6ATuBQ5RJ+YNXVcT3r3GYo/IDRB1BLTVbuieK7UKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBS8U5Nc0paN+UrTk2b1JDFU+xhCMm7wocBIbsDy2MZW7yRgG7sMIvH+sLc60c3GISUdPvyD0Q6AnB4PUslPqZs2Em5Rgr9e161E0T4L5jqTKWz2GtMHDCqMQ2D1BlgPkxeyPk9bsM0kZUMTtSRxuAmhdoSWNQnl3+MAg/mFiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr7/mO5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3F5C2BD10;
	Thu, 11 Apr 2024 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712864744;
	bh=qu6ATuBQ5RJ+YNXVcT3r3GYo/IDRB1BLTVbuieK7UKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kr7/mO5+UO3MFJ1SMERDUt3f5DoSyDI8K9ht7PHw4VP+SPG7ZDaPrGA1uLE/PXaAV
	 QAcD0nlDyRNRHS8y78TrxzJb9OVha4oPzlUUf7ntEtmbDOrbMGeNTNcY3rnPXzB8U1
	 E9nJe+h4R0zsBVwUgF1KKBE4s2G4UEZ2PygxMNicIovUEA/lssD89xYNdLWfjHAWzW
	 TAREh4lxYTAZLqY7rbYBNIk8DlYqgByII8Xpgx340Rb1t6atUlZ63zU7cszkhPKVzt
	 nkOcKWyeSjv9DQJS0WrJognrcZMq9K7h7BrI1X1fwsE3PScyCjtTBNZbTYQXtC+51G
	 AwjnB9kBraacA==
Message-ID: <b4e24c74-0613-48be-9056-a931f7d9a772@kernel.org>
Date: Thu, 11 Apr 2024 13:45:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Stefano Brivio <sbrivio@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 donald.hunter@gmail.com
References: <20240411180202.399246-1-kuba@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240411180202.399246-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 12:02 PM, Jakub Kicinski wrote:
> Commit under Fixes optimized the number of recv() calls
> needed during RTM_GETROUTE dumps, but we got multiple
> reports of applications hanging on recv() calls.
> Applications expect that a route dump will be terminated
> with a recv() reading an individual NLM_DONE message.
> 
> Coalescing NLM_DONE is perfectly legal in netlink,
> but even tho reporters fixed the code in respective
> projects, chances are it will take time for those
> applications to get updated. So revert to old behavior
> (for now)?
> 
> Old kernel (5.19):
> 
>  $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
>             --dump getroute --json '{"rtm-family": 2}'
>  Recv: read 692 bytes, 11 messages
>    nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
>  ...
>    nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
>  Recv: read 20 bytes, 1 messages
>    nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
> 
> Before (6.9-rc2):
> 
>  $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
>             --dump getroute --json '{"rtm-family": 2}'
>  Recv: read 712 bytes, 12 messages
>    nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
>  ...
>    nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
>    nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
> 
> After:
> 
>  $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
>             --dump getroute --json '{"rtm-family": 2}'
>  Recv: read 692 bytes, 11 messages
>    nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
>  ...
>    nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
>  Recv: read 20 bytes, 1 messages
>    nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
> 
> Reported-by: Stefano Brivio <sbrivio@redhat.com>
> Link: https://lore.kernel.org/all/20240315124808.033ff58d@elisabeth
> Reported-by: Ilya Maximets <i.maximets@ovn.org>
> Link: https://lore.kernel.org/all/02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org
> Fixes: 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU protection")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> CC: donald.hunter@gmail.com
> ---
>  net/ipv4/fib_frontend.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> index 48741352a88a..c484b1c0fc00 100644
> --- a/net/ipv4/fib_frontend.c
> +++ b/net/ipv4/fib_frontend.c
> @@ -1050,6 +1050,11 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  			e++;
>  		}
>  	}
> +
> +	/* Don't let NLM_DONE coalesce into a message, even if it could.
> +	 * Some user space expects NLM_DONE in a separate recv().

that's unfortunate

> +	 */
> +	err = skb->len;
>  out:
>  
>  	cb->args[1] = e;


Reviewed-by: David Ahern <dsahern@kernel.org>


