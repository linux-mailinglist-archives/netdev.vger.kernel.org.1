Return-Path: <netdev+bounces-231088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94969BF4B75
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7225403508
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 06:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10962673B0;
	Tue, 21 Oct 2025 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yp+gDZXg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325E25B1D2
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761028614; cv=none; b=l+cZQkOPIKIMP2uTv/JHk8dyWwX/0fLnuOBPOAw6Am7mo6gLob+t8qEnUo2PzPdPuXPIqJB5aSTMue4hGlZySXYcSqxNhkX291zyvM0ZTEFi2esF5kqWby5Ncd3VgeTqD7U1ECjNaCD0yQIVJIcJ/K21FTxHc7huzR0i+OxntnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761028614; c=relaxed/simple;
	bh=pPHShIOw0fKqNBE6FP/aihpLejo2j/yJSiQbkCPkF1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9WxxGqdWzAXthIWk3UmoVPrD/5JNknwROFwC37ZJODmUNrLaTE34GOowo3bqy4eK/2uVLb3oDKSz+CDnx3IbUXlvkYFBVJ6fBQWq4KpDbCkzDyIUVW1YXst3GD/DNV7g3j/bTiB5dmMaKnKSI6dIRJ38CPvY5NVAIiCssWpMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yp+gDZXg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47495477241so3976095e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761028611; x=1761633411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWWblYrlCLEpcH5LTQcbLzZ3/EiI9nz+a1hzMsf4pNQ=;
        b=Yp+gDZXg8xLE7MShXtTr3l9G7P5t8spbIFozLyQ9bWRRAPW3uxHW92Vt26khlqrH6i
         taQWHH9LaEHqMoS1RhgK8XsedBuIGMJVPqN/kL4BT0r9inczmuXKmOQ2siss6dpqtidX
         6mBC0SfEni/uRrcBIQQk/R8ImrAK2dyFUgEjnrETW7+g028b0QVygZTG61MHtSGwyQuP
         JkipUU9iSwPt40z4EFwpTjvFSzjT+KaQYIa3HQ51d+KSYJ+1OJ8Bhg3huSlMLhToaWfB
         3ZizoAFI4HJt+2usx8dXH9+NP6Zy5jxkFm33PYKTURjOLFrOk3oM4dfRSOXGPpRs+xiF
         8KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761028611; x=1761633411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWWblYrlCLEpcH5LTQcbLzZ3/EiI9nz+a1hzMsf4pNQ=;
        b=ULlUJoU2TrLlDeJu/3a3fFek+ptnLHJ8pEBG1+o1NA015VUWkB4CvFulIdja8490ZG
         nifrCmfomMdiL1Bj18jWhJwsiRhgOo5bqXvQS8tYjnO5ZNcRbC27Lj1GfiUUoV9y6iWa
         m8RGoRHcd4iXx6InBXnUvaZ8xVFh/7RotreU9J0QKi3fNXZ4bISEJj+v/A/gkVTb1dXu
         Q6FwdJQG8v9+qXIO37wwc/2nVylygmIUxmonSgmQrlU1pB7mf9ygauDddj6HrjlmE7LE
         GaV3c9xHzvdU9NScT8gIpLQlDznkj8dPN/CcSELTSAl7p46rH1MKjiwVm2oxWehXaOhc
         jG1w==
X-Forwarded-Encrypted: i=1; AJvYcCU2lvE8aqjAeD7OX+6ZhmG7G2z61M/U1vRbFNjkAvNyeHU1Vknhf4py9MJ/eOGtE4G+cFMhMZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2uW0cFe4Cycb7X+FsoNCrlf/WoVorceTfEMJWheduDjo/xrr
	z+EufqOC+8vrMk3B5b1WVGvR/xiNyogfSb9XMGDfn0HpmfB/nSQ6yVtkmL4NmdWzCsFOUCv4P7z
	WaTFR
X-Gm-Gg: ASbGncvXKcMpvVXVS12Oq7HFabigMHm7YPyCUWFmCdyw5IO0jotzM+/PH2vfNcWUgHp
	+CqI4XrpOrHDiJiI9zoQgr9h2Yike+VxbyKIRMKUgr6QWskxvuB7QazuyifBpP9j4+SY/tBOWZt
	GCBq/K/NnSqzFCexXz3kBz1wy4mykfJM77QuCIAmyagRImfn6/3M0ZEfwSsXAMBcU8Ci6Wyy0l6
	VEV4c5C2nQP86ElxCEWCV4kA061ZH3qHaINsk5VG8Toylz+bFBz1ZWB/1yZU3C7VlmRK/LtfhXz
	roXOnCH5C8LRH4QRSf7FvHuypZ+3tUaKFIkimHBN0e6RSEIuFuz8vwY3uDr25zcqpa1PN38qHoR
	bTsjifQvswCh05h65yS1hSSGRak7A0uMx1lMWzky39UzTuX7mpqE7W5lNhRzu+Z8qV6NMkEQN6e
	3tF5C2+Q==
X-Google-Smtp-Source: AGHT+IEkQcqp1ksk1Cj9+LjNgTTmawr/C6jo8SGgwsLly2e1GhUHXpoCb0o0/Ssyg6De4Q0iYDMU6Q==
X-Received: by 2002:a05:600c:8b66:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-471179117b3mr102871395e9.20.1761028610907;
        Mon, 20 Oct 2025 23:36:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3c56sm18971798f8f.18.2025.10.20.23.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 23:36:50 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:36:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] netrom: Prevent race conditions between multiple add
 route
Message-ID: <aPcp_xemzpDuw-MW@stanley.mountain>
References: <aPZ4fLKBiCCIGr9e@stanley.mountain>
 <20251021020533.1234755-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021020533.1234755-1-lizhi.xu@windriver.com>

On Tue, Oct 21, 2025 at 10:05:33AM +0800, Lizhi Xu wrote:
> On Mon, 20 Oct 2025 20:59:24 +0300, Dan Carpenter wrote:
> > On Mon, Oct 20, 2025 at 09:49:12PM +0800, Lizhi Xu wrote:
> > > On Mon, 20 Oct 2025 21:34:56 +0800, Lizhi Xu wrote:
> > > > > Task0					Task1						Task2
> > > > > =====					=====						=====
> > > > > [97] nr_add_node()
> > > > > [113] nr_neigh_get_dev()		[97] nr_add_node()
> > > > > 					[214] nr_node_lock()
> > > > > 					[245] nr_node->routes[2].neighbour->count--
> > > > > 					[246] nr_neigh_put(nr_node->routes[2].neighbour);
> > > > > 					[248] nr_remove_neigh(nr_node->routes[2].neighbour)
> > > > > 					[283] nr_node_unlock()
> > > > > [214] nr_node_lock()
> > > > > [253] nr_node->routes[2].neighbour = nr_neigh
> > > > > [254] nr_neigh_hold(nr_neigh);							[97] nr_add_node()
> > > > > 											[XXX] nr_neigh_put()
> > > > >                                                                                         ^^^^^^^^^^^^^^^^^^^^
> > > > >
> > > > > These charts are supposed to be chronological so [XXX] is wrong because the
> > > > > use after free happens on line [248].  Do we really need three threads to
> > > > > make this race work?
> > > > The UAF problem occurs in Task2. Task1 sets the refcount of nr_neigh to 1,
> > > > then Task0 adds it to routes[2]. Task2 releases routes[2].neighbour after
> > > > executing [XXX]nr_neigh_put().
> > > Execution Order:
> > > 1 -> Task0
> > > [113] nr_neigh_get_dev() // After execution, the refcount value is 3
> > >
> > > 2 -> Task1
> > > [246] nr_neigh_put(nr_node->routes[2].neighbour);   // After execution, the refcount value is 2
> > > [248] nr_remove_neigh(nr_node->routes[2].neighbour) // After execution, the refcount value is 1
> > >
> > > 3 -> Task0
> > > [253] nr_node->routes[2].neighbour = nr_neigh       // nr_neigh's refcount value is 1 and add it to routes[2]
> > >
> > > 4 -> Task2
> > > [XXX] nr_neigh_put(nr_node->routes[2].neighbour)    // After execution, neighhour is freed
> > > if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)  // Uaf occurs this line when accessing neighbour->count
> > 
> > Let's step back a bit and look at the bigger picture design.  (Which is
> > completely undocumented so we're just guessing).
> > 
> > When we put nr_neigh into nr_node->routes[] we bump the nr_neigh_hold()
> > reference count and nr_neigh->count++, then when we remove it from
> > ->routes[] we drop the reference and do nr_neigh->count--.
> > 
> > If it's the last reference (and we are not holding ->locked) then we
> > remove it from the &nr_neigh_list and drop the reference count again and
> > free it.  So we drop the reference count twice.  This is a complicated
> > design with three variables: nr_neigh_hold(), nr_neigh->count and
> > ->locked.  Why can it not just be one counter nr_neigh_hold().  So
> > instead of setting locked = true we would just take an extra reference?
> > The nr_neigh->count++ would be replaced with nr_neigh_hold() as well.
> locked controls whether the neighbor quality can be automatically updated;

I'm not sure your patch fixes the bug because we could still race against
nr_del_node().

I'm not saying get rid of locked completely, I'm saying get rid of code like
this:
		if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
			nr_remove_neigh(nr_node->routes[2].neighbour);

Right now, locked serves as a special kind of reference count, because we
don't drop the reference if it's true.

> count controls the number of different routes a neighbor is linked to;

Sure, that is interesting information for the user, so keep it around to
print in the proc file, but don't use it as a reference count.

> refcount is simply used to manage the neighbor lifecycle.

The bug is caused because our reference counting is bad.

So right now what happens is we allocate nr_neigh and we put it on the
&nr_neigh_list.  Then we lock it or we add it to ->routes[] and each of
those has a different reference count.  Then when we drop those references
we do:

		if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
			nr_remove_neigh(nr_node->routes[2].neighbour);

This removes it from the list, and hopefully this is the last reference
and it frees it.

It would be much simpler to say, we only use nr_neigh_hold()/put() for
reference counting.  When we set locked we do:

	nr_neigh_hold(nr_neigh);
	nr_neigh->locked  = true;

Incrementing the refcount means it can't be freed.

Then when we remove nr_neigh from ->routes[] we wouldn't "remove it from
the list", instead we would just drop a reference.  When we dropped the
last reference, nr_neigh_put() would remove it from the list.

My proposal would be a behavior change because right now what happens is:

1: allocate nr_neigh
2: add it to ->routes[]
3: remove it from ->routes[]
   (freed automatically because we drop two references)

Now it would be:
1: allocate nr_neigh
2: add it to ->routes[]
3: remove it from ->routes[]
4: needs to be freed manually with nr_del_neigh().

regards,
dan carpenter

