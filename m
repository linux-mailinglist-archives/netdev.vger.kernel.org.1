Return-Path: <netdev+bounces-243920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E83D8CAADEA
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 22:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01687304FEAE
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 21:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0898D29C339;
	Sat,  6 Dec 2025 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUoF1fYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717B2222D2
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765056409; cv=none; b=h6BiHt1Yyf+A2HbrBXsWsGSUSRqU4R25ej8iR4ikOY2wzM1SnRa2h3JlVlCQm2TNChH0Vp0QGu43svVtBx9CiPGMa89sGSk5n/WIUO/Y4BsbCqKWS3yIhSA3xZ2Bxfu45dgWIb5l37VBeZjpCggx0QiPtSuhrr7WxMYUmJYDoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765056409; c=relaxed/simple;
	bh=+AkkaljOphqLh2uo3jDJPVsDdFyxdZBQI/6nMBQQGTc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ai+oFr1ywsPDbzXNUFDsYxpHE2+9ZbFYfvvYLL/q9LrfP5R13lGHqRbZmwnzxghXfGojlV3Z/qFGbU8yHUzXMO4QvkayCp6EstJUIkPE6fcV299YrdSopy9Krk3ZqTAjiTDSIOWGJOjQgzOsaW9jHO3+Z1Gl3aKhTYoWF2KzLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUoF1fYJ; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63f996d4e1aso3647479d50.0
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 13:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765056407; x=1765661207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U56e9HYR/KD4xmjOdy4dmke3gmK4x3rtXLtXrPC8YJE=;
        b=gUoF1fYJl2FlBxjpqtebelDFgfn3vOS3b6ulakilRB/gkkVcggiZ1Q63afj0VCTJ+b
         PHjTk3Q6cCmNriBqb87HW9kwiyXzs9V6cSy71j4yJZzce8lVwoENU8tVYIjXG3l+huX6
         1gu+VnUlLK5KW1wo7uK9jeVe6yrxOOkmKICi4X01BxpG+npTmp5gwj5IwiqhK39nO/DL
         tMuZl4kO9v2SCTFFgq9xsOgQNeVlnNJUZZG6bIA/QkcgV1Xx883tmZdxBG8Gc4A8MjG+
         4tA/36rlVR1O8+J+M8OLkIEDax2IJY90EV0485427ubDNwYF1ilyvs6wb23vG9SAfp+t
         5Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765056407; x=1765661207;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U56e9HYR/KD4xmjOdy4dmke3gmK4x3rtXLtXrPC8YJE=;
        b=tT+vOQW8lcsvZZlLtQyTgsjVNnHGu53esYMHrOh0Hadck3MAjSVepO2oL65Qro2Deo
         zaqhkYMlhOUp4uoa5VCoz1egM1lGRnpi1f4rG/Pc3LvhbGiO3b0nPO1S459YrASmw3fC
         KSIht+ylhsv7GNWIsrcMW8pGOB4nbDdLCR36tAuuN44p++SJ3ec3xon0ShEMm5EPrtY2
         yGzDtoCX5Ob9/fawjjx+jhVtDsOT+BnW7ivARc5flbTjCsYSH8PIfbGh0RS9CAtY+cIJ
         SFUJ5y+BK0sn58CRre4qgCnAOT+DUQMWG0Q0Wc3RJQtFQg0aeQc6Uv7NibraL25X3h1E
         sLbw==
X-Forwarded-Encrypted: i=1; AJvYcCUkCeZkolPCxK15b6xIQ0iaDgl7/7TQEAcXqU5SL8nc1SpRqfEVqsNfUFB1StnATtt4olsXPYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAvjYrc/kMl7zYjWx4HHPf4cgDGFzRFK2S2EIVKUKzYYBy+kCw
	Hr3JRZTFfemlo39JJzi5WbufITvjx6zDa/SgDfXc4uh0SUIw6FH+yZ4W
X-Gm-Gg: ASbGncs7ZR3qleoBiHKqY0ZcLLqQTBR8+2yWB9jqf9lM9XUhHupzUgl6uMluEet+kQj
	7enhTdoSmNtjrfwWWpnHiQ7j6TPMbniKNRlMSEu0uvaW7HUjVr/KQMThDX7USgQMQi1usDa6rl8
	4cHxu1hFRKNNOCbkyQZKMpYfftAxRjHS4VPaka+5r2bQo3gxe9ugkA+mzvcDwW+cw8mkb4o0Bif
	etebE1Oopaiq+oc0ZYt1RZ0y0Hgp24Y1TT7kb63ZqCEfMdWLTAXEYcZQhRJ2STy3VG6OJvVN7Nv
	d6RBw7wzOPO/vHOnFWVcqYS2gK27YQlnx94gQXgyMhPrvo7OejB6RjDaocG34t/K/CZgtRp9V6g
	ekETFh02dn0Kq8H5JOaLE2tr0duqddIJHidDK5BbmoC64F4FYWbRVsUzImAcNg3U5PhX5kYyPAZ
	qS1/GGBpO16St4kkMI4F9lDeXFm/o/w5HoMcw8v1yJ7sY8Q4FiH2OpMY92h++VUDP/qn4=
X-Google-Smtp-Source: AGHT+IHZ9iLV7APHz1+Nitn+ctuBF0Em5EdoPm6bSuzEr+AS+vfgayx2cP7pz53IExvIbMScehZU4Q==
X-Received: by 2002:a05:690c:6913:b0:78c:2f4a:b6a8 with SMTP id 00721157ae682-78c33c76697mr32865897b3.58.1765056407352;
        Sat, 06 Dec 2025 13:26:47 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b4ac94dsm31353957b3.9.2025.12.06.13.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 13:26:46 -0800 (PST)
Date: Sat, 06 Dec 2025 16:26:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <willemdebruijn.kernel.29a0666ba5355@gmail.com>
In-Reply-To: <98a7e20010265e3ebf9d7e6d6dfb7339d5db7b99.1764943231.git.pabeni@redhat.com>
References: <cover.1764943231.git.pabeni@redhat.com>
 <98a7e20010265e3ebf9d7e6d6dfb7339d5db7b99.1764943231.git.pabeni@redhat.com>
Subject: Re: [RFC PATCH 1/2] net: gro: avoid relaying on skb->transport_header
 at receive time
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
> Currently {tcp,udp}_gro_receive relay on the gro network stage setting
> the correct transport header offset for all the skbs held by the GRO
> engine.
> 
> Such assumption is not necessary, as the code can instead leverage the
> offset already available for the currently processed skb. Add a couple
> of helpers to for readabilty' sake.
> 
> As skb->transport_header lays on a different cacheline wrt skb->data,
> this should save a cacheline access for each packet aggregation.
> Additionally this will make the next patch possible.
> 
> Note that the compiler (gcc 15.2.1) does inline the tcp_gro_lookup()
> call in tcp_gro_receive(), so the additional argument is only relevant
> for the fraglist case.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/net/gro.h        | 26 ++++++++++++++++++++++++++
>  include/net/tcp.h        |  3 ++-
>  net/ipv4/tcp_offload.c   | 15 ++++++++-------
>  net/ipv4/udp_offload.c   |  4 ++--
>  net/ipv6/tcpv6_offload.c |  2 +-
>  5 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index b65f631c521d..fdb9285ab117 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -420,6 +420,18 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  				struct udphdr *uh, struct sock *sk);
>  int udp_gro_complete(struct sk_buff *skb, int nhoff, udp_lookup_t lookup);
>  
> +/* Return the skb hdr corresponding to the specified skb2 hdr.
> + * skb2 is held in the gro engine, i.e. its headers are in the linear part.

I thought "being held in the gro engine" intended to mean behing held
on the gro_list, i.e., p.

But this is used inverse, where skb2 is the currently arriving packet
and skb == p. Is this intentional and am I just misunderstanding the
intent of this comment? Or is the comment intended to say

"skb is held on the gro list, therefore [..]"

> + */
> +static inline const void *
> +skb_gro_header_from(const struct sk_buff *skb, const struct sk_buff *skb2,
> +		    const void *hdr2)
> +{
> +	size_t offset = (unsigned char *)hdr2 - skb2->data;
> +
> +	return skb->data + offset;
> +}

