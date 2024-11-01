Return-Path: <netdev+bounces-140957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CCE9B8D5F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1271C220D2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9FF156676;
	Fri,  1 Nov 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XhTR7R+r"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7F147C9B;
	Fri,  1 Nov 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451349; cv=none; b=X53BOw+M9b8a7rZ0/lh3f6QiXXFMnMMREUntzLPdd7nionR26kC4Y44DDdPyPXSrQZaeah2dL1BGgFWeK6aSR7xtOE136XktH6aMIPHOuubzQBS6ZpiopgWys1kGttmib0vofnENBQweWoyUX8CHWFmK0rnJ6povgWWeCWngQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451349; c=relaxed/simple;
	bh=fLxGO+NXyb3lVBIx8VQdDEHOKDua9XIGAZdhiTyuwsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dap5xYolSI9xYvVidG84UzENTJaZWiVrTw0zhyZbNe3ctZjQbpAYsWS37el8HJxFC79BSiYaRV5yaAcjonT8y6INEEoQ/ct2PfK4/fKTCG0jFqiimlTIiq9CAxPj0/OLQT0LfSxI25cpBEopar5Xe2gczphqIedzgS3KM+k7YJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XhTR7R+r; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730451337;
	bh=LK1BfNcDjWqjY5IAYjhatcpF/S0PKDuPZuW/7DFKhNQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XhTR7R+rWkMy7t6j1Hw+Cfy162xf8VxwNkdwTKRmlrPAcW6I4BfMr6B/Q99K/b9rh
	 icKaOqO3a5I0Vjub/Do1b23hdcBNbSErAdYbk0VqdWykOT0RwxCdHMArGM+M4OazmC
	 RDpvpSyAl4AyIcYjWlMj7gCqhOavqv2OkO3/M4rhnMhT51IRwiG6+VYj5fU8FJ7i/3
	 EWMsUSP+IbvRYkcVZB7vCKxMMyIhqYzO/m/V46YHw+SCS8pQHWMd7UoHp7lHLq0xIt
	 R+8TaQT0yguqBdjEVYx+I1t5str35nwe09Z9/V2BTx2xEGRWxl46SrlwC3SbLeJjDb
	 SS5useDzSNe5w==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 00A226A53E;
	Fri,  1 Nov 2024 16:55:35 +0800 (AWST)
Message-ID: <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, 
 admiyo@os.amperecomputing.com, Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Fri, 01 Nov 2024 16:55:35 +0800
In-Reply-To: <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
	 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
	 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
	 <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,

Thanks for the quick response. I think the dev lladdr is the main thing
to work out here, and it's not something we can change that post-merge.
I'm not yet  convinced on your current approach, but a few
comments/queries that may help us get a consensus there, one way or the
other:

> We need a hardware address to create a socket without an EID in order
> to know where we are sending the packets.

Just to clarify that: for physical (ie, null-EID) addressing, you don't
need the hardware address, you need:

 1) the outgoing interface's ifindex; and
 2) the hardware address of the *remote* endpoint, in whatever=C2=A0
    format=C2=A0is appropriate for link type

In cases where there is no hardware addressing in the tx packet (which
looks to apply to PCC), (2) is empty.=20

I understand that you're needing some mechanism for finding the correct
ifindex, but I don't think using the device lladdr is the correct
approach.

We have this model already for mctp-over-serial, which is another
point-to-point link type. MCTP-over-serial devices have no hardware
address, as there is no hardware addressing in the packet format. In
EID-less routing, it's up to the application to determine the ifindex,
using whatever existing device-identification mechanism is suitable.

> The Hardware addressing is needed to be able to use the device in=20
> point-to-point mode.=C2=A0 It is possible to have multiple devices at the=
=20
> hardware level, and also to not use EID based routing.=C2=A0 Thus, the
> kernel needs to expose which device is which.

Yes, that's totally fine to expect find a specific device - but the
device's hardware address is not the conventional place to do that.

> The Essential piece of information is the outbox, which identifies
> which channel the=C2=A0message will be sent on.=C2=A0 The inbox is in the
> hardware address as well as a confirmation of on which channel the
> messages are expected to return.

Those are the indices of the shared memory regions used for the
transfer, right?

> In the future, it is possible to reuse channels and IRQs in
> constrained situations, and the driver would then be able to deduce
> from the packet which remote device sent it.

The spec mentions:

  A single PCC instance shall serve as a communication channel=C2=A0
  between=C2=A0at most two MCTP capable entities

so how is it ambiguous which remote device has sent a packet? Am I
misinterpreting "channel" there?

In which case, how does the driver RX path do that deduction? There is
no hardware addressing information in the DSP0292 packet format.

> =C2=A0Instead, there is a portion of it on outgoing packets, and a
> different portion on incoming packets.
>=20
> The hardware address format is in an upcoming version of the spec not
> yet published.

I can't really comment on non-published specs, but that looks more like
identifiers for the tx/rx channel pair (ie., maps to a device
identifier) rather than physical packet addressing data (ie., an
interface lladdr). Happy to be corrected on that though!

Cheers,


Jeremy

