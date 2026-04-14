Return-Path: <netdev+bounces-278349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBQaIIcB3mkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:57:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034B3F7935
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1357830166CD
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934153B8930;
	Tue, 14 Apr 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOVJBdYS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4662FFF8D
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157059; cv=none; b=PvpgXlihLk3HGg6wKausY39eRr5zy8tWuAgUtFeXEMLadyT4bkaHgrWkM3s7qdwDQ2mMSoKYxan4wB90PHFZczrWUbQ8PK/xRbULMHuBFkw3iwN86gFOEroSm2wP52zqXCrXnP8UO3VjAOwYt7aE8KE5i1owAIqp43BbOBty1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157059; c=relaxed/simple;
	bh=lUWPEDw2DjZ1dgMC7s3MwDU2q8Tz/2D26MRcskvU9JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkg5jSSjADnz98PM08oeLEAjXJ1rMhc1CKqNq0QCsTafHvphqCKBrvop9m2L1b8/pB0+FMR7//9Vc4NAmTDxADEZXYG+VScQcrEQ8tbjflxrGQ1msEa797sSOSuSYzs4+3W6zJS3Anj3d0cgtw5vyl8AUVf89iCYSeUwW4OXbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOVJBdYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFF1C19425;
	Tue, 14 Apr 2026 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776157059;
	bh=lUWPEDw2DjZ1dgMC7s3MwDU2q8Tz/2D26MRcskvU9JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOVJBdYSJAB4kqVME5GuYkdjjQ8r+wmfye6NPtk12e8D+nABK/hxsEt4h51jSEcxa
	 4/+v4ur5cxjQdwXZW9J26Q2lfg77+dChh3lixbrU0nKj3EstT/v8xUFo7hUezBBcZ8
	 9pUuzL2Ov/xkbuwONlXp42lJcAgUG1XYPquH78mBWAR5ujg4/WK5y2VbkMFsC0L+Ms
	 nhFAMVJoChi8GbN7MfWehrngrSujPnz8e/5t8Qt4NLrki2wax/GijSEzDZhP2Kn99C
	 wS7DAT0lnYKVKAL5OB+oKAghDnW7q5NSCSp/5SF/2cBVEBWMc/uYfyUtKQfgjZOEMg
	 i1rZOhnl20SFQ==
Date: Tue, 14 Apr 2026 10:57:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next] net: airoha: Wait for TX to complete in
 airoha_dev_stop()
Message-ID: <ad4BgCGNYjYACUdv@lore-desk>
References: <20260411-airoha-fix-ndo_stop-v1-1-caddaa181739@kernel.org>
 <20260414082949.104611-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eigqXCj77aqg9JTa"
Content-Disposition: inline
In-Reply-To: <20260414082949.104611-1-pabeni@redhat.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278349-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 2034B3F7935
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--eigqXCj77aqg9JTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net: airoha: Wait for TX to complete in airoha_dev_stop()
>=20
> Wait for TX to complete in airoha_dev_stop routine before stopping the
> TX DMA and run airoha_qdma_cleanup_tx_queue routine. Moreover,
> start/stop TX/RX NAPIs in ndo_open()/ndo_stop() callbacks in order to be
> sure the TX NAPIs have completed before stopping the TX DMA engine in
> airoha_dev_stop routine.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 8e4b043af4bc..9e40c8f375c1 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -1684,18 +1686,26 @@ static int airoha_dev_stop(struct net_device *d=
ev)
> >  	struct airoha_qdma *qdma =3D port->qdma;
> >  	int i, err;
> >
> > -	netif_tx_disable(dev);
> >  	err =3D airoha_set_vip_for_gdm_port(port, false);
> >  	if (err)
> >  		return err;
> >
> > -	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx); i++)
> > -		netdev_tx_reset_subqueue(dev, i);
> > -
> >  	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> >  				    FE_PSE_PORT_DROP);
> >
> > +	netif_tx_disable(dev);
> >  	if (atomic_dec_and_test(&qdma->users)) {
> > +		u32 val;
> > +
> > +		/* Wait for TX to complete */
> > +		err =3D read_poll_timeout(airoha_qdma_rr, val,
> > +					!(val & GLOBAL_CFG_TX_DMA_BUSY_MASK),
> > +					USEC_PER_MSEC, 100 * USEC_PER_MSEC,
> > +					false, qdma, REG_QDMA_GLOBAL_CFG);
> > +		if (err)
> > +			return err;
> >                   ^^^^^^^^^^
>=20
> Can this leave the device in an inconsistent state? When read_poll_timeou=
t()
> fails (TX DMA busy for more than 100ms), airoha_dev_stop() returns an err=
or
> immediately. However, atomic_dec_and_test(&qdma->users) has already
> decremented qdma->users to 0, but airoha_qdma_stop_napi() was never calle=
d,
> so all NAPIs remain enabled.
>=20
> The networking core (__dev_close_many in net/core/dev.c) ignores the
> ndo_stop return value and marks the device as down regardless. When the
> device is later brought up again, airoha_dev_open() sees atomic_fetch_inc=
()
> return 0 (old value) and calls airoha_qdma_start_napi() -> napi_enable(),
> which hits BUG_ON(!test_bit(NAPI_STATE_SCHED, &val)) in napi_enable_locke=
d()
> because the NAPI was never disabled.
>=20
> The early return also skips the netdev_tx_reset_subqueue() calls at the e=
nd
> of the function.
>=20
> Should the code either continue with cleanup on timeout (don't return), or
> ensure NAPI and DMA state are properly cleaned up before returning?

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> > +
> > +		airoha_qdma_stop_napi(qdma);
> >  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> >  				  GLOBAL_CFG_TX_DMA_EN_MASK |
> >  				  GLOBAL_CFG_RX_DMA_EN_MASK);
>=20
> [ ... ]
>=20

--eigqXCj77aqg9JTa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCad4BgAAKCRA6cBh0uS2t
rNmgAP9RniNbQ5atnC99/hDeG+1/vN79rvITBQQqpU0PDLwR5AEA5/vQe6+SQyC8
86Sc7ARxKYPKvkm2qY8grGKYTvVMAgY=
=qwvR
-----END PGP SIGNATURE-----

--eigqXCj77aqg9JTa--

