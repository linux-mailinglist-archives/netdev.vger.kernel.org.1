Return-Path: <netdev+bounces-103848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CA909E08
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DDBB20B29
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D11101E6;
	Sun, 16 Jun 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o7Vnjp7Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3E12E47
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718549971; cv=none; b=R538TehFTxDFp8+3box4X8KL8ClY5AmqXglwnWjGIsBgy7RL8eeFNDIzZ4lSJO7TomgaZdjjpamW0MM0jiJwoIQROHBN428vzyHtR7/vMmd8eU9mdyAVPb8dbfWwr3qtLWzWlaydPqxrxdqV46LJ/4/jXq3lIFx3EZNHai7NM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718549971; c=relaxed/simple;
	bh=rd9k6Pc5HaVw66F1GRBzk3DCuZB/+c304zL2zmGCNbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7RPERPDUaoOG849/0lsoFmPBx/Ejl/qRrpDeqgJRwqGUd4dXsATMV42EPPPY9YRJiUdR+FTZFnqDALts3Ex1lIGQ62F/w0Llb5BwqXrkt+bLgvg22yzzhgjSQTojx2cQISY41cv09S+cLbNEHNlfyRwbvALF2vndbEM/8tUWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o7Vnjp7Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=evL6CkB+xd+4fD9cJY7fB5tes/n5RhQAcoV+OAKN5SI=; b=o7Vnjp7ZLrxxGxPFdPpcl504Eh
	F3Dzri0xhgRaQltfhTSHjPX9FyTx4R8DneMNLytVD4WKgTiJiE1fTF8U3CnMsMWmMzykFJHj4mTrm
	bYzsA64gvER7iUmQGsW73avSkDwVyNiacIjcgC2tAU1UtGXTDD8COnDsUhy59N3VvH6A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIrLm-000BZJ-OC; Sun, 16 Jun 2024 16:59:22 +0200
Date: Sun, 16 Jun 2024 16:59:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: hfdevel@gmx.net, kuba@kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
Message-ID: <8c67377e-888e-4c90-85a6-33983b323029@lunn.ch>
References: <20240615.180209.1799432003527929919.fujita.tomonori@gmail.com>
 <2f9cf951-f357-402c-9da7-77276a9a6a63@gmx.net>
 <00d00a1c-2a78-4b7d-815d-8977fb4795be@lunn.ch>
 <20240616.214622.1129224628661848031.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616.214622.1129224628661848031.fujita.tomonori@gmail.com>

On Sun, Jun 16, 2024 at 09:46:22PM +0900, FUJITA Tomonori wrote:
> On Sat, 15 Jun 2024 20:33:04 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > I did wounder if calculating the value as needed would be any
> > slower/faster than doing a table access. Doing arithmetic is very
> > cheap compared to a cache miss for a table lookup. Something which
> > could be bench marked and optimised later.
> 
> Indeed, that might be faster. I'll drop the table in the next
> version. I'll put that experiment on my to-do list.

I would generally recommend getting something merged, and then
optimise it. This could be in the noise, it makes no real difference.
By getting code merged, you make it easier for others to contribute to
this driver, and there does appear to be others who would like to work
on this code.

	Andrew

