Return-Path: <netdev+bounces-163750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC578A2B790
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55ADF1652BB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA10130A7D;
	Fri,  7 Feb 2025 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLyTIHNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF121422A8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890106; cv=none; b=SRP3euIbByAXvv3SK69gGcLuPeI5IjyI10Rxkep4UC3YEsgGvaC8bp1YC8W59RAJDO83DDfVoev+Zpc+lvILV4SF3bJYzuRABdDdN+H9JMnO/aXRCSEWxoRuUFH+qI47u7/Gk6vHiW54bKIHtuXFK11ZKOuadCZOX0n5myOFyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890106; c=relaxed/simple;
	bh=sUV0LhiRWI6KiMOTimLFznEydlBBOljqaeIHcCqzQFU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GpcU2uezfvPNjTNwfAHJkPzGVhEAwssny540ob6OTUIk0DWqy0tnuObubU0pEuhihmpjj2d+mccg+2Kaaxg98K+a3C1NLPZIqm5pOl6uBzJIgpWe98waUDyn2DP6isZtTh/goywrNqyFBIQCO22Gm5Y+EPsw/RHas7l4gxeJkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLyTIHNi; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e43c9c8d08so11789746d6.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738890104; x=1739494904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+DyR1DTfwxiRPfUlS/owlTlhTqvgoEEkxvA8TcBa+A=;
        b=mLyTIHNioWLyRecnzCMDZZJ4ahOJeDuxnT28218cbTVKvpAd9P8J8ZtDUewhwNJQXO
         pEQITpnTHi9SZbQeKtpI7h+XecspCaEsNMQFORLUCxSCnBoyHsSufTD4Bh8R4I26yneQ
         l6klJ4AInVQjnnKxroemnLf3DqSNgzF5JRxRPrXijZwmBL5AktdRNXMdrYn05/uE3Yxf
         Ii0cGQq8UNqEnF47yU/z1qJCI+sJHn6dec5mJU2x7PyH1modUZuQXmqrfM1jyMH4fbNH
         eEeSb5KZoGuLav5/xgG54K7nrH7dVejcsWTD6YCjaMRFhImUIbI3CBGIwFTTxsBzEc7E
         NH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738890104; x=1739494904;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+DyR1DTfwxiRPfUlS/owlTlhTqvgoEEkxvA8TcBa+A=;
        b=L3dYTLhrrt3a80yRXAUrnf4YxfAZ8P2R125QiqkhKqw0yKUwaE+48+PaYaMReppP4d
         XJea8xTCAv/9g68T+jS+6n+914i3oOlpewHU40UYbKVp0mhcVgmPTGnMhyo92nrc1w1e
         F8J4h3EFntKoUBBMMDXcrVqsHO0LhKsg2gRbFxc1bd+zhaiQdVsZEsoc9lZZXoo7+Ydv
         rwN0Lo8h8P1eG5zc1hR66u5h7mbbqxmffyjLbsDQgtYejGskCpj3aTCVv8SfdNhjUwU3
         ZHCfJeGlU/SE6re1wM672tz+/f2bqneqcohbyx6QKxwzcwT4adEyoql8ABbuOaJxJrCi
         wvcg==
X-Forwarded-Encrypted: i=1; AJvYcCWlz4tWoYyfdVeqNNwQLndLZJCyxYFe0IjU8M8qSvH28u1QK5d/OPlgHsMcAMwKBp7GTjxfrmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Q1AWGFNy3vn/IFC5x72+Lv2Tc15DK7LcuYYakEGnnMEcmMoY
	FH3tFvcePr8irtSz0TpjZ/udTTp0RKPY0xUzsBS5fZxWdYgD4mgz
X-Gm-Gg: ASbGncssCGy7ohsVdE9DZ7Cu4BYOf7HNeMzyTeMcbMSifV1FVD7eJTpkkgMfjQGbWRf
	JErW19R0UWZ5EFV45uwKJJFFCAzO75kKN7TtAHhzkpp9ZyVCVzYwv3K9FsdG+n9QZsvT3ge1ev+
	4MseuiXBeC8Ng6HUgqhk86qnyLwSopkNxB14tSkGEEeoXpm+VwMEAjfGElE5GeZke0NuILrUvpF
	+aa2ijqmel2sGw9SfQwUBnJed+cFaJVEVaQd/8/auk3TYh++45O0XxZCxyh38pN8Yez0Scth4i/
	4Stq++c4KD7yGCnl/4g06N8DwnDHDa74WTg0VJWb3IY2seTIK6X55Rc+HAHEQgY=
X-Google-Smtp-Source: AGHT+IFB3jKA25qqkkoUky8DfRXQHG/fztwrwBXXXvemXvoeEnZahxiq3dU1XuEi0y9GmtN8ZRO4Cw==
X-Received: by 2002:ad4:576b:0:b0:6d8:8390:15db with SMTP id 6a1803df08f44-6e4455c95e4mr15432146d6.6.1738890103745;
        Thu, 06 Feb 2025 17:01:43 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e444b5ad24sm3839826d6.103.2025.02.06.17.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 17:01:43 -0800 (PST)
Date: Thu, 06 Feb 2025 20:01:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67a55b76da19a_25109e294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250206193521.2285488-6-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
 <20250206193521.2285488-6-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 5/7] icmp: reflect tos through ip cookie rather
 than updating inet_sk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Do not modify socket fields if it can be avoided.
> 
> The current code predates the introduction of ip cookies in commit
> aa6615814533 ("ipv4: processing ancillary IP_TOS or IP_TTL"). Now that
> cookies exist and support tos, update that field directly.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> Tested with ping -Q 32 127.0.0.1 and tcpdump
> 
> The existing logic works because inet->tos is read if ipc.tos (and
> with that cork->tos) is left unitialized:
> 
>   iph->tos = (cork->tos != -1) ? cork->tos : READ_ONCE(inet->tos);
> ---
>  net/ipv4/icmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 094084b61bff..9c5e052a7802 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -429,7 +429,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
>  	icmp_param->data.icmph.checksum = 0;
>  
>  	ipcm_init(&ipc);
> -	inet->tos = ip_hdr(skb)->tos;
> +	ipc.tos = ip_hdr(skb)->tos;
>  	ipc.sockc.mark = mark;
>  	daddr = ipc.addr = ip_hdr(skb)->saddr;
>  	saddr = fib_compute_spec_dst(skb);

local variable inet is no longer used, needs to be removed.

Will fix in v2.

