Return-Path: <netdev+bounces-169994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8969DA46C6D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E416E3D2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B755E27561D;
	Wed, 26 Feb 2025 20:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D175275617;
	Wed, 26 Feb 2025 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601782; cv=none; b=RUhRcbcRy0zb/mtZrm/6lpk+8zxk+OA03j8dCNxPsIZA/vIpb3kal0ZOTpqoueb2bPKoYrT70QKYQXBFc1gSwJpVQT776L1L8TwKBxya0rrlHI+QKw/Uwd5STz6+c0bUvrVCClS7ZV5Yf+bWqyBPIxyGw+LNrBSsVshnTyNdT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601782; c=relaxed/simple;
	bh=yxQtZhATw7YZMwx8d0sQeR7D3tNH7pkKxlGCc/f7ick=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg8ToDZvfWbCyxUiQ2WvETQ4sbR8yjqgf5VM+RiiDGlaF4uFFHpb0M6PQR+NTg/iaToZwr/QXMLr3UcD61IUQS0Hc6NDwHO3n3tAqsQnP/rtFsPqFRAEAJtEuO3u+P677lC4iZ2CyyG+G4Yrs+PDaUPsJ3RBDNlK8RBRmNTru2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29B8D54145B;
	Wed, 26 Feb 2025 21:21:00 +0100 (CET)
Date: Wed, 26 Feb 2025 21:20:58 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, Jan Hoffmann <jan@3e8.eu>,
	Birger Koblitz <git@birger-koblitz.de>,
	Sebastian Gottschall <s.gottschall@dd-wrt.com>
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <Z793qqMMvxKuFxbM@sellars>
References: <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
 <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
 <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>
 <20240430012159.rmllu5s5gcdepjnc@skbuf>
 <b90caf5f-fa1e-41e6-a7c2-5af042b0828e@gmail.com>
 <431e1af1-6043-4e3e-bc3b-5998ec366de7@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <431e1af1-6043-4e3e-bc3b-5998ec366de7@blackwall.org>
X-Last-TLS-Session-Version: TLSv1.3

Sorry for chiming in so late in this conversation, missed it due
to the mailing list address change and how my procmail sorts
things...

First of all, many thanks Joseph for looking into this! I think I
agree with you that there is an actual RFC4541 compatiblity
issue for multicast offloading switches which (try to) use
the kernel space Linux bridge IGMP/MLD snooping code. For both
routable and non-routable multicast traffic.


I see a lot of confusion and misunderstandings in this thread. And
initially got very confused by the cover letter, too, and needed to
recheck the MCAST_FLOOD flag behaviour in the code and in practice :-).

> There is a use case where one would like to enable multicast snooping
> on a bridge but disable multicast flooding on all bridge ports so that
> registered multicast traffic will only reach the intended recipients and
> unregistered multicast traffic will be dropped.

To clarify for others: This is exactly what the Linux bridge does
right now. With bridge multicast snooping enabled and active
(a querier is present) any snoopable, unregistered (no MDB entry)
IP multicast payload traffic will only be forwarded to ports which
were either manually set to a multicast router port or where a
multicast router was detected via IGMP/MLD query, MRD or PIM
snooping. And if no such port exists, will be dropped.

The current per port MCAST_FLOOD flag implementation does not change this
behaviour. Its current (unfortunately not very well documented)
behaviour is basically, mainly to decide on what to do with packets
which the bridge multicast snooping code *can not* deal with / can
not learn about. Which can be because multicast snooping is
disabled, because there is no IGMP/MLD querier, because they are
IGMPv1/v2/MLDv1 packets, because they are not in the RFC4541
defined snoopable address ranges - or because it is a multicast
packet which is not an IP packet after all. The last case should
make it clear why the MCAST_FLOOD is 1/enabled by default. Which
might be a bit confusing/counterintuitive initially when
coming and thinking from the other, the IP snooping direction.

> bridge ports' mcast_flood flag implementation, it doesn't work as desired.

The important context to the "it doesn't work as desired"
can be found some lines later:
"3. A hardware offloading switch is involved".

The main issue seems that the learned or manually set multicast
router ports in the Linux bridge are not propagated down to the
actual multicast offloading switches. And therefore these switches
won't be able to follow RFC4541, which will potentially lead to
packet loss for multicast packets, both routable ones - as
multicast routers are not detected - but also for non-routable ones
due to potential IGMPv1/v2/MLDv1 report suppression.
This is the main issue this patchset tries to tackle, making
multicast offloading switches with kernelspace IGMP/MLD snooping
RFC4541 compliant, I believe?

-----

> [PATCH RFC net-next 03/10] net: bridge: Always flood local subnet mc packets
> ...
> If multicast flooding is disabled on a bridge port, local subnet multicast
> packets from the bridge will not be forwarded out of that port, even if
> IGMP snooping is running and the hosts beyond the bridge port are sending
> Reports to join these groups (e.g., 224.0.0.251)

This is a fix for a regression which patch 01/10 introduced in the first place

> [PATCH RFC net-next 02/10] net: bridge: Always multicast_flood Reports
> ...
> Fixes: b00589af3b04 ("bridge: disable snooping if there is no querier")

This is a regression of patch 01/10, the "Fixes" line is
incorrect.


> [PATCH RFC net-next 09/10] net: dsa: mv88e6xxx: Enable mc flood for mrouter port

So this is what the idea of repurposing/redefining of MCAST_FLOOD
ultimately comes down to, I guess?

I'm wondering, shouldn't the information you're looking for already
be available inside the Linux bridge as is? As it
right now correctly knows when to flood on a port?
Hm, would it maybe alternatively be possible to somehow call the
new dsa_switch_ops.port_mrouter you're adding - which
seems to be a missing, key part to fix this in the DSA API -
from for instance br_port_mc_router_state_change() instead?
Without needing any new or redefined state or knob in the
Linux bridge?

I'm also not quite sure yet what effect your proposed changes to
the MCAST_FLOOD knob would have to non-IP multicast packets -
could it break them?

-----

For the discussion regarding more knobs for a more fine-grained
control for flooding various types of packets: I agree that would
be nice to have. But I don't think it's necessary to fix the
original issue which Joseph tries to address.

Also I think they maybe should be added afterwards, after fixing
the issue with offloading switches? As already as is the port
MCAST_FLOOD and BR_INPUT_SKB_CB(skb)->mrouters_only flags
interactions are quite hard to follow and confusing in the
Linux bridge code (qed.?).

Regards, Linus


PS: Also adding Jan Hoffmann, Birger Koblitz and
Sebastian Gottschall to CC, as they seem to have been working on
getting such a feature running in OpenWrt/DD-Wrt for rtl83xx
DSA switches, too.

