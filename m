Return-Path: <netdev+bounces-95837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482A8C39EF
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E81C20959
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6787626CB;
	Mon, 13 May 2024 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7dbfCob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D920B0F
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715564839; cv=none; b=Eh2k1w2nYOEyFd4vh+QLcENXv7qtEsQldKd/8G15mfo+imQmjsaIVBJBgF+tAxI9oWMktnxWL3lCocllrukvuycTyCHogjuHEbbeT0XNojGnsZzxB9ztKMFYOIwbBcbgCCWTqybXpc8w1fomz13/3A7zVBhkR7Vn7HSUsDrX4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715564839; c=relaxed/simple;
	bh=Er5Yov3RvA1KjyCxT5ImWYjSb3RTCiRAqejWvyOcHXU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Eh0fKahPRxo3AKg2hQbKJxKLw7W/0SeAiOY9I+5JiVJ2CRcnZXs3zFQwoTPmJfP8XW4LOq9WeV9HRohGPlq6dsWaudT4Af8/FcLPg9iIy5E021u7o9fatVtgclEgLdkUoRJE8i9ef1uSnvreg3tzNVC268Bz5mPhkdYhfucvgz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7dbfCob; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-481e99a2c55so88933137.3
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715564837; x=1716169637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t+2BVF1J6DGciba/T99xGVvHrGraVKcW1j0J9Sk5b4=;
        b=R7dbfCobngcf5N/k1zSdBwPrSRH4XM+xwCqzKegp603hYU4RfbQwFoLLa5OEYQQezQ
         bWCDrcyK1bG6OW5zXbccRkscVqQvWrj6B/BVNkTxMLge79iU6X22fJK6zkeoYvlW7pL5
         BX7qwhmxZ7IoRPjXTxrmbbQGXWwLFPQWW3/Yjly6erGtMdPLbZDqSK9DMmvdiYCX+jRY
         sx3fcWCEguOcouNLBfiIXHho0L6Ndbs5+xE8ADb8g4d82WzWVW/U11ag7inVtje6OJYy
         PpQEemSfPeip+tDuBF4ZQbVoM41EtCpzcHIGIxJEuGQ/D0nAo2DDTLeOEPKf2tX7jZWe
         0sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715564837; x=1716169637;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2t+2BVF1J6DGciba/T99xGVvHrGraVKcW1j0J9Sk5b4=;
        b=Z+0eJkxI4dsTt+3L+F3muCcQUDX4//tWbzqprjBZFfHyJ3AZhAtx+39nQdOga75DI3
         TK/+AeWp9LB82j7WG+17/sXUWQbBjRyqhhbXSc0cs7UezuwWHaq0I8AEL+Ud0kuznP7y
         Bz62quI9iNw8hby79dpgIzbZzPLTSuRTlpyHXaWsVlC8vC6tA+FAXX8H1xkfm0lGb8rP
         w1sey/NXgTcucI0PP0DA/ddsF0meKXUgJx2GxH3CiGcaVDxDx2FGHphefNn5fdpknwTq
         6ScKG9YNuEKNB/o8aE1HkZIglngzbXbBjmQifoJghRhHB63Gq2NQDcCIEK7l31Ty+Qg9
         F8rw==
X-Forwarded-Encrypted: i=1; AJvYcCVPdGlsXcfGIRXShC9d5cy6RzIpXgnlB/121VHbUlaj+2HTzsv9EDzjAuFFRcoJvzlbxgPwGvjs0Tp+q9bqOFGt8oS2rdbk
X-Gm-Message-State: AOJu0YwFHuw2Ct1SMne1DxvpBioKV08Qz6KnoWShskwephE/D1G8jxFD
	Jybrb5m/U848ZKETb2RPoJpsPxjklhrDSQHsnwFYrU4gpZYNHhIw
X-Google-Smtp-Source: AGHT+IGQxb7HxLvVo7gmOaak/NGhRqmxHCYmMZMRS13f/Y3XfwOZ63L7KcZ0WHpcwd5N4+9Hoi8RnA==
X-Received: by 2002:a05:6102:3f4c:b0:47f:684:a3d with SMTP id ada2fe7eead31-48077e79797mr8431251137.27.1715564837022;
        Sun, 12 May 2024 18:47:17 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0a4bdce8sm24903941cf.18.2024.05.12.18.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 18:47:16 -0700 (PDT)
Date: Sun, 12 May 2024 21:47:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org
Cc: pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 steffen.klassert@secunet.com, 
 tariqt@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6641712443505_1d6c67294c7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510030435.120935-8-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-8-kuba@kernel.org>
Subject: Re: [RFC net-next 07/15] net: psp: update the TCP MSS to reflect PSP
 packet overhead
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> PSP eats 32B of header space. Adjust MSS appropriately.
> 
> We can either modify tcp_mtu_to_mss() / tcp_mss_to_mtu()
> or reuse icsk_ext_hdr_len. The former option is more TCP
> specific and has runtime overhead. The latter is a bit
> of a hack as PSP is not an ext_hdr. If one squints hard
> enough, UDP encap is just a more practical version of
> IPv6 exthdr, so go with the latter. Happy to change.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> +static inline unsigned int psp_sk_overhead(const struct sock *sk)
> +{
> +	bool has_psp = rcu_access_pointer(sk->psp_assoc);
> +
> +	return has_psp ? PSP_HDR_SIZE + PSP_TRL_SIZE : 0;
> +}

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 6991464511c3..c67700fc49a1 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -299,10 +299,10 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
>  	sk->sk_gso_type = SKB_GSO_TCPV6;
>  	ip6_dst_store(sk, dst, NULL, NULL);
>  
> -	icsk->icsk_ext_hdr_len = 0;
> +	icsk->icsk_ext_hdr_len = psp_sk_overhead(sk);
>  	if (opt)
> -		icsk->icsk_ext_hdr_len = opt->opt_flen +
> -					 opt->opt_nflen;
> +		icsk->icsk_ext_hdr_len += opt->opt_flen +
> +					  opt->opt_nflen;
>  
>  	tp->rx_opt.mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) - sizeof(struct ipv6hdr);
>  
> @@ -1500,10 +1500,10 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>  		opt = ipv6_dup_options(newsk, opt);
>  		RCU_INIT_POINTER(newnp->opt, opt);
>  	}
> -	inet_csk(newsk)->icsk_ext_hdr_len = 0;
> +	inet_csk(newsk)->icsk_ext_hdr_len = psp_sk_overhead(sk);
>  	if (opt)
> -		inet_csk(newsk)->icsk_ext_hdr_len = opt->opt_nflen +
> -						    opt->opt_flen;
> +		inet_csk(newsk)->icsk_ext_hdr_len += opt->opt_nflen +
> +						     opt->opt_flen;
>  
>  	tcp_ca_openreq_child(newsk, dst);

The below code adjusts ext_hdr_len and recalculates mss when
setting the tx association.

Why already include it at connect and syn_recv, above?

My assumption was that the upgrade to PSP only happens during
TCP_ESTABLISHED. But perhaps I'm wrong.

Is it allowed to set rx and tx association even from as early as the
initial socket(), when still in TCP_CLOSE, client-side?

Server-side, there is no connection fd to pass to netlink commands
before TCP_ESTABLISHED.

> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> index 42b881e681b9..bcef042cb8a5 100644
> --- a/net/psp/psp_sock.c
> +++ b/net/psp/psp_sock.c
> @@ -170,6 +170,7 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
>  			  u32 version, struct psp_key_parsed *key,
>  			  struct netlink_ext_ack *extack)
>  {
> +	struct inet_connection_sock *icsk;
>  	struct psp_assoc *pas, *dummy;
>  	int err;
>  
> @@ -220,6 +221,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
>  
>  	WRITE_ONCE(sk->sk_validate_xmit_skb, psp_validate_xmit);
>  
> +	icsk = inet_csk(sk);
> +	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
> +	icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
> +
>  exit_free_dummy:
>  	kfree(dummy);
>  exit_clear_rx:
> -- 
> 2.45.0
> 



