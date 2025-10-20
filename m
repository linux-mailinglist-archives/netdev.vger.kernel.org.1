Return-Path: <netdev+bounces-230983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3425DBF2D67
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025FD4EDF93
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB6D3328E1;
	Mon, 20 Oct 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckMa2meL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21D332EA7
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983172; cv=none; b=WsYJnvOVwhGdJYrYpodVK0pIy7cFBmmiLaWmIbOamn39zESz5zPbrKnPY9w2njItRNvFu2x8UoXC3x8NaO1YNxzDKO0J76u+UtPGGvE9w4DaAnmcYXsv1bOh9FAXgSIxtpCatplz95mJWQfM/5kLFR9mOUSlmt0mPmgSH+8CwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983172; c=relaxed/simple;
	bh=KSaItg7owfwMA4E/6gJC21JmHwkSPxOVuYXpwaVH8eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdqHinJsUeZsuQeeG2wLR79L0vwlSk84zCwg4fiV4Ib3L0IHsqzUADuM/Uyg4wHwHpGQynOsmNbHzf4rNaJFv4CxeyPZQRslFDEK9zR1ojJjm7yjLU397GQrhzVjENqtPp7knaR9c4gACzaEpJLFgvVzZggBqYqCLJWL4UqwGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ckMa2meL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-427091cd4fdso2086332f8f.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760983169; x=1761587969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBIpzP5plYQbXfXPYKWyaixauHg0jqN/NWqmZVZnNC0=;
        b=ckMa2meL3YPvWDcGwBK+YxZErpGCddB46OFWhK2kz//Y7OXWaoplOQkNAUnmuUlwhT
         UwUO6qTztXkgLnBUOXTeLpklIcjZRjsDO3IEU+AFS+JJqIA+a7HDyMCYG9HvBLEydabR
         /4o4ZqrEgoLWcIok+8h01A1f9lIWHwlSzU3eTBwV+uSlRlLscuKyMxK5QJ0ybL50ZE1+
         +gOWFTSqXucUWRMvQP8qZKVsNowus5gAKTCoJlW/pXj56ZH3kR4aqo9AaAS6HdWjr3DJ
         TOwLL3ppprrSfziX5fJ85idP8N87tMXbhB9xh/CYvHlmiLKf7uFZ8bD4plCSecztaNnJ
         zCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983169; x=1761587969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBIpzP5plYQbXfXPYKWyaixauHg0jqN/NWqmZVZnNC0=;
        b=akJ2HSS2T9AzqTa9Ojf/tknJcCF6C6z8wq8CAFpZyufL6AjQJgHulfNxYm1OQ2uHWE
         ka9R9E2LOOL7d+Q09xEC1K+i8kB9F8y/VFBPYt5JOE8l5bQRlZIxk95WI9SZF/3gQvh8
         gxz3k9Ys0I/KgOi8VhNoPPnyKLwpABEKPbQGCQzaMKavlpvZ0PLEHoXkieXPC2LoOc9T
         IBOtIn9wqtiW30v+obfzlbWXDEvb8tFtoSByRtmYjgu8ySMSr7EsJhv+JPcsrHW1RryZ
         9US+Sh4eyu/+6Rfqq/IK/QEmN9PLt0gDH0lyBKv9QlJNGddce+KPsfhtjaDbqxUCRk/I
         Rawg==
X-Forwarded-Encrypted: i=1; AJvYcCV6B1Xda18VOIuy0Ql3/7/baScnPQ6YL/SWjRmPt1oyEdoPqSSWEB6if5b7NyG2YvqMZ7OybSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lklWPeOg+GaWAkGokSE5jTLrM0kO30nBYE9/08maNiTbK9Py
	ueouUyT2DZx3JFM2QY7mu3xpTshRGybORq6HvjVDaz+AnWOuZpc0irR9/FkmVq/lWzY=
X-Gm-Gg: ASbGncsd1lBRPLRnJejHCEYTtP0OFaHbvHlgUBfgHeUan9oGMKPZArYxJW8Sbi688rq
	PoWGVkxfjXH9fwj770cLcXhJ9HeOdNmaHzSxZrizrOXUQgw+NWDD2wpN4jTNIbD2gLpHUaUEDKh
	pNtlASEz5K68D5NCt/xTqWp3kQNYKBk+mzRToTLTpVpHI+AnAMJwaX13mxWv0+pka522Lz5YjmI
	qwMqckSXkSB6cr5HSDjZjusdkarGhlUt1bdWIZdeu8w6JD4MdvhaSae92wsmlnoRvkgXk4lByaW
	XnOSerhu8OueVTtWqX9IrLaH/sdfv1/wIyzo0hK59xXxMno/KyydQOC4RKPCpChyBm38RhnEXc6
	DM4ZKVr3F3RDZOAZxA455PhDk8PpglsaZmHCummbvCwpr0gY7QSxHCdgicCQ1NDKo/g/Zd1NSWe
	ix+x2gRZ46GOUWxv4=
X-Google-Smtp-Source: AGHT+IEve3rptaTxAGdVVvZ3C2zYTFALcxP2rlbTlJDOAnuR0ODFvI8Ya+F1oDNmVuli022ySOULYw==
X-Received: by 2002:a05:6000:2881:b0:427:1ba4:de9e with SMTP id ffacd0b85a97d-4271ba4dfdemr7326245f8f.63.1760983168883;
        Mon, 20 Oct 2025 10:59:28 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce06bsm16113493f8f.45.2025.10.20.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:59:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 20:59:24 +0300
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
Message-ID: <aPZ4fLKBiCCIGr9e@stanley.mountain>
References: <20251020133456.3564833-1-lizhi.xu@windriver.com>
 <20251020134912.3593047-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020134912.3593047-1-lizhi.xu@windriver.com>

On Mon, Oct 20, 2025 at 09:49:12PM +0800, Lizhi Xu wrote:
> On Mon, 20 Oct 2025 21:34:56 +0800, Lizhi Xu wrote:
> > > Task0					Task1						Task2
> > > =====					=====						=====
> > > [97] nr_add_node()
> > > [113] nr_neigh_get_dev()		[97] nr_add_node()
> > > 					[214] nr_node_lock()
> > > 					[245] nr_node->routes[2].neighbour->count--
> > > 					[246] nr_neigh_put(nr_node->routes[2].neighbour);
> > > 					[248] nr_remove_neigh(nr_node->routes[2].neighbour)
> > > 					[283] nr_node_unlock()
> > > [214] nr_node_lock()
> > > [253] nr_node->routes[2].neighbour = nr_neigh
> > > [254] nr_neigh_hold(nr_neigh);							[97] nr_add_node()
> > > 											[XXX] nr_neigh_put()
> > >                                                                                         ^^^^^^^^^^^^^^^^^^^^
> > > 
> > > These charts are supposed to be chronological so [XXX] is wrong because the
> > > use after free happens on line [248].  Do we really need three threads to
> > > make this race work?
> > The UAF problem occurs in Task2. Task1 sets the refcount of nr_neigh to 1,
> > then Task0 adds it to routes[2]. Task2 releases routes[2].neighbour after
> > executing [XXX]nr_neigh_put().
> Execution Order:
> 1 -> Task0
> [113] nr_neigh_get_dev() // After execution, the refcount value is 3
> 
> 2 -> Task1
> [246] nr_neigh_put(nr_node->routes[2].neighbour);   // After execution, the refcount value is 2
> [248] nr_remove_neigh(nr_node->routes[2].neighbour) // After execution, the refcount value is 1
> 
> 3 -> Task0
> [253] nr_node->routes[2].neighbour = nr_neigh       // nr_neigh's refcount value is 1 and add it to routes[2]
> 
> 4 -> Task2
> [XXX] nr_neigh_put(nr_node->routes[2].neighbour)    // After execution, neighhour is freed
> if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)  // Uaf occurs this line when accessing neighbour->count

Let's step back a bit and look at the bigger picture design.  (Which is
completely undocumented so we're just guessing).

When we put nr_neigh into nr_node->routes[] we bump the nr_neigh_hold()
reference count and nr_neigh->count++, then when we remove it from
->routes[] we drop the reference and do nr_neigh->count--.

If it's the last reference (and we are not holding ->locked) then we
remove it from the &nr_neigh_list and drop the reference count again and
free it.  So we drop the reference count twice.  This is a complicated
design with three variables: nr_neigh_hold(), nr_neigh->count and
->locked.  Why can it not just be one counter nr_neigh_hold().  So
instead of setting locked = true we would just take an extra reference?
The nr_neigh->count++ would be replaced with nr_neigh_hold() as well.

Because that's fundamentally the problem, right?  We call
nr_neigh_get_dev() so we think we're holding a reference and we're
safe, but we don't realize that calling neighbour->count-- can
result in dropping two references.

regards,
dan carpenter


