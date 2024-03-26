Return-Path: <netdev+bounces-82149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442E88C756
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1E61F67A90
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070D13CA9F;
	Tue, 26 Mar 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YfPnzPV0"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD713C9D1
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467250; cv=none; b=GV0dqD+CqtFE93+h9t2IULmIAo0FBqpxPbAbf3vfh9eHG7hts/4u7huJmf6Cpup3tZk79VeIIowJ4k9cq7hXs25OJ0M1xcFlyhabCCdws0V6BKm//IGShA4Skq94wdsqOfPsNKGx/wsGNZr+5LijwtoA2OB1lWakj9o1SOYl/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467250; c=relaxed/simple;
	bh=phIyPJUL5b/T7bCWm3uvYQe7Dh+FFaPf0uXSxoyeQck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SI3I2gMRRSKzkxGqpRDCAcd1SfH2VqwRWXcL95gHaOGjH8hqlxukerJS+RePf5OFzGuatiPNXfZ/+F9GdYRSWxn/NQFGOHgcYruxokw4Qo0FGuHR16jOl0CfU+A5h3f5ww3snlOQ2DjtCT8QQdvnxDVz+HaehxGojb67Whw3M7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YfPnzPV0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DgBOUNeCSK6pDD7C/dPf4FYAk624kO5YvijuKhLlS/I=;
	t=1711467246; x=1712676846; b=YfPnzPV08/Q7VJEaMc6rMIK6IGjoiODVIMxG0PEw/yaLilA
	OKe3pgc/JkhpBkLfBWtf4ya+ZGQxZhVmmZqT5T3rK929IGWvQkhWd2icu7rtbksRU9Vk7qAlUhAEp
	MTUDjKxpEJ66Ydc50ken/QTWK883GNfYWWR6KlzA6jEVc8s0tQ5dFEnh7Txn60NXaytjmJ91f9fvL
	e+FxcpYmaHyJO+EKzdYCz8DapgLSJEuRJGrzPKRQo3t3x0fum/qyvpKb+3Q4oBgOlagLsT8ngqygT
	X+Xy93mUZsvcKlcwIxIjHSMVfJ9+opa70ZpiINyAYOYmS/tTXqkwe0NLIQB6JlDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rp8oK-0000000Fo0U-02FS;
	Tue, 26 Mar 2024 16:34:00 +0100
Message-ID: <0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] using guard/__free in networking
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Date: Tue, 26 Mar 2024 16:33:58 +0100
In-Reply-To: <20240326073722.637e8504@kernel.org>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
	 <20240325190957.02d74258@kernel.org>
	 <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
	 <20240326073722.637e8504@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


> > So yeah, this is always going to be a trade-off, but all the locking is=
.
> > We even make similar trade-offs manually, e.g. look at
> > bpf_xdp_link_update(), it will do the bpf_prog_put() under the RTNL
> > still, for no good reason other than simplifying the cleanup path there=
.
>=20
> At least to me the mental model is different. 99% of the time the guard
> is covering the entire body. So now we're moving from "I'm touching X
> so I need to lock" to "This _function_ is safe to touch X".

Yeah, maybe. But then we also have a lot of trivial wrappers just do to
locking, like

do_something()
{
	rtnl_lock()
	ret =3D __do_something()
	rtnl_unlock();
	return ret;
}

because __do_something() has a bunch of error paths and it's just messy
to maintain the locking directly :)

So I guess I don't have that much of a different model, I'd actually say
it's an advantage of sorts in many cases, and in some cases you'd still
have "rtnl_lock()" only in the middle, or scoped_guard(rtnl) {...} for a
small block. But refactoring a function because it's accessing protected
data doesn't seem completely out of the question either.

> > > Forgive the comparison but it feels too much like Java to me :) =20
> >=20
> > Heh. Haven't used Java in 20 years or so...
>=20
> I only did at uni, but I think they had a decorator for a method, where
> you can basically say "this method should be under lock X" and runtime
> will take that lock before entering and drop it after exit,
> appropriately.

Yeah, I vaguely remember that. And yes, you can obviously just slap that
on everything and call it a day, or you could also there refactor the
things that do need the locking into a separate function, and use it
there?

> I wonder why the sudden love for this concept :S

I think it's neither sudden nor love ;-) But all the cleanup paths are
_always_ a mess to maintain, and this is the least bad thing folks came
up with so far?

> Is it also present in Rust or some such?

I have no idea. I _think_ Rust actually ties the data and the locks
together more?

> > > scoped_guard is fine, the guard() not so much. =20
> >=20
> > I think you can't get scoped_guard() without guard(), so does that mean
> > you'd accept the first patch in the series?
>=20
> How can we get one without the other.. do you reckon Joe P would let us
> add a checkpatch check to warn people against pure guard() under net/ ?

Maybe? But I think I do want to use guard() ;-)

There are a ton of functions like say cfg80211_wext_siwrts() or
nl80211_new_interface() that really just want to hold the mutex for the
(remainder of) the function. And really _nl80211_new_interface()
wouldn't even exist if we had that, because nl80211_new_interface()
would just be

nl80211_new_interface()
{
  cfg80211_destroy_ifaces(rdev);

  guard(wiphy)(&rdev->wiphy);

  // exactly existing content of _nl80211_new_interface()
  // with all the returns etc.
}

the only reason for _nl80211_new_interface() is the locking there ...

Actually, we might push that further down into the function, to just
before rdev_add_virtual_intf(), I guess? But it all just adds to the
complexity as long as it's not cleaned up automatically.

> > > Do you have a piece of code in wireless where the conversion
> > > made you go "wow, this is so much cleaner"? =20
> >=20
> > Mostly long and complex error paths. Found a double-unlock bug (in
> > iwlwifi) too, when converting some locking there.
> >=20
> > Doing a more broader conversion on cfg80211/mac80211 removes around 200
> > lines of unlocking, mostly error handling, code.
> >=20
> > Doing __free() too will probably clean up even more.
>=20
> Not super convinced by that one either:
> https://lore.kernel.org/all/20240321185640.6f7f4d6b@kernel.org/
> maybe I'm too conservative..

I mean ... it's not great, and it's all new stuff to learn (especially
those caveats with the cleanup order), but error paths are the things
that are really never tested and tend to be broken, no matter that we
have smatch/sparse/coverity/etc.

So while I don't think it's perfect, and I tend to agree even that it
encourages "over-locking" (though we can refactor and use scope etc.
where it matters), I'm pretty firmly on the "we should be using this to
not worry about error paths all the time" side of the fence, I guess.

johannes

