Return-Path: <netdev+bounces-169154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52EA42B20
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC816678D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F033266B5F;
	Mon, 24 Feb 2025 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPMJ2zV5"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D75265CBF
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421281; cv=none; b=DMuZh33+7hQDD9B8+4qkpTPLq5+MEnWxpyCYBlqVvB5XZidKJ4Eq5EcvNyjqThnU1CB2LLRbSgu1PrgpT6U+hiOiIeTDit4rxRa0D+uz8DDifVf7dwWw3CFy7CowsO2K9GrmAO4VdFsMvHDUKj51Ecp/il5LjTvlr19xsuekHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421281; c=relaxed/simple;
	bh=eQuGQvGBKRnzPnEPH9gOcy5jafPipiDOVtu1gALRPMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCq3OER8SaszQvFSn7EEUTBurAI7Jzh5MYhJiAk2LyLAcASv/ZdLF62/IN3Xs1ilhkHcPByp+9iNFqjnRkRUXEVIeTgIlCbvn3mWimrXGKVaISKHceXcqF0TwE0M6wZL5KQkjAXGntQGHoRUG68H852hUU1j78DX7p2NZ9Ak9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPMJ2zV5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1879D11400BC;
	Mon, 24 Feb 2025 13:21:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 24 Feb 2025 13:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740421277; x=1740507677; bh=2OylwEuidSow0gGM7o36hwqEIuguDe3J19l
	fQdb1FXA=; b=TPMJ2zV5+ebAlLY8gmiQ1VyUb4r0YYtWie7kV9Jl+FYN4wOk6J8
	n4B2isNKD18lHvnRYg5Wfyi+Qb9f4qnRodoP1nMZMrWXzonLB4eA4XUXw0K4ZlK0
	o2uYHMbMIn42NgDvaGWW4gf39AWwYtGhSHOa3FCT8cpc1D1ogSrtIMgKRYUi9IFm
	O3tWAHsCEy6K6CA4YcNPWr3hHfr3nxSQIoHUyOkY3/smTlSUFVBzJpQm3rVCs7Gi
	27w05AfxG+QwZD1810dQ9DD1CDNW2V+l8XcNNgxdgTiglMqKxAZeyWiRm0SBViBm
	XIj62VRSrh6a1SVvZAXDDz1T0zy/V5GrWYA==
X-ME-Sender: <xms:nbi8Zw-T2mBC2brHT58-HI4gsi2fNOuE6iDgpdh6noIN-M1YVyZU_w>
    <xme:nbi8Z4sz-niyxSTAtyLqSq6HNdvIfAt0ztsPMPHduk1h0G6rW8p03N8NsTCkSM1Kv
    bDxuDYxO9NI3N0>
X-ME-Received: <xmr:nbi8Z2AsW1KapQmwWLaNivq9oKki2XD3qdJLEJQwGdoQbGVoKCyPKJ0Kc3qm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgnhgruhhlthesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughsrghh
    vghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnthhonhhiohesmhgrnhguvg
    hlsghithdrtghomh
X-ME-Proxy: <xmx:nbi8ZweRE2iumRJCTXSGTpDe4rz3f63kX_hCeu5S1U5pwtprhb-2DQ>
    <xmx:nbi8Z1POWOX2bZ5fqI8Yp5pwOnHRp3TykS8znOqsWOaZMrRk0QgSMQ>
    <xmx:nbi8Z6kHmR-CZoMJUWn4c_u11XYzyJ-prw0iGLw-mFhyQO9qxSVxSQ>
    <xmx:nbi8Z3uqcwFsYn7Qe88J5Kj4fUCMA8LnW5V5Rec-OjZYDjUA25029w>
    <xmx:nbi8Z-jsrfK2Sb6HQcZT7dsWuv6zbvncVQZq-HOq1z3qAnoGaAqn1FrK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 13:21:16 -0500 (EST)
Date: Mon, 24 Feb 2025 20:21:14 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH net v2 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z7y4mpW3vNiy7eMw@shredder>
References: <cover.1740129498.git.gnault@redhat.com>
 <942aa62423e0d7721abd99a5ca1069f4e4901a6d.1740129498.git.gnault@redhat.com>
 <Z7sfmLG4V_kHKRfy@shredder>
 <Z7ysHMi4NociwDgR@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7ysHMi4NociwDgR@debian>

On Mon, Feb 24, 2025 at 06:27:56PM +0100, Guillaume Nault wrote:
> On Sun, Feb 23, 2025 at 03:16:08PM +0200, Ido Schimmel wrote:
> > On Fri, Feb 21, 2025 at 10:24:04AM +0100, Guillaume Nault wrote:
> > > Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> > > devices in most cases and fall back to using add_v4_addrs() only in
> > > case the GRE configuration is incompatible with addrconf_addr_gen().
> > > 
> > > GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> > > ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> > > address") restricted this use to gretap devices and created
> > 
> > It's not always clear throughout the commit message to which devices you
> > are referring to.
> 
> Yes, that's a problem I had when writing the commit message: I couldn't
> find a proper way to name the different GRE device types unambiguously.
> 
> By reusing the device types of "ip link" we don't know if "gre" refers
> to all GRE types or if it's only for IPv4 encapsulation. But using the
> ARPHRD_* types wouldn't help, as that wouldn't allow to distinguish
> between gretap and ip6gretap.

Right.

> 
> Maybe the following terms would be clearer:
> 'ip4gre', 'ip4gretap', 'ip6gre', 'ip6gretap' (and potentially 'ipXgre'
> and 'ipXgretap' when considering both the IPv4 and IPv6 tunnel
> versions). Would you find these terms clearer?

I'm fine with the above, but I also think that as long as "ip link"
types (e.g., 'gre', 'ip6gre') are consistently used throughout the
commit message, it should be clear which devices the commit message
refers to. Whatever you prefer.

> 
> > For example, here, by "gretap" you mean both "gretap"
> > and "ip6gretap", no?
> 
> Yes.
> 
> > BTW, I believe the check against 'ARPHRD_ETHER' in addrconf_gre_config()
> > is dead code. addrconf_gre_config() is only called for ARPHRD_IP{,6}GRE
> > devices.
> 
> Yes, that was dead code. But I'm reusing that condition to minimise
> code changes so to make the fix simpler. Do you mean I should write
> explicitely, somewhere, that it was dead code but isn't anymore?

No, it's fine as-is. I made the comment while reading the commit message
and looking at the unpatched code and only later when I checked the
patch I noticed that you already took care of it :)

> 
> > > add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> > > 
> > > The original problem came when commit 9af28511be10 ("addrconf: refuse
> > > isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> > > addr parameter was 0. The commit says that this would create an invalid
> > > address, however, I couldn't find any RFC saying that the generated
> > > interface identifier would be wrong. Anyway, since plain gre devices
> > > pass their local tunnel address to __ipv6_isatap_ifid(), that commit
> > > broke their IPv6 link-local address generation when the local address
> > > was unspecified.
> > 
> > By "plain gre devices" you mean "ipgre"? Because addrconf_ifid_ip6tnl()
> > is called for "ip6gre" and it doesn't fail, unlike __ipv6_isatap_ifid().
> 
> Exactly. I tried to use the "plain" adjective to say that's the kind of
> device you get with the "gre" keyword in "ip link".
> 
> > > Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> > > interfaces when computing v6LL address") tried to fix that case by
> > > defining add_v4_addrs() and calling it to generated the IPv6 link-local
> > 
> > s/generated/generate/
> > 
> > > address instead of using addrconf_addr_gen() (appart for gretap devices
> > 
> > s/appart/apart/
> 
> Will fix both.
> 
> > > which would still use the regular addrconf_addr_gen(), since they have
> > > a MAC address).
> > 
> > Assuming what I wrote is correct, I'm not sure why e5dd729460ca didn't
> > restrict the fix to "ipgre" and applied it to "ip6gre" as well.
> 
> I asked myself the same question. Antonio might have an answer to this.
> But in my understanding the changes brought by e5dd729460ca were much too
> broad.

I agree.

> 
> > > -	if (dev->type == ARPHRD_ETHER) {
> > > +	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
> > > +	 * unless we have an IPv4 GRE device not bound to an IP address and
> > > +	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
> > > +	 * case). Such devices fall back to add_v4_addrs() instead.
> > > +	 */
> > > +	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
> > 
> > Doesn't this mean that the 'ARPHRD_IP6GRE' case (and the
> > 'CONFIG_IPV6_GRE' checks) can be removed from
> > addrconf_init_auto_addrs()? That is, only call addrconf_gre_config() for
> > "ipgre", but not for "ip6gre".
> 
> Yes. But I didn't want to do that here, to keep the fix as simple as
> possible. Because that'd mean we'd also have to add a
> "(dev->type != ARPHRD_IP6GRE)" condition in the test at the beginning
> of addrconf_dev_config(), and I feel that'd be a distraction from the
> core of the patch. So I prefer to do that in net-next.

Fine by me. Thanks!

