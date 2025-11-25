Return-Path: <netdev+bounces-241376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C1C8337E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6583C4E31F3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE221FF5F;
	Tue, 25 Nov 2025 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LndKsMZW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1833EC;
	Tue, 25 Nov 2025 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041152; cv=none; b=aAbhNAsqvenId2oWh8YWkKbsaxgNj5pOYemThcCDdoyOxynFIy0gbJG+qyrs4aYUA+ik3l7+iIbRIyGf7DwLB9AzX4YIjvypw2RxJHXDHBTPuVugDTbnLUBmWqTHg8QE5fBICtdHG3O7TBrKEnRe2TMMuAayu93bfn7DkA3ejuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041152; c=relaxed/simple;
	bh=/aOYMLIKvCHI4Cu3/LmwNv0YkEuF32kZeHdoBluPw14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=De3/r8l3wFm3TFJcFlrSx/iw/6VOXa9DLpG+GoTqNJlS8ljPMZPUOUsFzo3AhF7m3zANijl6/Yx3G9zKmFnLxCUJAh06qacFni6zAKG19wHafBIjaykePqkCw1tjJTmMpVsAzcHldU3t6saZq9YClRa/eCVf64F+5h+phwYrv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LndKsMZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F41C4CEF1;
	Tue, 25 Nov 2025 03:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764041151;
	bh=/aOYMLIKvCHI4Cu3/LmwNv0YkEuF32kZeHdoBluPw14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LndKsMZWaw3PhgYoV7xFMR0j3za8Ppuu4UAInq1DCKGVNTYO67toxju2bIO14vW5S
	 MreXSmreC/CKFWsUrXZwCBuEuP2PJ6lHQISciErwb7kWHNdVbkHBwdqY7RI8x4UM2D
	 xpqxmS2PniRSq027weNpoAIeVVOY3JXPyKb3xNBNFBJSIkVCabDluN48zIiUe1aBvm
	 MZc5GsIwEUHf0cB44os74gf4zlkPYKrt1HP1dCJPu9KkrYa19sZvcorCkXXMka2zfc
	 DsRrpF+OAxyRy0CE8ST+RnQ2RoKT4Iv9awUKSJMnDW69KThg1NuucrHSup1ceRnvs6
	 Bvjq9a8NNBo+w==
Date: Mon, 24 Nov 2025 19:25:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: azey <me@azey.net>
Cc: "David Ahern" <dsahern@kernel.org>, "nicolasdichtel"
 <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "netdev" <netdev@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Message-ID: <20251124192550.09866129@kernel.org>
In-Reply-To: <19ab902473c.cef7bda2449598.3788324713972830782@azey.net>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
	<20251124190044.22959874@kernel.org>
	<19ab902473c.cef7bda2449598.3788324713972830782@azey.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 04:15:25 +0100 azey wrote:
> On 2025-11-25 04:00:44 +0100  Jakub Kicinski <kuba@kernel.org> wrote:
> > On Mon, 24 Nov 2025 14:52:45 +0100 azey wrote:  
> > > Signed-off-by: azey <me@azey.net>  
> > 
> > We need real/legal names because licenses are a legal matter.
> > -- 
> > pw-bot: cr  
> 
> I was under the impression this was clarified in d4563201f33a
> ("Documentation: simplify and clarify DCO contribution example
> language") to not be the case, are there different rules for this
> subsystem? I think it qualifies as a "known identity" since I use
> the alias basically everywhere (github, website, GPG, email, etc).

My understanding is that if I know you, I can apply your patch even 
if you use your nick name (rather than what you have in your passport
letter for letter).

I don't know you.

If you're saying that I can do some research and find out who you are
please be aware that we deal with 700 individual per release just
in networking.

