Return-Path: <netdev+bounces-123621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74332965C7E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE492898A1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013BA171E65;
	Fri, 30 Aug 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MYe3iDKv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F391170A1A
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009288; cv=none; b=Rrv2H9i7WBsUo3Un0zX+Ct8A15sqOD49HWJuIgriaEcR6F951Zk6Ei+0mGDLX6AShHeYuyUt12inheziRAkS1MTj8bd8IyWSuaYeW5rxyoQCmuwUnwDngUg6OlHzqXCSFTsOtV7Fx+H0GI7o2VMNx7Aa0Lp17FlOVV9MBqZoeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009288; c=relaxed/simple;
	bh=Be/ZXGgJhznFStfm5kc4CEbbjD/yQhPDJ4xEYxcPO5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sull2bDjMxeDCm8EYTv2j3gTqR5R1bp0HbJpZf3qy+OLNNacpJAnvrD/sgdBhIXE4kBtA9xM4Dg3BxjLF21JuAEgGxp55O23Q/aaa/Sdk07lejqgCNWsz3PL95nf+/dVxQMHbQxUOv8wFgepT1TLJdrxl7YT9b6oTGwbUavvq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MYe3iDKv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f4f505118fso18568981fa.3
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725009285; x=1725614085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHsMn5kFdGCBqudkVoxsaBBiaJWQEZ/c0MyvIXo/wrs=;
        b=MYe3iDKvTokGpcc8CPHXPGxXTdd9mFRe/hT2yWSuX0jOyUx+j14LJIH8zSIDWXwdpz
         1b0LSE6kLANtOVErFLxpQodDIRfwtnms/ifysVllLvN5KY5it+2tH3Se+ouxThj9NqE4
         /mRhq7CjLWfWApjXPlVmNzCOHC4Qj5UKoc66w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009285; x=1725614085;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHsMn5kFdGCBqudkVoxsaBBiaJWQEZ/c0MyvIXo/wrs=;
        b=kgUnjs+3jx65eNzG6OvT9FhE4KfdTGKYNK2efI23pahaQkV48x2+XCW2YHL+xCiCmU
         0i+BjKq4x2FCASTm9zSXuJMSJ3r2HJnCfUTaFg2aocJjvtwNr0i5kYqYotEH/GCEEtBP
         jpWHbWSjo9+2Z5bI38KdOMu46sXLgfKoVkC4fMFaQ70I4Gco+p31bkiaWrkbvvh1RC6H
         +irR218Fg5ok1sr/i96Tdw4MB7QMEJOcIPAxXM5zee4Wq94vTS3gKIoS/YJlza0/nJsx
         0sC7sfeN28AnrEh++3pwy272xCTasUjDhE/YAVyFQhLxSYBno7y2sjOv30yLR/6EeZUg
         HMRw==
X-Gm-Message-State: AOJu0YynWFaChqZu/fCzNbXn6O8NWfxgpaRnBdSvM5uiSyZFI1hnXMt1
	PcYN07QODz8sSp+unC0N2Ebq6sEAwD2A28fJlUCuvzV5LtG6AgY8ZHfUEkrg7Gs=
X-Google-Smtp-Source: AGHT+IHrVWZfHTQhT1DNzeqyBzoKe1zbIswbPjjJzfJTqyX34FI39PiV6qLxU/kQYANfmbNGGzd1GQ==
X-Received: by 2002:a05:6512:3b14:b0:533:4e2b:62fd with SMTP id 2adb3069b0e04-53546b035d0mr1076878e87.18.1725009284459;
        Fri, 30 Aug 2024 02:14:44 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89890090a1sm191708766b.49.2024.08.30.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:14:44 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:14:41 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs
 per-NAPI
Message-ID: <ZtGNgfXZv2BWbtY3@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-2-jdamato@fastly.com>
 <20240829150502.4a2442be@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829150502.4a2442be@kernel.org>

On Thu, Aug 29, 2024 at 03:05:02PM -0700, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 13:11:57 +0000 Joe Damato wrote:
> > +/**
> > + * napi_get_defer_hard_irqs - get the NAPI's defer_hard_irqs
> > + * @n: napi struct to get the defer_hard_irqs field from
> > + *
> > + * Returns the per-NAPI value of the defar_hard_irqs field.
> > + */
> > +int napi_get_defer_hard_irqs(const struct napi_struct *n);
> > +
> > +/**
> > + * napi_set_defer_hard_irqs - set the defer_hard_irqs for a napi
> > + * @n: napi_struct to set the defer_hard_irqs field
> > + * @defer: the value the field should be set to
> > + */
> > +void napi_set_defer_hard_irqs(struct napi_struct *n, int defer);
> > +
> > +/**
> > + * netdev_set_defer_hard_irqs - set defer_hard_irqs for all NAPIs of a netdev
> > + * @netdev: the net_device for which all NAPIs will have their defer_hard_irqs set
> > + * @defer: the defer_hard_irqs value to set
> > + */
> > +void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);
> 
> Do you expect drivers or modules to call these?
> I'm not sure we need the wrappers just to cover up the READ/WRITE_ONCE()
> but if you do want to keep them they can be static inlines in
> net/core/dev.h

It looked like there were a few call sites for these in
net/core/dev.c, the sysfs code, and the netlink code.

I figured having it all wrapped up somewhere might be better than
repeating the READ/WRITE_ONCE() stuff.

I have no preference on whether there are wrappers or not, though.
If you'd like me to drop the wrappers for the v2, let me know.

Otherwise: I'll make them static inlines as you suggested.

Let me know if you have a preference here because I am neutral.

> nit: IIUC the kdoc should go on the definition, not the declaration.

My mistake; thanks. I suppose if I move them as static inlines, I'll
just move the kdoc as well and the problem solves itself :)

