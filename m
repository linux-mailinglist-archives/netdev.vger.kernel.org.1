Return-Path: <netdev+bounces-209668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71907B10377
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BA6175DFA
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C62F2749E7;
	Thu, 24 Jul 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JHlkfcus"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318C2741D6;
	Thu, 24 Jul 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345525; cv=none; b=Bv4Bk5V5+hyXrkt6og4W1XXfm9yDHpMzpzZnDiMtP85+e3eF1qSXqefvWAkroBNEAAjXU65ChS6zOSW2uBZTeAIupBRmQjV8kUYw2Ks4GS/qzuUmFrA7j0phe5a//Ahd3xfQNwVkueri6hYOA5FXvAgYCBbSYD2ewwiU/y5aLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345525; c=relaxed/simple;
	bh=W5hUaxHLghSt7VbmvFIK6rwuVf0/IbHnLRuXq7ywMUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=msb7oRs1N2RVS4+vxhg1CyRdkJG7nYhX6Cdoy6I2iJj9Stqxf/0V5whFSkd2tEpxP/8dXQKJ/JPXnu/clXPSIbBIL+ncMVuFwjfhfH03Qp031yiCAaUf2tSBCNiaMTTyPevqWXWNlfhqZeHSYB2f6nLzmy4pSAM/GiM0Q4ISoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JHlkfcus; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56O8OH4Y1928854;
	Thu, 24 Jul 2025 03:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753345457;
	bh=qW4fz+XHWFBsB4JNZq7miTAJkiAxbmbsgHtV6xdIw5I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JHlkfcuspGxCNC4QhSHgyqIbJz5pMR54PFqu9qaY+4fK+nbSxqpztVlacGZOv/QrZ
	 zdB1/yvD0Hrhn+j+mjMjD+9VEW6FNpvx3uar6YIPlf8wzWYzhfI82EwY01PRnSr+cs
	 DQFbEr/jpUB3VMN+f8SsnoX5WKZx7R7VLL4wHTCI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56O8OGFt2362940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 24 Jul 2025 03:24:16 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 24
 Jul 2025 03:24:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 24 Jul 2025 03:24:16 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56O8OArL4050149;
	Thu, 24 Jul 2025 03:24:10 -0500
Message-ID: <b61181e5-0872-402c-b91b-3626302deaeb@ti.com>
Date: Thu, 24 Jul 2025 13:54:09 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation for
 RPMSG-ETH Driver
To: Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Mengyuan Lou
	<mengyuanlou@net-swift.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Fan Gong <gongfan1@huawei.com>, Lee Trager
	<lee@trager.us>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-2-danishanwar@ti.com>
 <81273487-a450-4b28-abcc-c97273ca7b32@lunn.ch>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <81273487-a450-4b28-abcc-c97273ca7b32@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 23/07/25 9:54 pm, Andrew Lunn wrote:
>> --- a/Documentation/networking/device_drivers/ethernet/index.rst
>> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
>> @@ -61,6 +61,7 @@ Contents:
>>     wangxun/txgbevf
>>     wangxun/ngbe
>>     wangxun/ngbevf
>> +   rpmsg_eth
> 
> This list is sorted. Please insert at the right location. I made the
> same comment to somebody else this week as well....
> 

Sure. I will re-order this.

>> +This driver is generic and can be used by any vendor. Vendors can develop their
>> +own firmware for the remote processor to make it compatible with this driver.
>> +The firmware must adhere to the shared memory layout, RPMSG communication
>> +protocol, and data exchange requirements described in this documentation.
> 
> Could you add a link to TIs firmware? It would be a good reference
> implementation. But i guess that needs to wait until the driver is
> merged and the ABI is stable.
> 

Currently TIs firmware is not open source. Once the firmware is
available in open source I can update the documentation to have a link
to that.

>> +Implementation Details
>> +----------------------
>> +
>> +- The magic number is defined as a macro in the driver source (e.g.,
>> +  ``#define RPMSG_ETH_SHM_MAGIC_NUM 0xABCDABCD``).
>> +- The firmware must write this value to the ``magic_num`` field of the head and
>> +  tail structures in the shared memory region.
>> +- During the handshake, the Linux driver reads these fields and compares them to
>> +  the expected value. If any mismatch is detected, the driver will log an error
>> +  and refuse to proceed.
> 
> So the firmware always takes the role of "primary" and Linux is
> "secondary"? With the current implementation, you cannot have Linux on
> both ends?
> 

Yes the firmware is primary and Linux is secondary. Linux can not be at
both ends.

> I don't see this as a problem, but maybe it is worth stating as a
> current limitation.
> 

Sure, I will mention that in the documentation in v2.

>> +Shared Memory Layout
>> +====================
>> +
>> +The RPMSG Based Virtual Ethernet Driver uses a shared memory region to exchange
>> +data between the host and the remote processor. The shared memory is divided
>> +into transmit and receive regions, each with its own `head` and `tail` pointers
>> +to track the buffer state.
>> +
>> +Shared Memory Parameters
>> +------------------------
>> +
>> +The following parameters are exchanged between the host and the firmware to
>> +configure the shared memory layout:
> 
> So the host tells the firmware this? Maybe this is explained later,
> but is the flow something like:
> 
> Linux makes an RPC call to the firmware with the parameters you list
> below. Upon receiving that RPC, the firmware puts the magic numbers in
> place. It then ACKs the RPC call? Linux then checks the magic numbers?
> 

Let me explain the flow,

Linux first send a rpmsg request with msg type = RPMSG_ETH_REQ_SHM_INFO
i.e. requesting for the shared memory info.

Once firmware recieves this request it sends response with below fields,

	num_pkt_bufs, buff_slot_size, base_addr, tx_offset, rx_offset

In the device tree, while reserving the shared memory for rpmsg_eth
driver, the base address and the size of the shared memory block is
mentioned. I have mentioned that in the documentation as well

+Configuration
+=============
+
+The driver relies on the device tree for configuration. The shared
memory region
+is specified using the `virtual-eth-shm` node in the device tree.
+
+Example Device Tree Node
+------------------------
+
+.. code-block:: dts
+
+   virtual-eth-shm {
+           compatible = "rpmsg,virtual-eth-shm";
+           reg = <0x80000000 0x10000>; /* Base address and size of
shared memory */
+   };

Now once Linux recieves (num_pkt_bufs, buff_slot_size, base_addr,
tx_offset, rx_offset) from firmware, the driver does a handshake
validation rpmsg_eth_validate_handshake() where the driver checks if the
base address recieved from firmware matches the base address resevred in
DT, if the tx and rx offsets are within the range, if the magic number
in tx and rx buffers are same as the magic number defined in driver etc.

Based on this validation the callback function returns success / failure.

If needed, I can add this detail also in the documentation.

>> +1. **num_pkt_bufs**:
>> +
>> +   - The total number of packet buffers available in the shared memory.
>> +   - This determines the maximum number of packets that can be stored in the
>> +     shared memory at any given time.
>> +
>> +2. **buff_slot_size**:
>> +
>> +   - The size of each buffer slot in the shared memory.
>> +   - This includes space for the packet length, metadata, and the actual packet
>> +     data.
>> +
>> +3. **base_addr**:
>> +
>> +   - The base address of the shared memory region.
>> +   - This is the starting point for accessing the shared memory.
> 
> So this is the base address in the Linux address space? How should the
> firmware convert this into a base address in its address space?
> 

The `base_addr` is the physical address of the shared memory. This is
reserved in the Linux DT. I haven't added the DT patch in this series,
but if you want I can add in v2 for your reference.

The same `base_addr` is used by firmware for the shared memory. During
the rpmsg callback, firmware shares this `base_addr` and during
rpmsg_eth_validate_handshake() driver checks if the base_addr shared by
firmware is same as the one described in DT or not. Driver only proceeds
if it's same.

After that the driver maps this base_addr and the tx / rx offsets in the
Linux virtual address space and use the same virtual address for writing
/ reading.

The firmware also maps this base_addr into it's vitual address space.
How firmware maps it is upto the firmware. The only requiremnt is that
the physical base_addr used by firmware and driver should be the same.

>> +4. **tx_offset**:
>> +
>> +   - The offset from the `base_addr` where the transmit buffers begin.
>> +   - This is used by the host to write packets for transmission.
>> +
>> +5. **rx_offset**:
>> +
>> +   - The offset from the `base_addr` where the receive buffers begin.
>> +   - This is used by the host to read packets received from the remote
>> +     processor.
> 
> Maybe change 'host' to 'Linux'? Or some other name, 'primary' and
> 'secondary'. The naming should be consistent throughout the
> documentation and driver.
> 

Sure I will change 'host' to 'Linux' and keep it consistent throughout
driver and firmware.

> Part of the issue here is that you pass this information from Linux to
> the firmware. When the firmware receives it, it has the complete
> opposite meaning. It uses "tx_offset" to receive packets, and
> "rx_offset" to send packets. This can quickly get confusing. If you
> used names like "linux_tx_offset", the added context with avoid
> confusion.
> 

Sure. Will do this.

>> +Shared Memory Structure
>> +-----------------------
>> +
>> +The shared memory layout is as follows:
>> +
>> +.. code-block:: text
>> +
>> +      Shared Memory Layout:
>> +      ---------------------------
>> +      |        MAGIC_NUM        |   rpmsg_eth_shm_head
>> +      |          HEAD           |
>> +      ---------------------------
>> +      |        MAGIC_NUM        |
>> +      |        PKT_1_LEN        |
>> +      |          PKT_1          |
>> +      ---------------------------
>> +      |           ...           |
>> +      ---------------------------
>> +      |        MAGIC_NUM        |
>> +      |          TAIL           |   rpmsg_eth_shm_tail
>> +      ---------------------------
>> +
>> +1. **MAGIC_NUM**:
>> +
>> +   - A unique identifier used to validate the shared memory region.
>> +   - Ensures that the memory region is correctly initialized and accessible.
>> +
>> +2. **HEAD Pointer**:
>> +
>> +   - Tracks the start of the buffer for packet transmission or reception.
>> +   - Updated by the producer (host or remote processor) after writing a packet.
> 
> Is this a pointer, or an offset from the base address? Pointers get
> messy when you have multiple address spaces involved. An offset is
> simpler to work with. Given that the buffers are fixed size, it could
> even be an index.
> 

Below are the structure definitions.

struct rpmsg_eth_shared_mem {
	struct rpmsg_eth_shm_index *head;
	struct rpmsg_eth_shm_buf *buf;
	struct rpmsg_eth_shm_index *tail;
} __packed;

struct rpmsg_eth_shm_index {
	u32 magic_num;
	u32 index;
}  __packed;

Head is pointer and it is mapped as below based on the information
shared by firmware

	port->tx_buffer->head =
		(struct rpmsg_eth_shm_index __force *)
		 (ioremap(msg->resp_msg.shm_info.base_addr +
			  msg->resp_msg.shm_info.tx_offset,
			  sizeof(*port->tx_buffer->head)));

>> +Information Exchanged Between RPMSG Channels
>> +--------------------------------------------
>> +
>> +1. **Requests from Host to Remote Processor**:
> 
> Another place where consistent naming would be good. Here it is the
> remote processor, not firmware used earlier.
> 

Sure I will rename it.

>> +
>> +   - `RPMSG_ETH_REQ_SHM_INFO`: Request shared memory information, such as
>> +     ``num_pkt_bufs``, ``buff_slot_size``, ``base_addr``, ``tx_offset``, and
>> +     ``rx_offset``.
> 
> Is this requested, or telling? I suppose the text above uses "between"
> which is ambiguous.

It's requested. The Linux driver requests firmware for these info.

> 
>> +3. **Notifications from Remote Processor to Host**:
>> +
>> +   - `RPMSG_ETH_NOTIFY_PORT_UP`: Notify that the Ethernet port is up and ready
>> +     for communication.
>> +   - `RPMSG_ETH_NOTIFY_PORT_DOWN`: Notify that the Ethernet port is down.
>> +   - `RPMSG_ETH_NOTIFY_PORT_READY`: Notify that the Ethernet port is ready for
>> +     configuration.
> 
> That needs more explanation. Why would it not be ready? 
> 

This actually not needed RPMSG_ETH_NOTIFY_PORT_UP and
RPMSG_ETH_NOTIFY_PORT_DOWN are enough. I will drop
RPMSG_ETH_NOTIFY_PORT_READY

>> +   - `RPMSG_ETH_NOTIFY_REMOTE_READY`: Notify that the remote processor is ready
>> +     for communication.
> 
> How does this differ from PORT_READY?

RPMSG_ETH_NOTIFY_REMOTE_READY implies that the remote processor i.e. the
firmware is ready where as RPMSG_ETH_NOTIFY_PORT_UP implies that the
ethernet port (Linux driver) is ready.

PORT_READY is not needed and can be dropped.


> 
>> +How-To Guide for Vendors
>> +========================
>> +
>> +This section provides a guide for vendors to develop firmware for the remote
>> +processor that is compatible with the RPMSG Based Virtual Ethernet Driver.
>> +
>> +1. **Implement Shared Memory Layout**:
>> +
>> +   - Allocate a shared memory region for packet transmission and reception.
>> +   - Initialize the `MAGIC_NUM`, `num_pkt_bufs`, `buff_slot_size`, `base_addr`,
>> +     `tx_offset`, and `rx_offset`.
>> +
>> +2. **Magic Number Requirements**
>> +
>> +   - The firmware must write a unique magic number (for example, ``0xABCDABCD``)
> 
> Why "for example"? Do you have a use case where some other value
> should be used? Or can we just make this magic value part of the
> specification?

No the magic number is always the same. I will update the doucmentation
to state the same.
> 
>> +- The driver assumes a specific shared memory layout and may not work with other
>> +  configurations.
>> +- Multicast address filtering is limited to the capabilities of the underlying
>> +  RPMSG framework.
> 
> I don't think there is anything special here. The network stack always
> does perfect address filtering. The driver can help out, by also doing
> perfect address filtering, or imperfect address filtering, and letting
> more through than actually wanted. Or it can go into promiscuous mode.
> 

Sure. I will drop this.

>> +- The driver currently supports only one transmit and one receive queue.
>> +
>> +References
>> +==========
>> +
>> +- RPMSG Framework Documentation: https://www.kernel.org/doc/html/latest/rpmsg.html
> 
> This results in 404 Not Found.
> 

I see the url is wrong. I will update the correct url
https://docs.kernel.org/staging/rpmsg.html

>      Andrew

-- 
Thanks and Regards,
Danish


