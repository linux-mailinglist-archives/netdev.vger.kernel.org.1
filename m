Return-Path: <netdev+bounces-295399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3zlWBw/OIWohOQEAu9opvQ
	(envelope-from <netdev+bounces-295399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4F642D19
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:12:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=du+BNIwg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MIZ1n7v5;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=du+BNIwg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MIZ1n7v5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295399-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A952C30097F2
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E59A3B19B3;
	Thu,  4 Jun 2026 19:12:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E92F7EF4
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 19:12:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600330; cv=none; b=jF3PeKrufFRnG3CLrJ66qQZ5Tzhstkdu/mafDrLVwb9zgy/twYxY0cphBZTwupvZx4F0grVoMNWGFbbkLfVd1VMQAqAmvhQdPChuxKlO017mTs6DPwdRHXBkV6acIDLKuQ14J90bxyHnCYRWWcFn6HVbN6s/15/m6X7EIAKlIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600330; c=relaxed/simple;
	bh=ykembX4DnSNgKL3XfltodtBr2NEGN0VjjMVEs45i9AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihla+3dTx6mgzguW/MumFAXL3/B96s37y7Ly39aU/k1fSDnqulxYcdq77ersvtjT2992326EdjEMM4EPGTjyi7H4rqisGZeGUEegN7KThDfZ6ZLSfzhhpK08wLnIhPjc7BFU66PjZKOCm+oX+g79KMzQ7IAv3mcASH3a7t6Rko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=du+BNIwg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MIZ1n7v5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=du+BNIwg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MIZ1n7v5; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71F816B029;
	Thu,  4 Jun 2026 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780600327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L7i2swvOC+jyqEqBi6J71Dz7ZL2TF4c4yN/go0BL5o=;
	b=du+BNIwgZkPrCHvZZp6Z5pgYTtbhQg6LVpneHU5VcpuZUPHfCuNNJJxDn08F6cRF8XjfEg
	kpwU2X5A5fBjRAkEaQx2ZvKzsCBjTktKKMF8uRkANugAs8Lr+LvgrAVxAreIEihf045E0z
	+B447SxeQm16FMgnEJ7FVzy/TqQ7cW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780600327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L7i2swvOC+jyqEqBi6J71Dz7ZL2TF4c4yN/go0BL5o=;
	b=MIZ1n7v5OoSUdcDUgR1RvEt12w6lYFbzx5nExRtHBJkzaCfLmp/gyJmNpZoCjbgRfzoaIy
	SLLWM/u6shUkS6BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780600327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L7i2swvOC+jyqEqBi6J71Dz7ZL2TF4c4yN/go0BL5o=;
	b=du+BNIwgZkPrCHvZZp6Z5pgYTtbhQg6LVpneHU5VcpuZUPHfCuNNJJxDn08F6cRF8XjfEg
	kpwU2X5A5fBjRAkEaQx2ZvKzsCBjTktKKMF8uRkANugAs8Lr+LvgrAVxAreIEihf045E0z
	+B447SxeQm16FMgnEJ7FVzy/TqQ7cW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780600327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L7i2swvOC+jyqEqBi6J71Dz7ZL2TF4c4yN/go0BL5o=;
	b=MIZ1n7v5OoSUdcDUgR1RvEt12w6lYFbzx5nExRtHBJkzaCfLmp/gyJmNpZoCjbgRfzoaIy
	SLLWM/u6shUkS6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFEFC779A8;
	Thu,  4 Jun 2026 19:12:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F7e4LQXOIWr4fQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 04 Jun 2026 19:12:05 +0000
Date: Thu, 4 Jun 2026 20:12:03 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
Message-ID: <aiHIQ4ZxnMSifhmi@pedro-suse>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-3-pfalcato@suse.de>
 <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295399-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,davemloft.net,google.com,redhat.com,vger.kernel.org,kvack.org,linux.dev,gentwo.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pedro-suse:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85C4F642D19

On Thu, Jun 04, 2026 at 02:30:34PM +0900, Harry Yoo wrote:
> 
> 
> On 6/3/26 3:31 AM, Pedro Falcato wrote:
> > SKB data area allocations (as done from alloc_skb()) use kmalloc().
> > These allocations can be variably sized and their contents can be more
> > or less controlled from userspace, which makes them useful for attackers
> > that want to overwrite a use-after-free'd object from the same kmalloc slab
> > (which often just requires the sizes to roughly match into the same kmalloc
> > bucket). [0] is an easy example of an exploit that uses netlink skb
> > allocation to target another similarly-sized accidentally freed object.
> > 
> > While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, these are
> > probabilistic. Use the existing kmem buckets API to further isolate these
> > allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=y.
> > 
> > Link: https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> >  net/core/skbuff.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 44a7f8401468..1f6c6b531ece 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -594,6 +594,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >  	return kmalloc_node_track_caller(obj_size, flags, node);
> >  }
> >  
> > +static kmem_buckets *skb_data_buckets __ro_after_init;
> > +
> >  /*
> >   * kmalloc_reserve is a wrapper around kmalloc_node_track_caller that tells
> >   * the caller if emergency pfmemalloc reserves are being used. If it is and
> > @@ -632,7 +634,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
> >  	 * Try a regular allocation, when that fails and we're not entitled
> >  	 * to the reserves, fail.
> >  	 */
> > -	obj = kmalloc_node_track_caller(obj_size,
> > +	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> >  					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
> >  					node);
> >  	if (likely(obj))
> 
> What about kmalloc_pfmemalloc()?

Good point, that looks free as well.

Sidenote: isolating kmem_cache_alloc for possibly-aliasing caches could also
be useful. skb allocation has net_hotdata.skb_small_head_cache. It doesn't merge
with anything for $raisins (odd size, plus I don't think usercopy caches are
getting merged?) but it feels too... accidental?

Maybe passing something like SLAB_NO_MERGE and making the size
standard-looking would be nice. I have a size of 704 bytes per object, and
this probably causes some weird wastage for each slab.


-- 
Pedro

