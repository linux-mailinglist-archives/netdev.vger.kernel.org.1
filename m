Return-Path: <netdev+bounces-209401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48990B0F806
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F80547977
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584D1F0994;
	Wed, 23 Jul 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="liLifVWL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F01C1AAA;
	Wed, 23 Jul 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287901; cv=none; b=QW1UeUG3XbllswzGyEcRQlgBfzn/lRCsKI4gATDcutUxFNrNXt7BEhii3AQ4hkXXV+1phvm244c/xZTrW/tMYEOOO3ULoTH/LfeEeFt3/4FbDJL2e0m7p3+vrF8hosokIxjNi9THnQIaLdd84Wo2esVt5yowWH158S49Pt7rBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287901; c=relaxed/simple;
	bh=+yH5sdRuy5JtUTts9MfUfZZCJprgFstIzCLKlBAEnhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxVHUOt3JNRpi4vCSA6MN4l9SNHqaEQsjZV3TKxsUeCWNL7beIebS2C9DWEl17foFps0dBM9vZL97mLRtttD2d/3BDww0Ekb2w0trfuE6EHpEDL3OBbSYggbaDxnbk7esRlWh7dtV2WuqDgLlbdWhMlENgGts8l7Gzd0g5YPGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=liLifVWL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zZNfuBfgB8dRySkDcZcabnnOZgPd4ahYjtj3I0BOkM4=; b=liLifVWLrTxGNp03U4ezUOaAcM
	kl7wHLDNErluVHrsCzFpLad3A/KqCtnUpyr3eFfWTFeV57VEatuR6kyvyxrGBZ6isu2L2UwzHYOaR
	Vj24hXdbxfa2gaUtS3K/HWa+DrZ/czeRVIrpr5mNRBnd08VndPL8P6CUVzNAjM3crXcs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uecGS-002fSW-KG; Wed, 23 Jul 2025 18:24:20 +0200
Date: Wed, 23 Jul 2025 18:24:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Fan Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation for
 RPMSG-ETH Driver
Message-ID: <81273487-a450-4b28-abcc-c97273ca7b32@lunn.ch>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723080322.3047826-2-danishanwar@ti.com>

> --- a/Documentation/networking/device_drivers/ethernet/index.rst
> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -61,6 +61,7 @@ Contents:
>     wangxun/txgbevf
>     wangxun/ngbe
>     wangxun/ngbevf
> +   rpmsg_eth

This list is sorted. Please insert at the right location. I made the
same comment to somebody else this week as well....

> +This driver is generic and can be used by any vendor. Vendors can develop their
> +own firmware for the remote processor to make it compatible with this driver.
> +The firmware must adhere to the shared memory layout, RPMSG communication
> +protocol, and data exchange requirements described in this documentation.

Could you add a link to TIs firmware? It would be a good reference
implementation. But i guess that needs to wait until the driver is
merged and the ABI is stable.

> +Implementation Details
> +----------------------
> +
> +- The magic number is defined as a macro in the driver source (e.g.,
> +  ``#define RPMSG_ETH_SHM_MAGIC_NUM 0xABCDABCD``).
> +- The firmware must write this value to the ``magic_num`` field of the head and
> +  tail structures in the shared memory region.
> +- During the handshake, the Linux driver reads these fields and compares them to
> +  the expected value. If any mismatch is detected, the driver will log an error
> +  and refuse to proceed.

So the firmware always takes the role of "primary" and Linux is
"secondary"? With the current implementation, you cannot have Linux on
both ends?

I don't see this as a problem, but maybe it is worth stating as a
current limitation.

> +Shared Memory Layout
> +====================
> +
> +The RPMSG Based Virtual Ethernet Driver uses a shared memory region to exchange
> +data between the host and the remote processor. The shared memory is divided
> +into transmit and receive regions, each with its own `head` and `tail` pointers
> +to track the buffer state.
> +
> +Shared Memory Parameters
> +------------------------
> +
> +The following parameters are exchanged between the host and the firmware to
> +configure the shared memory layout:

So the host tells the firmware this? Maybe this is explained later,
but is the flow something like:

Linux makes an RPC call to the firmware with the parameters you list
below. Upon receiving that RPC, the firmware puts the magic numbers in
place. It then ACKs the RPC call? Linux then checks the magic numbers?

> +1. **num_pkt_bufs**:
> +
> +   - The total number of packet buffers available in the shared memory.
> +   - This determines the maximum number of packets that can be stored in the
> +     shared memory at any given time.
> +
> +2. **buff_slot_size**:
> +
> +   - The size of each buffer slot in the shared memory.
> +   - This includes space for the packet length, metadata, and the actual packet
> +     data.
> +
> +3. **base_addr**:
> +
> +   - The base address of the shared memory region.
> +   - This is the starting point for accessing the shared memory.

So this is the base address in the Linux address space? How should the
firmware convert this into a base address in its address space?

> +4. **tx_offset**:
> +
> +   - The offset from the `base_addr` where the transmit buffers begin.
> +   - This is used by the host to write packets for transmission.
> +
> +5. **rx_offset**:
> +
> +   - The offset from the `base_addr` where the receive buffers begin.
> +   - This is used by the host to read packets received from the remote
> +     processor.

Maybe change 'host' to 'Linux'? Or some other name, 'primary' and
'secondary'. The naming should be consistent throughout the
documentation and driver.

Part of the issue here is that you pass this information from Linux to
the firmware. When the firmware receives it, it has the complete
opposite meaning. It uses "tx_offset" to receive packets, and
"rx_offset" to send packets. This can quickly get confusing. If you
used names like "linux_tx_offset", the added context with avoid
confusion.

> +Shared Memory Structure
> +-----------------------
> +
> +The shared memory layout is as follows:
> +
> +.. code-block:: text
> +
> +      Shared Memory Layout:
> +      ---------------------------
> +      |        MAGIC_NUM        |   rpmsg_eth_shm_head
> +      |          HEAD           |
> +      ---------------------------
> +      |        MAGIC_NUM        |
> +      |        PKT_1_LEN        |
> +      |          PKT_1          |
> +      ---------------------------
> +      |           ...           |
> +      ---------------------------
> +      |        MAGIC_NUM        |
> +      |          TAIL           |   rpmsg_eth_shm_tail
> +      ---------------------------
> +
> +1. **MAGIC_NUM**:
> +
> +   - A unique identifier used to validate the shared memory region.
> +   - Ensures that the memory region is correctly initialized and accessible.
> +
> +2. **HEAD Pointer**:
> +
> +   - Tracks the start of the buffer for packet transmission or reception.
> +   - Updated by the producer (host or remote processor) after writing a packet.

Is this a pointer, or an offset from the base address? Pointers get
messy when you have multiple address spaces involved. An offset is
simpler to work with. Given that the buffers are fixed size, it could
even be an index.

> +Information Exchanged Between RPMSG Channels
> +--------------------------------------------
> +
> +1. **Requests from Host to Remote Processor**:

Another place where consistent naming would be good. Here it is the
remote processor, not firmware used earlier.

> +
> +   - `RPMSG_ETH_REQ_SHM_INFO`: Request shared memory information, such as
> +     ``num_pkt_bufs``, ``buff_slot_size``, ``base_addr``, ``tx_offset``, and
> +     ``rx_offset``.

Is this requested, or telling? I suppose the text above uses "between"
which is ambiguous.

> +3. **Notifications from Remote Processor to Host**:
> +
> +   - `RPMSG_ETH_NOTIFY_PORT_UP`: Notify that the Ethernet port is up and ready
> +     for communication.
> +   - `RPMSG_ETH_NOTIFY_PORT_DOWN`: Notify that the Ethernet port is down.
> +   - `RPMSG_ETH_NOTIFY_PORT_READY`: Notify that the Ethernet port is ready for
> +     configuration.

That needs more explanation. Why would it not be ready? 

> +   - `RPMSG_ETH_NOTIFY_REMOTE_READY`: Notify that the remote processor is ready
> +     for communication.

How does this differ from PORT_READY?

> +How-To Guide for Vendors
> +========================
> +
> +This section provides a guide for vendors to develop firmware for the remote
> +processor that is compatible with the RPMSG Based Virtual Ethernet Driver.
> +
> +1. **Implement Shared Memory Layout**:
> +
> +   - Allocate a shared memory region for packet transmission and reception.
> +   - Initialize the `MAGIC_NUM`, `num_pkt_bufs`, `buff_slot_size`, `base_addr`,
> +     `tx_offset`, and `rx_offset`.
> +
> +2. **Magic Number Requirements**
> +
> +   - The firmware must write a unique magic number (for example, ``0xABCDABCD``)

Why "for example"? Do you have a use case where some other value
should be used? Or can we just make this magic value part of the
specification?

> +- The driver assumes a specific shared memory layout and may not work with other
> +  configurations.
> +- Multicast address filtering is limited to the capabilities of the underlying
> +  RPMSG framework.

I don't think there is anything special here. The network stack always
does perfect address filtering. The driver can help out, by also doing
perfect address filtering, or imperfect address filtering, and letting
more through than actually wanted. Or it can go into promiscuous mode.

> +- The driver currently supports only one transmit and one receive queue.
> +
> +References
> +==========
> +
> +- RPMSG Framework Documentation: https://www.kernel.org/doc/html/latest/rpmsg.html

This results in 404 Not Found.

     Andrew

