Return-Path: <netdev+bounces-209817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44DB10FC8
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BB6165CE3
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692C2EAD03;
	Thu, 24 Jul 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fQamVq7i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958E8F7D;
	Thu, 24 Jul 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375080; cv=none; b=iWfnQVMMUhe/Z53GQ4+3dyA72Z5MaunGi9vs0blxkZEyNjhgY8lyEIH1V/nLqyLsBL06IBeMxdBhiHeWwLgnYh+wKqdiBBjdpxEsYP/XZhXHw4t+nOB97gBT0ARnG1zmM8o6lMqOPX9k+E+TPHQChCbJfroP0DXZ6dKFXJ5sLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375080; c=relaxed/simple;
	bh=OXH8GmJZvpZLoq1JxdBZ8cdu2Ka5GQMselFH6Jtg44c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3PlrvSZCRgAlkG4WquKqoyciLnbhlENsGOASebQdgKGty1DjQ8oC+mGGhak5WdlTeFy/4HXMqtvgTJ97Ukrmmb0mbQazeDRZXmZ7QMJQJ6aNVvYwpY6qgkuo0AkPQR+alllduJSyiVwAsAKQ8/LbIoNGFSw6j+8YzkmF+Z2O08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fQamVq7i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DEdQcTV0U+iw+S/8LeqtsI4CCRmQHF+4d/FyF/4p8jE=; b=fQamVq7i79nXoR63qwAm66YW3O
	5U54kPNusnGYcHr/pNY7NUzhoy/TKltzpc7DBlRuVvCAURExdeRxAYUX4cFKpG956svMVn7h8DtoP
	j4E9Xmfr/IsVttZb8CtK3XnhO2EKrJ6mJcg1oHomCfvyPfk8uCxKCCuRH5ko3lWlCbYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueywX-002mWy-Ct; Thu, 24 Jul 2025 18:37:17 +0200
Date: Thu, 24 Jul 2025 18:37:17 +0200
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
Message-ID: <0a002a5b-9f1a-4972-8e1c-fa9244cec180@lunn.ch>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-2-danishanwar@ti.com>
 <81273487-a450-4b28-abcc-c97273ca7b32@lunn.ch>
 <b61181e5-0872-402c-b91b-3626302deaeb@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b61181e5-0872-402c-b91b-3626302deaeb@ti.com>

> Linux first send a rpmsg request with msg type = RPMSG_ETH_REQ_SHM_INFO
> i.e. requesting for the shared memory info.
> 
> Once firmware recieves this request it sends response with below fields,
> 
> 	num_pkt_bufs, buff_slot_size, base_addr, tx_offset, rx_offset
> 
> In the device tree, while reserving the shared memory for rpmsg_eth
> driver, the base address and the size of the shared memory block is
> mentioned. I have mentioned that in the documentation as well

If it is in device tree, why should Linux ask for the base address and
length? That just seems like a source of errors, and added complexity.

In general, we just trust DT. It is a source of truth. So i would
delete all this backwards and forwards and just use the values from
DT. Just check the magic numbers are in place.

> The same `base_addr` is used by firmware for the shared memory. During
> the rpmsg callback, firmware shares this `base_addr` and during
> rpmsg_eth_validate_handshake() driver checks if the base_addr shared by
> firmware is same as the one described in DT or not. Driver only proceeds
> if it's same.

So there is a big assumption here. That both are sharing the same MMU,
or maybe IOMMU. Or both CPUs have configured their MMU/IOMMU so that
the pages appear at the same physical address. I think this is a
problem, and the design should avoid anything which makes this
assumptions. The data structures within the share memory should only
refer to offsets from the base of the shared memory, not absolute
values. Or an index into the table of buffers, 0..N.

> >> +2. **HEAD Pointer**:
> >> +
> >> +   - Tracks the start of the buffer for packet transmission or reception.
> >> +   - Updated by the producer (host or remote processor) after writing a packet.
> > 
> > Is this a pointer, or an offset from the base address? Pointers get
> > messy when you have multiple address spaces involved. An offset is
> > simpler to work with. Given that the buffers are fixed size, it could
> > even be an index.
> > 
> 
> Below are the structure definitions.
> 
> struct rpmsg_eth_shared_mem {
> 	struct rpmsg_eth_shm_index *head;
> 	struct rpmsg_eth_shm_buf *buf;
> 	struct rpmsg_eth_shm_index *tail;
> } __packed;
> 
> struct rpmsg_eth_shm_index {
> 	u32 magic_num;
> 	u32 index;
> }  __packed;

So index is the index into the array of fixed size buffers. That is
fine, it is not a pointer, so you don't need to worry about address
spaces. However, head and tail are pointers, so for those you do need
to worry about address spaces. But why do you even need them? Just put
the indexes directly into rpmsg_eth_shared_mem. The four index values
can be in the first few words of the shared memory, fixed offset from
the beginning, KISS.

	Andrew

