Return-Path: <netdev+bounces-305774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bPFRNXAzTmqHGwIAu9opvQ
	(envelope-from <netdev+bounces-305774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:24:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB04724EF6
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:24:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Za4DuOW8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6r1x0ynR;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i0hMqNmj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Aj3XLAhY;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305774-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305774-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 359D430C1A61
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F643F4AD;
	Wed,  8 Jul 2026 11:16:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36D43E4A2
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:16:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509414; cv=none; b=tOCSex+/RgD1BE1152XNtYe+l0Olt/Vb0wXxYrPmiCQ8+JaPSWcKNrI9zSRDL/FgWAW72ynpotZGFIg8VYUo99quxA9V6/Ft+qz8D0us2s3s0PMe9VWGc0vX8wCOKymXmrzlw80lLuAitlSi/mPXHIdnEKytpaTQ4xtjcyf2WaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509414; c=relaxed/simple;
	bh=3PInDbf4JbfgTmFx+PN8mNEA88VRjgw5io2se7ift1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic5lzGTfvZiwT7VGYkaYO0H3ZTle1CaY+vROqimLzSrcEz20889C8BbKlLkpd3S1PW6EqljJyxcf6xtxg9C+pdq8FEjzKRSyZ57lNkJFqvZr8kSMPX+ctLglJxD3oIg8Pa/6zYgupZclL9AjdhHDS0xNkEtkBhmyKgib0j1fhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Za4DuOW8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6r1x0ynR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i0hMqNmj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Aj3XLAhY; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D033D759DC;
	Wed,  8 Jul 2026 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783509408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf0N7hyL9ieefPaK1hQyYaoHoBFLf71w/CV6PNdQScA=;
	b=Za4DuOW8aViDWdGKSRqUx+4l0Wiat9bfqmZmUpcJU4asPLP2SHTX5SRpROgsQ08eJN1xBi
	qY3On68ubhYOTy4etsXYgv/c32bIZQGW+2iDNmvI4CtOn5ojw4nE2pMXfUJTy8nRjeiYcm
	lD4lqTtj3TUUTUSMzpPF5psGnesq2AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783509408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf0N7hyL9ieefPaK1hQyYaoHoBFLf71w/CV6PNdQScA=;
	b=6r1x0ynRj86u7sQ1VQIc9IRfOk/cBqFF9KRYm+28V22F8wBxU+EUCOncVAtBQ1OtmqH5eI
	EI4VRIkQK9uUlGCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783509407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf0N7hyL9ieefPaK1hQyYaoHoBFLf71w/CV6PNdQScA=;
	b=i0hMqNmjGuh18zyd9w7EBeCsH3kQW85vULtgyHNjuKGx+sz2m8SL74PJLqYEReu9RZbtv+
	OMnuopjq1kf3VMNu1oF9xcqtPGRKZ6u6Sp041aF9TbrJvcx0CeAUP5g95t2Rpu+TewoSVm
	38IEf9OIvW51n7bf1Nz5bDcochaADvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783509407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf0N7hyL9ieefPaK1hQyYaoHoBFLf71w/CV6PNdQScA=;
	b=Aj3XLAhYXjGFu1orWSrMrTIBuRA+FR70+NILNlEteFudv028P9a5xA0UZdzNJLRM8qzlKX
	KwpBM+z5LjKsQABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0590779AE;
	Wed,  8 Jul 2026 11:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GMK9Mp4xTmriQQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 11:16:46 +0000
Date: Wed, 8 Jul 2026 12:16:44 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
Message-ID: <ak4w2k4Woj55E0On@pedro-suse>
References: <20260702170728.168755-1-pfalcato@suse.de>
 <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305774-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:kees@kernel.org,m:linux-mm@kvack.org,m:vbabka@kernel.org,m:harry@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:dkim,pedro-suse:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CB04724EF6

On Wed, Jul 08, 2026 at 10:30:50AM +0200, Paolo Abeni wrote:
> On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
> sk_buff *napi_build_skb(void *data, unsigned int frag_size)
> >  }
> >  EXPORT_SYMBOL(napi_build_skb);
> >  
> > +static kmem_buckets *skb_data_buckets __ro_after_init;
> > +
> >  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >  {
> >  	if (!gfp_pfmemalloc_allowed(flags))
> > @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >  	if (!obj_size)
> >  		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
> >  					     flags, node);
> > -	return kmalloc_node_track_caller(obj_size, flags, node);
> > +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> > +						    flags, node);
> 
> Sashiko noted that some drivers may require GFP_DMA buckets, and the
> above may break them:
> 
> https://sashiko.dev/#/patchset/20260702170728.168755-1-pfalcato%40suse.de

Oh, this is really awkward. Adding linux-mm and slab maintainers for input here.

Considering the current slab bucketing does not seem to duplicate DMA or
CGROUP caches, could it make sense to duplicate those as well? Otherwise we
could add a branch like:

if (gfp_flags & __GFP_DMA)
	/* use the global dma kmalloc caches */

> 
> >  }
> >  
> >  /*
> > @@ -634,7 +637,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
> >  	 * Try a regular allocation, when that fails and we're not entitled
> >  	 * to the reserves, fail.
> >  	 */
> > -	obj = kmalloc_node_track_caller(obj_size,
> > +	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> >  					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
> >  					node);
> 
> Minor nit: checkpatch laments WRT brackets alignment.

Will fix, thanks.

-- 
Pedro

