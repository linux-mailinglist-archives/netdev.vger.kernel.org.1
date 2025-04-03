Return-Path: <netdev+bounces-179087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7A2A7A8A9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 19:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C876C170D72
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A7250C15;
	Thu,  3 Apr 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="osqwXwn0"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5D19ABD4;
	Thu,  3 Apr 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743701747; cv=none; b=PNasCfPCY77Q1Q3+oNCFzVrrtxiv0qpbgJu8+9EwuuDANW93MuelXnOTayO1M77u5dGjeZlfDHHfSz5z7o8lV7eqJ86GVK+Tw0PQFMnF0+l4rJcUWahBfYEZaa0YyosnvIRiHXngGWRuqkXuAC4vSckT5LEk+dzaQsVRRP1Dpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743701747; c=relaxed/simple;
	bh=d+CWsA7N6x5bypcgUn4rlZNi6RhNGKz6daNKzvJBAkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjw7J0qrSEbvHo4x5wiPL6HE2VV9K39aVvawfFerYcAOzAtLK2odPY/Ah5LobiObPruU9C9ZTqkuTvxSLzNZHO2et44zT4amevwnYGAaajeHu28BXv/8fysDLAtmcS5BfAGpiKrjS1zKospmSkpZ2aUP1s6HxYXPkUo0iCJctps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=osqwXwn0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+zNCb4oElSV++JAIxIy8ekV4APM4kOcdN9c8XwdVuQM=; b=osqwXwn0wMWUxQtyTC40Lv91ML
	HSG85bEEGPO5mZb3oDOxb8u7trcXhCenNqXAlRZXvOEM52dHN9r8WpieqwDSbBjgQVot+/mtu1mPm
	BBbervCmlr1RYjM02vxZBRyslpWy8KOoQB31VtJYzzr0hBv3RZRh37GcFLGNPBedjn/XmKqJ6Dp5O
	PqIeR57OZi7qyync5onN6uDvfcMWNtfDjfJqCp5bAbx/rR/nnfmZXc/fYMtXzQFF7v6wNmimNY3Ov
	+WzaK0pHNDAnpZlFd+kIK30RFVN/1rxbQ58SUIrSScDo1FxljuAV6qh2wMqd5hZYZ8iOoGVyJ636c
	Q0dGiLAg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OTb-0000000DOaJ-17Bp;
	Thu, 03 Apr 2025 17:35:39 +0000
Date: Thu, 3 Apr 2025 18:35:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	torvalds@linux-foundation.org, peterz@infradead.org,
	Jann Horn <jannh@google.com>, andriy.shevchenko@linux.intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Harry Yoo <harry.yoo@oracle.com>, Christoph Lameter <cl@gentwo.org>
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <Z-7G6_jm4SKtSO7a@casper.infradead.org>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <3f387b13-5482-46ed-9f52-4a9ed7001e67@suse.cz>
 <202504030955.5C4B7D82@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504030955.5C4B7D82@keescook>

On Thu, Apr 03, 2025 at 09:59:41AM -0700, Kees Cook wrote:
> On Wed, Apr 02, 2025 at 12:44:50PM +0200, Vlastimil Babka wrote:
> > Cc Kees and others from his related efforts:
> > 
> > https://lore.kernel.org/all/20250321202620.work.175-kees@kernel.org/
> 
> I think, unfortunately, the consensus is that "invisible side-effects"
> are not going to be tolerated. After I finish with kmalloc_obj(), I'd
> like to take another run at this for basically providing something like:
> 
> static inline __must_check
> void *kfree(void *p) { __kfree(p); return NULL; }
> 
> And then switch all:
> 
> 	kfree(s->ptr);
> 
> to
> 
> 	s->ptr = kfree(s->ptr);
> 
> Where s->ptr isn't used again.

Umm ... kfree is now going to be __must_check?  That's a lot of churn.

I'd just go with making kfree() return NULL and leave off the
__must_check.  It doesn't need the __kfree() indirection either.
That lets individual functions opt into the new safety.

