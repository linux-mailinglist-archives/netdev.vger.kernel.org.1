Return-Path: <netdev+bounces-103652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5E908EA2
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBA31C20AC8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A516D332;
	Fri, 14 Jun 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeFf45bd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7654962D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378632; cv=none; b=p4k0hciM3hwnmgXMfW4ojWC25sCqfsy2j+yk035D2p8AuRXhTJoV7W8aufGjGfJB3ULGaLHecuMBvOlAi1yEByu2zPkxO7CnxHg/5M4DJcquZ719P+Ww+LuNucZ4eLjsmsBQYtsDtYAZnveMmBnliZNXV1kuCGxz9zeCkt5Ra3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378632; c=relaxed/simple;
	bh=DUQr91y9Dt2Oj5Jod0E091p2jOz6JawjaskCfoS9wnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6wV4O9dCsMO4wtZUB4EZiMHyd2LK0kc7EpAIoK2pZUE8OO4qyE8tDeet6mkJFtLuTnKJBWWbxdSXG5/wd0lmoOT1268vG8Yesg0B3SZSiuLgUf4PBqKEsahAryB2mrHV6fG8cUA2Pc7ocpj9YhjlSKT+1E8JKvM3Gx6R7zwgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeFf45bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28701C2BD10;
	Fri, 14 Jun 2024 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718378632;
	bh=DUQr91y9Dt2Oj5Jod0E091p2jOz6JawjaskCfoS9wnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aeFf45bdud0O/Kc9wftYe8AqZSLkVb00nsMDGILHICsrmycJFpH61Hx9IvAX+PVJO
	 ZJXqoUhdNQELoHCCBmD3Cxj6KiNe3HgI6HF7v4jO8pjY7Ker8pUBlb6q4F9vTXBXhD
	 MA79IHGyS/jQIRjnnRHh+4iEheAtAVgSxcGmYrKB7+MMmxnCmd5V2aPQZAjBM43CCs
	 mHgbTKDywSIdGjnPbjKD4m7RXEdXsA8lEZZ7W6Iy/BiY18zGEQ6FfbasXPbKrNOpRr
	 ltABeOQ9/VEy341SYu68CRyK22bQ3/61yqRpf21qca0HOINfP8OAeAvdnQMEx1WrDE
	 0NARInMf6lfFA==
Date: Fri, 14 Jun 2024 08:23:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
Message-ID: <20240614082351.7fc8d66c@kernel.org>
In-Reply-To: <20240614.114152.1787364292761357690.fujita.tomonori@gmail.com>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
	<20240611045217.78529-5-fujita.tomonori@gmail.com>
	<20240613174808.67eb994c@kernel.org>
	<20240614.114152.1787364292761357690.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 11:41:52 +0900 (JST) FUJITA Tomonori wrote:
> >> +static void tn40_get_stats(struct net_device *ndev,
> >> +			   struct rtnl_link_stats64 *stats)
> >> +{
> >> +	struct tn40_priv *priv = netdev_priv(ndev);
> >> +
> >> +	netdev_stats_to_stats64(stats, &priv->net_stats);  
> > 
> > You should hold the stats in driver priv, probably:
> > 
> > from struct net_device:
> > 
> > 	struct net_device_stats	stats; /* not used by modern drivers */
> >  
> 
> Currently, net_device_stats struct is in tn40_priv struct. You meant
> the driver shouldn't use net_device_stats struct?

Oh, I misread, I just saw netdev_stats_to_stats64( and didn't read
further. Doesn't look like you're using any of the magic properties
of struct net_device_stats, so yes, just replace it with struct
rtnl_link_stats64 in the priv, and with minor adjustments that should be it.

> Note that some TX40xx chips support HW statistics. Seems that my NIC
> supports the feature so I plan to send a patch for that after the
> initial driver is merged.

Sounds like a good plan :)

