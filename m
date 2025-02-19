Return-Path: <netdev+bounces-167677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391FA3BBB1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1437D18983C0
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7251C760D;
	Wed, 19 Feb 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sa2oQAj4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I1jqpVEh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gpkt3xYZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fMqq4Dss"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6C1BD9F2
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961149; cv=none; b=pJxgEJUB1cWU06bhfajRsNxBwRReysv9anbfco9amksKfNU7u5zIAcDVGe9F88dvNYwiuEX2uqnN8G5VDYNNyiKNJ+XZIPvkpwBFFjcvQ8R0fM1xsUz/WXlQwxjUv9TnHtXXEPL9AgDIp1JpkM/5PAO6lohGLmjLbL9zNSAyYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961149; c=relaxed/simple;
	bh=qIrWEi3ZC3axpcehFrxQOO9DVNkEWJ3VlRWxGRiYVJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAjwdNhjmgR61B95jIkSdIZfRuTqAmRGLJ1cEUTx2H9OhsnNMcsrsP3f8z/09uOS3D++GAuXvRaZY1vBjxTUfwVY8bhzRr/yzRd9Yiilhm7w7B2SFbRv58Vt3KIB+3BlAMcL29w3ngrtIcUlY6xGlA0sSp/8s7imuwASLTRKYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sa2oQAj4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I1jqpVEh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gpkt3xYZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fMqq4Dss; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D97FB2120F;
	Wed, 19 Feb 2025 10:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739961146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y+kkuBYJd/19NRvzUV1Wm8GdViJznSz/zdockMizPMQ=;
	b=sa2oQAj48rVWb+C47CGLGDqf3/x91C+AhoZ3EgLTzrih79RnZFSI6iIHP8oHIWastkaI7K
	3XgT8uh+Dfg0T+sBJvxQPGUEJFELCMNs6okHg7wVG8IaY7OzM11DxVHG5TOrU5jVZEtVmv
	3HV6gk2qh60S2t+41/ipCHlx8JcoB3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739961146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y+kkuBYJd/19NRvzUV1Wm8GdViJznSz/zdockMizPMQ=;
	b=I1jqpVEh8njxarckSfGyJDxT7jNlyfDsLtqXysJzdRUB5hWcSyM5iH2PdyGZ6Wc6fvdyXI
	O957BquzWOHYXcCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739961145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y+kkuBYJd/19NRvzUV1Wm8GdViJznSz/zdockMizPMQ=;
	b=gpkt3xYZY77AXwFDAQIb501JGoe3wTI4A/FIHUQdcaNhVbWYOILWErtUhassomI/6OFqlE
	i14gd/McoRH2PTFYrKqmjdqy/ZSxv7X2fheVxRlvah4I1YIJJ9K1j1Uds051HlGevjdQEm
	T0y3PJHs9T5zh0IRd8G/dTK6Oyr37zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739961145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y+kkuBYJd/19NRvzUV1Wm8GdViJznSz/zdockMizPMQ=;
	b=fMqq4Dsse+qu2p/vVEaXRxNBEaiKd83QTzs55xR+uRONDr2TVngLK+Djn8QCxh08wGOpM3
	7G7Ndxo9fuY1xODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD22E137DB;
	Wed, 19 Feb 2025 10:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id emDnKTmztWdfSQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Feb 2025 10:32:25 +0000
Message-ID: <6cc54680-3093-4d75-b688-91688023c41b@suse.cz>
Date: Wed, 19 Feb 2025 11:32:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] neighbour: Replace kvzalloc() with kzalloc()
 when GFP_ATOMIC is specified
Content-Language: en-US
To: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Gilad Naaman <gnaaman@drivenets.com>,
 Joel Granados <joel.granados@kernel.org>, Li Zetao <lizetao1@huawei.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kohei Enju <kohei.enju@gmail.com>
References: <20250219102227.72488-1-enjuk@amazon.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250219102227.72488-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,amazon.com,drivenets.com,huawei.com,linux.com,lge.com,linux-foundation.org,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/19/25 11:22, Kohei Enju wrote:
> kzalloc() uses page allocator when size is larger than
> KMALLOC_MAX_CACHE_SIZE, so the intention of commit ab101c553bc1
> ("neighbour: use kvzalloc()/kvfree()") can be achieved by using kzalloc().
> 
> When using GFP_ATOMIC, kvzalloc() only tries the kmalloc path,
> since the vmalloc path does not support the flag.
> In this case, kvzalloc() is equivalent to kzalloc() in that neither try
> the vmalloc path, so this replacement brings no functional change.
> This is primarily a cleanup change, as the original code functions
> correctly.
> 
> This patch replaces kvzalloc() introduced by commit 41b3caa7c076
> ("neighbour: Add hlist_node to struct neighbour"), which is called in
> the same context and with the same gfp flag as the aforementioned commit
> ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()").
> 
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Notes:
>     One of the SLAB maintainers (Vlastimil Babka) looked at v1 patch and
>     double-checked kzalloc() is clearer in this context:
>     https://lore.kernel.org/netdev/b4a2bf18-c1ec-4ccd-bed9-671a2fd543a9@suse.cz/
> 
> Changes:
>     v1: https://lore.kernel.org/netdev/20250216163016.57444-1-enjuk@amazon.com/
>     v1->v2:
>         - Change commit message
>         - Remove the Fixes tag since there is no real bug now
> ---
>  net/core/neighbour.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d8dd686b5287..344c9cd168ec 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -518,7 +518,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  	if (!ret)
>  		return NULL;
>  
> -	hash_heads = kvzalloc(size, GFP_ATOMIC);
> +	hash_heads = kzalloc(size, GFP_ATOMIC);
>  	if (!hash_heads) {
>  		kfree(ret);
>  		return NULL;
> @@ -536,7 +536,7 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
>  						    struct neigh_hash_table,
>  						    rcu);
>  
> -	kvfree(nht->hash_heads);
> +	kfree(nht->hash_heads);
>  	kfree(nht);
>  }
>  


