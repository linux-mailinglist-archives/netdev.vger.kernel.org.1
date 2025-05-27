Return-Path: <netdev+bounces-193643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF68BAC4EE8
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7A33A85F7
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459025B67D;
	Tue, 27 May 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZV6J6sL+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5EC2ED
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350301; cv=none; b=QlvPMaWEteSyMh2WmAhIozl4lPPfpUsNZulbv3xW1N9744nukOgRI41T3dsXrooXvM1uMZJ4nE5cPS+LAhoLr5pfESyhGIrlyts7VO/MTak81QibSLc08O2z0qgLiQMK+Kiyf+GYL5lGZ9Mnek2rRMLXI36UofxKQG9s8x0c/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350301; c=relaxed/simple;
	bh=3cU+dY0wVq4aj/o20gjFrN7S9DaDhmMGo7hP4cjZvPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMptB1vwRIvuzXcyNKy9Mjl+jWREHy6IwJ0g7RLKdIg9/sgtHedderMFWdPsji6rLt+eVXr1mdcZLcPH5gBhK6d+sgGWhFdKr+yCidqvR5LuFXem2Rspmhb19yIe1cWJDNLKcChynlijql3M0Gg+ihFF0/8vwrWC/rIiP4ULV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZV6J6sL+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6LClWmzPGP6R51f0eFDPpf34+b052ldRdb+oa5TATqU=; b=ZV6J6sL+e8j+CxulpG5MKHoW72
	SunHsrbmgTgQIJfOSu/DPVSgs14ffY35JeUoVKj0FTUEXnG4Enbn7L13GHI+7mVH63St3IQS4nvKC
	kevyml1rlePwPREXxr1wFLkU9/xUpFx/VvZPBdluuwDr/JpGjHjly01Ef5JWW9lvATdg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJtmD-00E4lA-DQ; Tue, 27 May 2025 14:51:29 +0200
Date: Tue, 27 May 2025 14:51:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
References: <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>

> root@red:~# iperf3 -c 10.0.0.2 -u -b 1100M -t 5  # blue
> Connecting to host 10.0.0.2, port 5201
> [  5] local 10.0.0.1 port 46140 connected to 10.0.0.2 port 5201
> [ ID] Interval           Transfer     Bitrate         Total Datagrams
> [  5]   0.00-1.00   sec   131 MBytes  1.10 Gbits/sec  94897
> [  5]   1.00-2.00   sec   131 MBytes  1.10 Gbits/sec  94959
> [  5]   2.00-3.00   sec   131 MBytes  1.10 Gbits/sec  94959
> [  5]   3.00-4.00   sec   131 MBytes  1.10 Gbits/sec  94959
> [  5]   4.00-5.00   sec   131 MBytes  1.10 Gbits/sec  94951
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
> [  5]   0.00-5.00   sec   656 MBytes  1.10 Gbits/sec  0.000 ms  0/474725 (0%)  sender
> [  5]   0.00-5.00   sec   597 MBytes  1.00 Gbits/sec  0.004 ms  42402/474725 (8.9%)  receiver
> root@red:~#
> 
> Here are the stat diffs for each interface:
> 
> 1) red's br0 (10.0.0.1)
>     RX:    bytes  packets errors dropped  missed   mcast
>            +1055      +14      -       -       -       -
>     TX:    bytes  packets errors dropped carrier collsns
>       +707341722  +474740      -       -       -       -
> 
> 2) red's tb0
>     RX:    bytes  packets errors dropped  missed   mcast
>            +1251      +14      -       -       -       -
>     TX:    bytes  packets errors dropped carrier collsns
>       +707341722  +474740      -       -       -       -
> 
> 3) blue's tb0
>     RX:    bytes  packets errors dropped  missed   mcast
>       +707028822  +474530     +5       -       -       -
>     TX:    bytes  packets errors dropped carrier collsns
>            +1251      +14      -       -       -       -
> 
> 4) blue's br0 (10.0.0.2)
>     RX:    bytes  packets errors dropped  missed   mcast
>       +700385402  +474530      -       -       -       -
>     TX:    bytes  packets errors dropped carrier collsns
>            +1251      +14      -       -       -       -
> 
> So, if I'm reading this right, loss happens at blue tb0 RX.
> We have 5 errors there and lost 210 packets.
> 
> Also, why does iperf3 report 42402 lost packets, though?

210 lost is probably not enough to cause the TCP issue. The difference
between 210 and 42402 probably means the loss is happening higher up
the stack. But the majority are reaching blue, and then getting
dropped. So maybe look at IP and UDP statistics, are the packets
corrupt, failing CRC errors? netstat(1) and ss(1) will help you.

Another thing to try is run tcpdump on blue can capture some of the
packets to a file. Feed the file to wireshark. Unlike tcpdump,
wireshark checks all the CRCs and will tell you if they are wrong.

	Andrew

