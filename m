Return-Path: <netdev+bounces-161978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D23A24E52
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 14:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8389D3A3608
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73421DA632;
	Sun,  2 Feb 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wt1PGGen"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5011D9A7D
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738503642; cv=none; b=mJLcja/+gdoDvohKouNindC7ybFK0TDRekPN7Yr/Cllj2okFauQ7op4zH7WbmPSkJTFrq2tiEkvRqx2sRgjdYydwI0S8Y9Z3k2XkfMQqAwt9YE2Ce0lSxmoXIEoZYmxI1QXv9zsK26E06meswCRRD02zn5Rjdi4tkAkSoEyDYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738503642; c=relaxed/simple;
	bh=jYgqlta0oXMbC8o3EGmW2ZIsZrUWw4kdFTXtiMG3tRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Acy10Dz2nB7ODswnD1cZoRxxYzo83ZjoI19Wg29cERNyP93Em/lVaGpggNFvEr7EtK1mO6pg8UmhoNa7Vsfz0KGBTQWP5pqp1Ot4F7HKYHgprYCFWq7z+UvpXX8DQvDTGLlWKYZFO0ojWjMF74ElmaSxx5+ounUSyYKh5dsecvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wt1PGGen; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 793D42540127;
	Sun,  2 Feb 2025 08:40:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 02 Feb 2025 08:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738503639; x=
	1738590039; bh=7kc2cRU9UlCykUHCU0+7CLRcRP7jvG9FgR4TP7xEyGo=; b=W
	t1PGGenwAdPNCL8mPTZpR6MljPNnyRnbke+6MbJfnR364fMHfVo3uIZ7gL5NywTG
	2jfddTFWrNukLOYY2RGzKOxX8YkFjDCTRnNE15HGTuytrwSUc6QlyPBOTw0P4YTQ
	y+dcKQBOVmlHgvbA1feGGL1mLfgJ0UXLSbNwDagLAa7jbV2C40abKFYt5GwzYXGA
	2Hasnv8zZRFZKyLDgf+YOwVrQbG7kW7y/+3mbP3UiF0ZXbYlW7HpqAQHkCcuFqp8
	CacJB3PHu3ztOOupps4zwyfWWkzv5aD5G8LXTm/N70szx6EqPwaOI9mee29RqdON
	x73730Qe10SKRX1oMowaQ==
X-ME-Sender: <xms:1nWfZzcUKYzLBQHSykhzXaCeblNgvHcJVfh7eoJBCWJwo8xaK_q3Gw>
    <xme:1nWfZ5MhUTJNJ3uqgRDwg5ccNJLUcVhXOtYsOx7o-VkuGUAUu9vqhk0St09ZoHnpG
    _NVzWnF_7cgFi4>
X-ME-Received: <xmr:1nWfZ8i1mbUkLD9kn-6Qf1LhbdJ1zUJepc-Nb2EZNVXBNMhd0_cf2tFhy5n2T43eir-MEzt81OkU8AFe0-MhOXKz2TIlDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepkeeggfeghfeuvdegtedtgedvuedvhfdujedv
    vdejteelvdeutdehheellefhhfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepiihnshgtnhgthhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvggu
    hhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtg
    hhpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1nWfZ0-CB7XkwuXZUg6p1MePIIHQnCjqauQmqEO8AOpOKw1Ek6Nn1A>
    <xmx:1nWfZ_s5XbLgDYWlrh2Vlz5HA04iV1amddg2m4DDJL-coKUjvQReAA>
    <xmx:1nWfZzHOE1LqQf7tf75eAU0txcaZWcUGtJB1fNBPsGmb_weEDgJIfg>
    <xmx:1nWfZ2NieMNDtYyjQ7Wt2QQ-bcp_Sty08ZC31KjCF7yTZxbKmVnLTw>
    <xmx:13WfZzj171wWJU9nfITgHcc-9RhkGtYf0_h2MJfXkiUPf5M6luiQlNrV>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 08:40:38 -0500 (EST)
Date: Sun, 2 Feb 2025 15:40:35 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Ted Chen <znscnchen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/3] vxlan: Support of Hub Spoke Network to
 use the same VNI
Message-ID: <Z59109CGe8WmZVsJ@shredder>
References: <20250201113207.107798-1-znscnchen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201113207.107798-1-znscnchen@gmail.com>

On Sat, Feb 01, 2025 at 07:32:07PM +0800, Ted Chen wrote:
> This RFC series proposes an implementation to enable the configuration of vxlan
> devices in a Hub-Spoke Network, allowing multiple vxlan devices to share the
> same VNI while being associated with different remote IPs under the same UDP
> port.
> 
> == Use case ==
> In a Hub-Spoke Network, there is a central VTEP acting as the gateway, along
> with multiple outer VTEPs. Each outer VTEP communicates exclusively with the
> central VTEP and has no direct connection to other outer VTEPs. As a result,
> data exchanged between outer VTEPs must traverse the central VTEP. This design
> enhances security and enables centralized auditing and monitoring at the
> central VTEP.
> 
> == Existing methods ==
> Currently, there are three methods to implement the use case.
> 
> Method 1:
>          The central VTEP establishes a separate vxlan tunnel with each outer
>          VTEP, creating a vxlan device with a different VNI for each tunnel.
>          All vxlan devices are then added to the same Linux bridge to enable
>          forwarding.
> 
>          Drawbacks: Complex configuration.
>          Each tenant requires multiple VNIs.

This looks like the most straightforward option to me.

Why do you view it as complex? Why multiple VNIs per tenant are a
problem when we have 16M of them?

> 
> Method 2:
>         The central VTEP creates a single vxlan device using the same VNI,
>         without configuring a remote IP. The IP addresses of all outer VTEPs
>         are stored in the fdb. To enable forwarding, the vxlan device is added
>         to a Linux bridge with hairpin mode enabled.
> 
>         Drawbacks: unnecessary overhead or network anomalies
>         The hairpin mode may broadcast packets to all outer VTEPs, causing the
>         source outer VTEP receiving packets it originally sent to the central
>         VTEP. If the packet from the source outer VTEP is a broadcast packet,
>         the broadcasting back of the packet can cause network anomalies.
> 
> Method 3:
>         The central VTEP uses the same VNI but different UDP ports to create a
>         vxlan device for each outer VTEP, each tunneling to its corresponding
>         outer VTEP. All the vxlan devices in the central VTEP are then added to
>         the same Linux bridge to enable forwarding.
> 
>         Drawbacks: complex configuration and potential security issues.
>         Multiple UDP ports are required.
> 
> == Proposed implementation ==
> In the central VTEP, each tenant only requires a single VNI, and all tenants
> share the same UDP port. This can avoid the drawbacks of the above three
> methods.

This method also has drawbacks. It breaks existing behavior (see my
comment on patch #1) and it also bloats the VXLAN receive path.

I want to suggest an alternative which allows you to keep the existing
topology (same VNI), but without kernel changes. The configuration of
the outer VTEPs remains the same. The steps below are for the central
VTEP.

First, create a VXLAN device in "external" mode. It will consume all the
VNIs in a namespace, but you can limit it with the "vnifilter" keyword,
if needed:

# ip -n ns_c link add name vx0 type vxlan dstport 4789 nolearning external
# tc -n ns_c qdisc add dev vx0 clsact

Then, for each outer VTEP, create a dummy device and enslave it to the
bridge. Taking outer VTEP1 as an example:

# ip -n ns_c link add name dummy_vtep1 up master br0
# tc -n ns_c qdisc add dev dummy_vtep1 clsact

In order to demultiplex incoming VXLAN packets to the appropriate bridge
member, use an ingress tc filter on the VXLAN device that matches on the
encapsulating source IP (you can't do it w/o the "external" keyword) and
redirects the traffic to the corresponding bridge member:

# tc -n ns_c filter add dev vx0 ingress pref 1 proto all \
	flower enc_key_id 42 enc_src_ip 10.0.0.1 \
	action mirred ingress redirect dev dummy_ns1

(add filters for other VTEPs with "pref 1" to avoid unnecessary
lookups).

For Tx, on each bridge member, configure an egress tc filter that
attaches tunnel metadata for the matching outer VTEP and redirects to
the VXLAN device:

# tc -n ns_c filter add dev dummy_vtep1 egress pref 1 proto all \
	matchall \
	action tunnel_key set src_ip 10.0.0.3 dst_ip 10.0.0.1 id 42 dst_port 4789 \
	action mirred egress redirect dev vx0

The end result should be that the bridge forwards known unicast traffic
to the appropriate outer VTEP and floods BUM traffic to all the outer
VTEPs but the one from which the traffic was received.

> 
> As in below example,
> - a tunnel is established between vxlan42.1 in the central VTEP and vxlan42 in
>   the outer VTEP1:
>   ip link add vxlan42.1 type vxlan id 42 \
>           local 10.0.0.3 remote 10.0.0.1 dstport 4789
> 
> - a tunnel is established between vxlan42.2 in the central VTEP and vxlan42 in
>   the outer VTEP2:
>   ip link add vxlan42.2 type vxlan id 42 \
>   		  local 10.0.0.3 remote 10.0.0.2 dstport 4789
> 
> 
>     ┌────────────────────────────────────────────┐
>     │       ┌─────────────────────────┐  central │
>     │       │          br0            │    VTEP  │
>     │       └─┬────────────────────┬──┘          │
>     │   ┌─────┴───────┐      ┌─────┴───────┐     │          
>     │   │ vxlan42.1   │      │  vxlan42.2  │     │
>     │   └─────────────┘      └─────────────┘     │  
>     └───────────────────┬─┬──────────────────────┘
>                         │ │ eth0 10.0.0.3:4789
>                         │ │            
>                         │ │            
>        ┌────────────────┘ └───────────────┐
>        │eth0 10.0.0.1:4789                │eth0 10.0.0.2:4789
>  ┌─────┴───────┐                    ┌─────┴───────┐
>  │outer VTEP1  │                    │outer VTEP2  │
>  │     vxlan42 │                    │     vxlan42 │
>  └─────────────┘                    └─────────────┘
> 
> 
> == Test scenario ==
> ip netns add ns_1
> ip link add veth1 type veth peer name veth1-peer
> ip link set veth1 netns ns_1
> ip netns exec ns_1 ip addr add 10.0.1.1/24 dev veth1
> ip netns exec ns_1 ip link set veth1 up
> ip netns exec ns_1 ip link add vxlan42 type vxlan id 42 \
>                    remote 10.0.1.3 dstport 4789
> ip netns exec ns_1 ip addr add 192.168.0.1/24 dev vxlan42
> ip netns exec ns_1 ip link set up dev vxlan42
> 
> ip netns add ns_2
> ip link add veth2 type veth peer name veth2-peer
> ip link set veth2 netns ns_2
> ip netns exec ns_2 ip addr add 10.0.1.2/24 dev veth2
> ip netns exec ns_2 ip link set veth2 up
> ip netns exec ns_2 ip link add vxlan42 type vxlan id 42 \
>                    remote 10.0.1.3 dstport 4789
> ip netns exec ns_2 ip addr add 192.168.0.2/24 dev vxlan42
> ip netns exec ns_2 ip link set up dev vxlan42
> 
> ip netns add ns_c
> ip link add veth3 type veth peer name veth3-peer
> ip link set veth3 netns ns_c
> ip netns exec ns_c ip addr add 10.0.1.3/24 dev veth3
> ip netns exec ns_c ip link set veth3 up
> ip netns exec ns_c ip link add vxlan42.1 type vxlan id 42 \
>                    local 10.0.1.3 remote 10.0.1.1 dstport 4789
> ip netns exec ns_c ip link add vxlan42.2 type vxlan id 42 \
>                    local 10.0.1.3 remote 10.0.1.2 dstport 4789
> ip netns exec ns_c ip link set up dev vxlan42.1
> ip netns exec ns_c ip link set up dev vxlan42.2
> ip netns exec ns_c ip link add name br0 type bridge
> ip netns exec ns_c ip link set br0 up
> ip netns exec ns_c ip link set vxlan42.1 master br0
> ip netns exec ns_c ip link set vxlan42.2 master br0
> 
> ip link add name br1 type bridge
> ip link set br1 up
> ip link set veth1-peer up
> ip link set veth2-peer up
> ip link set veth3-peer up
> ip link set veth1-peer master br1
> ip link set veth2-peer master br1
> ip link set veth3-peer master br1
> 
> ip netns exec ns_1 ping 192.168.0.2 -I 192.168.0.1
> 
> Ted Chen (3):
>   vxlan: vxlan_vs_find_vni(): Find vxlan_dev according to vni and
>     remote_ip
>   vxlan: Do not treat vxlan dev as used when unicast remote_ip
>     mismatches
>   vxlan: vxlan_rcv(): Update comment to inlucde ipv6
> 
>  drivers/net/vxlan/vxlan_core.c | 38 +++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> -- 
> 2.39.2
> 
> 

