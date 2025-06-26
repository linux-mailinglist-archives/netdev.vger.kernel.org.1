Return-Path: <netdev+bounces-201366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 475FDAE9327
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A131C25035
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541033987;
	Thu, 26 Jun 2025 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyJcVdLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF91E55B
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750896132; cv=none; b=DwOZsXyfxubKSCNPbNjdOXo29C7gm/1SocU+wzQqhskAf9ZNcW/a6PnI0U8MLPIz/ZRbFLfuoYtiChR+7GVhFXHf04GAfoEUEJNWc/mf+vflxeit63XhfRm7gfhvd+n+2PH6aXKWhcVGgiRwG40G3/FxeZ2jj3md9ThaAWfWvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750896132; c=relaxed/simple;
	bh=P+Zuu4qNqi2BqxLuy07ENVLsQh76g4f8zlh7mY+iFUQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LB22zBT5cgtHYdmIbL8r3bcNmg9WpXDjbTa0qMLdZRuekvrp9YuRWd4mNjRRftP7bkN6CRwtOGtjG7RbzYtZvsP+LZ5PlEeVKbkpbxHCTE2D0fshSiJLyEfD32+E+mJRUiZ+CuZ3Pf5YCEF2mJvhUgu/v1+Y565uGntnMIWuf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyJcVdLQ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e4043c5b7so5196767b3.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 17:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750896129; x=1751500929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JVVLm5cB/zKejNCFzzAdfeF0mrBsg+k6uAyfHfqBRc=;
        b=MyJcVdLQVZs9ekSzW5OYvVCycZqX70CPJjE12Opfq9Ppixe43fmIYdBU/nutjg16m+
         URbWyOus62cklf625tVnP7pEjeCWnbLRiPYuT6dTJsr946BdBgV76Rw/sfTH5/r0hqj2
         SUG7qLZg4lWELgsX6J8JijY9WX3ruBBB6Qy5dkg9Xh9Hx77CmDGqvkJXVhWpHPxBfWtE
         OBCYZrsEaaVgKrFr8xVm/U8Jwvcp0MTZOXs2px7xih2A8cqhUi3a18k23peI4CEcImAs
         kHKZvoJX42SmHyGkqBG8GAqEGSiEWXfKqVj8j7U2M5scDm2coqRpCHGewD+VPCu/tqMB
         4BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750896129; x=1751500929;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JVVLm5cB/zKejNCFzzAdfeF0mrBsg+k6uAyfHfqBRc=;
        b=RRGJYXnSF1519le1mJFTZU+yLjVRp+Pjodd+s1gOzS7fCltg1Qqkxt8OmHZdYfOn5A
         qr0lQByE+BXphWETOufymc9hQTfNMTRNypPiuN4W6XNFIAfd7BKWh8LUeBQ5BmilsFNB
         VjPpsdcrcihkmEL6QLGL8BV2ftbyMMpUScblrOKiJ+ep39VHZ0Rat7Z6bRsBA1uf1nzA
         S9VxWvqNmqu2Xz2ykO7/CjVsJA4+0VRMLhjyvhPCNVWs7Az3lCzIbVTQrk6bNB9kDaTk
         6HBRtP6dN+4+Z2roltPUsq0NMBY5ME/dWgHPz3wYrByNpH52UL7L9wZPHRv0uhzjS+zc
         R8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmIWGp6iDispHCMDKT1jLzcodgNcIzlOCOlg1vZD29J3hE98pTxkWuKyA/0GUTGne0CXQCfys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWm4ybN7LCfG5Wlm+8Crx0/+0awcJtzmYDuuHhdBayaoVysf+
	DswMRG3wa8HYa5C1rng511ueMUhw+yojIc0GqypjsHN7TVPeynwiGqCD
X-Gm-Gg: ASbGncvA+ZgM7u1D5YGgbzm5QNrqUgv3limAfutkSv/NV7V3Z1m0daFoLHK5dn97LGk
	KaDm2JZQ77pqkm4vDTZmzqY+NsiXhURgxW1vA0UO+iE6KkPHgSlQjA8tGDf9i1Xyz9mZEgRL+Tw
	sh6koX6M/r0ib2eQqjPXizzGKsnhf2nIZJhHeb1HLeLnVPmM25Wg1vW89EGiMcRiK5b+neBUZ0g
	A0o4OSdWxYTAS+olF2w+h7G46geMmftjrSfy65J8K5KzZj13uk08g2AYEphhtvsjvtZl8GV3JyS
	mY8XUf4XNbh7tovX1EKXBy3ErsjC1cMNNIBxxHWtVhpAjT8DeHU6XcGqyBvrLP9vvcpv6Xq51st
	4D5tA2fs+fRgRzR+LBtm1ODePWO+qKHhu53341DwNMA==
X-Google-Smtp-Source: AGHT+IFpPBJjbfNLBOyZytAzfi1PQ928WsJYHWlc7Ti8QIH0lSM+KNU7Y38p5dh5/SjgUVtUkfTcUw==
X-Received: by 2002:a05:690c:6384:b0:709:197d:5d3c with SMTP id 00721157ae682-71406cd24f9mr79138677b3.11.1750896128769;
        Wed, 25 Jun 2025 17:02:08 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4c1d658sm26396927b3.114.2025.06.25.17.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 17:02:07 -0700 (PDT)
Date: Wed, 25 Jun 2025 20:02:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685c8dff7491f_2a5da429443@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625135210.2975231-8-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-8-daniel.zahka@gmail.com>
Subject: Re: [PATCH v2 07/17] net: tcp: allow tcp_timewait_sock to validate
 skbs before handing to device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> Provide a callback to validate skb's originating from tcp timewait
> socks before passing to the device layer. Full socks have a
> sk_validate_xmit_skb member for checking that a device is capable of
> performing offloads required for transmitting an skb. With psp, tcp
> timewait socks will inherit the crypto state from their corresponding
> full socks. Any ACKs or RSTs that originate from a tcp timewait sock
> carrying psp state should be psp encapsulated.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> 
> Notes:
>     v2:
>     - patch introduced in v2
> 
>  include/net/inet_timewait_sock.h |  5 +++++
>  net/core/dev.c                   | 14 ++++++++++++--
>  net/ipv4/inet_timewait_sock.c    |  3 +++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
> index c1295246216c..3a31c74c9e15 100644
> --- a/include/net/inet_timewait_sock.h
> +++ b/include/net/inet_timewait_sock.h
> @@ -84,6 +84,11 @@ struct inet_timewait_sock {
>  #if IS_ENABLED(CONFIG_INET_PSP)
>  	struct psp_assoc __rcu	  *psp_assoc;
>  #endif
> +#ifdef CONFIG_SOCK_VALIDATE_XMIT
> +	struct sk_buff*		(*tw_validate_xmit_skb)(struct sock *sk,
> +							struct net_device *dev,
> +							struct sk_buff *skb);
> +#endif
>  };
>  #define tw_tclass tw_tos
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b825b3f5b7db..bf013436a57b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3904,10 +3904,20 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
>  					    struct net_device *dev)
>  {
>  #ifdef CONFIG_SOCK_VALIDATE_XMIT
> +	struct sk_buff *(*sk_validate)(struct sock *sk, struct net_device *dev,
> +				       struct sk_buff *skb);
>  	struct sock *sk = skb->sk;
>  
> -	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
> -		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
> +	sk_validate = NULL;
> +	if (sk) {
> +		if (sk_fullsock(sk))
> +			sk_validate = sk->sk_validate_xmit_skb;
> +		else if (sk->sk_state == TCP_TIME_WAIT)

Can this shadow a different constant for other protocols?

To be on the safe side: sk_is_tcp

> +			sk_validate = inet_twsk(sk)->tw_validate_xmit_skb;
> +	}
> +
> +	if (sk_validate) {
> +		skb = sk_validate(sk, dev, skb);

If this callback is in the hot path, a candidate for an INDIRECT_CALL wrapper.
There are only two users, TLS and PSP.

>  	} else if (unlikely(skb_is_decrypted(skb))) {
>  		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
>  		kfree_skb(skb);
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index dfde7895d8f2..859c03e07466 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -210,6 +210,9 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
>  		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
>  		twsk_net_set(tw, sock_net(sk));
>  		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
> +#ifdef CONFIG_SOCK_VALIDATE_XMIT
> +		tw->tw_validate_xmit_skb = NULL;
> +#endif
>  		/*
>  		 * Because we use RCU lookups, we should not set tw_refcnt
>  		 * to a non null value before everything is setup for this
> -- 
> 2.47.1
> 



