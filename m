Return-Path: <netdev+bounces-136957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD849A3C2C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76CCDB27083
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F42038C8;
	Fri, 18 Oct 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F8Qt7nny"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA6202624;
	Fri, 18 Oct 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248660; cv=none; b=OF8Vavu89S8yOCplKYvhMCbcCAFcWeLC0J3VzePQX+/h8UvWviBeyqP9CwVHfNmxzkuYk1rVCN1OK3o/Si+y3N/s+22oKgKsJqfMrWX6VmBT6Wt78VitpwGLWhL8rkPp4HoaBYxVfq+CAU5QRu46lzsZzHnYeMfptWIIeRWwM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248660; c=relaxed/simple;
	bh=syJdLYnz5Q70PDNaZn4aYfuviFa7wVVgde/vmOAQEWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYoqvieJsGZtjHj0ldzIANVX1VH1YQ2HvUWCgk6mg8GGI/788kZ2rHa3C5X9koLAjtgEb/pG3SSIMrBueAUKp5vU5sIEPGLajf5B+rFnsdx3chQLiXP6xpsiTyiAmbXSEKzWAYwyXOJxQO/JL1rqwOa+yIY24w16gLZHPCvqsww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F8Qt7nny; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2cU22bSglzDVdcqTFPBtq8HXbywO/nkwltNcPNsssAM=; b=F8Qt7nnyXIJ8jUCjfss2VhOk6T
	OL+E8R1+Q8R8f4UfvHPXgvDIQRA+b+byCTuu51OwS1XmFmu4bjyQiorxdW3zWARXdUvATqvjnKQHs
	f4U4i+aDTWIwFXdhvka0Wwh5j1+FcNwWlZMT20dHWAeR9U6AfuPxyRUn0CTWx5nHLnzd3B6ja2Zb4
	78JNWbjq+Rs6675gYYcgcUoIfvvkf9mmoMoCwrfEy7gnemkgB4ac92puyrNHdTLZnlmrGTC9NRrs5
	nSIm74T6PIyMDp0heZmtasmGiWzF47jq3ixeqQABHpfDawd/SdF0hQy007EC+39cIEP98r5680OB1
	+7bzyI5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1kZK-0000000D0vl-1n9N;
	Fri, 18 Oct 2024 10:50:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 860333005AF; Fri, 18 Oct 2024 12:50:54 +0200 (CEST)
Date: Fri, 18 Oct 2024 12:50:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <keescook@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Dan Carpenter <error27@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid
 potential warning
Message-ID: <20241018105054.GB36494@noisy.programming.kicks-ass.net>
References: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>
 <202410131151.SBnGQot0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410131151.SBnGQot0-lkp@intel.com>

On Sun, Oct 13, 2024 at 12:01:24PM +0800, kernel test robot wrote:
> >> drivers/firewire/core-transaction.c:912:2: warning: variable 'handler' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>      912 |         scoped_guard(rcu) {
>          |         ^~~~~~~~~~~~~~~~~
>    include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
>      197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
>      190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:55:28: note: expanded from macro 'if'
>       55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>          |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
>       57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>          |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/firewire/core-transaction.c:921:7: note: uninitialized use occurs here
>      921 |         if (!handler)
>          |              ^~~~~~~
>    include/linux/compiler.h:55:47: note: expanded from macro 'if'
>       55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>          |                                               ^~~~
>    include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
>       57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>          |                                                    ^~~~
>    drivers/firewire/core-transaction.c:912:2: note: remove the 'if' if its condition is always false
>      912 |         scoped_guard(rcu) {
>          |         ^
>    include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
>      197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
>          |         ^
>    include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
>      190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
>          |                 ^
>    include/linux/compiler.h:55:23: note: expanded from macro 'if'
>       55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>          |                       ^
>    drivers/firewire/core-transaction.c:903:36: note: initialize the variable 'handler' to silence this warning
>      903 |         struct fw_address_handler *handler;
>          |                                           ^
>          |                                            = NULL
>    1 warning generated.

So this goes away when we do:

--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -323,7 +323,7 @@ static __maybe_unused const bool class_#
  */
 #define __scoped_guard(_name, _fail, _label, args...)				\
 	for (CLASS(_name, scope)(args);	true; ({ goto _label; }))		\
-		if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {	\
+		if (__is_cond_ptr(_name) && !__guard_ptr(_name)(&scope)) {	\
 			_fail;							\
 _label:										\
 			break;							\

