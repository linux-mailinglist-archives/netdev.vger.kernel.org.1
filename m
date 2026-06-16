Return-Path: <netdev+bounces-299784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QoPbKKkVMWqVbQUAu9opvQ
	(envelope-from <netdev+bounces-299784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E468D7B1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:21:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GG1VgaOa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OmMcESaN;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GG1VgaOa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OmMcESaN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299784-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299784-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2525D30233E1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F4425CC0;
	Tue, 16 Jun 2026 09:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1017423142
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:20:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601632; cv=none; b=rMGoXSVYEEeXKhIb8HsScsnHwrnMGxX8pa1nSR55+7u6+sClRxJI1FlczFJBNYAGQAoeQWKJsjxniVSopIVIejmc4+/Rf/bmpDTSQ8MuJW+5/AZCmb3+YK7/o8gRXLU1Vx6nXGiPZ1JfmFQs43v0yllxDUjW/v0eYNY4umykhl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601632; c=relaxed/simple;
	bh=i0DVo8L4z7bKXdFdqTZAdPKP4ihP4U+9EZ39XGunM3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOJv2Sy4TJN/MeuVK/rWeFzbx4r0o4XTxbljEb47uVFAqyfMgrFRk4fWyC/exOWM+9VLkdxdcgnTLgE0viMz00LUMfEWVOJOubq6YP3YsbJJGRDrEFLdWT+iAe0qZL8ebaqVKY4P1Yuj4PZdPGHzixgl3uXgelJBrYyEVox0k3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GG1VgaOa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OmMcESaN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GG1VgaOa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OmMcESaN; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 013356C6B9;
	Tue, 16 Jun 2026 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781601629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1yCvhH13gtBfeltjB9Ohv+Zzo8kfs8ztYt0Jc+FSMBg=;
	b=GG1VgaOa/mxsWhVtWBV31CGGeWvEvBjcmIQ4YxWXPZlesczPS6DWMrswsTUIBiF6h94qwP
	/2TxhAtMBz+2kO/VUK6sPjpaJ+aFe74HPKE8TTAn7qdfPycnqY6Vp35gtB1E4bmdbbDtTw
	Pc2gOKpO9CNRiLXWBteAsxn7qhglsZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781601629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1yCvhH13gtBfeltjB9Ohv+Zzo8kfs8ztYt0Jc+FSMBg=;
	b=OmMcESaNOU9hK6UE4bKh79NId7JOMOXXy4UlXza8smGwMf85+9pPvCj6A94Z1iiEXfUrt2
	+MDehBtltHZH8ACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781601629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1yCvhH13gtBfeltjB9Ohv+Zzo8kfs8ztYt0Jc+FSMBg=;
	b=GG1VgaOa/mxsWhVtWBV31CGGeWvEvBjcmIQ4YxWXPZlesczPS6DWMrswsTUIBiF6h94qwP
	/2TxhAtMBz+2kO/VUK6sPjpaJ+aFe74HPKE8TTAn7qdfPycnqY6Vp35gtB1E4bmdbbDtTw
	Pc2gOKpO9CNRiLXWBteAsxn7qhglsZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781601629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1yCvhH13gtBfeltjB9Ohv+Zzo8kfs8ztYt0Jc+FSMBg=;
	b=OmMcESaNOU9hK6UE4bKh79NId7JOMOXXy4UlXza8smGwMf85+9pPvCj6A94Z1iiEXfUrt2
	+MDehBtltHZH8ACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D3D9779A8;
	Tue, 16 Jun 2026 09:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JOUNI1sVMWoTMAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 16 Jun 2026 09:20:27 +0000
Date: Tue, 16 Jun 2026 10:20:25 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Luigi Rizzo <lrizzo@google.com>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	willemb@google.com, kuniyu@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <ajESl4osXP7roz5q@pedro-suse.lan>
References: <20260615234220.3946885-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299784-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pedro-suse.lan:mid,suse.de:dkim,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 194E468D7B1

(+cc page pool maintainers)
On Mon, Jun 15, 2026 at 11:42:20PM +0000, Luigi Rizzo wrote:
> The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> especially with greedy senders, this has a high chance of happening in
> the softirq handler for tx network interrupts, creating a significant
> performance bottleneck.
> 
> Allow tx sockets to allocate socket buffers directly from the bounce
> buffers. This avoids the second copy and removes the above bottleneck.
> The fraction of swiotlb buffers allowed for this feature is set with
>    /sys/module/swiotlb/parameters/zerocopy_tx_percent
> (0 means disabled, 90 is the maximum, to avoid persistent I/O failures).
> 
> Implementation:
> - define a new page type to unambiguously identify bounce buffers used
>   as backing storage for socket buffers
> - modify skb_page_frag_refill to perform the modified allocation
> - modify the destructors __free_frozen_pages(), free_unref_folio() to
>   handle those pages and return them to the pool.
> 
> The savings are especially visible with fewer queues. In synthetic
> benchmarks, senders with 1-2 queues would cap around 50Gbps with
> conventional swiotlb, and reach over 170Gbps with the feature enabled.

I could be wrong, but I genuinely think that the way to go about this is
using page_pool for regular TX as well. page_pool pages are all dma-mapped
(so whatever swiotlb optimization you want can be done there), and the net
stack already has awareness of these special pages and special skbs, so it
won't Just Return Them back to the page allocator.

Otherwise you can easily go all over the place, and that's just not great.
Also this could possibly benefit setups that use IOMMU as well.

-- 
Pedro

