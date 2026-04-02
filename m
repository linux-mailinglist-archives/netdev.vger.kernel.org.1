Return-Path: <netdev+bounces-274510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PRVOxRczmmgnAYAu9opvQ
	(envelope-from <netdev+bounces-274510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:07:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6450388D0D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CA1A30923C4
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F65C3A1683;
	Thu,  2 Apr 2026 11:57:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503D3BF664
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131065; cv=none; b=jK1dPc0sGXUTdVuyvHOM0a0i1x6kC5RzdPNGSLUYWJUNvQEOopX05KJnYA9mj1M8Ac0wrNgxncMsDmrVuzwSJoKyQ0iSVJy2KHx/S7t6vzbZgnyONf0r07dhlMwEodwkrWYjee67uzzeYOAJ0LNosjwXPepT3rERZ2A4Qnp7cDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131065; c=relaxed/simple;
	bh=m2SofRiP0mtv+EMaqbH6qVEm9bOwOwO+uFQ3zkM/ATo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiQ6GYYCaptb79N8QSFxetS7nk2Q12iJ8by5Kh0irjG/dNJVOq+yTI7fDde8GZn6XHv8hbeq8bD77Y7/zdS6jmgRfRI4mPE3U0GdOxpnv213aaLHanOYIC5m+NxoVivmoEyPByaCEdYM06FA4zX44fwu7RAW+ycNTDkamP66/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 24123608B3; Thu, 02 Apr 2026 13:57:36 +0200 (CEST)
Date: Thu, 2 Apr 2026 13:57:37 +0200
From: Florian Westphal <fw@strlen.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH ipsec 2/2] xfrm: Wait for RCU readers during state netns
 exit
Message-ID: <ac5ZsQTyo16xST_a@strlen.de>
References: <ac5TePdKtegtWiRG@secunet.com>
 <ac5TqJaXXg66dqBy@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5TqJaXXg66dqBy@secunet.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.967];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274510-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E6450388D0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Steffen Klassert <steffen.klassert@secunet.com> wrote:
> xfrm_state_fini() flushes the resize and GC work, destroys all states, and
> then frees the state hash tables and the inbound percpu state cache.
> Those objects can still be observed by concurrent RCU readers. We need
> to wait for a RCU grace period before freeing the hash tables and the
> percpu cache to avoid netns teardown racing with lockless lookups.
> 
> Fix this by adding synchronize_rcu() before freeing the state hash
> tables and the inbound percpu state cache.
> 
> Fixes: c8406998b801 ("xfrm: state: use rcu_deref and assign_pointer helpers")
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  net/xfrm/xfrm_state.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 1748d374abca..84fbf1591138 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -3327,6 +3327,8 @@ void xfrm_state_fini(struct net *net)
>  	xfrm_state_flush(net, 0, false);
>  	flush_work(&xfrm_state_gc_work);
>  
> +	synchronize_rcu();
> +

xfrm_state_flush() is expected to relink all states to the gc list for
the gc worker to handle.

The xfrm state worker calls synchronize_rcu() and then frees states
on the state gc list.

What scenario does this additional synchronize_rcu() protect against?

AFAICS this one is not needed, but maybe i am missing something?

