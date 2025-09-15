Return-Path: <netdev+bounces-223182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7DB5828D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDC1160F24
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E621B0F23;
	Mon, 15 Sep 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Wart8UmR"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64E22156D
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955017; cv=none; b=Tca0c33xVLFGdHDEr/Gx2SnZu4vBH5WVD1FniCG9+8SciNK1iCl2okm9af1FkRm81wpr+I1e5vI1HNZHzoZiyd+tmpBQehxY7O54lIsFOJPsxGOxowZiFyFvgYdam/ENsXniggcE4bAWH0QJTbe1g4fo2Ha+iCczh3khtyrIUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955017; c=relaxed/simple;
	bh=J1MQoCvRD9kQRLJ9zYJO/3+CEeINf+rBaiFuoU2heCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAfOniPiNA8y8WAEIwtZ13EnPtN1nb9JaQci8BBu1R25i5kgMq+96lsbc3rqRIRY0/bsZtqsX+L7Gu/H6I0+knOTpVPMHG5lH6d24T+Yx41Za7/KMJIGsZtVaZCpeYVgaXvOs8o/Nz3fkEWyGWHpzsR747UM5GW1V2zAZKfaTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Wart8UmR; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tJcMzyi76z8j2yH6flmB8RxLPtEXfpa3c5ZDkTUyamU=; b=Wart8UmRASSqikQXSd56+8saC/
	+X2Hrm88/DoyYql3PnU+9tyixpkAxG9Cl986rTXqsWKSnn8Xdcarg8Z0zA3RFt0ydnuPhRjg+pnED
	CXv62H3S3tlU490HWmEAEWD4a+aWv/23s6kTGA439SVGvpQF7bq146XZuyRvT7A/cycuxiHZnXy4m
	lYD9Vp0bTM47XMb0HE8CFCjK9XOdXG7ciOTgHQdrzTZVGly0Jvo7+KHl5uY9uZ9pEaEeLMZm6UbEt
	OJ9lJE87gebp54Nr/4oZSOy1XSnkGFeVb5bJ5Bfl50vm3p/BzC/Ttp7tkUNKEBfiR0arsGt7odXP2
	dHxSWMkg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uyCOr-000AWs-0M;
	Mon, 15 Sep 2025 18:49:57 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uyCOq-000JHT-0k;
	Mon, 15 Sep 2025 18:49:56 +0200
Message-ID: <e742f9e0-671d-4058-99af-c3e38b73ec0d@iogearbox.net>
Date: Mon, 15 Sep 2025 18:49:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtnetlink: add needed_{head,tail}room attributes
To: Alasdair McWilliam <alasdair@mcwilliam.dev>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250915163217.368435-1-alasdair@mcwilliam.dev>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250915163217.368435-1-alasdair@mcwilliam.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27764/Mon Sep 15 10:26:33 2025)

Hi Alasdair,

On 9/15/25 6:32 PM, Alasdair McWilliam wrote:
> Various network interface types make use of needed_{head,tail}room values
> to efficiently reserve buffer space for additional encapsulation headers,
> such as VXLAN, Geneve, IPSec, etc. However, it is not currently possible
> to query these values in a generic way.
> 
> Introduce ability to query the needed_{head,tail}room values of a network
> device via rtnetlink, such that applications that may wish to use these
> values can do so.
> 
> Signed-off-by: Alasdair McWilliam <alasdair@mcwilliam.dev>
> ---
>   include/uapi/linux/if_link.h |  2 ++
>   net/core/rtnetlink.c         | 10 +++++++++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 45f56c9f95d9..3b491d96e52e 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -379,6 +379,8 @@ enum {
>   	IFLA_DPLL_PIN,
>   	IFLA_MAX_PACING_OFFLOAD_HORIZON,
>   	IFLA_NETNS_IMMUTABLE,
> +	IFLA_HEADROOM,
> +	IFLA_TAILROOM,
>   	__IFLA_MAX
>   };
>   
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 094b085cff20..c68e20a36daa 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1326,6 +1326,8 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
>   	       + rtnl_devlink_port_size(dev)
>   	       + rtnl_dpll_pin_size(dev)
>   	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
> +	       + nla_total_size(2)  /* IFLA_HEADROOM */
> +	       + nla_total_size(2)  /* IFLA_TAILROOM */
>   	       + 0;
>   }
>   
> @@ -2091,7 +2093,11 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>   	    nla_put_u32(skb, IFLA_CARRIER_UP_COUNT,
>   			atomic_read(&dev->carrier_up_count)) ||
>   	    nla_put_u32(skb, IFLA_CARRIER_DOWN_COUNT,
> -			atomic_read(&dev->carrier_down_count)))
> +			atomic_read(&dev->carrier_down_count)) ||
> +	    nla_put_u16(skb, IFLA_HEADROOM,
> +			READ_ONCE(dev->needed_headroom)) ||
> +	    nla_put_u16(skb, IFLA_TAILROOM,
> +			READ_ONCE(dev->needed_tailroom)))
>   		goto nla_put_failure;
>   
>   	if (rtnl_fill_proto_down(skb, dev))
> @@ -2243,6 +2249,8 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
>   	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
>   	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
>   	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
> +	[IFLA_HEADROOM]		= { .type = NLA_U16 },
> +	[IFLA_TAILROOM]		= { .type = NLA_U16 },

Given this is for dumping only, we'd need to replace NLA_U16 above with NLA_REJECT
like in case of IFLA_NETNS_IMMUTABLE.

Also the Documentation/netlink/specs/rt_link.yaml needs an extension, otherwise lgtm.
$subj should have [PATCH net-next] to indicate the target tree.

Thanks,
Daniel

