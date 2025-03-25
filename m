Return-Path: <netdev+bounces-177412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F44A70188
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD3C845FEA
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B325A320;
	Tue, 25 Mar 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NkF6jK5r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D33188A3A;
	Tue, 25 Mar 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907639; cv=none; b=q2zWf7uDfNOLn3YtjschvDoPSh+lQlWKumm+als41rsINxJHUTiuBieqnAhTedC9t2b7mYNq5tDx7Te4ktjp2jL1tRC46jXh9Cpz8T8EFVdtdFOPeAEJsaHlDm/JfmzIG8ABLzbmzkokuip5UwZfD6qE2m5rGhnWSl3BlU+tM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907639; c=relaxed/simple;
	bh=/6uaON5smXHqQtVSKe215zqyNkdbFUTP9lCiLLW0nFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7EbH4H/mqopsWzBqY7vYa9t1jXFeWEcLTcEufNEMQ8fyvVCjdum/jRctK9zYN+RHqJ059moBOep7Cp0IxdJh35YaCWu4KGRF4oBkMQvedZEx+qrmGMGVpIo+MP33Ton03eYctdMWB0ew4wqlmg0BRuBwx+Orocuxqx0fUgYQw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NkF6jK5r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZCCmE3ChXDzeZzCiCtSrUM14/B1R5KKCHoYXvznttWA=; b=NkF6jK5rv/0YVolhaIGFpbswAV
	z140+YRdKiySD59l8bhuixIF2iSJeG33ic193TwL761LeMh5wjxDZaCgz9Lfr8PzGn3yzYbnBC09N
	2fZ4B+tB2OzBnQ6YBtR4n7GYLsaSPvyS5g1f7BC8xVdxUX58ZsDp79our5HI5ZzdeygY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tx3tK-0072tp-PR; Tue, 25 Mar 2025 14:00:26 +0100
Date: Tue, 25 Mar 2025 14:00:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: add a debugfs files for showing netns refcount
 tracking info
Message-ID: <8bd706d6-1a85-4b36-a65a-fc6afe73950b@lunn.ch>
References: <20250324-netns-debugfs-v1-1-c75e9d5a6266@kernel.org>
 <59446182-8d60-40a0-975f-30069b0afe86@lunn.ch>
 <33f758b03548b869f75d72a24c3abbcf382427ae.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f758b03548b869f75d72a24c3abbcf382427ae.camel@kernel.org>

On Mon, Mar 24, 2025 at 08:37:57PM -0400, Jeff Layton wrote:
> On Mon, 2025-03-24 at 21:50 +0100, Andrew Lunn wrote:
> > On Mon, Mar 24, 2025 at 04:24:47PM -0400, Jeff Layton wrote:
> > > CONFIG_NET_NS_REFCNT_TRACKER currently has no convenient way to display
> > > its tracking info. Add a new net_ns directory in debugfs. Have a
> > > directory in there for every net, with refcnt and notrefcnt files that
> > > show the currently tracked active and passive references.
> > 
> > Hi Jeff
> > 
> > CONFIG_NET_NS_REFCNT_TRACKER is just an instance of
> > CONFIG_REF_TRACKER.
> > 
> > It would be good to explain why you are doing it at the netdev level,
> > rather than part of the generic CONFIG_REF_TRACKER level. Why would
> > other subsystems not benefit from having their reference trackers in
> > debugfs?
> > 
> > 
> 
> Mostly because I just needed the NS_REFCNT_TRACKER at the time.
> 
> I'm OK with making this more general, but all of those subsystems using
> refcount trackers would need to add the infrastructure to create
> directories to track them.

The base directory can be created by ref_tracker itself.

> To whit:
> 
> What would the directory structure look like for the more general case?

 ref_tracker_dir_init(struct ref_tracker_dir *dir,
					unsigned int quarantine_count,
					const char *name)

and then each tracker use 'name' as the debugfs filename. You would
need to check it is unique before creating it, since uniqueness was
probably not a requirement before.

	Andrew

