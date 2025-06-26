Return-Path: <netdev+bounces-201699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68530AEAA99
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070863B7911
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC477221FD2;
	Thu, 26 Jun 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="V50tz4OH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fEMPbN/X"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394921CA08
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980521; cv=none; b=qy4Mb3l0q7dh8igcnxcMQTcbwv86f7rF6Uygh9uzbrN/Bkejnk+lKGtzHv7WIeY/v8ND9GfT0R5F66z+ooCAVmwWr0j8LwzULAHa7Wczs0G97xG/6/bRwaR/WczWtsNam6ZFnbIqKfoi/FcvJgJqrLD6p4Lr7tm/2RE14Btxe5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980521; c=relaxed/simple;
	bh=ErAb8fKQuvG7AXJP4EWMfwv3bvetPyv8S3yKQ8C5660=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=DIdTxYDwTvykj3Hew7PliY279oLZbs3O2uemU1gvWyijnbK8uB7vkaCrTHw57HTQ2mfVWQXNa7sdjrra7NMnONOZI/EE3Za2tS7o3dp7PYfw7I/1kCWwiSQF9D7bwPYFOxQl0ZMI1Gdszjs/QsJZkfIW/VS0AtH0mOwM8e7ktZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=V50tz4OH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fEMPbN/X; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 146FE1D00266;
	Thu, 26 Jun 2025 19:28:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 26 Jun 2025 19:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1750980517; x=1751066917; bh=aCHT6S9sTlK1lHK/wqx16
	Mn5sRFkQNOkRGGZPxN/trE=; b=V50tz4OHpeNtbpVDwrPmle/6jUcGo02FZPEY/
	JF/8UqhfRnRIu1N1OceNzrPbT45d0n41ICnfhLt9c0QK955xpR8YUR33gFY8iuJu
	A8L3z69YljTpl824oAl/cWNBHvf71MR23ajESk5oYA4qVvZgKO9WJxvgm70+2Oqi
	4fsNnSp1KSiXHtj90BFCsvu3LGJki6mG75Ppf7ce4C9i9OsXkJksfh1/sTVEpKAV
	/b5rDfROLvkjbHkbi+JAJ0HItabhI/9I63xjHWG8011c8E+a7gaNUOxTAp2lVn7T
	HDb/1XdSDmu9JuQg9RGifqX6u7MRom5Z2NovtYMYcCBN+xujg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750980517; x=1751066917; bh=aCHT6S9sTlK1lHK/wqx16Mn5sRFkQNOkRGG
	ZPxN/trE=; b=fEMPbN/XdETp4cSEJvD9/Hv18BB94jr1jXSILFZQPyaqHIYFLHe
	CfuTnaVMNlRXsKMsxBwmZgWwRNAUUJYcITJK6JiGiBFiBYvfX9tGtyX/01E9aSys
	r8n2/SjY68lNOjmMJ3gMYkZEKCQ7vaEagnPYcdzo7mF7jG/5bCc9hh/1HTTnEQJ6
	gJKo6C/Ps80C5HL0/VNc58i9jJXTeVTpRLudHvzQIHTNEMJV+hrJKL+cAjT4yZNI
	hLueVZQ2ZqNc5V05i5dB6SF2LGa3s1WxmBlw4P7IcCGegFu3AK+6l+a9n7nCX8J0
	SUb6kqRW6nyrSUuMUUVzrkbh6uhbrXb73rg==
X-ME-Sender: <xms:pdddaORlGvB3QDxD2gXkeeLpu13Sj3-ZlgOfmoiWqhhGTTlyoEkhwQ>
    <xme:pdddaDxW7uBBfL2pd7qq_cLT2GN6hq-DGev_-dpS5vqIx-cFWQ2joL8LX-DO7FHcE
    8HGTZyI81jtjNCA-RA>
X-ME-Received: <xmr:pdddaL33pGWs_zZNRo8u9_IAw31saKx_smOQg3DQa_V7nKS26_kD19YqCsCZ-qytwmzEwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucggohhs
    sghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleegjeejueekvefhgfegveehieekieeigeeiieekgeehieffteetffffuefgveffnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfido
    nhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrth
    drtghomhdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhirdhushdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pdddaKC18Ap4idg_AolzgYQ5udxETaM_sDMk_scYelj2nXwBNbNn8g>
    <xmx:pdddaHjZbleskNPdMAEkwJJEi7cqd6aN2pa3NG7AdA20W96nNn_ZcA>
    <xmx:pdddaGoEG91vzrZQI0V4H0PNFM-ByuMMpg5oiI6aRFrSKZN5zJD9MA>
    <xmx:pdddaKiuzdo1rAiSWjGhkADKg1Ru3SwblO7UXfeOyh4yYS2dcPRImw>
    <xmx:pdddaAxVjKAxoO4VvnGnPFTi3hWznjP9rFWE4SJfeoDYOcU0RzUYu63r>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 19:28:36 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 75B3C9FCA2; Thu, 26 Jun 2025 16:28:35 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 74D269FB75;
	Thu, 26 Jun 2025 16:28:35 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
    netdev@vger.kernel.org
Subject: Re: [Bonding Draft Proposal] Add lacp_prio Support for ad_select?
In-reply-to: <aFpLXdT4_zbqvUTd@fedora>
References: <aFpLXdT4_zbqvUTd@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Tue, 24 Jun 2025 06:53:17 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2627545.1750980515.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jun 2025 16:28:35 -0700
Message-ID: <2627546.1750980515@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi Jay,
>
>We have a customer setup involving two separate switches with identical
>L2/VLAN configurations. Each switch forms an independent aggregator
>(port-channel), and the end host connects to both with the same number of
>links and equivalent bandwidth.
>
>As a result, the host ends up with two aggregators under a single bond
>interface. Since the user cannot arbitrarily override port count or
>bandwidth, they are asking for a new mechanism, lacp_prio, to influence
>aggregator selection via ad_select.
>
>Do you think this is a reasonable addition?

	In principle, I don't see a reason not to use the system
priority, et al, to influence the aggregator selection when bonding ends
up with multiple aggregators.  I'm undecided as to whether it should be
a separate ad_select policy or a "tiebreaker," but a separate policy is
probably simpler to deal with.

>If yes, what would be the best way to compare priorities?
>
>1. Port Priority Only. Currently initialized to 0xff. We could add a para=
meter
>   allowing users to configure it.
>   a) Use the highest port priority within each aggregator for comparison
>   b) Sum all port priorities in each aggregator and compare the totals

	I'm not a fan of this, as explained below.

	Also, note that in LACP-land, when comparing priorities, the
higher priority is numerically smaller, which makes "add them up and
compare" a little counter intuitive to me.

>2. Full LACP Info Comparison. Compare fields such as system_priority, sys=
tem,
>   port_priority, port_id, etc.

	I think it makes more sense to use the System ID (system
priority and aggregator MAC address) from the LAG ID of the local
aggregator.  In the bonding implementation, an aggregator is assigned a
MAC when an interface is added, so the only aggregators lacking a MAC
are ones that have no ports (which can't be active).

	If we want to use the partner System ID, that's a little more
complicated.  If aggregators in question both have LACP partners, then
the System IDs will be unique, since the MAC addresses will differ.  If
the aggregators don't have LACP partners, then they'll be individual
ports, and the partner information won't be available.

	Modulo the fact that bonding assigns a MAC to an aggregator
before the standard does (for the System ID), this is approximately
what's described in 802.1AX-2014 6.7.1, although the context there is
criteria for prioritizing between ports during selection for aggregation
when limited capabilities exist (i.e., 6 ports but only the ability to
accomodate 4 in an aggregrator).

	FWIW, the 802.1AX standard is pretty quiet on this whole
situation.  It recognises that "A System may contain multiple
Aggregators, serving multiple Aggregator Clients" (802.1AX-2014 6.2.1)
but doesn't have any verbiage that I can find on requirements for
choosing between multiple such Aggregators if only one can be active.  I
think the presumption in the standard is that the multiple aggregators
would or could be active simultaneously as independent entities.

	Anyway, the upshot is that we can pretty much choose as we see
fit for this particular case.

>At present, the libteam code has implemented an approach that selects the
>aggregator based on the highest system_priority/system from both local an=
d
>partner data.[1]

	Just looking at libteam code, it's more complicated than that.
The documentation says "Aggregator with highest priority according to
LACP standard will be selected," and the code looks to be doing memcmp()
on

struct lacpdu_info {
	uint16_t		system_priority;
	uint8_t			system[ETH_ALEN]; /* ID */
	uint16_t		key;
	uint16_t		port_priority;
	uint16_t		port; /* ID */
	uint8_t			state;
} __attribute__((__packed__));

	which is essentially the local portion of a LAG ID per
802.1AX-2014 6.3.6.1, with the key and state set to zero for the
comparison.  Also, the function you reference, get_lacp_port_prio_info,
is choosing between the actor and partner information for reasons that
aren't explained in the code, but I suspect might to comply with the
statement in 6.3.6.1:

	"To simplify comparison of LAG IDs it is conventional to order
	these such that S is the numerically smaller of S and T."

	where S and T are System Identifiers (comprised of System
Priority and the MAC address), or perhaps 6.7.1, as described above.

	Anyway, without knowing exactly why the team function is doing
what it does, I'm not sure if that's the proper algorithm to use.  Jiri
is on Cc, maybe he remembers.

	-J

>Looking forward to your thoughts.
>
>Best regards,
>Hangbin
>
>[1] https://github.com/jpirko/libteam/blob/master/teamd/teamd_runner_lacp=
.c#L402

---
	-Jay Vosburgh, jv@jvosburgh.net

