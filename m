Return-Path: <netdev+bounces-213215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE4B2422F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D5724CB4
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDA22D1F61;
	Wed, 13 Aug 2025 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVyOSkQR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D072C326A
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068881; cv=none; b=EiTIKBwqEXUheUABmyPRvAAupFXdtmGcrEFCSjCb4M49F27X7rFyp/79Nps7/J1Jt1SBFMIRL8p1zN04XuLXtiIei+ApRMyiOmCfCDjyrPug0UAC/+nSiNpnUvMqGbWs+9D1nTxZcGELkij/63f6WVE/DLQanRJ4zoLaWCGd8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068881; c=relaxed/simple;
	bh=FPSgSOe9+Ty0jK4JSjEYBgeSdySOqx3nIsNquyo1aOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IksSRic/5azJQ7epQvGx99Eh/TAj3023lCEvRSIek0RHp10QnHJpKM7vkgH/z8UlZixKMagEpWeimKFVyxr9aAdU+8DdovIh2NE64PXJCcShwAhq9dHFshlz0ukeARLS865uViQBWW9OESkfyzlJVK1Qs8h5q0DVF30rTDagpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVyOSkQR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso4928414a12.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755068880; x=1755673680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Riz+hlL+yUQb2ZDNGgleZP1m3SAZBHmBYEVDZCifnzE=;
        b=mVyOSkQRM8UJlVb5jPjr5zbnPEZmdkjq3oFHu9OEw+FY+X+0wtzvc0cYKCygI/lulg
         o9eQlFGr9Is3cu4gAeWBDsKCa/EAnZBrkJXI9gFy3K8KnF2qwZMh7EtqCIIbhKecoxrL
         x+U6jtLIHGPpmcVCf3TkXCtdQJjr1aZELfCSYtNsCpllexXsEYcB93ezRdIqpKzxgRh3
         jGYDvYIRm1dpCpiMb+JCAD0ria5xDGo1aqQ00B1I0fC+4fzuy9ebN7NCyLG7bACXyRrH
         HV0f1mGvUJk05f8QKY9T+sIO8Ltb0VFsVU0Cs1sdmZ9AZWm/uSqRVFbYh3WZHfg/TVTO
         L4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755068880; x=1755673680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Riz+hlL+yUQb2ZDNGgleZP1m3SAZBHmBYEVDZCifnzE=;
        b=RS26YhazVtA1DowrkP9uyIFmLHMYn367RsJsxCjRcwaczB7xRpaYLWun5Z1LOr2wyr
         +/G9n6LYp48W7EdoPmLr0gEm48WIdqfUbLo5HAxKG5ghbbmt3sm2wZhqiQ7K4QeNZquH
         7bhwO5JWheulvLAGBPoa7pSCxsOs//Gdy32lUSb409MicGQYSf3Qh07UdW65qe69aI5N
         eqYt9GfdtXb9AfmZjqNRkzcQKwysZyFemnH3cRtCFkI84Ah4Q1PAFAvBq1spSGJzuuez
         CE1XB9XiPKaw29UQVw4thP/j+X41wlUbqW33/c5tgvH+AkQ4+bmHVxflAM0ggqrEPK/m
         5ihg==
X-Forwarded-Encrypted: i=1; AJvYcCWfkHasSuo44mwtqaYAG/d67ZbSJLE447+mfgkyXG5X+E5rajw43YCDINQooy1paDcm3bd26xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQL0Ayq6hegqiIfjqeecCHQiz02quqo8gmH6du3z6opgjeMZb
	eVqlxAZCjbitcGHlMmy9HtPi6pnTgBD7fmjPbbkv2X/y7c2a+/tM4qtpKF5OCXpap2yitdXMlkO
	iNAg5PA==
X-Google-Smtp-Source: AGHT+IGwY584L8HLIOsUz9JBoa8Wg3VDjbNSVz3/i5QKeJO85ve+Eaa2Jl7Qu6DVGSrO1M6hCLBlTAxe81E=
X-Received: from pjx16.prod.google.com ([2002:a17:90b:5690:b0:31e:cee1:4d04])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da83:b0:242:9bc4:f1c7
 with SMTP id d9443c01a7336-2430d225e40mr34636395ad.54.1755068879883; Wed, 13
 Aug 2025 00:07:59 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:07:22 +0000
In-Reply-To: <20250812125155.3808-4-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812125155.3808-4-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813070758.120210-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v5 3/5] net: vxlan: bind vxlan sockets to their
 local address if configured
From: Kuniyuki Iwashima <kuniyu@google.com>
To: richardbgobert@gmail.com
Cc: andrew+netdev@lunn.ch, daniel@iogearbox.net, davem@davemloft.net, 
	donald.hunter@gmail.com, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	menglong8.dong@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	petrm@nvidia.com, razor@blackwall.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Richard Gobert <richardbgobert@gmail.com>
Date: Tue, 12 Aug 2025 14:51:53 +0200
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 15fe9d83c724..12da9595436e 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -78,18 +78,34 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
>  }
>  
>  /* Find VXLAN socket based on network namespace, address family, UDP port,
> - * enabled unshareable flags and socket device binding (see l3mdev with
> - * non-default VRF).
> + * bound address, enabled unshareable flags and socket device binding
> + * (see l3mdev with non-default VRF).
>   */
>  static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
> -					  __be16 port, u32 flags, int ifindex)
> +					  __be16 port, u32 flags, int ifindex,
> +					  union vxlan_addr *saddr)
>  {
>  	struct vxlan_sock *vs;
>  
>  	flags &= VXLAN_F_RCV_FLAGS;

VXLAN_F_LOCALBIND seems to be cleared ?

>  
>  	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
> -		if (inet_sk(vs->sock->sk)->inet_sport == port &&
> +		struct sock *sk = vs->sock->sk;
> +		struct inet_sock *inet = inet_sk(sk);
> +
> +		if (flags & VXLAN_F_LOCALBIND) {

Does selftest exercise this path ?


> +			if (family == AF_INET &&
> +			    inet->inet_rcv_saddr != saddr->sin.sin_addr.s_addr)
> +				continue;
> +#if IS_ENABLED(CONFIG_IPV6)
> +			else if (family == AF_INET6 &&
> +				 ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
> +					       &saddr->sin6.sin6_addr) != 0)
> +				continue;
> +#endif
> +		}
> +
> +		if (inet->inet_sport == port &&
>  		    vxlan_get_sk_family(vs) == family &&
>  		    vs->flags == flags &&
>  		    vs->sock->sk->sk_bound_dev_if == ifindex)

