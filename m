Return-Path: <netdev+bounces-185505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C633A9ABBE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2152E189FEEF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E1222595;
	Thu, 24 Apr 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rNb3xYDo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w7YLHNPW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rNb3xYDo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w7YLHNPW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C712701B1
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494138; cv=none; b=ng29neV+BlWrlKATy4r5KzqOHrvrvkBn4L/eQY7gHbTUGZWIZPjwqlz8+gjUlVDuMgYwHNXFkXlis/TlzB/G0pBHk6y/Pz7LL7Xpl9bQzYnHTKJHoLooxyHaEdT/Cqu0qOZDnzXqAoYwTzf9HSFjiMs9IZe7ORbM6MWs8/+whgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494138; c=relaxed/simple;
	bh=zB60+alblbYHMwKWew7Y71SuhpY9yTWh/4rUgG11Qo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZgBTbjbzogJFKvT7hr7kyJoAfwvZNdllu5xV+I2SocE6NMjtdXowVgswZbnuP4bF9Otgyh3cgyb6CFRSFR7VpGZQRkr2EaWNz869EBtrtVPrE4ADTFp6iJY+UPDPpGVcLzp9/5BWjsBWJbETQ5iEuPovml2AGEEIJCPYb1aYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rNb3xYDo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w7YLHNPW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rNb3xYDo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w7YLHNPW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 803A021171;
	Thu, 24 Apr 2025 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745494135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBfxIUFb6Wi4ZOUmIf9v+/3evFqDQIaD4Xx97OscEQs=;
	b=rNb3xYDod78VKRHrk8rmwtaUQLD47juZn8PUyBzJCwBldOcjD5kvY2SFu7zAYM/q6hyUy6
	o/s4mgWSuCWQqzbni3gT/Q37Oo7AUVijFPfua7padGYZfZHe5EqM5FI22Vwjav3o0igXsJ
	6Uf49ES99/kbFwElIntDzQsl7p2S+a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745494135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBfxIUFb6Wi4ZOUmIf9v+/3evFqDQIaD4Xx97OscEQs=;
	b=w7YLHNPWOfe51DKNAJbmpwK3kIk2SpQB1ADESOyNZagDetijisf0c/AyfVdBSRuBVsAgOX
	8gNwFI0fLw7s5KBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745494135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBfxIUFb6Wi4ZOUmIf9v+/3evFqDQIaD4Xx97OscEQs=;
	b=rNb3xYDod78VKRHrk8rmwtaUQLD47juZn8PUyBzJCwBldOcjD5kvY2SFu7zAYM/q6hyUy6
	o/s4mgWSuCWQqzbni3gT/Q37Oo7AUVijFPfua7padGYZfZHe5EqM5FI22Vwjav3o0igXsJ
	6Uf49ES99/kbFwElIntDzQsl7p2S+a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745494135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBfxIUFb6Wi4ZOUmIf9v+/3evFqDQIaD4Xx97OscEQs=;
	b=w7YLHNPWOfe51DKNAJbmpwK3kIk2SpQB1ADESOyNZagDetijisf0c/AyfVdBSRuBVsAgOX
	8gNwFI0fLw7s5KBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4886E1393C;
	Thu, 24 Apr 2025 11:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uK0iDXYgCmhiPAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 24 Apr 2025 11:28:54 +0000
Date: Thu, 24 Apr 2025 12:28:37 +0100
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
Message-ID: <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gentwo.org,google.com,linux-foundation.org,kernel.org,gmail.com,mojatatu.com,resnulli.us,nvidia.com,sk.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Thu, Apr 24, 2025 at 05:07:48PM +0900, Harry Yoo wrote:
> Overview
> ========
> 
> The slab destructor feature existed in early days of slab allocator(s).
> It was removed by the commit c59def9f222d ("Slab allocators: Drop support
> for destructors") in 2007 due to lack of serious use cases at that time.
> 
> Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
> constructor/destructor pair to mitigate the global serialization point
> (pcpu_alloc_mutex) that occurs when each slab object allocates and frees
> percpu memory during its lifetime.
> 
> Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
> so each allocate–free cycle requires two expensive acquire/release on
> that mutex.
> 
> We can mitigate this contention by retaining the percpu regions after
> the object is freed and releasing them only when the backing slab pages
> are freed.
> 
> How to do this with slab constructors and destructors: the constructor
> allocates percpu memory, and the destructor frees it when the slab pages
> are reclaimed; this slightly alters the constructor’s semantics,
> as it can now fail.
> 

I really really really really don't like this. We're opening a pandora's box
of locking issues for slab deadlocks and other subtle issues. IMO the best
solution there would be, what, failing dtors? which says a lot about the whole
situation...

Case in point:
What happens if you allocate a slab and start ->ctor()-ing objects, and then
one of the ctors fails? We need to free the ctor, but not without ->dtor()-ing
everything back (AIUI this is not handled in this series, yet). Besides this
complication, if failing dtors were added into the mix, we'd be left with a
half-initialized slab(!!) in the middle of the cache waiting to get freed,
without being able to.

Then there are obviously other problems like: whatever you're calling must
not ever require the slab allocator (directly or indirectly) and must not
do direct reclaim (ever!), at the risk of a deadlock. The pcpu allocator
is a no-go (AIUI!) already because of such issues.

Then there's the separate (but adjacent, particularly as we're considering
this series due to performance improvements) issue that the ctor() and
dtor() interfaces are terrible, in the sense that they do not let you batch
in any way shape or form (requiring us to lock/unlock many times, allocate
many times, etc). If this is done for performance improvements, I would prefer
a superior ctor/dtor interface that takes something like a slab iterator and
lets you do these things.

The ghost of 1992 Solaris still haunts us...

> This series is functional (although not compatible with MM debug
> features yet), but still far from perfect. I’m actively refining it and
> would appreciate early feedback before I improve it further. :)
> 
> This series is based on slab/for-next [2].
> 
> Performance Improvement
> =======================
> 
> I measured the benefit of this series for two different users:
> exec() and tc filter insertion/removal.
> 
> exec() throughput
> -----------------
> 
> The performance of exec() is important when short-lived processes are
> frequently created. For example: shell-heavy workloads and running many
> test cases [3].
> 
> I measured exec() throughput with a microbenchmark:
>   - 33% of exec() throughput gain on 2-socket machine with 192 CPUs,
>   - 4.56% gain on a desktop with 24 hardware threads, and
>   - Even 4% gain on a single-threaded exec() throughput.
> 
> Further investigation showed that this was due to the overhead of
> acquiring/releasing pcpu_alloc_mutex and its contention.
> 
> See patch 7 for more detail on the experiment.
> 
> Traffic Filter Insertion and Removal
> ------------------------------------
> 
> Each tc filter allocates three percpu memory regions per tc_action object,
> so frequently inserting and removing filters contend heavily on the same
> mutex.
> 
> In the Linux-kernel tools/testing tc-filter benchmark (see patch 4 for
> more detail), I observed a 26% reduction in system time and observed
> much less contention on pcpu_alloc_mutex with this series.
> 
> I saw in old mailing list threads Mellanox (now NVIDIA) engineers cared
> about tc filter insertion rate; these changes may still benefit
> workloads they run today.
> 

The performance improvements are obviously fantastic, but I do wonder
if things could be fixed by just fixing the underlying problems, instead
of tapering over them with slab allocator magic and dubious object lifecycles.

In this case, the big issue is that the pcpu allocator does not scale well.

-- 
Pedro

