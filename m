Return-Path: <netdev+bounces-119312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A62795522F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9DC2864D0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EA481AD7;
	Fri, 16 Aug 2024 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L8hZYQAG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37855893
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842118; cv=none; b=VJaWjtcz2AkLlpCZh73zDEWXmF6P2AFu51VE8iMairkwaF1p21GwKdSjLCCqRMVtpoVMJSOCY/65kU3MOByTPUHyyJSoZW1iX+PN6KmLvjhk3I0RcFEn/cDFeGEam9Ml4jcqrNd81wFbeJ/JhKeheiHUJ8ihLT6Ss/FAFqvJZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842118; c=relaxed/simple;
	bh=yfv/5f3LO31w3lGqEJqEAwKGDf0CEiS72lCeG7B5ksg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLFqHYEJbIZxrNAOQLJG4lNu6KyjZaNQaMy84VREpCzPJqRyUpd1b0TvJqPsNtEo9Dbl9Bi9WhvgoCxidhKalE7wbgxVI2Fq/xJaG+Es9f45gxzF5OTYyF7ezAksEMB8ebdfJvWCaqydgJkEQ41ftqPbsfo++lDJMKR4F5E9Le0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L8hZYQAG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xd7VXcBl257GszwHi+LyPbSYSmxpqwT0rbxgq8qtS1I=; b=L8hZYQAG5pwjxsbJQgbpYPGTEm
	7hBG/CxMuUvVib7ZCwCCegsLS03Cw44gAzJnVY0ElQ1XPGZ0Jo7aO75oeCptCvrSqS4gbZA/oludS
	jxjhvp4RTRN9rv211GHA2gWrPXX7OkTVpS2DI+K6nAQaY73V2OMNuZelXSwcubAB+AUo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sf453-004xpS-Tf; Fri, 16 Aug 2024 23:01:53 +0200
Date: Fri, 16 Aug 2024 23:01:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Woojung.Huh@microchip.com, ceggers@arri.de,
	arun.ramadoss@microchip.com
Subject: Re: [PATCH net] net: dsa: microchip: fix PTP config failure when
 using multiple ports
Message-ID: <f80d7a6b-651f-4c00-a068-c0cba2ff7ca9@lunn.ch>
References: <20240815083814.4273-1-foss@martin-whitaker.me.uk>
 <f335b2b8-aec7-4679-993a-3e147bf65d1d@lunn.ch>
 <b21de19d-db51-4d8e-b9be-d688f1c71be2@martin-whitaker.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21de19d-db51-4d8e-b9be-d688f1c71be2@martin-whitaker.me.uk>

On Fri, Aug 16, 2024 at 06:18:46PM +0100, Martin Whitaker wrote:
> On 15/08/2024 15:38, Andrew Lunn wrote:
> > On Thu, Aug 15, 2024 at 09:38:14AM +0100, Martin Whitaker wrote:
> > > When performing the port_hwtstamp_set operation, ptp_schedule_worker()
> > > will be called if hardware timestamoing is enabled on any of the ports.
> > > When using multiple ports for PTP, port_hwtstamp_set is executed for
> > > each port. When called for the first time ptp_schedule_worker() returns
> > > 0. On subsequent calls it returns 1, indicating the worker is already
> > > scheduled. Currently the ksz driver treats 1 as an error and fails to
> > > complete the port_hwtstamp_set operation, thus leaving the timestamping
> > > configuration for those ports unchanged.
> > > 
> > > This patch fixes this by ignoring the ptp_schedule_worker() return
> > > value.
> > 
> > Hi Martin
> > 
> > Is this your first patch to netdev? Nicely done. A few minor
> > improvements. You have the correct tree, net, since this is a fix. You
> > should add a Fixes: tag indicating the patch which added the bug. And
> > also Cc: stable@stable@vger.kernel.org
> > 
> > Thanks
> > 	Andrew
> 
> Hi Andrew,
> 
> It's my second patch. Yes, I missed the Fixes: tag. It should be
> 
> Fixes: bb01ad30570b0 ("net: dsa: microchip: ptp: manipulating absolute
> time using ptp hw clock")
> 
> Will you insert this, or do you need me to resend the patch?

Ideally, please resend it. patchwork might pickup the Fixes: tag from
your reply, but since it was wrapped, it might get it wrong. Sometimes
Jakub fixes things like this when merging patches, but it is easier
for him if there is a new correct version. And it is a good learning
exercise for somebody who i hope will submit more patches in the
future..

    Andrew

