Return-Path: <netdev+bounces-174610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8DCA5F88F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25187188ABFE
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C572686B1;
	Thu, 13 Mar 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VJhsOptS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9A2686B7
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876387; cv=none; b=jxRCEO6fW6VQlSJbsnH5Ksh3jTI0sER0eMuKn+vkubTAeLg6+hdaN4s44Hewxmir+pQTEoGPxyyrXqp9eHG6BAhZb+PTgzwakZ6g1WZa7FKGL8FKG/LGG8pUuqC93b9gg7BZOhKLnN0fNhD57CNQLDE9SGYNBxR7TSpPH8cDCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876387; c=relaxed/simple;
	bh=m1v2kHB2wFWddLHMLNcTG9WMN9c2m8mKZm//8DFw+as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smpPYoDGlXlkcCgsPQNhYpM68N3QFnxmSWsT9VEMbyRPnORznFVk9gpqvRNV+2mzcN1UDU12KVXWZddBpFFH8+Oy/tLoNCV3844CgHlMC0Xr69IF55hxbBqLD86i37t7ypROfbUZJ6lUBBGeNzSB4O6rG3iYUZ0m4mV4MxCTbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VJhsOptS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uh+jy4czPz6D5F5Elw3j8kYQDRNK4LSsV2VFuC4YdMQ=; b=VJ
	hsOptS0PYXZ655nIqmgJOe33NTS4TTEQUwONvErMaHPPaPHoTwiaHf2TpcpCnkCW/5XzYk128Nmx3
	OzMTqALHg9UlJfJS9nxc1SEaO9tohqJ8RetNYKiFW1GOIoT0gUU4BYjARQQJ6DHkNjNuXVu5tonj4
	22MTLEDSiGobJkM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsjcK-00511Y-KB; Thu, 13 Mar 2025 15:33:00 +0100
Date: Thu, 13 Mar 2025 15:33:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net 02/13] net: dsa: mv88e6xxx: fix VTU methods for 6320
 family
Message-ID: <2e88876c-0d08-464a-89e9-75e2fd597022@lunn.ch>
References: <20250313134146.27087-1-kabel@kernel.org>
 <20250313134146.27087-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313134146.27087-3-kabel@kernel.org>

On Thu, Mar 13, 2025 at 02:41:35PM +0100, Marek Behún wrote:
> The VTU registers of the 6320 family use the 6352 semantics, not 6185.
> Fix it.
> 
> Fixes: b8fee9571063 ("net: dsa: mv88e6xxx: add VLAN Get Next support")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
> This bug goes way back to 2015 to commit b8fee9571063 ("net: dsa:
> mv88e6xxx: add VLAN Get Next support") where mv88e6xxx_vtu_getnext() was
> first implemented: the check for whether the switch has STU did not
> contain the 6320 family.
> 
> Therefore I put that commit into the Fixes tag.
> 
> But the driver was heavily refactored since then, and the actual commits
> that this patch depends on are
>   f1394b78a602 ("net: dsa: mv88e6xxx: add VTU GetNext operation")
>   0ad5daf6ba80 ("net: dsa: mv88e6xxx: add VTU Load/Purge operation")
> But I don't know how to declare it properly.
> Using the "Cc: stable" method with these commits tagged would mean they
> should be cherry-picked, but these commits in turn depend on other
> changes in the driver.

What happens when you try to cherry-pick this patch back to
b8fee9571063. If it explodes with all sorts of conflicts, whoever is
doing the backport will quickly give up and report the backport
failed. You can then step in and provide a backported version for a
particular stable kernel.

Or you can extend the Cc: stable:

Cc: <stable@vger.kernel.org> # 3.3.x

Anybody backporting the patch should not go further back than 3.3.x,
but the Fixes tag indicates older versions are broken, which is useful
knowledge to hit people over the head with when they refuse to update
to the latest LTS.

	Andrew

