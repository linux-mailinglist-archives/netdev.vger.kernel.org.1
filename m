Return-Path: <netdev+bounces-201659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971DAAEA3F4
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C803560859
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AC1C9DE5;
	Thu, 26 Jun 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0ztzCzf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592418871F;
	Thu, 26 Jun 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957312; cv=none; b=tk+pSOxzaLej8EZtytapmI+adGHOvY88MLlxNSq7vjwB/6PrBBEVl+9lJmC+no7dtYeQTyJ3pwU/1l5Q8vyzikhvdGmKeP6Eng74GUDrp2qucFKUkCKfFK/bs4U3d2KZGsWmYgo1aUfQkIE6Wk6ALk1m31bQAEMJg2mzYx0DWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957312; c=relaxed/simple;
	bh=A47JsGFJAcdfZoN9cJAf31aE1xI0U994JLP8UH8NTPE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DLyFgu+20UUpoIJS0r2RuaVqJCCl/tEXgQtPruF1JzQsfBHEhL51J/uHzAxyJwRa51jP8iC4z+FBMZcUjMUFt8gqUJm6VSaeSquNylwOijRuqMY4+1wzgE5/FBNG4qKvpO/vwwFSTl1wZqGiEzuSY6GgEgcJpLhkxSHNtuJ83bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0ztzCzf; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-735ac221670so605817a34.0;
        Thu, 26 Jun 2025 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750957310; x=1751562110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0eJ0w3IISHrbGn+3mnx3nM/2RGegTot8OFcZDYvJ1g=;
        b=b0ztzCzfvZK3FIK2N+ilrL+vVGEQaOtWJvBtfcRP82tsl+s2TOy3Py1j2N0hO3VNux
         E1jqVBHLmd5n3Ne/dxKTGWpU2vCoky/p2iHzwpf70Wh6xT9CUoEUwxtOKoeQyPcydf2m
         F+of8zYUtprNCc0KivGws2CKfK3p6wAlHA7JAIXTodCtKCgEFIWQAfOcIZsD3opzWhXN
         QwAyLVN04/fQW7WvF5yzmN2xls4b7YE8Gvf/dNHx1tiImwA6QhkKPCfcpi/A4nql8aIQ
         lbAMroMkiXpF7cPWmwYLS1+CWpLPd6M1oZRz1dtHpxunktdwnFxYo3LJ7TL6Ma/HWcXr
         syiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750957310; x=1751562110;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0eJ0w3IISHrbGn+3mnx3nM/2RGegTot8OFcZDYvJ1g=;
        b=S5gcVWnX0RkXFhF4Wh/dfhNgfG6SgTXhH7MT4+82yQIzEnmF3ZDhDdPHCQdfXGbaI4
         R2tkAbQ8DgKtO8JsRB2UbCcSpc0p1RkCUVYpHofuLNX2dmtBjZkM1X9mXc4N1lFMkZN/
         W58d+F0QOi5ukt7ebXWwd0bMS9Jo5XqWvkkcIup0LxrqiEG46IsJ0gJF+15hYnwT2P0k
         hikfBP/maNr4zny515bAJ0jVHdenVsoQGWxEEXV6p/3Blxds8zWuJ6j6Itmk1aYmRJFC
         863v/S30dkyOtkmtxH5E1GYxOF3nTCVgNukz5GCZ0pYMdk01hdh+8TKroMv5mY/bhJX1
         Ghdg==
X-Forwarded-Encrypted: i=1; AJvYcCWksoaFyp03VL6QXBBSY+QQ7BWHFGL3f5mGgOhiZHudbvlr3kqcTNksQY++bWaHB1CEkdONowbtZzR5V6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRqqljNzc4I258muhELyAtUEh7UpQ/uNNd9tSK9tRbYXtFQ/C
	Ks7P2f45LyxQMsrXr2nyA5URVl5OVEyaACc+za4huRw3GzMGtBhNsAOH
X-Gm-Gg: ASbGnctvpYoG9OpjO9SvQyEX7q/NSXxbFQMpx6QEP0LliBmymLpQA34YgEiz14/5zG7
	7Ug/8Xu89F5SICdAeA230yVQh+HyQNTXJ6PdHZIlkLoOy4PokTeTibPjW4lZW5eFOwkq4NOr/US
	qbypP4VmUISm7TwfE3EMxlOYCizPEyGbm7LqFBwfLHecI8GCqu6DPrgwi1jjEKb0eHmQiWeI9JQ
	5cdeJzdmin72kT4alLMNw6FCruvZkmYS70mijrcxsCGe+CjAeNYAZtQN4hpHdRpfCdhkj4NqJQS
	OYwEYZRfULJq18yJHnUdg2dqulyvUXlrmr6xz6mj2xK4PxtuzJTgWgnDEG5OonBc5vf0AB+N4Py
	X8AAZ5Ve55BrZu9T+/8xLQXeHbv0oRnhBfbHJ++AtzA==
X-Google-Smtp-Source: AGHT+IENq0OGATXAeZtTIjTi6POBzk1nJkKYSRJ6g8vF7jgMMKhUoAhAhCQrsVa8ttOQpx+51KbhoA==
X-Received: by 2002:a05:6830:33f0:b0:735:a6df:babc with SMTP id 46e09a7af769-73ae9dc1bc7mr1856294a34.3.1750957309802;
        Thu, 26 Jun 2025 10:01:49 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c1bfdesm663017b3.54.2025.06.26.10.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 10:01:47 -0700 (PDT)
Date: Thu, 26 Jun 2025 13:01:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
Message-ID: <685d7cfb42c5b_2e676c29462@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250620-netpoll_fix-v1-1-f9f0b82bc059@debian.org>
References: <20250620-netpoll_fix-v1-1-f9f0b82bc059@debian.org>
Subject: Re: [PATCH net] net: netpoll: Initialize UDP checksum field before
 checksumming
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> commit f1fce08e63fe ("netpoll: Eliminate redundant assignment") removed
> the initialization of the UDP checksum, which was wrong and broke
> netpoll IPv6 transmission due to bad checksumming.
> 
> udph->check needs to be set before calling csum_ipv6_magic().
> 
> Fixes: f1fce08e63fe ("netpoll: Eliminate redundant assignment")
> Signed-off-by: Breno Leitao <leitao@debian.org>

On second thought: small nit: net/core/netpoll.c patches generally
only have netpoll: as prefix, not net: netpoll:

Also, perhaps just revert the offending patch? Revert, rather than
forward fix.

That said, current approach works too.
> ---
>  net/core/netpoll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 4ddb7490df4b8..6ad84d4a2b464 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -432,6 +432,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
>  	udph->dest = htons(np->remote_port);
>  	udph->len = htons(udp_len);
>  
> +	udph->check = 0;
>  	if (np->ipv6) {
>  		udph->check = csum_ipv6_magic(&np->local_ip.in6,
>  					      &np->remote_ip.in6,
> @@ -460,7 +461,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
>  		skb_reset_mac_header(skb);
>  		skb->protocol = eth->h_proto = htons(ETH_P_IPV6);
>  	} else {
> -		udph->check = 0;
>  		udph->check = csum_tcpudp_magic(np->local_ip.ip,
>  						np->remote_ip.ip,
>  						udp_len, IPPROTO_UDP,
> 
> ---
> base-commit: 720d4a1714e78cfdc05d44352868601be9c3de94
> change-id: 20250620-netpoll_fix-8c678facd8d9
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 



