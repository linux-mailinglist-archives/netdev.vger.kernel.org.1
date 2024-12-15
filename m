Return-Path: <netdev+bounces-151990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 704289F24A7
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 16:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5828165013
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D4A17C220;
	Sun, 15 Dec 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vAxLh7Bw"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346B174EE4
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276863; cv=none; b=sQSQVguFrcWz5xAGYJOWKtu+ww76IOFrkIEH/P3VJe5d/upSETddlJ8MLJWRww1uLEt1YmhKg9v1bWFULosKzQtNExsfqDIZADt4YLQrGocd4c4SHzhbhxHNPo3+zDcnLYPA3SGUWSVqx4eNk+0QRL6lkx/zo6yUftR+DMUm9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276863; c=relaxed/simple;
	bh=OKfd6CtJIYDfMWlhgRElCSOa0hMpY+sn9PGUNMgkQzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4HAnv8YYQk8zHC2+3zFmI/nexaHglLDLzGfn3BR1MCy+3L8v7KTe5eWm3lYjvMdCcwGoKtrrRDqsm1t5KwnjpxgbqFseTcj+C7E5fceQExKv96NRA91KI34ncEV1m4XBCP1DPYpTJN39JjCksNMtN5xls4ujmF1bCQCYiHUt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vAxLh7Bw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91CB6254011D;
	Sun, 15 Dec 2024 10:34:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 15 Dec 2024 10:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734276860; x=1734363260; bh=MXl70iU2fbQ2dIjNrK4HF8rlkt406YgBqo4
	fmTwU7vo=; b=vAxLh7BwHEE/d7rKzeMFGNA5lb7SZhx/s2BLb/QHVswBKBuZ9dt
	kJ9hazd6KKQhED96hypOvbKdpOg+Okx4GCFAmBpUv4eCtyLP9ODdBvT5XPOVYRFM
	G3+MxHRtOw+FNz6MpAKxqZfZHjNQt56YUc9Y1uagFfDc0K2WVxSfIo/3OissT/og
	LWeCKVRIoOtsjgY7exXpJtf44rm8PGnDX/KnBXLLkyVOiFAPC+j39nq13taxbHQC
	9H1qBqZ/4cM38JYAriciU/vBbB9RqlfG4OBtfgclOM5TAPWRUEfBh8/ElShD4fmI
	Ox+cCLrHVL+xy7T6epnXpCfDJzcs+hOuE+w==
X-ME-Sender: <xms:-_ZeZyOIBqhfl98tKgAoL0OiuXqs7hy-YRgFG7dExMPdxpfCKgJ38g>
    <xme:-_ZeZw-FUYufpzMjJMi1P3FX0HnjLZ8pM8A1-z8noW-08Jsm9YKARcqlwKe6VWQ28
    0XB2FdNWqc6jwg>
X-ME-Received: <xmr:-_ZeZ5R5dTJS4po3YHQpJ3S66SuKGdRzr_4e5albOsXONxVYBBHNWaiY65Qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihih
    uhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepvghrihgtrdguuhhmrgiivghtsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:-_ZeZysok7jJNTo1uwY6N5Y_XFR9HCTx6OwXlpTd1u1VMQ9aKJrPyQ>
    <xmx:-_ZeZ6eAplrUh5PQXRcipSc0ihgvbP-OJ_KglC3gxlS-hDqzUbfmGg>
    <xmx:-_ZeZ21tVR0QOP2_KdsZiPrdLgTWPvBdR3uDowjkv5zcOGBcuwU8XQ>
    <xmx:-_ZeZ-8WyRYjY6x6k05H-Pq6yevi20-eQz2TIHlw-XJ0Mq8GO5xJ4Q>
    <xmx:_PZeZxzvhYmIy-ypmvEy8YdjTiOv7kMOqpyrgRSYaS2zxkTCntqWCESS>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 10:34:19 -0500 (EST)
Date: Sun, 15 Dec 2024 17:34:17 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/4] inetpeer: update inetpeer timestamp in
 inet_getpeer()
Message-ID: <Z172-TL96Dy0d95d@shredder>
References: <20241213130212.1783302-1-edumazet@google.com>
 <20241213130212.1783302-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213130212.1783302-4-edumazet@google.com>

On Fri, Dec 13, 2024 at 01:02:11PM +0000, Eric Dumazet wrote:
> inet_putpeer() will be removed in the following patch,
> because we will no longer use refcounts.
> 
> Update inetpeer timetamp (p->dtime) at lookup time.

Given you're planning a v2: s/timetamp/timestamp/

