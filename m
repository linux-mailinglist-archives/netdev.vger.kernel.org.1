Return-Path: <netdev+bounces-127020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2822A973A97
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DCD1F233C1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D6B195B1A;
	Tue, 10 Sep 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3PpaTFV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E91957F9;
	Tue, 10 Sep 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979939; cv=none; b=dIpLN7Mjw60phuzy9U1gI25sL800arNru7h2IAqgTIUC8wIz9DbVQC6eHckDWLJGFG2ig1EDziiF7iRgXHH1hONujhDAa9/fqFoAznr7yIhbSdX1udr27g8++SQo1a4A8LTz9LoxeouAEeFSoT0mkVv+rkqX/6GfbPXFs4y4oGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979939; c=relaxed/simple;
	bh=pQ/DJDwBz9sdXFZh80HIa5hsy6UQVemtDbUkxYwlaH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoMcrfwK0PYmST0Jtl3ci+mxwqOnJoFy0cmCqzyBMQMh04DjyGBlgGQ7pLS4VE82M2uZ4/z7G/rAZ987QK5zoTnZZhEWv0KhH1YS0IbOKkNZn+owwM7pO8BAFjEehZwjwLnGsZATTj4SPcX43QrYm2Un8F5bVOaK+pgJrxXJtIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3PpaTFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D8BC4CEC3;
	Tue, 10 Sep 2024 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979939;
	bh=pQ/DJDwBz9sdXFZh80HIa5hsy6UQVemtDbUkxYwlaH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M3PpaTFV9AsjrZRN4Jn2waUapazBBG/P6RB6wJuEXjfB+lWE4QnpSH+ECaiy25w5+
	 VaYq/QNr9p4AQkLlM5wpyyg7eQd8ePnglSPS3bvdK4ovqWHiXNdrpG9bhfLKmBQZrs
	 1j4vKxzRV3RnxfHnWhmyZJDv/dtl2xdsdZewhrcTzteTEqhW1dCrswmChMv4jgcP1+
	 LS+MDLyM5Mn5C3gqXgOO35CR/egq+aZ7i/ERcFd7p7FRRg+p0diWPV4L1m0doia7SW
	 QLuE+++69xsJRYB5dI6CDV/hsmjlqUTBfzrxo8xEp0iZ4V40OjnVWLjIcgzPLEglly
	 kJp2Zr7T8evZw==
Date: Tue, 10 Sep 2024 07:52:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 1/9] net: napi: Add napi_storage
Message-ID: <20240910075217.45f66523@kernel.org>
In-Reply-To: <Zt_jn5RQAndpKjoE@LQ3V64L9R2.homenet.telecomitalia.it>
References: <20240908160702.56618-1-jdamato@fastly.com>
	<20240908160702.56618-2-jdamato@fastly.com>
	<20240909164039.501dd626@kernel.org>
	<Zt_jn5RQAndpKjoE@LQ3V64L9R2.homenet.telecomitalia.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 08:13:51 +0200 Joe Damato wrote:
> On Mon, Sep 09, 2024 at 04:40:39PM -0700, Jakub Kicinski wrote:
> > On Sun,  8 Sep 2024 16:06:35 +0000 Joe Damato wrote:  
> > > Add a persistent NAPI storage area for NAPI configuration to the core.
> > > Drivers opt-in to setting the storage for a NAPI by passing an index
> > > when calling netif_napi_add_storage.
> > > 
> > > napi_storage is allocated in alloc_netdev_mqs, freed in free_netdev
> > > (after the NAPIs are deleted), and set to 0 when napi_enable is called.  
> >   
> > >  enum {
> > > @@ -2009,6 +2019,9 @@ enum netdev_reg_state {
> > >   *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
> > >   *		   where the clock is recovered.
> > >   *
> > > + *	@napi_storage: An array of napi_storage structures containing per-NAPI
> > > + *		       settings.  
> > 
> > FWIW you can use inline kdoc, with the size of the struct it's easier
> > to find it. Also this doesn't need to be accessed from fastpath so you
> > can move it down.  
> 
> OK. I figured since it was being deref'd in napi_complete_done
> (where we previously read napi_defer_hard_irqs and
> gro_flush_timeout) it needed to be in the fast path.
> 
> I'll move it down for the next RFC.

Hm, fair point. In my mind I expected we still add the fast path fields
to NAPI instances. And the storage would only be there to stash that
information for the period of time when real NAPI instances are not
present (napi_disable() -> napi_enable() cycles).

But looking at napi_struct, all the cachelines seem full, anyway, so we
can as well split the info. No strong preference, feel free to keep as
is, then. But maybe rename from napi_storage to napi_config or such?

> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 22c3f14d9287..ca90e8cab121 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6719,6 +6719,9 @@ void napi_enable(struct napi_struct *n)
> > >  		if (n->dev->threaded && n->thread)
> > >  			new |= NAPIF_STATE_THREADED;
> > >  	} while (!try_cmpxchg(&n->state, &val, new));
> > > +
> > > +	if (n->napi_storage)
> > > +		memset(n->napi_storage, 0, sizeof(*n->napi_storage));  
> 
> OK, your comments below will probably make more sense to me after I
> try implementing it, but I'll definitely have some questions.
> 
> > And here inherit the settings and the NAPI ID from storage, then call
> > napi_hash_add(). napi_hash_add() will need a minor diff to use the
> > existing ID if already assigned.  
> 
> I don't think I realized we settled on the NAPI ID being persistent.
> I'm not opposed to that, I just think I missed that part in the
> previous conversation.
> 
> I'll give it a shot and see what the next RFC looks like.

The main reason to try to make NAPI ID persistent from the start is that
if it works we don't have to add index to the uAPI. I don't feel
strongly about it, if you or anyone else has arguments against / why
it won't work.

> > And the inverse of that has to happen in napi_disable() (unhash, save
> > settings to storage), and __netif_napi_del() (don't unhash if it has
> > index).
> > 
> > I think that should work?  
> 
> Only one way to find out ;)
> 
> Separately: your comment about documenting rings to NAPIs... I am
> not following that bit.
> 
> Is that a thing you meant should be documented for driver writers to
> follow to reduce churn ?

Which comment?

