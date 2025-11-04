Return-Path: <netdev+bounces-235584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF89AC32F68
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 21:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A117C4E7415
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB031E834E;
	Tue,  4 Nov 2025 20:47:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936470824
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289244; cv=none; b=TnWi6zhswdicCDmlx0dZWclX03aYvGRB4hxl4X9UiKrWS5IgxK2OlI54Phs0tmcnG9Oapdd6PSRQ4nmrjnxtS9C35yJaHBovEXylqKx90TR6dzDOcP5YLt4Lg6dYRqGC56xUhKD9ifdozOvWne8FXzQ6bqe6YYMM76ipyoJnnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289244; c=relaxed/simple;
	bh=4eaIrXrANd5VD/fSpSfGD4DpUByFI9i0+0rIbNiFZLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjiqbTbA5oLlzHy9Mi3aIAHAshpnrOXhVUsg/TZTyfZMbddXtYWs5jAkuv1JKzoSJvFl7AHzUuASHwwIssOzZqgGviy28ajXsIXyjtNvyCRre7+JyhYaxyMpmA0vmjqds+657zVm/XySR6VFkdeunfv6mYh5/aqtsc/TRqYVcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from equinox by eidolon.nox.tf with local (Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1vGNvy-00000000GwG-4BSJ;
	Tue, 04 Nov 2025 21:47:19 +0100
Date: Tue, 4 Nov 2025 21:47:18 +0100
From: David Lamparter <equinox@diac24.net>
To: Lorenzo Colitti <lorenzo@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Patrick Rohr <prohr@google.com>
Subject: Re: [RESEND PATCH net-next v2 2/4] net/ipv6: create ipv6_fl_get_saddr
Message-ID: <aQpmVg6iLVZiI7hH@eidolon.nox.tf>
References: <20251104144824.19648-1-equinox@diac24.net>
 <20251104144824.19648-3-equinox@diac24.net>
 <CAKD1Yr2maTnjEjYYFn9MNG-R+Mx7jw8wcxfowbAk+h=LCZE1pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKD1Yr2maTnjEjYYFn9MNG-R+Mx7jw8wcxfowbAk+h=LCZE1pA@mail.gmail.com>

On Tue, Nov 04, 2025 at 12:51:26PM -0500, Lorenzo Colitti wrote:
> On Tue, Nov 4, 2025 at 9:49 AM David Lamparter <equinox@diac24.net> wrote:
> > This adds passing the relevant flow information as well as selected
> > nexthop into the source address selection code, to allow the RFC6724
> > rule 5.5 code to look at its details.
> >
> > [...]
> >  struct ipv6_saddr_dst {
> > -       const struct in6_addr *addr;
> > +       const struct flowi6 *fl6;
> 
> Do you need an entire flowi6? In this patch I see that you only use
> saddr and daddr.
[quote reordered below]
> Similarly, do you need a sk? I don't think you use it in this patch.
> Is it used in future patches?

The answer is the same for both fields: the RFC6724 code (which I
haven't posted yet and really should) calls ip6_route_output() for
different source addresses, and that takes both the sk as well as the
fl6 as parameters.

> But flowi6 has lots of information in it that
> potentially duplicates other inputs to this function - for example,
> the ifindex could also be in flowi6->oif. Should you pass in a
> different object than flowi6? Or should, for example, flowi6->oif be
> updated with dst->ifindex?

The problem is that they're not subsets of each other; flowi6 doesn't
tell anything about the neighbor/router that has already been selected
(and is at the core of the 6724 r5.5 considerations) - that's in the
dst.  But the dst is missing all the other bits ip6_route_output wants
to be able to look at for various policy things.

I agree there are a few bits that the function can get at in multiple
ways, but that's because we've already partially but not entirely
processed things at this point.  The flowi6 with a whole bunch of raw
input data is "still" there but being halfway done kinda naturally means
we have some object pointers around at the same time.

