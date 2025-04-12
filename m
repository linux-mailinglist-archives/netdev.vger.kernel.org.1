Return-Path: <netdev+bounces-181858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 366B2A86A1D
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 03:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A897AA85D
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0306F4ED;
	Sat, 12 Apr 2025 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWvmFUIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805E4A0C;
	Sat, 12 Apr 2025 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744421534; cv=none; b=OgrliwcnzP7UTlKzrzf1XwNUT3GKXM+uhjsRGJ3OOo3zTBWgxP9WT4n5JMs8veEQ4tmOUQ1B/lmuF/f8lIWf9PgUdqMXjlpdrD/wv5xMB4MluQ0zy3aYzHvIbZ//V4uwoNrtSHrwvU1clrt5kyXIHKbvi0GbZyF6vunOvcBwT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744421534; c=relaxed/simple;
	bh=O+KwZdkujNvzxCORrfTfkbjJm+iKBPW7dMUVSOqhsus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QucO2S8K+9Sfsqp56n+bwR4WaAFmg1a9ZHB161gJUErrCjHoNFNKO0XfV06v0knAFPfyoZr6ezzmgpNJF+SncmtA/WIa527E0NE71dxTcWa7/mvr5pk2bwRukTUTgmL4MI1d9JjXsYyV6Z53utOYb0hMH0+9GAgkUvz6FPTxWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWvmFUIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D054CC4CEE2;
	Sat, 12 Apr 2025 01:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744421534;
	bh=O+KwZdkujNvzxCORrfTfkbjJm+iKBPW7dMUVSOqhsus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWvmFUIpYcpVhaWlsEilexPSUUlsrwhQqqtJQOZTFygMPUNg+5o+8VJFM9We1SVIK
	 MWamkAXzJt2t1CiufpM7KXkScefV/R8RUtT9rhfRwk+Zr2/vmhzVKO1hgiB6MFqRgk
	 86Y5/x5PPVSD5prAI3d5n5K0b8nmzPkrrirNRKShOqMAG7+PzZWgca1DvjTbbIwzDJ
	 UKnRAPKcMVYxnH7rYw1Gk3dmte87NmJIOcM5dNLsZS8frnbb3VuTPeHEWktDszcdnq
	 vpmkQHk8r04FYfs9ABcnsuSu8FfvjruBfMVwYsVlJrU7R1tGqLqbgmdYc3261vtm0S
	 tBs/3U/R1J02A==
Date: Fri, 11 Apr 2025 18:32:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Edward Cree <ecree.xilinx@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Paolo Abeni <pabeni@redhat.com>,
 Sai Krishna <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: ngbe: fix memory leak in ngbe_probe()
 error path
Message-ID: <20250411183212.51b084af@kernel.org>
In-Reply-To: <pok6kit3b7c7sv34mpvmzulycblqys3ntdrz7oyeofxhtfcht6@xa7iihddqrf5>
References: <20250409053804.47855-1-abdun.nihaal@gmail.com>
	<7ff3877b-1a76-45a1-ad03-922582679397@web.de>
	<pok6kit3b7c7sv34mpvmzulycblqys3ntdrz7oyeofxhtfcht6@xa7iihddqrf5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 10:44:55 +0530 Abdun Nihaal wrote:
> Hello Markus,
>=20
> On Wed, Apr 09, 2025 at 05:23:39PM +0200, Markus Elfring wrote:
> > How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D an=
d =E2=80=9CCc=E2=80=9D) accordingly?
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc1#n145 =20
>=20
> Thanks for pointing that out. Actually I wasn't sure about which commit
> to add as the Fixes tag, so I left it assuming that the maintainers
> would know better.
>=20
> I was confused between the following two commits both of which change
> the kfree(wx->mac_table) line.
> - 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")
> - 9607a3e62645 ("net: wangxun: Rename private structure in libwx")

I think:

Fixes: 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")

rss_key gets allocated at that point but never freed. The later patches
just move it around and fix up a little but first broken patch counts.

