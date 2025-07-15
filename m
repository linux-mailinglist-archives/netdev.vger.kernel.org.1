Return-Path: <netdev+bounces-206942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47279B04D33
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 03:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1AF1A67DFA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E819F42D;
	Tue, 15 Jul 2025 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HcLN9Hwl"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC3B67F;
	Tue, 15 Jul 2025 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752541702; cv=none; b=GZiSHPqumOfEtWnBhaTm3HCdxQU/JTw6tqoM70RcYEkYus3kM/9eYcJN3yA9dNMy1FIDrpoUfzt0kf0bcPthcII1zxvPhh95vMOnIpV2d8qWpsqxxJgmKhZG4xHYuLSJ4Uk0apIJYY5HrypobvglkF3JxmpkgXZPDzGmphOG79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752541702; c=relaxed/simple;
	bh=ojrv6DJfXjklr/E0fZqpqhsV0atMlJMyXmZtdKiYlPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YNMVi/MC4GPzfEbXjEwUhPsn9tQ2UiAlqJYo4DR2/emP0V/BcEQyvzRu3SOszfbN1Zapz/4CfbhWg0NBWfEvwI9uajGrRyMwAySZIPbn9nKT0HxKt/vLIUOvhcmtnwrMLJ/t/Z1k/mMLAOjJ8b25pr9nom2wlR+C1lxusC49AuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HcLN9Hwl; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752541697;
	bh=ojrv6DJfXjklr/E0fZqpqhsV0atMlJMyXmZtdKiYlPQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HcLN9HwlQSJy468mVAXckRgEKJUzHfeAzRiYM5tur9AtCOgBN/Pdcb+3okPGklKYj
	 t0OYQD5jo0iKWnLuWktQbVDiWiMSLqY3NDsJ9DmV34IEK1B2tG5cegIsnofsmQ2pgb
	 YpAw3V8BoIzlyES3jb1+QfMKH+XQbnyfVuZd5/nY3y5Y0B+pG/dgkqBXDpYS7IbAiQ
	 NEYAo9XD8uuN0z8xuiaB4r8t0BMlfEBaqss7WMq09wcR7xiY/IiFq744TfKxAz5zdn
	 OXBIYebGHkGRDnSBQ/HgLpMOhVbHo1k27Abv5u3irX0e3smRAjPRlqEVPxkawQkNu6
	 3BOzqhdpka0eg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A1DCF6B68A;
	Tue, 15 Jul 2025 09:08:16 +0800 (AWST)
Message-ID: <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: YH Chung <yh_chung@aspeedtech.com>, "matt@codeconstruct.com.au"
 <matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, BMC-SW
 <BMC-SW@aspeedtech.com>
Cc: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Date: Tue, 15 Jul 2025 09:08:16 +0800
In-Reply-To: <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi YH,

> > Do we really need an abstraction for MCTP VDM drivers? How many are you
> > expecting? Can you point us to a client of the VDM abstraction?
> >=20
> > There is some value in keeping consistency for the MCTP lladdr formats =
across
> > PCIe transports, but I'm not convinced we need a whole abstraction laye=
r for
> > this.
> >=20
> We plan to follow existing upstream MCTP transports=E2=80=94such as I=C2=
=B2C, I=C2=B3C,
> and USB=E2=80=94by abstracting the hardware-specific details into a commo=
n
> interface and focus on the transport binding protocol in this patch.
> This driver has been tested by our AST2600 and AST2700 MCTP driver.

Is that one driver (for both 2600 and 2700) or two?

I'm still not convinced you need an abstraction layer specifically for
VDM transports, especially as you're forcing a specific driver model
with the deferral of TX to a separate thread.

Even if this abstraction layer is a valid approach, it would not be
merged until you also have an in-kernel user of it.

> > > TX path uses a dedicated kernel thread and ptr_ring: skbs queued by
> > > the MCTP stack are enqueued on the ring and processed in-thread conte=
xt.
> >=20
> > Is this somehow more suitable than the existing netdev queues?
> >=20
> Our current implementation has two operations that take time: 1)
> Configure the PCIe VDM routing type as DSP0238 requested if we are
> sending certain ctrl message command codes like Discovery Notify
> request or Endpoint Discovery response. 2) Update the BDF/EID routing
> table.

More on this below, but: you don't need to handle either of those in
a transport driver.

> > > +struct mctp_pcie_vdm_route_info {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 eid;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 dirty;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 bdf_addr;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_node hnode;
> > > +};
> >=20
> > Why are you keeping your own routing table in the transport driver? We =
already
> > have the route and neighbour tables in the MCTP core code.
> >=20
> > Your assumption that you can intercept MCTP control messages to keep a
> > separate routing table will not work.
> >=20
> We maintain a routing table in the transport driver to record the
> mapping between BDFs and EIDs, as the BDF is only present in the PCIe
> VDM header of received Endpoint Discovery Responses. This information
> is not forwarded to the MCTP core in the MCTP payload. We update the
> table with this mapping before forwarding the MCTP message to the
> core.

There is already support for this in the MCTP core - the neighbour table
maintains mappings between EID and link-layer addresses. In the case of
a PCIe VDM transport, those link-layer addresses contain the bdf data.

The transport driver only needs to be involved in packet transmit and
receive. Your bdf data is provided to the driver through the
header_ops->create() op.

Any management of the neighbour table is performed by userspace, which
has visibility of the link-layer addresses of incoming skbs - assuming
your drivers are properly setting the cb->haddr data on receive.

This has already been established through the existing transports that
consume lladdr data (i2c and i3c). You should not be handling the
lladdr-to-EID mapping *at all* in the transport driver.

> Additionally, if the MCTP Bus Owner operates in Endpoint (EP) role on
> the PCIe bus, it cannot obtain the physical addresses of other devices
> from the PCIe bus.

Sure it can, there are mechanisms for discovery. However, that's
entirely handled by userspace, which can update the existing neighbour
table.

> Agreed. In our implement, we always fill in the "Route By ID" type
> when core asks us to create the header, since we don't know the
> correct type to fill at that time.=C2=A0 And later we update the Route ty=
pe
> based on the ctrl message code when doing TX. I think it would be nice
> if we can have a uniformed address format to get the actual Route type
> by passed-in lladdr when creating the header.

OK, so we'd include the routing type in the lladdr data then.

Cheers,


Jeremy

