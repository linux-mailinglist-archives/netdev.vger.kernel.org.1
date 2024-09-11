Return-Path: <netdev+bounces-127244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D105974BD5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF8A1F240D1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470313D529;
	Wed, 11 Sep 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LBazfXtA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C513B5B7
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041104; cv=none; b=UbM/Ehu004hgYaE8pdZ3jIKbq8rdDOLXzd/grmSJd+Wfe5+gUi7uk49KH5mOxuNsAOLqS34WA/WaaLURwugqZjOEZCVamxJAS+9wEceI/G4S1EWaOWb5V7IzCX27ObDDJ0jKFbCKVB/dG9HvTUZiKXLnsb98Za5w5mVfCT+DGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041104; c=relaxed/simple;
	bh=NKir++yKg6qIFt5diuBLaxpcrvVxtXH7i+aodtCpXo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhOWK4eivInRX1FE63tYcY6SG8HO7l0TDjOl4j9Al4yqSE/z/nPBQomfIZ1QxGQIdR7LSE7pkgQ9W20dLW59mtRfCTdIm3YzpFtltn5ZbWvoRmmlMRlI9qWmxYVlER6hKJ+hQAl1hIH5va9VFhGZnFFNrSn/MaX/loG4FEZgiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LBazfXtA; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a8d3cde1103so553844466b.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726041101; x=1726645901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqhOEnN7I1NfnKs5yoj/51R0usVuimIfU3tAa/E8LUE=;
        b=LBazfXtAk6QnKbefeuXr1ONUvktLdgW+HEExtCgob22xaO2TaRt42YRzgN+MSYjhps
         Wng8VugBo7S8sohwOCO9IJzhLjVnvDwE0/X6rJlVXvGy0KiSVdDZG0RvbVj0n4kX52xA
         fSfkIKuiY+S/Cg7nhBxQLYOGgZ1VPT3lE7wac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041101; x=1726645901;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqhOEnN7I1NfnKs5yoj/51R0usVuimIfU3tAa/E8LUE=;
        b=H3BKtCTynEdTtrLu6QHVVkl5EMNFseJfsXLieVP9KsiG0MQi6AudrENqDenixLCutD
         62elQGw6RngoXJPQ4zn2p7S6vVattLLhVRAAYFpJfSt6pxWL23cObWXqTNg61GLtezRW
         IMmleKYBhOy0M+bjjqXMJPYs1XhDjWBVkaK/giefRDmS5XW3fzPq034fGqifTzEW8iZE
         u5Z+RWPSYD2Zp3hVzGq5+ZMos0nb2qmA+vzlsWPHXBGFYSVh02q9yAjg1aY4L/oXUfkh
         npQvRwhyI7K1lzKqUbdqPiE/KkZqYmKsAAHc/0eFXPO2RZdHFc5dHj1JvC+aad1j1iwS
         hhVQ==
X-Gm-Message-State: AOJu0YzxsyH31GhK1nOZvnmZVt7UnjZmUwcrzgS1Zx9SZ/Do6Tah/+W7
	nq7ni55EFOjFN8qv2YHjDaJUULuqnJGVH1+h+7Aqu8eorPgFpkrqIE7mVjbhDCc=
X-Google-Smtp-Source: AGHT+IHfl4wUSekHQff7+1uJioix71uW7NP/VwOhy8UsjvFLMD59myAjxRkXduY2WsfEVdSUA5M/Sw==
X-Received: by 2002:a17:906:7310:b0:a86:c372:14c3 with SMTP id a640c23a62f3a-a8ffadf0438mr308127066b.48.1726041100563;
        Wed, 11 Sep 2024 00:51:40 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d556e8sm580483466b.204.2024.09.11.00.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:51:40 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:38 +0200
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
Message-ID: <ZuFMClzrGwDDFm01@LQ3V64L9R2.homenet.telecomitalia.it>
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
> 
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
> 
> Then -- change netif_napi_add_weight() to prevent if from
> calling napi_hash_add() if it has index >= 0
> 
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
> 
> And here inherit the settings and the NAPI ID from storage, then call
> napi_hash_add(). napi_hash_add() will need a minor diff to use the
> existing ID if already assigned.
> 
> And the inverse of that has to happen in napi_disable() (unhash, save
> settings to storage), and __netif_napi_del() (don't unhash if it has
> index).
> 
> I think that should work?

I made the changes you suggested above yesterday and I had also
renamed the struct to napi_config because I also liked that better
than storage.

I'll update the code to put the values in the napi_struct and copy
them over as you suggested in your other message.

That said: the copying thing is more of an optimization, so the
changes I have should be almost (?) working and adding that copying
of the values into the napi_struct should only be a performance
thing and not a functionality/correctness thing.

I say that because there's still a bug I'm trying to work out with
mlx5 and it's almost certainly in the codepath Stanislav pointed out
in his messages [1] [2]. Haven't had much time to debug it just yet,
but I am hoping to be able to debug it and submit another RFC before
the end of this week.

FWIW: I too have fallen down this code path in mlx5 in the past for
other reasons. It appears it is time to fall down it again.

[1]: https://lore.kernel.org/netdev/Ztjv-dgNFwFBnXwd@mini-arch/
[2]: https://lore.kernel.org/netdev/Zt94tXG_lzGLWo1w@mini-arch/

