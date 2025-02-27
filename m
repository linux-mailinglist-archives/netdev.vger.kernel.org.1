Return-Path: <netdev+bounces-170343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC53A48484
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758D71758BB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53D1A9B5B;
	Thu, 27 Feb 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0Tr/jzQg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D04EB38;
	Thu, 27 Feb 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672192; cv=none; b=dmEgFttjWOGZgyE/Rd8KFNWLdhqaANM/Yh2NWC8TS0LixqhuGSedTU0FCsMgrG2VM2Kf2DDsqAK5SKx3W8xynA1qg9vVKOMp3/obso+/54tWzDcaZu+ZpTUi/THAmgeBlSL9UjsoE94TA7tTx2rOV1uSluDp3k/ezr52H2JXk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672192; c=relaxed/simple;
	bh=kDR/3BsbGHNq1vO8Xg5bepJteccoLWRVMd1vEEh2v1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOEflF5bXzPprD47h6k0wBBmNVnPSoz4MCTSnjbeR6SyEj4yAl4iTmnoP1Urp9BECI6Le6tEPNQmRuV513xtY5vZl6LaxcRv4dpjl6VcdyAtoIht+gth7+zTaNr/EAaiN+RXljdSlhDMvhftcrsop5YZGdFBCUro9Yc24IVyQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0Tr/jzQg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jHA36oJ30EP9uMa5rF7xPESwPrtKLCK7Cd5ezd49fWk=; b=0Tr/jzQg9aJuTcenur4l/oX+xr
	4IxBeJe4kMTdHI7YinrnF4qym310wM1HdVJS+OF7M7xsmrryPnHn8zHfb8PzU3vAkbZ/v6gHkLBlb
	FdB6ztqqpqTYHv544JgFMldLAiS8/Cz9HvXXzivirZGe+vQ12cfJb1itGb4RA/YgYkso=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tngLe-000e3j-3H; Thu, 27 Feb 2025 17:02:54 +0100
Date: Thu, 27 Feb 2025 17:02:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: Link flap workaround option for false IRP events
Message-ID: <8c0a80fe-5e92-42c4-88cc-0fc46c17a936@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>

> The reason for the module option is I'm playing it safe, as Intel couldn't determine root cause.

> The aim of the patch is to keep the effect to a minimum whilst
> allowing users who are impacted to turn on the workaround, if they
> are encountering the issue.

And how do such users determine this module parameter exists? You need
to be a pretty savvy user to know about them, and how the set them,
etc.

> Issue details:

> We have seen the issue when running high level traffic on a network
> involving at least two nodes and also having two different network
> speeds are need. For example:

> [Lenovo WS] <---1G link---> Network switch <---100M link--->[traffic source]
> The link flap can take a day or two to reproduce - it's rare.

By flap, you mean down/up? So the network dies for a couple of seconds
while autoneg happens? And this repeats at 1 to 2 day intervals?

Or does the link go down, and stay down, and it needs user
intervention to get the link back?

	Andrew

