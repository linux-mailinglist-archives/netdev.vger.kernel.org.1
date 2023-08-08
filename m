Return-Path: <netdev+bounces-25277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE28773A4F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87AC2817D4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F511181;
	Tue,  8 Aug 2023 13:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BD107B0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 13:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A2C433C7;
	Tue,  8 Aug 2023 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691499615;
	bh=9adJ+qtIOIy3KtEkatfZhz5gevID4T+P74hC7Kqi6Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbFezovZwuCfYCNVraKSH/2qUJSaCH36FBAW0tGpi9tn3Ka5AXPPpiGIlvsb2Ky1p
	 7yyZiq+mjTENgDMTaq5/cu0YjocBtQ/CXhT8f4JPp4ezPN+MtqG56o+isefGjUaGER
	 0YAxT2QNFa5U2v/Z5FwebVQHib+eXRtgew7eiHtOuKpoRZrOJA9vcu+m87DmLsuSVk
	 QMeOui8yzkR7WNrtx5k7oOYNC7A7HlRvggH9PX6wWAyWkmrFJtFZF8H+Z/Rb1ORA1g
	 84XZkAEp4KPoO2nPhCChGayR0iQFPKSWT0NP7s54YMAM4nvpMAIPB2ekM1ouPtZUE+
	 jePWMmV/6P2Ng==
Date: Tue, 8 Aug 2023 15:00:11 +0200
From: Simon Horman <horms@kernel.org>
To: David Rheinsberg <david@readahead.eu>
Cc: netdev@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Stanislav Fomichev <sdf@google.com>,
	Luca Boccassi <bluca@debian.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] net/unix: use consistent error code in SO_PEERPIDFD
Message-ID: <ZNI8W78I3FxvT333@vergenet.net>
References: <20230807081225.816199-1-david@readahead.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807081225.816199-1-david@readahead.eu>

On Mon, Aug 07, 2023 at 10:12:25AM +0200, David Rheinsberg wrote:
> Change the new (unreleased) SO_PEERPIDFD sockopt to return ENODATA
> rather than ESRCH if a socket type does not support remote peer-PID
> queries.
> 
> Currently, SO_PEERPIDFD returns ESRCH when the socket in question is
> not an AF_UNIX socket. This is quite unexpected, given that one would
> assume ESRCH means the peer process already exited and thus cannot be
> found. However, in that case the sockopt actually returns EINVAL (via
> pidfd_prepare()). This is rather inconsistent with other syscalls, which
> usually return ESRCH if a given PID refers to a non-existant process.
> 
> This changes SO_PEERPIDFD to return ENODATA instead. This is also what
> SO_PEERGROUPS returns, and thus keeps a consistent behavior across
> sockopts.
> 
> Note that this code is returned in 2 cases: First, if the socket type is
> not AF_UNIX, and secondly if the socket was not yet connected. In both
> cases ENODATA seems suitable.
> 
> Signed-off-by: David Rheinsberg <david@readahead.eu>
> ---
> Hi!
> 
> The SO_PEERPIDFD sockopt has been queued for 6.5, so hopefully we can
> get that in before the release?
> 
> Thanks
> David

As a fix, it should probably have a fixes tag.
This one seems appropriate.

Fixes: 7b26952a91cf ("net: core: add getsockopt SO_PEERPIDFD")

And the patch should be targeted at net

	Subject: [PATCH net] ...

It's probably not necessary to repost just to address these minor points.
But please consider them if you need to post a v2 for some other reason.

