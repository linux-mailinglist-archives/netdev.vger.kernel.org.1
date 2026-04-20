Return-Path: <netdev+bounces-279899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFAjI0Zy5mlgwgEAu9opvQ
	(envelope-from <netdev+bounces-279899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:36:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31690432F11
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 871E730071CB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5373AF645;
	Mon, 20 Apr 2026 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s8w5mWsX"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3A39936E
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710211; cv=none; b=hPV+Q6bbB2vOAODwHkTlHQd59eOeedr474HG/bR3CQJtP8KVtPdF9yUMnH+W5wom8iLBjhShTJI7gbLjRyKpgSpoz4NczKDOvKQpn+jx9gXOIy1Q+gz7u6YemQxzcrBgo4vHUBA2Y70qbIgKJ845YYt2Y6P/s1AZNSSK46mJylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710211; c=relaxed/simple;
	bh=CBBSoO9kTtLxzHRoa4Ab9jE/HH2VINcAEfP4EjjDQPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bum6WSUwSwnPqluOZ/T9qr3tGPbEA1rNHBoOLk91hnYTMZRJYs1GZWiv+MRI0nK2UtnYqOdSbXm9Vx/0EvhlBavJsCc4U4QNf3/hFX2Gsxw5TZknkXj/CzfO1l3V32v0swo7dH34auIda+EjIFWSmkxwKwJEafgTwcTFZPAEl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s8w5mWsX; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 20 Apr 2026 11:36:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776710206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iemELGgB+ZL7KFZ21IfvD3tE3IwlqkufHa9FGi9Rq/M=;
	b=s8w5mWsXpYVJTyMrsqnwl8ny9bR1qXKZP1Xko919KsJfHehzySLyRqSagj1FqR1i1bJ4Fo
	W+0G1U8N3BLH87E7/lWwOuT+TnTS0Z6jiMCVy35G6RvR4/Up7BAEPFA56KxNC7n1KA6Jdm
	NgcFF4IfncuuMPWPreMgGoA9nss3cnI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, Kees Cook <kees@kernel.org>, 
	Fushuai Wang <wangfushuai@baidu.com>, Menglong Dong <menglong8.dong@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
Message-ID: <2026420182243.zAiN.martin.lau@linux.dev>
References: <20260420161432.3919396-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420161432.3919396-2-bestswngs@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279899-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,baidu.com,vger.kernel.org,asu.edu];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 31690432F11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 09:14:33AM -0700, Weiming Shi wrote:
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index f8338acebf077..3b487280f50fa 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  		struct bpf_map *map;
>  
>  		smap = rcu_dereference(SDATA(selem)->smap);
> -		if (!(smap->map.map_flags & BPF_F_CLONE))
> +		if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
>  			continue;
>  
>  		/* Note that for lockless listeners adding new element
> @@ -547,6 +547,8 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
>  		return -EMSGSIZE;
>  
>  	smap = rcu_dereference(sdata->smap);
> +	if (!smap)
> +		goto errout;

You need to study it more thoroughly and the code around it
instead of rushing to fix a problem discovered by AI/bot (?).

This is now treated as an -EMSGSIZE error by diag_get().

>  	if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
>  		goto errout;
>  
> @@ -599,6 +601,8 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
>  	saved_len = skb->len;
>  	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
>  		smap = rcu_dereference(SDATA(selem)->smap);
> +		if (!smap)
> +			continue;
>  		diag_size += nla_value_size(smap->map.value_size);
>  
>  		if (nla_stgs && diag_get(SDATA(selem), skb))

... and here it will eventually return an -EMSGSIZE to the user space
which is incorrect. Pass the smap to diag_get instead.

pw-bot: cr

