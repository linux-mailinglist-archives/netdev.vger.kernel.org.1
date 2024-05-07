Return-Path: <netdev+bounces-94098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8DB8BE1CF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327831F25B6B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10240156F48;
	Tue,  7 May 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QY69fWhW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7F156F37
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084149; cv=none; b=ob1lV0nFZqpQVJJV5D4SOi6QA0GMr3xcpZnkmxjhNf8sQdJePI0gFDRlIozE3V9JwNFIoYf0sHyKHZWV9KQuR1sGq/jiOq5XoBzN/EYZLtekWj9nTD3TFrbMb3x8obq6Ez0Ku3/YCSK8e99F/gDVxfSz5BFs+D/1ESc3L9T5Sao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084149; c=relaxed/simple;
	bh=dWYuhSmaw6zHw/xPyvKvmeoz7fmgJSbAFIN1ULigx1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnDscfUXQHUXEkkjVdU6DqKovHYo1Rs+Rpzhm75BUHHmI0pYD8kqdDsC3mGEx68OlQCJuW5fvTiOtihmZ8VlCKwc0mNlGtCdQc4SFUzhCy1YoujXRtvDpw5xW05Yf4hQd0V7Mn7UhV2Kvf27WXZfUEvl4ndRR7pmnfEZiJ10cIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QY69fWhW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a5f81af4so789314066b.3
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715084146; x=1715688946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUKfXenJAG2N5WSgqguRSHR3qBfgjkNSXZ2oXGFiItU=;
        b=QY69fWhWTMO3yG0urr8Aozglu4L7uxGOzS5TmFk/WK6iITOQanhnK1ahmYOtxnzzG8
         JYb7EDzzh0gkeDc0+BzFaf60CCXOb+IoQ7FIX6VHymQDUsxolg3vXsoOaBwUOTRSn5wP
         UjxzfaNKs4pJEDAavj89x+VfKE+yP4d2nMEHroOv4WkTGrgbQB2O6afZIK8bgmTcBBgH
         3CrZrXQYTmZvLbuz18E7KTud7+k5ytqi8GYCIbzPLOTtcif7gA8FoUbwHrofMBPsrs5j
         EJETQYi9jnHMbau0E0aH1lM9xPaBMa3Y3CaKHDB9WrTLz5o1eHR1pE9kruO79+zjKqpc
         KNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715084146; x=1715688946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUKfXenJAG2N5WSgqguRSHR3qBfgjkNSXZ2oXGFiItU=;
        b=Rzo1A+5+TbbzEOQSJDmUjP3T1OCKP6fo62zlJF2HLi+DYnA27aUNj3KCxmRnn6TZrX
         rLsgobDVZEUQAZWpsHfsOWoWYAeVuBlCtZRjc3cDwANomyZDNzBVNhx9vvcowKiqW+jx
         qn6pzP6P+q0bf0Y4O6KCllny0cmnfO5U3BJoHEPz/5rN/JJxaWNF1lKFR9xkeHb1yWZB
         kxDeSZ6Aq3eYIeRdYtb4kQ5Ge+I4VKuGS5v4cYD1Ai2045Ia+gDY0NFJ6QMfrCl00qx/
         nM7i9Y2q33vX/0qK4MT3s58gfjeUJyjoRk41bLPku1BCWz9XlzZ8nL2QJkRw632mU/Xn
         HSNA==
X-Forwarded-Encrypted: i=1; AJvYcCXx8+u0OOjX669cv4kYIBjhntm98NPfm2hv/JN1eKQYpNfq2A7sQ2aOutNgyZj5ZcMDzWRUAFS9cnP1u080b/J/vJM8KazR
X-Gm-Message-State: AOJu0YxKfnhB9JZk9lIFyVzkVlh6jny8JcIzKPFlX8sGdsQ/RQ3C+5cg
	Bi1F8TVsLaKrnTe32TXsZkpYnucp1FBJ2ne5h1RQ+0kWySlq3Jh3F23nIIu1rjI=
X-Google-Smtp-Source: AGHT+IG9cak2fCNRkjLA6nMOklMc3wR0gPeYdLkCkvN53U7wFdtqN+DcTu8b6RKxXiaT5kYD3tNeag==
X-Received: by 2002:a50:d4d3:0:b0:570:cd6:8ef with SMTP id e19-20020a50d4d3000000b005700cd608efmr9909187edj.29.1715084145631;
        Tue, 07 May 2024 05:15:45 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b0056e718795f8sm6289854eds.36.2024.05.07.05.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 05:15:45 -0700 (PDT)
Message-ID: <9a1825ff-3a55-4c2a-86bc-0709d4ff8153@blackwall.org>
Date: Tue, 7 May 2024 15:15:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix corrupted ethernet header on
 multicast-to-unicast
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240505184239.15002-1-nbd@nbd.name>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240505184239.15002-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/05/2024 21:42, Felix Fietkau wrote:
> The change from skb_copy to pskb_copy unfortunately changed the data
> copying to omit the ethernet header, since it was pulled before reaching
> this point. Fix this by calling __skb_push/pull around pskb_copy.
> 
> Fixes: 59c878cbcdd8 ("net: bridge: fix multicast-to-unicast with fraglist GSO")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/bridge/br_forward.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d7c35f55bd69..d97064d460dc 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -258,6 +258,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
>   {
>   	struct net_device *dev = BR_INPUT_SKB_CB(skb)->brdev;
>   	const unsigned char *src = eth_hdr(skb)->h_source;
> +	struct sk_buff *nskb;
>   
>   	if (!should_deliver(p, skb))
>   		return;
> @@ -266,12 +267,16 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
>   	if (skb->dev == p->dev && ether_addr_equal(src, addr))
>   		return;
>   
> -	skb = pskb_copy(skb, GFP_ATOMIC);
> -	if (!skb) {
> +	__skb_push(skb, ETH_HLEN);
> +	nskb = pskb_copy(skb, GFP_ATOMIC);
> +	__skb_pull(skb, ETH_HLEN);
> +	if (!nskb) {
>   		DEV_STATS_INC(dev, tx_dropped);
>   		return;
>   	}
>   
> +	skb = nskb;
> +	__skb_pull(skb, ETH_HLEN);
>   	if (!is_broadcast_ether_addr(addr))
>   		memcpy(eth_hdr(skb)->h_dest, addr, ETH_ALEN);
>   

This dance is getting ugly, but better to have it correct.
It'd be nice if you could add a selftest that exercises it.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


