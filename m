Return-Path: <netdev+bounces-134095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F92997F1A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BB91F21FFF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83F1CBEAB;
	Thu, 10 Oct 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hw6Bw/Vp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uehgxAKY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7C1C1ACB;
	Thu, 10 Oct 2024 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544105; cv=none; b=YuvfKpPyowow+4gTHv6oLyDgYHO/ZT1IV6DtdLULVM5W6FYuIdPoVAP63B4xyumVscGvs8iPkTleBYrZGlyeGyBAi9AwE1WOgw4aGaz7/bQRIw5c8N7XfXGeJtvRb0OeJVyvbqGXoeSccpxYlzh6aiUTFXwt1nod7MD6OmCgka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544105; c=relaxed/simple;
	bh=nO5tveuS8n4BbqPpvO7KvqpGxY6o+MMol7+g0GDzdTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XuZisrsAelO5jQFpqgM1gsTplDC7mk8A9608SNojB+OHq+pdkTMIkfWVMgA/5kvsYI8TTFM6HF867j3GK4/nU51pc3k7DfDZu0hp1iksads4vAAxVviGJN1JZlreEXc137xuyR2Dy/B+SjIGSdxdj2p0ET8xNU65gJH3WHt9RQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hw6Bw/Vp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uehgxAKY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728544102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IU6+r5lZGAYZvMk+oAC6fxTdFz8i+0mzjN8aBnNbt3M=;
	b=hw6Bw/VpVdaTyP4PBmtuQiqyNyiYHkDnABR2i0CsyzvWfQR8lbjUGyUVYA22YxziLtLurh
	bzmp0RUF6lK9knrSbw7CDiCKGBOFj4OqN7MsJZkwO5gUJJvGM3RYd57HHx6NENWeAOz+ED
	ZCHFxwoSaXMZZAsngUenbF0YOMYwWZ6XFzV5RK35CtJ7xZ2z6NHqLIehT1EciyTRYDubFR
	gGLfyP2CEfDA87r+H2OqYiLTI970bcxQWGfVIO2C1tSn8w9LrbTLBcZkXGuX/zGJPa/i48
	BYgr9IRALy0zHcQ4mv18vqSgBoWVL931KUIKujYr5FaOgWFLxWe3Qw82j9hP1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728544102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IU6+r5lZGAYZvMk+oAC6fxTdFz8i+0mzjN8aBnNbt3M=;
	b=uehgxAKYZ234wpzUPC6gpFpkpmQEj/nuRSAJ/ahxtW5AhCw9W75oc9MAWoBWZ33KzS8VFS
	auwPAKaLdTfNzKBA==
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "moderated list:INTEL
 ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 2/2] igc: Link queues to NAPI instances
In-Reply-To: <Zwa3sW-4s7oqktX3@LQ3V64L9R2>
References: <20241003233850.199495-1-jdamato@fastly.com>
 <20241003233850.199495-3-jdamato@fastly.com>
 <87msjg46lw.fsf@kurt.kurt.home> <Zwa3sW-4s7oqktX3@LQ3V64L9R2>
Date: Thu, 10 Oct 2024 09:08:20 +0200
Message-ID: <87wmig3063.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed Oct 09 2024, Joe Damato wrote:
> On Mon, Oct 07, 2024 at 11:14:51AM +0200, Kurt Kanzenbach wrote:
>> Hi Joe,
>>=20
>> On Thu Oct 03 2024, Joe Damato wrote:
>> > Link queues to NAPI instances via netdev-genl API so that users can
>> > query this information with netlink:
>> >
>> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yam=
l \
>> >                          --dump queue-get --json=3D'{"ifindex": 2}'
>> >
>> > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>> >  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>> >  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>> >  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>> >  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>> >  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
>> >
>> > Since igc uses only combined queues, you'll note that the same NAPI ID
>> > is present for both rx and tx queues at the same index, for example
>> > index 0:
>> >
>> > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>> > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>> >
>> > Signed-off-by: Joe Damato <jdamato@fastly.com>
>> > ---
>> >  drivers/net/ethernet/intel/igc/igc_main.c | 30 ++++++++++++++++++++---
>> >  1 file changed, 26 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/e=
thernet/intel/igc/igc_main.c
>> > index 7964bbedb16c..b3bd5bf29fa7 100644
>> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> > @@ -4955,6 +4955,7 @@ static int igc_sw_init(struct igc_adapter *adapt=
er)
>> >  void igc_up(struct igc_adapter *adapter)
>> >  {
>> >  	struct igc_hw *hw =3D &adapter->hw;
>> > +	struct napi_struct *napi;
>> >  	int i =3D 0;
>> >=20=20
>> >  	/* hardware has been reset, we need to reload some things */
>> > @@ -4962,8 +4963,17 @@ void igc_up(struct igc_adapter *adapter)
>> >=20=20
>> >  	clear_bit(__IGC_DOWN, &adapter->state);
>> >=20=20
>> > -	for (i =3D 0; i < adapter->num_q_vectors; i++)
>> > -		napi_enable(&adapter->q_vector[i]->napi);
>> > +	for (i =3D 0; i < adapter->num_q_vectors; i++) {
>> > +		napi =3D &adapter->q_vector[i]->napi;
>> > +		napi_enable(napi);
>> > +		/* igc only supports combined queues, so link each NAPI to both
>> > +		 * TX and RX
>> > +		 */
>>=20
>> igc has IGC_FLAG_QUEUE_PAIRS. For example there may be 2 queues
>> configured, but 4 vectors active (and 4 IRQs). Is your patch working
>> with that?  Can be tested easily with `ethtool -L <inf> combined 2` or
>> by booting with only 2 CPUs.
>
> I tested what you asked, here's what it looks like on my system:

Thanks.

>
> 16 core Intel(R) Core(TM) i7-1360P
>
> lspci:
> Ethernet controller: Intel Corporation Device 125c (rev 04)
>                      Subsystem: Intel Corporation Device 3037
>
> ethtool -i:
> firmware-version: 2017:888d
>
> $ sudo ethtool -L enp86s0 combined 2
> $ sudo ethtool -l enp86s0
> Channel parameters for enp86s0:
> Pre-set maximums:
> RX:		n/a
> TX:		n/a
> Other:		1
> Combined:	4
> Current hardware settings:
> RX:		n/a
> TX:		n/a
> Other:		1
> Combined:	2
>
> $ cat /proc/interrupts | grep enp86s0 | cut --delimiter=3D":" -f1
>  144
>  145
>  146
>  147
>  148
>
> Note that IRQ 144 is the "other" IRQ, so if we ignore that one...
> /proc/interrupts shows 4 IRQs, despite there being only 2 queues.
>
> Querying netlink to see which IRQs map to which NAPIs:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json=3D'{"ifindex": 2}'
> [{'id': 8200, 'ifindex': 2, 'irq': 148},
>  {'id': 8199, 'ifindex': 2, 'irq': 147},
>  {'id': 8198, 'ifindex': 2, 'irq': 146},
>  {'id': 8197, 'ifindex': 2, 'irq': 145}]
>
> This suggests that all 4 IRQs are assigned to a NAPI (this mapping
> happens due to netif_napi_set_irq in patch 1).
>
> Now query the queues and which NAPIs they are associated with (which
> is what patch 2 adds):
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \=
=20
>                          --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8197, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8198, 'type': 'tx'}]
>
> As you can see above, since the queues are combined and there are
> only 2 of them, NAPI IDs 8197 and 8198 (which are triggered via IRQ
> 145 and 146) are displayed.

Is that really correct? There are four NAPI IDs which are triggered by
the four IRQs. Let's say we have:

 - IRQ: 145 -> NAPI 8197 -> Tx for queue 0
 - IRQ: 146 -> NAPI 8198 -> Rx for queue 0
 - IRQ: 147 -> NAPI 8199 -> Tx for queue 1
 - IRQ: 148 -> NAPI 8200 -> Rx for queue 1

My understanding is that this scheme is used when <=3D 2 queues are
configured. See IGC_FLAG_QUEUE_PAIRS.

My expectation would be some output like:

[{'id': 0, 'ifindex': 2, 'napi-id': 8197, 'type': 'tx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8199, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'}]

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcHfWQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgm5kD/wKWSB0Ipa7QUEmYLceiDsnwHr9ptAG
veIqB7500LItsANplLxHfgqb85Bs6ioag6EQVbnOCyeIncbO/2sPWGTYuen71uNk
em7EhPF+c73A1NkLZzYMSw2FVnoPrPD3+9wIWzRBgYneix9b3nFwVAwgO1NiDnQg
Vw+2WmAnJkM2KHziYF4lcuJlDFlwqUS674wJGVG3eQTzF/pAWzgML0BoldNMUQlP
gQFdXhYK4HQJTaF09aIv7hwZOyI659+vUDmS7zvJd1qk1R9L+FaYiv3hOjuIu7YQ
dEzWs9PhGH3vk50POY30Y248oiAO8wQZMloB0Y5CufKtgIB1fhx+NQFDAmdfI5If
y+Vavk+N2/b6DvCQlyQ149SoJAwIRZ3Noa2J/q0vMSceCnncDJCITXYtTbhjmruv
gq2guTYIZIFbpx4NKorJoWZ9fl0PGJL8uDgqRHO6cotcG40jS90p85Lm5iy1dVp/
0Z55krETtccNRy/pp2FNT+ljwgUye5Mo9hOtXvKyNsVip50pxM+ng16U8h0uAIOd
OyXeYASR6Xc9o9Ac5LX39AjoDnONwXj0+lnYyFjnMk6apyV5gNbXN2lCQDv9XZWt
9P6VVuiCQB97u9oKOs7iO5cQ64frJI0nuLmafxg5eKcVi4Cb7gjhRYNJRdzFEvDM
pgxnGG2nKU/qmg==
=yeTM
-----END PGP SIGNATURE-----
--=-=-=--

