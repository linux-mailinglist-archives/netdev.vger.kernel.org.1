Return-Path: <netdev+bounces-66825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555C3840CB0
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A40428CE55
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F8F157046;
	Mon, 29 Jan 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDjl4nHY"
X-Original-To: netdev@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEB2157036;
	Mon, 29 Jan 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547655; cv=none; b=KfQcKDEbcpWCwLjMbkjmNS7zcExomZ5+w0QoxqG+xYpCg2Ih4YxFYzdxSC99ZHp0zSUKqRqsxheGbSSi4OLq6cL9obkZ3sQUt+MrYfgiv+BeJnnYcrNYOiUlL/UXGi664is9bX90aZueu7cMLsoTbvKzQYCv1elIcYzzUZmVNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547655; c=relaxed/simple;
	bh=7JYEai2Vsq4gvVHmUJukqXtYqxWaNxu6aKcd5o2EzPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz+pxhY8ZrJ1KlZzk5c8YKH76CYz8ohRDgjz7pI0dsKR2PMBoOz2MzglggKDy2VO1ATgD1vkuDinjjUMqXLrWXXPLuof7jo0E+p5ixcMYtFnu64BG6xHCXc4I5AYdesefMuOOuWd1eBSRvFLIMyIbub8uUvShNEVQBbgrKSPf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDjl4nHY; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 747915C0161;
	Mon, 29 Jan 2024 12:00:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 12:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706547652; x=1706634052; bh=6Ia2NjlYKOPOjqDPHkCr3xIGYPP+
	QvYk9mYKIaIV6VI=; b=WDjl4nHYc6qwpeUY/TvHu1DZLa1DipeZSPtGb0JITPNC
	6EpXU/1gqCi0SNVHHog0imw9v/23E1uGBxdd/lF+CHvw33ijMUyGTsC0+M/Djof4
	kv5uqZ9ITsgeAjijuLdEXisU/HU8bj2ctkBJA4FBvo9AD8tUU87fgm4Lk2qsEGIq
	Ih0eFmhMovLmZTg4zEJ/w4R3xsosn0gp4dAGk2gcri01sqn2GOyAWdwqztYGNIch
	QdJspnL4LoPmEGBfuugjHwZ01iNZIPra6Qzg2YrCDy1vOUnptre595RgwA+1aCRH
	oURUdsF+7EvgyWm2HHAAumVHWwijM8JqWBePFdp0xA==
X-ME-Sender: <xms:xNm3ZbwybD7POPzE_nsvnBkBq7h6ws3eYabTbEVENgFVFqRLqDhEQg>
    <xme:xNm3ZTSe7N6aQRt-NAN5Vxd2VbjyDv8j0UGAkPKv27fQLNV9zPB2K5xSrFArBUbbR
    leE6Zb0qlKNrLc>
X-ME-Received: <xmr:xNm3ZVVsMmjyzBZYWyqj4OWVEu5ygaBku85d1Y67RzThG9Zt8E-PDBe3qa2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ortddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpefhgeejieeftdehheefheethfevue
    dvleevuedtgeeuiefgvedvudeilefftefftdenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgpdhrvghmlhgrsgdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:xNm3ZVjqC4R4j3Oleu4x-s61sATqx_UJBiAQYThCMIEcvCj9G5b1bg>
    <xmx:xNm3ZdCbAYNY0HyOu8mzVtndQdwcPirUkBjkoLWOnaxMEc46PcLt0Q>
    <xmx:xNm3ZeLTUr5haSVfFo7Zeh41VhBOdL2gsRRMqNDI8iuVSOoXjfbsVA>
    <xmx:xNm3ZQrfXltkjxKhmjzXDSLZq03fJrftKMmjm8diS3xwY8-057quIw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 12:00:51 -0500 (EST)
Date: Mon, 29 Jan 2024 19:00:49 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <ZbfZwZrqdBieYvPi@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
 <ZbedgjUqh8cGGcs3@shredder>
 <ZbeeKFke4bQ_NCFd@shredder>
 <20240129070057.62d3f18d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129070057.62d3f18d@kernel.org>

On Mon, Jan 29, 2024 at 07:00:57AM -0800, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 14:46:32 +0200 Ido Schimmel wrote:
> > On Mon, Jan 29, 2024 at 02:43:49PM +0200, Ido Schimmel wrote:
> > > On Mon, Jan 22, 2024 at 09:16:12AM -0800, Jakub Kicinski wrote:  
> > > > If you authored any net or drivers/net selftests, please look around
> > > > and see if they are passing. If not - send patches or LMK what I need
> > > > to do to make them pass on the runner.. Make sure to scroll down to 
> > > > the "Not reporting to patchwork" section.  
> > 
> > Forgot to mention: Thanks a lot for setting this up!
> 
> Finger crossed that it ends up being useful :)
> 
> > > selftests-net/test-bridge-neigh-suppress-sh should be fixed by:
> > > 
> > > dnf install ndisc6
> > > 
> > > selftests-net/test-bridge-backup-port-sh should be fixed by:
> > > 
> > > https://lore.kernel.org/netdev/20240129123703.1857843-1-idosch@nvidia.com/
> > > 
> > > selftests-net/drop-monitor-tests-sh should be fixed by:
> > > 
> > > dnf install dropwatch  
> 
> Installed both (from source) just in time for the
> net-next-2024-01-29--15-00 run.. let's see.

Thanks!

The last two tests look good now, but the first still fails. Can you
share the ndisc6 version information? I tested with [1] from [2].

If your copy of ndisc6 indeed works, then I might be missing some
sysctl. I will be AFK tomorrow so I will look into it later this week.

[1]
$ ./ndisc6 --version
ndisc6: IPv6 Neighbor/Router Discovery userland tool 1.0.8 ($Rev$)
 built Jan 29 2024 on <redacted>
Configured with: ./configure 
Written by Remi Denis-Courmont

Copyright (C) 2004-2007 Remi Denis-Courmont
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.

[2] https://git.remlab.net/gitweb/?p=ndisc6.git

