Return-Path: <netdev+bounces-206666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E72B03FB4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7A07A1BCE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E9D253950;
	Mon, 14 Jul 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R3g71tAU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17D253F12
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499282; cv=none; b=VchR1iziBKjYcRXjti2DzAb3C93PbQJREsXUqdMk6M+aSo+MR2Ypnr+6aMZVFVekr/XrFCM5e7peUTlWNiNQ/V66Lx1PL02AgVENVCg0NgCtn7rjrBBW9+KimwPN9EmJAep9DdPGH+yESyCPAHCj9Ua1xPbCc7V2+KjT0AOURWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499282; c=relaxed/simple;
	bh=8V46B+h7Aq9vDHuLfNmbsEXoaZceorKSPR3tAJDh6es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBDc21aYBmBeeJnosa6buxEFTnkiF+r2cM3deGhj3fwUejFZpoynHocJK3gdu/fE6eQSmAuF3tDhUUoJDCtZR1jjyQ7FLI+9REtc8erJDy0FHvyPcAV9bnrrK2RiYh0peax0ctYJ0mwe7vS/ghF+7Hk9DMQKDD0WjZamN4qXADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R3g71tAU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0miYtI8adthQbJSjL+I5LKEdnoo7DUpP4EAp/foVdpU=; b=R3g71tAUdbs8gGHhissyKuNgCN
	+vq112vzxYRZFfGg8W923WBD+0D6+00Sd8GNr1VfbkTcJXMIGV48sU3wZjWE/wloUdcQZx1dL7NxM
	nXRw2I+ep8UT1c3XgiesOVXWL/T26muVGa+j48G1QzSzK+/wG1uxIBEl97kwdFq7Zh1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubJ7N-001SdM-RL; Mon, 14 Jul 2025 15:21:17 +0200
Date: Mon, 14 Jul 2025 15:21:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Naveen Mamindlapalli <naveen130617.lkml@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: Clarification: ethtool -S stats persistence across ifconfig
 down/up
Message-ID: <f84921a4-ccec-4418-9811-959989dcef2c@lunn.ch>
References: <CABJS2x60cwpoDXTex0M+CyOepWbdvX8-RcwFmBu-vxvNywW0tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJS2x60cwpoDXTex0M+CyOepWbdvX8-RcwFmBu-vxvNywW0tw@mail.gmail.com>

On Mon, Jul 14, 2025 at 12:46:15PM +0530, Naveen Mamindlapalli wrote:
> Hi All,
> 
> I am trying to better understand the expected behavior of Netdev
> statistics reported via `ethtool -S`.
> 
> Specifically, I would like to clarify:
> Are drivers expected to retain `ethtool -S` statistics across
> interface down/up cycles (i.e., ifconfig ethX down followed by
> ifconfig ethX up)?
> 
> >From my reading of the kernel documentation:
> - The file Documentation/networking/statistics.rst states that
> standard netdev statistics (such as those shown via ip -s link) are
> expected to persist across interface resets.
> - However, Documentation/networking/ethtool-netlink.rst (as of Linux
> v6.15) does not mention any such requirement for `ethtool -S`
> statistics.
> 
> So my understanding is that `ethtool -S` statistics may reset across
> down/up, depending on how the hardware and driver implement the stats.

I'm not sure it is written down anywhere, but the general expectation
is that they survive a down/up.

Statistic counters going backwards is not so easy to deal with. These
statistics can be exported to third party systems, e.g. via an SNMP
agent. So it is better they only go backwards when they wrap around.

Having said that, this topic is not closely looked at when reviewing
drivers, so i expect there are a number of drivers which do reset to
zero on close/open.

Feel free to submit a patch extending the documentation, but please
make it clear that the reality is, some drivers will reset to zero,
even if the intended behaviour is they don't.

	Andrew

