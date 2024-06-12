Return-Path: <netdev+bounces-102799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B648904C7D
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BC51C229F5
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70C167DB8;
	Wed, 12 Jun 2024 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q4xrWK3Z"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF86C167270;
	Wed, 12 Jun 2024 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176397; cv=none; b=SWvLPT1Xd07Z6ylzhcKzhudwkT291BiQcLJZPLvmkihvRCEyiFqeFthJFTBfMKeNM9LkqLnp7Q2jURCD9TTq3CQJSDUjUaio4q7iAr8NoAv7TWKSEfln6Zg0WmMGv2jrDvp7k1glXjzbwaMJqx2pHj2LX1MTzLmNoCpIHDCGGIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176397; c=relaxed/simple;
	bh=VpcqE5Zm8e7kCewYX4SBrrW4Uqo5FYSxEun+rXKHtpg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdgQwJLMXAcfiEHYjHcMUOqq76KA4gJNj48YUMjj6hD5CxfGtDebdKZ6+qgrJln94ZbhQYAJqaDNjei+RQO1b5fLOp9G0rRMfP1drSvg6Mbx8ip2tNX36682XnNu+ESNKET9w3SFanTFg0/Aiqnab4PwdjUrjsDMAsLP9BKFzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q4xrWK3Z; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C7Cump010945;
	Wed, 12 Jun 2024 02:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718176376;
	bh=wQrIUIi/wXdFJ8MiGwe+ykgIpBS1m4gqB9HR6GiOlJs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Q4xrWK3ZK0bV3TCfMw8iFjKdkVpZZcxLpmp1dn2krUCmVweTI6jhQRcUKj7cLe1WH
	 e+Zk/4n3a7JZpOCsNrXXtX5XP08JLeW+n6+mK3YmC8bdxjCsx/GrEJ07V/HKPzveTw
	 Jzdo9AXxu7xfcOwRVV0N/PoYTgfvClrsJbYr9E24=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C7Cuon006114
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 02:12:56 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 02:12:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 02:12:55 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C7Csum118254;
	Wed, 12 Jun 2024 02:12:54 -0500
Date: Wed, 12 Jun 2024 12:42:53 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <corbet@lwn.net>, <rogerq@kernel.org>, <danishanwar@ti.com>,
        <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <misael.lopez@ti.com>, <srk@ti.com>
Subject: Re: [RFC PATCH net-next 01/28] docs: networking: ti: add driver doc
 for CPSW Proxy Client
Message-ID: <77267e15-b986-4b54-9e12-fb9536432ac2@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
 <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
 <6e520ad0-0f9b-4fee-87fe-44477b01912b@ti.com>
 <287322d3-d3ee-4de6-9189-97067bc4835c@lunn.ch>
 <3586d2d1-1f03-47b0-94c0-258e48525a9d@ti.com>
 <b5d9f1ff-0b0f-4c97-9d1c-4ba4468ce6e3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5d9f1ff-0b0f-4c97-9d1c-4ba4468ce6e3@lunn.ch>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Jun 12, 2024 at 12:03:00AM +0200, Andrew Lunn wrote:
> > System Architecture and Implementation Details
> > ==============================================
> > 
> > The CPSW Ethernet Switch has a single Host Port (CPU facing port) through
> > which it can receive data from the Host(s) and transmit data to the
> > Host(s).
> 
> So there is a single host port, but it can support multiple hosts,
> each having a subset of the available DMA channels. Maybe it is
> explain later, but why call it a _single_ host port? Apart from the
> DMA channels, are there other things the hosts are sharing?

The term __single__ is important here in the context of the questions
you have asked below. Please consider the analogy of an external network
switch to which our Laptop/PC is connected to via a LAN Cable. Such
external network switches have multiple ports, all of which are treated
identically. Devices connected to one port can communicate with devices
connected on other ports of that network switch. So there technically
isn't a "special port" or Host Port, since each Port connects to a
different device.

In the case of CPSW, a CPSW5G instance for example, has 4 MAC Ports
(which are the equivalent of the ports present on the external network
switch and accessible via the external world) and 1 Host Port. The
single Host Port has multiple TX/RX DMA Channels to transmit/receive
data. If these channels are shared across multiple cores, then yes, we
do have multiple hosts exchanging data with CPSW via its single host
port. All rules that apply to the MAC Ports or any Ethernet Switch Port
for that matter, also apply to the CPSW's Host Port. One such rule which
is significant in the current context happens to be that "duplicate"
packets cannot be sent out of a single port. I shall refer to this again
in my reply below.

> 
> > The exchange of data occurs via TX/RX DMA Channels (Hardware
> > Queues). These Hardware Queues are a limited resource (8 TX Channels and
> > up to 64 RX Flows). If the Operating System on any of the cores is the
> > sole user of CPSW then all of these Hardware Queues can be claimed by that
> > OS. However, when CPSW has to be shared across the Operating Systems on
> > various cores with the aim of enabling Ethernet Functionality for the
> > Applications running on different cores, it is necessary to share these
> > Hardware Queues in a manner that prevents conflicts. On the control path
> > which corresponds to the configuration of CPSW to get it up and running,
> > since there is no Integrated Processor within CPSW that can be programmed
> > with a startup configuration, either the Operating System or Firmware
> > running on one of the cores has to take the responsibility of setting it.
> > One option in this case happens to be the Ethernet Switch Firmware (EthFw)
> > which is loaded by the Bootloader on a remote core at the same time that
> > Linux and other Operating Systems begin booting. EthFw quickly powers on
> > and configures CPSW getting the Forwarding Path functional.
> 
> At some point, a definition of functional will be needed. How does the
> EthFw know what is required? Should Linux care? Can Linux change it?

The term functional can be considered to be the equivalent of a "start-up"
configuration that is present in the external network switches. The code
that is flashed into the external network switch's non-volatile memory
to setup and configure the switch on device power-on is responsible to
get the switch functional. From a user's perspective, functional will
imply that the devices connected to the ports on the external network
switch are able to exchange data with one another (Forwarding Path).

Therefore, Linux doesn't need to know about this and also cannot change
the startup configuration performed by EthFw.

> 
> > Once Linux and
> > other Operating Systems on various cores are ready, they can communicate
> > with EthFw to obtain details of the Hardware Queues allocated to them to
> > exchange data with CPSW.
> 
> > With the knowledge of the Hardware Queues that
> > have been allocated, Linux can use the DMA APIs to setup these queues
> > to exchange data with CPSW.
> 
> This might be an important point. You communicate with the CPSW. You
> don't communicate transparently through the CPSW to external ports?
> There is no mechanism for a host to say, send this packet out port X?
> It is the CPSW which decides, based on its address tables? The
> destination MAC address decides where a packet goes.

Yes, the host cannot/doesn't decide which MAC Port the packet goes out
of. The ALE in CPSW is responsible for deciding that. This is identical
to an external network switch. A PC which sends traffic to the port on
the network switch cannot/doesn't tell the switch which port to send it
out of. The network switch is supposed to learn and determine this.

The DMA Channels provide a path to/from CPSW's Host Port for each Host.

Please refer to the following illustration corresponding to the data
movement from each of the Hosts to the CPSW's Host Port via the ALE and
then out of the MAC Ports:

           -------      ---------            ---------   CONTROL-PATH
           |Linux|      |AUTOSAR|            | EthFW | -------------
           -------      ---------            ---------             |
            |   |         |   |               |    |               |
DATA       TX   RX       TX   RX              TX   RX              |
PATH =>     |   |         |   |               |    |               |
(DMA)       |   |         |   |               |    |               |
	    |   |         |   |               |    |               |
	    \   \         \   \               /    /               |
	     \   \         \   \             /    /                |
	      \   \         \   \           /    /                 |
	       \   \         \   \         /    /                  |
	        \   \         \   \       /    /                   |
                ===============================                    |
               ||        CPSW HOST PORT       ||                   V
                ===============================             -----------
			     	|                           |CPSW     |
			     TX + RX                        |CONTROL  |
			     	|                           |REGISTERS|
			     	|                           -----------
			     	|
                       ===================
		      ||ALE & SWITCH CORE||
                       ===================
                        /  |      |    \
		       /   |      |     \
		      /    |      |      \
		    TX+RX  |       \      -------
		    /      |        \            \
		   /     TX+RX     TX+RX        TX+RX
                  /        |          \            \
        ==========    ==========    ==========    ==========
       |MAC Port 1|  |MAC Port 2|  |MAC Port 3|  |MAC Port 4|
        ==========    ==========    ==========    ==========

>
> > Setting up the Hardware Queues alone isn't sufficient to exchange data
> > with the external network. Consider the following example:
> > The ethX interface in userspace which has been created to transmit/receive
> > data to/from CPSW has the user-assigned MAC Address of "M". The ping
> > command is run with the destination IP of "D". This results in an ARP
> > request sent from ethX which is transmitted out of all MAC Ports of CPSW
> > since it is a Broadcast request. Assuming that "D" is a valid
> > destination IP, the ARP reply is received on one of the MAC Ports which
> > is now a Unicast reply with the destination MAC Address of "M". The ALE
> > (Address Lookup Engine) in CPSW has learnt that the MAC Address "M"
> > corresponds to the Host Port when the ARP request was sent out. So the
> > Unicast reply isn't dropped. The challenge however is determining which
> > RX DMA Channel (Flow) to send the Unicast reply on. In the case of a
> > single Operating System owning all Hardware Queues, sending it on any of
> > the RX DMA Channels would have worked. In the current case where the RX
> > DMA Channels map to different Hosts (Operating Systems and Applications),
> > the mapping between the MAC Address "M" and the RX DMA Channel has to be
> > setup to ensure that the correct Host receives the ARP reply. This
> > necessitates a method to inform the MAC Address "M" associated with the
> > interface ethX to EthFw so that EthFw can setup the MAC Address "M" to
> > RX DMA Channel map accordingly.
> 
> Why not have EthFW also do learning? The broadcast ARP request tells
> you that MAC address M is associated to a TX DMA channel. EthFW should
> know the Rx DMA channel which pairs with it, and can program ALE.
> 
> That is how a switch works, it learns what MAC address is where, it is
> not told.

The ALE in CPSW learns just like any other switch and doesn't need to be
programmed. When the ARP broadcast is sent out via the ALE, it learns
that the MAC Address "M" is from the Host Port. The problem however is
that knowing this alone isn't sufficient for the return path (ARP reply).
The ARP reply contains the destination MAC Address "M" which tells the
ALE that the Host Port is the destination. So the ALE will send the ARP
reply to the Host Port. But, as the illustration shows, from the Host
Port, there are multiple RX DMA Channels for each Host. So the ALE did
its job as expected from any standard ALE. The missing part here is
determining which RX DMA Channel (Flow) to place that packet on. That
requires programming the Classifiers in CPSW to map that packets
containing the MAC Address "M" to the RX DMA Flow corresponding to the
Host which has registered with that MAC Address "M". This is handled by
EthFw. EthFw doesn't/cannot snoop on all traffic on the Host Port, since
it doesn't lie in between the Host Port and the other Hosts. Rather, it
is quite similar to a Host itself since it also has dedicated TX/RX DMA
Channels to exchange traffic with CPSW.

> 
> > At this point, Linux can exchange data with the external network via CPSW,
> > but no device on the external network can initiate the communication by
> > itself unless it already has the ARP entry for the IP Address of ethX.
> > That's because CPSW doesn't support packet replication implying that any
> > Broadcast/Multicast packets received on the MAC Ports can only be sent
> > on one of the RX DMA Channels.
> 
> That sounds broken.
> 
> And this is where we need to be very careful. It is hard to build a
> generic model when the first device using it is broken. Ethernet
> switches have always been able to replicate. Dumb hubs did nothing but
> replicate. Address learning, and forwarding out specific ports came
> later, but multicast and broadcast was always replicated. IGMP
> snooping came later still, which reduced multicast replication.
> 
> And your switch cannot do replication....

I will respectfully disagree with your statement here. Packet replication
is supported in CPSW just like any other Ethernet Switch which can create
copies of Broadcast/Multicast traffic it receives on one "Port" and send
them out of the other "Ports". That is exactly how the ARP Broadcast
request sent from Linux to the CPSW Host Port is duplicated in the Switch
Core and is sent out via all of the MAC Ports in the illustration above.

The "packet replication" that I was referring to, is that of creating
duplicates of a packet and sending them out on the same "Port" (Host Port
in this case). This is not expected of any Ethernet Switch and can only
be considered an optional feature. In the current case, due to the presence
of Multiple Hosts connected to a __single__ Host Port, copies of Broadcast
or Multicast traffic are expected on a single Port so that one copy each of
the Broadcast/Multicast traffic directed to the Host Port can be sent on
each of the RX DMA Flows for every Host. Since that is not supported, all
Broadcast/Multicast traffic directed to the Host Port from the Switch Core
is by default placed on the RX DMA Flow corresponding to EthFw. EthFw then
creates copies of these in software and shares them with each Host via
Shared Memory for example.

> 
> > So the Broadcast/Multicast packets can
> > only be received by one Host. Consider the following example:
> > A PC on the network tries to ping the IP Address of ethX. In both of the
> > following cases:
> > 1. Linux hasn't yet exchanged data with the PC via ethX.
> > 2. The MAC Address of ethX has changed.
> > the PC sends an ARP request to one of the MAC Ports on CPSW to figure
> > out the MAC Address of ethX. Since the ARP request is a Broadcast
> > request, it is not possible for CPSW to determine the correct Host,
> > since the Broadcast MAC isn't unique to any Host. So CPSW is forced
> > to send the Broadcast request to a preconfigured RX DMA Channel which
> > in this case happens to be the one mapped to EthFw. Thus, if EthFw
> > is aware of the IP Address of ethX, it can generate and send the ARP
> > reply containing the MAC Address "M" of ethX that it was informed of.
> > With this, the PC can initiate communication with Linux as well.
> > 
> > Similarly, in the case of Multicast packets, if Linux wishes to receive
> > certain Multicast packets, it needs to inform the same to EthFw which
> > shall then replicate the Multicast packets it received from CPSW and
> > transmit them via alternate means (Shared Memory for example) to Linux.
> 
> This all sounds like you are working around broken behaviour, not
> something generic.
> 
> What i actually think you need to do is hide all the broken
> behaviour. Trap all multicast/broadcast to EthFw. It can run a

All Multicast/Broadcast traffic received by the Host Port is trapped and
sent to EthFw like I have mentioned in my reply above.

> software bridge, and do learning. It will see the outgoing ARP request
> from a host and learn the host MAC address. It can then flood the

As I have mentioned earlier, EthFw is not in the path between the CPSW
Host Port and the Hosts. So your suggestion is not applicable.

> packet out the external ports, working around the CSPW brokeness. It
> can also program the ALE, so the reply goes straight to the
> host. Incoming broadcast and multicast is also trapped to the EthFW
> and it can use its software bridge to flood the packet to all the
> hosts. It can also perform IGMP snooping, and learn which hosts are
> interested in Multicast. 
> 
> Your switch then functions as a switch.
> 
> And you are then the same as the RealTek and Samsung device. Linux is
> just a plain boring host connect to a switch, which somebody else is
> managing. No new model needed.

I hope that the illustration above along with my replies would have
clarified that CPSW is *not* broken and works just like any Ethernet
Switch is expected to work. It is only because there is a __single__
Host Port from CPSW that is shared across Hosts, that the EthFw based
model is required. If there were dedicated Host Ports for each Host,
then just like the Broadcast/Multicast traffic is already replicated for
each Port (whether it is a MAC Port or the Host Port), the traffic would
also be replicated in CPSW for each Host Port.

> 
> > All data between Linux (Or any Operating System) and EthFw is exchanged
> > via the Hardware Mailboxes with the help of the RPMsg framework. Since
> > all the resource allocation information comes from EthFw, the
> > vendor-specific implementation in the Linux Client is limited to the DMA
> > APIs used to setup the Hardware Queues and to transmit/receive data with
> > the Ethernet Switch. Therefore, it might be possible to move most of the
> > vendor specific implementation to the Switch Configuration Firmware
> > (similar to EthFw), to make the Linux Client implementation as generic
> > and vendor agnostic as possible. I believe that this series more or less
> > does the same, just using custom terminology which can be made generic.
> 
> This is actually very similar to what your college is doing:
> 
> https://lore.kernel.org/netdev/20240531064006.1223417-1-y-mallik@ti.com/
> 
> The only real difference is shared memory vs DMA.

Yes, the Shared Memory path is intended for the low-bandwidth
Broadcast/Multicast traffic from EthFw while the DMA path is dedicated
for high-bandwidth Unicast traffic. The current series implements the
DMA path while the other series you have referred to implements the
Shared Memory path. Both of them together enable the desired functionality.

Regards,
Siddharth.

