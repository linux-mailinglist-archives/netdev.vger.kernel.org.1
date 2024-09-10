Return-Path: <netdev+bounces-126807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDC9972955
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86FA286538
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3A175568;
	Tue, 10 Sep 2024 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RB3/N3tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C921CD1F
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948838; cv=none; b=dT8TPp8z8A1cVcqFi+Qo6SeB0Vw5chbHDmriaUeeiOrA2iIwFlXvrcjerrYIj9xOX6QFg7z4Sjl6WEISv4YEZhol6yR1vNLsEZImhq+VtTDl1f3B9gGhiK2yvq9b2oyzaZzb55A4aVL2b62Lh8W57cagd8bhTmyLoJBMdF1lNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948838; c=relaxed/simple;
	bh=ZSKYFvREQ6G7ojYDniUR+vXtHepNfTW2jfP6yl9Qxq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUOjHFH1CYk86tJMOHQfX5wN7HY734YDhiwU9/srLRb2CqzTpH2wAVACyseev/R3AZ96YkfoyZMdklnoKVSYxQXUtCOzA76jDdi2lsx/wYys0v/TackeuwHt6FH1uYckYUdM9BJ/VJp7THDTMSj1ITt44vwO5iTIUiQpff+lQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RB3/N3tk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so6283274a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725948835; x=1726553635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOSfkKWiqdI3BWtcPK6He/p+XcWPyTmAhMgvF4mKHJs=;
        b=RB3/N3tkM8780eNrH0DBo1sdkPoMHYSQK6n9TdphxuWvrZSvf2Vy94kWhkYUHO1jBw
         1y2CO+zgerBCPqCrFYAXVwbxcxMQL1TnB+4aZ/QUKMlNYovp6j8csg3te0UcWAEoEP85
         1RviARVKWnEcmeXdsEl57pgnZF23q3CBRL2a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725948835; x=1726553635;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOSfkKWiqdI3BWtcPK6He/p+XcWPyTmAhMgvF4mKHJs=;
        b=lWV9orMX2NqPkyFIcaNk1TdEMBs7ZzmPJqd6doY10Aq0HDjCfvPTS8B/JSwn8KaAP0
         K2C2XFMx4ZWdz8AEbv1JaR2aJuWQ36E2bZ54+TTpqrVlhxfwNEAO6RpVi81vSauLk3cs
         vK2UFkByw/nJ5Gs9iJ83G+LMEa7GHxd66r0Z6x2Jj6c+x5gE0PrN37+8qjhOHN0OHkkt
         A09FhknLRAF+HL1BC+Z0aYM9P7hK8lUcfipT407/gutOqqebTpQeal4VvtFF+dHWAtta
         p03jIlbAt/aCTL1KFLMo4rKp/LaWHzn3fajIYnh7L0+7ktJrzAySAINlRI6l6WvH4dNx
         nt1Q==
X-Gm-Message-State: AOJu0YzZcCJBelq2b2qB2/scB2aRxa0/Mn/Dgz3Nh7hylKyI1T9DDUtU
	YvJB57+HJyBCrb+0n7f15SoWgHIjfUgz6eap50UK7yAK0NjAESD13pEQOjRiVR7xNGGMo7p63zz
	dhS4=
X-Google-Smtp-Source: AGHT+IEr+VRs334AZ3Iv8vggty1pVNOhhQUDeIaT1NlT8PjIYTlORJ/kJNdgCibNtSImpIhUkfVzYA==
X-Received: by 2002:a05:6402:2787:b0:5c0:ad76:f6d5 with SMTP id 4fb4d7f45d1cf-5c3dc7804ddmr8780737a12.5.1725948833811;
        Mon, 09 Sep 2024 23:13:53 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8ce50sm3825553a12.84.2024.09.09.23.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:13:53 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:13:51 +0200
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
Message-ID: <Zt_jn5RQAndpKjoE@LQ3V64L9R2.homenet.telecomitalia.it>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909164039.501dd626@kernel.org>

On Mon, Sep 09, 2024 at 04:40:39PM -0700, Jakub Kicinski wrote:
> On Sun,  8 Sep 2024 16:06:35 +0000 Joe Damato wrote:
> > Add a persistent NAPI storage area for NAPI configuration to the core.
> > Drivers opt-in to setting the storage for a NAPI by passing an index
> > when calling netif_napi_add_storage.
> > 
> > napi_storage is allocated in alloc_netdev_mqs, freed in free_netdev
> > (after the NAPIs are deleted), and set to 0 when napi_enable is called.
> 
> >  enum {
> > @@ -2009,6 +2019,9 @@ enum netdev_reg_state {
> >   *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
> >   *		   where the clock is recovered.
> >   *
> > + *	@napi_storage: An array of napi_storage structures containing per-NAPI
> > + *		       settings.
> 
> FWIW you can use inline kdoc, with the size of the struct it's easier
> to find it. Also this doesn't need to be accessed from fastpath so you
> can move it down.

OK. I figured since it was being deref'd in napi_complete_done
(where we previously read napi_defer_hard_irqs and
gro_flush_timeout) it needed to be in the fast path.

I'll move it down for the next RFC.

> > +/**
> > + * netif_napi_add_storage - initialize a NAPI context and set storage area
> > + * @dev: network device
> > + * @napi: NAPI context
> > + * @poll: polling function
> > + * @weight: the poll weight of this NAPI
> > + * @index: the NAPI index
> > + */
> > +static inline void
> > +netif_napi_add_storage(struct net_device *dev, struct napi_struct *napi,
> > +		       int (*poll)(struct napi_struct *, int), int weight,
> > +		       int index)
> > +{
> > +	napi->index = index;
> > +	napi->napi_storage = &dev->napi_storage[index];
> > +	netif_napi_add_weight(dev, napi, poll, weight);
> 
> You can drop the weight param, just pass NAPI_POLL_WEIGHT.

OK will do.

> Then -- change netif_napi_add_weight() to prevent if from
> calling napi_hash_add() if it has index >= 0

OK.

> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 22c3f14d9287..ca90e8cab121 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6719,6 +6719,9 @@ void napi_enable(struct napi_struct *n)
> >  		if (n->dev->threaded && n->thread)
> >  			new |= NAPIF_STATE_THREADED;
> >  	} while (!try_cmpxchg(&n->state, &val, new));
> > +
> > +	if (n->napi_storage)
> > +		memset(n->napi_storage, 0, sizeof(*n->napi_storage));

OK, your comments below will probably make more sense to me after I
try implementing it, but I'll definitely have some questions.

> And here inherit the settings and the NAPI ID from storage, then call
> napi_hash_add(). napi_hash_add() will need a minor diff to use the
> existing ID if already assigned.

I don't think I realized we settled on the NAPI ID being persistent.
I'm not opposed to that, I just think I missed that part in the
previous conversation.

I'll give it a shot and see what the next RFC looks like.

> And the inverse of that has to happen in napi_disable() (unhash, save
> settings to storage), and __netif_napi_del() (don't unhash if it has
> index).
> 
> I think that should work?

Only one way to find out ;)

Separately: your comment about documenting rings to NAPIs... I am
not following that bit.

Is that a thing you meant should be documented for driver writers to
follow to reduce churn ?

