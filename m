Return-Path: <netdev+bounces-170022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC24A46E5A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E163A6DCE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5CD25BAC9;
	Wed, 26 Feb 2025 22:17:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5AB25BABD;
	Wed, 26 Feb 2025 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608275; cv=none; b=PeNr3SfBJZLMLR5TlfgAKmMR9tnEBegLlIp8HRkrwCS+wn1wt2tLhW5ziasi+GUWbQjBjJXnSEixa42dUVh6Ux2r+m25z8ALvOB5AO05u9UdrcBNWeA2U5cPYiR8eJpkP5yxeGz1XFab2RAovAwEClzKZ3pm8NcTFaCtwrSQrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608275; c=relaxed/simple;
	bh=ferVKhh06TlPVDqgV9LZurHR7vzDaHcpdeX6NQh2JDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYYAsyK6jhOtdcGh9dxFVIgfKOrGwR7szDV4EnAtzJMXEmWSGiVwXjLWIdr/gMccyrqxMIkKK0j9LPyiQlxLEGPnSH2wJFpHtYRro18oklF7jksvpRjDoR+0tEXc2UeDCltqeEJ7u480WV2843uywCso07rY+J+FF48Fl2f20G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F0AA54C42A;
	Wed, 26 Feb 2025 23:17:44 +0100 (CET)
Date: Wed, 26 Feb 2025 23:17:43 +0100
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
Message-ID: <Z7-TBwv6iDY-1uAm@sellars>
References: <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
 <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
 <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>
 <20240430012159.rmllu5s5gcdepjnc@skbuf>
 <b90caf5f-fa1e-41e6-a7c2-5af042b0828e@gmail.com>
 <431e1af1-6043-4e3e-bc3b-5998ec366de7@blackwall.org>
 <Z793qqMMvxKuFxbM@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z793qqMMvxKuFxbM@sellars>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Feb 26, 2025 at 09:20:58PM +0100, Linus Lüssing wrote:
> [...]
> The main issue seems that the learned or manually set multicast
> router ports in the Linux bridge are not propagated down to the
> actual multicast offloading switches.

Next to this issue I'm also wondering if the following might still
need addressing (which this patchset does not try to address?) to
support multicast offloading switches with kernelspace
IGMP/MLD snooping - or if there are some switch chips which do
not support this and hence won't be able to use kernelspace
IGMP/MLD snooping. A rough first attempt of a guideline/checklist:

Needed switch chip capabilities:

1) adding MDB entries to ports
2) adding multicast router ports
3) -> the switch chip must only apply these to
        a) IP packets with a matching protocol family
	   (ether type 0x0800 || 0x86DD) and:
        b.1) snoopable IP multicast address ranges
           (224.0.0.0/4 minus 224.0.0.0/24,
	    ff00::/8 minus ff02::1/128
	    IP destination addresses)
	   b.2) alternatively to b.1 (+a), but less
	   desirably a switch chip might match on layer 2:
	   01:00:5E:00:00:00, mask ff:ff:ff:f8:00:00
	   minus 01:00:5e:00:00:00, mask ff:ff:ff:ff:ff:00;
	   33:33:00:00:00:00, mask ff:ff:00:00:00:00
	   minus 33:33:00:00:00:01, mask ff:ff:ff:ff:ff:ff
	c.1) must *not* apply this to IGMP/MLD reports
	   (especially IGMPv1/v2/MLDv1 reports), they
	   must only be forwarded to the registered
	   multicast router ports *plus*
	   the CPU port / Linux bridge,
	   for the latter to be able to learn
	   c.2) may forward IGMP/MLD packets
	   only to the CPU port / Linux bridge,
	   if the Linux bridge (or DSA) can in turn
	   selectively forward the IGMP/MLD
	   to multicast router ports,
	   excluding the incoming port
	   -> DSA might need to inform the
	      Linux bridge about the
	      supported mode of the switch chip?
	(d) IGMP/MLD queries need to be flooded to
	   all ports by default, but they would not
	   match 3.b or 3.c.1 anyway; 3.c.2 may
	   match, then the Linux bridge (or DSA)
	   needs to make sure to reflect it back
	   to all ports excluding the incoming port
4) Any frame that did not match via 3) within the
   switch chip must by default be flooded to all ports
   4.1) this should be tunable and propagated from
        Linux bridge MCAST_FLOOD port flag to the
	switch chip
   4.2) if a switch chip cannot comply with 3) and
        has bridge port isolation enabled then
	the Linux bridge should perform multicast
	forwarding and IGMP/MLD snooping fully
	in kernelspace and return a warning
	about missing hardware support
   4.3) if a switch chip cannot adhere to neither 3) nor 4.2)
        then a user trying to enable bridge multicast snooping
	should be denied and return an error
	=> no incomplete hacks allowed, which might break
	   especially IP in specific scenarios


Would it maybe make sense to add some guideline/checklist like this,
which is more explicit than RFC4541 but should be compatible
to it, to Documentation/networking/dsa/dsa.rst?

(I'm not as familiar with DSA/switchdev/switch chips as
 with IP/IGMP/MLD/RFC4541 on layer 2+. So especially feedback
 from people more familiar with these lower layes would be
 appreciated.)

-----

Why I'm also wondering if a guideline might be useful because:

Saw this merging of multicast routers ports and MDB approach
discussion here:

https://lore.kernel.org/netdev/db38eb8f-9109-b142-6ef4-91df1c1c9de3@3e8.eu/

I have some suspicion what it might try to achieve, but am unsure
if that can work reliably in all scenarios.
Is this intended as a hack where the switch chip or DSA has no
support to configure multicast router ports?

If yes, what would happen if there is:

1) a layer 3 multicast router
2) a multicast sender with a routable destination address
3) no local multicast listener for 3), so no local reports
   for it?

Would neither an MDB nor a multicast router port be configured then?

Or with two multicast snooping switches, if one of them never sees
the according IGMP/MLD reports due to RFC4541 forwarding
restrictions?

Regards, Linus

