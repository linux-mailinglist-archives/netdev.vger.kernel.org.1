Return-Path: <netdev+bounces-268226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK47JFg/uGnSawEAu9opvQ
	(envelope-from <netdev+bounces-268226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:35:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3600229E595
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 575A5307AFFF
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7B3D301E;
	Mon, 16 Mar 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2RfqEAqk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550383D1CAE;
	Mon, 16 Mar 2026 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682130; cv=none; b=f6fB+C2L2kFjaz9U3uqcXo1IYsAKQ6ObKz6fJYzZpJQTZU++ivbSJEXi0pRmAUlB7jaxW1m4Au6IwWK2laJ/sQlLAkwjuybssLWkBATRpjMelBq280s08O3KGQI+rINHIkwrWRmL/Dj96wGtQFgubsP2WNZgubPsMcWfIPUhK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682130; c=relaxed/simple;
	bh=NecQNIbJVjR4QKynRnsWGLEM/FjCA8nKBtIf4lM6MYU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Rq9D0caax9XrW/3aV7kkMPLkpzn4qlfxluBphqk3aJOrlLfHDDe0ekXtVc2d+sila/TfGWsbgDmh8wo2j/JgQyX//hpFRSSCbf4EI+nuIINt29x+1q/38uoVjqDACCge5Fi67UIULj7i86XkAe7biZIWCI5eHiPbgsXxFARKusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2RfqEAqk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 75F08C55049;
	Mon, 16 Mar 2026 17:29:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 959E35FC4A;
	Mon, 16 Mar 2026 17:28:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F415210372205;
	Mon, 16 Mar 2026 18:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773682122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gz0O9gf9DYS/9ki+LBzB+Kc7tz7JAV4ntvwkaPEiz9o=;
	b=2RfqEAqkQVxA/RBKfoUw4sivzmpo/J3yIH3PRNOSIqcaI+6j1jCXdiZw0OrgYrhyrk9uxE
	gnIRJ+LHMMTEN3pxnTANZm4QcvoarnjEPeumXPbQ3uEKOusXCLZ7Abt5w8m1ioKPYDk9UG
	rHYPSxLNQoI3oZxFkrQ9xfek7YrfKznFUlbRPeE5wWQ9EyNBs3iXCdpjjP69JQdnapQ8oN
	z8fdwhle17H+7c+9iu/gOrkyroc9MhlSO9pcY8ET5j5Tggtat2tkzJguMOBpFXrpbqhw0t
	tMLOg3DwLiyWxAcNbkl6Q+EDosicnHRpZu/TAzWT2PlMKujUYVfk1VUHuZv9eQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 18:28:39 +0100
Message-Id: <DH4DU4Z4X9MM.398FQ3BIZQIJB@bootlin.com>
Subject: Re: [PATCH net-next v3 0/3] Initial support for PIC64-HPSC/HX
 Ethernet endpoint
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Charles Perry" <charles.perry@microchip.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260313140610.3681752-1-charles.perry@microchip.com>
In-Reply-To: <20260313140610.3681752-1-charles.perry@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268226-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3600229E595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Charles,

On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
> Hello,
>
> This series add basic support for Microchip "PIC64-HPSC" and "PIC64HX"
> Ethernet endpoint. Both SoCs contain 4 GEM IP with support for
> MII/RGMII/SGMII/USXGMII at rates of 10M to 10G. Only RGMII and SGMII at a
> rate of 1G is tested for now. Each GEM IP has 8 priority queues and the
> revision register reads 0x220c010e.

Do you have plans to test higher rate? We might get our hands on GEMs
that support >1G and would like to know if CCing you would make sense.

> One particularity of this instantiation of GEM is that the MDIO controlle=
r
> within the GEM IP is disconnected from any physical pin and the SoC rely =
on
> another standalone MDIO controller.

Ah, that means you instantiate the MDIO bus for no good reason.
Code looks like:

static int macb_mii_init(struct macb *bp)
{
	struct device_node *mdio_np, *np =3D bp->pdev->dev.of_node;
	int err =3D -ENXIO;

	/* With fixed-link, we don't need to register the MDIO bus,
	 * except if we have a child named "mdio" in the device tree.
	 * In that case, some devices may be attached to the MACB's MDIO bus.
	 */
	mdio_np =3D of_get_child_by_name(np, "mdio");
	if (!mdio_np && of_phy_is_fixed_link(np))
		return macb_mii_probe(bp->dev);

	// ... probe MDIO bus ...
}

So to *not* get the bus we need to be in fixed link config. Do you care
about that? I think that the proper fix would be to lazy probe the MDIO
bus until a PHY (ours or some other MAC's) asks for it.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


