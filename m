Return-Path: <netdev+bounces-118862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F3953574
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E616CB23538
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E627217C995;
	Thu, 15 Aug 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O5aoSFau"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910E3214
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732684; cv=none; b=Fo4ZOOZ/A/hEme/BpGLqzUWkwFtH52BX6bWGF7ewkdHiFhYC3LIQTIHYTIcbmjozuPNJfuVuKOWjTqtW7vWx0WR0pG36EL+WmjCRzKK0F+fqf1geg9dKxbHc7YLNyWxUoHUKiuX+MeJXMnX5dkbOpoXmIfkt7FwpyHs7G+7MwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732684; c=relaxed/simple;
	bh=E6kUmfGixmvbsCzfr8LStiPA/kEgFtAWjHgmchgVgh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd7IjRMd3/6O3m4KHuuzlruA+7Mbs0pnJFYv7vwZjOn/dBQDmSiGk8ufC/52Q/A12ZW37oqoFe5oZENH4R+Nnf1dIc5ZbkZBoi8zdL6hXWFurct6RzzQx8+433QCVi+ZX+jYJkH/1uhrc81cMpSr3GXHs1c5znp/63hCxf9sxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O5aoSFau; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EVQHSNibfPtjbGnEiF8WgEoT7g/+baKlIQMU/NL8SZ4=; b=O5aoSFaucAFWTIfixBf2gbN4M5
	AtnD3RQCIpqvVmYHNN9CgrgC5HMdmjDMBDudhM4Z7N6mxkwPklj/l3kcb2G+t0dHEbDPtp5XCP1GT
	V2DSNPgvbDFPkK0Pftba5t+TOu2LEZAYwxA9P79Wx1t0IdfK+GX5+Yf+05MILIP0igXI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sebc0-004qkU-8v; Thu, 15 Aug 2024 16:38:00 +0200
Date: Thu, 15 Aug 2024 16:38:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Woojung.Huh@microchip.com, ceggers@arri.de,
	arun.ramadoss@microchip.com
Subject: Re: [PATCH net] net: dsa: microchip: fix PTP config failure when
 using multiple ports
Message-ID: <f335b2b8-aec7-4679-993a-3e147bf65d1d@lunn.ch>
References: <20240815083814.4273-1-foss@martin-whitaker.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815083814.4273-1-foss@martin-whitaker.me.uk>

On Thu, Aug 15, 2024 at 09:38:14AM +0100, Martin Whitaker wrote:
> When performing the port_hwtstamp_set operation, ptp_schedule_worker()
> will be called if hardware timestamoing is enabled on any of the ports.
> When using multiple ports for PTP, port_hwtstamp_set is executed for
> each port. When called for the first time ptp_schedule_worker() returns
> 0. On subsequent calls it returns 1, indicating the worker is already
> scheduled. Currently the ksz driver treats 1 as an error and fails to
> complete the port_hwtstamp_set operation, thus leaving the timestamping
> configuration for those ports unchanged.
> 
> This patch fixes this by ignoring the ptp_schedule_worker() return
> value.

Hi Martin

Is this your first patch to netdev? Nicely done. A few minor
improvements. You have the correct tree, net, since this is a fix. You
should add a Fixes: tag indicating the patch which added the bug. And
also Cc: stable@stable@vger.kernel.org

Thanks
	Andrew

---
pw-bot: cr

