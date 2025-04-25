Return-Path: <netdev+bounces-185964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1DA9C5E1
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C206189650E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1348C241674;
	Fri, 25 Apr 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cWiUqFTr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y0ZmVzGf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fqJV5IG0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R7k0UeX/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571F2472A0
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577754; cv=none; b=kX8S27HcGzVWRhK94obJ1+hQGe34Z0okwJ+ZKrVzM7diUSPThSQ5DT0ctYrG/M+6ZAurbUmDcYIgW82AQ9wN7scrS8kyo4vFhlrCTcRFem2JUKkft8D2xQIzKVg66Hx3ld/hb1sML7CJdpM7ZxbE0/8SZE7SSc+V1sLaOk3c/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577754; c=relaxed/simple;
	bh=01s7FYAwXYKUUmCA4M7YdS5f1Frdy10xeLcV1T4JnZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJFVyQ3iCKLUQ2LUa2zHq5zRZ7BpXYH/ipGtOY7+GckE5+QKdlETqAds/PyQrhPT+9Ibk05omlDUlqA2b9rU5ribga1FHpQY62ztdKFIs/UsRaeZltZ879z7d9QV86xK2Gr4xMy9+KLhMRH4q5qmCohYikUUPQlVO5rNEZBRqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cWiUqFTr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y0ZmVzGf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fqJV5IG0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R7k0UeX/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D807921165;
	Fri, 25 Apr 2025 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745577751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkLOb7ep/XB+oGXue+ezpJrDGGh8x1ALKKM4drPkRMQ=;
	b=cWiUqFTr/2nFFeZmXzq3gKG3ltuuH1WlH/mxpn3GoNjeaeOC92SV5krw71BNTqemdV9SaN
	qdcOtv8tEzzKC/J5/DJ9IFAtBLG8WmLzDrXv7pIQKtkh6grseMkEBTPLh0/HKrby0rznEy
	OcW8LtWjdpYGs14ywBOqrwqJGRY1vzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745577751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkLOb7ep/XB+oGXue+ezpJrDGGh8x1ALKKM4drPkRMQ=;
	b=Y0ZmVzGf8B2yX5w9q1/sTgxqIZVPC5n99odt67I5nKJCgZ8QjY/kMNWcnuTG7gzzqp9VWU
	rE2PK7jgJwiTn7Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fqJV5IG0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="R7k0UeX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745577750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkLOb7ep/XB+oGXue+ezpJrDGGh8x1ALKKM4drPkRMQ=;
	b=fqJV5IG0bhNfyGdivbLUgLIffWPuW/tU+2b0TxuTUeJpQV7idraaWU2HjbR6LdA9z//NAg
	PLmNpOJ0oMH6TYjXVjeZEy9Whvd71iMeFZqMJDxyg8QGKQnAH4GXeWEQlIfIjr6mTJeseA
	MzxOlbdUWs0sjCEGAlfk1d+rJuIV4do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745577750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkLOb7ep/XB+oGXue+ezpJrDGGh8x1ALKKM4drPkRMQ=;
	b=R7k0UeX/PFFmh2+kLYJ8KRGZnL6286IStOk86GZ/VGGOKDuj0ylYul0faVZPFtsSUeNOle
	JT8iIsN3clH3BfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 810B21398F;
	Fri, 25 Apr 2025 10:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e5LMGBVnC2jFJQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 25 Apr 2025 10:42:29 +0000
Date: Fri, 25 Apr 2025 11:42:27 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>, 
	Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>, Byungchul Park <byungchul@sk.com>, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the
 percpu allocator scalability problem
Message-ID: <vd3k2bljkzow6ozzan2hkeiyytcqe2g6gavroej23457erucza@fknlr6cmzvo7>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
 <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
 <aAtf8t4lNG2DhWMy@harry>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAtf8t4lNG2DhWMy@harry>
X-Rspamd-Queue-Id: D807921165
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gentwo.org,google.com,linux-foundation.org,kernel.org,gmail.com,mojatatu.com,resnulli.us,nvidia.com,sk.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 25, 2025 at 07:12:02PM +0900, Harry Yoo wrote:
> On Thu, Apr 24, 2025 at 12:28:37PM +0100, Pedro Falcato wrote:
> > On Thu, Apr 24, 2025 at 05:07:48PM +0900, Harry Yoo wrote:
> > > Overview
> > > ========
> > > 
> > > The slab destructor feature existed in early days of slab allocator(s).
> > > It was removed by the commit c59def9f222d ("Slab allocators: Drop support
> > > for destructors") in 2007 due to lack of serious use cases at that time.
> > > 
> > > Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
> > > constructor/destructor pair to mitigate the global serialization point
> > > (pcpu_alloc_mutex) that occurs when each slab object allocates and frees
> > > percpu memory during its lifetime.
> > > 
> > > Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
> > > so each allocate–free cycle requires two expensive acquire/release on
> > > that mutex.
> > > 
> > > We can mitigate this contention by retaining the percpu regions after
> > > the object is freed and releasing them only when the backing slab pages
> > > are freed.
> > > 
> > > How to do this with slab constructors and destructors: the constructor
> > > allocates percpu memory, and the destructor frees it when the slab pages
> > > are reclaimed; this slightly alters the constructor’s semantics,
> > > as it can now fail.
> > > 
> > 
> > I really really really really don't like this. We're opening a pandora's box
> > of locking issues for slab deadlocks and other subtle issues. IMO the best
> > solution there would be, what, failing dtors? which says a lot about the whole
> > situation...
> > 
> > Case in point:
> 
> <...snip...>
> 
> > Then there are obviously other problems like: whatever you're calling must
> > not ever require the slab allocator (directly or indirectly) and must not
> > do direct reclaim (ever!), at the risk of a deadlock. The pcpu allocator
> > is a no-go (AIUI!) already because of such issues.
> 
> Could you please elaborate more on this?

Well, as discussed multiple-times both on-and-off-list, the pcpu allocator is
not a problem here because the freeing path takes a spinlock, not a mutex. But
obviously you can see the fun locking horror dependency chains we're creating
with this patchset. ->ctor() needs to be super careful calling things, avoiding
any sort of loop. ->dtor() needs to be super careful calling things, avoiding
_any_ sort of direct reclaim possibilities. You also now need to pass a gfp_t
to both ->ctor and ->dtor.

With regards to "leaf locks", I still don't really understand what you/Mateusz
mean or how that's even enforceable from the get-go.

So basically:
- ->ctor takes more args, can fail, can do fancier things (multiple allocations,
  lock holding, etc, can be hidden with a normal kmem_cache_alloc; certain
  caches become GFP_ATOMIC-incompatible)

- ->dtor *will* do fancy things like recursing back onto the slab allocator and
  grabbing locks

- a normal kmem_cache_free can suddenly attempt to grab !SLUB locks as it tries
  to dispose of slabs. It can also uncontrollably do $whatever.

- a normal kmem_cache_alloc can call vast swaths of code, uncontrollably, due to
  ->ctor. It can also set off direct reclaim, and thus run into all sorts of kmem_
  cache_free/slab disposal issues

- a normal, possibly-unrelated GFP_KERNEL allocation can also run into all of these
  issues by purely starting up shrinkers on direct reclaim as well.

- the whole original "Slab object caching allocator" idea from 1992 is extremely
  confusing and works super poorly with various debugging features (like, e.g,
  KASAN). IMO it should really be reserved (in a limited capacity!) for stuff like
  TYPESAFE_BY_RCU, that we *really* need.

These are basically my issues with the whole idea. I highly disagree that we should
open this pandora's box for problems in *other places*.

-- 
Pedro

