Return-Path: <netdev+bounces-128034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 271619778EC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 08:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA021F25B4D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223C1AE845;
	Fri, 13 Sep 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vCDkAfrI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDhwroHh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89823187350
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209815; cv=none; b=M0MX3UjiG5y9VYgpdLPMByvbDMRMJxlXU4Owa7GloGUd0tRx/NocXF5Y/9Rc1VqzThHYvR2jvQyBjfHLjWsaRe7IlXcVfEa8IyPpvOP3bK/4D2mcJ951tUv6KPVQwpt/QXREn4tVTVmvV+XgeaZHIw9QKZ/AZLnWwAD7YxGtXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209815; c=relaxed/simple;
	bh=y6hW1vrT9FtOAKWc8Jz+bIO/EqXmI7YAkVMeM9GpL7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgXmbKwJnRjYSom9JVLwHHo3CFp+ELDB/CNAn10PV2nZUdsu4vneG3DIsgbGMrgqvONKwBR4U/uNR/Zej6qUbuZ2VZL3OZVaPLSNZsxvV84IQRWVmTUTMcZ/HC9gxuTm/DIWqXxN+yyrTUr8PkA51dpa94xDvCxOnLrCWSTp9J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vCDkAfrI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDhwroHh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Sep 2024 08:43:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726209811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UxZITJkju7g+vfn5+J5VmDDlJupxwHYMvgYZjSUhSPc=;
	b=vCDkAfrIqVgYBGCCNkZFwF/rwWKnkmeOb6ixCl1rXyKohiiGqGyjvnS3cASjJOn7iJrHjz
	p5qsNdT8SWOfXHIMFWMwWp0ehJsvWEpW7aNLsCcvNsdKCmU3hKYC/zExWmWJZTe76YHWr/
	twFbLZ91/hyp3VajW5RwbD17i1fymhnXQkfDXWtKdL6RauwbYwLH0yFF+a3+xax0tje8+C
	r+uoZT+/F1EhWFKCsdcIgrwc9GZ59xV7IgYnzimiKitQLguprynJ149bAZhW7XAO6lh5Qj
	kayRexzIcTWPcNp92YrIbpMOqENvwqF5b6bqXq+Hf//JsoakhQCWnwif/eIfLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726209811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UxZITJkju7g+vfn5+J5VmDDlJupxwHYMvgYZjSUhSPc=;
	b=FDhwroHhMxGSA7nxbSMIHUwkjI2BvQwPyi+iIXOz7msQWPTGdOBkZyo0XblLvycD6t6k5T
	VTumKWh1DF/F/EBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net 0/2] net: hsr: Use the seqnr lock for frames received
 via interlink port.
Message-ID: <20240913064329.mRHNdBGa@linutronix.de>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
 <20240911155324.79802853@kernel.org>
 <20240912065155.AyiTp0bn@linutronix.de>
 <20240912171413.4a81ab12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912171413.4a81ab12@kernel.org>

On 2024-09-12 17:14:13 [-0700], Jakub Kicinski wrote:
> On Thu, 12 Sep 2024 08:51:55 +0200 Sebastian Andrzej Siewior wrote:
> > > The fix doesn't look super urgent and with a repost it won't have
> > > time to get into tomorrow's PR with fixes. So I just pushed them
> > > both into net-next.  
> > 
> > I just noticed that you applied
> 
> Yeah, the plural "you", but still my bad for not putting two
> and two together :S

Oh I'm sorry, I didn't pay attention ;)

> >    b3c9e65eb2272 ("net: hsr: remove seqnr_lock")
> > 
> > to net. Patch 1/2 should replace that one and clashes with this one now.
> > I tried to explain that removing the lock and making it atomic can break
> > things again.
> > Should I send a revert of b3c9e65eb2272 to net?
> 
> I have a potentially very stupid plan to squash the revert into 
> the cross merge..

Whatever works best for you. I will probably send the revert+patch to
Greg for stable once he asks for it.

Sebastian

