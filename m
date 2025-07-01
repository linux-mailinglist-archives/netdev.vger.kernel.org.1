Return-Path: <netdev+bounces-203013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC98AF0140
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD5127A28B4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5D275AFF;
	Tue,  1 Jul 2025 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="IncesFOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b8Y0VNQP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809F1F3B83
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389742; cv=none; b=WIB9OFPw5XUJPBH4sQeI2GzvDrglu3hzAl5cJmcTglV+2z+IxnNKlt7B3I555FuJ2+sNojq0bAgbVJ0iAhgKFzaKEk0lsge07vn/ql3KVpoGaqCblRCcdmIbM4XhvzuGfncRhokXF7EF9tYsPkKb2zgqddKx/5UQ75D/zI4ar7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389742; c=relaxed/simple;
	bh=stPEYuSXMksOaRfGrTlnY2dVNscW+UN81rFC3yPYPQo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=rKwfPSH2zjrXAjqeq/LH9AI2zROAkuDaoN61QtUENfO1iKyrlyxtua+XYByTrN8UeGW1WWAUGHZDfKB+cF6WuS1383VySbJeTPg9Xs7tTN+TY4BuCSrlCBa2tzklkQnzNLEnI1oJjHbUIEGI7uvMuu9NjQPXM6cvTzO/DZF/NRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=IncesFOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b8Y0VNQP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECB781400221;
	Tue,  1 Jul 2025 13:08:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 01 Jul 2025 13:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1751389738; x=1751476138; bh=hkbTUVwVEKnKid2hJwEnBAYsQo86IhSu
	xGdodEPDaDs=; b=IncesFOQEhn3/TfrHeuVRzlp4MQlbmZcYwJHH5ytnCzYZvuW
	ZlpTMHe7l6LIr0oJjQ2JU3Gc21Nusx+lLE1b2sSr3dJ1aHkuAri89vJziyhSWrhV
	bw4S1Tbn99eZpVn/ThLxmKIs1jwzAVOzWSrQYtaYJLDJNl7b3F1vD5VleewRM+iJ
	0sRS49KhYcv/kJHSXqeHeekzWZC7tBurX45hXEfLaEv5QNu0aMg94zWQ/3cM0/y2
	2Wqad7OWIHfGpEliaS4tW+SuGwgGu1r6OKvKgH+xl2AlsO5SO7Fs19onOl7nJf0v
	GRS37lw1CAna/OxIVRcb4GvWEebRVBl640KYdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751389738; x=
	1751476138; bh=hkbTUVwVEKnKid2hJwEnBAYsQo86IhSuxGdodEPDaDs=; b=b
	8Y0VNQPeIss7SRbJOVURbir3KaheMLfNWCMVzSTKE/Cd2o4RJODB8yTa66y0itwE
	XCS/jiWB6P86+Qaw0Ge+YmZoXbr2ts2lP0Wm1igllHVQcvn7CK7cVOdqUJMI3PCF
	eXFoqj2cjHsYliM8LPsivT3ykciod8gXjeuDndL+KDR76LnbNBfSacilqyYUau4v
	H03eXr+mkFITii4N+D2IWXSj+JMGuaQ46iuGkIBrw9nP3KAhphyQ4S+rYwT3+QD8
	bgVzTIzJAqMbCytGSc2CoPTxE2iZOTv5ktzst0H5FgLQsuDsppZ2Fh3AYjMvJgbr
	SZV6DuSSNw5LIfxyrN/Yw==
X-ME-Sender: <xms:KhZkaOAC8L7RDy4OPZ_XKQlomxPXR3QEUlUNkl2DmOZiMAPJeI79hw>
    <xme:KhZkaIiVPB1Bx7UwTQOY4MksJnP7m_4SanpFRIGb_9khx8ryqfdYTuT3ODV8yRgjG
    hsdJuJaSVOqVFAJ9RY>
X-ME-Received: <xmr:KhZkaBkz5KHINyq0_3DZgAG7yuvCK_fWjLlrJp1g3QXB4Q1Fz6afIBWYe7iuM2RamgHPng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeegfefghffghffhjefgveekhfeukeevffethffgtddutdefffeuheelgeelieeuhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghp
    thhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhrihesrh
    gvshhnuhhllhhirdhushdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:KhZkaMyjAQKAllGUKG8YzNQVGAhFqErBL0sVyN_BD8WgO0AjXQtFvA>
    <xmx:KhZkaDTKL3haNoMWdf76BN762KRyaEV1H8I13PhvGIcARWEe3FNrHg>
    <xmx:KhZkaHZs2hz0ihc3XZUfKkJ2QDcfNMDfAPSxN-09dcyOpYlNuV49Og>
    <xmx:KhZkaMTD10mSEqyvPgxuWhGz2KftZC5qo62BUM8tc9I1BbVdrIuoDw>
    <xmx:KhZkaMiyTeBBImZi3H17tO8zz9dEfOLNn6b1WYyUVLo-I-cXT2zcckfY>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 13:08:57 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id CF0429FCB3; Tue,  1 Jul 2025 10:08:56 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id CB67E9FBDC;
	Tue,  1 Jul 2025 10:08:56 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
    netdev@vger.kernel.org
Subject: Re: [Bonding Draft Proposal] Add lacp_prio Support for ad_select?
In-reply-to: <aF4fEGySN8Pwpnab@fedora>
References: <aFpLXdT4_zbqvUTd@fedora> <2627546.1750980515@famine> <aF4fEGySN8Pwpnab@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 27 Jun 2025 04:33:20 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Jul 2025 10:08:56 -0700
Message-ID: <2946319.1751389736@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Thu, Jun 26, 2025 at 04:28:35PM -0700, Jay Vosburgh wrote:
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>=20
>> >Hi Jay,
>> >
>> >We have a customer setup involving two separate switches with identical
>> >L2/VLAN configurations. Each switch forms an independent aggregator
>> >(port-channel), and the end host connects to both with the same number =
of
>> >links and equivalent bandwidth.
>> >
>> >As a result, the host ends up with two aggregators under a single bond
>> >interface. Since the user cannot arbitrarily override port count or
>> >bandwidth, they are asking for a new mechanism, lacp_prio, to influence
>> >aggregator selection via ad_select.
>> >
>> >Do you think this is a reasonable addition?
>>=20
>> 	In principle, I don't see a reason not to use the system
>> priority, et al, to influence the aggregator selection when bonding ends
>> up with multiple aggregators.  I'm undecided as to whether it should be
>> a separate ad_select policy or a "tiebreaker," but a separate policy is
>> probably simpler to deal with.
>
>There is only one system priority in the bond, which means all aggregators
>share the same system priority =E2=80=94 right?
>
>Or do you mean we should also take the partner's system priority into acco=
unt?

	Ok, this is what I get for reading the standard and not checking
the code carefully while I do it.

	That said, I still think that:

	(a) the system priority is the logical fit for this purpose, at
least from what the standard seems to intend, given that "System" there
means "Aggregation System," and,

	(b) the implementation we have (as well as few switches I
checked) is totally impractical for using system priority in this
manner, as all of them implement it as a global, or at least not on a
per-Aggregation System basis.

	Granted, the switches I have are pretty old, but even those that
require ports to be explicitly configured for particular channel groups
don't permit setting the system priority on a per-channel group (i.e.,
Aggregation System) basis.

>> >If yes, what would be the best way to compare priorities?
>> >
>> >1. Port Priority Only. Currently initialized to 0xff. We could add a pa=
rameter
>> >   allowing users to configure it.
>> >   a) Use the highest port priority within each aggregator for comparis=
on
>> >   b) Sum all port priorities in each aggregator and compare the totals
>>=20
>> 	I'm not a fan of this, as explained below.
>>=20
>> 	Also, note that in LACP-land, when comparing priorities, the
>> higher priority is numerically smaller, which makes "add them up and
>> compare" a little counter intuitive to me.
>
>Yeah..
>
>>=20
>> >2. Full LACP Info Comparison. Compare fields such as system_priority, s=
ystem,
>> >   port_priority, port_id, etc.
>>=20
>> 	I think it makes more sense to use the System ID (system
>> priority and aggregator MAC address) from the LAG ID of the local
>> aggregator.  In the bonding implementation, an aggregator is assigned a
>> MAC when an interface is added, so the only aggregators lacking a MAC
>> are ones that have no ports (which can't be active).
>
>Same question, the system priority and aggregator MAC address are all same
>in the same bonding interface. So how can we prioritize between two
>aggregators within the same bond?
>
>Unless we take the partner's System ID into account. Which looks like, if
>we want to choose a better aggregator in bond, we need to config the switc=
h side...

	Again, moving on from my lack of paying complete attention,
looking at the teamd implementation, I think that's what it does:

static void get_lacp_port_prio_info(struct lacp_port *lacp_port,
				    struct lacpdu_info *prio_info)
{
	int prio_diff;
	int system_diff;

	prio_diff =3D ntohs(lacp_port->actor.system_priority) -
		    ntohs(lacp_port->partner.system_priority);
	system_diff =3D memcmp(lacp_port->actor.system,
			     lacp_port->partner.system, ETH_ALEN);
	if (prio_diff < 0 || (prio_diff =3D=3D 0 && system_diff < 0))
		*prio_info =3D lacp_port->actor;
	if (prio_diff > 0 || (prio_diff =3D=3D 0 && system_diff >=3D 0))
		*prio_info =3D lacp_port->partner;

	Right here, it chooses between returning the actor or partner
data based on comparisons of the actor and partner System Identifier,
returning the data for whichever is higher priority after comparing the
System Identifiers (which is the System Priority plus Partner System,
the latter of which is the MAC address, 802.1AX-2014 6.3.2).

	I would hazard to guess that Jiri did it this way for the same
reason we're having this conversation: there's not really a better way
without rearranging a lot of the innards of how configuration of this
stuff is done.

	It looks like lacp_find_new_agg_lead() runs though all of the
ports in all of the aggregators and chooses the aggregator with the
"best" port of all.

	One downside if we were to adapt this logic or something similar
to bonding is that there's currently no way to set the Port Priority of
interfaces in the bond.  There is a "prio" that can be set via ip set
... type bond_slave prio X, which is IFLA_BOND_SLAVE_PRIO, but that's a
failover priority, not the LACP Port Priority.

	So right now, if the above logic were put into bonding, the
local selection criteria would end up based entirely on the port number,
which isn't configurable, and so doesn't seem especially better than
what we have now.

>> 	If we want to use the partner System ID, that's a little more
>> complicated.  If aggregators in question both have LACP partners, then
>> the System IDs will be unique, since the MAC addresses will differ.  If
>> the aggregators don't have LACP partners, then they'll be individual
>> ports, and the partner information won't be available.
>
>Can we active a aggregator that don't have LACP partner? If not, then
>we don't need to compare that aggregator.

	Yes, we can.  If no ports have a LACP partner, then all of the
ports are "individual," which act like an aggregator with just one port.
If all ports in the bond are individual, then one is chosen to become
active.

	The rationale behind this is to permit LACP-unaware hosts or
things like PXE to be able to communicate when LACP is not up and
running on the host system.

>> 	Modulo the fact that bonding assigns a MAC to an aggregator
>> before the standard does (for the System ID), this is approximately
>> what's described in 802.1AX-2014 6.7.1, although the context there is
>> criteria for prioritizing between ports during selection for aggregation
>> when limited capabilities exist (i.e., 6 ports but only the ability to
>> accomodate 4 in an aggregrator).
>>=20
>> 	FWIW, the 802.1AX standard is pretty quiet on this whole
>> situation.  It recognises that "A System may contain multiple
>> Aggregators, serving multiple Aggregator Clients" (802.1AX-2014 6.2.1)
>> but doesn't have any verbiage that I can find on requirements for
>> choosing between multiple such Aggregators if only one can be active.  I
>> think the presumption in the standard is that the multiple aggregators
>> would or could be active simultaneously as independent entities.
>>=20
>> 	Anyway, the upshot is that we can pretty much choose as we see
>> fit for this particular case.
>
>Yes

	From the above, I suspect we'll have to add some additional
configuration parameters somewhere.  It would be nice if the System
Priority were configurable on a per-aggregator basis, but that seems
complicated from a UI perspective (other than something like a mapping
of agg ID to system prio).

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

