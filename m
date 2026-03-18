Return-Path: <netdev+bounces-269216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLAHKmA1u2mTgwIAu9opvQ
	(envelope-from <netdev+bounces-269216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:29:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0862C3D6D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6F2E302514B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6E2DEA7B;
	Wed, 18 Mar 2026 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="I4yqW3l9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AT4JROXy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5BB37C931;
	Wed, 18 Mar 2026 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876573; cv=none; b=tLhRGqvkTzeyxDYCmRCYFrvcThyMhvbAG98gk+nJWKSjCztnwh42x5PsyP7I3dMIlNFZHyhbtSarBQstvwy0zYf/56rWXDRpCaCjGvUuXi9Y7zBeFcIstzNuZq+WuKXdXqL0RTr56jSqyk36PScZ6ahe8I+a/eboVJCPCoiYMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876573; c=relaxed/simple;
	bh=Yltuqge8PJ7BjcOQyqRpWatjQMP9p0TpULVftc/TqUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOpeJrnXWpSumCWdC/GCnp3jnxSPDzH3ziqVfXwg2Cp0wP6CF/C8NXA9+n/nDV+Y0WV9ge9cjrS24UE6RR/qg7FbBm3lTgFRsL+Q/2W4d+NEGuiQRPhvwj/YBCsH8o8j0nguqThBAM+WlDi/NchyK36kbSxKC4GfbcEkbzAsgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=I4yqW3l9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AT4JROXy; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA68B7A01B3;
	Wed, 18 Mar 2026 19:29:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 18 Mar 2026 19:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773876568; x=
	1773962968; bh=XbUyYjVc65Nz+Nj4mNs9Q0oYuHKw+RwPHEk+rYYtfDs=; b=I
	4yqW3l9VvDtVYa1qXIrFGmGGqeYjyX+V8Szhnxt7xXCsnjIi77lyjBrtCkq5T7fP
	tfIHYv71v0WHCmzgrtFWsSYh9z4xRlWWOKI7N336zBntFnqPGqqWhJvuklRQetCo
	8HR6hHHBo/n4UNuYLzvwVv7MxF58nYzycNh390gaTRKGP62mIxfl4q1oJQYLk7lV
	0718DPOzYCLZIemQBzIj8SOG6dpySAOeH8/uLXqU0eMmO5Q8QCrnuJtex4/JZvFH
	iwPqW0XHDBm22k0Dk3Qb7ZKk+YTCbbKS01HErf8rGY3mjgJeFG0nFjSBoMguzysm
	G6DvaA/MiTt9A5v8HR0vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773876568; x=1773962968; bh=XbUyYjVc65Nz+Nj4mNs9Q0oYuHKw+RwPHEk
	+rYYtfDs=; b=AT4JROXyyZp/TwUwuqWdRI1pz/kkUMG9YA4+zqt0ahuxDIhfywj
	yrERMKg9Q6ZIw3jqapow5jaORm0cz87hTgZ39O2XjNgYq1U+hC1iBnYAjFpm4H+Y
	CC4Oel3jM+AxhId99E0t3e0XOVJUPQzqNen9W5T/F4aA1BKOQFSjS5I9pQ4H4WWJ
	NbvaNnnqkGAvCMqzmQgBqT56xcXjphGNxHBO2OsG0ahS811ZNMUmf6TbCfx/dqaz
	GJd35eTR+EBpwEkB7xU7oSeCaiBP7ider8nH60iVcoj6TakNZDWyiv7PJe5RpUbq
	otrO8Wv+3xuI4uPfVcEOmmJWexiMMxDf4Kw==
X-ME-Sender: <xms:VzW7af4DTgKPywiTtSgKbnoZVqwRR3srD4zOdKolULINJWWDk_lTtw>
    <xme:VzW7aUULXSAW7ztJiPXd8RWs6JpOli4uebpDZRPqovuaVNUxOj5Xq0STFeFXYQsaN
    jF04rqop4qTD3F7OVtjtbppC2JxaHK8p9b91cifDDeMQsNith91m5o>
X-ME-Received: <xmr:VzW7aXjPhC1CIkuKaIoQAaRd_1D_pGo7JzjNQKDz_WO5UFeFoQAd98nG2c7x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhrtghpthhtohep
    rghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhrihesrhgvshhn
    uhhllhhirdhushdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:VzW7aUeZPDpj1n9WDs0cVcl_QMoiwJYlNPN-4qI78IdfbV5oAWLYJQ>
    <xmx:VzW7aW192n06YMPEMsn1AzN7x_Mgz2m6y3SOOK-HsDgGcRfstHZt2A>
    <xmx:VzW7aQolxV9KSErG0GEE94OnRJUf4XX94qAElgn8-VXX4qWejrDN7A>
    <xmx:VzW7aejLGtKfDJwpGuPo93t_wyA58HgDW5XDEwXtdO0S4LzJDonCmg>
    <xmx:WDW7aaaizXubWOz4lkBldekXAbWYKpfSGKQyFvjDdfr2mWPRS-yeR4Bd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 19:29:27 -0400 (EDT)
Date: Thu, 19 Mar 2026 00:29:25 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/5] net: add ndo_update_offloads for offload
 computation
Message-ID: <abs1VWLQVmXcWESQ@krikkit>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
 <ablv266AIETvJwpP@krikkit>
 <abn8qFyE7pDuM4oN@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abn8qFyE7pDuM4oN@fedora>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-269216-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: DC0862C3D6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-18, 01:15:20 +0000, Hangbin Liu wrote:
> On Tue, Mar 17, 2026 at 04:14:35PM +0100, Sabrina Dubroca wrote:
> > 2026-03-16, 12:26:09 +0800, Hangbin Liu wrote:
> > > Add a new ndo_update_offloads callback to net_device_ops that allows
> > > devices to compute and update their offload features during feature
> > > updates.
> > > 
> > > This callback enables master devices to recompute their features
> > > based on current slave device configuration. This is particularly
> > > useful for bonding, bridging, team, and failover devices that need
> > > to aggregate features from their lower devices.
> > > 
> > > The callback is optional and only implemented by devices that need
> > > dynamic offload feature computation.
> > 
> > Maybe a dumb idea (and sorry to suggest this quite late in your
> > submissions): since all implementations of this callback are only
> > calling netdev_compute_master_upper_features(), does this need to be a
> > new ndo, or could this be some kind of flag within struct net_device
> 
> Ideally all dev with IFF_MASTER should re-compute the offload. But at present
> some master devices do have this flag, or have their own offload
> implementation.
> 
> Do you mean add a new private flag, like IFF_RECOMPUTE_OFFLOAD? For the second
> parameter, maybe we can pass false for bridge specifically.

I hadn't thought specifically about where to store that flag. As a
private flag, why not (this should be internal to the kernel, so not a
uapi flag like IFF_MASTER), but priv_flags is marked as "hotpath" now,
so maybe something similar to needs_free_netdev or
netns_immutable. Either way, then devices are free to do their own
magic, or request the core to call
netdev_compute_master_upper_features() for them in some common
locations. Does that makes sense?

-- 
Sabrina

