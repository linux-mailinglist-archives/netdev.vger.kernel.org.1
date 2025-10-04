Return-Path: <netdev+bounces-227859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E4BB8EB9
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 16:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A4619C033C
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FD321D5BC;
	Sat,  4 Oct 2025 14:28:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25A21D3C5;
	Sat,  4 Oct 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588084; cv=none; b=pmSE8k8U5Aop+AB9T/AQz3IsDTQygio1fM4IKIOFYCUrWEvk1gHxGcO0/zWxc7+eo7XvrVeNth1Y+W3ZWMFcxXwoa9G6ShlKKmkJdipfo77EuGT0sz2TlND/MSQtGODszYTUvhYUH1NL1jlzZdMkxuPiEfvXP4Yive/jrVrPNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588084; c=relaxed/simple;
	bh=tl77jBe7fIPku8Z7eZo9//stu+k4QPsQ0UhsRrMUZ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAn7DlRGO3OyXVuYi3V5Q3sKzhdLye+NWOpQF5WvldcmJj28fd7ZkOBJtuXazZzTF8twWxRPe92KlVuCamb5ngUVzbUZ/rKm2MFshsuOnoPMH+AvC4hQH4iUpDUXOF5OI0gQZXWpdASWttdW6ipm0OpsE9vjtvoeGNSaoi3/afM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B85B954C477;
	Sat,  4 Oct 2025 16:27:55 +0200 (CEST)
Date: Sat, 4 Oct 2025 16:27:54 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Ido Schimmel <idosch@nvidia.com>
Cc: "Huang, Joseph" <joseph.huang.at.garmin@gmail.com>,
	Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net] net: bridge: Trigger host query on v6 addr valid
Message-ID: <aOEu6uQ4pP4PJH-y@sellars>
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
 <aMW2lvRboW_oPyyP@shredder>
 <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
 <aMqb63dWnYDZANdb@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMqb63dWnYDZANdb@shredder>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Sep 17, 2025 at 02:30:51PM +0300, Ido Schimmel wrote:
> But before making changes, I want to better understand the problem you
> are seeing. Is it specific to the offloaded data path? I believe the
> problem was fixed in the software data path by this commit:

Two issues I noticed recently, even without any hardware switch
offloading, on plain soft bridges:

1) (Probably not the issue here? But just to avoid that this
causes additional confusion:) we don't seem to properly converge to
the lowest MAC address, which is a bug, a violation of the RFCs.

If we received an IGMP/MLD query from a foreign host with an
address like fe80::2 and selected it and then enable our own
multicast querier with a lower address like fe80::1 on our bridge
interface for example then we won't send our queries, won't reelect
ourself. If I recall correctly. (Not too critical though, as at least we
have a querier on the link. But I find the election code a bit
confusing and I wouldn't dare to touch it without adding some tests.)

2) Without Ido's suggested workaround when the bridge multicast snooping
+ querier is enabled before the IPv6 DAD has taken place then our
first IGMP/MLD query will fizzle, not be transmitted.

However (at least for a non-hardware-offloaded) bridge as far as I
recall this shouldn't create any multicast packet loss and should
operate as "normal" with flooding multicast data packets first,
with multicast snooping activating on multicast data
after another IGMP/MLD querier interval has elapsed (default:
125 sec.)?

Which indeed could be optimized and is confusing, this delay could
be avoided. Is that that the issue you mean, Joseph?
(I'd consider it more an optimization, so for net-next, not
net though.)

> In current implementation, :: always wins the election

That would be news to me.

RFC2710, section 5:

   To be valid, the Query message MUST come from a link-
   local IPv6 Source Address

RFC3810, section 5.1.14, is even more explicit:

   5.1.14.  Source Addresses for Queries

   All MLDv2 Queries MUST be sent with a valid IPv6 link-local source
   address.  If a node (router or host) receives a Query message with
   the IPv6 Source Address set to the unspecified address (::), or any
   other address that is not a valid IPv6 link-local address, it MUST
   silently discard the message and SHOULD log a warning.

So :: can't be used as a source address for an MLD query.
And since 2014 with "bridge: multicast: add sanity check for query source addresses"
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6565b9eeef194afbb3beec80d6dd2447f4091f8c)
we should be adhering to that requirement? Let me know if I'm missing
something.

For IPv4 and 0.0.0.0 this is a different story though... I'm not
aware of a requirement in RFCs to avoid 0.0.0.0 in IGMP
queries. And "intuitively" one would prefer 0.0.0.0 to be the
least prefered querier address. But when taking the IGMP RFCs
literally then 0.0.0.0 would be the lowest one and always win... And RFC4541
unfortunately does not clarify the use of 0.0.0.0 for IGMP queries.
Not quite sure what the common practice among other layer 2 multicast
snooping implemetations across other vendos is.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0888d5f3c0f183ea6177355752ada433d370ac89
> 
> And Linus is working [1][2] on reflecting it to device drivers so that
> the hardware data path will act like the software data path and flood
> unregistered multicast traffic to all the ports as long as no querier
> was detected.

Right, for hardware offloading bridges/switches I'm on it, next
revision shouldn't take much longer...

Regards, Linus

