Return-Path: <netdev+bounces-22471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FFF76795E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED6C282826
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F8389;
	Sat, 29 Jul 2023 00:07:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC4383
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A73C433C9;
	Sat, 29 Jul 2023 00:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690589260;
	bh=kbga49OdhCfacasA6BWUF7xsphpoiosmV5o/Y4DA840=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDiiVvi3nCMpNqR+VhRatpmtyqyEcMvELZWaLQE5ted9bK54bOvp4969Q0QJXKQwX
	 GQlsN0s6lzIwceYGud1PafFBbyY2QSEyZnD8c502lHgKDjh+tIk3RvnpvmdGnTF2H5
	 iHS9Gztj/HoSyhPkFGhdPOBQ4jDRhi/25kxHiJmhAqx3BQ9rzyu61VztWIniERmnYJ
	 tAZjvK7NJOsybmJoce6Et3xvOgBzbLzE9sLjP1egxLQe+/+XhCqhqTY/jBzzkopnw9
	 +VFrG9mo2gPR56OpYTVrBVUkTo5nO32IfDazuwc/1TiP3JL7XRIq+2elhwqTxTgKLI
	 Me5JbinU5Ilkg==
Date: Fri, 28 Jul 2023 17:07:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 sd@queasysnail.net
Subject: Re: [PATCH net-next v2 1/2] net: store netdevs in an xarray
Message-ID: <20230728170738.760006ae@kernel.org>
In-Reply-To: <20230728162350.2a6d4979@hermes.local>
References: <20230726185530.2247698-1-kuba@kernel.org>
	<20230726185530.2247698-2-kuba@kernel.org>
	<20230727130824.GA2652767@unreal>
	<20230727084519.7ec951dd@kernel.org>
	<20230728045304.GC2652767@unreal>
	<20230728082745.5869bc97@kernel.org>
	<20230728162350.2a6d4979@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 16:23:50 -0700 Stephen Hemminger wrote:
> > I think so, as in - the previous code doesn't have any checks either,
> > so it'd insert the negative ifindex into the hash table. Hopefully
> > nobody assigns negative values to dev->ifindex, that'd be a bug in
> > itself, I reckon.
> 
> Even inserting with ifindex = 0 would be a bug

... and that could actually happen if we allocate and the indexes 
have wrapped :S We need better limit. I'll send a fix.

