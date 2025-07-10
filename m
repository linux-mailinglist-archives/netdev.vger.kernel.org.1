Return-Path: <netdev+bounces-205933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD3B00D73
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D044E7BAF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A02FC3D3;
	Thu, 10 Jul 2025 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOoT3EOM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91B194124
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181119; cv=none; b=EWBHUPOv7jTD2JUBELcM+fm9+zCg61gQ1Vwlojgpw1b8HmQ6Fohf7c9Brp9+wXaBywhvKgYQww88E6GuWKn/Se7IAkaKBLrqjIGRHMVWU81J5eaUuzc5PnPNZxB3Jkdu3lUy5bOJoiNTRAQ8wq9zg1hxooRUUdUoq2ejbRzMmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181119; c=relaxed/simple;
	bh=LeBzDSXQm6hEg1m8ugnr5W6pqifQRiY6F7tVY3CCk/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPCVF1crDWlxbik8uNDWYiPwyJEQXqwVOEnkrAf0DaGklHdVqYrx/E5ycFhq9HnqRVErqsafrVjX97BipWU80x+YcpIXEiNeY5mny5TpwL1QJSH42/hlK6AfYR1tWstG4LjoAlRT8WNUPDBd83a1ZG3/drDUq27O5EqwEzZ6ULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOoT3EOM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iX9BMDj32qrhv8aJGtQzh7OnSxDpAFVDmDM0NuzLl8Q=;
	b=gOoT3EOMlF3cmII6pPemq29T1juFKBnexYGvw4PWDm4rp/QicbFxMFKIzUGRnhOQE3CNTS
	FCVy52OHdktK3A4ZVWZ78L1sV2rrUK8kTsT+9QLr37rlAuKyX+osHI5iQQl/a6uKLB7mwn
	OeYwmXjlkjxH6NVYd0iWJurzMUgOlRw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-MQN0Zf8YN9mrk9YEB-L6dA-1; Thu,
 10 Jul 2025 16:58:30 -0400
X-MC-Unique: MQN0Zf8YN9mrk9YEB-L6dA-1
X-Mimecast-MFC-AGG-ID: MQN0Zf8YN9mrk9YEB-L6dA_1752181109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831921809C86;
	Thu, 10 Jul 2025 20:58:28 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82CD61977029;
	Thu, 10 Jul 2025 20:58:24 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: dev@openvswitch.org,  netdev@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Ilya Maximets <i.maximets@ovn.org>,
  =?utf-8?Q?Adri=C3=A1n?=
 Moreno <amorenoz@redhat.com>,  Mike Pattrick <mpattric@redhat.com>,
  Florian Westphal <fw@strlen.de>,  John Fastabend
 <john.fastabend@gmail.com>,  Jakub Sitnicki <jakub@cloudflare.com>,  Joe
 Stringer <joe@ovn.org>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map
 concept.
In-Reply-To: <CAAF9568-4387-400A-A17F-116E187F5A2C@redhat.com> (Eelco
	Chaudron's message of "Fri, 04 Jul 2025 16:22:15 +0200")
References: <20250627210054.114417-1-aconole@redhat.com>
	<CAAF9568-4387-400A-A17F-116E187F5A2C@redhat.com>
Date: Thu, 10 Jul 2025 16:58:22 -0400
Message-ID: <f7ty0svpxu9.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Eelco Chaudron <echaudro@redhat.com> writes:

> On 27 Jun 2025, at 23:00, Aaron Conole wrote:
>
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
> Hi Aaron, thanks for putting all the work into researching this. Much app=
reciated!
>
> Looking at the two potential solutions above, I=E2=80=99m wondering how t=
hese would be implemented transparently, specifically, how OpenFlow rules g=
et translated into datapath rules.
>
> I understand this isn't part of the kernel-level implementation, but gett=
ing insight into this mapping would help me better understand how we could =
implement this in OVS. I'm asking because this touches quite a few isolated=
 OVS abstraction layers.

Thanks Eelco.  Here's the idea for userspace changes, (but not including
any code from it because it's a big set):

1. Extend dpif class to have an advertised "offloadable" output action
2. During xlate processing, when an output action is being generated for
   'current', check that the flow key and output could be offloaded.
3. If not, proceed as normal.
4. If so, modify 'current' recirc ID, insert 'current' flow.
5. Generate 'offload' flow (match->offload action) set, and install it
   along with the fallback jump to the 'unoffloaded' recirc ID.

As for the netlink dpif, we will look at the output port being proposed.
For the approach that uses the tuple/try/commit, we can just generate
the set of actions and flows a bit easier here.  We just 'do it' without
needing to look too much deeper.  For the sock(netns,inode,actions), it
needs to do additional work - I was thinking we peer into the netns on
the other side of the port and if there is a matching socket (it can be
in a SYN_SENT, or a TCP_ESTABLISHED state) for the tuple, we will add
the details there.  It gets a bit more complicated, because we may want
to get NAT details by looking at the ct_orig data in the flow - that
needs to be worked out a bit more.

> Also, with these datapath actions, it seems like we introduce some depend=
ency on TCP traffic. What happens if the matching traffic isn't TCP?

We won't select non-TCP traffic for this kind of offload (the idea is
that the userspace will be a first line of check, and that we will track
the matching prerequisites in the flow_netlink validate and ensure it
only works for traffic we can process).  That keeps the surface area
small.

> Would it be possible to give a concrete example using a simple set of Ope=
nFlow rules (see below)? I=E2=80=99m assuming we won=E2=80=99t need any Ope=
nFlow-specific actions for this to work.
>
> Take the following examples:
>
>  - Simple NORMAL rule:
> 	actions=3DNORMAL
>
>  - Simple two port back-2back traffic rule:
> 	"in_port=3Dpod1,eth_type(0x800),nw_src=3D10.0.0.1/32,action=3Dpod2=E2=80=
=9D
> 	"in_port=3Dpod2,eth_type(0x800),nw_src=3D10.0.0.2/32,action=3Dpod1=E2=80=
=9D

Are you looking for the new DP flows?  Something like the following
(this is from the testing I did with the proposed solution using)::

# Clear out and add ARP
ovs-dpctl.py del-flows dp-test
ovs-dpctl.py add-flow dp-test "in_port(2),eth(),eth_type(0x0806),arp()" "1"
ovs-dpctl.py add-flow dp-test "in_port(1),eth(),eth_type(0x0806),arp()" "2"

# These recirc id entries add to the sockmap and forward
ovs-dpctl.py add-flow dp-test \
	"recirc_id(0x11234),in_port(1),eth(),eth_type(0x800),ipv4(proto=3D6),tcp()=
,tcp_flags()" \
	"sock(commit,2),2"
ovs-dpctl.py add-flow dp-test \
	"recirc_id(0x21234),in_port(2),eth(),eth_type(0x800),ipv4(proto=3D6),tcp()=
,tcp_flags()" \
        "sock(commit,1),1"

# These recirc id entries let you ignore the sockmap
ovs-dpctl.py add-flow dp-test \
	"recirc_id(0x11233),in_port(1),eth(),eth_type(0x800),ipv4(proto=3D6),tcp()=
,tcp_flags()" \
	"2"
ovs-dpctl.py add-flow dp-test \
	"recirc_id(0x21233),in_port(2),eth(),eth_type(0x800),ipv4(proto=3D6),tcp()=
,tcp_flags()" \
        "1"


# CT lookups / NAT
ovs-dpctl.py add-flow dp-test \
        "recirc_id(0x1),ct_state(-trk),in_port(1),eth(),eth_type(0x0800),ip=
v4()" \
        "ct(commit,nat(src=3D192.168.0.20)),recirc(0x2)"
ovs-dpctl.py add-flow dp-test \
        "recirc_id(0x1),ct_state(-trk),in_port(2),eth(),eth_type(0x0800),ip=
v4()" \
        "ct(commit,nat(dst=3D172.31.110.1)),recirc(0x3)"

# CT Lookups / nat that goes through sockmap
ovs-dpctl.py add-flow dp-test \
        "recirc_id(0x11232),ct_state(-trk),in_port(1),eth(),eth_type(0x0800=
),ipv4()" \
        "ct(commit,nat(src=3D192.168.0.20)),recirc(0x11233)"
ovs-dpctl.py add-flow dp-test \
        "recirc_id(0x11232),ct_state(-trk),in_port(2),eth(),eth_type(0x0800=
),ipv4()" \
        "ct(commit,nat(dst=3D172.31.110.1)),recirc(0x11233)"

ovs-dpctl.py add-flow dp-test \
        "recirc_id(0x2),ct_state(+trk-inv),in_port(1),eth(),eth_type(0x0800=
),ipv4()" \
        "2"
ovs-dpctl.py add-flow dp-test \
        "recirc_id(0x3),ct_state(+trk-inv),in_port(2),eth(),eth_type(0x0800=
),ipv4()" \
        "1"

# Packet initial entry
ovs-dpctl.py add-flow dp-test \
	"recirc_id(0),in_port(1),eth(),eth_type(0x800),ipv4(),tcp_flags()" \
	"sock(tuple),sock(try,recirc=3D0x11234)"
ovs-dpctl.py add-flow dp-test \
        "recirc_id(0),in_port(2),eth(),eth_type(0x800),ipv4(),tcp_flags()" \
        "sock(tuple),sock(try,recirc=3D0x21234)"

This is with an older version I prototyped where the sock(try,..) didn't
use an action list, but just a recirc ID to make it a bit faster to
test.  With the above, I could adjust the path using the recirc IDs to
make it flow in different ways.

I don't have an example with the sock(netns,inode,acts) because I didn't
finish all of the userspace plumbing.  Before I went too far, I wanted
to get some outside opinion.

Hope it helps.

> Thanks,
>
> Eelco
>
>
>> A third option that we talked about, but that I
>> didn't implement is just adding XDP hooks into
>> the openvswitch datapath.  This gets difficult
>> for us because then the processing becomes
>> split.  For example, we'd need to coalesce
>> counters from an eBPF program that does the
>> forwarding, in addition to the normal flow path.
>> It requires lots of work from the userspace
>> AND from the kernel space.  We'd rather go with
>> an XDP datapath solution that we can completely
>> switch to - ie: do everything in eBPF by going
>> from openflow->eBPF rather than a difficult
>> hybrid approach.
>>
>> Finally, we also discussed just implementing
>> this without any flow rules or eBPF hooks at
>> all - ie: just looking at the packet when it
>> arrives and trying to forward at that moment.
>> It would require hooking the output action,
>> and maintaining a table in kernelspace (just
>> like the first approach outlined above), but
>> we rejected it for a few reasons:
>>   * That doesn't allow for any observability
>>   * It still needs lots of kernelspace work
>>   * It would make some flows 'disappear' that
>>     need to actually be visible for proper
>>     state tracking.
>>
>> There may be other approaches, but I wanted
>> to at least start the discussions in both
>> the kernel and userspace communities to
>> see if there can be some consensus on if/how
>> to move forward with the approach.  From a
>> forwarding performance perspective it does
>> have some merit.  On my local test system
>> doing a netns<->ovs<->netns forwarding with
>> iperf3 and approach one, I observed the
>> following results:
>>
>> Using apprach 1 (since I didn't finish all the
>> work I'd need to test approach 2 in userspace):
>>
>> Without the patch:
>>
>>>   [core@localhost ~]$ sudo ip netns exec left ./git/iperf3/src/iperf3 -s
>>>   -----------------------------------------------------------
>>>   Server listening on 5201 (test #1)
>>>   -----------------------------------------------------------
>>>   Accepted connection from 172.31.110.2, port 55942
>>>   [  5] local 172.31.110.1 port 5201 connected to 172.31.110.2 port 559=
56
>>>   [ ID] Interval           Transfer     Bitrate
>>>   [  5]   0.00-1.00   sec  8.40 GBytes  72.0 Gbits/sec
>>>   [  5]   1.00-2.00   sec  8.66 GBytes  74.4 Gbits/sec
>>>   [  5]   2.00-3.00   sec  8.52 GBytes  73.2 Gbits/sec
>>>   [  5]   3.00-4.00   sec  8.48 GBytes  72.9 Gbits/sec
>>>   [  5]   4.00-5.00   sec  8.60 GBytes  73.9 Gbits/sec
>>>   [  5]   5.00-6.00   sec  8.46 GBytes  72.7 Gbits/sec
>>>   [  5]   6.00-7.00   sec  8.46 GBytes  72.7 Gbits/sec
>>>   [  5]   7.00-8.00   sec  8.45 GBytes  72.6 Gbits/sec
>>>   [  5]   8.00-9.00   sec  8.39 GBytes  72.1 Gbits/sec
>>>   [  5]   9.00-10.00  sec  8.40 GBytes  72.2 Gbits/sec
>>>   - - - - - - - - - - - - - - - - - - - - - - - - -
>>>   [ ID] Interval           Transfer     Bitrate
>>>   [ 5] 0.00-10.00 sec 84.8 GBytes 72.9 Gbits/sec receiver
>>>   -----------------------------------------------------------
>>>   Server listening on 5201 (test #2)
>>>   -----------------------------------------------------------
>>
>> With the patch (just doing a simple case):
>>>   [core@localhost ~]$ sudo ip netns exec left ./git/iperf3/src/iperf3 -s
>>>   -----------------------------------------------------------
>>>   Server listening on 5201 (test #1)
>>>   -----------------------------------------------------------
>>>   Accepted connection from 172.31.110.2, port 50794
>>>   [  5] local 172.31.110.1 port 5201 connected to 172.31.110.2 port 508=
06
>>>   [ ID] Interval           Transfer     Bitrate
>>>   [  5]   0.00-1.00   sec  9.57 GBytes  82.1 Gbits/sec
>>>   [  5]   1.00-2.00   sec  9.49 GBytes  81.6 Gbits/sec
>>>   [  5]   2.00-3.00   sec  9.71 GBytes  83.4 Gbits/sec
>>>   [  5]   3.00-4.00   sec  9.75 GBytes  83.8 Gbits/sec
>>>   [  5]   4.00-5.00   sec  10.0 GBytes  86.3 Gbits/sec
>>>   [  5]   5.00-6.00   sec  9.95 GBytes  85.4 Gbits/sec
>>>   [  5]   6.00-7.00   sec  9.97 GBytes  85.7 Gbits/sec
>>>   [  5]   7.00-8.00   sec  10.0 GBytes  86.1 Gbits/sec
>>>   [  5]   8.00-9.00   sec  9.84 GBytes  84.5 Gbits/sec
>>>   [  5]   9.00-10.00  sec  9.95 GBytes  85.5 Gbits/sec
>>>   [  5]  10.00-10.00  sec   512 KBytes  11.0 Gbits/sec
>>>   - - - - - - - - - - - - - - - - - - - - - - - - -
>>>   [ ID] Interval           Transfer     Bitrate
>>>   [ 5] 0.00-10.00 sec 98.3 GBytes 84.4 Gbits/sec receiver
>>>   -----------------------------------------------------------
>>>   Server listening on 5201 (test #2)
>>>   -----------------------------------------------------------
>>
>> And I also did a test using a ct(nat) workflow (which was
>> the primary motivation - avoiding calls into conntrack):
>>
>>>   [core@localhost ~]$ sudo ip netns exec right ./git/iperf3/src/iperf3
>>>   [  5] local 172.31.110.1 port 5201 connected to 192.168.0.21 port 589=
60
>>>   [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
>>>   [  5]   0.00-1.00   sec  6.99 GBytes  59.9 Gbits/sec    0   4.11 MByt=
es
>>>   [  5]   1.00-2.00   sec  7.32 GBytes  62.9 Gbits/sec    0   4.11 MByt=
es
>>>   [  5]   2.00-3.00   sec  7.25 GBytes  62.2 Gbits/sec    0   4.11 MByt=
es
>>>   [  5]   3.00-4.00   sec  7.37 GBytes  63.4 Gbits/sec   41   4.11 MByt=
es
>>>   [  5]   4.00-5.00   sec  7.30 GBytes  62.6 Gbits/sec    0   4.11 MByt=
es
>>>   [  5]   5.00-6.00   sec  7.52 GBytes  64.7 Gbits/sec    0   4.11 MByt=
es
>>>   [  5]   6.00-7.00   sec  7.05 GBytes  60.5 Gbits/sec    0   4.11 MByt=
es
>>>   [  5]   7.00-8.00   sec  7.38 GBytes  63.4 Gbits/sec    0   4.11 MByt=
es
>>>   [  5]   8.00-9.00   sec  7.45 GBytes  63.9 Gbits/sec    0   4.11 MByt=
es
>>>   [  5]   9.00-10.00  sec  7.38 GBytes  63.5 Gbits/sec    0   4.11 MByt=
es
>>>   - - - - - - - - - - - - - - - - - - - - - - - - -
>>>   [ ID] Interval           Transfer     Bitrate         Retr
>>>   [  5]   0.00-10.00  sec  73.4 GBytes  63.0 Gbits/sec   41            =
sender
>>>   [  5]   0.00-10.00  sec  73.4 GBytes  63.0 Gbits/sec                 =
 receiver
>>
>> While the corresponding run with approach 1 in place looks almost
>> identical to the run with the patch above.  To test these, I also
>> modified ovs-dpctl.py in tools/testing/selftests/net/openvswitch
>> to support the new actions.
>>
>> Okay - that's about all for now.  Flames/comments/etc welcome!
>>
>> Signing-off-now: Aaron Conole <aconole@redhat.com>
>>
>> PS: Apologies for all of the issues with checkpatch.
>> ---
>>  include/uapi/linux/openvswitch.h |  36 ++++
>>  net/ipv4/tcp_ipv4.c              |   3 +-
>>  net/openvswitch/actions.c        | 311 +++++++++++++++++++++++++++++++
>>  net/openvswitch/datapath.h       |  48 +++++
>>  net/openvswitch/flow.h           |   6 +
>>  net/openvswitch/flow_netlink.c   | 206 +++++++++++++++++++-
>>  net/openvswitch/vport.c          |   2 +
>>  7 files changed, 610 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openv=
switch.h
>> index 3a701bd1f31b..f7eb3b4053ec 100644
>> --- a/include/uapi/linux/openvswitch.h
>> +++ b/include/uapi/linux/openvswitch.h
>> @@ -940,6 +940,26 @@ enum ovs_psample_attr {
>>
>>  #define OVS_PSAMPLE_ATTR_MAX (__OVS_PSAMPLE_ATTR_MAX - 1)
>>
>> +enum ovs_sock_try_attr {
>> +	OVS_SOCK_TRY_ATTR_UNSPEC =3D 0,
>> +	OVS_SOCK_TRY_ATTR_NOT_FWD_ACTIONS, /* Actions list. */
>> +
>> +	__OVS_SOCK_TRY_ATTR_MAX
>> +};
>> +#define OVS_SOCK_TRY_ATTR_MAX (__OVS_SOCK_TRY_ATTR_MAX - 1)
>> +
>> +enum ovs_sock_fwd_attr {
>> +	OVS_SOCK_FWD_ATTR_UNSPEC =3D 0,
>> +	OVS_SOCK_FWD_ATTR_NET_ID,
>> +	OVS_SOCK_FWD_ATTR_SOCK_INODE,
>> +	OVS_SOCK_FWD_ATTR_SOCKET,
>> +	OVS_SOCK_FWD_ATTR_ACTIONS_IF_FAIL,
>> +
>> +	__OVS_SOCK_FWD_ATTR_MAX
>> +};
>> +
>> +#define OVS_SOCK_FWD_ATTR_MAX (__OVS_SOCK_FWD_ATTR_MAX - 1)
>> +
>>  /**
>>   * enum ovs_action_attr - Action types.
>>   *
>> @@ -1034,6 +1054,22 @@ enum ovs_action_attr {
>>  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
>>  	OVS_ACTION_ATTR_PSAMPLE,      /* Nested OVS_PSAMPLE_ATTR_*. */
>>
>> +	OVS_ACTION_ATTR_SOCK_TRY,     /* Attempt to find a socket in the map.
>> +				       * If an appropriate socket is found,
>> +				       * then the packet is forwarded and the
>> +				       * pipeline ends.  Otherwise, execute
>> +				       * the provided action list. */
>> +	OVS_ACTION_ATTR_SOCK_TUPLE,   /* Sets the socket map criteria to use
>> +					* the key's 5-tuple details. */
>> +	OVS_ACTION_ATTR_SOCK_ADD,     /* Looks at the port specified by u32,
>> +				       * and if possible tries to find a socket.  If
>> +				       * found, take a reference to the socket, and
>> +				       * populate the map with the last loaded sock
>> +				       *  tuple as a key, and the socket as value */
>> +	OVS_ACTION_ATTR_SOCK_FWD,     /* Forward to a socket inode.  When the
>> +				       * action is accepted by the kernel, it
>> +				       * will take a reference to the socket
>> +				       * and keep for the lifetime of the flow. */
>>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>>  				       * from userspace. */
>>
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 429fb34b075e..f43f905b1cb0 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const s=
truct tcp_md5sig_key *key,
>>  #endif
>>
>>  struct inet_hashinfo tcp_hashinfo;
>> +EXPORT_SYMBOL(tcp_hashinfo);
>>
>>  static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) =3D {
>>  	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
>> @@ -2143,7 +2144,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_bu=
ff *skb,
>>  	}
>>  	return false;
>>  }
>> -EXPORT_IPV6_MOD(tcp_add_backlog);
>> +EXPORT_SYMBOL_GPL(tcp_add_backlog);
>>
>>  int tcp_filter(struct sock *sk, struct sk_buff *skb)
>>  {
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 3add108340bf..223bc4b9a638 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/in6.h>
>>  #include <linux/if_arp.h>
>>  #include <linux/if_vlan.h>
>> +#include <linux/snmp.h>
>>
>>  #include <net/dst.h>
>>  #include <net/gso.h>
>> @@ -24,6 +25,9 @@
>>  #include <net/checksum.h>
>>  #include <net/dsfield.h>
>>  #include <net/mpls.h>
>> +#include <net/snmp.h>
>> +#include <net/sock.h>
>> +#include <net/tcp.h>
>>
>>  #if IS_ENABLED(CONFIG_PSAMPLE)
>>  #include <net/psample.h>
>> @@ -1310,6 +1314,284 @@ static void execute_psample(struct datapath *dp,=
 struct sk_buff *skb,
>>  {}
>>  #endif
>>
>> +static int ovs_cmp_sock_md(struct ovs_skb_sk_map_data *key,
>> +			   struct ovs_skb_sk_map_data *cmp)
>> +{
>> +	return (key && cmp && key->key_type =3D=3D cmp->key_type &&
>> +		(key->key_type !=3D OVS_SK_MAP_KEY_UNSET) &&
>> +		((key->key_type =3D=3D OVS_SK_MAP_KEY_INPUT_SOCKET_BASED &&
>> +		  key->key.input_socket =3D=3D cmp->key.input_socket) ||
>> +		 (key->key_type =3D=3D OVS_SK_MAP_KEY_TUPLE_BASED &&
>> +		  key->key.tuple.ip.ipv4.src =3D=3D cmp->key.tuple.ip.ipv4.src &&
>> +		  key->key.tuple.ip.ipv4.dst =3D=3D cmp->key.tuple.ip.ipv4.dst &&
>> +		  key->key.tuple.tp.src =3D=3D cmp->key.tuple.tp.src &&
>> +		  key->key.tuple.tp.dst =3D=3D cmp->key.tuple.tp.dst &&
>> +		  key->key.tuple.protocol =3D=3D cmp->key.tuple.protocol)));
>> +}
>> +
>> +static bool ovs_skbuff_validate_for_sockmap(struct sk_buff *skb, unsign=
ed int *hlen)
>> +{
>> +	unsigned int header_len;
>> +	struct ethhdr *eth;
>> +	struct tcphdr *tcp;
>> +	struct iphdr *ip;
>> +
>> +	if (!skb || skb->len <=3D sizeof(struct ethhdr))
>> +		return false;
>> +
>> +	eth =3D eth_hdr(skb);
>> +	if (!eth)
>> +		return false;
>> +
>> +	if (eth->h_proto !=3D htons(ETH_P_IP))
>> +		return false;
>> +
>> +	ip =3D ip_hdr(skb);
>> +	if (!ip || skb->len <=3D sizeof(struct ethhdr) + ip->ihl * 4)
>> +		return false;
>> +
>> +	if (ip->protocol !=3D IPPROTO_TCP)
>> +		return false;
>> +
>> +	tcp =3D tcp_hdr(skb);
>> +	if (!tcp ||
>> +	    skb->len <=3D sizeof(struct ethhdr) + ip->ihl * 4 + tcp->doff * 4)
>> +		return false;
>> +
>> +	header_len =3D sizeof(struct ethhdr) + ip->ihl * 4 + tcp->doff * 4;
>> +	if (hlen)
>> +		*hlen =3D header_len;
>> +
>> +	return true;
>> +}
>> +
>> +static int enqueue_skb_to_tcp_socket(struct sock *sk, struct sk_buff *s=
kb)
>> +{
>> +	size_t skb_doff =3D skb_transport_offset(skb), oiif;
>> +	struct tcphdr *tcph =3D tcp_hdr(skb);
>> +	struct iphdr *iph =3D ip_hdr(skb);
>> +	struct ovs_skb_cb oskb;
>> +	int ret =3D 0;
>> +
>> +	memcpy(&oskb, OVS_CB(skb), sizeof(oskb));
>> +
>> +	/* Setup for processing the TCP details */
>> +	skb_pull(skb, skb_doff);
>> +
>> +	IP_INC_STATS(sock_net(sk), IPSTATS_MIB_INPKTS);
>> +	TCP_INC_STATS(sock_net(sk), TCP_MIB_INSEGS);
>> +
>> +	/* Initialize TCP_SKB_CB(skb)->header.h4 to null */
>> +	memset(&TCP_SKB_CB(skb)->header.h4, 0,
>> +	       sizeof(TCP_SKB_CB(skb)->header.h4));
>> +
>> +	TCP_SKB_CB(skb)->seq =3D ntohl(tcph->seq);
>> +	TCP_SKB_CB(skb)->end_seq =3D (TCP_SKB_CB(skb)->seq + tcph->syn +
>> +				    tcph->fin + skb->len - tcph->doff * 4);
>> +	TCP_SKB_CB(skb)->ack_seq =3D ntohl(tcph->ack_seq);
>> +	TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_word(tcph);
>> +	TCP_SKB_CB(skb)->sacked =3D 0;  /* Clear SACK state */
>> +	TCP_SKB_CB(skb)->ip_dsfield =3D ipv4_get_dsfield(iph);
>> +	TCP_SKB_CB(skb)->has_rxtstamp =3D skb->tstamp ||
>> +	  skb_hwtstamps(skb)->hwtstamp;
>> +	oiif =3D skb->skb_iif;
>> +	bh_lock_sock_nested(sk);
>> +	tcp_segs_in(tcp_sk(sk), skb);
>> +	skb->skb_iif =3D sk->sk_rx_dst_ifindex;
>> +	TCP_SKB_CB(skb)->header.h4.iif =3D sk->sk_rx_dst_ifindex;
>> +	ret =3D 0;
>> +	if (!sock_owned_by_user(sk)) {
>> +		ret =3D tcp_v4_do_rcv(sk, skb);
>> +	} else {
>> +		enum skb_drop_reason drop_reason;
>> +
>> +		if (tcp_add_backlog(sk, skb, &drop_reason)) {
>> +			ret =3D -EAGAIN;
>> +			skb->skb_iif =3D oiif;
>> +			skb_push(skb, skb_doff);
>> +			memcpy(OVS_CB(skb), &oskb, sizeof(oskb));
>> +			goto tcp_add_done;
>> +		}
>> +	}
>> +tcp_add_done:
>> +	bh_unlock_sock(sk);
>> +	return ret;
>> +}
>> +
>> +static int execute_sock_try(struct datapath *dp, struct sk_buff *skb,
>> +			    struct sw_flow_key *key,
>> +			    const struct nlattr *a, bool last)
>> +{
>> +	struct dp_sk_mnode *n;
>> +
>> +	if (unlikely(!OVS_CB(skb)->sk_map_data) ||
>> +	    OVS_CB(skb)->sk_map_data->key_type =3D=3D OVS_SK_MAP_KEY_UNSET) {
>> +		net_warn_ratelimited("Attempt to use ovs sk_map without a valid tuple=
.\n");
>> +		goto not_forwarded;
>> +	}
>> +
>> +	list_for_each_entry(n, &dp->sock_list, list_node) {
>> +		if (ovs_cmp_sock_md(&n->key, OVS_CB(skb)->sk_map_data)) {
>> +			struct sock *sk =3D n->output_sock;
>> +			unsigned int pull_len =3D 0;
>> +			int ret;
>> +
>> +			if (!sk || sk->sk_state !=3D TCP_ESTABLISHED ||
>> +			    !ovs_skbuff_validate_for_sockmap(skb, &pull_len) ||
>> +			    (skb->pkt_type !=3D PACKET_HOST &&
>> +			     skb->pkt_type !=3D PACKET_OTHERHOST)) {
>> +				goto not_forwarded;
>> +			}
>> +
>> +			ret =3D enqueue_skb_to_tcp_socket(sk, skb);
>> +			if (ret =3D=3D -EAGAIN)
>> +				goto not_forwarded;
>> +
>> +			return ret;
>> +		}
>> +	}
>> +
>> +not_forwarded:
>> +	return clone_execute(dp, skb, key, 0, nla_data(a), nla_len(a),
>> +			     last, true);
>> +}
>> +
>> +static int execute_sock_fwd(struct datapath *dp, struct sk_buff *skb,
>> +			    struct sw_flow_key *key,
>> +			    const struct nlattr *a, bool last)
>> +{
>> +	const struct nlattr *actions, *sfw_arg;
>> +	const struct ovs_key_socket *arg;
>> +	int ret, rem =3D nla_len(a);
>> +
>> +	sfw_arg =3D nla_data(a);
>> +	arg =3D nla_data(sfw_arg);
>> +
>> +	ret =3D enqueue_skb_to_tcp_socket(arg->output_sock, skb);
>> +	if (ret =3D=3D -EAGAIN)
>> +		goto not_forwarded;
>> +
>> +	return ret;
>> +
>> +not_forwarded:
>> +	actions =3D nla_next(sfw_arg, &rem);
>> +	return clone_execute(dp, skb, key, 0, nla_data(actions),
>> +			     nla_len(actions), last, true);
>> +}
>> +
>> +static struct sock *get_socket(struct net *net, __be32 saddr, __be16 sp=
ort,
>> +			       __be32 daddr, __be16 dport, u32 idx, bool ref)
>> +{
>> +	struct sock *sk =3D NULL;
>> +	struct inet_hashinfo *hashinfo =3D &tcp_hashinfo;
>> +	spinlock_t *lock; /* Locking for the tcphash */
>> +	u32 hash;
>> +
>> +	hash =3D inet_ehashfn(net, daddr, dport, saddr, sport);
>> +	lock =3D inet_ehash_lockp(hashinfo, hash);
>> +
>> +	spin_lock_bh(lock);
>> +	sk =3D __inet_lookup_established(net, hashinfo, saddr, sport, daddr,
>> +				       dport, idx, 0);
>> +	/* take a reference to the socket while under the lock. */
>> +	if (sk && sk->sk_state =3D=3D TCP_ESTABLISHED && ref)
>> +		sock_hold(sk);
>> +	else
>> +		sk =3D NULL;
>> +	spin_unlock_bh(lock);
>> +
>> +	/* At this point the caller has a valid reference to the socket. */
>> +	return sk && sk->sk_state =3D=3D TCP_ESTABLISHED ? sk : NULL;
>> +}
>> +
>> +static int execute_ovs_sk_map_metadata(struct sk_buff *skb,
>> +				       struct sw_flow_key *key)
>> +{
>> +	struct ovs_skb_sk_map_data *skmd =3D OVS_CB(skb)->sk_map_data;
>> +
>> +	/* for now, only ipv4 tcp - more to follow */
>> +	if (key->ip.proto !=3D IPPROTO_TCP || skb->protocol !=3D htons(ETH_P_I=
P))
>> +		return 0;
>> +
>> +	/* Never override the input socket mapping, as it is the
>> +	 * preferred key.
>> +	 */
>> +	if (skmd->key_type =3D=3D OVS_SK_MAP_KEY_INPUT_SOCKET_BASED &&
>> +	    skmd->key.input_socket) {
>> +		return 0;
>> +	}
>> +
>> +	/* XXX: Add support for ipv6 and input socket; this just handles v4 */
>> +	skmd->key_type =3D OVS_SK_MAP_KEY_TUPLE_BASED;
>> +	skmd->key.tuple.ip.ipv4.src =3D key->ipv4.addr.src;
>> +	skmd->key.tuple.ip.ipv4.dst =3D key->ipv4.addr.dst;
>> +	skmd->key.tuple.tp.src =3D key->tp.src;
>> +	skmd->key.tuple.tp.dst =3D key->tp.dst;
>> +	skmd->key.tuple.protocol =3D key->ip.proto;
>> +	return 0;
>> +}
>> +
>> +/* lookup a socket in the output port specified by 'port'.  If found, u=
se
>> + * the metadata as a key to insert into the list.
>> + */
>> +static int execute_ovs_add_sock(struct datapath *dp, struct sk_buff *sk=
b,
>> +				struct sw_flow_key *key,
>> +				u32 port)
>> +{
>> +	struct ovs_skb_sk_map_data *skmd =3D OVS_CB(skb)->sk_map_data;
>> +	struct vport *vport =3D ovs_vport_rcu(dp, port);
>> +	struct sock *sock =3D NULL;
>> +
>> +	if (!skmd)
>> +		return -EINVAL;
>> +
>> +	if (likely(vport && netif_running(vport->dev) &&
>> +		   netif_carrier_ok(vport->dev)) &&
>> +	    vport->dev->rtnl_link_ops &&
>> +	    vport->dev->rtnl_link_ops->get_link_net) {
>> +		struct net *ns;
>> +		u32 ifindex;
>> +
>> +		ns =3D vport->dev->rtnl_link_ops->get_link_net(vport->dev);
>> +		ifindex =3D inet_sdif(skb);
>> +		sock =3D get_socket(ns,
>> +				  key->ipv4.addr.src, key->tp.src,
>> +				  key->ipv4.addr.dst, htons(key->tp.dst),
>> +				  ifindex, true);
>> +	}
>> +
>> +	if (sock) {
>> +		struct dp_sk_mnode *node;
>> +		struct dp_sk_mnode *n;
>> +
>> +		list_for_each_entry(n, &dp->sock_list, list_node) {
>> +			if (ovs_cmp_sock_md(&n->key,
>> +					    OVS_CB(skb)->sk_map_data)) {
>> +				/* get_socket above took a ref, so must
>> +				 * actually close it here.
>> +				 */
>> +				sock_put(sock);
>> +				return 0;
>> +			}
>> +		}
>> +
>> +		node =3D kzalloc(sizeof(*node), GFP_ATOMIC);
>> +		if (!node) {
>> +			/* get_socket above took a ref, so must actually close
>> +			 * it here.
>> +			 */
>> +			sock_put(sock);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		node->key =3D *OVS_CB(skb)->sk_map_data;
>> +		node->output_sock =3D sock;
>> +		list_add(&node->list_node, &dp->sock_list);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /* Execute a list of actions against 'skb'. */
>>  static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>  			      struct sw_flow_key *key,
>> @@ -1522,6 +1804,35 @@ static int do_execute_actions(struct datapath *dp=
, struct sk_buff *skb,
>>  				return 0;
>>  			}
>>  			break;
>> +
>> +		case OVS_ACTION_ATTR_SOCK_TRY: {
>> +			bool last =3D nla_is_last(a, rem);
>> +
>> +			err =3D execute_sock_try(dp, skb, key, a, last);
>> +			if (last) {
>> +				/* If this is the last action, the skb has
>> +				 * been consumed or freed.
>> +				 * Return immediately.
>> +				 */
>> +				return err;
>> +			}
>> +			break;
>> +		}
>> +
>> +		case OVS_ACTION_ATTR_SOCK_TUPLE:
>> +			err =3D execute_ovs_sk_map_metadata(skb, key);
>> +			break;
>> +
>> +		case OVS_ACTION_ATTR_SOCK_ADD:
>> +			err =3D execute_ovs_add_sock(dp, skb, key, nla_get_u32(a));
>> +			break;
>> +		case OVS_ACTION_ATTR_SOCK_FWD:
>> +			bool last =3D nla_is_last(a, rem);
>> +
>> +			err =3D execute_sock_fwd(dp, skb, key, a, last);
>> +			if (last) {
>> +				return err;
>> +			}
>>  		}
>>
>>  		if (unlikely(err)) {
>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>> index cfeb817a1889..90279cb0adbd 100644
>> --- a/net/openvswitch/datapath.h
>> +++ b/net/openvswitch/datapath.h
>> @@ -67,6 +67,50 @@ struct dp_nlsk_pids {
>>  	u32 pids[];
>>  };
>>
>> +enum ovs_sk_map_key_select {
>> +	OVS_SK_MAP_KEY_UNSET,
>> +	OVS_SK_MAP_KEY_INPUT_SOCKET_BASED,
>> +	OVS_SK_MAP_KEY_TUPLE_BASED,
>> +
>> +	OVS_SK_MAP_KEY_MAX__
>> +};
>> +
>> +/**
>> + * struct ovs_skb_sk_map_data - OVS SK Map lookup data
>> + * @key_type: Select whether to use input_socket based map or use the 5=
-tuple.
>> + * @key: Union of input_socket vs 5-tuple.
>> + */
>> +struct ovs_skb_sk_map_data {
>> +	enum ovs_sk_map_key_select key_type;
>> +	union {
>> +		struct sock *input_socket;
>> +		struct {
>> +			union {
>> +				struct {
>> +					__be32 src;	/* IP4 source address. */
>> +					__be32 dst;	/* IP4 destination address. */
>> +				} ipv4;
>> +				struct {
>> +					struct in6_addr src;	/* IP6 source address. */
>> +					struct in6_addr dst;	/* IP6 destination address. */
>> +					__be32 label;		/* IP6 flow labe. */
>> +				} ipv6;
>> +			} ip;
>> +			struct {
>> +				__be16 src;	/* TCP/UDP/SCTP src port. */
>> +				__be16 dst;	/* TCP/UDP/SCTP dst port. */
>> +			} tp;
>> +			u8 protocol;		/* IPPROTO_*. */
>> +		} tuple;
>> +	} key;
>> +};
>> +
>> +struct dp_sk_mnode {
>> +	struct list_head		list_node;
>> +	struct ovs_skb_sk_map_data	key;
>> +	struct sock			*output_sock;
>> +};
>> +
>>  /**
>>   * struct datapath - datapath for flow-based packet switching
>>   * @rcu: RCU callback head for deferred destruction.
>> @@ -109,6 +153,9 @@ struct datapath {
>>  	struct dp_meter_table meter_tbl;
>>
>>  	struct dp_nlsk_pids __rcu *upcall_portids;
>> +
>> +	/* Socket list */
>> +	struct list_head sock_list;
>>  };
>>
>>  /**
>> @@ -128,6 +175,7 @@ struct ovs_skb_cb {
>>  	u16			acts_origlen;
>>  	u32			cutlen;
>>  	u32			probability;
>> +	struct ovs_skb_sk_map_data *sk_map_data;
>>  };
>>  #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
>>
>> diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
>> index b5711aff6e76..c797f0a23e57 100644
>> --- a/net/openvswitch/flow.h
>> +++ b/net/openvswitch/flow.h
>> @@ -72,6 +72,12 @@ struct ovs_key_nsh {
>>  	__be32 context[NSH_MD1_CONTEXT_SIZE];
>>  };
>>
>> +struct ovs_key_socket {
>> +	u32		netns_id;
>> +	u32		socket_inode;
>> +	struct sock	*output_sock;
>> +};
>> +
>>  struct sw_flow_key {
>>  	u8 tun_opts[IP_TUNNEL_OPTS_MAX];
>>  	u8 tun_opts_len;
>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netli=
nk.c
>> index ad64bb9ab5e2..d86e53a2618a 100644
>> --- a/net/openvswitch/flow_netlink.c
>> +++ b/net/openvswitch/flow_netlink.c
>> @@ -34,6 +34,7 @@
>>  #include <net/ipv6.h>
>>  #include <net/ndisc.h>
>>  #include <net/mpls.h>
>> +#include <net/tcp.h>
>>  #include <net/vxlan.h>
>>  #include <net/tun_proto.h>
>>  #include <net/erspan.h>
>> @@ -65,6 +66,8 @@ static bool actions_may_change_flow(const struct nlatt=
r *actions)
>>  		case OVS_ACTION_ATTR_USERSPACE:
>>  		case OVS_ACTION_ATTR_DROP:
>>  		case OVS_ACTION_ATTR_PSAMPLE:
>> +		case OVS_ACTION_ATTR_SOCK_TUPLE:
>> +		case OVS_ACTION_ATTR_SOCK_ADD:
>>  			break;
>>
>>  		case OVS_ACTION_ATTR_CT:
>> @@ -85,6 +88,7 @@ static bool actions_may_change_flow(const struct nlatt=
r *actions)
>>  		case OVS_ACTION_ATTR_CHECK_PKT_LEN:
>>  		case OVS_ACTION_ATTR_ADD_MPLS:
>>  		case OVS_ACTION_ATTR_DEC_TTL:
>> +		case OVS_ACTION_ATTR_SOCK_TRY:
>>  		default:
>>  			return true;
>>  		}
>> @@ -2398,6 +2402,40 @@ static void ovs_nla_free_set_action(const struct =
nlattr *a)
>>  	}
>>  }
>>
>> +static void ovs_nla_free_sock_try_action(const struct nlattr *attrs)
>> +{
>> +	const struct nlattr *a;
>> +	int rem;
>> +
>> +	nla_for_each_nested(a, attrs, rem) {
>> +		switch (nla_type(a)) {
>> +		case OVS_SOCK_TRY_ATTR_NOT_FWD_ACTIONS:
>> +			ovs_nla_free_nested_actions(nla_data(a), nla_len(a));
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static void ovs_nla_free_sock_fwd(const struct nlattr *attrs)
>> +{
>> +	const struct nlattr *a;
>> +	int rem;
>> +
>> +	nla_for_each_nested(a, attrs, rem) {
>> +		switch (nla_type(a)) {
>> +		case OVS_SOCK_FWD_ATTR_SOCKET: {
>> +			struct ovs_key_socket *ks =3D nla_data(a);
>> +
>> +			sock_put(ks->output_sock);
>> +		}
>> +			break;
>> +		case OVS_SOCK_FWD_ATTR_ACTIONS_IF_FAIL:
>> +			ovs_nla_free_nested_actions(nla_data(a), nla_len(a));
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>>  static void ovs_nla_free_nested_actions(const struct nlattr *actions, i=
nt len)
>>  {
>>  	const struct nlattr *a;
>> @@ -2406,7 +2444,7 @@ static void ovs_nla_free_nested_actions(const stru=
ct nlattr *actions, int len)
>>  	/* Whenever new actions are added, the need to update this
>>  	 * function should be considered.
>>  	 */
>> -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 25);
>> +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 29);
>>
>>  	if (!actions)
>>  		return;
>> @@ -2436,6 +2474,14 @@ static void ovs_nla_free_nested_actions(const str=
uct nlattr *actions, int len)
>>  		case OVS_ACTION_ATTR_SET:
>>  			ovs_nla_free_set_action(a);
>>  			break;
>> +
>> +		case OVS_ACTION_ATTR_SOCK_TRY:
>> +			ovs_nla_free_sock_try_action(a);
>> +			break;
>> +
>> +		case OVS_ACTION_ATTR_SOCK_FWD:
>> +			ovs_nla_free_sock_fwd(a);
>> +			break;
>>  		}
>>  	}
>>  }
>> @@ -3169,6 +3215,114 @@ static int validate_psample(const struct nlattr =
*attr)
>>  	return a[OVS_PSAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
>>  }
>>
>> +static const struct nla_policy sockfwd_policy[OVS_SOCK_FWD_ATTR_MAX + 1=
] =3D {
>> +	[OVS_SOCK_FWD_ATTR_NET_ID] =3D {.type =3D NLA_U32 },
>> +	[OVS_SOCK_FWD_ATTR_SOCK_INODE] =3D {.type =3D NLA_U32 },
>> +	[OVS_SOCK_FWD_ATTR_SOCKET] =3D {.type =3D NLA_UNSPEC },
>> +	[OVS_SOCK_FWD_ATTR_ACTIONS_IF_FAIL] =3D {.type =3D NLA_NESTED },
>> +};
>> +
>> +static int validate_and_copy_sock_fwd(struct net *net,
>> +				      const struct nlattr *attr,
>> +				      const struct sw_flow_key *key,
>> +				      struct sw_flow_actions **sfa,
>> +				      __be16 eth_type, __be16 vlan_tci,
>> +				      u32 mpls_label_count,
>> +				      bool log, bool last, u32 depth)
>> +{
>> +	struct nlattr *a[OVS_SOCK_FWD_ATTR_MAX + 1];
>> +	const struct nlattr *acts_if_fail;
>> +	struct ovs_key_socket osk;
>> +
>> +	int nested_acts_start;
>> +	int start, err;
>> +
>> +	err =3D nla_parse_deprecated_strict(a, OVS_SOCK_FWD_ATTR_MAX,
>> +					  nla_data(attr), nla_len(attr),
>> +					  sockfwd_policy, NULL);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Must specify netID and inode */
>> +	if (!a[OVS_SOCK_FWD_ATTR_NET_ID] || !a[OVS_SOCK_FWD_ATTR_SOCK_INODE])
>> +		return -EINVAL;
>> +
>> +	/* Internally passed. */
>> +	if (a[OVS_SOCK_FWD_ATTR_SOCKET])
>> +		return -EINVAL;
>> +
>> +	osk.netns_id =3D nla_get_u32(a[OVS_SOCK_FWD_ATTR_NET_ID]);
>> +	osk.socket_inode =3D nla_get_u32(a[OVS_SOCK_FWD_ATTR_SOCK_INODE]);
>> +	osk.output_sock =3D NULL;
>> +
>> +	/* lookup the socket and lock it. */
>> +	rcu_read_lock();
>> +	for_each_net_rcu(net) {
>> +		struct hlist_nulls_node *node;
>> +		struct sock *sk;
>> +		size_t i;
>> +
>> +		if (net->ns.inum !=3D osk.netns_id)
>> +			continue;
>> +
>> +		for (i =3D 0; i < tcp_hashinfo.ehash_mask + 1; i++) {
>> +			hlist_nulls_for_each_entry_rcu(sk, node,
>> +						       &tcp_hashinfo.ehash[i].chain,
>> +						       sk_nulls_node) {
>> +				if (!sk_fullsock(sk) ||
>> +				    (sk->sk_state !=3D TCP_ESTABLISHED &&
>> +				     sk->sk_state !=3D TCP_SYN_SENT &&
>> +				     sk->sk_state !=3D TCP_SYN_RECV))
>> +					continue;
>> +				if (sk->sk_socket && sk->sk_socket->file &&
>> +				    sk->sk_socket->file->f_inode &&
>> +				    sk->sk_socket->file->f_inode->i_ino =3D=3D
>> +				    osk.socket_inode)) {
>> +					osk.output_sock =3D sk;
>> +					sock_hold(sk);
>> +					goto found;
>> +				}
>> +			}
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	/* Nothing allocated, return an error now. */
>> +	goto failed;
>> +
>> +found:
>> +	start =3D add_nested_action_start(sfa, OVS_ACTION_ATTR_SOCK_FWD,
>> +					log);
>> +	if (start < 0)
>> +		goto failed;
>> +
>> +	err =3D ovs_nla_add_action(sfa, OVS_SOCK_FWD_ATTR_SOCKET, &osk,
>> +				 sizeof(osk), log);
>> +	if (err)
>> +		goto failed;
>> +
>> +	nested_acts_start =3D add_nested_action_start(sfa,
>> +		    OVS_SOCK_FWD_ATTR_ACTIONS_IF_FAIL, log);
>> +	if (nested_acts_start < 0)
>> +		goto failed;
>> +
>> +	err =3D __ovs_nla_copy_actions(net, acts_if_fail, key, sfa,
>> +				     eth_type, vlan_tci, mpls_label_count, log,
>> +				     depth + 1);
>> +	if (err)
>> +		goto failed;
>> +
>> +	add_nested_action_end(*sfa, nested_acts_start);
>> +	add_nested_action_end(*sfa, start);
>> +	return 0;
>> +
>> +failed:
>> +	if (osk.output_sock)
>> +		sock_put(osk.output_sock);
>> +
>> +	return -EINVAL;
>> +}
>> +
>>  static int copy_action(const struct nlattr *from,
>>  		       struct sw_flow_actions **sfa, bool log)
>>  {
>> @@ -3183,6 +3337,25 @@ static int copy_action(const struct nlattr *from,
>>  	return 0;
>>  }
>>
>> +static int validate_sock_try(const struct nlattr *attr)
>> +{
>> +	static const struct nla_policy sock_try_policy[OVS_SOCK_TRY_ATTR_MAX +=
 1] =3D {
>> +		[OVS_SOCK_TRY_ATTR_NOT_FWD_ACTIONS] =3D {.type =3D NLA_UNSPEC },
>> +	};
>> +	struct nlattr *a[OVS_SOCK_TRY_ATTR_MAX + 1];
>> +	int error;
>> +
>> +	/* populate the actions field. */
>> +	error =3D nla_parse_deprecated_strict(a, OVS_SOCK_TRY_ATTR_MAX,
>> +					    nla_data(attr), nla_len(attr),
>> +					    sock_try_policy, NULL);
>> +
>> +	if (!a[OVS_SOCK_TRY_ATTR_NOT_FWD_ACTIONS])
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>  static int __ovs_nla_copy_actions(struct net *net, const struct nlattr =
*attr,
>>  				  const struct sw_flow_key *key,
>>  				  struct sw_flow_actions **sfa,
>> @@ -3225,6 +3398,10 @@ static int __ovs_nla_copy_actions(struct net *net=
, const struct nlattr *attr,
>>  			[OVS_ACTION_ATTR_DEC_TTL] =3D (u32)-1,
>>  			[OVS_ACTION_ATTR_DROP] =3D sizeof(u32),
>>  			[OVS_ACTION_ATTR_PSAMPLE] =3D (u32)-1,
>> +			[OVS_ACTION_ATTR_SOCK_TRY] =3D (u32)-1,
>> +			[OVS_ACTION_ATTR_SOCK_TUPLE] =3D 0,
>> +			[OVS_ACTION_ATTR_SOCK_ADD] =3D sizeof(u32),
>> +			[OVS_ACTION_ATTR_SOCK_FWD] =3D (u32)-1,
>>  		};
>>  		const struct ovs_action_push_vlan *vlan;
>>  		int type =3D nla_type(a);
>> @@ -3509,6 +3686,33 @@ static int __ovs_nla_copy_actions(struct net *net=
, const struct nlattr *attr,
>>  				return err;
>>  			break;
>>
>> +		case OVS_ACTION_ATTR_SOCK_TRY:
>> +			err =3D validate_sock_try(a);
>> +			if (err)
>> +				return err;
>> +			break;
>> +
>> +		case OVS_ACTION_ATTR_SOCK_TUPLE:
>> +			break;
>> +
>> +		case OVS_ACTION_ATTR_SOCK_ADD:
>> +			if (nla_get_u32(a) >=3D DP_MAX_PORTS)
>> +				return -EINVAL;
>> +			break;
>> +
>> +		case OVS_ACTION_ATTR_SOCK_FWD: {
>> +			bool last =3D nla_is_last(a, rem);
>> +
>> +			err =3D validate_and_copy_sock_fwd(net, a, key, sfa,
>> +							 eth_type, vlan_tci,
>> +							 mpls_label_count,
>> +							 log, last, depth);
>> +			if (err)
>> +				return err;
>> +			skip_copy =3D true;
>> +			break;
>> +		}
>> +
>>  		default:
>>  			OVS_NLERR(log, "Unknown Action type %d", type);
>>  			return -EINVAL;
>> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
>> index 8732f6e51ae5..9c8add78b94a 100644
>> --- a/net/openvswitch/vport.c
>> +++ b/net/openvswitch/vport.c
>> @@ -494,6 +494,7 @@ u32 ovs_vport_find_upcall_portid(const struct vport =
*vport,
>>  int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
>>  		      const struct ip_tunnel_info *tun_info)
>>  {
>> +	struct ovs_skb_sk_map_data skmd =3D {};
>>  	struct sw_flow_key key;
>>  	int error;
>>
>> @@ -501,6 +502,7 @@ int ovs_vport_receive(struct vport *vport, struct sk=
_buff *skb,
>>  	OVS_CB(skb)->mru =3D 0;
>>  	OVS_CB(skb)->cutlen =3D 0;
>>  	OVS_CB(skb)->probability =3D 0;
>> +	OVS_CB(skb)->sk_map_data =3D &skmd;
>>  	if (unlikely(dev_net(skb->dev) !=3D ovs_dp_get_net(vport->dp))) {
>>  		u32 mark;
>>
>> --=20
>> 2.47.1


