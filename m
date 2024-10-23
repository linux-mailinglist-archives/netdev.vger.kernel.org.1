Return-Path: <netdev+bounces-138285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0D9ACCFE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45593B248AB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E020ADC5;
	Wed, 23 Oct 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J/W2RePC"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9F20A5D9;
	Wed, 23 Oct 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693931; cv=none; b=g/yLeKAEtgLxsFiiQ3DESlaJ7Vc7vOntlBpsh556m4Ue4Uv0h7HPelg8KxVe3myuQMnOeyNgdIDyUmuGXDxel3TXA6neRB+iQFaNRTwCJaD25WHY8obhgYDa/RqihWseQGsQ4y+QfAdHtAFdng1SmXzDQmMZeMvgObW7USbA5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693931; c=relaxed/simple;
	bh=1Aw1YYPKTor8fa/AfSMAmhwcPTIkzDMwkYyZMzB41TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aokVn7TqOTSRJCAaDr5KZQEM5jxqkbANV6+zAvuxfsqj+rUYjSh53stYAXNZuSt3dge595chtTMnAljfH82+hwcJQJAWRLU88gM/fPmmxKsSl9jEOg+pynMU+3qvt4ufEClK8+0Fn8C1aE+szrpclbYEffHAg035EGatM7qgFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J/W2RePC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=st7qu5UokEHEesgocAQ0zrKfe0DY+ZCXHcQUXHppVyc=; b=J/W2RePCyEXPdnI/0AJZRR5WiN
	r0oBCbMIAklsx4C5xn11SRlOSe97Oujl40j1YK5m3iJd5SNq4RcQqa4fdunqSptv72FLIF5uLHa0m
	dIXiAPWJ0OEm0bgPTJDGnn3Z+6X2ZSRto5PARw0XboxrNK8aFglYeJePhs/W+oyaN6+Uwj2gloDfL
	C6HrBWDYhMP52Q4gnajdRHQW9SF/Ot3Umhhk91i/owUIRjeCXwXJgQUpKlUf60M9u5B82U1Hr1sCA
	+skwx1OUVBZKhOSCKrYr9wJ71tSEa0DMOJFHI4LcdTh61e42X5/+6OAjacUjCqpeMGIL83Tp5gHvV
	cIQ0lM7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cP7-00000008QA7-1az4;
	Wed, 23 Oct 2024 14:32:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7CD6330073F; Wed, 23 Oct 2024 16:32:04 +0200 (CEST)
Date: Wed, 23 Oct 2024 16:32:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <keescook@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Dan Carpenter <error27@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid
 potential warning
Message-ID: <20241023143204.GB9767@noisy.programming.kicks-ass.net>
References: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>
 <202410131151.SBnGQot0-lkp@intel.com>
 <20241018105054.GB36494@noisy.programming.kicks-ass.net>
 <a7eec76f-1fbc-4fef-9b6d-15b588eacecb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7eec76f-1fbc-4fef-9b6d-15b588eacecb@intel.com>

On Wed, Oct 23, 2024 at 03:43:22PM +0200, Przemek Kitszel wrote:
> On 10/18/24 12:50, Peter Zijlstra wrote:
> > On Sun, Oct 13, 2024 at 12:01:24PM +0800, kernel test robot wrote:

> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -323,7 +323,7 @@ static __maybe_unused const bool class_#
> >    */
> >   #define __scoped_guard(_name, _fail, _label, args...)				\
> >   	for (CLASS(_name, scope)(args);	true; ({ goto _label; }))		\
> > -		if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {	\
> > +		if (__is_cond_ptr(_name) && !__guard_ptr(_name)(&scope)) {	\
> 
> but this will purge the attempt to call __guard_ptr(), and thus newer
> lock ;) good that there is at least some comment above

No, __guard_ptr() will only return a pointer, it has no action. The lock
callback is in CLASS(_name, scope)(args).

