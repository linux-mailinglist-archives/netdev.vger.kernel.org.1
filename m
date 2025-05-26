Return-Path: <netdev+bounces-193451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB1CAC4165
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED617A5FF9
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7511FF1CF;
	Mon, 26 May 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XrqCk2qQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77898201261
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269711; cv=none; b=M2X+3Ro0VifxC9MpM75b/go9xy8Ey1HkZHXF8jeQh1vmTCDV9tLRv/AeemDZfGxbMCSZ1iCyMH9Fsg14i/1O+ycOOFsbD7ngiVsLalDNd8tuvD2/Fw3vDMgIug/MQEM5jUAuoVsqlBwYYMyYkUe2j2Fu5/edDUT9yGP+EVIRk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269711; c=relaxed/simple;
	bh=qal+7MPWt3FKHUuft8jXhyL7AhHYnAh2y22WjBbXClM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWK2Th0LoGgXcDf9wImju6ZGc4dF7O8yn8sxbVUAaT0q/9PzvxJex0k+ZS1P9nDGWyDVgfxPw7b4P5fexUdT8hP/NEO3FWF4RAgiRnxdvJ9v7J/YmsMT7Id2NvvRIOxYXJP3m02WccyMO/+ADxcTL8L1ATE56usS6dmPNWJURUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XrqCk2qQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F5Uae48EjpX3JFYZrSgemXyt4npxFmytveAivho6oQA=; b=XrqCk2qQQea5G59TjvBs73OMte
	DdDCH7mtuO+c4zKEC6qERhGQDq7Aamy21Q1kzrmlXWAgxzYlxEsrZTrKtfpkDMS4JoLuwwBIpB9Ei
	b2y4gGynqjA3T1X3Gq/zcYTX+q8FvD/4CRvxQMcpyKz7NWYczTub2McR6cNTR6UjFQ/4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJYoR-00E0TA-5H; Mon, 26 May 2025 16:28:23 +0200
Date: Mon, 26 May 2025 16:28:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>

> > Simple peer-to-peer, no routing nothing. Anything else is making things
> > hard to debug. Also note that this whole thing is supposed to be used as
> > peer-to-peer not some full fledged networking solution.
> 
> > Let's forget bridges for now and anything else than this:
> >  Host A <- Thunderbolt Cable -> Host B
> 
> Right, but that's precisely what I'm digging into: red->blue runs at line speed,
> and so does blue->purple. From what I understand about drivers and networking,
> it doesn't make sense then that the red->blue->purple path drops down so much in
> performance (9Gbps to 5Mbps)

Agreed.

Do the interfaces provide statistics? ethtool -S. Where is the packet
loss happening?

Is your iperf testing with TCP or UDP?  A small amount of packet loss
will cause TCP to back off a lot. Also, if the reverse direction is
getting messed up, ACKs are getting lost, TCP will also stall.

Maybe try a UDP stream, say 500Mbs. What is the packet loss? Try the
reverse direction, what is the packet loss. Then try --bidir, so you
get both directions at the same time.

	Andrew

