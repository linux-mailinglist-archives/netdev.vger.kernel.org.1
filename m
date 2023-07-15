Return-Path: <netdev+bounces-18082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAC75498A
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7129281F4A
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD963BA;
	Sat, 15 Jul 2023 15:03:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F215C5
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 15:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FEDC433CA;
	Sat, 15 Jul 2023 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689433422;
	bh=QurM5yEFwkouec+rUx/t+ROt/1ZTj1FQOXoLyADVrNY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ndl4pAKy52gqYk5ZE+8uuf3Hw04O4yFxdwWij61FlNJXRhpfmLpo06v7pzqzCPzpW
	 XG1dgnAxgI9L5PidMHx+PnM8kWS/7j00PdInY7yO4DSQLeh5dXaLyQfiqNtgZQuIvW
	 yvnRwOsc5C6L7nMpj0+lj+22zHoO6JX7KyEv52wPSDaipv64wiOcBVAleGi5ywa+Cv
	 peY/ZwldrwmtjdWx/khYWV7cYveclSObR1vWDMPKMGfq2Ly/bg8twfKmK2wHHJe2ml
	 4SfFAPh1InUyeFjrAlve7oRVm8zYlUXBR5SleXPDlsdYBLKRlkPFuQuzBf0zTWs14R
	 53U29cFxvu9Mg==
Message-ID: <8a214a83-303a-bd1f-fd7f-f84230d7d756@kernel.org>
Date: Sat, 15 Jul 2023 09:03:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] net:ipv6: check return value of pskb_trim()
Content-Language: en-US
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
References: <20230715094613.37897-1-ruc_gongyuanjun@163.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230715094613.37897-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/23 3:46 AM, Yuanjun Gong wrote:
> goto tx_err if an unexpected result is returned by pskb_tirm()

s/pskb_tirm/pskb_trim/

> in ip6erspan_tunnel_xmit().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/ipv6/ip6_gre.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index da80974ad23a..92220b02e99f 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -955,8 +955,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
>  		goto tx_err;
>  
>  	if (skb->len > dev->mtu + dev->hard_header_len) {
> -		pskb_trim(skb, dev->mtu + dev->hard_header_len);
> -		truncate = true;
> +		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
> +			goto tx_err;
> +		else
> +			truncate = true;
>  	}
>  
>  	nhoff = skb_network_offset(skb);

no need for the `else`:
		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
			goto tx_err;

		truncate = true;

