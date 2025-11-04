Return-Path: <netdev+bounces-235585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB5C33018
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 22:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF894420FA9
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCC2BEC41;
	Tue,  4 Nov 2025 21:16:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA72D3737
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291007; cv=none; b=LyNdiruY/aMqfNLq2qWEYjo7NVCDEmesD0bPUJrod2nQW5BE11LTz+uHjDe4xF1xBBzM0k3iEQoyPkqjvyVjqvo9xOfp8ELcKZUW7gt1JueYXunsaBtspn5griLxvShXvstWJnFc8UoezaKp+KGLXVn5IIlpa/Hio+i68cpG1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291007; c=relaxed/simple;
	bh=UTxD4ES96MSxMz2l3X3pHF+HUGcr6qpp4yP4Xftc+i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdDdPoOchOsv+TosV/EpE7/n7PMbVuu/bLGsAA4xyxr8RMjIlSmsq6hQaVMQmVK1ZGdwtpS2QcqjPzHH1IxqiBwjBO42qW1Kd1vnoF9TPj1aSmbBvEgwnC9tZhG2/W52sDtIErvS39shXHIyF3mesjIJRU1zfzPPu6tQCUhluoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from equinox by eidolon.nox.tf with local (Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1vGOOR-00000000HY9-2IYG;
	Tue, 04 Nov 2025 22:16:44 +0100
Date: Tue, 4 Nov 2025 22:16:43 +0100
From: David Lamparter <equinox@diac24.net>
To: David Lamparter <equinox@diac24.net>
Cc: Lorenzo Colitti <lorenzo@google.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Patrick Rohr <prohr@google.com>
Subject: Re: [RESEND PATCH net-next v2 2/4] net/ipv6: create ipv6_fl_get_saddr
Message-ID: <aQptO3iWSdZkdfAs@eidolon.nox.tf>
References: <20251104144824.19648-1-equinox@diac24.net>
 <20251104144824.19648-3-equinox@diac24.net>
 <CAKD1Yr2maTnjEjYYFn9MNG-R+Mx7jw8wcxfowbAk+h=LCZE1pA@mail.gmail.com>
 <aQpmVg6iLVZiI7hH@eidolon.nox.tf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQpmVg6iLVZiI7hH@eidolon.nox.tf>

On Tue, Nov 04, 2025 at 09:47:18PM +0100, David Lamparter wrote:
> On Tue, Nov 04, 2025 at 12:51:26PM -0500, Lorenzo Colitti wrote:
> > On Tue, Nov 4, 2025 at 9:49 AM David Lamparter <equinox@diac24.net> wrote:
> > > This adds passing the relevant flow information as well as selected
> > > nexthop into the source address selection code, to allow the RFC6724
> > > rule 5.5 code to look at its details.
> > >
> > > [...]
> > >  struct ipv6_saddr_dst {
> > > -       const struct in6_addr *addr;
> > > +       const struct flowi6 *fl6;
> > 
> > Do you need an entire flowi6? In this patch I see that you only use
> > saddr and daddr.
> [quote reordered below]
> > Similarly, do you need a sk? I don't think you use it in this patch.
> > Is it used in future patches?
> 
> The answer is the same for both fields: the RFC6724 code (which I
> haven't posted yet and really should)

I've thrown up this (unfinished) code at
https://github.com/eqvinox/linux/commits/rule-5-5-HEAD/

This is NOT a request for reviews of those changes; I'm still working
on things.

