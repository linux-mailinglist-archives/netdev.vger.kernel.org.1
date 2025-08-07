Return-Path: <netdev+bounces-212086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD82B1DCE9
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 20:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5B03B1ADA
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CF20299E;
	Thu,  7 Aug 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="sD24ZGn4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6QuXm11"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF51224B0D
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590226; cv=none; b=Bwv1oC5UtfwchB3ecrFNxa031OVQ3WkQstGvqld3TRqpX8bD/64NfeH/ANqYe7KX6MMKrmsir9RZvoXVm0nsGxN1DBnfYFbDpuODy7uWW+pf8K5IS5+SvI+0j8To8veVe9EvJESTiN6O7c5y4L1m4L/wgYc3TrBfABciORqrG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590226; c=relaxed/simple;
	bh=JBkq/9wV9uPzFqi3Jlzb0h9BZdIi6OdOf7LhG9tQrgk=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=dDHPIrYZMb/DQvwh+uKFvPx8t3yBQZgK4KFLZoQKXwrwzd7CMIvhdt0ed/AGwUvDG4rh3w36gPluerBOjvF9im5lK12E3wLjyFPRogUSpZjoDeEw026XfoUNw8m0ZH/ukOyGk4i7KQtV5AMU/2WCoFCFC6I1+mPF+dFMNLNmU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=sD24ZGn4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k6QuXm11; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 540B41D00259;
	Thu,  7 Aug 2025 14:10:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 14:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1754590222; x=1754676622; bh=hEmtbPHLb0C3xWJqZGZIARoxgxCkwv/J
	cyOO6Dza8H0=; b=sD24ZGn48OlWByVvdIuMUyZ9nUHOB2tTsQwIo3zvYSqc19B/
	eKKPcnWT4Ibnh92DAji+v8Nbt2he/Re7q8UcfzxVOFSaxcsPVAfTLEpU/bmBtEE8
	VBUx2f1i4jPZwmdmr7UcBvpBWT0lUDUDjecc8Hw25SD412+nY744/KbyMCK7jZwm
	4BXsSWSEnD1Owz89Lyh3bjbNDQsU3fR9oANiUDmGi7cVSKMkrsydaioAYUpS5C19
	5Bi8iA0OiVYSh99reqB9HJ8pKRO9DWoidS7uXBDZJv1MAqAXcKCplvA2UhYTCbdk
	bvLhAq9y2W9/bjWSKsiXV/txfNj+kVrtSpCFIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754590222; x=
	1754676622; bh=hEmtbPHLb0C3xWJqZGZIARoxgxCkwv/JcyOO6Dza8H0=; b=k
	6QuXm11YP9qmggNMsJVQN9qYb4Jo5yH8D25GmESN4Y56ph0ll9dQWgYR3kQaA9p0
	d5mc15le8cgoIVgX/eF4HkseBmeSiinrcrFa3JupRXV69TvzNJukaoK+6cH3VRgl
	Z/gj8zmvokJtXFTeEfOt+mu8myhBWp+gOCUNfpEBfcUmgsJU3+NpkkeOaG7e0PAK
	ZO3FuPc7mag1BX3l8V732E8Peewz6q0hfTK7m+nvFaC0Q4o9ekspip4EdGfOMUPp
	lVlMJA3yPJp4T0l9uyiDea5ZhjgIVj2cm15Nv9qqYjBray/NZdxRTIvAONxnmDcc
	3vX659oqYDV6sqSGpyw8A==
X-ME-Sender: <xms:DeyUaJoD8xvTDU849qjWzF3mHDUUfR0Y509DVKXfKsyMfqC2QU7fqg>
    <xme:DeyUaA1z60FpBcaWE1xXqzkeLD8vYvrtac3aqH-0W774rbi3ValKsDVl5rGISNt0N
    AamRZBnfnxH9uszO4E>
X-ME-Received: <xmr:DeyUaHGoUdGHFHwoe4l1w-MKP_3Vcc6DN9SGcq-CYRbgMKBdAc7GCklh6ek3Fd0KQTtwLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdtuddtfeffueehleegleeiuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtph
    htthhopehprhgruggvvghpsheslhhinhhugidrvhhnvghtrdhisghmrdgtohhmpdhrtghp
    thhtohepihdrmhgrgihimhgvthhssehovhhnrdhorhhgpdhrtghpthhtoheprghmohhrvg
    hnohiisehrvgguhhgrthdrtghomhdprhgtphhtthhopehprhgruggvvghpsehushdrihgs
    mhdrtghomhdprhgtphhtthhopeifihhluggvrhesuhhsrdhisghmrdgtohhmpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DeyUaLGOCUa8Rvib9wl0D3ixo57PaBULXh5FqNjdlBbSXeD2x0nUIA>
    <xmx:DeyUaK6nJKQtka5FZJMKQSjWllxF5sud0oFKmHCnxJcKA-ajeuJ1PQ>
    <xmx:DeyUaAyOx9HwWB-2RhQN_0hLgf6GTDB9CO7-qPlOK8HY9hD4xN1zTg>
    <xmx:DeyUaJP4MgQDLQyBa9W5_b9QFRu7afj2Gk-Op3Ha_8FSqyLRllLiHw>
    <xmx:DuyUaCGDidwJ-48ImrcPCZDb844K451nBah4Sb8-U3mCbO01jR8g7Zr_>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 14:10:21 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 27A039FCA5; Thu,  7 Aug 2025 11:10:20 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2485F9FC54;
	Thu,  7 Aug 2025 11:10:20 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David Wilder <wilder@us.ibm.com>
cc: Hangbin Liu <liuhangbin@gmail.com>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
    Pradeep Satyanarayana <pradeep@us.ibm.com>,
    "i.maximets@ovn.org" <i.maximets@ovn.org>,
    Adrian Moreno Zapata <amorenoz@redhat.com>
Subject: Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
In-reply-to: <MW3PR15MB3913268E49B5D040CFF75107FA2CA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com> <aGJkftXFL4Ggin_E@fedora> <MW3PR15MB391317D5FD3E0DCE1E592EE0FA46A@MW3PR15MB3913.namprd15.prod.outlook.com> <aGOKggdfjv0cApTO@fedora> <aJQtzYe0XyFAEKFz@fedora> <MW3PR15MB3913268E49B5D040CFF75107FA2CA@MW3PR15MB3913.namprd15.prod.outlook.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Thu, 07 Aug 2025 16:24:35 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Aug 2025 11:10:20 -0700
Message-ID: <603132.1754590220@famine>

David Wilder <wilder@us.ibm.com> wrote:

>From: Hangbin Liu <liuhangbin@gmail.com>
>Sent: Wednesday, August 6, 2025 9:38 PM
>To: David Wilder
>Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com;=
 Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata
>Subject: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_tar=
get format to allow for a list of vlan tags.
>
>Hi Hangbin
>
>> Hi David,
>> On Tue, Jul 01, 2025 at 07:13:06AM +0000, Hangbin Liu wrote:
>> > From: Hangbin Liu <liuhangbin@gmail.com>
>> > Sent: Monday, June 30, 2025 3:18 AM
>> > To: David Wilder
>> > Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.=
com; Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangb=
in Liu
>> > Subject: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip=
_target format to allow for a list of vlan tags.
>> >
>> > > On Fri, Jun 27, 2025 at 01:17:13PM -0700, David Wilder wrote:
>> > > I have run into issues with the ns_ip6_target feature.  I am unable =
to get
>> > > the existing code to function with vlans. Therefor I am unable to su=
pport
>> > > A this change for ns_ip6_target.
>> >
>> > > Any reason why this is incompatible with ns_ip6_target?
>> >
>> > Hi Hangbin
>> >
>> > I am unable to get the existing ns_ip6_target code to function when th=
e target
>> > is in a vlan. If the existing code is not working with vlans it makes =
no
>> > sense to specify the vlan tags.
>> >
>> > This is what I think is happening:
>> >
>> > In ns_send_all() we have this bit of code:
>> >
>> > dst =3D ip6_route_output(dev_net(bond->dev), NULL, &fl6);
>> > if (dst->error) {
>> >         dst_release(dst);
>> >         /* there's no route to target - try to send arp
>> >          * probe to generate any traffic (arp_validate=3D0)
>> >          */
>> >         if (bond->params.arp_validate)
>> >                bond_ns_send(slave, &targets[i], &in6addr_any, tags);
>> >                <.......>
>> >                continue;
>> > }
>> >
>> > ip6_route_output() is returning an error as there is no neighbor entry=
 for
>> > the target. A ns is then sent with no vlan header. I found that the
>> > multicast ns (with no vlan header) is not passed to the vlan siblings
>> > with the target address so no reply is sent.
>> >
>> > The ipv4 code is simmiler but the arp is sent as a brodcast. The broad=
cast arp
>> > will be propagated to the vlan sibling (in the linux vlan code).
>> >
>> > This could be a testing issue,  I am unsure.  Can you help with
>> > a test case with the target in a vlan?
>
>> I looked into this recently, and you are right =E2=80=94 ip6_route_outpu=
t() returns
>> an error dst. The root cause is that we cannot get the destination IPv6
>> address through the bond interface, because the source IPv6 address is
>> configured on other interfaces, the VLAN sub-interface.
>>
>> This is a key difference between IPv6 and IPv4:
>> In IPv4, it's possible to get a destination route via the bond even when=
 the
>> source IP is configured on a different interface. But in IPv6, the routi=
ng
>> mechanism is stricter in requiring the source address to be valid on the
>> outgoing interface.
>>
>> I'm not sure how to fix this yet, as it's fundamentally tied to how IPv6
>> routing behaves.
>
>I am thinking that we don't need to do a route lookup as if we are sending
>from the bonding interface.  We only need to find the interface we should
>send the packet through.  As if we ran "ip route get <dest addr>".

	Assuming I'm following correctly, the whole point of the route
lookup is to determine which interface the ARP (or NS for IPv6) should
nominally sent through (based on the destination address).  This serves
two purposes:

	- collecting the VLAN tags,

	- insuring that the ARP / NS won't be sent on a logically
incorrect interface (e.g., its address corresponds to some totally
unrelated interface).

	So, really, I'm agreed that what we're really looking for is
"what is the proper output interface to use to send to destination X,"
which we can then check to see if that interface is logically connected
to the bond (e.g., a VLAN atop the bond).

	Is the solution to call ip6_route_output() with the flowi6_oif
set to zero?  That seems to be what happens for the "ip route get" case
in inet6_rtm_getroute() (he says, looking at the code but not running
actual tests).

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net


