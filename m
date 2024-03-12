Return-Path: <netdev+bounces-79536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC70F879D88
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1A71C20F86
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1FB143737;
	Tue, 12 Mar 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="hcsknrZP"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938D143733
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279302; cv=none; b=Ev9fNsUargS3up62WGmiyPBeoM41AcL6CW8y3NKBNMp7vd3SNHejm1psUl23a4rHo/W7mP5QfVUdmwDTIERttPVjDlT0B5q3nZFsXb2orM0/r9tWXVl6YiaGSHaF7UayQ6dLpS/i3gBVXFJbsR5lv1O85/Gulsg83LnAFHRa6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279302; c=relaxed/simple;
	bh=O5Xdh11NPiLII661A1yUwjIQCPL9DVeG8jST4oezlGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0/UjI5hggDEBKi3oSUDxMfTCRtbXNa1xPsUXISmw6pYEnld5n4N+J5indS4rh+0kpVVro0+ZYgjEl3ZxTX7sNnR9jTMmlA/ovTuTRmGTBDn3IsuBUJGQQh2YhDMQN8FNggQoLaap/0O0gOw5wI4c0HClcOxdoCxZnyftkzyakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=hcsknrZP; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 0596C6023D;
	Tue, 12 Mar 2024 22:34:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710279290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlSkheADaLDcsz6/Z7dUa1gCytkS4OjR6tZU4w7KpqU=;
	b=hcsknrZP4RK4Q6APAQeVVt6ZDNLIsxgrWk7nard+g8I5MXVrpLG2fxwTGKZSnN3Mbz82CU
	zaQ+fSO6xnwnlNBd7VdnOFDtG4cvmDBcdoJEw9odWx+8HT3wraikH3tKS+gBa/u9pev4SQ
	e08fLoSZSTufnKpNuHO0WJcnxlOkXe7TOCTityyc0IGu+cVneBgz0F2ypeUKb4jWIPRR/9
	Qwv7jUnyQU3oUaZfpyI2TgPyGuSvOlrBDZxaRgjfOuCcP4hKvauJ7YUkxD3Lyh68QI7GHS
	Eg1l9Qpj9F7j0btq7yXgYqC0SFAq3Qn4SBoAAhIvO3pRKExYh72kxCWNLpAseg==
Date: Tue, 12 Mar 2024 22:34:59 +0100
From: Max Gautier <mg@max.gautier.name>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create
 /var/lib/arpd
Message-ID: <ZfDKg3uKqy3T7BW5@framework>
References: <20240311165803.62431-1-mg@max.gautier.name>
 <20240311124003.583053a6@hermes.local>
 <Ze-Fj2RwYnM0WgWi@framework>
 <20240311183007.4a119eeb@hermes.local>
 <ZfAQvGTYe7eBcY3e@framework>
 <20240312142420.53e35ab4@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312142420.53e35ab4@hermes.local>

On Tue, Mar 12, 2024 at 02:24:20PM -0700, Stephen Hemminger wrote:
> On Tue, 12 Mar 2024 09:22:20 +0100
> Max Gautier <mg@max.gautier.name> wrote:
> 
> > On Mon, Mar 11, 2024 at 06:30:07PM -0700, Stephen Hemminger wrote:
> > > On Mon, 11 Mar 2024 23:28:31 +0100
> > > Max Gautier <mg@max.gautier.name> wrote:
> > >   
> > > > On Mon, Mar 11, 2024 at 12:40:03PM -0700, Stephen Hemminger wrote:  
> > > > > On Mon, 11 Mar 2024 17:57:27 +0100
> > > > > Max Gautier <mg@max.gautier.name> wrote:
> > > > >     
> > > > > > Only apply on systemd systems (detected in the configure script).
> > > > > > The motivation is to build distributions packages without /var to go
> > > > > > towards stateless systems, see link below (TL;DR: provisionning anything
> > > > > > outside of /usr on boot).
> > > > > > 
> > > > > > The feature flag can be overridden on make invocation:
> > > > > > `make USE_TMPFILES_D=n DESTDIR=<install_loc> install`
> > > > > > 
> > > > > > Links: https://0pointer.net/blog/projects/stateless.html    
> > > > > 
> > > > > Why does arpd need such hand holding, it is rarely used, maybe should just not be built.    
> > > > 
> > > > The commit introducing the install of that directory is quite old  
> > > 
> > > The problem is that build environment != runtime environment for embedded systems.  
> > 
> > That's the same for anything detected by the configure script, right ?
> > Hence the override capability.
> 
> Configure is mostly about what packages are missing from the build.
> It would be better if arpd was just smarter about where to put its
> file.

What do you mean by smarter ? Trying to found an existing directory
rather than a fixed one ?

> 
> > 
> > > But arpd really is legacy/dead/rotting code at this point.  
> > 
> > Yeah I can see that, not touched since 2016 (mostly). You would rather
> > just drop it ?
> > 
> 

-- 
Max Gautier

