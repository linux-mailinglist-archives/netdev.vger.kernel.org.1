Return-Path: <netdev+bounces-178784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A326A78E1C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8577D189575B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0435236451;
	Wed,  2 Apr 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DeX/TrKk"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A720E01D;
	Wed,  2 Apr 2025 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596385; cv=none; b=eniYhIULoB2UGepzqTz0VUCTaOXOLjZMbsMegU0cLl0dTMv1RIisMga5v2jXdGTMrnPJZv//lYjTvymPo//Fo4IzuSjD7ZJgwLX1J8PVvHx87dNVAQtOM7nMbDi01oXQQZRWEOx0S8u62HeaUoRxq4RrE/NE0D4CpdvvX4nwVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596385; c=relaxed/simple;
	bh=kolbk5Q3wtJxd0+NiGQSwAuJbT11Mr9/eiUv+PMRFnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4Kc58QFe5PhpY/2fg4wtoz2r2NGlHugT2YSFwnhv4S0dIjMxDZXuv/+BVjZcETbTEywKwvCxPn9AHB7JA/ALLQRYRrD4ARTnBlYQjnU4RmQWvfz/QIkETISJdwjROTY+Xkz0Np5TgLp32JL3ah1K8peygjWS+o7YvTzLF2enxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DeX/TrKk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tYWalLVq1oY7YpgCK/9TLrLFA6SrCHespTPHmhCT5W0=; b=DeX/TrKkUl7ChmLIkudAGakoJN
	wsSUgMerqtPGyl9OXs8f24kpWwBVJCMpW/mnnpHVcIc4OFtPRxqhUGuMvHw4wCWTy7pEstmV8dRqn
	SadtUutQ0Bhw+tvxfLx5Iy7VQHuSg3eZ7EzlI/tibq4jui7PPUzPDGdga1tKZm4PN1gijbLSSu5Yt
	AdWyU6i6jvl5Vs8HVhz4pa7OScaG9WOdE/0xPQ3XyXx1/O7YS7ikRMNrc3+BZ9bxl1zp5Mn9mnwly
	/7hMuerNACzK46FGeyFdO5XBglm5/1g1jneirQD7kOlp0jIWa3mTQpDGl+5poSLkMLitbYYaAlA9P
	3LY4gU1A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzx4C-00000007171-1r8R;
	Wed, 02 Apr 2025 12:19:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7678D30049D; Wed,  2 Apr 2025 14:19:35 +0200 (CEST)
Date: Wed, 2 Apr 2025 14:19:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	torvalds@linux-foundation.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <20250402121935.GJ25239@noisy.programming.kicks-ass.net>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <Z-0SU8cYkTTbprSh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-0SU8cYkTTbprSh@smile.fi.intel.com>

On Wed, Apr 02, 2025 at 01:32:51PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 01, 2025 at 03:44:08PM +0200, Przemek Kitszel wrote:
> > Add auto_kfree macro that acts as a higher level wrapper for manual
> > __free(kfree) invocation, and sets the pointer to NULL - to have both
> > well defined behavior also for the case code would lack other assignement.
> > 
> > Consider the following code:
> > int my_foo(int arg)
> > {
> > 	struct my_dev_foo *foo __free(kfree); /* no assignement */
> > 
> > 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > 	/* ... */
> > }
> > 
> > So far it is fine and even optimal in terms of not assigning when
> > not needed. But it is typical to don't touch (and sadly to don't
> > think about) code that is not related to the change, so let's consider
> > an extension to the above, namely an "early return" style to check
> > arg prior to allocation:
> > int my_foo(int arg)
> > {
> >         struct my_dev_foo *foo __free(kfree); /* no assignement */
> > +
> > +	if (!arg)
> > +		return -EINVAL;
> >         foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> >         /* ... */
> > }
> > Now we have uninitialized foo passed to kfree, what likely will crash.
> > One could argue that `= NULL` should be added to this patch, but it is
> > easy to forgot, especially when the foo declaration is outside of the
> > default git context.

The compiler *should* complain. But neither GCC nor clang actually
appear to warn in this case.

I don't think we should be making dodgy macros like you propose to work
around this compiler deficiency. Instead I would argue we ought to get
both compilers fixed asap, and then none of this will be needed.

