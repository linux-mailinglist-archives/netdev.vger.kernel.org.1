Return-Path: <netdev+bounces-138172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC89AC7E3
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1994E1C20B2D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28A1A727D;
	Wed, 23 Oct 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GDposURQ"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CD1AA7AA;
	Wed, 23 Oct 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679188; cv=none; b=DcCNL+6HfbOwbpQWDENK9D3p8KUX0pRVorx1E0tdpmIo/4xR8MnPnOMWvP2zvr0TFWJsA4y5isZD86w7Uuwo0T/wcpZJdHBo9BdzrnBJG1bh3nA1uuUntoMjO9hPJOQfTCole1iz7r8wKNONyIhfyEG6E+frnjd0pcOuX/LYGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679188; c=relaxed/simple;
	bh=VUMd6Qvh9KQf375hJ+IDZ84kEpNnUFkgGnI/5etwR28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFUmDkisjIwUJ8JuGkDudzxz6lcyE4AJu+GiqjMDdOKlVp7c3pJ/gOeYqS7NU1Ogmsb0Iqm2rd1URvQH6dDaCCcndwCHKlohuPfDqyP1Jpbik6YncBpel0JycNGnVn9ZyyL4luTaOFDtBE8ZLLNaizW0roPFuQqUHpz+/IJMPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GDposURQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3FHBkBXYKZ3rKrf2JpbLNn6a5JolzYYI8DJQ+fxlZK0=; b=GDposURQ12m7dpKynfkJ7kSl70
	v7u9GhA4sxdmKQjoEMHSi5GmIJ0nP6BqE6e5NgH6V4SQdbTvkXLqkltgf/Ddy/rLgpmS+kOBYegJl
	KK7aT3z/t9URXb+CvdQXl8jd7UX3frxHtClz+0urld9MpwJxxJxkOymzFVBkKO/CV/hpIaQkOl+OA
	2xhedT28UdlGSJ3JJTZ11XacdyGyrjJ5aIt7rkRLqmXF3pk5XkQ9s0n0X6Wl6jtnvi0Jm2kGwsSab
	IXoieXoNJos11cQda0Kgf5zaGli0C5e1QTDWqx2xeHu3rubcxzbqbfXxabe1VyTY5zRzxwnX56A8z
	9KZ23MkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YZJ-00000008NrH-0KnN;
	Wed, 23 Oct 2024 10:26:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E580301171; Wed, 23 Oct 2024 12:26:20 +0200 (CEST)
Date: Wed, 23 Oct 2024 12:26:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <keescook@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4] cleanup: adjust scoped_guard() macros to avoid
 potential warning
Message-ID: <20241023102620.GI16066@noisy.programming.kicks-ass.net>
References: <20241018113823.171256-1-przemyslaw.kitszel@intel.com>
 <ZxKz5jGCNZSAbNo-@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxKz5jGCNZSAbNo-@google.com>

On Fri, Oct 18, 2024 at 12:15:50PM -0700, Dmitry Torokhov wrote:
> Hi Przemek,
> 
> On Fri, Oct18, 2024 at 01:38:14PM +0200, Przemek Kitszel wrote:
> > Change scoped_guard() and scoped_cond_guard() macros to make reasoning
> > about them easier for static analysis tools (smatch, compiler
> > diagnostics), especially to enable them to tell if the given usage of
> > scoped_guard() is with a conditional lock class (interruptible-locks,
> > try-locks) or not (like simple mutex_lock()).
> 
> Thank you for making all these improvements!
> 
> >  
> > +#define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
> > +static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
> 
> Question - does this have to be a constant or can it be a macro?

One macro cannot define another.

