Return-Path: <netdev+bounces-185529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04904A9ACEA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8963BE473
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7592522F392;
	Thu, 24 Apr 2025 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BESfJqtA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CEF22CBE9;
	Thu, 24 Apr 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496617; cv=none; b=Cnl7CSeBDDgPeDz5j6PFYt0Pe3O6IHsE+tOF3e3LC4quF3QsQRrJanlPRQjr//MOS1KvGBrgzVYIwAGuFTj8jK5jNvG4Bt/li55Hul0p6xwekSAOgPdFAmVBBPpov31WNu++qB9fdKM/cM1WpDz1LxyopBHicAe8pF0vMUQog9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496617; c=relaxed/simple;
	bh=nAj0N3ovD8bLyyRqHE5gU6mhmOpMsErhRtAn2uNjcJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRufBBUuyZ4Zo7/n2hEJy8cyMzFabTTDMaIyA0/aSfC/zVgfFladxdJ9INTiflwlgRFtLRNA3NsGs+mScQ92taEOll3hG2IfO12Mvxj+RMuJ0VN1pexE6ttIPfpIJYlQn7dfsUMbL8J7sp75TTplLfkzoFn53CS4Vgue8PpBMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BESfJqtA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZZUTwd9c1S61T3iZg2G9dEZKpyLqqlMebgnkhbCpRhM=; b=BESfJqtAkHEkdiAs4hmeY2BD3M
	I3fxRVGOqYbB8jrR3eeonKM08yb9JJpGMG6tEqWjir3D7m388wCO2lslvA28AKgtwuxlWTALdYblN
	JQC2ACUq7APaQOV3AS+sFg30RZ4hbz3z8UYX7IvmuFWCbPqyOmPCUEjZ3ldCJb19UQlw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7vP1-00ASRQ-NS; Thu, 24 Apr 2025 14:10:03 +0200
Date: Thu, 24 Apr 2025 14:10:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/7] net: register debugfs file for net_device refcnt
 tracker
Message-ID: <4118dbd6-2b4b-42c3-9d1e-2b533fc92a66@lunn.ch>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
 <20250418-reftrack-dbgfs-v4-7-5ca5c7899544@kernel.org>
 <20250423165323.270642e3@kernel.org>
 <a07cd1c64b16b074d8e1ec2e8c06d31f4f27d5e5.camel@kernel.org>
 <20250423173231.5c61af5b@kernel.org>
 <cdfc5c6f260ee1f81b8bb0402488bb97dd4351bb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdfc5c6f260ee1f81b8bb0402488bb97dd4351bb.camel@kernel.org>

On Thu, Apr 24, 2025 at 06:56:06AM -0400, Jeff Layton wrote:
> On Wed, 2025-04-23 at 17:32 -0700, Jakub Kicinski wrote:
> > On Wed, 23 Apr 2025 20:04:58 -0400 Jeff Layton wrote:
> > > On Wed, 2025-04-23 at 16:53 -0700, Jakub Kicinski wrote:
> > > > Names are not unique and IIUC debugfs is not namespaced.
> 
> Correct, debugfs is not namespaced.
> 
> I meant to say earlier that I'm open to suggestions on how to make the
> netdev names unique. Low-level netdev stuff is not my area of
> expertise. We can drop this patch if doing so is problematic.
> 
> > > > How much naming the objects in a "user readable" fashion actually
> > > > matter? It'd be less churn to create some kind of "object class"
> > > > with a directory level named after what's already passed to
> > > > ref_tracker_dir_init() and then id the objects by the pointer value 
> > > > as sub-dirs of that?  
> > > 
> > > That sounds closer to what I had done originally. Andrew L. suggested
> > > the flat directory that this version represents. I'm fine with whatever
> > > hierarchy, but let's decide that before I respin again.
> > 
> > Sorry about that :(
> > 
> 
> No worries...but we do need to decide what this directory hierarchy
> should look like.
> 
> Andrew's point earlier was that this is just debugfs, so a flat
> "ref_tracker" directory full of files is fine. I tend to agree with
> him; NAME_MAX is 255, so we have plenty of room to make uniquely-named
> files.
> 
> We could build a dir hierarchy though. Something like:
> 
> - ref_tracker
>     + netdev
>     + netns

How do you make that generic? How due the GPU users of reftracker fit
in? And whatever the next users are? A flat directory keeps it
simple. Anybody capable of actually using this has to have a level of
intelligence sufficient for glob(3).

However, a varargs format function does make sense, since looking at
the current users, many of them will need it.

	Andrew

