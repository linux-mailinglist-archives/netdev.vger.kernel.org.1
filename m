Return-Path: <netdev+bounces-134845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A999B4FE
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74ED61F22D8E
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7E1714B7;
	Sat, 12 Oct 2024 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGoHELhe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85421F5FA;
	Sat, 12 Oct 2024 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728737955; cv=none; b=Hl8MN+PyVx/zy4Qd61kfpyIk4Lg359nF1dm5XPlIAqUbyjBV0fl3lams6r/w+Ug4tRKnv8ZHHnS+tNGRbdd15SMyVNdYvtfJmUz+wrMmeEqzzRra6bHE9U/G1c2gXOK+gaG+58qhdvHB90kJw3D/ZMc9Hct2E5ftzslQH1jxLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728737955; c=relaxed/simple;
	bh=DZStcdS7n+z5tKJSApCjAhG+OeXNP7JddySHFlPgmaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvjwvqAsM1WvxywCkHm8ej3w+cHrxGXnelko+ZpGW/ksTzs8rUpfOhYanPoO8ApPNkKjOSAGVk3hO3t3m3vLevwVf/xAw9JSRRr8zFJm/DKNFmFZmdeZj5eoLT6JFC5rIZCydayeB1xFC1wGBoLhVOoL71tyuGsU0vMvN9jp24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGoHELhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDECC4CEC6;
	Sat, 12 Oct 2024 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728737955;
	bh=DZStcdS7n+z5tKJSApCjAhG+OeXNP7JddySHFlPgmaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGoHELhekbgdSG7h9nhcERjJO/+fAqpJUuajNc0ZZVGXOWNxoxAhVunSkTO2BEunw
	 sOW7wcRr4XKKlgutvqu6+r+fnY4m9G74o46E3sCrzZmAvksdLfgkFue4TSZj5tTBde
	 v9fsdDzJx93dK90jBWomGiW7CACfg5ERKJamhIuNFmzaY8BHCBwasjS3In3E8xOBHn
	 QoKEIT3SVfwQdXDWDE7gAcyjC+4G/ouH3GvC6uIMFT4Mwaa5rIe/Nw+8upY/5hj786
	 XjWFzYV7VZO33cby1NunTeU02i9UMSDmy38HysZGUCDeqyOyrLxdckIlM9O/ahLCh8
	 XdhNT6otp2TKA==
Date: Sat, 12 Oct 2024 13:59:10 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 net-next 2/7] net: ibm: emac: remove custom init/exit
 functions
Message-ID: <20241012125910.GD77519@kernel.org>
References: <20241011195622.6349-1-rosenp@gmail.com>
 <20241011195622.6349-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195622.6349-3-rosenp@gmail.com>

On Fri, Oct 11, 2024 at 12:56:17PM -0700, Rosen Penev wrote:
> c092d0be38f4f754cdbdc76dc6df628ca48ac0eb introduced EPROBE_DEFER

The preferred way to cite commits in patch descriptions is like this:

commit c092d0be38f4 ("net: ibm: emac: remove all waiting code")

Something like this in gitconfig can be helpful.

[core]
	abbrev = 12
[pretty]
	quote = commit %h (\"%s\")
[alias]
	quote = log -1 --pretty=quote

Then the following should work:

$ git quote c092d0be38f4f754cdbdc76dc6df628ca48ac0eb
commit 71eb7f699755 ("net: ibm: emac: use netif_receive_skb_list")

> support. Because of that, we can defer initialization until all modules
> are ready instead of handling it explicitly with custom init/exit
> functions.
> 
> As a consequence of removing explicit module initialization and
> deferring probe until everything is ready, there's no need for custom
> init and exit functions.
> 
> There are now module_init and module_exit calls but no real change in
> functionality as these init and exit functions are no longer directly
> called by core.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Otherwise, LGTM.

