Return-Path: <netdev+bounces-291420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZgHmFn2YFGoUOwcAu9opvQ
	(envelope-from <netdev+bounces-291420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C84855CDBE9
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 634B5302BE00
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0059737418A;
	Mon, 25 May 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofNbC01J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450F3630BA
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734555; cv=none; b=cKMaZr6wndDBS3xuMpV/wlyPXaa7/DPIIAEtsiAY6OCVp6iuMlciYSeU6XlFwJo0PorZlLB3X5Wo9oJ4YhG4nt8MGQzcNjHhmGN/VGZa3BaspJRmPRas4sAeYPnGuqtBimPUQd5BIVHiTtbikugKItJmHo0muMqgEVPz1n2/X/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734555; c=relaxed/simple;
	bh=33l/BNLB/4H2TS7wiLWeh8V6xZENwl7EU42gDX0JjE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBZSsomudwty7aKIH+zQ6cO5N+W+Dq0dZm/f724tDmKnv+LIBOsuV0g5Is1IwBEbGSTfY7nDvGGlaewSQVgCCdo9XoHtnWXXKMB1dXJd7mdVG1XHb9aiZlYqSfhwFwMvSeq/yduFsiWUsJ6VcjYtFYsvNf84Up1mSmvKxT+QF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofNbC01J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DF11F000E9;
	Mon, 25 May 2026 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779734554;
	bh=ykDGctv4OVpaFZp1N3Nviudsc7INWh9wiR/Z6cNaens=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofNbC01J69dZ0ZKehxo1NhOA1HHC7VeYxTqq5PIElq2TLYB5l46cTGNeBVM/mW7jQ
	 0g+V5eZx+0oMfSIujGSz54TSgeb87Bq5iqZa8iVQoB6Qow1yaFZ6VmIjYqHqM3rnBR
	 oKLqqUrlLxHAZIDTvFIHLTweVJGM9b+WZcNPzVUG0Y/1YGRNZe3GbyvSmy0lYp8egx
	 5fsZLhbALZlQMBsF/ALR6V0Zwz0jVMfYJG16O/Ile/7hIbzlzTEJDrxl/ne0sxYYay
	 cDk2uFPwNyEW86h4SMqgv6cRsK3veEX9moFUtIEMYmZNSx/Z9jF+l3Cr+e9Bshuaxr
	 jkXkxgEMqaA+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	melotti@google.com,
	fw@strlen.de,
	hawk@kernel.org,
	posk@google.com
Subject: Re: [PATCH net] inet: frags: fix a possible frag_mem_limit drift
Date: Mon, 25 May 2026 11:42:32 -0700
Message-ID: <20260525184232.2384368-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522140045.1836961-1-edumazet@google.com>
References: <20260522140045.1836961-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com,strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291420-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C84855CDBE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
inet: frags: fix a possible frag_mem_limit drift

This patch attempts to compensate for a frag_mem_limit accounting drift
in inet_frag_reasm_prepare() when an incoming fragment that completes
reassembly is not the first fragment, by adding the difference between
skb->truesize and head->truesize to fqdir->mem before consuming head.

> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index 393770920abd..3222cc2ac235 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -539,6 +539,9 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
>  		FRAG_CB(skb)->next_frag = FRAG_CB(head)->next_frag;
>  		rb_replace_node(&head->rbnode, &skb->rbnode,
>  				&q->rb_fragments);
> +		delta = skb->truesize - head->truesize;
> +		if (delta)
> +			add_frag_mem_limit(q->fqdir, delta);

[High]
Can the new delta computation ever evaluate to a non-zero value at this
point?

Looking a few lines above in the same function, skb_morph(skb, head) is
invoked before this hunk:

	skb_morph(skb, head);
	FRAG_CB(skb)->next_frag = FRAG_CB(head)->next_frag;
	rb_replace_node(&head->rbnode, &skb->rbnode,
			&q->rb_fragments);
	delta = skb->truesize - head->truesize;

In net/core/skbuff.c, skb_morph() is implemented as:

	struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src)
	{
		skb_release_all(dst, SKB_CONSUMED);
		return __skb_clone(dst, src);
	}

and __skb_clone() copies truesize from src to dst via the C(x) macro:

	#define C(x) n->x = skb->x
	...
	C(truesize);

So by the time the new code runs, skb->truesize has already been
overwritten with head->truesize, and the subtraction is identically
zero. The if (delta) branch never fires and add_frag_mem_limit() is
never called.

If the drift described in the changelog is real (the original
skb->truesize accounted via ip_frag_queue() differs from the clone fp's
truesize that ends up being subtracted later), would the compensation
need to be computed before skb_morph() overwrites skb->truesize, or
expressed against fp->truesize rather than the post-morph skb->truesize?

>  		consume_skb(head);
>  		head = skb;
>  	}
-- 
pw-bot: cr

