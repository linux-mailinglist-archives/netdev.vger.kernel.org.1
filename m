Return-Path: <netdev+bounces-228594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7535BCF5B5
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4431334B281
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A9259C9C;
	Sat, 11 Oct 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbFI4omk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7D61FFE
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760189684; cv=none; b=kpNYlmMkBk/hKdpGddBFzuuQXCwV8w+bkRWIHETkukZQRy17KjrdeHis9dOQyTGSruLr0O9G4sOrr4EYOyPEkEtuL94bUmfyF2fjimv8rrG4NoD5rTkaF7b3yecGqF+eaOxWRc6OMyyZG4jfaxF7RJINIEeCNFwyk/m7A/8HXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760189684; c=relaxed/simple;
	bh=0eibqLwpXBrjUm2YGT1GLTK10uNsplZcqPI1+nozNhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0Vz9CedIKmj2il7rTkshlaRXnMQ/OC45PULmtLufYHOXX/gikZwqi0ss2UCRM+cHJ9I7rx9i47r+7PAZIsyUsrH+sH8HBfUC8VCv9spKL2n6LTzRTULj8emebZQ89mov29KO8r0kHrN3xdft9kxN7MYfVmdvN3O+6l+UbvSWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbFI4omk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8027CC4CEFE;
	Sat, 11 Oct 2025 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760189683;
	bh=0eibqLwpXBrjUm2YGT1GLTK10uNsplZcqPI1+nozNhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbFI4omkz7RznMb6Vks53VvoAzqdHh5iq1prnThbZ1BNuh1cjrjkdwavfL6LpYQtE
	 2cZN+p24KPX9z2yZ6adKbUC+219MBH4Wrxl+sBwvba2eQZ9+pqP3g//sVZT46Ya2yZ
	 /SW3bxuEHaYhUvX8LoaVPkOg9+iAPaAxlmHA4cklQNlxM3QEnwzKRGzn8+p05oHOD/
	 v7e0/4vLLjTYW51kYuVJ7HswxVoSsfnKkXwv++a1PHrYwOyvztNnb0i6e/kcu99JlF
	 PvouCr3xiej7hfzkItlV5kluNwgICNAGg6IhFgI4GwVYK8+3JlzBHdHE8xhSqXn4OS
	 NhjGgiOGkFCkw==
Date: Sat, 11 Oct 2025 15:34:41 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Take into account out-of-order tx
 completions in airoha_dev_xmit()
Message-ID: <aOpc8d0dPGOnwfJE@lore-desk>
References: <20251010-airoha-tx-busy-queue-v1-1-9e1af5d06104@kernel.org>
 <aOo0woPiMxjABFv2@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nk5Dyb1DUQd53K2s"
Content-Disposition: inline
In-Reply-To: <aOo0woPiMxjABFv2@horms.kernel.org>


--nk5Dyb1DUQd53K2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Oct 10, 2025 at 07:21:43PM +0200, Lorenzo Bianconi wrote:
> > Completion napi can free out-of-order tx descriptors if hw QoS is
> > enabled and packets with different priority are queued to same DMA ring.
> > Take into account possible out-of-order reports checking if the tx queue
> > is full using circular buffer head/tail pointer instead of the number of
> > queued packets.
> >=20
> > Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN75=
81 SoC")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 833dd911980b3f698bd7e5f9fd9e2ce131dd5222..5e2ff52dba03a7323141fe9=
860fba52806279bd0 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1873,6 +1873,19 @@ static u32 airoha_get_dsa_tag(struct sk_buff *sk=
b, struct net_device *dev)
> >  #endif
> >  }
> > =20
> > +static bool airoha_dev_is_tx_busy(struct airoha_queue *q, u32 nr_frags)
> > +{
> > +	u16 index =3D (q->head + nr_frags) % q->ndesc;
> > +
> > +	/* completion napi can free out-of-order tx descriptors if hw QoS is
> > +	 * enabled and packets with different priorities are queued to the sa=
me
> > +	 * DMA ring. Take into account possible out-of-order reports checking
> > +	 * if the tx queue is full using circular buffer head/tail pointers
> > +	 * instead of the number of queued packets.
> > +	 */
> > +	return index >=3D q->tail && (q->head < q->tail || q->head > index);
>=20
> Hi Lorenzo,

Hi Simon,

thx for the review.

>=20
> I think there is a corner case here.
> Perhaps they can't occur, but here goes.
>=20
> Let us suppose that head is 1.
> And the ring is completely full, so tail is 2.
>=20
> Now, suppose nr_frags is ndesc - 1.
> In this case the function above will return false. But the ring is full.
>=20
> Ok, ndesc is actually 1024 and nfrags should never be close to that.
> But the problem is general. And a perhaps more realistic example is:
>=20
>   ndesc is 1024
>   head is 1008
>   The ring is full so tail is 1009
>   (Or head is any other value that leaves less than 16 slots free)
>   nr_frags is 16
>=20
> airoha_dev_is_tx_busy() returns false, even though the ring is full.

yes, you are right, this corner case is not properly managed by the proposed
algorithm, thx for pointing this out.

>=20
> Probably this has it's own problems. But if my reasoning above is correct
> (is it?) then the following seems to address it by flattening and extendi=
ng
> the ring. Because what we are about is the relative value of head, index
> and tail. Not the slots they occupy in the ring.
>=20
> N.B: I tetsed the algorirthm with a quick implementation in user-space.
> The following is, however, completely untested.
>=20
> static bool airoha_dev_is_tx_busy(struct airoha_queue *q, u32 nr_frags)
> {
> 	unsigned int tail =3D q->tail < q->head ? q->tail + q->ndesc : q->tail;
> 	unsigned int index =3D q->head + nr_frags;
>=20
> 	return index >=3D tail;
> }

I agree, the algorithm you proposed properly manages the 99% of the cases. =
The
only case where it fails is when the queue is empty (so tail =3D head =3D x,
e.g. x =3D 0). In this case we would have:

	- q->ndesc =3D 1024
	- q->tail =3D q->head =3D 0
	- tail =3D 0
	- index =3D n (e.g. n =3D 1)
	- index >=3D tail =3D=3D> 1 >=3D 0 =3D=3D> busy (but the queue is actually=
 empty).

I guess we should add a minor change in the tail definition:

	u32 tail =3D q->tail <=3D q->head ? q->tail + q->ndesc : q->tail;

so:
	- q->ndesc =3D 1024
	- q->tail =3D q->head =3D 0
	- tail =3D 1024
	- index =3D n (e.g. n =3D 1)
	- index >=3D tail =3D> 1 < 1024 =3D> OK

Can you spot any downside with this approach?
I tested the proposed approach and it seems to be working fine.

Regards,
Lorenzo

>=20
> ...

--nk5Dyb1DUQd53K2s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaOpc8QAKCRA6cBh0uS2t
rIRpAQDSIsIVZ9Ty0Rkg1NUgdKBIwZ81yEMCdi/+UaKq4bLPLgEAj8DhwXBDnnv0
f4sdK7RnQFXPyXMgAKP1Sck+WfHt7QU=
=csea
-----END PGP SIGNATURE-----

--nk5Dyb1DUQd53K2s--

