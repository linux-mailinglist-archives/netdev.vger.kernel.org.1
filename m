Return-Path: <netdev+bounces-299802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o390ANsmMWpAcwUAu9opvQ
	(envelope-from <netdev+bounces-299802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:35:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EAB68E5AB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:35:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c6ZIWxrG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=htIhsYP4;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c6ZIWxrG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=htIhsYP4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299802-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299802-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43F6D30701F0
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0C428462;
	Tue, 16 Jun 2026 10:28:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35351426D00
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:28:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605699; cv=none; b=ItTetc4TadnCBTNir+64ySs0YX+9uTFiCowRTeVM4DNbmqo8bfbcaawnsfvcYoPFIAW0xl5RMPlr70w+DUNJP3CGT6oc24UHaXpFJHUlY5HekRMO9OGMYwX249OSdiCCatLPQMLkpwKDLoJnSH+A/m89QSKZ9Vdk6rMMFidTs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605699; c=relaxed/simple;
	bh=8DWU9VWzxC4XCBak6R0aM7lw2i8FXBebRDSkmvMuPsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPN9sThb0OAow5/QrB8v4s5jqZnDchslCN000DOxM7q2Nyc/SxSB/h2tc7cZ2mBy/13SnxpaCGZTRWQFx5st3V8rX0rtOtEdXjFq11xdLOcUaBo1sDbeASrlwPaVqL/G45wwOMSWFUiNv0AsMlZXDLC/yO48xgBy8u0DDPgZdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c6ZIWxrG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=htIhsYP4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c6ZIWxrG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=htIhsYP4; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9467F75F6B;
	Tue, 16 Jun 2026 10:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781605696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lL22iMRFlTp29xQKd3nBq3piPO8S7G1smf2jDj2dB1g=;
	b=c6ZIWxrGrZXJ+1bGhWCCqluOIc3GDBkYOcQQcPLWaWIXo+WZX7gtO23kujbMHi28KxgYoo
	bPHGu0qFUq/oc72HRAkr9cPAQ2qGGbGr+ZvMGGBotXp5ahrxDIwJzK2Jy69dLH0UY5BllZ
	eY5TzAXb7xCKpcvqbLpqnPhvP4X+bWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781605696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lL22iMRFlTp29xQKd3nBq3piPO8S7G1smf2jDj2dB1g=;
	b=htIhsYP4BWF1M1KA8hAn8VBmBPFgJbTzQsBwLMWLd9JGkId/dCEZKc3Ikxit0zG6p2Z2aG
	o/o+BdVRYi22etAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781605696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lL22iMRFlTp29xQKd3nBq3piPO8S7G1smf2jDj2dB1g=;
	b=c6ZIWxrGrZXJ+1bGhWCCqluOIc3GDBkYOcQQcPLWaWIXo+WZX7gtO23kujbMHi28KxgYoo
	bPHGu0qFUq/oc72HRAkr9cPAQ2qGGbGr+ZvMGGBotXp5ahrxDIwJzK2Jy69dLH0UY5BllZ
	eY5TzAXb7xCKpcvqbLpqnPhvP4X+bWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781605696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lL22iMRFlTp29xQKd3nBq3piPO8S7G1smf2jDj2dB1g=;
	b=htIhsYP4BWF1M1KA8hAn8VBmBPFgJbTzQsBwLMWLd9JGkId/dCEZKc3Ikxit0zG6p2Z2aG
	o/o+BdVRYi22etAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 461E7779A8;
	Tue, 16 Jun 2026 10:28:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jwzTDT8lMWr9dAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 16 Jun 2026 10:28:15 +0000
Date: Tue, 16 Jun 2026 11:28:13 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Luigi Rizzo <lrizzo@google.com>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	willemb@google.com, kuniyu@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <ajEg31FWu9PZT2dk@pedro-suse.lan>
References: <20260615234220.3946885-1-lrizzo@google.com>
 <ajESl4osXP7roz5q@pedro-suse.lan>
 <CAMOZA0+L2+=FEQ5ORvv07JaJix0R+6Q6u01CyMKCbd842To9nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMOZA0+L2+=FEQ5ORvv07JaJix0R+6Q6u01CyMKCbd842To9nA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299802-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lrizzo@google.com,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:hawk@kernel.org,m:ilias.apalodimas@linaro.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,arm.com,google.com,davemloft.net,kernel.org,redhat.com,linuxfoundation.org,linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,linaro.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:from_mime,vger.kernel.org:from_smtp,pedro-suse.lan:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56EAB68E5AB

On Tue, Jun 16, 2026 at 11:48:36AM +0200, Luigi Rizzo wrote:
> On Tue, Jun 16, 2026 at 11:20 AM Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > (+cc page pool maintainers)
> > On Mon, Jun 15, 2026 at 11:42:20PM +0000, Luigi Rizzo wrote:
> > > The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> > > especially with greedy senders, this has a high chance of happening in
> > > the softirq handler for tx network interrupts, creating a significant
> > > performance bottleneck.
> > >
> > > Allow tx sockets to allocate socket buffers directly from the bounce
> > > buffers. This avoids the second copy and removes the above bottleneck.
> > > The fraction of swiotlb buffers allowed for this feature is set with
> > >    /sys/module/swiotlb/parameters/zerocopy_tx_percent
> > > (0 means disabled, 90 is the maximum, to avoid persistent I/O failures).
> > >
> > > Implementation:
> > > - define a new page type to unambiguously identify bounce buffers used
> > >   as backing storage for socket buffers
> > > - modify skb_page_frag_refill to perform the modified allocation
> > > - modify the destructors __free_frozen_pages(), free_unref_folio() to
> > >   handle those pages and return them to the pool.
> > >
> > > The savings are especially visible with fewer queues. In synthetic
> > > benchmarks, senders with 1-2 queues would cap around 50Gbps with
> > > conventional swiotlb, and reach over 170Gbps with the feature enabled.
> >
> > I could be wrong, but I genuinely think that the way to go about this is
> > using page_pool for regular TX as well. page_pool pages are all dma-mapped
> > (so whatever swiotlb optimization you want can be done there), and the net
> > stack already has awareness of these special pages and special skbs, so it
> > won't Just Return Them back to the page allocator.
> 
> I am not sure I follow your comment above, can you expand/clarify?
> 
> The problem I am dealing with is that the copy from the socket buffer
> to the bounce buffer is done in the device xmit function. Under high
> it is almost always done by the tx softirq.
> This means that even if we move the copy outside the HARD_TX_LOCK(),
> it would still be almost completely serialized.
> Hence the proposed method to make skb_page_frag_refill() allocate
> directly a bounce buffer (under specific conditions) so there is a single copy
> done directly to the dma-able buffer, and ii is done  in the user threads/CPUs
> and is not seriallized in the softirq thread.
> 
> I am not sure how page_pool on tx could help here.

Page pool would provide both the means of passing around an iommu-mapped page,
and a concrete "this is where we allocate these pages" spot. Then introducing
a "zero-copy" swiotlb allocation would be a simple matter of introducing this
on page pool's side. In pseudo-code, something like:

static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
						 gfp_t gfp)
{
	struct page *page;

	gfp |= __GFP_COMP;
	
	if (pool->dma_map && /* is_swiotlb */) {
		page = swiotlb_alloc_pages(pool->p.nid, gfp, pool->p.order, ...);
		if (!page)
			return NULL;
		/* page is implicitly swiotlb mapped (well, _actually_ it's
		 * not that simple, because of the dma_mapped tracking that
		 * was introduced, but PoC anyway..). */
	} else {
		page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
		if (unlikely(!page))
			return NULL;

		if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
			put_page(page);
			return NULL;
		}
	}
}

(plus other spots, obviously). No copying should be required, and the
netmem desc will keep the dma_addr around. The network stack will notice
pp_recycle on all of these skbs and simply refuse to throw the pages away to
the page allocator.

In any case, it might be that this is not feasible for XYZ reasons, but I've
thought about this (making net use and reuse page pool pre-iommu-mapped pages
exclusively) for a while and I definitely see a lot of similarities with your
problem (that more or less reduces down to "I want to get an iommu-mapped page
from the get-go").

-- 
Pedro

