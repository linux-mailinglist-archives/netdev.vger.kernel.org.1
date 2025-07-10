Return-Path: <netdev+bounces-205935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC47B00D7D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B666C58759E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF502FD864;
	Thu, 10 Jul 2025 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQIuVnOE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB82FCE09
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181680; cv=none; b=rbd5suIQR2HLcVjQFYDEaOb8p9ZLWHuZ4NXKBoKvnSygw2fVvUGEhOaYgbTWwj72ddhniKkXZclD8OqaeT1ScSdludp8x8cRxLFwV7FSTRpkfskmvudDHV9ek2XjyxN54M5S7vLwRsDgCjHpaOsW6OvqA/xF6irTJ6F2YW7X5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181680; c=relaxed/simple;
	bh=H1IPeIccAnwjfs0WpZeHufMS44gCESa5qppZzC3iFek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=olLqGZH4OscOH47Cq8LIyAlquF7mweosjae97rHdGKLaFVzAwLx6Si/3BvMlqqF7Le24iXJtpX/JgyIqvdxsqF87jHVInlnj8AwLaLOaNB+uQo8JQAsAT6hjeTJUrLkWKuib7M/pgbLKIQ/ZHa32KhMU/o8fl0zSvMMqB6rX1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQIuVnOE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yGXmz048mjHAM/oCbqLFH8FBN50Fh1/awgsA+FR9KU=;
	b=LQIuVnOE9Tu/cfdxcYLzkF9UohfmFLdhcHdW2AjgDepOns2pv1GE/EMr4CrR0NFLKKY6Gm
	qECDM0U+NILVFP0P8ICVfIqfoHRJKFFvnjZvNMZeaLmpo25mSWjxOK4YqKJi93wbaagmaj
	e9Yl/GEHaMG9e70Uovr0bHijP5Q/N7w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-leZR9H6VP7Wh_FDAX61j0A-1; Thu,
 10 Jul 2025 17:07:53 -0400
X-MC-Unique: leZR9H6VP7Wh_FDAX61j0A-1
X-Mimecast-MFC-AGG-ID: leZR9H6VP7Wh_FDAX61j0A_1752181670
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8851A195609E;
	Thu, 10 Jul 2025 21:07:50 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E607730001A1;
	Thu, 10 Jul 2025 21:07:46 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: dev@openvswitch.org,  netdev@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  Mike Pattrick <mpattric@redhat.com>,
  Florian Westphal <fw@strlen.de>,  John Fastabend
 <john.fastabend@gmail.com>,  Jakub Sitnicki <jakub@cloudflare.com>,  Joe
 Stringer <joe@ovn.org>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map
 concept.
In-Reply-To: <CAG=2xmOXG_5da9+yX0z8hruTqgQxaHzRLVVHZU9M9cmZ475Qqw@mail.gmail.com>
	(=?utf-8?Q?=22Adri=C3=A1n?= Moreno"'s message of "Thu, 10 Jul 2025 02:35:26
 -0700")
References: <20250627210054.114417-1-aconole@redhat.com>
	<CAG=2xmOXG_5da9+yX0z8hruTqgQxaHzRLVVHZU9M9cmZ475Qqw@mail.gmail.com>
Date: Thu, 10 Jul 2025 17:07:45 -0400
Message-ID: <f7ttt3jpxem.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

> On Fri, Jun 27, 2025 at 05:00:54PM -0400, Aaron Conole wrote:
>> The Open vSwitch module allows a user to implemnt a flow-based
>> layer 2 virtual switch.  This is quite useful to model packet
>> movement analagous to programmable physical layer 2 switches.
>> But the openvswitch module doesn't always strictly operate at
>> layer 2, since it implements higher layer concerns, like
>> fragmentation reassembly, connection tracking, TTL
>> manipulations, etc.  Rightly so, it isn't *strictly* a layer
>> 2 virtual forwarding function.
>>
>> Other virtual forwarding technologies allow for additional
>> concepts that 'break' this strict layer separation beyond
>> what the openvswitch module provides.  The most handy one for
>> openvswitch to start looking at is the concept of the socket
>> map, from eBPF.  This is very useful for TCP connections,
>> since in many cases we will do container<->container
>> communication (although this can be generalized for the
>> phy->container case).
>>
>> This patch provides two different implementations of actions
>> that can be used to construct the same kind of socket map
>> capability within the openvswitch module.  There are additional
>> ways of supporting this concept that I've discussed offline,
>> but want to bring it all up for discussion on the mailing list.
>> This way, "spirited debate" can occur before I spend too much
>> time implementing specific userspace support for an approach
>> that may not be acceptable.  I did 'port' these from
>> implementations that I had done some preliminary testing with
>> but no guarantees that what is included actually works well.
>>
>> For all of these, they are implemented using raw access to
>> the tcp socket.  This isn't ideal, and a proper
>> implementation would reuse the psock infrastructure - but
>> I wanted to get something that we can all at least poke (fun)
>> at rather than just being purely theoretical.  Some of the
>> validation that we may need (for example re-writing the
>> packet's headers) have been omitted to hopefully make the
>> implementations a bit easier to parse.  The idea would be
>> to validate these in the validate_and_copy routines.
>>
>> The first option that I'll present is the suite of management
>> actions presented as:
>>   * sock(commit)
>>   * sock(try)
>>   * sock(tuple)
>>
>> These options would take a 5-tuple stamp of the IP packet
>> coming in, and preserve it as it traverses any packet
>> modifications, recirculations, etc.  The idea of how it would
>> look in the datapath might be something like:
>>
>>    + recirc_id(0),eth(src=3DXXXX,dst=3DYYYY),eth_type(0x800), \
>>    | ip(src=3Da.b.c.d,dst=3De.f.g.h,proto=3D6),tcp(sport=3DAA,dport=3DBB=
) \
>>    | actions:sock(tuple),sock(try,recirc(1))
>>    \
>>     + recirc_id(1),{match-action-pairs}
>>     ...
>>     + final-action: sock(commit, 2),output(2)
>>
>> When a packet enters ovs processing, it would have a tuple
>> saved, and then forwarded on to another recirc id (or any
>> other actions that might be desired).  For the first
>> packe, the sock(try,..) action will result in the
>> alternativet action list path being taken.  As the packet
>> is 'moving' through the flow table in the kernel, the
>> original tuple details for the socket map would not be
>> modified even if the flow key is updated and the physical
>> packet changed.  Finally, the sock(commit,2) will add
>> to the internal table that the stamped tuple should be
>> forwarded to the particular output port.
>>
>> The advantage to this suite of primitives is that the
>> userspace implementation may be a bit simpler.  Since
>> the table entries and management is done internally
>> by these actions, userspace is free to blanket adjust
>> all of the flows that are tcp destined for a specific
>> output port by inserting this special tuple/try set
>> without much additional logic for tracking
>> connections.  Another advantage is that the userspace
>> doesn't need to peer into a specific netns and pull
>> socket details to find matching tuples.
>
> What if there is no match on tcp headers at all? Would userspace also
> add these actions?

Well, for now we discard the kernel provided flow key, but that does
have the parsed details and we can use that.

> I guess you could argue that, if OVS is not being asked to do L4, this
> feature would not apply, but what if it's just the first flow that
> doesn't have an L4 match? How would userspace now how to add the action?

You can see my answer to Eelco, maybe it helps - but the idea is to work
by hooking the xlate layer's output.  There could be some kind of
additional work we need to do when the rules are more complex, as you
note (for instance looking in the xlate cache), but we should be able to
do this.

>>
>> However, it means we need to keep a separate mapping
>> table in the kernel, and that includes all the
>> tradeoffs of managing that table (not added in the
>> patch because it got too clunky are the workqueues
>> that would check the table to basically stop counters
>> based on the tcp state so the flow could get expired).
>>
>> The userspace work gets simpler, but the work being
>> done by the kernel space is much more difficult.
>>
>> Next is the simpler 'socket(net,ino)' action.  The
>> flows for this may look something a bit more like:
>>
>>    + recirc_id(0),eth(src=3DXXXX,dst=3DYYYY),eth_type(0x800), \
>>    | ip(src=3Da.b.c.d,dst=3De.f.g.h,proto=3D6),tcp(sport=3DAA,dport=3DBB=
) \
>>    | actions:socket(NS,INO,recirc(0x1))
>>
>> This is much more compact, but that hides what is
>> really needed to make this work.  Using the single
>> primitive would require that during upcall processing
>> the userspace is aware of the netns for the particular
>> packet.  When it is generating the flows, it can add
>> a socket call at the earliest flow possible when it
>> sees a socket that would be associated with the flow.
>>
>> The kernel then only needs to validate at the flow
>> installation time that the socket is valid.  However,
>> the userspace must do much more work.  It will need
>> to go back through the flows it generated and modify
>> them (or insert new flows) to take this path.  It
>> will have to peer into each netns and find the
>> corresponding socket inode, and program those.  If
>> it cannot find those details when the socket is
>> first added, it will probably not be able to add
>> these later (that's an implementation detail, but
>> at least it will lead to a slow ramp up).
>>
>> From a kernel perspective it is much easier.  We
>> keep a ref to the socket while the action is in
>> place, but that's all we need.  The
>> infrastructure needed is mostly all there, and
>> there aren't many new things we need to change
>> to make it work.
>>
>> So, it's much more work on the userspace side,
>> but much less 'intrusive' for the kernel.
>
> I'm quite intrigued by what would userspace have to do in this case.
> IIUC, it would have to:
> 1) Track all sockets created in all affected namespaces
> 2) Associate a socket with an upcalled packet
> 3) Carry this information throughout recirculations until an output
> action is detected and the destination socket found.

That's a way to do it, but it requires OVS to have a separate process
running to track the sockets as well.  I'd rather just get it at the
point we know we will output and then lookup the socket details and work
backwards.  That also means we don't need to preserve information across
controller callouts from the userspace side.

> 4) Traverse the recirculation chain backwards to find the first flow
> (recirc_id(0)) and modify it to add the socket action.

Yes, this recirc lookup needs to be thought out because we will
potentially need to get to the beginning of the chain - picking that is
important.  We could default to just using recirc_id(0) and then
doing a flow_mod on the start of the chain to have the right jump point.
Picking the start of chain is difficult - but I figured that just
choosing recirc_id(0) would be okay.

> Is that what you had in mind or am I completely off-track?

Sortof - hopefully I explained it a bit better.

> Thanks.
> Adri=C3=A1n


