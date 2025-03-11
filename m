Return-Path: <netdev+bounces-173728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5EAA5B6C0
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 03:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A63A4D7B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 02:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C51C5799;
	Tue, 11 Mar 2025 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNIRxrZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F39339A1
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660363; cv=none; b=fwKOmQet3z5dZ7l6OHYw0fwUmT20jiJXbSasJL5nN7JJvzhRj2XnDqPSDTnoJAD7XG2pbr1RuUYooUFfZvC2AXrSh0/+UoQxYXQNF76KjvOienhyL6gEL/HtyNG7NPOiulukVYtsmr/9GyWjYNZBY0wX/bKgGzwma3F2ZpaKKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660363; c=relaxed/simple;
	bh=Jiujg2Z5sKB4wGuHCMruACu2//XgjWrECFuI66Ts9WA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V5gCSOgNfHpqP5OgUHdI//vJWkMndkpEqTYRiX9jrEIskw6ao558d7WOys/k3DBKBTMrJEGs/tZ470D4vH64+a0ukgrVMooKLPdJail+vqgpYk2kc1jpzq7DjYS5VknGildGhjM98p+Sew1VOj+tcOuHi6XX5zJAQGQOyLicLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNIRxrZS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769f3e19a9so825421cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 19:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741660360; x=1742265160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M7x42zPFVtx7ZR3iuMRga38MzaG2Tq/bzMtxp08m18=;
        b=hNIRxrZSyap5dH61CWN69FQzBIqsbr/cuTPGA4igx+aMo9LiGTVvVJdjbcPPjgDOL0
         kCRQ74VcCZRBCtaTCwM8AKSeMKRzzIz20kUw5gHzO+REBq/jpG2eolzeuEzEnsV0WE+R
         3BDDYdJBFn+sjAkBAXXrygMSwfBCXnmKsMBKKdNiEq//1aIsCw2TqBwvY0wzOvp7yTBa
         b/yBbQ8sh0PTavRFoIEsx1zfU4sV1Oa26dcIKkOSbLvGiDPqdiFN/Wv1gjJn7y4k/a1n
         POmjKlrGrh0SkC72lqlDDH0BVN/+XEmQYSHEJSIx6FCbXzpGJCvwheIrealx8YvRtTbi
         JYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660360; x=1742265160;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7M7x42zPFVtx7ZR3iuMRga38MzaG2Tq/bzMtxp08m18=;
        b=kHEMflaqCP3xq48KPiMWsMXjshfaHHuNwG82WJrWWU76lZoqc8t0PM/MMn7jW6RqZa
         YCEZVqbLGnlm32mpoMc+7JHlb8nWoTGeMoY3TwPo5PQSwgALO/T/a+x64+vybuDwULyw
         KpB5SGfSyS8nxhFrFt40BieAzUO7q1sHvdCl5+cWKrf7WFQAcL98iR0eBf5GvNgDGkGg
         WCTSFTCl2/Pr8L3Yd5mTZyK/L3bkY1F5CDm5F/Fd8WpDw4GXpTeTIPLTtYEfumx24Ytr
         JPAnm1WcD5TDIDqWsfV2GjlrqLhNo2dXJOZQyN0OcU8L3BT+37nO4AqYYBeUjMT9VXKr
         ZVLA==
X-Forwarded-Encrypted: i=1; AJvYcCXlc22e6bhyPmJJr4S31n2cuptdv9xYA/kQ/XlgwfGP1bSW7+ybj+4B963aC+5oDin/PkfeCig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMEnjEhrZvSgfJyh97BIDwZTQ9SUrc0KSssonV0OhIz+Oo0Fbe
	BbdIG2czmE9Ak97RZfstgiD+HsgmvN5q6Av8mmoKsbjjAX4urVQ+
X-Gm-Gg: ASbGncsXz0OlQ7PE1T0tb8LsmuqYJaIvedPcGlu+9+Vi/3ibNmK6zNhNyQBKWHXKMLO
	Ujd+fH4DohmtOaFeCd8gvH2eQ1iXR9f842MiHfWsJEnosdiKp6rgffIdgoNn1W/veSqZTiniJBz
	yLevK/2OGfubrxD1LMsX42Gz+jDK9suj6R/Fjt8d143N0aifEDWgDIiL2SkfUIAMKkJaVJM+AJB
	O/RJuGtLI1W++sFSCmHjB3RXdJSsH+HPGJGGinrB3ebUGUIrXQHF5YxOVyZK7fxVuEHE+9s7Ip+
	T5190SrN8uH9btC5pM4i3uWyBWoT+4SkMAdj2t05kCEnt6oZaUhHCKxJCRwGKFvCPU3b1SZHQ3x
	YvyNRNhby1RLXLiKLMzOuRyx0GrSnmR9Y
X-Google-Smtp-Source: AGHT+IEcb4dfJUYXpytlREo5z9Ci+JV9cC90KSbMDyS2ecvUgX7+6rP/2WFVHzMO9molCyYJX5cGCw==
X-Received: by 2002:a05:6214:268b:b0:6e8:9e9c:d212 with SMTP id 6a1803df08f44-6e9004f8506mr266151816d6.0.1741660360466;
        Mon, 10 Mar 2025 19:32:40 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bec2sm66227406d6.6.2025.03.10.19.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 19:32:39 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:32:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 kuniyu@amazon.com
Message-ID: <67cfa0c7382ef_28a0b3294dd@willemb.c.googlers.com.notmuch>
In-Reply-To: <fe46117f2eaf14cf4e89a767d04170a900390fe0.1741632298.git.pabeni@redhat.com>
References: <cover.1741632298.git.pabeni@redhat.com>
 <fe46117f2eaf14cf4e89a767d04170a900390fe0.1741632298.git.pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> Most UDP tunnels bind a socket to a local port, with ANY address, no
> peer and no interface index specified.
> Additionally it's quite common to have a single tunnel device per
> namespace.
> 
> Track in each namespace the UDP tunnel socket respecting the above.
> When only a single one is present, store a reference in the netns.
> 
> When such reference is not NULL, UDP tunnel GRO lookup just need to
> match the incoming packet destination port vs the socket local port.
> 
> The tunnel socket never sets the reuse[port] flag[s]. When bound to no
> address and interface, no other socket can exist in the same netns
> matching the specified local port.

What about packets with a non-local daddr (e.g., forwarding)?
 
> Note that the UDP tunnel socket reference is stored into struct
> netns_ipv4 for both IPv4 and IPv6 tunnels. That is intentional to keep
> all the fastpath-related netns fields in the same struct and allow
> cacheline-based optimization. Currently both the IPv4 and IPv6 socket
> pointer share the same cacheline as the `udp_table` field.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>  - use RCU_INIT_POINTER() when possible
>  - drop 'inline' from c file
> 
> v1 -> v2:
>  - fix [1] -> [i] typo
>  - avoid replacing static_branch_dec(udp_encap_needed_key) with
>    udp_encap_disable() (no-op)
>  - move ipv6 cleanup after encap disable
>  - clarified the design choice in the commit message

> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
> +{
> +	bool is_ipv6 = sk->sk_family == AF_INET6;
> +	struct udp_sock *tup, *up = udp_sk(sk);
> +	struct udp_tunnel_gro *udp_tunnel_gro;
> +
> +	spin_lock(&udp_tunnel_gro_lock);
> +	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
> +	if (add)
> +		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
> +	else
> +		hlist_del_init(&up->tunnel_list);
> +
> +	if (udp_tunnel_gro->list.first &&
> +	    !udp_tunnel_gro->list.first->next) {
> +		tup = hlist_entry(udp_tunnel_gro->list.first, struct udp_sock,
> +				  tunnel_list);
> +
> +		rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup);
> +	} else {
> +		rcu_assign_pointer(udp_tunnel_gro->sk, NULL);

not important, but can use RCU_INIT_POINTER
> +	}
> +
> +	spin_unlock(&udp_tunnel_gro_lock);
> +}
> +EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
> +#endif
>  

>  static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
>  	netdev_features_t features,
> @@ -635,8 +667,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
>  {
>  	const struct iphdr *iph = skb_gro_network_header(skb);
>  	struct net *net = dev_net_rcu(skb->dev);
> +	struct sock *sk;
>  	int iif, sdif;
>  
> +	sk = udp_tunnel_sk(net, false);
> +	if (sk && dport == htons(sk->sk_num))
> +		return sk;
> +
>  	inet_get_iif_sdif(skb, &iif, &sdif);
>  
>  	return __udp4_lib_lookup(net, iph->saddr, sport,

