Return-Path: <netdev+bounces-231245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E7CBF675D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B7B34E1BF8
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554E2DECB0;
	Tue, 21 Oct 2025 12:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414B2F2616;
	Tue, 21 Oct 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049924; cv=none; b=avk1nZOjjEV0oLGSJN0N912MQrlbR6Y0xitLYqb4LktOoXbtnOJ0YtkSTPbK2iLHZifSHrRgsy4/7u1VS3+gCOnVVxuhNBP0YUVGISUfNXtPO408cZGKPA4GUsL3e76XiZPZsnzwzAdzlEpgwX+93bT1Y799HUtrtpCj0PuURz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049924; c=relaxed/simple;
	bh=BbHrSanNbvDNOCEHSd7v5dXDuNcF7qVtGsFeh2Ji/zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT/kFhJAmfnzo8J36j0VFICFDi32SHoLcf0gog3sxsjhlsEUUSpeL3b5czW1177fg05ZUiSLTe12ewJwBkCkgoQpXconSdDocLNuJz6Qbm6hck45uTISjiqyF9hZIJdMbqA/068CqoTY193D9ie0RIu++Xwnz46B5DymAB6CMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0E45CA72E6;
	Tue, 21 Oct 2025 14:31:53 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:31:51 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Wrong source address selection in arp_solicit for forwarded
 packets
Message-ID: <76z4ckbvjimtrf2foaislezs4vlru5upxn3i5ysu4au2m2pfei@slgxispho2iv>
Mail-Followup-To: Ido Schimmel <idosch@idosch.org>, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <eykjh3y2bse2tmhn5rn2uvztoepkbnxpb7n2pvwq62pjetdu7o@r46lgxf4azz7>
 <aPZB33C-C1t1z7Dk@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPZB33C-C1t1z7Dk@shredder>
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1761049905233

On 20.10.2025 17:06, Ido Schimmel wrote:
> On Fri, Oct 17, 2025 at 04:47:27PM +0200, Gabriel Goller wrote:
> > Hi,
> > I have a question about the arp solicit behavior:
> > 
> > I have the following simple infrastructure with linux hosts where the ip
> > addresses are configured on dummy interfaces and all other interfaces are
> > unnumbered:
> > 
> >   ┌────────┐     ┌────────┐     ┌────────┐    │ node1  ├─────┤ node2
> > ├─────┤ node3  │    │10.0.1.1│     │10.0.1.2│     │10.0.1.3│    └────────┘
> > └────────┘     └────────┘
> 
> The diagram looks mangled. At least I don't understand it.

Ah sorry about that, looks like I had format=flowed configured on my
client.

Diagram should be correct now:

   ┌────────┐     ┌────────┐     ┌────────┐
   │ node1  ├─────┤ node2  ├─────┤ node3  │
   │10.0.1.1│     │10.0.1.2│     │10.0.1.3│
   └────────┘     └────────┘     └────────┘

If it's still not right it's correctly rendered on lore:
https://lore.kernel.org/netdev/eykjh3y2bse2tmhn5rn2uvztoepkbnxpb7n2pvwq62pjetdu7o@r46lgxf4azz7/

> > All nodes have routes configured and can ping each other. ipv4 forwarding is
> > enabled on all nodes, so pinging from node1 to node3 should work. However, I'm
> > encountering an issue where node2 does not send correct arp solicitation
> > packets when forwarding icmp packets from node1 to node3.
> 
> I believe ICMP is irrelevant here.

Yep, ICMP is just an example.

> > For example, when pinging from node1 to node3, node2 sends out the
> > following arp packet:
> > 
> > 13:57:43.198959 bc:24:11:a4:f6:cd > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100),
> > length 46: vlan 300, p 0, ethertype ARP (0x0806), Ethernet (len 6),
> > IPv4 (len 4), Request who-has 10.0.1.3 tell 172.16.0.102, length 28
> > 
> > Here, 172.16.0.102 is an ip address configured on a different interface on
> > node2. This request will never receive a response because `rp_filter=2`.
> > 
> > node2 has the following (correct) routes installed:
> > 
> > 10.0.1.3 nhid 18 via 10.0.1.3 dev ens22 proto openfabric src 10.0.1.2 metric 20 onlink
> > 
> > Since arp_announce is set to 0 (the default), arp_solicit selects the first
> > interface with an ip address (inet_select_addr), which results in
> > selecting the wrong source address (172.16.0.102) for the arp request.
> > Because rp_filter is set to 2, we won't receive an answer to this arp
> > packet, and the ping will fail unless we explicitly ping from node2 to
> > node3.
> > 
> > I'm wondering if it would be possible (and correct) to modify arp_solicit to
> > perform a fib lookup to check if there's a route with an explicit source
> > address (e.g., the route above using src 10.0.1.2) and use that address as the
> > source address for the arp packet. Of course, this wouldn't be backward
> > compatible, as some users might rely on the current interface ordering behavior
> > (or the loopback interface being selected first), so it would need to be
> > controlled via a sysctl configuration flag. Perhaps I'm missing something
> > obvious here though.
> 
> This would probably entail adding a new arp_announce level, but nobody
> added a new level in at least 20 years, so you will need to explain why
> your setup is special and why the same functionality cannot be achieved
> in a different way that does not require kernel changes.

To add a bit more context, I'm using FRR on all nodes and the dummy
interface ips are distributed using OpenFabric. But this shouldn't
matter because the routes are inserted correctly and work fine.

> A few things you can consider:
> 
> 1. You wrote that the router interfaces are unnumbered. Modern
> unnumbered networks usually assign IPv6 link-local addresses to these
> interfaces. These addresses are only used for neighbour resolution and
> can be used as the nexthop address for IPv4 routes. For example:
> 
> ip route add 192.0.2.1/32 nexthop via inet6 fe80::1 dev dummy1
> 
> Or using nexthop objects:
> 
> ip nexthop add id 1 via fe80::1 dev dummy1
> ip route add 192.0.2.1/32 nhid 1

Hmm I don't know how this would help? There is a link-local address set
on the interface, but we would have to add a ipv6 source address to the
arp packet which wouldn't be right?

The route already exists (see `dev ens22` and `onlink`).

> 2. If you have interfaces whose addresses should not be considered as
> source addresses when generating IP/ARP packets out of other interfaces,
> then you can try placing them in a different VRF if it's viable.

Yep, this is definitely a solution as the "loopback" address of the VRF
is its master device. Still, what if the master device or the loopback
device have multiple ips?

> 3. Requires some work and I didn't look too much into it, but I believe
> it should be possible to derive the preferred source address and rewrite
> it in ARP packets using tc-bpf on egress. See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dab4e1f06cabb6834de14264394ccab197007302

Yeah ebpf is definitely also a solution, but IMO this is a bit of a
weird behavior and should be fixed in the kernel.

We have all the information we need (from the routes) and just need to
use them to select the correct source address, and not just give up and
select randomly.


Thanks for the answer!
Gabriel


