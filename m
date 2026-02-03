Return-Path: <netdev+bounces-256235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHXeIDjKgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:13:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA1D7618
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D39B300E390
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC1839C649;
	Tue,  3 Feb 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kIGWXhrH"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C7303CB6;
	Tue,  3 Feb 2026 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113588; cv=none; b=HUPzMeoLZrU4co3LhgyrPIJzpSvKsTJH1H37lYn+c+iGs7jJQceuzUwciPzxxtsChRcqvgxCWLm1HIZklrh6YWCyOjYB74lFwTRtFL4ksk4qV+JMi54RGykiYgeu58Svl3JclsfNOmExwpq8xqLM9Zj6K7Q4iYtuf8NOlX/8p+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113588; c=relaxed/simple;
	bh=pJ0goWwKS6MP4ur7vxzRvhXTxeUm60Sw2ceZqjxHz+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo5O9MQI470wJSEdKUvbClkYlKeeWvBzdfusLXDueq2V9e44yGjyEwc6LRHl9hVZUXcUMa1MjF3ftMB0H767BGlYMYCt2Uxr0ooz+1CyhtJdZ0Zsp8Tv7mDYFpqzVjQMuLsk8/KGmfzN5hXzg5u82znYBZ7+9EiGlC1PUATannM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kIGWXhrH; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f4zbH658Rz9thY;
	Tue,  3 Feb 2026 11:03:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770113036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/WLesTWjIpwef38SdQ4JX0gdMp0IJsjyMkm8xAgFWc=;
	b=kIGWXhrH/fv5Z6UEAwBwiKWnU1HgR++qoAwUtaSjL0r2h36xtP6PXwALTo9+2xHpHvNDpX
	7zzG/igQFe7TZlu/681yxRxR8YlgD6kHLF6QuhXJseIxd0hRuJkjd7lHXb4skFBFEXqdzh
	jgCyWStCK5A94b3tELO/6fl8zgCGCNMb/s3//jcJUMlZV/K5Pr/H1HM+uH6cHsMNb0K0+p
	dqlec2zoPzHAwiMB28GejqjFcDd7uK3S7/EQdz1XjIryuXQq9Qs4emeM15JzfeIKdplYVO
	6p1jwz37A7xjGvN5mW8FZ4tYdhEKjcGECe2yHgo5PKxvwsyUKjSv9jnrfNM/XA==
Date: Tue, 3 Feb 2026 11:03:41 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, shawnguo@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 conor+dt@kernel.org, horms@kernel.org, richardcochran@gmail.com,
 robh@kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, wahrenst@gmx.net, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [net-next,v22,4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20260203110341.1ce21455@wsk>
In-Reply-To: <20260203014247.824561-2-kuba@kernel.org>
References: <20260131233459.1625279-5-lukasz.majewski@mailbox.org>
	<20260203014247.824561-2-kuba@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: fe9904b47499ae8f7ea
X-MBO-RS-META: zwqoyhezb5rx5qmpyzoc4ik3614jqbee
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256235-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,google.com,redhat.com,davemloft.net,gmail.com,lists.linux.dev,lists.infradead.org,gmx.net,pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: DCBA1D7618
X-Rspamd-Action: no action

Hi Jakub,

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see
> https://netdev-ai.bots.linux.dev/ai-local.html ---
> net: mtip: Add net_device_ops functions to the L2 switch driver
>=20
> This patch adds net_device_ops callbacks for the MTIP L2 switch
> driver, including transmit, multicast configuration, MAC address
> handling, and timeout recovery functions.
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c ---
> > a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c +++
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c =20
>=20
> [ ... ]
>=20
> > +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> > +					struct net_device *dev,
> > int port) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status;
> > +	unsigned int index;
> > +	struct cbd_t *bdp;
> > +	void *bufaddr;
> > +
> > +	spin_lock_bh(&fep->hw_lock); =20
>=20
> [ ... ]
>=20
> > +	/* Save skb pointer. */
> > +	fep->tx_skbuff[index] =3D skb; =20
>=20
> mtip_start_xmit_port() stores sk_buffs in fep->tx_skbuff[index] and
> creates DMA mappings, but mtip_switch_tx() which should complete TX
> operations is empty:
>=20
> static void mtip_switch_tx(struct switch_enet_private *fep)
> {
> }
>=20
> The NAPI poll handler mtip_rx_napi() calls mtip_switch_tx() to reclaim
> transmitted buffers. Since it does nothing, won't every transmitted
> packet leak the skb and DMA mapping? Also, dirty_tx is never
> advanced, so the TX ring will fill (cur_tx =3D=3D dirty_tx) and stop
> accepting packets.
>=20
> jakub: maybe add a TODO comment transiently here, since later patch
> implements the cleanup?

The mtip_switch_tx() is empty as we have agreed, that I will divide
this driver to several patches to ease the review.

Adding TODO seems to only make AI review happy, as:

- The patch which adds support for FEC_MTIP_L2SW in Kconfig will be
  sent after the driver is accepted to net-next

- Those commits are even now bisectable when FEC_MTIP_L2SW is
  enabled (when I test the setup).

Anyway, if you still would like to have the TODO comment, then please
give me a hint how it shall be written to make the AI happy...



And maybe a few my thoughts:

1. AI review seems to bring each time different issues - even the
"grammatic" ones were not provided with the first AI generated review.

2. I have tried to setup claudie> to run the patch set through it -
however, it requires a paid account on a cloud/AI vendor (and I guess
that different vendors' AI engines produce different output for the same
"AI prompt")?


Anyway, I do appreciate the AI review - it provides very deep insights
through the code.

>=20
> > +static void mtip_timeout(struct net_device *dev, unsigned int
> > txqueue) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +
> > +	dev->stats.tx_errors++; =20
>=20
> Jakub Kicinski noted in v16 review that tx_errors are already counted
> by the network stack, and the statistic is exposed per-queue in
> sysfs. Does incrementing tx_errors here double-count timeout events?
>=20
> https://lore.kernel.org/all/20250725151618.0bc84bdb@kernel.org/
>=20

Yes, this shall been removed.

> > +	DO_ONCE(mtip_print_hw_state, dev);
> > +
> > +	schedule_work(&priv->tx_timeout_work);
> > +} =20



--=20
Best regards,

=C5=81ukasz Majewski

