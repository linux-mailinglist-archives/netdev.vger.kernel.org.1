Return-Path: <netdev+bounces-145045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E249C9324
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD9C28355C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473701A9B4F;
	Thu, 14 Nov 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AQv9O/lU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990814A91
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615669; cv=none; b=eW+g/HE8ZUuDUTPBjselabPMPJGmZRqNO4LLtcc6j3jgrdg4No563ic4wqIgG5V9Utj1qLSF+1++G743PB/57sKckVU8Bv2j1viPesGyda9uEOULyRfKQFwLszintHrkXEgkikxmLqMQ2VouNqBtFsYlkPQ902dw4XK3lVk6vts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615669; c=relaxed/simple;
	bh=xdb2fRXhTK5FzTRWLOLfXxjW7Ks3TpF3jhUW0TuXp/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owUdVDqkrIyMOI58kAJvT3hnGKWxn14UH/wcBs3ZIrbstf65URmzejgWMjEHK4ua3ikKB5nXjomMpNEJ1U8TVcaRWostuoLsDyfuo5BXPU6RZEM1Jl8lge/3yS1hxZ8743FO4v7Qe+MomzGvzLMWFvbxszpqAAQVP+ccsXq+psM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AQv9O/lU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cU71yniksnPA3B81N4UemtIKvbKLFFF5mvQAXbZsz5I=; b=AQv9O/lUuNJiugYppr9zCEGHbG
	SGkw1R9C5Hev6fH4hh+qz6LLg8OtO1QW4dkSPuzvwYx9F1dBPbUXz43ez6AVX6zVYbr0N+2GIoCf8
	+GAC2Ahvkjs2Hjc+sehXiRoFrgr+Jc1e1gnr0e+FiQr5KOdLMO3WcqDZdjqR6CxyH1cHBCOx/OHw1
	H7To1bh3wHPZrKiOHEckG/J77CW6U2ruLMDx3JRj0lhwM+QX7fxqo1riBQu6/UfGPxEStJBZ/FZar
	GfV4sqZAHjsgS4kQMCGjD5Rjuh5dvfMriTfFKXX10J1T7uR2YKvjJBPZkCcWXiE8jELavwQF5Megb
	HnHnkunA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41410)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBgKq-0000D8-1t;
	Thu, 14 Nov 2024 20:21:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBgKo-0001OC-2b;
	Thu, 14 Nov 2024 20:20:58 +0000
Date: Thu, 14 Nov 2024 20:20:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <ZzZbqll+zj8o+Umc@shell.armlinux.org.uk>
References: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
 <20241113161602.2d36080c@kmaincent-XPS-13-7390>
 <ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 13, 2024 at 03:57:56PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 13, 2024 at 04:16:02PM +0100, Kory Maincent wrote:
> > You simply need to install python python-yaml and maybe others python
> > subpackages.
> > Copy the tool "tools/net/ynl" and the specs "Documentation/netlink/" on the
> > board.
> > 
> > Then run the ynl commands.
> 
> Thanks... fairly unweildly but at least it's functional. However,
> running the first, I immediately find a problem:
> 
> # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump tsinfo-get --json '{"header":{"dev-name":"eth0"}}'
> 
> One would expect this to only return results for eth0 ? I get:

Here's the nlmon packet capture for the ynl request:

        0x0000:  0004 0338 0000 0000 0000 0000 0000 0010  ...8............
        0x0010:  2400 0000 1500 0503 f9d3 0000 0000 0000  $...............
        0x0020:  1901 0000 1000 0180 0900 0200 6574 6832  ............eth2
        0x0030:  0000 0000                                ....

Length: 0x00000024
Family ID: 0x0015 (ethtool)
Flags: 0x0305 (Return all matching, Specify tree root, ack, request)
Sequence: 0x0000d3f9
Port ID: 0x00000000
Command: 0x19
Family Version: 0x01

Then 16 bytes of data that does contain the interface name given to
YNL. I haven't parsed that, it seems to require manual effort to do
so as wireshark is unable to do so.

I'd be guessing to draw any conclusions from this without deeper
analysis.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

