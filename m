Return-Path: <netdev+bounces-100425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359C48FA84E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 04:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCD9285E12
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26F22075;
	Tue,  4 Jun 2024 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRG1lLjf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547038B
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717468432; cv=none; b=Ruq6fi+BlLuFn9L5Sx68wckZccAXHz/YIosohQhGqbPTCsvpnHqID7zQlsv/nwPED6iq6z5rpRjkj0Hj6HIqu7Euel5QeW6j8NR9jfS8O2A11hvfVahjS47eJjKnmGePVH9rGUM7373ek7de1mmaWfzLGtoqLWwCJh56cEvwWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717468432; c=relaxed/simple;
	bh=OGxygs7iiIOF25aOfxkc8zUojYb8pw1o0xfMg/p2R90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJbxMhimxKEAQXbVbbEuk+sYvYPNf4Olg3hnsbwMg6IOJG+dmD+U2SZHWDJ02ux8p3IPDt1B53jzSvqsRcsGpDb7M0eSk7juwsGgtMGELLTCeN3nxWDzBZR8W6xoP55RwMaz684xzyCz93B0vGDJzjqKMiUP5LMzKBnZvNMgaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRG1lLjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB89C2BD10;
	Tue,  4 Jun 2024 02:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717468432;
	bh=OGxygs7iiIOF25aOfxkc8zUojYb8pw1o0xfMg/p2R90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DRG1lLjf/vL8Lh0vBCKDX8hZlynEfhIch0XAPP3k3GnI35tm+dUqkr6ZcFOC7ZwLj
	 SFeycR1Upj4LHbVXK5BI1s/4WPfC328gPb0nqy/SpZaDktTUCNTaCVWdWhKFkPI+o1
	 Fo/KjwUnko2AuAsLZm4IDZNUqsz8CuxBuppStflhDOZggI8jWolbKsRTIzwh8fneaJ
	 ChO4wMgq+Ss8esYrEsh9FznMXh1YyfqpkGO22ERlaOk9upzzm3GYrQ6I8p1DZ2rS4+
	 OhxN4uhkQMWEvLWsW5sCVnZmFG8IfI2l6uYHEHbpXvPFkt8dv5R/FvUM2XCrRWn/xb
	 q5C2bPFqDjbxA==
Message-ID: <6861ace8-febe-43b8-b75a-751af0506c4d@kernel.org>
Date: Mon, 3 Jun 2024 20:33:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] rtnetlink: make the "split" NLM_DONE handling
 generic
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
References: <20240603184826.1087245-1-kuba@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240603184826.1087245-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 12:48 PM, Jakub Kicinski wrote:
> @@ -6694,7 +6734,7 @@ void __init rtnetlink_init(void)
>  	register_netdevice_notifier(&rtnetlink_dev_notifier);
>  
>  	rtnl_register(PF_UNSPEC, RTM_GETLINK, rtnl_getlink,
> -		      rtnl_dump_ifinfo, 0);
> +		      rtnl_dump_ifinfo, RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
>  	rtnl_register(PF_UNSPEC, RTM_SETLINK, rtnl_setlink, NULL, 0);
>  	rtnl_register(PF_UNSPEC, RTM_NEWLINK, rtnl_newlink, NULL, 0);
>  	rtnl_register(PF_UNSPEC, RTM_DELLINK, rtnl_dellink, NULL, 0);
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index f3892ee9dfb3..d09f557eaa77 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2805,7 +2805,7 @@ void __init devinet_init(void)
>  	rtnl_register(PF_INET, RTM_NEWADDR, inet_rtm_newaddr, NULL, 0);
>  	rtnl_register(PF_INET, RTM_DELADDR, inet_rtm_deladdr, NULL, 0);
>  	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr,
> -		      RTNL_FLAG_DUMP_UNLOCKED);
> +		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
>  	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
>  		      inet_netconf_dump_devconf,
>  		      RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED);
> diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> index c484b1c0fc00..7ad2cafb9276 100644
> --- a/net/ipv4/fib_frontend.c
> +++ b/net/ipv4/fib_frontend.c
> @@ -1050,11 +1050,6 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  			e++;
>  		}
>  	}
> -
> -	/* Don't let NLM_DONE coalesce into a message, even if it could.
> -	 * Some user space expects NLM_DONE in a separate recv().
> -	 */
> -	err = skb->len;
>  out:
>  
>  	cb->args[1] = e;
> @@ -1665,5 +1660,5 @@ void __init ip_fib_init(void)
>  	rtnl_register(PF_INET, RTM_NEWROUTE, inet_rtm_newroute, NULL, 0);
>  	rtnl_register(PF_INET, RTM_DELROUTE, inet_rtm_delroute, NULL, 0);
>  	rtnl_register(PF_INET, RTM_GETROUTE, NULL, inet_dump_fib,
> -		      RTNL_FLAG_DUMP_UNLOCKED);
> +		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
>  }


You are using the legacy way for route, link and address dumps with the
option to quickly add the others as needed (meaning when a regression is
reported). If those 3 need the workaround, I think there are high odds
all of the other rtnl_register users will need it. So, if there is not
going to be a per-app opt-in to a new way, you might as well make this
the default for all rtnl families - sadly.



