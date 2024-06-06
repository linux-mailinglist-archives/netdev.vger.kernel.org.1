Return-Path: <netdev+bounces-101276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989E8FDF21
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A871C2164F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9AB139D11;
	Thu,  6 Jun 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tdUOIgq+"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8612B17C;
	Thu,  6 Jun 2024 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656759; cv=none; b=BWQVIfk+ZW6G7exR605Oq9vujNh/22EQLFhZBzAPkr0ju1Mrv1c6K+bVsiJizG1YJENQuORrjABw/AftWtEG9lRj801P77U+5EDMoKclmMFwiA4IRo0sMPfjiAqiV5Wk5ZIcdsiDn6VpyoUepgUFVHXV6hnm6RtIsMtWeQqFK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656759; c=relaxed/simple;
	bh=0mjjMGe367OYg5qoD1T9yoMijPlKQtT0gPZ5+U4wZrI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocWuKlU5temMq5IVv077EnYzPfOIi8xFdqHI6O/sM3RZ3lRPreR4Fj6XygQoiO45+JC6y9ItAZtIcFo52AppRQHgiIrxRxQFkTCTbXF9WM+ecFRBPceiMaStfZ1xTi89LdYSplSekuOfbXiDPesR4eMibhnWbSAmUCCnsYTHg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tdUOIgq+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4566q532069189;
	Thu, 6 Jun 2024 01:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717656725;
	bh=KbbDyP4RKxjaOkCv02Y6AO/CjOQIQ/JQJ8NahY4g11A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tdUOIgq+Wom6F7mkCWT/Xez1YG4kE4YrFlnCHd4PXNHfE08lsCV6PCYWVIW1Q48ge
	 UDpnUy2SRLh1ll7GNhVHGAshsmZbZLyWzbqES1yFtl8lznIO3KGnke4i61ikwrAwlt
	 czyV2OK0OiP86wzcrOsOw/6rx/qHMSTbcHT2fSiE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4566q5Bv112149
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 01:52:05 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 01:52:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 01:52:05 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4566q43h080133;
	Thu, 6 Jun 2024 01:52:05 -0500
Date: Thu, 6 Jun 2024 12:22:04 +0530
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
Message-ID: <3586d2d1-1f03-47b0-94c0-258e48525a9d@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
 <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
 <6e520ad0-0f9b-4fee-87fe-44477b01912b@ti.com>
 <287322d3-d3ee-4de6-9189-97067bc4835c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <287322d3-d3ee-4de6-9189-97067bc4835c@lunn.ch>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Jun 04, 2024 at 04:20:16PM +0200, Andrew Lunn wrote:
> On Sun, Jun 02, 2024 at 09:36:05AM +0530, Siddharth Vadapalli wrote:

[...]
> 
> If you do want to add a third model, where Linux has some insight into
> the switch, you need to coordinate with other vendors in the
> automotive world, and come up with a model which everybody can
> use. What i don't want is a TI model, followed by a Realtek model,
> followed by a vendor XYZ model. So if you need more than what the
> first model above provides, you will need to get a consortium of
> vendors together to design a new model a few vendors agree on.

I believe that a third model is required given the System Architecture
and the use-case that it must cater to. I agree completely that having a
vendor specific implementation should always be the last step when it is
just not possible to generalize any portion of the implementation. I will
describe the existing Architecture on the TI SoC and will also attempt to
generalize the implementation below. I hope that you could review it and
guide me towards the generic, vendor-agnostic implementation which will
also address the use-case that this series corresponds to. I am willing
to work on the generic implementation since I assume that this series
does keep it generic enough that it could be extended to be vendor
independent. So there might be minor changes required when switching to
the generic model. On the other hand, based on the description that I
provide below, if you think that the existing models can also be slightly
modified to accomodate the use-case, I will surely take that into
consideration and work on the corresponding implementation.

System Architecture and Implementation Details
==============================================

The CPSW Ethernet Switch has a single Host Port (CPU facing port) through
which it can receive data from the Host(s) and transmit data to the
Host(s). The exchange of data occurs via TX/RX DMA Channels (Hardware
Queues). These Hardware Queues are a limited resource (8 TX Channels and
up to 64 RX Flows). If the Operating System on any of the cores is the
sole user of CPSW then all of these Hardware Queues can be claimed by that
OS. However, when CPSW has to be shared across the Operating Systems on
various cores with the aim of enabling Ethernet Functionality for the
Applications running on different cores, it is necessary to share these
Hardware Queues in a manner that prevents conflicts. On the control path
which corresponds to the configuration of CPSW to get it up and running,
since there is no Integrated Processor within CPSW that can be programmed
with a startup configuration, either the Operating System or Firmware
running on one of the cores has to take the responsibility of setting it.
One option in this case happens to be the Ethernet Switch Firmware (EthFw)
which is loaded by the Bootloader on a remote core at the same time that
Linux and other Operating Systems begin booting. EthFw quickly powers on
and configures CPSW getting the Forwarding Path functional. Once Linux and
other Operating Systems on various cores are ready, they can communicate
with EthFw to obtain details of the Hardware Queues allocated to them to
exchange data with CPSW. With the knowledge of the Hardware Queues that
have been allocated, Linux can use the DMA APIs to setup these queues
to exchange data with CPSW.

Setting up the Hardware Queues alone isn't sufficient to exchange data
with the external network. Consider the following example:
The ethX interface in userspace which has been created to transmit/receive
data to/from CPSW has the user-assigned MAC Address of "M". The ping
command is run with the destination IP of "D". This results in an ARP
request sent from ethX which is transmitted out of all MAC Ports of CPSW
since it is a Broadcast request. Assuming that "D" is a valid
destination IP, the ARP reply is received on one of the MAC Ports which
is now a Unicast reply with the destination MAC Address of "M". The ALE
(Address Lookup Engine) in CPSW has learnt that the MAC Address "M"
corresponds to the Host Port when the ARP request was sent out. So the
Unicast reply isn't dropped. The challenge however is determining which
RX DMA Channel (Flow) to send the Unicast reply on. In the case of a
single Operating System owning all Hardware Queues, sending it on any of
the RX DMA Channels would have worked. In the current case where the RX
DMA Channels map to different Hosts (Operating Systems and Applications),
the mapping between the MAC Address "M" and the RX DMA Channel has to be
setup to ensure that the correct Host receives the ARP reply. This
necessitates a method to inform the MAC Address "M" associated with the
interface ethX to EthFw so that EthFw can setup the MAC Address "M" to
RX DMA Channel map accordingly.

At this point, Linux can exchange data with the external network via CPSW,
but no device on the external network can initiate the communication by
itself unless it already has the ARP entry for the IP Address of ethX.
That's because CPSW doesn't support packet replication implying that any
Broadcast/Multicast packets received on the MAC Ports can only be sent
on one of the RX DMA Channels. So the Broadcast/Multicast packets can
only be received by one Host. Consider the following example:
A PC on the network tries to ping the IP Address of ethX. In both of the
following cases:
1. Linux hasn't yet exchanged data with the PC via ethX.
2. The MAC Address of ethX has changed.
the PC sends an ARP request to one of the MAC Ports on CPSW to figure
out the MAC Address of ethX. Since the ARP request is a Broadcast
request, it is not possible for CPSW to determine the correct Host,
since the Broadcast MAC isn't unique to any Host. So CPSW is forced
to send the Broadcast request to a preconfigured RX DMA Channel which
in this case happens to be the one mapped to EthFw. Thus, if EthFw
is aware of the IP Address of ethX, it can generate and send the ARP
reply containing the MAC Address "M" of ethX that it was informed of.
With this, the PC can initiate communication with Linux as well.

Similarly, in the case of Multicast packets, if Linux wishes to receive
certain Multicast packets, it needs to inform the same to EthFw which
shall then replicate the Multicast packets it received from CPSW and
transmit them via alternate means (Shared Memory for example) to Linux.

The following is a summary of the steps so far required to enable
Ethernet Functionality for applications running on Linux:
1. Determine and setup the Hardware Queues allocated to Linux
2. Inform the MAC Address of ethX to EthFw
3. Inform the IP Address of ethX to EthFw
4. Inform any of the Multicast Addresses associated with ethX to EthFw

All data between Linux (Or any Operating System) and EthFw is exchanged
via the Hardware Mailboxes with the help of the RPMsg framework. Since
all the resource allocation information comes from EthFw, the
vendor-specific implementation in the Linux Client is limited to the DMA
APIs used to setup the Hardware Queues and to transmit/receive data with
the Ethernet Switch. Therefore, it might be possible to move most of the
vendor specific implementation to the Switch Configuration Firmware
(similar to EthFw), to make the Linux Client implementation as generic
and vendor agnostic as possible. I believe that this series more or less
does the same, just using custom terminology which can be made generic.

I can update this series to a generic implementation along with proper
documentation and naming convention to enable any vendor to reuse the
same without having to modify the implementation. The RPMsg ABIs can
be given generic names with extensive documentation and also designed
to be extensible enough to cater to functional enhancements over time.

Kindly let me know your thoughts on this.

Regards,
Siddharth.

