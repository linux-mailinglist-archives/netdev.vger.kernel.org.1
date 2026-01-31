Return-Path: <netdev+bounces-255330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QRqEHZ10fWn+SAIAu9opvQ
	(envelope-from <netdev+bounces-255330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:18:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F1DC07AD
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB69300D68F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5533344038;
	Sat, 31 Jan 2026 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edWbggcl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43C26A09B;
	Sat, 31 Jan 2026 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769829527; cv=none; b=HcanABltvKrbMvLWHxHbs6U+XrhI1HTOMoPA2+r+VhRYdUzl7M1Us6PxKD7xngQsmZUN+3XFnv2UzSs2MAS+gDbpd8K5KqmRIx6hlVdOGSyUI8CxFOnz5GH21MMgg9r6neexLL2RD2Ms6FpHSkGnDhYtFLuHIf9nF7owp49baD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769829527; c=relaxed/simple;
	bh=ys8kgjZzyAzTe1k2KQChLBeHjhhYI3GQOK0RaM6R0wY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6GbBUj/KVNUW7VVs9LqWNC+ziRKz03haJ2Cqlw4VYD5ZpOzLypLq90zOet7Ft3+bmSWAdqU5gNUQhaZsatCMngs8hv5AbKe32us1CEE5iRz2bOvRVOX38p7N+ecGo5M4dylrRHIkvm32K68tSwnJXDFNGXoFM9Qweaq3q+Bh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edWbggcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7BFC4CEF7;
	Sat, 31 Jan 2026 03:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769829527;
	bh=ys8kgjZzyAzTe1k2KQChLBeHjhhYI3GQOK0RaM6R0wY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=edWbggclBkAef278oeYGahWR677lIOIsgMZfkaLwrPQ2c7gwa6X39EII8KX98GYZS
	 dKmmo0GqaDhfMvCAL316ft38FUmcEMhz4i/sNe8WItxtfecLbo12r03RXG3XX/IghW
	 0qccVEHlIk+xXeIJS4PjOlSXtrsn5l6AB7j9oB4JozOn2Sa/4kxOZdDaRZS1VT4b5A
	 EhU7UFkMe/9cF/c33WzEw7mdG9YAOMYuKUp5Ei1BxFlTqejYvwUgvFg/g7+dwIwSeo
	 7PRwP3zkNe+Qc3Rh6QaiIlnxWnYcMf6dS2gAWewtBApzGSWnj1fj2jRPq9Mb4vKbQZ
	 Ioxjx1L4/hwSQ==
Date: Fri, 30 Jan 2026 19:18:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: fengwei_yin@linux.alibaba.com, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: procfs: Fix RCU stall and soft lockup in
 ptype_seq_next()
Message-ID: <20260130191845.404c5e64@kernel.org>
In-Reply-To: <20260128070359.6762-1-fengwei_yin@linux.alibaba.com>
References: <20260128070359.6762-1-fengwei_yin@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.alibaba.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3F1DC07AD
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 15:03:59 +0800 fengwei_yin@linux.alibaba.com wrote:
> The root cause is in ptype_seq_next(): when iterating over packet
> types, it's possible that a packet type entry (pt) has been removed,
> its dev set to NULL, and pt->af_packet_net is not initialized.
> In that case, the function may return the same 'nxt' pointer indefinitely.
> This results in an infinite loop under RCU read-side critical section,
> causing an RCU stall and eventually a soft lockup.
> 
> Fix the issue by properly handling the case where 'nxt' points to
> an empty list, ensuring forward progress in the iterator.

> @@ -247,7 +247,7 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>  
>  	if (pt->af_packet_net) {
>  net_ptype_all:
> -		if (nxt != &net->ptype_all && nxt != &net->ptype_specific)
> +		if (!list_empty(nxt) && nxt != &net->ptype_all && nxt != &net->ptype_specific)
>  			goto found;
>  
>  		if (nxt == &net->ptype_all) {
> @@ -267,6 +267,9 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>  			return NULL;
>  		nxt = ptype_base[hash].next;
>  	}
> +
> +	if (list_empty(nxt))
> +		return NULL;
>  found:
>  	return list_entry(nxt, struct packet_type, list);
>  }

I'm not sure this fix works, TBH, we're dealing with an RCU list here.
The elements are not deleted with list_del_init(), so they won't
look "empty".

If the pt entries are under RCU protection I think the issue is that
af_packet is clearing pt->dev before waiting for the grace period to
expire.

Willem, is there a reason for that or just convenience?
-- 
pw-bot: cr

