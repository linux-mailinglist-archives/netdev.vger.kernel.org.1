Return-Path: <netdev+bounces-231357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E01BF7C9B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC3314E9BC6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE32E11CB;
	Tue, 21 Oct 2025 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="km/RNYBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccJsJ1yw"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A0346E73
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065580; cv=none; b=lJSeYK7M86ddX51uxL8LCw+WV9myJLLb1BkZoQh18oZK29q/VvDRF5nGlDxKBsj+Gkmp2zdU/jsLIWouL+Czxc8Axg/dAKcroPFgBfDhGVxb1MaxoeHC5yJvLCjHrp21CK739p+xuEb82Bhv6/YJ7BwnLbqKlRIR/D40tE8SR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065580; c=relaxed/simple;
	bh=4JfixZFPfVihXjKhMmwk1/yB7Zcjh++/ZO67fzTTx1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu90/6lK0Ta3CHNBbwReTKsZGgO2TtkRlK1aNRoi9J/685ewH2ECe5Y16rDpPnGXcZUw1Duwo/Yt+phlD2MmrrhvTCeSQafNF6mlfpD/QkXvERYa63+mqyhP2GZRYMAeqAH33tTHFHAL8Xpkcdkl4HNMz4chhotOQP5NMzf/vn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=km/RNYBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccJsJ1yw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A10141D0000C;
	Tue, 21 Oct 2025 12:52:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 12:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761065575; x=
	1761151975; bh=4OaAX2xEk2neBRfluWdNHM2MvJ4wdhZGJvRC6TwttHQ=; b=k
	m/RNYBEByaImddACRmAHv7AGdxhfa56a2TzMdu/QsxNvzQ/XMWX5zEAK+aMrMGyh
	+CPEbDR+KrsRqAjbkXtrLIEN1cuDbnQBsCb5J6ZO9N1AvPHXfQD6dNsdJgjSrJhX
	5iJwB5QklHMY1dDobknrWlSwxOiVCx+bnMh2/aVCDZq8JwSSL/6G36j5do42xh7U
	tmiuYt71Daw8UML2lU0X0lBuutW8fqeOcVqsRKdrRmBU72VDrqXPV4nCEUwPXMaG
	j0+YJ95nHhi4hxtBfBhMXKRVepPvBhJC2Df3d9D98FEb5JXSNphe/z0tQO/Vz99L
	e2o/chII7jhOD3GD9iT6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761065575; x=1761151975; bh=4OaAX2xEk2neBRfluWdNHM2MvJ4wdhZGJvR
	C6TwttHQ=; b=ccJsJ1ywZzXP1dQSDHdQFL3/f8qUro14zActJgHsYIUYUJssR9e
	ipn+/lHAWzI1/b3rPOYdTJIQHglBcA368Fb1G16uiOhTdwOfPkArOLUssGr+Xq43
	N2rKT5OtHbSdxwfSO5XvCtl/FxR05+EjYsuTo5tWVKl/tJn8/iGaRn6bkdlQzX+P
	7xkp+vdtGu0SW0VsuimXEZgUUvcg6uzdY1RbjvwtzZloSlbsToQ/0HJjyCkm1bP+
	w7oQby0fHhIeB46fUPRow9WunHKfi1IoLyEeIakSMxcb8neX+uqYFEGb1P9QklUz
	IdJduMebJUub5vv9b7bhMEVv8+ZVvP3G+IA==
X-ME-Sender: <xms:Zrr3aOMQdGsWNTsyIA5riM01XWw7vz7hkT_WWV6ooYeeIRkt8jwxCA>
    <xme:Zrr3aGVuQUQcMn4b7bjvvz9AoJKllzGOUfT8WHehfQmgf-xJN8mhZNpbFWuSzm6Ce
    IyPGFuPk061rdM2dCpky78rEuIwla4CbQst4Q3UROtaUrBl220BbFMy>
X-ME-Received: <xmr:Zrr3aNz8JQQFOoa9PbVXdlve7DyLDeXTCh9nvJCaQ5bP9h3WXXsACfhqsStN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeduvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvhesjh
    hvohhssghurhhghhdrnhgvthdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehl
    uhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhird
    hush
X-ME-Proxy: <xmx:Zrr3aOPPYgTUvagRZ1f34p1zBe9hElKtroryGE391I1lArY-JETZwg>
    <xmx:Zrr3aHp7yQLuilIS10mvwFWH6nXbowdVv-WXg7TGNPgXcdA_lX2I1Q>
    <xmx:Zrr3aN_4soJVmBNFsZb4HnirwE5ExSqsoKW_QME-DyeSAAczkE4lng>
    <xmx:Zrr3aF3zVfvwlyUI_MsrXbs0XzAqso7CMZ9yAyRtjkVGmQC2R4ZK2Q>
    <xmx:Z7r3aJmP6COHdQTQOwuFGI26TXkkdgQ_h97RGA01QxInL6l2n_FDZDyf>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 12:52:53 -0400 (EDT)
Date: Tue, 21 Oct 2025 18:52:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 1/4] net: add a common function to compute
 features for upper devices
Message-ID: <aPe6Y86R0vqc3a-R@krikkit>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-2-liuhangbin@gmail.com>
 <aPX8di8QX96JvIZY@krikkit>
 <a2e85a2b-58b0-4460-ae7a-b1ea01e4d7e4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2e85a2b-58b0-4460-ae7a-b1ea01e4d7e4@redhat.com>

2025-10-21, 10:46:22 +0200, Paolo Abeni wrote:
> On 10/20/25 11:10 AM, Sabrina Dubroca wrote:
> > 2025-10-17, 03:41:52 +0000, Hangbin Liu wrote:
> >> Some high level software drivers need to compute features from lower
> >> devices. But each has their own implementations and may lost some
> >> feature compute. Let's use one common function to compute features
> >> for kinds of these devices.
> >>
> >> The new helper uses the current bond implementation as the reference
> >> one, as the latter already handles all the relevant aspects: netdev
> >> features, TSO limits and dst retention.
> >>
> >> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> >> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > 
> > No objection to this patch/series, just a nit and some discussion below, so:
> > 
> > Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> > 
> > 
> > [...]
> >> +/**
> >> + *	netdev_compute_master_upper_features - compute feature from lowers
> > 
> > nit: I'm slightly annoyed (that's not quite the right word, sorry)
> > that we're adding a new function to "compute features" that doesn't
> > touch netdev->features, but I can't come up with a better name
> > (the best I got was "compute extra features" and it doesn't help).
> 
> I'm not the right person to ask a good name, and I'm ok with the current
> one, but since the question is pending... what about:
> 
> netdev_{compute,update}_offloads_from_lower()
> 
> ?
> 
> As it actually updates (some of) the offloads available to the (upper)
> device?

(and the DST_RELEASE flags. at least the tso_max_* kind of fits into "offloads")

I think we can keep the current name. It's more "it kind of bothers
the pedantic part of me" than "annoyed", and we can't find a better
name, so let's ignore the pedantic part. Sorry for the noise.


> >> + *	@dev: the upper device
> >> + *	@update_header: whether to update upper device's header_len/headroom/tailroom
> >> + *
> >> + *	Recompute the upper device's feature based on all lower devices.
> >> + */
> >> +void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
> >> +{
> > [...]
> >> +	netif_set_tso_max_segs(dev, tso_max_segs);
> >> +	netif_set_tso_max_size(dev, tso_max_size);
> >> +
> >> +	netdev_change_features(dev);
> > 
> > Maybe a dumb idea: I'm wondering if we're doing this from the wrong
> > side.
> > 
> > Right now we have:
> > 
> > [some device op] -> [this new function] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features
> > 
> > Would it make more sense to go instead:
> > 
> > [some device op] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features -> [this new function]
> > 
> > ?
> 
> Uhmmm.... this function touches a few more things beyond dev->*features,
> calling it from ndo_fix_features() looks a bit out-of-scope.

True. And as Hangbin said, it's setting (so a bit more "update" than
"compute", as you wrote above) values whereas ndo_fix_features is just
returning a value.

So if we wanted to have this done by netdev_change_features, we'd
probably need a new ndo, or some kind of flag to tell
__netdev_update_features that this device needs the new function
called. Well, we have netif_is_bridge_master, netif_is_team_master,
netif_is_bond_master. But at this stage we don't know if update_header
should be true/false. So ndo would be cleaner, but a lot
heavier... it's probably not worth all this mess.

-- 
Sabrina

