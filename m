Return-Path: <netdev+bounces-274657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBQvOtW1zmmApgYAu9opvQ
	(envelope-from <netdev+bounces-274657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6533A38D21C
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91628305ACA8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2D3DEAFF;
	Thu,  2 Apr 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6OTV792"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5873DCD9A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154607; cv=none; b=JH3TMsAYOEpdyA8VzJYA9YLCLIS5HbyDBVzcWfhLYYQqaJtwKK0gaQx4jVp+lf88pn5JSqEXdxS7GVvtg8Jp+J7pkvyoffbgJN7psE7z+AkyuLAyFcl9CorccdbND7BkwK2ncigyGvSV07UIy2EjCy3/LUDP6UMgMh1I8+vA/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154607; c=relaxed/simple;
	bh=DS8IBS91i62jn8rja2VJw785maHOIJIUi+yPRXeo48A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMboemlDdu4jYRxuC5/nVnrlrYOG6iLlXGL36IXi81f04ApAXZ8U+aVjnf7Xzqj8ya3sxzaLzV8UE2fiH22OWvsIK4N7B1zDJiSKQj6R2B9FNuLCSFztxAtJWbet4UyVrANOC6rLf6cxUrfLODjatQToz39LtC1JTihwr/f/aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6OTV792; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b97e6e48b24so182484666b.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775154604; x=1775759404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEu3yUtBUuZccyyj8V1hymKx7VBvoK6SXdlQQoWr1mI=;
        b=g6OTV792BbA64J8v5kT83Z/lN8p81OXQhKKu9uYvX0SZ7Nh6ZOaSTzMLk3/MK+tnH/
         twcSqx1hmLzUxEWdJBJJ/6h2hDhAmU8Q4dnWjrgM65EBnaD7FBqy759ws/FJtA/JPfkL
         NuSGagDrBgkdGdWnAWA43ic59Pq3xFuHNGBrR5O7jO88rV6yMmXEMFTbl3L7nuXxnrMx
         5MawwsnsBIyKmkUad39spWxZJi3pyacvOClTBWFTif1jnwNym4xV2NMle4noWu47PKmy
         tzIa1uX5Yqms2u56KF3fCObgtPl6vy/0JjXwfc1uCe2HvagIJ/723h3TP+z7lDyphP5K
         Fqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775154604; x=1775759404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEu3yUtBUuZccyyj8V1hymKx7VBvoK6SXdlQQoWr1mI=;
        b=f3FiO1xzrvQBwkncWS1TOMAL4ZSN5mEyHcrOZzlTYdsjmFUkMrkD6NbDY4ZZOEFuob
         xQN5IV/VwyOSeQMI/PCEn5Dx+6VvEzGxDsjWV1OYSzTCDsleB+ThBvNstyEw2oVS3W4Q
         3Y8wdocLX4w113FH6UVZej3MRPsTHwx8eDYuXVCUHG+m6NCkxP8tsi/QJJ8dNYB3k27q
         5AV9R38eQb44emYmqdYXrKWfyAPCwQ1JC4I79Vh9qipfi511J8d43Vz1/e46Of/TV60n
         WK3IfVnyUfYgWyTsEknHGzeC1oxBXHrxKJlDOwU7ueuOVRe45tH3uutkycyjZfTUIiQl
         j6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV609r2+vliHIM6yMeQU2vtefVzjaXiPJVZ6wwVP6a2N9z+YDzOLEmwMZuyi3aDSZeBFosDxIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyovH6XsZTnlnrL0B50OmZbl7I5uvfLuFi2ZdOFFGFdMpXsKEBg
	QHBSUkyeGSGvfjOoK9OJzqnw/z4aEo6iM5WcCQFFgI/N2kkPLozprBmy
X-Gm-Gg: ATEYQzyiAuGzZl+ddx3qm3gHYx5kAKKXOIYsIsrfXFclNOjR4kEmTWWEQPiYq4D9AjD
	/LDkCm/EAHNRYwpwLMGB2AaROFlLG9Jz3Jg2Ppo06CHSXIpSZRMlXHO9GU2FT+rlGgX1QZ20pq/
	wCr2Hx6PnNOtQaNn5IeecHH4J1CAmgjU18RzoC8EAb7hu0X/YbCVSJOcXScdra+Bgmiwe49uSTO
	jE40zq+gN48wUrAOEj71hX3ZMfo8tZXcX8XjNE2jR0v7L1vKj88Anmnlh3tjLz/kpQGAEhky2NB
	9gZsZhWzeAvjZvPNCunef8Br35gBqePlRXB0Gv2yCN9CCGLp5COyglAH2L4ucGQXVmA+OFncNRe
	8NvAIJRKK+heoYR9dLhjDMGId3U+9JGdmiJIhdSPtY0837Sj8eIezxq2L7p6kGyGwQ5wGh/RIrY
	uSFy11qlsrcOrMzFWxEvluQ6mnCOQBDEFR19tCgDPVGtpgOO8UDRR3ehTjwTCK1r8S5gYn9ctWA
	WhUbA==
X-Received: by 2002:a17:906:f40e:b0:b98:4c5f:6603 with SMTP id a640c23a62f3a-b9c1390aa9cmr556518166b.18.1775154604017;
        Thu, 02 Apr 2026 11:30:04 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:248c:6c47:3ce1:a121? ([2a02:a03f:a75e:9a00:248c:6c47:3ce1:a121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972181sm119683866b.8.2026.04.02.11.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 11:30:03 -0700 (PDT)
Message-ID: <841c82b6-464c-4308-ba37-73ef07454377@gmail.com>
Date: Thu, 2 Apr 2026 20:30:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] seg6: separate dst_cache for input and output
 paths in seg6 lwtunnel
To: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
 paolo.lungaroni@uniroma2.it, nicolas.dichtel@6wind.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260401185755.29813-1-andrea.mayer@uniroma2.it>
 <20260401185755.29813-2-andrea.mayer@uniroma2.it>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260401185755.29813-2-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:email,uniroma2.it:email]
X-Rspamd-Queue-Id: 6533A38D21C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 20:57, Andrea Mayer wrote:
> The seg6 lwtunnel uses a single dst_cache per encap route, shared
> between seg6_input_core() and seg6_output_core(). These two paths
> can perform the post-encap SID lookup in different routing contexts
> (e.g., ip rules matching on the ingress interface, or VRF table
> separation). Whichever path runs first populates the cache, and the
> other reuses it blindly, bypassing its own lookup.
> 
> Fix this by splitting the cache into cache_input and cache_output,
> so each path maintains its own cached dst independently.
> 
> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>   net/ipv6/seg6_iptunnel.c | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 3e1b9991131a..d6a0f7df9080 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -48,7 +48,8 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
>   }
>   
>   struct seg6_lwt {
> -	struct dst_cache cache;
> +	struct dst_cache cache_input;
> +	struct dst_cache cache_output;
>   	struct seg6_iptunnel_encap tuninfo[];
>   };
>   
> @@ -488,7 +489,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>   	slwt = seg6_lwt_lwtunnel(lwtst);
>   
>   	local_bh_disable();
> -	dst = dst_cache_get(&slwt->cache);
> +	dst = dst_cache_get(&slwt->cache_input);
>   	local_bh_enable();
>   
>   	err = seg6_do_srh(skb, dst);
> @@ -504,7 +505,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>   		/* cache only if we don't create a dst reference loop */
>   		if (!dst->error && lwtst != dst->lwtstate) {
>   			local_bh_disable();
> -			dst_cache_set_ip6(&slwt->cache, dst,
> +			dst_cache_set_ip6(&slwt->cache_input, dst,
>   					  &ipv6_hdr(skb)->saddr);
>   			local_bh_enable();
>   		}
> @@ -564,7 +565,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
>   	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
>   
>   	local_bh_disable();
> -	dst = dst_cache_get(&slwt->cache);
> +	dst = dst_cache_get(&slwt->cache_output);
>   	local_bh_enable();
>   
>   	err = seg6_do_srh(skb, dst);
> @@ -591,7 +592,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
>   		/* cache only if we don't create a dst reference loop */
>   		if (orig_dst->lwtstate != dst->lwtstate) {
>   			local_bh_disable();
> -			dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
> +			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
>   			local_bh_enable();
>   		}
>   
> @@ -701,11 +702,13 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>   
>   	slwt = seg6_lwt_lwtunnel(newts);
>   
> -	err = dst_cache_init(&slwt->cache, GFP_ATOMIC);
> -	if (err) {
> -		kfree(newts);
> -		return err;
> -	}
> +	err = dst_cache_init(&slwt->cache_input, GFP_ATOMIC);
> +	if (err)
> +		goto err_free_newts;
> +
> +	err = dst_cache_init(&slwt->cache_output, GFP_ATOMIC);
> +	if (err)
> +		goto err_destroy_input;
>   
>   	memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
>   
> @@ -720,11 +723,20 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>   	*ts = newts;
>   
>   	return 0;
> +
> +err_destroy_input:
> +	dst_cache_destroy(&slwt->cache_input);
> +err_free_newts:
> +	kfree(newts);
> +	return err;
>   }
>   
>   static void seg6_destroy_state(struct lwtunnel_state *lwt)
>   {
> -	dst_cache_destroy(&seg6_lwt_lwtunnel(lwt)->cache);
> +	struct seg6_lwt *slwt = seg6_lwt_lwtunnel(lwt);
> +
> +	dst_cache_destroy(&slwt->cache_input);
> +	dst_cache_destroy(&slwt->cache_output);
>   }
>   
>   static int seg6_fill_encap_info(struct sk_buff *skb,

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

