Return-Path: <netdev+bounces-77415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07734871BD6
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EB31C22291
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F866026D;
	Tue,  5 Mar 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1MLrRmB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3BEeCua"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368855C19
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634340; cv=none; b=eivdy9eJu9hgGu8zN16XiXgMb3iRBRWpKWe/Jj2I7w4F6W4x0LWgmWujQeOBTTU6bpw5j8Yh8DhSsi0pomw77vfgzhGaxjveqJCA4U/gyRm7wiA0zjrTt/CtZWkXxVMoPRbu6/eCdIhxUKNoUxPFby1ysbVrrXWUGBkllNYrBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634340; c=relaxed/simple;
	bh=FBZoA8HT41rrelgYnH47F5Fcbqc4gNO9/ROnWyurk2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqVN9C6OlFAqYdcHVqMSik9kGu7yFrnHVpv6Ro+jfYP/BUTLpP8IBIH+4HaO2MAaKR4Y3EeXER+QV9KaSp0nV3kfucHvedQQ9pUslBFvUjXjQqdXqM8FajOscSObvxsIu1ODNs4n88A/gabH2RBkPY8rBwdXfij9Vp3Kbe6VZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1MLrRmB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3BEeCua; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 5 Mar 2024 11:25:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709634337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lRByV/83WJQ2CHNvx77tbl9d/au9m4pfpaa9GSCYX4=;
	b=I1MLrRmB4Y9y32zEFGxTNfUtEUii3hj3BWW6JqhgR96cq0VRMKj8NvptCutzukyb4hyfVi
	gKVGULHxBbuulSubKcLjl5rWIEAFV2PUZjwps1hlMSrR2+/xrDY4BzGuZsM1WCsN+l4a7t
	WqWTWuqgbCOrT3z2imlp8XZpHE3LDlvA+z5PKXK5Py4tBqXchyKQPiAjt6ZKzRDBeYUcc1
	H/ploNUYQbn79UAxqErCNdW0cyEIyQYcXQR8Oo3F6cPq+S/ntskjDLTqWTdpr14rzg6GX4
	eNLFGn8Pz0cpo93DJvWC4m738gRt81wjNmIkAhB2hW1Le17gJGIIcZw/B+emnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709634337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lRByV/83WJQ2CHNvx77tbl9d/au9m4pfpaa9GSCYX4=;
	b=H3BEeCuavoAZL2iFd8Ae01Wgd8EJINhaX0L3FPiwicsyTac5p8ItwO9iGCH54ix6gjiy2I
	KB916mk/bI8zlDCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v3 net-next 3/4] net: Use backlog-NAPI to clean up the
 defer_list.
Message-ID: <20240305102535.Mw-yj_ra@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
 <20240228121000.526645-4-bigeasy@linutronix.de>
 <8f351363c3beaf84a3cb54643b02b0981b9e782c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f351363c3beaf84a3cb54643b02b0981b9e782c.camel@redhat.com>

On 2024-03-05 10:55:45 [+0100], Paolo Abeni wrote:
> On Wed, 2024-02-28 at 13:05 +0100, Sebastian Andrzej Siewior wrote:
> > @@ -4736,6 +4736,26 @@ static void napi_schedule_rps(struct softnet_data *sd)
> >  	__napi_schedule_irqoff(&mysd->backlog);
> >  }
> >  
> > +void kick_defer_list_purge(unsigned int cpu)
> > +{
> 
> Minor nit: I guess passing directly 'sd' as an argument here would be
> better, but that could be a follow-up.

I need the CPU number in the "non-backlog threaded" case for
smp_call_function_single_async(cpu, ). sd->cpu has the CPU stored but
only in the CONFIG_RPS case. In the theoretical case +SMP -SYSFS we
wouldn't have RPS but would need this CPU member.

> Cheers,
> 
> Paolo

Sebastian

