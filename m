Return-Path: <netdev+bounces-133095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28079994919
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382171C22592
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3F1DEFED;
	Tue,  8 Oct 2024 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y5JD+o2C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B51DEFC4;
	Tue,  8 Oct 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389972; cv=none; b=g9+A0mWeUZLWHXkqlhPH+xwEwmA7OaVUxNr9eMzssDP4A06ZosqriOz7iZuNiP7LQfeCNA/Gd9WTM/DhmIm/vJGB2ZVDaID6fR5QdhtL14nrjiDmE1qG8mM+EivvA2PsL+zswOTUdA6uhrdd3UsUORB2BuigCV2eK4qo1FBwaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389972; c=relaxed/simple;
	bh=Prmu2OR7B+Iu6vHbD5l8K/Vq3XxtgvywtBZ62/0SkK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3wRYQr2BzMwfaQpNZQUvItT5o8T+fu0VJqq4nXjmbjukDid2bn3nI/Zqjk9ZyCQknJurFubGZouEYrtwzzmc6bz7jZ0jU2Li5lLB+DbYY64ogheenyKVAmSybJyWUvpSOerpaxmiZPr70UjZiPEr9cfPbbINLE/KuG7uTyB+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y5JD+o2C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JiJmz6e1UljL0t9ycRv1qNhYpev/eyOeqgRK0hpHDNA=; b=Y5JD+o2CuIwNdaLpjsWW4feMxO
	NaL1P68ML3xta2lPAWYob2EuSOTBDxzSmTmTcvhmCIspyhifLGWQauIHrUIWTWv+xAXZqsoAJaLo3
	vvG6YSPKGAU8056rtUb+UkbgXFkr0zV8OUZPcG0A0U5uGH4VmQ4P+NbhGVHUSJi59jo4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sy9BM-009MpA-6j; Tue, 08 Oct 2024 14:19:16 +0200
Date: Tue, 8 Oct 2024 14:19:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: refuse cross-chip mirroring operations
Message-ID: <1abbbea3-0eb8-42c4-b4d5-c06c36676a4c@lunn.ch>
References: <20241008094320.3340980-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008094320.3340980-1-vladimir.oltean@nxp.com>

On Tue, Oct 08, 2024 at 12:43:20PM +0300, Vladimir Oltean wrote:
> In case of a tc mirred action from one switch to another, the behavior
> is not correct. We simply tell the source switch driver to program a
> mirroring entry towards mirror->to_local_port = to_dp->index, but it is
> not even guaranteed that the to_dp belongs to the same switch as dp.
> 
> For proper cross-chip support, we would need to go through the
> cross-chip notifier layer in switch.c, program the entry on cascade
> ports, and introduce new, explicit API for cross-chip mirroring, given
> that intermediary switches should have introspection into the DSA tags
> passed through the cascade port (and not just program a port mirror on
> the entire cascade port). None of that exists today.
> 
> Reject what is not implemented so that user space is not misled into
> thinking it works.
> 
> Fixes: f50f212749e8 ("net: dsa: Add plumbing for port mirroring")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

