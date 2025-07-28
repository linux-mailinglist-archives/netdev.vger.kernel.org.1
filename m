Return-Path: <netdev+bounces-210514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E18B13B75
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E4516737E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67CB266565;
	Mon, 28 Jul 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VrR9kCVE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF3264FB5;
	Mon, 28 Jul 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709231; cv=none; b=D8SSvRZ3xnLQNQfv6ynuvGHCwUj66/NZfU1BBKI6+JY3t4S4421vJuInWPpwZ2ht2NRuaaoCr/eFcOJDbipViwoS10SjM1cBkxQEkur5cI8SOfUNc7qO8PenZbjmO8x1Tyw0wYfD8W5yWb1sM+8D0RSpsLwTYatbu0nSyhGhy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709231; c=relaxed/simple;
	bh=KnpOVuLTmoxEh/UdwCPbXWtITz8xrUN/fXAXPmfAYeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9+t1l+A5PoXoJxl0Qqqa41Fzun7jJ8LpHtk+i6kXe/PoC7MyngkfFUMEw3I9/ViwQ8vdra7etpupWk4naRjbRq/7g1AiIkve2hG2ZuNPhWbOFuuIH1p9p9iHzfTjF5/p8deJv5llpav5tnhruhy0+4Lc1vTdop9Oc5eIFXcv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VrR9kCVE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RwK1KXVV9DfcATRhcZwiQsKsRwhCv003V4YhKjirnLo=; b=VrR9kCVEPI9teFRbKMwKz6V1xM
	zjZO71Ly5imGqMDfptEjiKSxKeSM1nmZMSaUzxakm3IG3vLugrnSWpp63wutky7J1fkhkiF6Kf+bT
	VvP8IxAnil/Mxuvn6tc3vXSmTjgSAkjBdiRx6ZTRhJQiY/5kESLyUkwrswG5kM1/doTc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugNsY-0035jj-7R; Mon, 28 Jul 2025 15:26:58 +0200
Date: Mon, 28 Jul 2025 15:26:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: syzbot+8182574047912f805d59@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com, jiri@resnulli.us,
	andrew+netdev@lunn.ch
Subject: Re: [RFC PATCH] net: team: switch to spinlock in team_change_rx_flags
Message-ID: <df06dba7-f5bd-4ee1-b9af-c5dd4b5d4434@lunn.ch>
References: <68712acf.a00a0220.26a83e.0051.GAE@google.com>
 <20250727180921.360-1-ujwal.kundur@gmail.com>
 <e89ca1c2-abb6-4030-9c52-f64c1ca15bf6@lunn.ch>
 <CALkFLL+qhX94cQfFhm7JFLE5s2JtEcgZnf_kfsaaE091xyzNvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkFLL+qhX94cQfFhm7JFLE5s2JtEcgZnf_kfsaaE091xyzNvw@mail.gmail.com>

On Mon, Jul 28, 2025 at 10:55:13AM +0530, Ujwal Kundur wrote:
> > Did not compile this change? I doubt you did, or you would of get warnings, maybe errors.
> 
> Ah sorry, I shouldn't have relied on static analysis -- clangd did not
> complain so I did not wait for the compilation to succeed.
> 
> > And what about all the other users of team->lock?
> 
> I see the mutex is defined in `struct team` and cannot be changed as
> I've proposed here. Would switching to a spinlock across the board
> degrade performance?

Sorry, team is not my area of expertise. 

> >From what I understand, the NDO for ndo_change_rx_flags doesn't seem
> to disable BHs unlike ndo_set_rx_mode [1][2] so this seems to occur
> only when a new unicast address is being added via dev_uc_add [3]
> (which does disable BHs).
> Comparing other operations that use mutex_lock / mutex_unlock, looks
> like a few of them do not have RCU protection for their NDOs requiring
> lock / unlock pairs in the code, but none of them disable BHs (AFAICT)
> apart from the operations dealing with unicast / multicast addressing.
> If this is indeed the case, perhaps we can use a dedicated spinlock
> for team_change_rx_flags? Or switch back to rcu_read_lock as I believe
> it's being used in team_set_rx_mode [4] for precisely this reason. To
> be honest, I do not understand the intent behind this change as
> mentioned in 6b1d3c5f675cc794a015138b115afff172fb4c58.

I'm guessing, but is this about passing ndo_set_rx_mode from the upper
device down to the lower devices? Maybe look at how this is
implemented for other stacked devices. A VLAN interface on a base
interface for example? A bridge interface on top of an interface.

	Andrew

