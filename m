Return-Path: <netdev+bounces-305681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QzDWDRcLTmqpCAIAu9opvQ
	(envelope-from <netdev+bounces-305681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0A0723306
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:32:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HWLd9fzq;
	dkim=pass header.d=redhat.com header.s=google header.b=FpafQaDr;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305681-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305681-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD40F3003EBF
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E213DDB17;
	Wed,  8 Jul 2026 08:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9EE3FE369
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 08:30:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499458; cv=none; b=UDc3mCRgoo/bIqyb0Tmg/clIv2mTrx1yJ08Z7PG4DSFnDO2T5l1lSevaUjyKGEZmCyFz264YP9A8gI1IS+m+mP6HC9Vl2iqnkg8riHB48kiOeo1Wb3oFfWxQeuHJD54Mg8vzIkfegYKDJkexpVCNhRuziBCgSzXZ2XGYftNfX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499458; c=relaxed/simple;
	bh=vUxkYgLjD7SSNYU9O4l3RAJNTa98pYA33vlEm8vPQ1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4dZgXgovMm2aG+274CI6EeEOe1gOQIiHMI3+Jil2rfTwufLMyEylcFZbVvx3SX1QZ25HazzE6/J6SyLe+7CUx+nt+GmJKFzEVBQSbc52+H4zOxYuJpjmmn4462uRlV/oCkdHK/g9o8zTtbQG/M0iPsqqSeoKGMas6/swZ1Nzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWLd9fzq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpafQaDr; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783499455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2x2KW8jXt7Qu/ChgVuNcsLQe8Mz8PkKb4meLHcRszN0=;
	b=HWLd9fzqpLVKMJZpJddVc8eCgyMdMLZuadtDy5/t6o3QTI8I4/XQHPNp57KoQm/BWCWZjv
	sDAQPgNRM4C//L9yOIbvUvg+lfXP8IPL3D0yq7CB3qGoSFl07/yLC3UpG/Bp1ga6gmy3vj
	W3fjkVkxSow7ZZTevQwFif1IItJ60y0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-GzmD_3w-OJ6VQqrm0eEKUQ-1; Wed, 08 Jul 2026 04:30:53 -0400
X-MC-Unique: GzmD_3w-OJ6VQqrm0eEKUQ-1
X-Mimecast-MFC-AGG-ID: GzmD_3w-OJ6VQqrm0eEKUQ_1783499453
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47416fc1674so397153f8f.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783499452; x=1784104252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2x2KW8jXt7Qu/ChgVuNcsLQe8Mz8PkKb4meLHcRszN0=;
        b=FpafQaDrLI58czW5fS80Aj4Byej/siHXG8SGvveULl71cqQi3TgOrklhU87jKQlj3n
         HQ3sntltI6UdW0P62WRYCoeBar1ha9FUyE/WsdvB2W+RLi6mxhFdMejgpbiIzmcBBfJA
         KU1+ghuwjgX3tTd9k3AoBhZxdFNYlny2/Hmo1CGx7hiiG7D9tJn2aN9iYUEeDRZ3olDs
         oAD3FSaJEOOAS3s8MCZpZeefT2n/WHd9BpIUUSC27w49Y7+JjdS5yfZ8ZU7stq9qHwGO
         cHC+fjcnb6Zv3HieHYrLwRH5y2vKuMeWH/u7SHQZGhbM6XSJO8JFlYLZmZt4qapA1wxy
         KH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499452; x=1784104252;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2x2KW8jXt7Qu/ChgVuNcsLQe8Mz8PkKb4meLHcRszN0=;
        b=W9b3N4WwMQXmQIb2hU28igC7h1MFwMKHJTp4L0l6Qe8gmyG8nGr2ynwwF1qptCxXbg
         gUbjvwVUkkSNvcEsNo7hWk4XD/B4CZoASW6R1NXOVWzhFW+H4rzPcMgPkITeQilBstGx
         kaMvYmIxJssFRgcjAlbxTdh1TtiJyyAZX3rOEoi4gNwLvutf34hu6/CQdor3LTS6zxZo
         0ROY1wWhvj9EaT3hIv165PrEPrEKBj0tfC01TDKNq0TZhnnkg/1VQcL2Rzu/4WQ6Zw7I
         Rj0nvwEIGQke1ll4Sp8gqCAbwHERaB8eN4Y0FNLLSosvc+NZFo4d7dgZxJQiS+JP96cN
         XX6w==
X-Forwarded-Encrypted: i=1; AHgh+RqGI3ost/t2Q5+ilBDtkJcVxwIzD4iL14EpH91o1tAlEaxB20RbFr7HZOIn/ieIhUJyCZvfC28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDnQfzPzpDaxZAtf+K/d8ghaeppNA3HdF3omgOFVkGmjwBHID
	MPRuL3ZRIVZkRCsCcPhHAtK3Gsj6lBM4pZlktw7n+Qnq2wv+3gr1J7kmp4qbNS83Lz8+voGdjj/
	tkFdjJQEZzBUUZZKP9VXGeJRD8Oqjy64TX5rp0g3LaVsr4YNBgH8ALhW2JQ==
X-Gm-Gg: AfdE7clQoISWKzS9xoBr3rlhxqHuUdQ1shYgAfkyrJDQlc3SL8XMKjKAhdWdKUlGnUo
	/5lMJhZL3oe9+uv4eNTnSy7pB5D0maIpOwTmzcnmSIEtT2dH3EDUPKfsDy0AOgSmWrqxX1NzVSE
	+hn+ukUrXWKGszCbBHtOaY+ZpJcTDBdKav+bQiZ4BilEaYMvOVQA6cM1QOZbTW/4sZtnzsRqDEF
	DJBA/Zbz0mdy0+ANkFV/SpDFOdqXNJsIStgj01KDnIIk2w3HSoR95vDA89+9ZBURcVzLQkn+7fz
	s4IdVA4JJtsXINiTtwaxtccLd092e1ZDoVXfW6hh9ernubGjYVHnr97xNsiCtZTvRXefwxsBBZM
	UkdU09ZusOK6hrTXexgku+kr7bNQgJCJKPj+JZeb0xych1pTGoObFIVGwNUHVVSd9AcAcA+Wev2
	YYuFt8JMtDzQHO
X-Received: by 2002:a05:600c:6206:b0:493:bc92:ba9a with SMTP id 5b1f17b1804b1-493e68bee61mr14535865e9.13.1783499452608;
        Wed, 08 Jul 2026 01:30:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6206:b0:493:bc92:ba9a with SMTP id 5b1f17b1804b1-493e68bee61mr14535405e9.13.1783499452198;
        Wed, 08 Jul 2026 01:30:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0faed08sm111777175e9.11.2026.07.08.01.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 01:30:51 -0700 (PDT)
Message-ID: <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
Date: Wed, 8 Jul 2026 10:30:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
To: Pedro Falcato <pfalcato@suse.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <20260702170728.168755-1-pfalcato@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260702170728.168755-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:kees@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B0A0723306

On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
sk_buff *napi_build_skb(void *data, unsigned int frag_size)
>  }
>  EXPORT_SYMBOL(napi_build_skb);
>  
> +static kmem_buckets *skb_data_buckets __ro_after_init;
> +
>  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
>  {
>  	if (!gfp_pfmemalloc_allowed(flags))
> @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
>  	if (!obj_size)
>  		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
>  					     flags, node);
> -	return kmalloc_node_track_caller(obj_size, flags, node);
> +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> +						    flags, node);

Sashiko noted that some drivers may require GFP_DMA buckets, and the
above may break them:

https://sashiko.dev/#/patchset/20260702170728.168755-1-pfalcato%40suse.de

>  }
>  
>  /*
> @@ -634,7 +637,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
>  	 * Try a regular allocation, when that fails and we're not entitled
>  	 * to the reserves, fail.
>  	 */
> -	obj = kmalloc_node_track_caller(obj_size,
> +	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
>  					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
>  					node);

Minor nit: checkpatch laments WRT brackets alignment.

/P


