Return-Path: <netdev+bounces-218595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375DB3D6B1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 04:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1527A2754
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A02119C546;
	Mon,  1 Sep 2025 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lZP1kH5H"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBA17BA3;
	Mon,  1 Sep 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693923; cv=none; b=Ay3/uuDqupiT4R1ANWyhJyfTdZgyi4n+xSNyU7cilP2bkfoPDQvoGAS6HUHgL4+/EUCoDRv9/a/updbwPkHslgMFFkVyRdoQqNISK/ppk1ZbGX+O2L7TcKxWEuWJMIIPhHZQhKQ3apVEqu6pnXbg6DexLPFRxg9NfBN6ctahs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693923; c=relaxed/simple;
	bh=ChZAicVlkcjKi0EO4v+H0wz/vYmiYh1zGAgB/wYlU+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3CVafsO6eOwcdCkKQ+CALbuuqJpA8ssWWHBTKHW4B0TdCxaQsJD24cCPdLGXfBFNizmIctBuZZsE5UUt8xjnZ+SwQ7mDNIzccr7SWfuet0RGH4arpZbfEB2mOrphdsZ6rQTRWH8P7cbDuTbYuY66T8aXPTN0szXDot5Bk6eFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lZP1kH5H; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756693919;
	bh=xtP+NZRv90BvqwkSiNCov8eSQ4xNLfe3WR5oE65gFUs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lZP1kH5HsSBMBHLKwtVaWZS75vLVhMpNMA3gxIgpepqoD6Rx17x6u92b5K5c0c5ex
	 SH7MR5aslwrB/ZRC9j8xPi3DIbTAFHqYSvgLQDFwtcJg7VfchkbHC427HUONOMWM3U
	 i0e7l/PPoS+nUEnn7pMh6v5x25z0cC0B0o+uzxaUXyA+GIL5y1fftLQisLGDY9sf8C
	 Z+C1fnmRMXep1xOwutT60BZVnfQInHBt+4BW9YTg791Eh13yN1AhhJJ4wn1NYRdB+I
	 S3xl887Ih60y3sjDS7AgaUsQQLi93PLLsTOYABdgbRWhy5F/bE1/pe6D6vr5sSWUMN
	 PfC7wYrCXjSaQ==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 67A2F64CF7;
	Mon,  1 Sep 2025 10:31:58 +0800 (AWST)
Message-ID: <c22e5f4dc6d496cec2c5645eac5f43aa448d0c48.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v27 1/1] mctp pcc: Implement MCTP over PCC
 Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Adam Young
 <admiyo@os.amperecomputing.com>, Matt Johnston <matt@codeconstruct.com.au>,
  Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Mon, 01 Sep 2025 10:31:57 +0800
In-Reply-To: <e28eeb4f-98a4-4db6-af96-c576019d3af1@amperemail.onmicrosoft.com>
References: <20250828043331.247636-1-admiyo@os.amperecomputing.com>
	 <20250828043331.247636-2-admiyo@os.amperecomputing.com>
	 <eb156195ce9a0f9c0f2c6bc46c7dcdaf6e83c96d.camel@codeconstruct.com.au>
	 <e28eeb4f-98a4-4db6-af96-c576019d3af1@amperemail.onmicrosoft.com>
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

> > Nice!
>=20
> Yeah.=C2=A0 Had a bit of an internal discussion about this one. Ideally, =
we=20
> would stop the queue one packet earlier, and not drop anything.=C2=A0 The=
=20
> mbox_send_message only returns the index of the next slot in the ring
> buffer and since it is circular, that does not give us a sense=C2=A0 of t=
he=20
> space left.

I think that's okay as-is. If you have access to the tail pointer of the
ring buffer too, you may be able to calculate space, but that's
1) optional, and 2) best left to a later change.

> > > +static int mctp_pcc_ndo_stop(struct net_device *ndev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_ndev *mctp=
_pcc_ndev =3D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_=
priv(ndev);
> > Minor: Unneeded wrapping here, and it seems to be suppressing the
> > warning about a blank line after declarations.
>=20
> The Reverse XMasstree format checker I am using seems overly strict.=C2=
=A0 I=20
> will try to unwrap all of these.=C2=A0 Is it better to do a separate vari=
able=20
> initialization?=C2=A0 Seems a bad coding practice for just a format decis=
ion=20
> that is purely aesthetic. But this one is simple to fix.

That shouldn't be tripping any RCT checks here, as it's just one
variable init?

	mctp_pcc_ndev *mctp_pcc_ndev =3D netdev_priv(ndev);

Keep it in one if possible (as you have done).

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drain_packets(&mctp_pcc_nd=
ev->outbox.packets);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drain_packets(&mctp_pcc_nd=
ev->inbox.packets);
> > Now that you're no longer doing the pcc_mbox_free_channel() in ndo_stop=
,
> > nothing has quiesced the pcc channels at this point, right? In which
> > case you now have a race between the channels' accesses to skb->data an=
d
> > freeing the skbs here.
>=20
> (I have written and rewritten this section multiple times, so apoliges=
=20
> if soemthing is unclear or awkward...it might reflect and earlier=20
> thought...)
>=20
> OK, I think I do need to call pcc_mbox_free_channel here,

You should ensure that the packet processing has stopped on
ndo_stop (and has not started before ndo_open). Without doing that, you
have two issues:

 - the RX packets will continue while the interface is down; and
 - you cannot free the lists

If there's a way to keep the channel allocated, but suspend the
processing of messages, that would seem like a good option (and sounds
like it would solve the MTU complexity).

However, on a cursory look through the pcc/mailbox infrastructure, it
seems like the pcc_mbox_request_channel starts processing immediately -
so it looks like you can not have the channel in an allocated-but-idle
state, since the request_channel does the bind_client, which does a
pcc_startup.

So, I figure you have two options:

 - only request the channel until the interface is up; or

 - implement your own quiescing in the callbacks - keeping the channels
   allocated, but check if the netdev is operational (ie, ndo_open has
   been called) before processing an RX message

> which means I need to allocate them in the pairing function. The ring
> buffer will still have pointers to the sk_buffs, but they will never
> be looked at again: the ring buffer will ger reinitialized if another
> client binds to it.

OK, but the skbs will remain allocated between those operations, which
has other side-effects (eg, socket mem accounting). You'll want to drain
the queue (as you are doing) if the queue is no longer making progress.

> The removal was to deal with the setting of the MTU, which requires a
> channel to read the size of the shared buffer.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_pcc_mtu =3D mctp_pcc=
_ndev->outbox.chan->shmem_size -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sizeof(struct pcc_header);
>=20
> I could create a channel, read=C2=A0 the value, and release it.=C2=A0 The=
 Value I=20
> need is in the ACPI PCC-table but I don't have direct access to it.=20
> Perhaps it would be better to initialize the value to -1 and use that to=
=20
> optionally reset it to the max value on ndo open.

If you cannot create the channel until ndo_open, I'd you will also need
to check the current mtu value on open, and failing if it exceeds the
limit of the channel.

If you have some way to extract this from the ACPI tables, that may be
preferable. With the -1 approach, you'll also need to ensure that the
*current* MTU is not larger than the channel max, on ndo_open. For
example:

  $ mctp link set mctppcc0 mtu 1000
     # sets current mtu, no max currently specified
  $ mctp link set mctppcc0 up
     # driver discovers max is (say) 500, now we have an invalid mtu

So, if you're able to parse the max from ACPI on initial bind, then you
can detect the error at the time of occurrence (the `link set mtu`)
rather than later (the `link set up`, and then ndo_open failing).

> Check=C2=A0 me here: The channel has a value ring msg_count that keeps tr=
ack=20
> of the number of entires in the ring buffer.=C2=A0 This needs to be set t=
o0=20
> in order for it to think the buffer is empty.=C2=A0 It is initialized in=
=C2=A0=20
> __mbox_bind_client, called from mbox_bind_client which is in turn called=
=20
> from mbox_request_channel
>=20
> The networking infra calls stop_ndo, so it must stop sending packets to=
=20
> it first.=C2=A0 I can netif_stop_queue(ndev) of course, but that seems=
=20
> counterintuitive? Assume i don't need to do that, but can't find the=20
> calling code.

You won't have any further ->ndo_start_xmit calls at the point that
->ndo_stop is called.

> > Is there a mbox facility to (synchronously) stop processing the inbound
> > channel, and completing the outbound channel?
>=20
> There is mbox_free_channel which calls shutdown, and that removed the
> IRQ handler, so no more=C2=A0 messages will be processed.=C2=A0 That shou=
ld be=20
> sufficient.

OK, as above, this will depend on the approach you on allocating and
releasing the channels.

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->mtu =3D MCTP_MIN_MTU=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->max_mtu =3D mctp_pcc=
_mtu;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev->min_mtu =3D MCTP_MIN=
_MTU;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D mctp_register_netde=
v(ndev, NULL, MCTP_PHYS_BINDING_PCC);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto free_netdev;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return devm_add_action_or_=
reset(dev, mctp_cleanup_netdev, ndev);
> > As has been mentioned elsewhere, using the devm cleanup mechanism is a
> > bit unconventional here. You have the device remove callback available,
> > which lets you do the same, and that way you can demonstrate symmetry
> > between the add and remove implementations.
>=20
> This has gone through a few=C2=A0 iterations and I thought I had it clear=
.
>=20
> I was trying=C2=A0 to make use of automated cleanup as much as possible.

OK, your call there. Using ->remove allows you to be explicit about the
matching ordering, which would be my approach, but that's certainly not
the only correct one.

Cheers,


Jeremy

