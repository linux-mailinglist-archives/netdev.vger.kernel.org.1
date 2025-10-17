Return-Path: <netdev+bounces-230503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011FBE9656
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEA23AD3A9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C4F2472B0;
	Fri, 17 Oct 2025 14:57:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C020A5E5;
	Fri, 17 Oct 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713038; cv=none; b=dnvJJWMaBNu9xYCPDoLSKAo0+1MwVdgOgLpD0A4Jn9Oug7HObShAVUPHJrNFUaejcIR2/pEsevzkPS0sn6xx0MOzGsDwrpG0LN8yjZIMnxX9tr7SCIjF3INvLs+WbCeSfm7k0Jeukhr9nsvXoWnWY2ZVvbr6+B6U4a/R6izxV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713038; c=relaxed/simple;
	bh=e3mc8mzlkB9PwjVdtejEw8It9IQJRLvlgGVuPMXrDMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kYAPABRQHyWM3hXyXeTrE8tEYDxRfdD8R0Bc7B4golCeNI7VseT0VI9BljU/51HYNGBKCogt+ILWYI2i94wkyK8K7OkLVZsAHV9E6CbKfqXf3KiAFqPIk5hxr9t+Ly403ziLFzYBLo9QdworQnRsQNRM1936ebcKY4tEMtfKES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D59E389DCE;
	Fri, 17 Oct 2025 16:47:27 +0200 (CEST)
Date: Fri, 17 Oct 2025 16:47:27 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Wrong source address selection in arp_solicit for forwarded packets
Message-ID: <eykjh3y2bse2tmhn5rn2uvztoepkbnxpb7n2pvwq62pjetdu7o@r46lgxf4azz7>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1760712443410

Hi,
I have a question about the arp solicit behavior:

I have the following simple infrastructure with linux hosts where the ip
addresses are configured on dummy interfaces and all other interfaces are
unnumbered:

   ┌────────┐     ┌────────┐     ┌────────┐  
   │ node1  ├─────┤ node2  ├─────┤ node3  │  
   │10.0.1.1│     │10.0.1.2│     │10.0.1.3│  
   └────────┘     └────────┘     └────────┘  

All nodes have routes configured and can ping each other. ipv4 forwarding is
enabled on all nodes, so pinging from node1 to node3 should work. However, I'm
encountering an issue where node2 does not send correct arp solicitation
packets when forwarding icmp packets from node1 to node3.

For example, when pinging from node1 to node3, node2 sends out the
following arp packet:

13:57:43.198959 bc:24:11:a4:f6:cd > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100),
length 46: vlan 300, p 0, ethertype ARP (0x0806), Ethernet (len 6),
IPv4 (len 4), Request who-has 10.0.1.3 tell 172.16.0.102, length 28

Here, 172.16.0.102 is an ip address configured on a different interface on
node2. This request will never receive a response because `rp_filter=2`.

node2 has the following (correct) routes installed:

10.0.1.3 nhid 18 via 10.0.1.3 dev ens22 proto openfabric src 10.0.1.2 metric 20 onlink

Since arp_announce is set to 0 (the default), arp_solicit selects the first
interface with an ip address (inet_select_addr), which results in
selecting the wrong source address (172.16.0.102) for the arp request.
Because rp_filter is set to 2, we won't receive an answer to this arp
packet, and the ping will fail unless we explicitly ping from node2 to
node3.

I'm wondering if it would be possible (and correct) to modify arp_solicit to
perform a fib lookup to check if there's a route with an explicit source
address (e.g., the route above using src 10.0.1.2) and use that address as the
source address for the arp packet. Of course, this wouldn't be backward
compatible, as some users might rely on the current interface ordering behavior
(or the loopback interface being selected first), so it would need to be
controlled via a sysctl configuration flag. Perhaps I'm missing something
obvious here though.

Any insights would be appreciated!

Gabriel


