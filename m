Return-Path: <netdev+bounces-95144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1958C1810
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B0B1C21104
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 21:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC384A50;
	Thu,  9 May 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="zJYnrRIL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466F78C98;
	Thu,  9 May 2024 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288915; cv=none; b=PoG7t/6Du4ecwn2B4OBn3Yojo82v7XxceM2Hcrd3Za+aHtK53JeWQW9mDibUDI0oOPBTquDJYDrrpB1D/xS9P+2NBH5eH929Qb5/3R5tDGakUsqM0C5H65hriEi7oeYO5wCa0jyqpVohUBcW2DSbikd6laqwy4nJ/g5LlIz55Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288915; c=relaxed/simple;
	bh=B+tz+/pwbJIwID1oHTpk2MJK1jmegWdaI9yVJKU+6vo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=MnKAWRvRl+D3H2lWzGqMR/Kb8fJ+bMyjnQmVWfd+LmuLZLXsutcs8UtoMyteaYoZdhAbiyEsNpsxKw/MTIGHvbVkxgyakesuXBU11JMDuifeedWnvYOPG4UkF/rT9N5uWU7PVzRWsLEnBfectO16tTbfBmDQENrONs1P7N3Mnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=zJYnrRIL; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:f8c1:ac3:4d22:e947] (unknown [IPv6:2a02:8010:6359:2:f8c1:ac3:4d22:e947])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 301457D8BA;
	Thu,  9 May 2024 22:08:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1715288907; bh=B+tz+/pwbJIwID1oHTpk2MJK1jmegWdaI9yVJKU+6vo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<e6939885-7ba3-e46c-779a-ac5f8367d08c@katalix.com>|
	 Date:=20Thu,=209=20May=202024=2022:08:26=20+0100|MIME-Version:=201
	 .0|To:=20Samuel=20Thibault=20<samuel.thibault@ens-lyon.org>,=0D=0A
	 =20linux-kernel@vger.kernel.org,=20tparkin@katalix.com,=0D=0A=20Er
	 ic=20Dumazet=20<edumazet@google.com>,=20Jakub=20Kicinski=20<kuba@k
	 ernel.org>,=0D=0A=20Paolo=20Abeni=20<pabeni@redhat.com>|Cc:=20netd
	 ev@vger.kernel.org|References:=20<20240509205812.4063198-1-samuel.
	 thibault@ens-lyon.org>|From:=20James=20Chapman=20<jchapman@katalix
	 .com>|Subject:=20Re:=20[PATCH]=20l2tp:=20Support=20different=20pro
	 tocol=20versions=20with=20same=0D=0A=20IP/port=20quadruple|In-Repl
	 y-To:=20<20240509205812.4063198-1-samuel.thibault@ens-lyon.org>;
	b=zJYnrRILKLLXI1ewJyke6L392b/nG9jT18B90E0H/rk1qU5W1gPWsjO97mB36EG5p
	 c54N8LLgG/V/afpyatLxFzbYH/J0szE305YcLy1/REOS90T/jVWIw8MZHelmY1d3+5
	 WLsz7hv6NlLDyYbEufAGT6soVhR1kI+593Zyw8UfI0nirMgApUQtaHRV35zl8gr9Va
	 h/Oe6VdAimUNX8uNVMz5j6LG4wdyjKGJE8Oeoe57OyH5Zs+MHDWTlhbTdGh0JJVEot
	 K/z8oNQiqXqpwzbOI9dS8BfQrCysLxgFn2F0Uf0qq3mOBUceLDpLA10G1LT+46nnYi
	 kQ5P2TGD/9Gcg==
Message-ID: <e6939885-7ba3-e46c-779a-ac5f8367d08c@katalix.com>
Date: Thu, 9 May 2024 22:08:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 linux-kernel@vger.kernel.org, tparkin@katalix.com,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
References: <20240509205812.4063198-1-samuel.thibault@ens-lyon.org>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH] l2tp: Support different protocol versions with same
 IP/port quadruple
In-Reply-To: <20240509205812.4063198-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 21:58, Samuel Thibault wrote:
> 628bc3e5a1be ("l2tp: Support several sockets with same IP/port quadruple")
> added support for several L2TPv2 tunnels using the same IP/port quadruple,
> but if an L2TPv3 socket exists it could eat all the trafic. We thus have to
> first use the version from the packet to get the proper tunnel, and only
> then check that the version matches.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

LGTM

Reviewed-by: James Chapman <jchapman@katalix.com>


> ---
>   net/l2tp/l2tp_core.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 2ab45e3f48bf..7d519a46a844 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -820,13 +820,8 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
>   	/* Get L2TP header flags */
>   	hdrflags = ntohs(*(__be16 *)ptr);
>   
> -	/* Check protocol version */
> +	/* Get protocol version */
>   	version = hdrflags & L2TP_HDR_VER_MASK;
> -	if (version != tunnel->version) {
> -		pr_debug_ratelimited("%s: recv protocol version mismatch: got %d expected %d\n",
> -				     tunnel->name, version, tunnel->version);
> -		goto invalid;
> -	}
>   
>   	/* Get length of L2TP packet */
>   	length = skb->len;
> @@ -838,7 +833,7 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
>   	/* Skip flags */
>   	ptr += 2;
>   
> -	if (tunnel->version == L2TP_HDR_VER_2) {
> +	if (version == L2TP_HDR_VER_2) {
>   		/* If length is present, skip it */
>   		if (hdrflags & L2TP_HDRFLAG_L)
>   			ptr += 2;
> @@ -855,7 +850,7 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
>   			struct l2tp_tunnel *alt_tunnel;
>   
>   			alt_tunnel = l2tp_tunnel_get(tunnel->l2tp_net, tunnel_id);
> -			if (!alt_tunnel || alt_tunnel->version != L2TP_HDR_VER_2)
> +			if (!alt_tunnel)
>   				goto pass;
>   			tunnel = alt_tunnel;
>   		}
> @@ -869,6 +864,13 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
>   		ptr += 4;
>   	}
>   
> +	/* Check protocol version */
> +	if (version != tunnel->version) {
> +		pr_debug_ratelimited("%s: recv protocol version mismatch: got %d expected %d\n",
> +				     tunnel->name, version, tunnel->version);
> +		goto invalid;
> +	}
> +
>   	/* Find the session context */
>   	session = l2tp_tunnel_get_session(tunnel, session_id);
>   	if (!session || !session->recv_skb) {


