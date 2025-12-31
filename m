Return-Path: <netdev+bounces-246444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A98CEC4CF
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B499300941B
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F2296BA8;
	Wed, 31 Dec 2025 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htLX0VET"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA82820C6
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200333; cv=none; b=rvcN3wkx/LtSGStq4WhlNR/SxLe3hiiBktzFiCeZhQAbWoZo0p1KzmdjM9VjrOyHYpP67/0/VnkhCrIIQ17iMIZbSB0wErTWjSfvCuZANr4nGqlob9UjEu/ffEKzUFgyFANPDSkA/K1X0K/Q9b69OqKTOUQz8IrcXr+LwFKEeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200333; c=relaxed/simple;
	bh=WyqHYezKOH+DMJ0UpAwYhp8NooCaZxdex/cupUoeXDE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CqG/kEtZlZmH/1a/ufCC0U4zT5P61eZSrhc/j33HJut9m4xgqbmfIWKJfo1Oz78Du9wS3koqkW/ZV5qq4FikQAnEQQ/7UlLijka3Zj1ADlC9SZW+JxZ30/rTCzKDmhSi8obFe1iTojKeK/p7eIA0cI1ds7v/LpDwv1UwZ5Z1+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htLX0VET; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64467071f9fso8332955d50.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767200331; x=1767805131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5vfxC5LQq+6GqGCoNMY0GdxL0wTOy2eVAsq/vGyBfA=;
        b=htLX0VETx9lBm/v4kX9/AFLXocYNlwZnH8eg1yp/cX0OR5SZKqqc0nKoDq6Bsuy1TC
         kMoRIpSZtn+EmZAP/VlbpXb70UW5k0B3Zb6LWTAqEBP9LBex/SDQid9BDQjhZgSzAPkX
         vQSJrihS5MHZFaNjSUOnbDkZ3c6F4jTyL7UVVRN7u1H3F5//5pui+PalW+zki0yWcFF7
         TDAkEgbeNCn3wt5vV3wG6IFMLG5P/tPzsvMKDys017aTrZWYHDjWmj5GMByVwkTm3s8V
         yomO/UYggHgfuaDQugSE3SYcNqqDmcNUl1iGlG/8sHLQ8QEI2q1sGPDZU1ApFgptBY7L
         4FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767200331; x=1767805131;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5vfxC5LQq+6GqGCoNMY0GdxL0wTOy2eVAsq/vGyBfA=;
        b=NZYfavqwYy2GocuPW606+9WrIudqPLV3N527hgOjIr7zsNDk4spDbJy8ZmpkI93hLt
         j2wXuAtorznOCuzhLOwG7ONvnyJW0mLbJDdYg+stscauRjwinHjotvzAOSCzDSqAhXem
         YfrhyzZSAkAMhPFVmYNQWtKrruqOoU2S5OOYbx3YKiddZQXAprHI58pV6CHzkC4oILbc
         nHfNFhaqTitiY4QS0NdfW/sAxYv2dFyJYQa0212uZebvNyHbSvylAvkQGf7rVaLesjNL
         kqAieLzU+5VdA+8J6DNsdRy70KU1bmkAV2Dps90esTyBVuNrfWT1ioJxEvmNerSvPcnv
         TRag==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3WIR37pimjzvJf0uQgEhvfjMGrbE/+pmx0fovvGUx7G+CFiSxeY9KBhgTo5qcnhYgd/ltG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7BsAIqHVWVVL08p0MAmy9jKeBB0a2H/FaHF4eaCgPgg9Qcgu
	6QwaHTr648k1YbZmd9KbOgujqN0rBx5IJR41K1jw8fUGYw88EQwuTkODTx5hyg==
X-Gm-Gg: AY/fxX4PSFQb6gkz3gX9PYkFZgmpU8KquMqT9nlCPRuN3EqVKIrs4hZfBGtzIuhrdvA
	X1Ow/9yYo80QyYtSUSnfugdrgZkRQXtKn3XgfX61kjfIEifyM47yv8P+7k95TC8bUJoeKbsT3rx
	uP9+xHQOOe5h37GifDPZPhgjX3E44r4XAu9ekDCZol2w1az3dYD3xDKMqyTr+jxh1OOCNrzHvy0
	ZpT5e7maFspRp3XEtq92YnDmcd1cji6Z8Jbl7GuB5lUUHhQYbKHhfavBMo1Lma9q+gFmDooC5Bn
	a5SpCJt30E7QiQkKSS+rrpi0H0e7Jg5MhzIblBk6W/eyqnkZh6nnsA4qvrLJkwy6epnPmCbuK4y
	lpT5ch00PNsAl6QXnRZsiBNNLwKE5gSfJcDXj3UWUFMadrkeF8FhOT8/2e0YF/2NsX/lfoXMYfm
	Mesop3Uha6/NUMY/vBXSpzQBGUZPUxdZ5wpMzsi5nTKFCtp8wjMhOiKTcmwJ0=
X-Google-Smtp-Source: AGHT+IEEbf1Ml/7y8rtjxwVetsP36RiH/JP8aBTm3mU6oSNB1EXZyf7kW80KkTZecm+oV8sizPnBDQ==
X-Received: by 2002:a05:690e:1387:b0:644:60d9:7530 with SMTP id 956f58d0204a3-6466a8de5c9mr30559920d50.86.1767200330823;
        Wed, 31 Dec 2025 08:58:50 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb44f0d4csm139530617b3.37.2025.12.31.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 08:58:49 -0800 (PST)
Date: Wed, 31 Dec 2025 11:58:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: mheib@redhat.com, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kernelxing@tencent.com, 
 kuniyu@google.com, 
 willemdebruijn.kernel@gmail.com, 
 atenart@kernel.org, 
 aleksander.lobakin@intel.com, 
 Mohammad Heib <mheib@redhat.com>
Message-ID: <willemdebruijn.kernel.14a62f33c80f0@gmail.com>
In-Reply-To: <20251231025414.149005-1-mheib@redhat.com>
References: <20251231025414.149005-1-mheib@redhat.com>
Subject: Re: [PATCH net v2] net: skbuff: fix truesize and head state
 corruption in skb_segment_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

mheib@ wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> When skb_segment_list is called during packet forwarding through
> a bridge or VXLAN, it assumes that every fragment in a frag_list
> carries its own socket ownership and head state. While this is true for
> GSO packets created by the transmit path (via __ip_append_data), it is
> not true for packets built by the GRO receive path.
> 
> In the GRO path, fragments are "orphans" (skb->sk == NULL) and were
> never charged to a socket. However, the current logic in
> skb_segment_list unconditionally adds every fragment's truesize to
> delta_truesize and subsequently subtracts this from the parent SKB.
> 
> This results a memory accounting leak, Since GRO fragments were never
> charged to the socket in the first place, the "refund" results in the
> parent SKB returning less memory than originally charged when it is
> finally freed. This leads to a permanent leak in sk_wmem_alloc, which
> prevents the socket from being destroyed, resulting in a persistent memory
> leak of the socket object and its related metadata.
> 
> The leak can be observed via KMEMLEAK when tearing down the networking
> environment:
> 
> unreferenced object 0xffff8881e6eb9100 (size 2048):
>   comm "ping", pid 6720, jiffies 4295492526
>   backtrace:
>     kmem_cache_alloc_noprof+0x5c6/0x800
>     sk_prot_alloc+0x5b/0x220
>     sk_alloc+0x35/0xa00
>     inet6_create.part.0+0x303/0x10d0
>     __sock_create+0x248/0x640
>     __sys_socket+0x11b/0x1d0
> 
> This patch modifies skb_segment_list to only perform head state release
> and truesize subtraction if the fragment explicitly owns a socket
> reference. For GRO-forwarded packets where fragments are not owners,
> the parent maintains the full truesize and acts as the single anchor for
> the memory refund upon destruction.
> 
> Fixes: ed4cccef64c1 ("gro: fix ownership transfer")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  net/core/skbuff.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a00808f7be6a..63d3d76162ef 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4656,7 +4656,14 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  		list_skb = list_skb->next;
>  
>  		err = 0;
> -		delta_truesize += nskb->truesize;
> +
> +		/* Only track truesize delta and release head state for fragments
> +		 * that own a socket. GRO-forwarded fragments (sk == NULL) rely on
> +		 * the parent SKB for memory accounting.
> +		 */
> +		if (nskb->sk)
> +			delta_truesize += nskb->truesize;
> +

Similar to the previous point: if all paths that generate GSO packets
with SKB_GSO_FRAGLIST are generated from skb_gro_receive_list and that
function always sets skb->sk = NULL, is there even a need for this
brancy (and comment)?

>  		if (skb_shared(nskb)) {
>  			tmp = skb_clone(nskb, GFP_ATOMIC);
>  			if (tmp) {
> @@ -4684,7 +4691,12 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  
>  		skb_push(nskb, -skb_network_offset(nskb) + offset);
>  
> -		skb_release_head_state(nskb);
> +		/* For GRO-forwarded packets, fragments have no head state
> +		 * (no sk/destructor) to release. Skip this.
> +		 */
> +		if (nskb->sk)
> +			skb_release_head_state(nskb);
> +
>  		len_diff = skb_network_header_len(nskb) - skb_network_header_len(skb);
>  		__copy_skb_header(nskb, skb);
>  
> -- 
> 2.52.0
> 



