Return-Path: <netdev+bounces-83230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8FB8916B3
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0E2863EB
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACACC53812;
	Fri, 29 Mar 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIXV6oIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891CA537E8
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707792; cv=none; b=qlTJKZD2PhVZBk9yOsLaSWC5mofjbbKBprkpP8Q6Q0rk52zQ7B4EL5fP80KP7v/rexJIvBItR08DTiTmSROXLBDvRFsDUruJ7xMudxsygCnWnDNeTzt9PJoZNzxTXpphcEfiz5kp7rjUIViJChq64tR04avhFbgKEfmBFaHY9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707792; c=relaxed/simple;
	bh=XJ8Ya8zuEMAjfbXR865ifaZPLGnTPY/HlM/DRqi3Qts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTOuGN2QDbIHuxJ/bTbP3kEYK6/Rk3gYB/FvM7uWABK5WqEEwQSOoVOzqVgC4FP6EcK3hHW50NIj9APLo4f1nX7MzwN49bqxag//HQW745mqoTHdBoGg8T4zAffdEtJp7avXXnzCe8KCkNk5AQnz/2kSvj8hL5meMRqsBguJlgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIXV6oIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18500C433F1;
	Fri, 29 Mar 2024 10:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711707792;
	bh=XJ8Ya8zuEMAjfbXR865ifaZPLGnTPY/HlM/DRqi3Qts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIXV6oIYpvloTgUf7ldYJYvMJ8AtHHGlV9H1DImVxtzH/AY8fMEy3ASTBu5wjpFBt
	 PLgomR4tWDvTc4Tul2yWiPDB2Rk0Lu4c/VPJyO+mHi887W7f45NPNGGdcpRXcjInNx
	 L8cX3y/u50CWA2izvBRabjkah/lSvTzCOR00evdjcn1gSUGjPrdTzB8djSPsRffmh7
	 fYNKmnPC/D5A2Jpe3n++eYaJWd8BKzj53LoNspJ5WUEM2YQ3vNsn+U5AVQz2QBPZMU
	 /EgncL9Iy+znUyuGy7HbXgKHa+0f1JIQDNDHfaWPVtSV+oW1pzYTunA/oVdJ1p7CRL
	 Y8fEwPUY+ze/A==
Date: Fri, 29 Mar 2024 10:23:08 +0000
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] using guard/__free in networking
Message-ID: <20240329102308.GM651713@kernel.org>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
 <20240325190957.02d74258@kernel.org>
 <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
 <20240326073722.637e8504@kernel.org>
 <6602e8671ecd0_1408f4294cf@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6602e8671ecd0_1408f4294cf@willemb.c.googlers.com.notmuch>

On Tue, Mar 26, 2024 at 11:23:19AM -0400, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Tue, 26 Mar 2024 09:42:43 +0100 Johannes Berg wrote:
> > > On Mon, 2024-03-25 at 19:09 -0700, Jakub Kicinski wrote:
> > > > On Mon, 25 Mar 2024 23:31:25 +0100 Johannes Berg wrote:  
> > > > > Hi,
> > > > > 
> > > > > So I started playing with this for wifi, and overall that
> > > > > does look pretty nice, but it's a bit weird if we can do
> > > > > 
> > > > >   guard(wiphy)(&rdev->wiphy);
> > > > > 
> > > > > or so, but still have to manually handle the RTNL in the
> > > > > same code.  
> > > > 
> > > > Dunno, it locks code instead of data accesses.  
> > > 
> > > Well, I'm not sure that's a fair complaint. After all, without any more
> > > compiler help, even rtnl_lock()/rtnl_unlock() _necessarily_ locks code.
> > > Clearly
> > > 
> > > 	rtnl_lock();
> > > 	// something
> > > 	rtnl_unlock();
> > > 
> > > also locks the "// something" code, after all., and yeah that might be
> > > doing data accesses, but it might also be a function call or a whole
> > > bunch of other things?
> > > 
> > > Or if you look at something like bpf_xdp_link_attach(), I don't think
> > > you can really say that it locks only data. That doesn't even do the
> > > allocation outside the lock (though I did convert that one to
> > > scoped_guard because of that.)
> > > 
> > > Or even something simple like unregister_netdev(), it just requires the
> > > RTNL for some data accesses and consistency deep inside
> > > unregister_netdevice(), not for any specific data accessed there.
> > > 
> > > So yeah, this is always going to be a trade-off, but all the locking is.
> > > We even make similar trade-offs manually, e.g. look at
> > > bpf_xdp_link_update(), it will do the bpf_prog_put() under the RTNL
> > > still, for no good reason other than simplifying the cleanup path there.
> > 
> > At least to me the mental model is different. 99% of the time the guard
> > is covering the entire body. So now we're moving from "I'm touching X
> > so I need to lock" to "This _function_ is safe to touch X".
> > 
> > > Anyway, I can live with it either way (unless you tell me you won't pull
> > > wireless code using guard), just thought doing the wireless locking with
> > > guard and the RTNL around it without it (only in a few places do we
> > > still use RTNL though) looked odd.
> > > 
> > > 
> > > > Forgive the comparison but it feels too much like Java to me :)  
> > > 
> > > Heh. Haven't used Java in 20 years or so...
> > 
> > I only did at uni, but I think they had a decorator for a method, where
> > you can basically say "this method should be under lock X" and runtime
> > will take that lock before entering and drop it after exit,
> > appropriately. I wonder why the sudden love for this concept :S
> > Is it also present in Rust or some such?
> > 
> > > > scoped_guard is fine, the guard() not so much.  
> > > 
> > > I think you can't get scoped_guard() without guard(), so does that mean
> > > you'd accept the first patch in the series?
> > 
> > How can we get one without the other.. do you reckon Joe P would let us
> > add a checkpatch check to warn people against pure guard() under net/ ?
> > 
> > > > Do you have a piece of code in wireless where the conversion
> > > > made you go "wow, this is so much cleaner"?  
> > > 
> > > Mostly long and complex error paths. Found a double-unlock bug (in
> > > iwlwifi) too, when converting some locking there.
> > > 
> > > Doing a more broader conversion on cfg80211/mac80211 removes around 200
> > > lines of unlocking, mostly error handling, code.
> > > 
> > > Doing __free() too will probably clean up even more.
> > 
> > Not super convinced by that one either:
> > https://lore.kernel.org/all/20240321185640.6f7f4d6b@kernel.org/
> > maybe I'm too conservative..
> 
> +1 on the concept (fwiw).
> 
> Even the simple examples, such as unregister_netdevice_notifier_net,
> show how it avoids boilerplate and so simplifies control flow.
> 
> That benefit multiplies with the number of resources held and number
> of exit paths. Or in our case, gotos and (unlock) labels.
> 
> Error paths are notorious for seeing little test coverage and leaking
> resources. This is an easy class of bugs that this RAII squashes.

+1

While I'm ambivalent to the constructs that have been proposed,
I do see leaking resources in error paths as a very common pattern.
Especially in new code. Making that easier to get right seems
worthwhile to me.

> 
> Sprinkling guard statements anywhere in the scope itself makes it
> perhaps hard to follow. Perhaps a heuristic would be to require these
> statements at the start of scope (after variable declaration)?
> 
> Function level decorators could further inform static analysis.
> But that is somewhat tangential.
> 

