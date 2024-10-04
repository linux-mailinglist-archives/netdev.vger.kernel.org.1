Return-Path: <netdev+bounces-131937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CBA98FFCE
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BC71F215A1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2B147C9B;
	Fri,  4 Oct 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZfgwYR2X"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6983F1448DF;
	Fri,  4 Oct 2024 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034397; cv=none; b=TSl4cuyH/DxSH8pyplf6sb6lWXvex+L3VI50uv7UlAiITNf6j8VV4mE40ShKusvgeooIpWZNb+uNh4XYeQ0sgFPEeVmXh2cfiIOXIZxE9dtAEhNqU2kEWjxZaUqQLuYyzrAXA4aJYWohGhdlJisRSpyBfX5ZrhKJD83rwWg3qtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034397; c=relaxed/simple;
	bh=15PXJDPEpkT6NOSIzX8RENsvPLMNV0sN4TqJKOdxNgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLbpehxSMnriL4gkZzOjEomowvmP463VI289t1nGvaqc4SgTTiw8jCnt1vuxxkn9E/+g2bzCFENrHEdfkmqPC90Z+OCjBps8kiTJRVTs6Z9CDUEPt3EE2Ron7owDzidWjiZSwhDjPz6467hXSU98GfCW7o4BQEd7Evh9XlV12IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZfgwYR2X; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=14KluE/LHokBuCB5SwHA3aLDg/3wRxJ1KUVsPcYEMV0=; b=ZfgwYR2X2HIh0n+zkwcif++5Ai
	iZQwnJrVTnwoekEU874sQ44vLmFeamWV5PA1DmstnKEo4dV3EhtFngcIuIO+e2nqMzvFCBzqleyM9
	LjN7dR5cmxKtdqXvJ3ZFj5Jt7ob7LAVsC8/OAB0yJyGkngio0GBnPcq/odSQc9jmQxvevVJYWl6cn
	860yshwi7sX33w41P+xWwiCNN1uo9SjGKSPELc1TdHLxK/cxBzLDtJlRE8XIB3JeX/aAg/RB1W8V7
	tpjY2+TYxkCARcJSfNOCcOB3PszfmVuRb9L/rSL2o7y8KGRo68UHNj44xIRzJyEWxhJMcabZG44YF
	OUnOCxeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swegP-00000003oNd-3udH;
	Fri, 04 Oct 2024 09:33:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4B56030083E; Fri,  4 Oct 2024 11:33:08 +0200 (CEST)
Date: Fri, 4 Oct 2024 11:33:08 +0200
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
Message-ID: <20241004093308.GI18071@noisy.programming.kicks-ass.net>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <Zv6RZS3bjfNcwh-B@smile.fi.intel.com>
 <Zv6SIHeN_nOWSH41@smile.fi.intel.com>
 <20241003141221.GT5594@noisy.programming.kicks-ass.net>
 <Zv7ZsieITDle2lgl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv7ZsieITDle2lgl@smile.fi.intel.com>

On Thu, Oct 03, 2024 at 08:51:46PM +0300, Andy Shevchenko wrote:

> > I would really like to understand why you don't like this; care to
> > elaborate Andy?
> 
> To me the idea of
> 
> int my_foo(...)
> {
> 	NOT_my_foo_macro(...)
> 		return X;
> }
> 
> is counter intuitive from C programming. Without knowing the magic behind the
> scenes of NOT_my_foo_macro() I would eager to ask for adding a dead code like
> 
> int my_foo(...)
> {
> 	NOT_my_foo_macro(...)
> 		return X;
> 	return 0;
> }

Well, this is kernel coding, we don't really do (std) C anymore, and
using *anything* without knowing the magic behind it is asking for fail.

Also, something like:

int my_foo()
{
	for (;;)
		return X;
}

or

int my_foo()
{
	do {
		return X;
	} while (0);
}

is perfectly valid C that no compiler should be complaining about. Yes
its a wee bit daft, but if you want to write it, that's fine.

The point being that the compiler can determine there is no path not
hitting that return.

Apparently the current for loop is defeating the compiler, I see no
reason not to change it in such a way that the compiler is able to
determine wtf happens -- that can only help.

> What I would agree on is
> 
> int my_foo(...)
> {
> 	return NOT_my_foo_macro(..., X);
> }

That just really won't work with things as they are ofcourse.

> Or just using guard()().

That's always an option. You don't *have* to use the -- to you -- weird
form.


