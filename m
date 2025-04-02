Return-Path: <netdev+bounces-178788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D1A78E3E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45641896338
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC16236421;
	Wed,  2 Apr 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="exMHggJ/"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40621B199;
	Wed,  2 Apr 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596552; cv=none; b=XtYG2P9Tu5hb7IfkNl0GuGw5YZOm0fw1t2YEzI6uQeWKYA1CRgIfTspoxMvCnQPdtxh9LayKRRpdh+UGExOBEhlrE8bV8q2aMxuQIf0iM1CvJPU3ZHKRJ4Dr7b4FsUDW5be26T/FIFlx84zTwRYuAYJymW+slCS5aA+KLF7lzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596552; c=relaxed/simple;
	bh=rjPUePPhHfImwnSvaxwfF564XJ0VhhEVaBaFthDIdp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWzKRdIRfOGlq8Mcq5Y4fBIc3fOaGrHY3+R+JewHaLjwi8a6zIWe6+Dq3Ke+rlx0iXNOjx364YzqAQWXV5iysyfvFZ74tte3T92lkcvtBUDKn+eVWhWYG6l/1279hk4TXUNxWq3docgLI7wuWePaiqmWUnk5jpZk3LoQBIr0cEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=exMHggJ/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=33b2t4HcrwoP+ai68jl46pM/QnlIuyA8Mc5B+grxlcA=; b=exMHggJ//R3UNW/FQV6swFas17
	utBymsHGwpsvS0cD/fUT65Wxa+tkWNbJzZkCbFpksuhWh/1sZMpX8oEu6+AH5qenYXWbphvvL625h
	BKg6nKjo73TsrmNcQGl+cphViRA8+Kh5u5BURHr1U8bktfgwRyJ1IfXtPl8xvX2tV2+y1mL63G2IE
	ZFjWYBq7Eo0Pa+EfSIyvcZAoiI3/8U1ghZjlOkofcF5lNVM2v8nf1YvjD7zvHS69C/2C5SsU5qYuN
	Ix1CCUS+GIn6rtfLrIhINo8TbHvG2DA2mObaoS7Oeoj/199PLFQxuiiPtgjE6nAMjm9GEqRtzyHsa
	btvoQhng==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzx6v-00000007183-0Szs;
	Wed, 02 Apr 2025 12:22:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A8C68300288; Wed,  2 Apr 2025 14:22:24 +0200 (CEST)
Date: Wed, 2 Apr 2025 14:22:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	torvalds@linux-foundation.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <20250402122224.GB25719@noisy.programming.kicks-ass.net>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <Z-0SU8cYkTTbprSh@smile.fi.intel.com>
 <20250402121935.GJ25239@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402121935.GJ25239@noisy.programming.kicks-ass.net>

On Wed, Apr 02, 2025 at 02:19:35PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 02, 2025 at 01:32:51PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 01, 2025 at 03:44:08PM +0200, Przemek Kitszel wrote:
> > > Add auto_kfree macro that acts as a higher level wrapper for manual
> > > __free(kfree) invocation, and sets the pointer to NULL - to have both
> > > well defined behavior also for the case code would lack other assignement.
> > > 
> > > Consider the following code:
> > > int my_foo(int arg)
> > > {
> > > 	struct my_dev_foo *foo __free(kfree); /* no assignement */
> > > 
> > > 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > > 	/* ... */
> > > }
> > > 
> > > So far it is fine and even optimal in terms of not assigning when
> > > not needed. But it is typical to don't touch (and sadly to don't
> > > think about) code that is not related to the change, so let's consider
> > > an extension to the above, namely an "early return" style to check
> > > arg prior to allocation:
> > > int my_foo(int arg)
> > > {
> > >         struct my_dev_foo *foo __free(kfree); /* no assignement */
> > > +
> > > +	if (!arg)
> > > +		return -EINVAL;
> > >         foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > >         /* ... */
> > > }
> > > Now we have uninitialized foo passed to kfree, what likely will crash.
> > > One could argue that `= NULL` should be added to this patch, but it is
> > > easy to forgot, especially when the foo declaration is outside of the
> > > default git context.
> 
> The compiler *should* complain. But neither GCC nor clang actually
> appear to warn in this case.
> 
> I don't think we should be making dodgy macros like you propose to work
> around this compiler deficiency. Instead I would argue we ought to get
> both compilers fixed asap, and then none of this will be needed.

Ah, I think the problem is that the cleanup function takes a pointer to
the object, and pointers to uninitialized values are generally
considered okay.

The compilers would have to explicitly disallow this for the cleanup
functions.

