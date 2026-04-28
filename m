Return-Path: <netdev+bounces-281932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBiTAGzF8GktYgEAu9opvQ
	(envelope-from <netdev+bounces-281932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:34:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDC54870BD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C475E302D1A4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D843C063;
	Tue, 28 Apr 2026 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njqDm8qP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B84418DF
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386471; cv=none; b=WHgkP4kU5vMz3V24JRPX1ziRj5wuxEVMrB57y3b1RIQizRC2o2eBqFyHnv7FacCOCo1NGru1meQVIkwQ9Ksbe0rqtdiRfZcshgNU7c3upipqWpeDHHi+dsV9efV5XkRI1uSfaTwqzhJCyWvxk2JKlFUp7I66l9277ohZ/R12JRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386471; c=relaxed/simple;
	bh=qR6Y7sdK6qSuJkg49zUGOwPy3lhyzMqz+waaO0XxmjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaoeTp/ex6UE+wsjlbQNYJL6TvOKIF/Zrx3K81+aFm5QveUSQFOdr5Y39ZWR3a3Xa4fiP7n4DA8xL4m6YHnoiyJBH+cxt4uZld/KOz5DJrOG9ndCVFUIwvyDQGKjTofBdek+NxE8u/cWmL73pwOl6RVoWO7jpp4sumtqnascokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njqDm8qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952C8C2BCAF;
	Tue, 28 Apr 2026 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777386470;
	bh=qR6Y7sdK6qSuJkg49zUGOwPy3lhyzMqz+waaO0XxmjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njqDm8qPiV1Sh5NASc3Ec4k9OZRbZkbS2KnG8XY16zmgjZSrECOHanUuqoiSmZ8YH
	 5jro2WLsL4BJ3xcbZDlkuRJjfNdoTRtbqn35ZV14xgt0NY+E2ycji9zChkEfr1WWOM
	 Ittoh1oFA0YwlhbGlxhYG2YeBE19Bb6WsPwd4SpqCPBgpyVcdYxMkv5kaom6ewIE00
	 7TMHy7b6KiOp/5IIMWh+zIONW7kDD3el/ola0XlWW3XkapuYbe2jvlfxnCHDzqyqEU
	 RLdpPRUzdDuVv3dury1x5D0eSGL5OrHwsA/Aw8jQKzrDaUHrKJqWLn2sXLiFn3FNzf
	 FeDh36qmGtD9A==
Date: Tue, 28 Apr 2026 16:27:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Move entries to queue head in case of
 DMA mapping failure in airoha_dev_xmit()
Message-ID: <afDD5EJtYUx6sgRb@lore-desk>
References: <20260428-airoha-xmit-unmap-error-path-v1-1-aec44c6765c1@kernel.org>
 <679ebe0a-5889-4a84-afd6-3da50a07bced@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="usYxARcXN3Cq7GA5"
Content-Disposition: inline
In-Reply-To: <679ebe0a-5889-4a84-afd6-3da50a07bced@redhat.com>
X-Rspamd-Queue-Id: 7DDC54870BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


--usYxARcXN3Cq7GA5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 4/28/26 10:44 AM, Lorenzo Bianconi wrote:
> > In order to respect the original descriptor order and avoid any
> > potential IOMMU fault or memory corruption, move pending queue entries
> > to the head of hw queue tx_list if the DMA mapping of current inflight
> > packet fails in airoha_dev_xmit routine.
> >=20
> > Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-o=
f-order DMA tx descriptors")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 5effb4a4ae84..82018a085e46 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2123,14 +2123,14 @@ static netdev_tx_t airoha_dev_xmit(struct sk_bu=
ff *skb,
> >  	return NETDEV_TX_OK;
> > =20
> >  error_unmap:
> > -	while (!list_empty(&tx_list)) {
> > +	list_for_each_entry(e, &tx_list, list) {
> >  		e =3D list_first_entry(&tx_list, struct airoha_queue_entry,
> >  				     list);
>=20
> Coccinelle says:
>=20
> +/srv/nipa-builds-contest/testing/wt-cocci/drivers/net/ethernet/airoha/ai=
roha_eth.c:2123:1-20:
> iterator with update on line 2124
>=20
> I guess you should additionally drop the statement above.

ack, sorry. I will fix it in v2.

Regards,
Lorenzo

>=20
> /P
>=20

--usYxARcXN3Cq7GA5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCafDD5AAKCRA6cBh0uS2t
rEryAP93+3om9/MyBd5xMoBvLsJPmTDWfbzGmYwYQDzdPQw5VQEAorMCm2iUQpMc
97tysFlJONWC+zZF/0tdEL4Ufh+aJQ8=
=RFuK
-----END PGP SIGNATURE-----

--usYxARcXN3Cq7GA5--

