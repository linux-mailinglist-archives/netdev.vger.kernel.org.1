Return-Path: <netdev+bounces-254473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MODMHVuEemnx7AEAu9opvQ
	(envelope-from <netdev+bounces-254473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:49:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E802AA93A6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E180C3018588
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6826933B6F9;
	Wed, 28 Jan 2026 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aIGJEdcP"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFB2F5A22;
	Wed, 28 Jan 2026 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636953; cv=none; b=SYNM28DEo3p1Oy11R3HnuWd3TCMCVycmpGA/VWiSAvWI8fg/EN42f7qZhlqgd8QUzu2Yz8J5V+z5TBkszd0nXkgy2Vbe8rTp/Ms0N2Ub8WF27IFK7wwA+BGwXTIE757d8Z9YehmhBboM2AfWtRZeag5ORmjcHGQcp6IY5Hi+O2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636953; c=relaxed/simple;
	bh=WrvAyanbpwZ6MTEpVe5ifEBlgTpCvqg1qgTjOkpLaBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5UHVc9YQu4XlMEq7o2HRT5hJoJx5rIyc0UmTLvJY1wyO5qe+mwrwH740LKMVvgKORApBQc8H3KLRlYPPcf7+fh/1manWHQ544wxlVjiCm1dCLjIXYymgGW39YCWgXS4iQ/Vs3QX/0DYxNoUAo0AKzT4OGx4FCR9azlfgjXguKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aIGJEdcP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1bWc4D8zz9v9k;
	Wed, 28 Jan 2026 22:49:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769636940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruAirXc8ptlR96ve5/9BugE40WCJ6xsmkWJx5Uj7rfU=;
	b=aIGJEdcPUTNpCRPoxieT4ns0YAjlCS1SCWknUwnMSvmg9qMSU20pliO7EHJ/YKehTef8X4
	OfTEP83Ov9GJqRBfQnmvxyTZcUkhN3Isu8Z69m16GysXboDZgypVf6Kj9EW9o5rDTKZsMY
	NIcdir18IPW6rSkamg/khyUXsG3gehroa1KRAizet4EDWTmH8218TSM2mJHy+ejCWT3X0R
	RlbV1knLwiHUkLPAQpjKDcSOf9gjVgsxYEH1P6cGBrYcHW7AVeKncHeNW5OdTfn2+5JM62
	sRj7wXkwpjWQSCUAdP5w3MdePLt7m5N1DeC244DsjJqF2Be7TWLIy2uh2IH44A==
Date: Wed, 28 Jan 2026 22:48:52 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, horms@kernel.org,
 shawnguo@kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, wahrenst@gmx.net,
 pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
 richardcochran@gmail.com, edumazet@google.com, andrew+netdev@lunn.ch,
 robh@kernel.org, krzk+dt@kernel.org, andrew@lunn.ch
Subject: Re: [net-next,v20,3/7] net: mtip: Add buffers management functions
 to the L2 switch driver
Message-ID: <20260128224852.62b16788@wsk>
In-Reply-To: <20260128022554.4151421-1-kuba@kernel.org>
References: <20260126103400.1683125-4-lukasz.majewski@mailbox.org>
	<20260128022554.4151421-1-kuba@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: 0a70d41f27b7b89e913
X-MBO-RS-META: p4u7ozw7pi4bkkx54cikgzroe65njg1g
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254473-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,pengutronix.de,kernel.org,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:dkim]
X-Rspamd-Queue-Id: E802AA93A6
X-Rspamd-Action: no action

Hi Jakub,

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see
> https://netdev-ai.bots.linux.dev/ai-local.html ---
> net: mtip: Add buffers management functions to the L2 switch driver
>=20
> This patch adds buffer management functions for the MTIP L2 switch
> driver, implementing mtip_free_buffers(), mtip_create_page_pool(), and
> mtip_alloc_buffers() for RX page pool and TX bounce buffer handling.
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c index
> > 03c5163d6508..9c21a3d29c1c 100644 ---
> > a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c +++
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c @@ -888,11
> > +888,96 @@ static void mtip_get_drvinfo(struct net_device *dev,
> >
> >  static void mtip_free_buffers(struct net_device *dev)
> >  {
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	int i;
> > +
> > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > +		page_pool_put_full_page(fep->page_pool,
> > +					fep->page[i], false); =20
>=20
> Can fep->page[i] be NULL here?  When mtip_alloc_buffers() fails
> partway through the RX allocation loop, it calls mtip_free_buffers()
> via the error path.  At that point, only some fep->page[] entries
> have been allocated - the rest remain NULL from the kzalloc
> initialization.
>=20
> The call chain page_pool_put_full_page()->page_pool_put_netmem()->
> page_pool_unref_and_test()->page_pool_unref_netmem()->
> netmem_get_pp_ref_count_ref() will attempt to access
> &NULL->pp_ref_count when passed a NULL page, causing a NULL pointer
> dereference.
>=20
> Should there be a NULL check before calling page_pool_put_full_page()?
>=20

Yes, such check shall be added.

> > +		fep->page[i] =3D NULL;
> > +	}
> > +
> > +	page_pool_destroy(fep->page_pool);
> > +	fep->page_pool =3D NULL;
> > +
> > +	for (i =3D 0; i < TX_RING_SIZE; i++)
> > +		kfree(fep->tx_bounce[i]);
> >  } =20
>=20
> [ ... ]
>=20
> > +static int mtip_alloc_buffers(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct cbd_t *bdp;
> > +	struct page *page;
> > +	int i, ret;
> > +
> > +	ret =3D mtip_create_page_pool(fep, RX_RING_SIZE);
> > +	if (ret < 0) {
> > +		dev_err(&fep->pdev->dev, "Failed to create page
> > pool\n");
> > +		return ret;
> > +	}
> > +
> > +	bdp =3D fep->rx_bd_base;
> > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > +		page =3D page_pool_dev_alloc_pages(fep->page_pool);
> > +		if (!page) {
> > +			dev_err(&fep->pdev->dev,
> > +				"Failed to allocate page for rx
> > buffer\n");
> > +			goto err;
> > +		} =20
>=20
> [ ... ]
>=20
> > + err:
> > +	mtip_free_buffers(dev); =20
>=20
> When this error path is taken, fep->page[] may contain NULL entries
> for pages that were never allocated.
>=20
> > +	return -ENOMEM;
> >  } =20

I will add proper fix for v21.

--=20
Best regards,

=C5=81ukasz Majewski

