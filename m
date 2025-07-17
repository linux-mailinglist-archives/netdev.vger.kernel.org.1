Return-Path: <netdev+bounces-207821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819A6B08A64
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A3C17ED99
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF428CF73;
	Thu, 17 Jul 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1USvtfD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A331E1DE9;
	Thu, 17 Jul 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747512; cv=none; b=k+0jkDwn8qZIqJY5fOVIl+p4y/aTSHpPRYHfu5ZZAQb6E2bym0F6QYmRfIBMgcadfi2D48OYk/TxZHeLc2OJVcyBWQqvZPC6KwXwZSItWyP5o9EVo8XWfe3nb8TZWfKy3WVvl12syNojF9FHoMu2yXCXoqbBP2n1g08HSISvP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747512; c=relaxed/simple;
	bh=UdkMaNQ5XdKn1NCcxIgSZbT+EuyNvw60BoYf1c/uglw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDmZwhOxZLn5QjpiqOIdFQCpWYWgG5sjOk/WwiWdZkz0XH0sYZX7gKmpaU6dYjQ9upp4mIJOR04kAUxWhh9MlEHe+xahXvwGavbLjHzSBWjn7u/qndRbYtrBRbtNIPLAx5+LxRTtrc2ja4GmV91JodccY0JGxtBVtjmvt4FISB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1USvtfD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so517158f8f.0;
        Thu, 17 Jul 2025 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752747509; x=1753352309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJUJCrrGY1mC5sb7uP4Q2ZDApWsnctQlMWRg7UQIEV4=;
        b=Z1USvtfDgWsTWA8LObUZws4o23BpcBZ6zeuHXE1gfu2Aa4ndcwgKuPAnYM7D4BcFhn
         QvOL33M7v3a7tozjEl2EzkiTh3zOvGooBIMQCXGOUOE3z2rwx0WT0wuiVEMLinDsguD+
         x/R9/lQWvTvz6VPLlvQJQCysqMmU+asIzCoz58i8+wJwwK34oc5mRU7mKwC9JumOBA2a
         j0xCuic4vl7OIfmpEK+5pOfeKBHtuLpEo9BTJbLL+6xM4BOam1YNELbVN4vdP85upF+M
         4Q33tWREW6H1NPtFUjfd1QTxbU2qSk8N94wL8pd9nR+MmfeBr65Qmpyu31XTPXUqab5w
         LCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752747509; x=1753352309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yJUJCrrGY1mC5sb7uP4Q2ZDApWsnctQlMWRg7UQIEV4=;
        b=oVxB+j4HBls7WYBNlVW9KYmKfj20rrrlS/9zdlJiERvJmeO9cjwzQMIujxARU6GuSs
         kOr+AFCYvzIb/NWP8oXBA4f74GbUihNWjN/z7isFzM9GkX56UkI9usXeqeiNNyAMcBre
         MZCDB7NzY2eseknrEjEY+kvAZyMkx9diTAxh7tG5MalpOKd7Vs0GbgY1CW+eEwWn5E2t
         NDXKPxObYBYIq8bLEcwl84YaAKUSxHdniX4pIxgQb9fndE/8Zb3tYzobdSn8uxJl4eHB
         yf6Zn5fW4BFooD3OnCsz05SUFK3YywKjRZivELRHykjPaH5LwIDLWwyunoOsu7JzDy5R
         tJGg==
X-Forwarded-Encrypted: i=1; AJvYcCVGx7pZkYT4jC/HFihqt4kX80iPjwpHMDU2IxLjFCTmTO0Rxvze2wFJ/kSdUch4dcCEPumoHrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RFM/tQ96MylpLrp3wM+kInDnQjjSfFXlkhUW/jWLts635ei7
	RRhtIzKV9J9VCvraVQHIq9J+Is5/KCJTx+LRQHyvguX0yrsVtXFPjUY4
X-Gm-Gg: ASbGncuTY2uHRF7aCYikPITkRLyLJ/squP9QfuIp8OPaNfE2nKxRjMc5M0SyiGiezIp
	Ej2VXi388m/IZvEZ96orEXEASjd/qoRpdBJSjYFDjNnE/9qCYvdHvRJ3osw8Nf2CBJSqYRg3oaq
	I3uNHQ0JCM6gXtD79DpUuz9PuwMg6wRJhgBPOk8KWklKNETHGgemWGHWP0bq0ielsMcEKFYJ7tr
	0MVXB7EM4uLMvvjceV/5Pa+10kQ/3Uo7qhTaAKlrxnqTB0n1XQjNkijBsfxFoUQoIOn+sVTLPlJ
	s8OVmd1ECWmdOwSy0qQkVIKQhNIqtotIpbIjqcxnvMP1TsWTfaGTw3+etVFn
X-Google-Smtp-Source: AGHT+IEDRCRoXA3j3hUcXdK6LLnmg68YMkKzm5D5pcFNpm7nGUBTMSLcudMdQSXLH9/Aa0UCq5JukA==
X-Received: by 2002:a05:6000:645:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3b613a3ef64mr2017707f8f.26.1752747508880;
        Thu, 17 Jul 2025 03:18:28 -0700 (PDT)
Received: from debian ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80246asm46337205e9.10.2025.07.17.03.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:18:28 -0700 (PDT)
Message-ID: <790b80ea-dee7-fd7b-aa42-e0cb5641737f@gmail.com>
Date: Thu, 17 Jul 2025 12:18:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org
References: <20250705150622.10699-1-nbd@nbd.name>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250705150622.10699-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> Since "net: gro: use cb instead of skb->network_header", the skb network
> header is no longer set in the GRO path.
> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
> to check for address/port changes.
> Fix this regression by selectively setting the network header for merged
> segment skbs.
> 
> Fixes: 186b1ea73ad8 ("net: gro: use cb instead of skb->network_header")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c | 1 +
>  net/ipv4/udp_offload.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index d293087b426d..be5c2294610e 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -359,6 +359,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  		flush |= skb->ip_summed != p->ip_summed;
>  		flush |= skb->csum_level != p->csum_level;
>  		flush |= NAPI_GRO_CB(p)->count >= 64;
> +		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
>  
>  		if (flush || skb_gro_receive_list(p, skb))
>  			mss = 1;
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 85b5aa82d7d7..e0a6bfa95118 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -767,6 +767,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>  					NAPI_GRO_CB(skb)->flush = 1;
>  					return NULL;
>  				}
> +				skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
>  				ret = skb_gro_receive_list(p, skb);
>  			} else {
>  				skb_gro_postpull_rcsum(skb, uh,

Isn't it better to set the network header in skb_gro_receive_list instead?

Other than that, LGTM.

