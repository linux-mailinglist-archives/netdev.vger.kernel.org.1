Return-Path: <netdev+bounces-93058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903488B9DF6
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE4BB23694
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0015B984;
	Thu,  2 May 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYBuZdXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4115B97B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665546; cv=none; b=OeUmz5u4WWqCg39Is+Q8m84ZVJBueugRkQN9CVytIXB2YRmbmptDIjnzXxTgi1FDUDAN/i2TcIb+letVamMPue8TpA3tvs4MuN7AG0/pxPApeH5l6Qst3Mpw6THTN1V+4GRwePrxXcH6LMlBEXWHtUYcRJ/xg7u+bsgmdGfqBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665546; c=relaxed/simple;
	bh=QzzqvodqqlLSZV2d7REsr/ENSXXubcQSxmHWJYhSn0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRyrV+hlnSSqgQv1w9pcUdEMW7TvthGh0F9hoYJYe6f02n53CGTcRD/0jmCuNaWUMGkazEx5CrTcKUin63yQzjz1pMX6RmeZC7iwOn0isasD3+J5TTPNmg7qZZyHAuCYfw3l/iOwO5F0wFaTTNfb9auCmaQnZ5wBEerDcf8khi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYBuZdXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1039C113CC;
	Thu,  2 May 2024 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714665545;
	bh=QzzqvodqqlLSZV2d7REsr/ENSXXubcQSxmHWJYhSn0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gYBuZdXX7GPF49aCYjsPO/S0KTo8m3Ni8wihcZ94PhY3A/qE4PhD6p7SlsmMu0ejU
	 C6qg/SLqxxcXqv0d5VPESPv/Xc2771kx/Thudl8iHCPsu0qwhqOl1s0tKAUz7mTkSn
	 I6Y/g+qTy2ZOT5ySrMG3YOUkdurxpnzh9w2lFzrUlAVmP3FsRpziseozdE2T9v51Dd
	 qSQ13O89sj1v4Gkun+/fFtvc9MQVM0Ok/kkM9vk8o9hbLaspKSEbettJ6EB5GVGxrW
	 /cuTequTNiyOa6bS4bHG9SaldzwHusMSzeqZFZL1axpPwmjFW1kT/YaSTyXuKSTMNE
	 JZqGlpNXq/XEw==
Message-ID: <d09f8831-293e-45ec-93fb-6feab25d47f2@kernel.org>
Date: Thu, 2 May 2024 09:59:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] rtnetlink: change rtnl_stats_dump() return
 value
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20240502113748.1622637-1-edumazet@google.com>
 <20240502113748.1622637-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240502113748.1622637-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 5:37 AM, Eric Dumazet wrote:
> By returning 0 (or an error) instead of skb->len,
> we allow NLMSG_DONE to be appended to the current
> skb at the end of a dump, saving a couple of recvmsg()
> system calls.

any concern that a patch similar to:
https://lore.kernel.org/netdev/20240411180202.399246-1-kuba@kernel.org/
will be needed again here?

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/rtnetlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 283e42f48af68504af193ed5763d4e0fcd667d99..88980c8bcf334079e2d19cbcfb3f10fc05e3c19b 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -6024,7 +6024,7 @@ static int rtnl_stats_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  	cb->args[1] = idx;
>  	cb->args[0] = h;
>  
> -	return skb->len;
> +	return err;
>  }
>  
>  void rtnl_offload_xstats_notify(struct net_device *dev)


Reviewed-by: David Ahern <dsahern@kernel.org>


