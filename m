Return-Path: <netdev+bounces-307731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p5rOCNdqV2pdNQEAu9opvQ
	(envelope-from <netdev+bounces-307731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:11:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1A975D638
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ai83GQU1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mAvO173l;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ai83GQU1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mAvO173l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307731-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307731-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194A8302E788
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B238442105;
	Wed, 15 Jul 2026 11:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5444163E
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 11:07:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113675; cv=none; b=Btixsd/EXyJn4gNUs3D63W3wB4TtOx4/1p9j2GX+FdpFvU1o2OJ9UdNNs2f70DJdjE3/v9PIxUNc/axPN9ONHCrOO/h8RTh0E1v1WxVEFBwFJh5FwNG8hEuwvqXgLh1MsCz0hwlvI4F48T//83TQth9u2pJbx6wvm9ZSuu++ZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113675; c=relaxed/simple;
	bh=Hc514JNshgqWceOMm9U2mfrHvFSvhhnQoBZQ351+jAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkoIKcuWiwaeFbFMfQtBM0SQpldbErtXKGCt0BILqEtfk1uKUJjmqB944KRchuEBWezXVr6eUD7vvaNT6E+4Izo4NghDnDzL1U38D3C+Wob7BktFjyh/1nmq18DKNfWiD+7VZc3V/oKRrjITNnTIdGHbXQcAbK1sp3T4TK80tK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ai83GQU1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mAvO173l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ai83GQU1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mAvO173l; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07A567837A;
	Wed, 15 Jul 2026 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784113672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nioUefq1xbXjtodWxvKxZTWQPlbxpqryGWIKwDtgw9w=;
	b=ai83GQU1QSLW4HMqQLHqkTNNKJcdnVJeYTkcJczwLEkaWbE4HH08Sgzz4Zi3FfHHLXKF0w
	BUqWf9xtp+Poz7MSTvJxVILX1rJ1fg0J0/12EhNSXj8Ts27FocAgBdZZtHRJP2E0SYcjVW
	dRLsXyhi36zD9Vi640oinf7YuU/RvAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784113672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nioUefq1xbXjtodWxvKxZTWQPlbxpqryGWIKwDtgw9w=;
	b=mAvO173lFLygJBfvjytDRj9llSE+d8jC3KzkTwirCPAfOhdFiZxPmaq14VxHUPIQnWNtTe
	BMuK6oUQqZjAcqAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784113672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nioUefq1xbXjtodWxvKxZTWQPlbxpqryGWIKwDtgw9w=;
	b=ai83GQU1QSLW4HMqQLHqkTNNKJcdnVJeYTkcJczwLEkaWbE4HH08Sgzz4Zi3FfHHLXKF0w
	BUqWf9xtp+Poz7MSTvJxVILX1rJ1fg0J0/12EhNSXj8Ts27FocAgBdZZtHRJP2E0SYcjVW
	dRLsXyhi36zD9Vi640oinf7YuU/RvAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784113672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nioUefq1xbXjtodWxvKxZTWQPlbxpqryGWIKwDtgw9w=;
	b=mAvO173lFLygJBfvjytDRj9llSE+d8jC3KzkTwirCPAfOhdFiZxPmaq14VxHUPIQnWNtTe
	BMuK6oUQqZjAcqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E927779AE;
	Wed, 15 Jul 2026 11:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iqBNAAdqV2ooAwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 15 Jul 2026 11:07:51 +0000
Date: Wed, 15 Jul 2026 12:07:49 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Harry Yoo <harry@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	linux-mm@kvack.org, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
Message-ID: <aldpAY6nXwgayHL0@pedro-suse.lan>
References: <20260702170728.168755-1-pfalcato@suse.de>
 <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
 <ak4w2k4Woj55E0On@pedro-suse>
 <529e3997-d26f-4d8e-ad90-3329fe90e555@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529e3997-d26f-4d8e-ad90-3329fe90e555@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307731-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:kees@kernel.org,m:linux-mm@kvack.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:from_mime,suse.de:dkim,pedro-suse.lan:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C1A975D638

On Wed, Jul 08, 2026 at 10:27:54PM +0900, Harry Yoo wrote:
> 
> 
> On 7/8/26 8:16 PM, Pedro Falcato wrote:
> > On Wed, Jul 08, 2026 at 10:30:50AM +0200, Paolo Abeni wrote:
> >> On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
> >> sk_buff *napi_build_skb(void *data, unsigned int frag_size)
> >>>  }
> >>>  EXPORT_SYMBOL(napi_build_skb);
> >>>  
> >>> +static kmem_buckets *skb_data_buckets __ro_after_init;
> >>> +
> >>>  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >>>  {
> >>>  	if (!gfp_pfmemalloc_allowed(flags))
> >>> @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >>>  	if (!obj_size)
> >>>  		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
> >>>  					     flags, node);
> >>> -	return kmalloc_node_track_caller(obj_size, flags, node);
> >>> +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> >>> +						    flags, node);
> >>
> >> Sashiko noted that some drivers may require GFP_DMA buckets, and the
> >> above may break them:
> >>
> >> https://sashiko.dev/#/patchset/20260702170728.168755-1-pfalcato%40suse.de
> > 
> > Oh, this is really awkward. Adding linux-mm and slab maintainers for input here.
> > 
> > Considering the current slab bucketing does not seem to duplicate DMA or
> > CGROUP caches, could it make sense to duplicate those as well?
> 
> Could we specify what kmalloc types the user needs when creating
> kmem_buckets and duplicate caches for the requested kmalloc types only?

Perhaps. But do the users themselves know? alloc_skb() allows users to specify
random __GFP flags. We're bound to see some random caller do
alloc_skb(__GFP_ACCOUNT) ;)

In all honesty, I'm not quite sure what the best way forward here is. The most
transparent way is to bucket those other kmalloc types as well, but that might
very trivially result in a lot more caches (and possibly memory usage) for no
great reason. So perhaps specifying caches might do.

-- 
Pedro

