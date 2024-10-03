Return-Path: <netdev+bounces-131625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372098F126
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3FB1F21B00
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD7C19B3F9;
	Thu,  3 Oct 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/+m5gRc"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBD4C8F;
	Thu,  3 Oct 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964749; cv=none; b=OFG+GVDQMhFa91ere4Vv7EduNu12cbDVA2GMQVz71Y8w9Cw8vHgxGMnsHpvSEAGXV5XIS9/aeNLBqfB8SjqhKZtNanABu/9aY6E20UlIp92MB9jNzzEoue+tlfQrFXuYQbonxsSL9EcT5/2XqZkrzAORHHt53u7GE0XxmBwD0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964749; c=relaxed/simple;
	bh=cQd4mMRKVLDRW1NJGKxzReBjq8mteLn3CMjp7CnqjMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTgsXOHZ/rZh8nnoxVtwTMCfA+vy/eI+EL4Cnuf/tqVZtjRx1a5RRmoZSol5/9pHh6nlDu3fDVTob+9jAS0IXjClJ9zO9RUf/gpzKfeWm+SF2eSOhTEfn4aMFZCxk3FlnTW+N6qoMzYliHQfXhzSDdxfKY8wFRTTL/sn2Yh7BUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n/+m5gRc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pVCwUExqiSdr8iY1y7EUoZrut1GRcK+AHbDlzulP3sA=; b=n/+m5gRcdFdn0tqrLejXX5iT1Q
	UM9cnkK09Ws/z3RLAXqGlMoc7VI/JvXoMx/FEIJ2cQGPsKcw1pzny0YOnJFY2CIRUApq7V+vX/jvm
	J4Jg1J1waGTEtjocbeuXkE0p3W6bxcM9KqLRRj3mH09uIXKD3DaLIlg+xtpK6wd9jYqMp/6feOxtD
	1aRXpVNrkJWf7hPCPrVSR7bsbf6tl4lCCW4i07+q5yL30d/S0vtCuaCMY+dZNxc9Jdi+7AcmoUwit
	lcfOQMPNc1xLB7cgetBXLdoOa6SDn2sq6PvNv3aB2yLHlcDGQalqXs5jfabnj+6f8JXbSPzzY1CsK
	GUKCN46g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swMZ5-00000003hBk-0DLR;
	Thu, 03 Oct 2024 14:12:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02DE430083E; Thu,  3 Oct 2024 16:12:21 +0200 (CEST)
Date: Thu, 3 Oct 2024 16:12:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
Message-ID: <20241003141221.GT5594@noisy.programming.kicks-ass.net>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <Zv6RZS3bjfNcwh-B@smile.fi.intel.com>
 <Zv6SIHeN_nOWSH41@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6SIHeN_nOWSH41@smile.fi.intel.com>

On Thu, Oct 03, 2024 at 03:46:24PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 03, 2024 at 03:43:17PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 03, 2024 at 01:39:06PM +0200, Przemek Kitszel wrote:
> 
> ...
> 
> > > +#define __scoped_guard_labeled(_label, _name, args...)			\
> > > +	for (CLASS(_name, scope)(args);					\
> > > +	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
> > > +		     ({ goto _label; }))				\
> > > +		if (0)							\
> > > +		_label:							\
> > > +			break;						\
> > > +		else
> > 
> > I believe the following will folow more the style we use in the kernel:
> > 
> > #define __scoped_guard_labeled(_label, _name, args...)			\
> > 	for (CLASS(_name, scope)(args);					\
> > 	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
> > 		     ({ goto _label; }))				\
> > 		if (0) {						\
> > _label:									\
> > 			break;						\
> > 		} else
> > 

Yeah, needs braces like that. I'm not super opposed to this, however, 

> And FWIW:
> 1) still NAKed;

I would really like to understand why you don't like this; care to
elaborate Andy?

