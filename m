Return-Path: <netdev+bounces-204411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45151AFA593
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384EF7A7ECD
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133FE1E832A;
	Sun,  6 Jul 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFWdrkLd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39F19E97B;
	Sun,  6 Jul 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751809548; cv=none; b=du9RlBgXBRTLFzo6Scbf45+8FAJFJ00MpgT/pwALRLz7N0W391Y72+52E+hq1Cfmd49JIOHVVS27wKNxwUpKv1YWL0OyRPGn+lEe9NhBt5HFMlJJSGWCCYLiq6Nsm6Skrn1QtsCSzXlk2WEpYOy8N2nwVR0GLxtl7OXvnKVqzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751809548; c=relaxed/simple;
	bh=FHEDS0QZAgKXgJbWG2/Cr7Ry8SPFDhRqNV9UGS2n+7s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jdYy2ibq7HSREHPL3mWyVk8XddfiJWHUtQMVBL1EA7q3WjME1xRlXznJR8/bE6ruXQVXb1sZGf3JbiZfIpNU9ezZUFFqMJwmeH815Ie6XQPW58DeKVEz8NYo7s/SSzd3QeXPrm9QAkcyckHrTh/EnGsIv6NicYMPmQSjWpSss+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFWdrkLd; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81826d5b72so1865131276.3;
        Sun, 06 Jul 2025 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751809545; x=1752414345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBYZIpHcYxpUb3Jzm70CuMo48gVL792R8BW12Oo0i9Y=;
        b=WFWdrkLdrs8EvekwcQ7IQWip/jsVCOA/5dgQBWRyAciZwBstR5Qj+WplkdHKk8E6zJ
         8b8JFq3A4yKg+/8NGr6/gQCSTrNaxznMfxzcbYGXdmzQRqQUjOtwqqZbTUGxbPJBq/NM
         MZJpH4r3qB5wHJKKeP7x/6gJSjbrAX0HRTSwyqFbDkCf8cfIBWWxnBAu6SPf70sBlR4o
         Ijc4ZUpX81HATDd6NE/JTIVsyy/4geIMDZONG8LToDyaAUlPpu/rDmlklNYaeoHA8HO7
         cvoRvfml1iDNGHBaHdZnaODIbGFQYTKnMSccpdliSYgIdame4wz01RUC/Bd/c9aHh9Qn
         y1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751809545; x=1752414345;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cBYZIpHcYxpUb3Jzm70CuMo48gVL792R8BW12Oo0i9Y=;
        b=XVymhSdp1sL8jb9ZnhIszN9iilXOzlUsWQkNc47+xQN0vE5J6G/PfS9i2wnf+NDx95
         72aBrhFal+lDpxsws9eFBspyuZUihe1TeKmZVO2NS4SzuSXAh5k2+M/X3AmRTxsEzaPf
         RrtfcmqnMpZmq2xqcsUxxHMgtYcmdN8JUR0WkqDd4mg9/v/HK2PV6MrweVBkwwduLNgo
         swoRKwzXq7tClpUkQxi/UEfndbHbzX3R7G69JpJud2rIVE6pV0/ZbAwFIzPIr9l5wTvV
         0AQQjKnjQKYF55uc9r4ycRHjqBQi6cFc874wMAKuK3twekl11py5zprvH01UWHkoR4QH
         C2zg==
X-Forwarded-Encrypted: i=1; AJvYcCXvo7MimqPgclKhvidOMTOEtNEafDHtSIdt/gaJgeuahEJDClNsJUwUXx6E07OeKasH4adqF0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCREZXyWDiXxq3uaGBFBOWzJQMz2vAd9z79nmUa7Ds59nolFiJ
	VzzSAjVEEP9PI/ZAQoC+Ows5cb/5urYkv0+vfgAl/s9Be/iycdKEpgHS
X-Gm-Gg: ASbGncsOIoa8NBVQl/Q9KDXtKBiStF1OpPPh7JAIRmRXi+rXNYYdI2d4PMMYTCdgNOe
	3Tj5ytxGd/U4mozzUC/DFMMfSKKkX8HpJEzWp+jueyBgWvSQ0WHRZILW55v90scLeNO+iRQ0D8l
	J5+hiZ+FvOmm1bjfGgJxvLZ2GmdeVOWSU1RYmQbT/7DqI8x4ICEzGhXy2D+uDLmfZW61Z5TSFSz
	Xfe/bNsYTkvA7HU7PvyE3Hh5/pQC+uhiihmV7VoiRdqkfg5/GvuM9F2OzvKqNR5fdRhJCtJEu96
	+G/LDnzjiBByn6x5OgVKwXOjO0xzZZ0cbVUwIQV0+Nny7I6BIXUiF+tychnO6emcUWXdvYG9nsP
	BeIADj+K7OSp6mnTUBMZwNYJK3uVb2Obp94ZGkGc=
X-Google-Smtp-Source: AGHT+IHoE4Y7lFX/EVffGHdYuQVe9w5o7wp6SVMXrUW5Wy9ACX5OTR6czeJZPf3AIgR97NU8FcOTiA==
X-Received: by 2002:a05:6902:a84:b0:e84:4840:7b5 with SMTP id 3f1490d57ef6-e8b3cd04e29mr5537002276.22.1751809545325;
        Sun, 06 Jul 2025 06:45:45 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c3401fasm2002251276.19.2025.07.06.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 06:45:43 -0700 (PDT)
Date: Sun, 06 Jul 2025 09:45:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Gobert <richardbgobert@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <686a7e07728fc_3aa654294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250705150622.10699-1-nbd@nbd.name>
References: <20250705150622.10699-1-nbd@nbd.name>
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> Since "net: gro: use cb instead of skb->network_header", the skb network
> header is no longer set in the GRO path.
> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()

Only ip_hdr is in scope.

Reviewing TCP and UDP GSO, tcp_hdr/transport header is used also
outside segment list. Non segment list GSO also uses ip_hdr in case
pseudo checksum needs to be set.

The GSO code is called with skb->data at the relevant header, so L4
helpers are not strictly needed. The main issue is that data will be
at the L4 header, and some GSO code also needs to see the IP header
(e.g., for aforementioned pseudo checksum calculation).

> to check for address/port changes.

If in GSO, then the headers are probably more correctly set at the end
of GRO, in gro_complete.

The blamed commit was added to support tunneling. It's not obvious
that unconditionally setting network header again, instead of inner
network header, will break that.

Side-note: the number of times this feature has been broken indicates
we should aim for getting test coverage.

> Fix this regression by selectively setting the network header for merged
> segment skbs.

 
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
> -- 
> 2.49.0
> 



