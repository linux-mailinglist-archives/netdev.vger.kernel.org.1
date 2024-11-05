Return-Path: <netdev+bounces-141778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 510EC9BC38E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0789B216F9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740153365;
	Tue,  5 Nov 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGvKuaTB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124B2A1CA
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775972; cv=none; b=C415lVC4Tm9IIL0Be+DxvnzkrlGE4Ab8w00kmkgFW4EcLOlXbzHc/cQyVPhRXI8QZB5Lyx+xulot8CGGkFKzkuTwZl5ENNz9/2ltW2S/tOF7xYa7j9J3H+fWp1R/qVwzLH25AALTvjnvYSlv5U+wz5Oml0pPcsneSAG+InfFUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775972; c=relaxed/simple;
	bh=IwVwwcT7penUTVRjdcAshziuwkH/Qw3PEYD8J4PgxOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iq8ykBeELFZgApyMfnBMjEvRO86sW8H3HqPz2PuN/YjyjijSgIMfEDFcSkdZTujsdyjNjrehMhKHzNnv+DA72vZ5BA3ZvMVWkn0ZINvq6bRCTVzVyPrN2J4ruN9KWXSiszGoxBFioqR9hqBg5SJtzPXV7t5WHkZUA5cuPCrYpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGvKuaTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B148BC4CECE;
	Tue,  5 Nov 2024 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730775972;
	bh=IwVwwcT7penUTVRjdcAshziuwkH/Qw3PEYD8J4PgxOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gGvKuaTBEfgUoZAHHvHQjZjyz5kVfIjcyVALMrHLwQ1tOsElODRqweGZJUJtDjmsE
	 gaQUyQeZxcBH+P6azAg6TD4T+AZlQqdGR+fIW+ztCvuYxYapzXsp49zMM6Ek4aDZIz
	 NhG51AtLRawbNlvEpb2e6uN69VqPPuowPkRI7cbupBiCDRuy+8s8YKPCQdGgv0LW4x
	 1thnqcZD6/OQNRSFen7mIMR/LBBtRasLzBFVUEW0i5RBUnmV/hR5++dU0Tzop7REnx
	 +WQrmVnSPpJwiK2NnAlUweaOSQXR0b0R6MElqH7ocffMQ9SIpME2C5bmcZjh6t+7ho
	 LQkgb7TqCzjaw==
Date: Mon, 4 Nov 2024 19:06:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
 <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Andy
 Roulin" <aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/8] net: Shift responsibility for FDB
 notifications to drivers
Message-ID: <20241104190610.391b784a@kernel.org>
In-Reply-To: <87ldxzky77.fsf@nvidia.com>
References: <cover.1729786087.git.petrm@nvidia.com>
	<20241029121807.1a00ae7d@kernel.org>
	<87ldxzky77.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 12:43:11 +0100 Petr Machata wrote:
> > On Thu, 24 Oct 2024 18:57:35 +0200 Petr Machata wrote:  
> >> Besides this approach, we considered just passing a boolean back from the
> >> driver, which would indicate whether the notification was done. But the
> >> approach presented here seems cleaner.  
> >
> > Oops, I missed the v2, same question:
> >
> >   What about adding a bit to the ops struct to indicate that 
> >   the driver will generate the notification? Seems smaller in 
> >   terms of LoC and shifts the responsibility of doing extra
> >   work towards more complex users.
> >
> > https://lore.kernel.org/all/20241029121619.1a710601@kernel.org/  
> 
> Sorry for only responding now, I was out of office last week.
> 
> The reason I went with outright responsibility shift is that the
> alternatives are more complex.
> 
> For the flag in particular, first there's no place to set the flag
> currently, we'd need a field in struct net_device_ops. But mainly, then
> you have a code that needs to corrently handle both states of the flag,
> and new-style drivers need to remember to set the flag, which is done in
> a different place from the fdb_add/del themselves. It might be fewer
> LOCs, but it's a harder to understand system.
> 
> Responsibility shift is easy. "Thou shalt notify." Done, easy to
> understand, easy to document. When cut'n'pasting, you won't miss it.

Makes sense for real proto drivers, but we also need to touch 4
Ethernet drivers. While we can trust proto drivers to do the right
thing, HW driver devs on average are average. And I can't think of
another case where driver would send netlink notifications directly.

> Let me know what you think.

Mild preference towards keeping the expectations from HW drivers as low
as possible. But I don't feel strongly. Let me revive the series in PW
so it is top of the list for Paolo tomorrow.. :)

