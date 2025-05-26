Return-Path: <netdev+bounces-193510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B82AC445C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 22:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D673BBCEE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A4023E320;
	Mon, 26 May 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qtZNdhVf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5485661
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290806; cv=none; b=XCBxjSxUU0lziQA6EluhzSf6DqjxkvBVrEGWXbuZvzmEcgdBUL7CK1j6z4DqJ4GSvOsKNpo+70zLPHgx44GhqkhDul/2Z9xQtdXzQJg14GqLyUm2ud82/xfmLfLIlngPEK++RG5E5zUb2dVmQ9tz1jghncQiLVj6TIh5mJoStiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290806; c=relaxed/simple;
	bh=g5EqDqcVKQDS1oS9SFtg5J6kqQ2KNNUrTEkE0jqPkD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul7vyTsutr/reaQ7XWYZrrAB28+WCHeqXjl3lZw7kyBptztiXYU+K2OLsx2z5quR8KwZkVe0oYi2RUT8BxMIuHEjw7AoFvjesyi5h/LBNT56DZQULLw1ItKP9+ZFx5oS35z1FuJv4/ERQbVsQpfvW+YEaHft2yWcSNgs6zpHMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qtZNdhVf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DZ8FDbzaT+M3Idya4+3fx9U6rjMp+YIIUq9dCdQm4KY=; b=qtZNdhVfjnaF7+96KAqAH3eLoQ
	w9kRS/7hEKF2zzFZBRPQNtMX9/5nhRK6wQUDEPB8fMD+zzInaRqL6rtEDxwKEgJRK5/jVLWC7OHhR
	Vjuei9JyGYh8HTa/nvcbTGiP0NBgjR+vurtpN62oP45SmY744n+b9g9lLmzhg0+59vxA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJeIe-00E1Zz-Lk; Mon, 26 May 2025 22:19:56 +0200
Date: Mon, 26 May 2025 22:19:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>

On Mon, May 26, 2025 at 09:34:19PM +0200, Ricard Bejarano wrote:
> Hey Andrew, thanks for chiming in.
> 
> > Do the interfaces provide statistics? ethtool -S. Where is the packet
> > loss happening?
> 
> root@blue:~# ethtool -S tb0
> no stats available
> root@blue:~# ip -s link show tb0
> 6: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master br0 state UP mode DEFAULT group default qlen 1000
>     link/ether 02:70:19:dc:92:96 brd ff:ff:ff:ff:ff:ff
>     RX:  bytes packets errors dropped  missed   mcast
>       11209729   71010      0       0       0       0
>     TX:  bytes packets errors dropped carrier collsns
>      624522843  268941      0       0       0       0
> root@blue:~#
> 
> root@red:~# ethtool -S tb0
> no stats available
> root@red:~# ip -s link show tb0
> 8: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master br0 state UP mode DEFAULT group default qlen 1000
>     link/ether 02:5f:d6:57:71:93 brd ff:ff:ff:ff:ff:ff
>     RX:  bytes packets errors dropped  missed   mcast
>      624522843  320623      0       0       0       0
>     TX:  bytes packets errors dropped carrier collsns
>       11209729   71007      0       0       0       0
> root@red:~#

There are three devices in your chain, so three sets of numbers would
be good.

What is also interesting is not the absolute numbers, but the
difference after sending a known amount of packets.

So take a snapshot of all the numbers. Do a UDP stream. Take another
snapshot of the numbers and then a subtractions. You can then see how
many packets got launched into the chain, how many made it to the end
of the first link, how many got sent into the second link and how many
made it to the end of the chain. That should give you an idea where
the packets are getting lost.

> This is the first time we're going beyond ~5Mbps in the blue->purple direction,
> meaning, there is something up with TCP.

Not really. TCP does not work well on lossy links. TCP considers
packet loss as congestion, it is sending too fast for the link. So it
slows down. If there is a lot of packet loss, it just runs slow.

What you need to do is find out where the packet loss happens. Then
why the packet loss happens.

What you also might find interesting is
https://github.com/nhorman/dropwatch.

	Andrew

