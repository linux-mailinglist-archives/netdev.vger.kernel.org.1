Return-Path: <netdev+bounces-186182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A575A9D63A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC94E162A87
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8859297A63;
	Fri, 25 Apr 2025 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPd6Sh5q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DA297A62
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745623479; cv=none; b=Ei2UoVZcOuesl3ioPHGK1aaxlAsZcfIree/xhVL0piG7hixFqvAPEg9v9ktgb+AuFHHqQCgYmZLbhNfcFT5mjmj1GHd1A+LE2GDYCY5+pybrkRqCLYuNdX9BkytYegyyEANd1WL6a7zTO10qyTvTNhHQwt9vfb1TUyucTqj+7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745623479; c=relaxed/simple;
	bh=B5OXRVPek/B+ddasBj6G2p5RouHbGaCs7eOa2s2VDwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3gPrO6Ox642GHTJSe95p8ZGjjCvWi73rAOlxdDmym1EIcTE30bwXICtrYDkrhD4qEYLHbcqUKBFMJyEv/nqvQu+20vSi1c3NUG63G0sOtZCB0XH2yuXuhhNvx3N8tvJa2AVBNXrzNWJ+GdxMrOqhlgR7+7xELitvM8qmzatfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPd6Sh5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70607C4CEEF;
	Fri, 25 Apr 2025 23:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745623479;
	bh=B5OXRVPek/B+ddasBj6G2p5RouHbGaCs7eOa2s2VDwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPd6Sh5q69w8Y+Jje3GKOF2Gfq5gw6s/QTnFm7mSn2Vm/oqGY9ozIDdDOtzMa1/44
	 MJWiB9dGRMQrEgIwAfUsfIakC1K0EYqoHGd35VjpdvJ+OqUWyIyW7Ch3ViqmzswuJn
	 YT/Kweh8fM5SbQ10mTCTwiKgmFPGDNpcnXCamrVDLb8q648I/5JoWpoO0m5hFFYvCS
	 TYIK3ulvl6IvoRFvj53p3qqJ0xH9fBpsLD6XBmUkepqiL9VM27IV456coQxsMiBgmu
	 OEP6rjcliXvukPyUAgJDg88ywCkJU1TdeX7D/hKNkmPuzQpjb0RIvostabWZLQ0ShJ
	 LXLFmgdS1wMxA==
Date: Fri, 25 Apr 2025 16:24:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk,
 asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com,
 dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 11/22] net: allocate per-queue config structs and
 pass them thru the queue API
Message-ID: <20250425162437.45765bc0@kernel.org>
In-Reply-To: <CAHS8izN5ZjCmBC-+_p0kLFNo5hexEG=GKfk7Jd7w4wokcw2F3w@mail.gmail.com>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-12-kuba@kernel.org>
	<CAHS8izN5ZjCmBC-+_p0kLFNo5hexEG=GKfk7Jd7w4wokcw2F3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 14:17:30 -0700 Mina Almasry wrote:
> > @@ -129,6 +136,10 @@ struct netdev_stat_ops {
> >   *
> >   * @ndo_queue_mem_size: Size of the struct that describes a queue's memory.
> >   *
> > + * @ndo_queue_cfg_defaults: (Optional) Populate queue config struct with
> > + *                     defaults. Queue config structs are passed to this
> > + *                     helper before the user-requested settings are applied.
> > + *
> >   * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specified index.
> >   *                      The new memory is written at the specified address.
> >   *
> > @@ -146,12 +157,17 @@ struct netdev_stat_ops {
> >   */
> >  struct netdev_queue_mgmt_ops {
> >         size_t  ndo_queue_mem_size;
> > +       void    (*ndo_queue_cfg_defaults)(struct net_device *dev,
> > +                                         int idx,
> > +                                         struct netdev_queue_config *qcfg);
> >         int     (*ndo_queue_mem_alloc)(struct net_device *dev,
> > +                                      struct netdev_queue_config *qcfg,
> >                                        void *per_queue_mem,
> >                                        int idx);
> >         void    (*ndo_queue_mem_free)(struct net_device *dev,
> >                                       void *per_queue_mem);
> >         int     (*ndo_queue_start)(struct net_device *dev,
> > +                                  struct netdev_queue_config *qcfg,
> >                                    void *per_queue_mem,
> >                                    int idx);
> >         int     (*ndo_queue_stop)(struct net_device *dev,  
> 
> Doesn't the stop call need to return the config of the queue that was
> stopped? Otherwise what do you pass to the start command if you want
> to restart the old queue?

As you say below, I expect driver to retain the config within qmem.

> In general I thought what when we extend the queue API to handle
> configs, the config of each queue would be part of the per_queue_mem
> attribute, which is now a void *. Because seems to me the config needs
> to be passed around with the per_queue_mem to all the functions?
> Maybe.
> 
> I imagined you'd create a new wrapper struct that is the per queue
> mem, and that one will contain a void * that is driver specific
> memory, and a netdev_queue_config * inside of it as well, then the
> queue API will use the new struct instead of void * for all the
> per_queue_mem. At least that's what I was thinking.

That sounds nice from the API perspective, but I was worried about
perf impact. Some driver folks count each cycle and we may be mixing
cache cold and cache hot data in the config. At the very least not
all drivers will support all fields. So my gut feeling was that driver
authors will want to assign the fields to their own struct members,
anyway. Perhaps something we can revisit once we have more mileage?

> > +       maxqs = max(dev->num_rx_queues, dev->num_tx_queues);
> > +       cfg->qcfg = kcalloc(maxqs, sizeof(*cfg->qcfg), GFP_KERNEL_ACCOUNT);  
> 
> I just thought of this, but for devices that can new rx/tx queues on
> the fly, isn't num_rx_queues dynamically changing? How do you size
> this qcfg array in this case?
> 
> Or do they go through a full driver reset everytime they add a queue
> which reallocates dev->num_rx_queues?

Yes, good question. Easiest way to deal with that I thought of was 
to act like old memory school management. "normal" queues allocate
indexes 0 -> n, "dynamic" queues allocate n -> 0. Like stack vs heap
growth. And we need to patch up all this code that naively checks
queue ID vs num_real, we'll need a bitmap or a member in the structs.

>>> +       __netdev_queue_config(dev, rxq_idx, &qcfg, false);  
> 
> Ah, on error, you reset the queue to its defaults, which I'm not sure
> is desirable. I think we want to restart the queue with whatever
> config it had before.

Not defaults to be clear. The last argument here (false) tells
the config code to use the _current_ config not the pending one.
So we should be reverting to what's currently installed.

