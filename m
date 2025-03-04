Return-Path: <netdev+bounces-171695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E3A4E3DE
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94A088767B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8DC27D79C;
	Tue,  4 Mar 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oOiusnYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B127E1A4
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100941; cv=none; b=UGc/Rx6EvTIefNFgGlxJuqV6tp5374qDPxaOzeGzhDOkchQz7ANRG3ZZ/MRqgMOCQ+D7O9pB8uTkGYPJMJsaFYkl6YwQsI3TIuyZYA5TTufJXTz9PSFcSiGnqzqIlLwCLlxWbceN2S6e/2BowMQZSg0Pxjg4fSVeNAsrOoRxj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100941; c=relaxed/simple;
	bh=8PdHR+go0LZyaSvswv9QdAwopu5SDegpWFTZMMMm+JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ55BdPTVD7R+qKctJSUnzxq1h5mxSFmjitFUELEwL+ZgQrGtHzlt3ZXAcx4s9WFuhDVw5nf6lJtef6UkxzGad7kARPNRhWnbK/csSavtg/dX9Fj7kyAvKmwhLKC5cxwyRKpEQf324u90f9Bixlyit7sxAFQ7/CjL0c7CqVF49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oOiusnYk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47208e35f9cso66579551cf.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741100939; x=1741705739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAJF5oZvK4kDimU1hi8HyGe8Ni5obiEempBFfdSb2no=;
        b=oOiusnYkJFatMYLUxEEfu7QYLKGgXcHIeicVtgcE1iF54yQBvdzLx658h06ePrcjee
         ueonzdyDtbrpkCQncf/aMhXwAS2amZKJQ6S4zcSw35cc8Agz2AkFMzEaIfP6MNHsu7Ct
         /pw7Zuj85EUvw2UfpQt4ct7rFWQ0aV66XawYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100939; x=1741705739;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAJF5oZvK4kDimU1hi8HyGe8Ni5obiEempBFfdSb2no=;
        b=nLVSScSLp1xI1WgJ6jqVszuaHH0y6Q4mZe5AunhvIsMaUUxJ++h/lqVqnaNPmLs/vP
         6VG2hGgihqC7RU8w+LLA9ZuM6HlHrOM0HdDegW+E+ZJajIVwdoFUzmZu+PoNW9PJzJ9t
         Vff/ENp1imaSwrtOoD90nMJjm4lIbDplOo5S0s5kYDcBQo3U8yCtXkMvw71bj3fWcSFT
         A6674g/qXpMDJiVEEkMky1hmG6BaMUjivmCHlrDaT9gWQhvpHFb3fJH2V1N+/i87C4Jj
         cV92zDPgmbyL2f4P3AYcx7j0oTSxGOQB1ao0rWrpPSrYqCBc9dvlI7DzhdR4rHMqzoEv
         dHeg==
X-Gm-Message-State: AOJu0YzsbMyzD5ei7/u7oa+48ur11jA2gKBvyXqQNSJbalcI+oixO42F
	JJl1/QFXDIpakAUlXLsA6MrJM4w39IidYAGig0AkvXuQCTzL38rCm+1YujaJ5NQ=
X-Gm-Gg: ASbGnct6j9BqARxD77wy4fTVmMlkWWjw1I0g9UNWAgOc8p/CFgcEdTTTvg43wMP00hA
	EfH2SYZXkzw4NKdZ8VgRg2W/WEKxWBUGz7r4rzhA3QkAIh3+4qVOmkn7ppihnKStRgUaIOhguye
	djJLQ4i6kQCf7ibpxuqRctx69YMW7JXCST4sMhXcJItoyXD7JGGGH3fTvPg2Tj0sd7PXKloUfIX
	6zm/9zydTpN27pEsS9V9ZoxSXI1TQ6q37EzJpVfDbJoK0FXiLWbU1dWWNqIgjcqAErAy5AIgK88
	BOFveTu0siaezCd6sE0GM5yrZ/qP0BBR7o8m6YURL97Uo9YnlfWZdQ8/VxrmqiCuN7ufi/d/JrV
	sB/+QVd8=
X-Google-Smtp-Source: AGHT+IFN7StRwj2Ft1J/Us75lrKPTPd2o+N24d4I6qj5+wKxsZNxpj1S/cF2hLsjZ4/ip/QBD/Wuaw==
X-Received: by 2002:ac8:5a49:0:b0:471:bcb7:7897 with SMTP id d75a77b69052e-474bc066ee2mr231531011cf.1.1741100938725;
        Tue, 04 Mar 2025 07:08:58 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bf582sm74153761cf.37.2025.03.04.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:08:58 -0800 (PST)
Date: Tue, 4 Mar 2025 10:08:55 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8cXh43GJq2lolxE@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303160355.5f8d82d8@kernel.org>

On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:
> > > > @@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
> > > >         bool still_empty;
> > > >         int i;
> > > > 
> > > > +       spin_lock(&vi->refill_lock);
> > > > +       if (!vi->refill_enabled) {
> > > > +               spin_unlock(&vi->refill_lock);
> > > > +               return;
> > > > +       }
> > > > +       spin_unlock(&vi->refill_lock);
> > > > +
> > > >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> > > >                 struct receive_queue *rq = &vi->rq[i];
> > > >  
> > > 
> > > Err, I suppose this also doesn't work because:
> > > 
> > > CPU0                       CPU1
> > > rtnl_lock                  (before CPU0 calls disable_delayed_refill) 
> > >   virtnet_close            refill_work
> > >                              rtnl_lock()
> > >   cancel_sync <= deadlock
> > > 
> > > Need to give this a bit more thought.  
> > 
> > How about we don't use the API at all from refill_work?
> > 
> > Patch 4 adds consistent NAPI config state and refill_work isn't a
> > queue resize maybe we don't need to call the netif_queue_set_napi at
> > all since the NAPI IDs are persisted in the NAPI config state and
> > refill_work shouldn't change that?
> > 
> > In which case, we could go back to what refill_work was doing
> > before and avoid the problem entirely.
> > 
> > What do you think ?
> 
> Should work, I think. Tho, I suspect someone will want to add queue API
> support to virtio sooner or later, and they will run into the same
> problem with the netdev instance lock, as all of ndo_close() will then
> be covered with netdev->lock.
> 
> More thorough and idiomatic way to solve the problem would be to cancel
> the work non-sync in ndo_close, add cancel with _sync after netdev is
> unregistered (in virtnet_remove()) when the lock is no longer held, then
> wrap the entire work with a relevant lock and check if netif_running()
> to return early in case of a race.

Thanks for the guidance. I am happy to make an attempt at
implementing this in a future, separate series that follows this
one (probably after netdev conf in a few weeks :).

> Middle ground would be to do what you suggested above and just leave 
> a well worded comment somewhere that will show up in diffs adding queue
> API support?

Jason, Michael, et. al.:  what do you think ? I don't want to spin
up a v6 if you are opposed to proceeding this way. Please let me
know.

