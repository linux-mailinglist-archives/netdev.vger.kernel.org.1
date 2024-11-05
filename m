Return-Path: <netdev+bounces-141998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FAD9BCEBD
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667101C21A9B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBB1D6DDC;
	Tue,  5 Nov 2024 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WdgwpUTU"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921961D5160;
	Tue,  5 Nov 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815763; cv=none; b=Ft4DOS8+1rhwvxWP4pULSdbe1OW/X+f0rtYgtF6EC8YZ4OyYXZancK28d0bzIrKLjPCctI7rQzqLANutzpakAti6qBwawfQffNWBazNRpP3FkHLRYOizekas22jlSH7NzSCai6mASMhs9xpm2aTbSAOZboamk32fNOHh6xWa2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815763; c=relaxed/simple;
	bh=7EXK0GtrYV87pSMTgaawQ3RdZ9op2hMQY5GP0nFAmAw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stFX2Bu5p7aF+WW4dzhgFhFsR08+meOTrzSPxzXEJBm4mLzHG3gacSYo7pEeRbKkxE/m/qfEUEHvGErlXOFjmAnsEljor5M1mHaJtv+umCCbxCCisJv9I5iSiJOMY1e/iZ2X/kx73w59185D5Pnki/r1uCRkCNCcijE+buaYOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WdgwpUTU; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730815756;
	bh=7EXK0GtrYV87pSMTgaawQ3RdZ9op2hMQY5GP0nFAmAw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WdgwpUTUWXs3k2dPPsN1RmufKy6Ft8Hzw4k/D6Fc+b05wFtVko6dQDnuydbmoiEPv
	 tVllYzjzx70CA9SprXPSxF5Jo7fapqx7soSXmw5KD1Xk+LVe4MZY7y+eOflwojXYZ7
	 Sb67RP1zPclevj2NnAzwOoqZS+l3keXdTkIG3P3PNiPqhCnnkgIlj7iKrb9OHECSxm
	 qbCxtDIQUgnZvchzoQfVam/EB3q7Ln/iqgwh7Fd7csK5GhplLF3RtmfS/vP0EH3Co+
	 jMQyskM0oY3Y0NfNubIv5TOZGp9FXLNk3uD4oAirtg/t58xVvQPlpVhKF6BmcI4JFx
	 Wl+k+J0kI2pbw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 660F46B0ED;
	Tue,  5 Nov 2024 22:09:15 +0800 (AWST)
Message-ID: <f4e3ff994fe28bb2645b5fddf1850f8fcc5d1f89.camel@codeconstruct.com.au>
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
Date: Tue, 05 Nov 2024 22:09:15 +0800
In-Reply-To: <c69f83fa-a4e2-48fc-8c1a-553724828d70@amperemail.onmicrosoft.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
	 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
	 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
	 <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
	 <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
	 <c69f83fa-a4e2-48fc-8c1a-553724828d70@amperemail.onmicrosoft.com>
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

> > > We need a hardware address to create a socket without an EID in
> > > order
> > > to know where we are sending the packets.
> > Just to clarify that: for physical (ie, null-EID) addressing, you
> > don't
> > need the hardware address, you need:
> >=20
> > =C2=A0 1) the outgoing interface's ifindex; and
> > =C2=A0 2) the hardware address of the *remote* endpoint, in whatever
> > =C2=A0=C2=A0=C2=A0=C2=A0 format is appropriate for link type
> >=20
> > In cases where there is no hardware addressing in the tx packet
> > (which
> > looks to apply to PCC), (2) is empty.
> >=20
> > I understand that you're needing some mechanism for finding the
> > correct
> > ifindex, but I don't think using the device lladdr is the correct
> > approach.
> >=20
> > We have this model already for mctp-over-serial, which is another
> > point-to-point link type. MCTP-over-serial devices have no hardware
> > address, as there is no hardware addressing in the packet format.
> > In
> > EID-less routing, it's up to the application to determine the
> > ifindex,
> > using whatever existing device-identification mechanism is
> > suitable.
>=20
> I'd like to avoid having a custom mechanism to find the right=20
> interface.=C2=A0 Agreed that this is really find 1) above: selecting the=
=20
> outgoing interface.

OK, but from what you're adding later it sounds like you already have
part of that mechanism custom anyway: the mapping of a socket to a
channel index?

It sounds like there will always be some requirement for a
platform-specific inventory-mapping mechanism; you're going from socket
number to ifindex. It should be just as equivalent to implement that
using a sysfs attribute rather than the device lladdr, no?

> There is already an example of using the HW address in the interface:=C2=
=A0
> the loopback has an address in it, for some reason. Probably because
> it is inherited from the Ethernet loopback.

Yes, and that the ethernet packet format does include a physical
address, hence the lladdr being present on lo.

> In our use case, we expect there to be two MCTP-PCC links available
> on a=20
> 2 Socket System, one per socket.=C2=A0 The end user needs a way to know
> which=20
> device talks to which socket.=C2=A0 In the case of a single socket system=
,
> there should only be one.
>=20
> However, there is no telling how this mechanism will be used in the=20
> future, and there may be MCTP-PCC enabled devices that are not bound
> to a CPU.

That's fine; I think finding an interface based on the channel numbers
seems generally applicable.

> Technically we get the signature field in the first four bytes of the
> PCC Generic Comunications channel Shared memory region:
>=20
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_=
Channel/Platform_Comm_Channel.html#generic-communications-channel-shared-me=
mory-region
>=20
> "The PCC signature. The signature of a subspace is computed by a=20
> bitwise-or of the value 0x50434300 with the subspace ID. For example,
> subspace 3 has the signature 0x50434303."

ok! so there is some form of addressing on the packet. Can we use this
subspace ID as a form of lladdr? Could this be interpreted as the
"destination" of a packet?

You do mention that it may not be suitable though:

> One possibility is to do another revision that uses=C2=A0 the SIGNATURE a=
s
> the HW address, with an understanding that if the signature changes,=20
> there will be a corresponding change in the HW address,

Is that signature format expected to change across DSP0292 versions?

Cheers,


Jeremy

