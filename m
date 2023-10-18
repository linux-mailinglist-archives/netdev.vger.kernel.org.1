Return-Path: <netdev+bounces-42284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F807CE0BF
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80921C20D01
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1428B37CAE;
	Wed, 18 Oct 2023 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncDNWx8q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE883C1E
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F344C433C8;
	Wed, 18 Oct 2023 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697641684;
	bh=eBX5fiI/8MMX4Ixycd95dI41u9/Wb0d6aFG8drBPe6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ncDNWx8qhRtcory1Tw4Nk1zbt/IKqWXTTuWX5uiPO1UyWQr7cKjuBnlbqTI6pfVgv
	 Idq8D1aelKm4BopkE8O/+N1ItOi9Sc63cfmxyJDwHkw+boGVyBxResPTHbYuUSN2nH
	 euGDjAk6BYHrwlJoRtSXJZcfcf7xPji5TlfxRuef2lh8f3S29m99xahI5X0VjxwtkM
	 KP2mJqyK35EOX0Z4ogdwvfzu1xeQLfSeWy1km0v9Pf//AppT56sz35hP01Rkzyq0EV
	 vPAiuYsTHR+Okqf6vudIBoqZmgMi/e6Wiwi+2f1g3nqVVlqxJlGxktPgJ4EZAyHMo6
	 ztGvWNgonCskA==
Message-ID: <cab7b508-37af-09f4-a55e-69e89d29373c@kernel.org>
Date: Wed, 18 Oct 2023 09:08:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next V2] net: fix IPSTATS_MIB_OUTPKGS increment in
 OutForwDatagrams.
Content-Language: en-US
To: Heng Guo <heng.guo@windriver.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, filip.pudak@windriver.com, kun.song@windriver.com
References: <20231017062838.4897-1-heng.guo@windriver.com>
 <20231018010647.30574-1-heng.guo@windriver.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231018010647.30574-1-heng.guo@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/23 7:06 PM, Heng Guo wrote:
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 1af29af65388..15988e5a745b 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -141,14 +141,14 @@ void mpls_stats_inc_outucastpkts(struct net_device *dev,
>  					   tx_packets,
>  					   tx_bytes);
>  	} else if (skb->protocol == htons(ETH_P_IP)) {
> -		IP_UPD_PO_STATS(dev_net(dev), IPSTATS_MIB_OUT, skb->len);
> +		IP_INC_STATS(dev_net(dev), IPSTATS_MIB_OUTREQUESTS);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	} else if (skb->protocol == htons(ETH_P_IPV6)) {
>  		struct inet6_dev *in6dev = __in6_dev_get(dev);
>  
>  		if (in6dev)
> -			IP6_UPD_PO_STATS(dev_net(dev), in6dev,
> -					 IPSTATS_MIB_OUT, skb->len);
> +			IP6_INC_STATS(dev_net(dev), in6dev,
> +				      IPSTATS_MIB_OUTREQUESTS);
>  #endif
>  	}
>  }

mpls_stats_inc_outucastpkts is called for both forward and local output
use cases.

