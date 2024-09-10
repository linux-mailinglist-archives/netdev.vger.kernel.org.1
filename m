Return-Path: <netdev+bounces-127045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29E973D04
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A399B2119C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A11A0706;
	Tue, 10 Sep 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="n/WKfeNT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38B19F480
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984649; cv=none; b=H0Fr8ZBcb+JkCNmWI+u2ZxbYQHSaYQK4Be2FjtLVzwgZkdWKNerfp77SslRpXHizVnoYYfSSjgm4dOjny5s+PTbHSw1knmZacfwUYSWc6ftD8ojMuIiPR7dNe0YJsz3tKvEc3Euctylm/AUKFKpcc984ptjQoveV0n0hPK2Nhok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984649; c=relaxed/simple;
	bh=dM7gA/+oguMRgO7/v/MyBYt9f4M0YaqbnGL6itt+HT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAWIndTBd4EZuHEXWoz6rW27kDtkMEayWjlR1XFUcFt2X4Ac7Ssf+ar2HwCGe7pOqbVz0rUyJ/ethPen1myDtzPaPGt+X9Xy+xH+X1hJTki7iqJ/vtTnDMbreJzuLfJC2A9CU5EGF3jAxYoW7q02Ys/kexVb+OKKMk6xGW/35mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=n/WKfeNT; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a7aa086b077so534448166b.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725984645; x=1726589445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf3Iv71aicYhG3oQ3jGMgzEb4cVqdz7BdZNP84b6Zno=;
        b=n/WKfeNTT++E/n1PTRPvOQWZpW6xNIZkZA619v9SSuSZdfQkma3auvIWZjLubsvG/K
         HXEusac6c3xoeuIO6Ht7SYVCt+qE5exWPlRbt4eqQatxG3fuKvvWu9YQkCSQl//MXlPr
         i7A6ynNHWWT4jn2KrgWktf9TId+LauSTdR0hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984645; x=1726589445;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf3Iv71aicYhG3oQ3jGMgzEb4cVqdz7BdZNP84b6Zno=;
        b=BA1lktN2xTzyN/Ns6QbIWFD/w5WQZxI7TQe8R6GabOhnKjOiTNd2r9a+JRifStNo3f
         x4jB3Kg8sI+tdFSNuqreaSPF2gjDI2OiM0S8nhe2U+gP/FrNsU2ykv+XbmwIfxOcQzo6
         YYNU0IIb+6KbeoDURZ/3kxZJCwG7GEAloeGxDEBvYnGwYiz+8VMih76ACvolItBaNJza
         Q2CW+8YLQyBek0lWghmmWGhq7pDhac+7MIA1VvOqeFsL13Ofotoe1sZPfdfcYVe/RhYB
         0k9eFPS3sk1LMT0HV4Lwr1CPP9BKdIEIy0JRFjs24jgQwSBnkpuwbOPwsA6aZF5nQoiz
         9Ztg==
X-Gm-Message-State: AOJu0YzxmoclH97SnWbMjcdkE2ZwSE+T3Oph4/CtOAVcgcZW4XF70O31
	Lz3NUHo3qi6KPjAMCQizNuu95W7XCnXLluY7F3PU2IgiOtC6uxyTGe5hkaJh0ow=
X-Google-Smtp-Source: AGHT+IHxHjK63CxiZHrWwLws1xG9AiEiJEPfI1UgHEKNCqePjWh3JnXOx+0CXs1Uw1lTzvZ/w4BzBg==
X-Received: by 2002:a17:907:6088:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a8ffaa97ad0mr156569566b.5.1725984644883;
        Tue, 10 Sep 2024 09:10:44 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d66d7csm493714666b.224.2024.09.10.09.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:10:44 -0700 (PDT)
Date: Tue, 10 Sep 2024 18:10:42 +0200
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 1/9] net: napi: Add napi_storage
Message-ID: <ZuBvgpW_iRDjICTH@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240908160702.56618-1-jdamato@fastly.com>
 <20240908160702.56618-2-jdamato@fastly.com>
 <20240909164039.501dd626@kernel.org>
 <Zt_jn5RQAndpKjoE@LQ3V64L9R2.homenet.telecomitalia.it>
 <20240910075217.45f66523@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910075217.45f66523@kernel.org>

On Tue, Sep 10, 2024 at 07:52:17AM -0700, Jakub Kicinski wrote:
> On Tue, 10 Sep 2024 08:13:51 +0200 Joe Damato wrote:
> > On Mon, Sep 09, 2024 at 04:40:39PM -0700, Jakub Kicinski wrote:
> > > On Sun,  8 Sep 2024 16:06:35 +0000 Joe Damato wrote:  
> > > > Add a persistent NAPI storage area for NAPI configuration to the core.
> > > > Drivers opt-in to setting the storage for a NAPI by passing an index
> > > > when calling netif_napi_add_storage.
> > > > 
> > > > napi_storage is allocated in alloc_netdev_mqs, freed in free_netdev
> > > > (after the NAPIs are deleted), and set to 0 when napi_enable is called.  
> > >   
> > > >  enum {
> > > > @@ -2009,6 +2019,9 @@ enum netdev_reg_state {
> > > >   *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
> > > >   *		   where the clock is recovered.
> > > >   *
> > > > + *	@napi_storage: An array of napi_storage structures containing per-NAPI
> > > > + *		       settings.  
> > > 
> > > FWIW you can use inline kdoc, with the size of the struct it's easier
> > > to find it. Also this doesn't need to be accessed from fastpath so you
> > > can move it down.  
> > 
> > OK. I figured since it was being deref'd in napi_complete_done
> > (where we previously read napi_defer_hard_irqs and
> > gro_flush_timeout) it needed to be in the fast path.
> > 
> > I'll move it down for the next RFC.
> 
> Hm, fair point. In my mind I expected we still add the fast path fields
> to NAPI instances. And the storage would only be there to stash that
> information for the period of time when real NAPI instances are not
> present (napi_disable() -> napi_enable() cycles).

I see, I hadn't understood that part. It sounds like you were
thinking we'd stash the values in between whereas I thought we were
reading from the struct directly (hence the implementation of the
static inline wrappers).

I don't really have a preference one way or the other.

> But looking at napi_struct, all the cachelines seem full, anyway, so we
> can as well split the info. No strong preference, feel free to keep as
> is, then. But maybe rename from napi_storage to napi_config or such?

I can give that a shot for the next RFC and see how it looks. We can
always duplicate the fields in napi_struct and napi_config and copy
them over as you suggested above.

> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 22c3f14d9287..ca90e8cab121 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -6719,6 +6719,9 @@ void napi_enable(struct napi_struct *n)
> > > >  		if (n->dev->threaded && n->thread)
> > > >  			new |= NAPIF_STATE_THREADED;
> > > >  	} while (!try_cmpxchg(&n->state, &val, new));
> > > > +
> > > > +	if (n->napi_storage)
> > > > +		memset(n->napi_storage, 0, sizeof(*n->napi_storage));  
> > 
> > OK, your comments below will probably make more sense to me after I
> > try implementing it, but I'll definitely have some questions.
> > 
> > > And here inherit the settings and the NAPI ID from storage, then call
> > > napi_hash_add(). napi_hash_add() will need a minor diff to use the
> > > existing ID if already assigned.  
> > 
> > I don't think I realized we settled on the NAPI ID being persistent.
> > I'm not opposed to that, I just think I missed that part in the
> > previous conversation.
> > 
> > I'll give it a shot and see what the next RFC looks like.
> 
> The main reason to try to make NAPI ID persistent from the start is that
> if it works we don't have to add index to the uAPI. I don't feel
> strongly about it, if you or anyone else has arguments against / why
> it won't work.

Yea, I think not exposing the index in the uAPI is probably a good
idea? Making the NAPI IDs persistent let's us avoid that so I can
give that a shot because it's easier from the user app perspective,
IMO.

> > > And the inverse of that has to happen in napi_disable() (unhash, save
> > > settings to storage), and __netif_napi_del() (don't unhash if it has
> > > index).
> > > 
> > > I think that should work?  
> > 
> > Only one way to find out ;)
> > 
> > Separately: your comment about documenting rings to NAPIs... I am
> > not following that bit.
> > 
> > Is that a thing you meant should be documented for driver writers to
> > follow to reduce churn ?
> 
> Which comment?

In this message:

https://lore.kernel.org/netdev/20240903124008.4793c087@kernel.org/

You mentioned this, which I interpreted as a thing that core needs
to solve for, but perhaps this intended as advice for drivers?

  Maybe it's enough to document how rings are distributed to NAPIs?
  
  First set of NAPIs should get allocated to the combined channels,
  then for remaining rx- and tx-only NAPIs they should be interleaved
  starting with rx?
  
  Example, asymmetric config: combined + some extra tx:
  
      combined        tx
   [0..#combined-1] [#combined..#combined+#tx-1]
  
  Split rx / tx - interleave:
  
   [0 rx0] [1 tx0] [2 rx1] [3 tx1] [4 rx2] [5 tx2] ...
  
  This would limit the churn when changing channel counts.

