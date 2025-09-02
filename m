Return-Path: <netdev+bounces-219254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7051B40C94
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97994822E9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C4340DAA;
	Tue,  2 Sep 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjd20ak1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A82D6E4C;
	Tue,  2 Sep 2025 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835772; cv=none; b=XZIwlsUxvAD5AeDBndRHjFQG0S+t5cpa3N90mzd9XBqF7BOSAYwaWu4IqBKqsVIBTa/HlmE5dy+GAf5lK6t6v756BrFGljSL5xHKSt9Udsjeh8+XG8Urq6YZ269gPqbZAaGOdexbA1DB90VT4aj/qxmsxcTr/kgxE6pzJ9yHOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835772; c=relaxed/simple;
	bh=nUIv0T9cl2reI+pj8w1YZiBBxoXkMMt5PsKonDFcwe0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=C1Dqm3Uub+nZaxEBuiMcdo3zFSvasNVHlJqk9Q8ocnrlQHKmGA/+neoYRHz1v31BTmJkkfSI0WNZFRA3tfh64t6T7fwFmmf9Z2aQRxXuh/1cz8pYl1J6isDVKCqITXNtfslVzydavOyMJLxYqKcRwdVdKKxjvshaSYISq8zNN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjd20ak1; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e86faa158fso15220285a.1;
        Tue, 02 Sep 2025 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756835770; x=1757440570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddHpAd9jtZb7IpqveANd7DVR7MHkX6ew6+3YAHzckak=;
        b=fjd20ak10HThblhILiWX8SFSh9w65z+LN3XpPOpppDCe7R+i/TP/Ntyq4DVXBQ5tgJ
         O+CkH0Bp2VcggQwzhG9r9c4/PBkfRxXF3RAVjZ1X4a7km5c8vcv4sd80DeGI4bsJXPOd
         dD7kZCi1w6bpU+PzD4loNxfgAg3NSDww7rKGsMf/ZHxD+szzGx6/AERvmzVZHtI/jQBe
         tYwijLj+zY1VsdIp/i/nM/aXRpnAmuP8C92M3xy0VsYVAsp52NUjz4PKqfjTpg03JSRx
         NZwbbpIjpEt1dXZznwL5Ff+tpBu4JdlI11Qv3WmHaOkAoT0Dqj9uT4FYHrpsVKNpbJe0
         VePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835770; x=1757440570;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ddHpAd9jtZb7IpqveANd7DVR7MHkX6ew6+3YAHzckak=;
        b=MQJ3L4OsMuNhRV+NWPQXkXYL4RBYua5tbOwVjZF1AnWyDugRenpNFZdFp8G9HfuYfA
         yMhk8tmdg8P9iEglajFtRxhYmz0hJRHZbEclkddBRQ2JgMzowSdETYqs0Jsdxg/9CqsF
         lEGSBJ9zgEByMOG/kFksG1oA34zWjA+X7l/pB2SkU/xv13nxtSLGOHz6MulCDAV6xBOH
         ryxyOoqJ8ck5Xh4C1JsYyV5dfJhT7pM/u0kSwVijJsJ9khf9xquNIaGcyTDqysMJ2HmT
         /6W0tNMCnWR92va5AQM35K4agXkQeWsbm9MahPzS9tVYZRxpO0UObolxeyEmoQuyyFa1
         7iAg==
X-Forwarded-Encrypted: i=1; AJvYcCVYaRJhti2/x1Rwp75v1KeMjuuZbWHe5BZ+V5N3zNsgKqiWdytX/0KSHes8HAJhJj3G+RCXGkXE@vger.kernel.org, AJvYcCXGM4gQ64TkzQDjwhL4y1zmICbvlN1ynPHaZMjAJiXrbj1mnKIK5Tv7hdcJVdFnr1gNoMsu7tShXAfwxMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQ5HPMhdBMv6X0F5KfpcFK2PScCNizgtnZ6aAuUU4M3aPSG7z
	O0tPtdLlZeLoZE/GRU4cVeY/NSE3pF9tRgpxJtIuKxUnbnbZJv/Buwwz
X-Gm-Gg: ASbGncuJhc7aRO9ol5vnmduSrt4pIWdFI9vCIetvM76GXkBJldjTKOXkJdcrjokVhMJ
	J7pVE9kmZMmXBdaj84DHCNM3hxu81z9V6DfCrhuIODkxOoZqxqylh7jL/6b5eYawtHS6d4vep6N
	a7mXNS89UjeR+sWKeMVGG2hz136NVnCUnSrzn4vreyuFTkOS8D3PbQZgfjTzigQYmP4wiWJBO+8
	6XP7scFv26LGREu/C/S5e5iTPcPQLqbVVjE4L45ICdOvfvk/69ditEk2rdwKxXNqgEOrwTDW1vH
	1a5qZ8WWb0PfbZknuepzLSsrl/AAx0HX2ieBxltr7JIfE+j4qN74kaJugYHf81CBgNxAd/g80H1
	e7DiNVYHD5SAt2BG7Dyp2yfCS9k4ptFk9iCz4NLq5ykoG8OmsJrEE4VR/mPHV6/8G50SAobk/Vw
	Ve2CS0AIC1PlE7
X-Google-Smtp-Source: AGHT+IGxvreFIZ2AHC5OSH4MGuo7yUGRwSUzwFC4IxvE6wbKI6ZEXzDEV6R7r00UVe5aK251ZsDjnQ==
X-Received: by 2002:a05:620a:370b:b0:7f1:51e6:50f7 with SMTP id af79cd13be357-7fed6028193mr1317152685a.20.1756835770048;
        Tue, 02 Sep 2025 10:56:10 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8069c1532ecsm168639885a.32.2025.09.02.10.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:56:09 -0700 (PDT)
Date: Tue, 02 Sep 2025 13:56:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 ecree.xilinx@gmail.com, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 willemdebruijn.kernel@gmail.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.c2757acce463@gmail.com>
In-Reply-To: <20250901113826.6508-2-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
 <20250901113826.6508-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v4 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
> This frees up space for another ip_fixedid bit that will be added
> in the next commit.
> 
> udp_sock_create always creates either a AP_INET or a AF_INET6 socket,
> so using sk->sk_family is reliable. In IPv6-FOU, cfg-ipv6_v6only is
> always enabled.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h      |  3 ---
>  net/ipv4/fou_core.c    | 32 ++++++++++++++------------------
>  net/ipv4/udp_offload.c |  2 --
>  net/ipv6/udp_offload.c |  2 --
>  4 files changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index a0fca7ac6e7e..87c68007f949 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -71,9 +71,6 @@ struct napi_gro_cb {
>  		/* Free the skb? */
>  		u8	free:2;
>  
> -		/* Used in foo-over-udp, set in udp[46]_gro_receive */
> -		u8	is_ipv6:1;
> -
>  		/* Used in GRE, set in fou/gue_gro_receive */
>  		u8	is_fou:1;
>  
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 3e30745e2c09..a654a06ae7fd 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -228,21 +228,27 @@ static int gue_udp_recv(struct sock *sk, struct sk_buff *skb)
>  	return 0;
>  }
>  
> +static inline const struct net_offload *fou_gro_ops(const struct sock *sk,
> +						    int proto)

no explicit inline keyword in .c files

otherwise patch LGTM.

