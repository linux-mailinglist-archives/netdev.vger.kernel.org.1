Return-Path: <netdev+bounces-286116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1scfF5nv/mkMzwAAu9opvQ
	(envelope-from <netdev+bounces-286116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:26:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CBE4FEA98
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CED53011C44
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7738A72A;
	Sat,  9 May 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCVVtO4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D2384231;
	Sat,  9 May 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315157; cv=none; b=vEqQrkLmkIBHjNF7l4UaMw5ztF1+dkuOy9/4fJooY86EsmgdZYdlUNwpeCwQacgFWXHQalKjuaJjSt1ZAjXKHZ4/oBb8ifp+B6g4bGPTcY8xbsmke3XTtPAFu1AM1RywkZnYHnXg3SKVoCmO9aAYUZum87dM0DxwSYT6sOlDPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315157; c=relaxed/simple;
	bh=nczlNiIr/A9xdNyg6rE5uVSARRuTIZ7Uz1A5NFRANqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkCAf+4SYt6zLT0/uhfz1XkUzdDglsooBHAScfjXM82zapxp8NSb47E3S8AHVrCskoDpMUbl9AtWC/NNHcUo9xpArcsSkhh63oTl8loCVQ1Az2aAU4tht++VALMtCMSOH19Vijev4oCIMKISP+kazVgspuW+CLP48LkwIjVZL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCVVtO4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077A5C2BCB4;
	Sat,  9 May 2026 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778315157;
	bh=nczlNiIr/A9xdNyg6rE5uVSARRuTIZ7Uz1A5NFRANqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCVVtO4GspLXm5oU2Y+5HmrgHaQiFURcpPBaQjKOGDVaLDRBN27A8bkvOo394mwtJ
	 a6liRN/2eMOSZd7Df3DCnUreka/54xDgLu7tAQgtk9B3j//rIFq6oyH9gspoGn2BdC
	 MWSo54itWTgPWgCNMmXHNez2IsZKTgvMY2K7hvh83lhaXIPQYBu91IFSyluwh+luiD
	 +ZPIxUoKXYry1c6j30Ut5bhLHkeOmIxbPdhf7cuJXv11GTHNAN6rza+tR2/rC5ABwB
	 v3TZ0LerSeoUsT4CB9hSHcMcH8CghGTX/VJ1QsgxDqrat8iP7iKHoHUf0G+xw9/n3p
	 kHIu7Om+b2lTg==
Date: Sat, 9 May 2026 10:25:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 07/10] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <af7vkpjEY5FhlEyc@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-7-af613b61ae02@kernel.org>
 <20260509014611.3558060-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YnCVD7Lr1XicTVN0"
Content-Disposition: inline
In-Reply-To: <20260509014611.3558060-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 85CBE4FEA98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286116-lists,netdev=lfdr.de];
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


--YnCVD7Lr1XicTVN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: airoha: Support multiple net_devices for a single FE GDM port
>=20
> This commit introduces support for multiple net_devices connected to the
> same Frame Engine (FE) GDM port (GDM3 or GDM4) via an external hardware
> arbiter on EN7581 or AN7583 SoCs, and adds a get_dev_from_sport callback
> to differentiate between the net_devices attached to each port.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 786bc677af3c..0253919714e0 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -3188,14 +3257,23 @@ static int airoha_probe(struct platform_device =
*pdev)
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> >  		struct airoha_gdm_port *port =3D eth->ports[i];
> > -		struct airoha_gdm_dev *dev;
> > +		int j;
> > =20
> >  		if (!port)
> >  			continue;
> > =20
> > -		dev =3D port->dev;
> > -		if (dev && dev->dev->reg_state =3D=3D NETREG_REGISTERED)
> > -			unregister_netdev(dev->dev);
> > +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> > +			struct airoha_gdm_dev *dev =3D port->devs[j];
> > +			struct net_device *netdev;
> > +
> > +			if (!dev)
> > +				continue;
> > +
> > +			netdev =3D dev->dev;
> > +			of_node_put(netdev->dev.of_node);
> > +			if (netdev->reg_state =3D=3D NETREG_REGISTERED)
> > +				unregister_netdev(netdev);
> > +		}
> >  		airoha_metadata_dst_free(port);
> >  	}
> >  	airoha_hw_cleanup(eth);
>=20
> [Medium]
> Is the ordering of of_node_put() and unregister_netdev() here correct?
>=20
> airoha_alloc_gdm_device() now does:
>=20
> 	netdev->dev.of_node =3D of_node_get(np);
>=20
> so the netdev holds its own reference to the of_node for its entire
> registered lifetime. In this error unwind the of_node_put() runs before
> unregister_netdev(), and netdev->dev.of_node is not cleared, so any
> subsequent access to netdev->dev.of_node during unregistration (netdev
> notifiers, sysfs, overlay-aware code) would be looking at a node whose
> reference count has already been dropped.
>=20
> Other drivers (e.g., drivers/net/ethernet/hisilicon/hns/hns_enet.c in
> hns_nic_dev_remove()) put the node only after unregister_netdev().
>=20
> Would swapping the order to call unregister_netdev() first, then
> of_node_put(), be more appropriate here?

ack, I will fix it in v5.

>=20
> > @@ -3216,14 +3294,22 @@ static void airoha_remove(struct platform_devic=
e *pdev)
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> >  		struct airoha_gdm_port *port =3D eth->ports[i];
> > -		struct airoha_gdm_dev *dev;
> > +		int j;
> > =20
> >  		if (!port)
> >  			continue;
> > =20
> > -		dev =3D port->dev;
> > -		if (dev)
> > -			unregister_netdev(dev->dev);
> > +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> > +			struct airoha_gdm_dev *dev =3D port->devs[j];
> > +			struct net_device *netdev;
> > +
> > +			if (!dev)
> > +				continue;
> > +
> > +			netdev =3D dev->dev;
> > +			of_node_put(netdev->dev.of_node);
> > +			unregister_netdev(netdev);
> > +		}
> >  		airoha_metadata_dst_free(port);
> >  	}
> >  	airoha_hw_cleanup(eth);
>=20
> [Medium]
> Same question in airoha_remove(): the of_node_put() fires before
> unregister_netdev(), while netdev->dev.of_node is still assigned. Would
> this be safer with the unregister first and the put afterwards?

ack, I will fix it in v5.

>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index 3e93919a175c..207c75152fde 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
>=20
> [ ... ]
>=20
> > @@ -542,14 +543,15 @@ struct airoha_qdma {
> >  struct airoha_gdm_dev {
> >  	struct airoha_gdm_port *port;
> >  	struct airoha_qdma *qdma;
> > -	struct net_device *dev;
> >  	struct airoha_eth *eth;
> > +	struct net_device *dev;
> > +
> > +	int nbq;
> >  };
> > =20
> >  struct airoha_gdm_port {
> > -	struct airoha_gdm_dev *dev;
> > +	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
> >  	int id;
> > -	int nbq;
> > =20
> >  	struct airoha_hw_stats stats;
>=20
> [Medium]
> With multiple airoha_gdm_dev instances now sharing a single
> airoha_gdm_port, do the per-netdev statistics need to become per-netdev
> rather than per-port?
>=20
> airoha_dev_get_stats64(), airoha_ethtool_get_mac_stats() and
> airoha_ethtool_get_rmon_stats() all read from dev->port->stats, and the
> underlying hardware counters at REG_FE_GDM_*_CNT(port->id) are per-GDM
> port rather than per-netdev. When two netdevs share a port (for example
> PCIE0/PCIE1 on EN7581 GDM3, or ETH/USB on GDM4), both netdevs would
> report identical port-wide counters via rtnl_link_stats64 (ip -s link
> show) and via the get_eth_mac_stats/get_rmon_stats ethtool callbacks,
> and summing across the two netdevs would double-count.
>=20
> Would it make sense to maintain per-netdev software counters in the
> xmit/RX paths for the multi-dev case so each netdev reports its own
> traffic through the standard uAPI?

We have already a separated patch to address this issue that is not part of=
 the
series. I will add it to the v5 in the next iteration.

Regards,
Lorenzo

--YnCVD7Lr1XicTVN0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf7vkgAKCRA6cBh0uS2t
rNx6AP4vp7fBv+mMgpov4j4sMb2X2lfK18z7Rdr86kjr3iuVkQEA2v2JFYUsriWf
RBzOd9kloGcV9h2okyFY1MsyXDH1uAY=
=LwTq
-----END PGP SIGNATURE-----

--YnCVD7Lr1XicTVN0--

