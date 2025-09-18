Return-Path: <netdev+bounces-224499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DE1B8596C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C06584A6C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70030C36A;
	Thu, 18 Sep 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq47ffte"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8C23D7C9
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209042; cv=none; b=QvlPQvtTP5oMoA5Rz/c/O8Zw4U92QXXx2EmTiQS5wXDXiytopx6Nl5FB7q+jtNwwRiLCh3wmfftgD0LFxvX86d8oDERJfm3MCD38M7Lsx5qKEVYpztNnrqjMgOhYCDMJW5Bbmgo9hNc44EiW1zl47Zrg4tl+0BjLa3GAsDXFtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209042; c=relaxed/simple;
	bh=X6OJvuEybBZW1Dyb87p9FajiaDNcmATdR1fKZQUKprU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1WZRWXuUicbk4gjZ5dmQG/zK9BdR0z6rK8qfcUZoTc7QPZBvxeUNtyq+K53nUFwkkwNh52JGUFfoJGmNRas75FOSicwCc1o9ppQmRhzDQBIGdSgX1FeHP7V/VQxoYSY2PlB2e5iQfDFeZW93ckhtT+JMlM2lUlGc2yAW4bjB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq47ffte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1277CC4CEE7;
	Thu, 18 Sep 2025 15:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758209042;
	bh=X6OJvuEybBZW1Dyb87p9FajiaDNcmATdR1fKZQUKprU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kq47ffteQ1kTvSC0yRnMrFxlv9Wvj923XCAG4cgaYSvOuffEZcuwASO8w2LkZ7n2B
	 ncBoOaNTABSutLOMjL6TYM+Zeh+30uvBbOH7MmuqPzL67CMD/nXoVw2Ea4uMTSassY
	 2tq58EycFghxVgCYG3NWmCUb1b89pJ03XshgW8gE3lAJqFPRBJ+NJAlhp+dpjnBaOI
	 YpJORNLGV95wn1wdlHff8MAn7kLdiU7cSRtvqqEPF4fb6QWkSoI4V1NzAXfd712eQ8
	 8QSKgxl7uzHB8aKaFPC7S1FUgFW7O2cLOyd4X/PtIBjM+ZcMgTA9EYNNoGendFKawn
	 QhTxnIZ3AzqWg==
Message-ID: <454978a6-41c1-46cc-a51f-0b068238a3f3@kernel.org>
Date: Thu, 18 Sep 2025 09:24:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: ipv4: simplify drop reason handling
 in ip_rcv_finish_core
Content-Language: en-US
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250918083127.41147-1-atenart@kernel.org>
 <20250918083127.41147-3-atenart@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250918083127.41147-3-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 2:31 AM, Antoine Tenart wrote:
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 8878e865ddf6..93b8286e526a 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -335,7 +335,6 @@ static int ip_rcv_finish_core(struct net *net,
>  			goto drop_error;
>  	}
>  
> -	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
>  	    !skb_dst(skb) &&
>  	    !skb->sk &&
> @@ -354,7 +353,6 @@ static int ip_rcv_finish_core(struct net *net,
>  				drop_reason = udp_v4_early_demux(skb);
>  				if (unlikely(drop_reason))
>  					goto drop_error;
> -				drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  
>  				/* must reload iph, skb->head might have changed */
>  				iph = ip_hdr(skb);
> @@ -372,7 +370,6 @@ static int ip_rcv_finish_core(struct net *net,
>  						   ip4h_dscp(iph), dev);
>  		if (unlikely(drop_reason))
>  			goto drop_error;
> -		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	} else {
>  		struct in_device *in_dev = __in_dev_get_rcu(dev);
>  
> @@ -391,8 +388,10 @@ static int ip_rcv_finish_core(struct net *net,
>  	}
>  #endif
>  
> -	if (iph->ihl > 5 && ip_rcv_options(skb, dev))
> +	if (iph->ihl > 5 && ip_rcv_options(skb, dev)) {
> +		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  		goto drop;
> +	}
>  
>  	rt = skb_rtable(skb);
>  	if (rt->rt_type == RTN_MULTICAST) {

I do not see any of the cleanup changes requested on v1.

