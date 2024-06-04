Return-Path: <netdev+bounces-100416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6A08FA769
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 03:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82933280F1C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 01:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1800B8494;
	Tue,  4 Jun 2024 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gOX4dm+g"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530254A2C;
	Tue,  4 Jun 2024 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463768; cv=none; b=eMLEzYn7q2rtd95x9lmbO+vbttOEbE5qL1OA371quexnDoxE4f+aWh1qbgka+notFVymxkwuLZM7648HHKmYVpS/1jbNeKhxwpH/LxWd3S0QFEnmlOcQksl/T+oUHKZhiQ95Lz84u92YWCP6fqVpF8cku6vYW/JkFN4V/3+BQ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463768; c=relaxed/simple;
	bh=3k4VVgF3vzvK7xLsva37al3VhH6jC2ecwaxPsYlpRLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DYgvMbMs3LapG+op8t1eBRR1w2MNbxEOB75X37KgpxxpQdlzeZ7JvlmNDtTOmRv8huZ9Eo/A09YsQTcY14s4PIbOKY30jqKWIdDXqNo29m0dsrXzB8hZQIVcnecypyZaacH2PejU0KVSOy7a1tssgrAwruCADqrEvByqCMsa97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=gOX4dm+g; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7112D2013B;
	Tue,  4 Jun 2024 09:15:53 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717463754;
	bh=PwovlZCKdFMr+QpQpCC2tTBSTOMUP4TYt99tDEe4S2I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gOX4dm+gp8roOZb0OqKy6dQGgS+HWCAZMLSIAd+e1g3mY5T+MplAbFKjPIJq5gx6u
	 6bjVU8MOVsKbcDNFifflHT9Z2xmlHmx5b7yL2KcmWhQneoMfD4pHcv6Kvx4nu0WGw5
	 pjiVw98XyF9L38Tjy60+PO/z1psXD29DCicFlNpWrEjE5yqeImaev/W/JIpeoNZedO
	 yXpUOJrejGTcPj//+TGXrPGV7Vpy9QJNI2vIlWKgwCi51+4tmjVT+okygjJtYBHfVr
	 g/4pTo1czHWKHggVqz9p2BQ6m8r1DnXlKhAR9N4EJIZrIffx3UCltzENMza994Oa0r
	 frCn6JFNyxxvQ==
Message-ID: <4eefd134bec51482655018bbbd7c4d5c7668a7fa.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, 
 admiyo@os.amperecomputing.com, Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Jun 2024 09:15:53 +0800
In-Reply-To: <1a38b394-30ae-42c6-b363-9f3a00166259@amperemail.onmicrosoft.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
	 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
	 <20240528191823.17775-4-admiyo@os.amperecomputing.com>
	 <6a01ffb4ef800f381d3e494bf1862f6e4468eb7d.camel@codeconstruct.com.au>
	 <1a38b394-30ae-42c6-b363-9f3a00166259@amperemail.onmicrosoft.com>
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

> > And can you include a brief summary of changes since the prior version
> > you have sent?
> >=20
> They are all in the header patch.

Ah, neat. Can you include reviewers on CC for that 0/n patch then?

> > > +static struct list_head mctp_pcc_ndevs;
> > I'm not clear on what this list is doing; it seems to be for freeing
> > devices on module unload (or device remove).
> >=20
> > However, the module will be refcounted while there are devices bound, s=
o
> > module unload shouldn't be possible in that state. So the only time
> > you'll be iterating this list to free everything will be when it's
> > empty.
> >=20
> > You could replace this with the mctp_pcc_driver_remove() just removing =
the
> > device passed in the argument, rather than doing any list iteration.
> >=20
> > ... unless I've missed something?
>=20
> There is no requirement that all the devices=C2=A0 be unloaded in order f=
or=20
> the module to get unloaded.

... aside from the driver refcounting. You're essentially replicating
the driver core's own facility for device-to-driver mappings here.

> It someone wants to disable the MCTP devices, they can unload the=20
> module, and it gets cleaned up.
>=20
> With ACPI, the devices never go away, they are defined in a table read=
=20
> at start up and stay there.

Sure, the ACPI bus devices may always be present, but you can still
unbind the driver from one device:

   echo '<device-id>' > /sys/bus/acpi/drivers/mctp_pcc/unbind

- where device-id is one of the links to a device in that mctp_pcc dir.

then:

> So without this change there is no way to unload the module.

... with no devices bound, you can safely unload the module (but the
unload path will also perform that unbind anyway, more on that below).

> Maybe it is just a convenience for development, but I think most
> modules behave this way.

If you can avoid holding internal references to devices, you have a
whole class of bugs you can avoid.

> > Any benefit in including the pcc_hdr in the skb?
> >=20
> > (not necessarily an issue, just asking...)
> It shows up in=C2=A0 tracing of the packet.=C2=A0 Useful for debugging.

Sounds good!

> > Does anything need to tell the mailbox driver to do that ack after
> > setting ack_rx?
>=20
> Yes.=C2=A0 It is in the previous patch, in the pcc_mailbox code.=C2=A0 I=
=20
> originally had it as a follow on, but reordered to make it a pre-req.=C2=
=A0=20
> That allows me to inline this logic, making the driver easier to review=
=20
> (I hope).

OK. As far as I can tell here this is just setting a member of the
mailbox interface, but not calling back into the mailbox code. If this
is okay, then all good.

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netif_stop_queue(ndev);
> > Do you need to stop and restart the queue? Your handling is atomic.
> I guess not.=C2=A0 This was just from following the examples of others. W=
ill=20
> remove.

Those examples (at least, in the MCTP drivers) will not have been able
to complete transmission until way later - say, after a separate
completion, or after a separate thread has processed the outgoing skb.
While that is happening, we may have stopped the queue.

In your case, you complete transmission entirely within the start_xmit
operation (*and* that path is atomic), so the queue is fine to remain
enabled.

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (adev && mctp_pcc_dev->acpi_device =3D=3D adev)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0con=
tinue;
> > I think you meant '!=3D' instead of '=3D=3D'?
> Yes.=C2=A0 Yes I did.=C2=A0 This is code that has to be there for complet=
eness,
> but I don't really have a way to test, except for the "delete all" case.

The 'unbind' example above will test this.

> > > +static int __init mctp_pcc_mod_init(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("Initializing MCT=
P over PCC transport driver\n");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_LIST_HEAD(&mctp_pcc_n=
devs);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D acpi_bus_register_d=
river(&mctp_pcc_driver);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering=
 driver\n"));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > > +}
> > > +
> > > +static __exit void mctp_pcc_mod_exit(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("Removing MCTP ov=
er PCC transport driver\n");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_pcc_driver_remove(NUL=
L);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_bus_unregister_driver=
(&mctp_pcc_driver);
> > > +}
> > > +
> > > +module_init(mctp_pcc_mod_init);
> > > +module_exit(mctp_pcc_mod_exit);
> > If you end up removing the mctp_pcc_ndevs list, these can all be
> > replaced with module_acpi_driver(mctp_pcc_driver);
>=20
> Yeah, I can't get away with that.=C2=A0 The ACPI devices may still be the=
re=20
> when some one calls rmmod, and so we need to clean up the ndevs.

The core driver unregister path should unbind all devices before the
module is removed, so your mctp_pcc_driver_remove() should get invoked
on each individual device during that process.

(with the above !=3D vs. =3D=3D bug fixed, you'll probably find that
"delete-all" case will always hit an empty list)

... this is unless something is different about the ACPI bus type, but
it all looks standard from a brief look!

Cheers,


Jeremy

