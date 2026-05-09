Return-Path: <netdev+bounces-286123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAivJbT3/ml30gAAu9opvQ
	(envelope-from <netdev+bounces-286123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:00:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62A04FEDC5
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30B23301410F
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77337D13D;
	Sat,  9 May 2026 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP5r8Bhp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC83345CD8;
	Sat,  9 May 2026 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317233; cv=none; b=bd+WhkovCpMCpXUWeyY8Y3KQwrUtXFNFI8re5jkcJanSZzGht4pTxHCeWdXmt7VcqZoTKC2DmfSuFAZZHa8X87li0fwSwBxlWUM6rO0mQjnqoojm4EJmJG2+e5uKKrz0fIvUi5s2Sf2lIIp4slD0MXvM/7SnuAat6Tm/v9Y8Mvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317233; c=relaxed/simple;
	bh=ZqLpz2CFj28iASBq5rq8tyYLR7o5ybdmwFhd94Td2m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4kaDlgMURLKIlXQr9KbElxH19stHfh4Tk9X69m7vlaXH68iYUg7QXBjNLROsgy5dA6kmuFwMBBvfEdt1t7gC4+zJgY2ZDVMXJqJ1wZdMbzeK0iuzLnbJAK7wkzFmfCsGmPVgMBQ8dia1YWjS0fiJ7gz42a7ZtLIAO6t1AfhCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP5r8Bhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87068C2BCB2;
	Sat,  9 May 2026 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778317233;
	bh=ZqLpz2CFj28iASBq5rq8tyYLR7o5ybdmwFhd94Td2m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pP5r8Bhpm0NTMhVIzUfWOtGIwxDRr+p9wyNO5ZIeT0iScG9QjezvbYUzRJIH6hos/
	 LV1CTwl0sCAFeVQudLmrYvT+gMk1zNxdf+dq12q0Kdw26VkxWuaru4xA0u65jLr4ps
	 2rtxmqu1gQZpgHQ/zkgGJvGZOJ8O/zpJz1L3UeLs1H0wIPeKLe3V5v0kAigf+/D3V6
	 S72mUlJbtwzA9rnCzqnkmcRT9AtoxXiwEjFX1M8Igj1wiPHkijfBahVrAfAL6pH3AQ
	 nSZHmF1177Rk6g5rX9IFvJG3I2qbw7K6KUDSbV3fAABWfQWFhMoJ1uU0pCy2VBj2G2
	 XJsSFDSNoBGYA==
Date: Sat, 9 May 2026 11:00:30 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 08/10] net: airoha: Do not stop GDM port if
 it is shared
Message-ID: <af73rqYK1xCL-XsK@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-8-af613b61ae02@kernel.org>
 <20260509014613.3558087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lk/TFdVeNBlgNVPK"
Content-Disposition: inline
In-Reply-To: <20260509014613.3558087-1-kuba@kernel.org>
X-Rspamd-Queue-Id: E62A04FEDC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286123-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--Lk/TFdVeNBlgNVPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: airoha: Do not stop GDM port if it is shared
>=20
> This patch adds a per-port users refcount so the GDM forward configuration
> is only reset to FE_PSE_PORT_DROP when the last netdev attached to the
> shared GDM port stops, and it adjusts the MTU/length register updates to
> cope with the shared case.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 0253919714e0..1c4927c1aeb0 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1714,8 +1714,8 @@ static int airoha_dev_open(struct net_device *net=
dev)
> >  	int err, len =3D ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> >  	struct airoha_gdm_port *port =3D dev->port;
> > +	u32 cur_len, pse_port =3D FE_PSE_PORT_PPE1;
> >  	struct airoha_qdma *qdma =3D dev->qdma;
> > -	u32 pse_port =3D FE_PSE_PORT_PPE1;
> > =20
> >  	netif_tx_start_all_queues(netdev);
> >  	err =3D airoha_set_vip_for_gdm_port(dev, true);
> > @@ -1729,10 +1729,14 @@ static int airoha_dev_open(struct net_device *n=
etdev)
> >  		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
> >  				GDM_STAG_EN_MASK);
> > =20
> > -	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> > -		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> > -		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> > -		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> > +	cur_len =3D airoha_fe_get(qdma->eth, REG_GDM_LEN_CFG(port->id),
> > +				GDM_LONG_LEN_MASK);
> > +	if (!atomic_read(&port->users) || len > cur_len)
> > +		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> > +			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> > +			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> > +			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> > +	atomic_inc(&port->users);
>=20
> [Medium]
> When a second netdev opens with a larger MTU, this unconditionally
> widens GDM_LONG_LEN_MASK for the already-running sibling that has a
> smaller MTU:
>=20
> 	if (!atomic_read(&port->users) || len > cur_len)
> 		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> 			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> 			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> 			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
>=20
> Meanwhile airoha_dev_change_mtu() rejects shrinks (len < cur_len) with
> -EBUSY when the port is shared. Is this asymmetry intentional?

This is done intentionally since we do not want to break traffic of already
running net_device if we want to increase the MTU on a sibling net_device.

>=20
> With the new policy the hardware long-length ends up as the maximum of
> the two MTUs, so the smaller-MTU sibling silently accepts frames larger
> than its advertised MTU at the MAC level. Should opens that would
> increase the shared length also be gated (symmetric policy), or should
> the commit message and a comment document the chosen ceiling/floor
> behaviour?

I will add a comment in the code in v5.

>=20
> > =20
> >  	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
> >  			GLOBAL_CFG_TX_DMA_EN_MASK |
> > @@ -1762,8 +1766,12 @@ static int airoha_dev_stop(struct net_device *ne=
tdev)
> >  	for (i =3D 0; i < netdev->num_tx_queues; i++)
> >  		netdev_tx_reset_subqueue(netdev, i);
> > =20
> > -	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> > -				    FE_PSE_PORT_DROP);
> > +	if (atomic_dec_and_test(&port->users)) {
> > +		airoha_set_vip_for_gdm_port(dev, false);
> > +		airoha_set_gdm_port_fwd_cfg(qdma->eth,
> > +					    REG_GDM_FWD_CFG(port->id),
> > +					    FE_PSE_PORT_DROP);
> > +	}
>=20
> [Low]
> Is the airoha_set_vip_for_gdm_port(dev, false) call inside the
> atomic_dec_and_test() block intentional?
>=20
> Looking at airoha_dev_stop() as a whole, the same call is already made
> unconditionally a few lines above:
>=20
> 	netif_tx_disable(netdev);
> 	airoha_set_vip_for_gdm_port(dev, false);
> 	for (i =3D 0; i < netdev->num_tx_queues; i++)
> 		netdev_tx_reset_subqueue(netdev, i);
>=20
> 	if (atomic_dec_and_test(&port->users)) {
> 		airoha_set_vip_for_gdm_port(dev, false);
> 		...
> 	}
>=20
> Since get_vip_port() derives the bit mask per-(port, dev->nbq) and
> airoha_fe_clear() of already-cleared bits is a no-op, the second call
> looks like dead code today. The commit log only mentions the
> FE_PSE_PORT_DROP gating, not VIP handling. Should the duplicate be
> dropped in v2?

ack, I will fix in v5.

>=20
> > =20
> >  	if (atomic_dec_and_test(&qdma->users)) {
> >  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> > @@ -1915,10 +1923,22 @@ static void airoha_dev_get_stats64(struct net_d=
evice *netdev,
> >  static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
> >  {
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > +	u32 cur_len, len =3D ETH_HLEN + mtu + ETH_FCS_LEN;
> >  	struct airoha_gdm_port *port =3D dev->port;
> > -	u32 len =3D ETH_HLEN + mtu + ETH_FCS_LEN;
> >  	struct airoha_eth *eth =3D dev->eth;
> > =20
> > +	cur_len =3D airoha_fe_get(eth, REG_GDM_LEN_CFG(port->id),
> > +				GDM_LONG_LEN_MASK);
> > +	if (len < cur_len) {
> > +		u8 port_refcnt =3D atomic_read(&port->users);
> > +
> > +		/* We can decrease the device MTU just if the GDM port is
> > +		 * not shared or if the other device is not running.
> > +		 */
> > +		if (port_refcnt > 1 || (port_refcnt && !netif_running(netdev)))
> > +			return -EBUSY;
> > +	}
> > +
>=20
> [Low]
> Why is port_refcnt typed as u8 here when atomic_read() returns int?
>=20
> 	u8 port_refcnt =3D atomic_read(&port->users);
>=20
> With AIROHA_MAX_NUM_GDM_DEVS currently 2 this cannot overflow, but a
> future bump of AIROHA_MAX_NUM_GDM_DEVS, or a refcount leak, that pushed
> port->users to 256 would wrap to 0 and quietly bypass both the
> port_refcnt > 1 and port_refcnt && !netif_running(netdev) checks,
> permitting MTU shrinks that are meant to be rejected. Would using int
> here (the type atomic_read() returns) be preferable?

ack, I will fix in v5.

Regards,
Lorenzo

>=20
> >  	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
> >  		      GDM_LONG_LEN_MASK,
> >  		      FIELD_PREP(GDM_LONG_LEN_MASK, len));

--Lk/TFdVeNBlgNVPK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf73rgAKCRA6cBh0uS2t
rGHbAQCU4qZQKNGV5iqcff0D6MaDhyAsSLJmi/W5EouwYcqncAEAmNiuT5ZIzpcH
4Mt+NqzHqJyEkeLUhvnoyxX86GhLUg8=
=akYS
-----END PGP SIGNATURE-----

--Lk/TFdVeNBlgNVPK--

