Return-Path: <netdev+bounces-293479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPipN7yVHGr4PQkAu9opvQ
	(envelope-from <netdev+bounces-293479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 22:10:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FA2617DC0
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 22:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD49300A8DF
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8AA340403;
	Sun, 31 May 2026 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1sw/8v9H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD733F59F
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780258188; cv=none; b=EUALU2rJQyf6Qj+Y0plistvF9exCYSqreXQHEahgc5jbs8ozPbswRiKbrj4iGkhxICY3JyO5t6EXwjY0oalKEqVqcwJq95ErWDWOpSr2XndkJF8gqxcUqPjd5JN7jcfLgYWdpwSxrqGBPw4FiAeQZ2nY8T65qoa04dIZR3St0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780258188; c=relaxed/simple;
	bh=f1iyvM5oD0AD/aQm9yS1LeKBzyOycO7WanYFFv1detQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMbtyAcIRHDZkl/oOcPPFuHkh6TygZNWQFtbW9+eCtG5IqUE1Y84VLE1BiCNe1VtTIBZRZ5OtMDfNQiYi19250B3qdLFQLiiYW5EoPcxswvJC8F4ru5z7yA21mIQRT5tLY3Z9QSgny2qXTEyMJJc5lP4U5WpbrzQno9gN5UZeMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1sw/8v9H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f/JfZbc+A+tVnoRWSeTgCPsGaZWhhfOF8KGHoxY+trw=; b=1sw/8v9HTUeeU7C+FrPvjwOOF9
	r2PItOLz+n5L3UgmLeQA7Z3uBUrUW9JREmsu40cXMNop3anidE7ovCOn7iYm0PnwHKj1jv73rPef8
	tHU7koqk4P9dN4wkJYXOdOfxM0kTrvqgkVSuWlL8FOYyQytF+qDC5ea0otoAi3IBRf7g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTmTg-005Obj-3P; Sun, 31 May 2026 22:09:44 +0200
Date: Sun, 31 May 2026 22:09:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <4b5bc4b7-9921-42ac-bf87-a5009f561443@lunn.ch>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
 <20260525125437.4061-3-oscmaes92@gmail.com>
 <20260525084528.547fe263@kernel.org>
 <20260528142851-oscmaes92@gmail.com>
 <20260528080748.3e74355f@kernel.org>
 <20260528170510-oscmaes92@gmail.com>
 <20260528121210.40b0e493@kernel.org>
 <20260531165140-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531165140-oscmaes92@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293479-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 44FA2617DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 06:51:40PM +0200, Oscar Maes wrote:
> On Thu, May 28, 2026 at 12:12:10PM -0700, Jakub Kicinski wrote:
> > On Thu, 28 May 2026 19:05:10 +0200 Oscar Maes wrote:
> > > On Thu, May 28, 2026 at 08:07:48AM -0700, Jakub Kicinski wrote:
> > > > On Thu, 28 May 2026 16:28:51 +0200 Oscar Maes wrote:  
> > > > > On Mon, May 25, 2026 at 08:45:28AM -0700, Jakub Kicinski wrote:  
> > > > > Intel x86  
> > > > 
> > > > LOL. Please. Which _hardware_ platform.
> > > > Or to ask more directly - is it QEMU.  
> > > 
> > > It was indeed tested on QEMU.
> > > Either way, the performance measurements were just a sanity check.
> > > Changing the code to use the modern API is just better.
> > 
> > Please don't waste our time with optimizations to unused code.
> 
> It's not unused code. VMware emulates this device by default in some cases.
> I've encountered it when installing QubesOS in vmware which is based on
> relatively modern Linux.

There is a saying: If it is not broken, don't fix it.

"Changing the code to use the modern API is just better" if not a good
enough reason on its own. Using older APIs does not mean it is
broken. It does not need fixing. Some percentage of changes like this
break stuff.  We Reviewers/Maintainers need to look closely at such
changes and decide if it does actually break stuff. And we want to
know what the return on investment is? I would much rather spend my
time reviewing new drivers for hardware which currently does not have
a driver.

So, if you say something like: I'm using this driver daily for X. I've
spent some time optimising it, and with this change, my use case gets
a 10% increase in performance. Here are my numbers....

That gives us a better feeling that you have extensively tested this,
so it is less likely you have broken something. You can also show
there is a real improvement. So the change is actually worth while.

	Andrew






