Return-Path: <netdev+bounces-248120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA877D03B1D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FA4730650B5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6B12D979C;
	Thu,  8 Jan 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAe4vl8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3152D63E5
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884714; cv=none; b=ekMZylBDAh225/9XyzvRlM0fU8tA2CZnVHMkQfKwDhBNopq0mT0j3MJztS7cdT1VlcwpNfBT7GRcZxVCLwlwWY3wBO91aLI3IuYmL4UJIOQ0kdAz7m0HvdwL3mB6QCvLhP5qgjbjBQzyV9/0RZ7zBN9uNdyk3fcROeXddPTMSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884714; c=relaxed/simple;
	bh=9y+gumv6+abQK3WrEmzubVcxZM5jnmgGM58KsYU56ow=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W4lAzqSOtVpEol+ZWMEOWoai7wDjTC3L1V2gApJR+N1xPJBYHNbTjzKCe5Db9ucVSbcupIcZunk8SJh1SewmOtKV4pxOUcebdE2HUE925wO6SuAenOP2ns/dWDBdhCUBlxvBvcHsUz2VJl0/haK5ZlxdcVi+rKk9Kjh0ZAGgQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAe4vl8S; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-790647da8cbso36180467b3.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767884711; x=1768489511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9SnUaQupDJTHWVBeAVtee0q7OFN0KAML/VstuXdPgU=;
        b=PAe4vl8S8lkc7AKbWf7KHaJFL0bX5PbfYnDmJ+Wbdh5Zq/FoQPzJJjJuxZV6SEmquH
         NQSbUhkFfQcgxwiYHJIDuQ8PLwTTqyHQMRuAGsuu5bn1f+aly/Rlbxq22d+5Wh7qu6oe
         +RS49QVjFJIeRXuLNnsGyikoed++nyo8T3EDuHEHpZ3KbVvFBwyMC8Mi2rxF0ZSZgFI8
         fFXG3bE9RPCgF6qzEBrVOk++msXNpyeWXQrCsM0SQae1lDplKIAmQ+rqfFmDxbaUSqF4
         pvsOb+s92TocKIuo3AH67RCstYv4S6TTdW65p96LGhNOUgZT6H9MUfSj2aR+bTXe8n7C
         P5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767884711; x=1768489511;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9SnUaQupDJTHWVBeAVtee0q7OFN0KAML/VstuXdPgU=;
        b=bEbiOf1dA86zsG2PpomqNtOt5yzvAdtCftDLY47BtWJrvBNwPBD1JoDt47rhavUSpv
         /SVMEWf4fm6XK+u/RUFDSw4yt3ahuRRMkww5A6J69Fr+jniHiTkz6V/x2KAEJJVRc08p
         gJkFGHpOBD4FI5653GV4clBA+5rtXKeevGb1d+p6JNHVC120XaAUuFJxncE3voTPyWKz
         ojdymaD6s5zJt/huq8XD7s4NbwUyVhPuVH/jorWGGegaHIpln+DvmIZFZzuSRNi3SU2f
         VWllTn+GwsNWhf2meLPiD41FYK6uHdjU1FpI8QnavRo6HFDn6LVta0/4ogMMyIt23pxz
         RH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+l43VEMcSSKOfVryQ+LVQyIIWa5FZonz1DkX6atX14KMQZDGXcFCcS0YWQGdS4p1QZXe3v2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/36JL1cMTKVFUuNDzyggXVzSAmxZ+ERE1cRdGEy5Gy4/5baE
	ySEj0sVwSDdmnxhQaH/4xSIBPlXejwgmthuHO/pqOnM2pCxd2YyC0HoM
X-Gm-Gg: AY/fxX72jgYSgZc8UqRR+aadhvcKeWeSHXNrbJ8gmsHkHEwQARY8sKYz9cGgGXZRJpU
	y8u78qIR7NZRd7LT9Wb5gXWEM7EbuLCVA+NaYYaZSarX6n1aWQO038I2bT+fWBmaipPKyLlNVYD
	Q+RdGxUjqFWLJqyKd8E17IKfs8o8qmcQ2C6myRv5z8wMvHpn+ITu+dblC5u9+mmeof4gH9OkPm5
	H0GyXlzNpD2CgN4xGoPgOQalvhZvdfE2t91irVEK3DJW9yYGdHwRJwiNosNsdCY5TnqizK+MtCn
	KR+b2uza4UgS6eENmF5LamrruXtMiHK3Aw65D4NESzJJb3s+JrkRX3Urx/gsr7JvVcOsbysFl1R
	SpOIKRODNQNTT49l7By0BW+TsxF/ictXfxpVUSgT5J4c1AdMA/k/NtIlvcz6y7fhdViKJusFcZD
	vdipjN0lukNJK6GOk9o9+FeDXDeK/ymKP9prdhJbWWaEfg6a7A20njRVPVnRA=
X-Google-Smtp-Source: AGHT+IGKh8OH5jNGc9Klaj9frs4A/TPDhnmQu2N/mh5aKvUE5uhrNeLEu0GOrcZhHASHbyGkkVHD6A==
X-Received: by 2002:a05:690e:1517:b0:645:550e:efb5 with SMTP id 956f58d0204a3-64716bd2ef5mr5830319d50.52.1767884711297;
        Thu, 08 Jan 2026 07:05:11 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa57a73csm29893997b3.19.2026.01.08.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 07:05:10 -0800 (PST)
Date: Thu, 08 Jan 2026 10:05:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kshitiz.bartariya@zohomail.in, 
 Mahdi Faramarzpour <mahdifrmx@gmail.com>
Message-ID: <willemdebruijn.kernel.3d34f04282b4@gmail.com>
In-Reply-To: <20260108102950.49417-1-mahdifrmx@gmail.com>
References: <20260108102950.49417-1-mahdifrmx@gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mahdi Faramarzpour wrote:
> This commit adds SNMP drop count increment for the packets in
> per NUMA queues which were introduced in commit b650bf0977d3
> ("udp: remove busylock and add per NUMA queues").

If respinning anyway, may be worth adding the note that SNMP
counters are incremented currently by the caller for skb. And
that these skbs on the intermediate queue cannot be counted
there so need similar logic in their error path.

> 
> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> ---
> v4:
>   - move all changes to unlikely(to_drop) branch
> v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/
>   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail.com/
>   - change ENOMEM to ENOBUFS
> v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmail.com/
> ---
>  net/ipv4/udp.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index ffe074cb5..399d1a357 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1705,6 +1705,10 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	unsigned int rmem, rcvbuf;
>  	int size, err = -ENOMEM;
>  	int total_size = 0;
> +	struct {
> +		int ipv4;
> +		int ipv6;
> +	} mem_err_count;
>  	int q_size = 0;
>  	int dropcount;
>  	int nb = 0;
> @@ -1793,14 +1797,28 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	}
>  
>  	if (unlikely(to_drop)) {
> +		mem_err_count.ipv4 = 0;
> +		mem_err_count.ipv6 = 0;

Simpler to avoid the struct and in this branch scope define

int err_ipv4 = 0;
int err_ipv6 = 0;

>  		for (nb = 0; to_drop != NULL; nb++) {
>  			skb = to_drop;
> +			if (skb->protocol == htons(ETH_P_IP))
> +				mem_err_count.ipv4++;
> +			else
> +				mem_err_count.ipv6++;
>  			to_drop = skb->next;
>  			skb_mark_not_on_list(skb);
> -			/* TODO: update SNMP values. */
>  			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
>  		}
>  		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> +
> +		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS,
> +			       mem_err_count.ipv4);
> +		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS,
> +			       mem_err_count.ipv4);
> +		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS,
> +			       mem_err_count.ipv6);
> +		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS,
> +			       mem_err_count.ipv6);

Only add if non-zero.

>  	}
>  
>  	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
> -- 
> 2.34.1
> 



