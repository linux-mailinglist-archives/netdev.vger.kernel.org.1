Return-Path: <netdev+bounces-258846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOZNH0PikmmrzgEAu9opvQ
	(envelope-from <netdev+bounces-258846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:24:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F7141EE1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5DA300C91C
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D22BE056;
	Mon, 16 Feb 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VATDK8RJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5A2848A8;
	Mon, 16 Feb 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771233856; cv=none; b=hyVyBCwu62j0dw60DiuD+MpXiMr2KCFQyXsy0Lqdggdljj2/lA2LicLxE9B40dTZlY78omYVQUQCUxk+fXtnw9QQxkZnmNT1Kb5/uCd4S4G+bIpNuE4YNOuo9Spz0bNz6f7uBLgDKSRWSDQL1XXafSrFvizJeac2fVGn9Q7yhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771233856; c=relaxed/simple;
	bh=jUieC0lBFZSQ/SZySCEiOOp4+YSwNd1XEU2ZN/W1gaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1Nzs1FialL3SLzeJ6vxd0Frz67lsODcbMTa2srPOF2KaI2TqqMlYlER/qKiU4JLktPTMu7M+4W+6ftJzbDekscdnkPd9PGwVeAb069An+u2S/aWFxBHIVc7ZtWcIMPd3f8oVMXuLyepsJ9SDxxOoXh2TWxPoids8aGgiB5ZiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VATDK8RJ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fDy5R1Rxqz9tVQ;
	Mon, 16 Feb 2026 10:24:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1771233851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2vy6a1Meu+skf7rOG8rJ02x19jQsoOB+N+i06OG6jo=;
	b=VATDK8RJSlC2sJH92HI3+Xk72/x56bq1logEqJaAjaGfbVTFDoqdqEEVJyGNMxIZoODhNy
	c3eE1WaySM1Kdvks+bvwiLBIt9hjoBmJTXLZEESlvEhzNvu/OB5vTVGbsCzqr779/j+UPn
	YRaVzcu1RhRq2oZ4qOkJFJPKi3kFtpZnPfTUMNC8wdmqg9yY2ajeEu1+OuwQBIcHD5qNRI
	uIIqfutbvd6YMH892tkQqrw4Ynka/UNeLGJjanx7RLglG+XMkzwDPe2Zzs7zZjXtZAggj5
	lCNYEA3j+Alg39iq6OAVvW8AgSULz3cGOrXSmU7r+tkPHjPnqSBLhBmYahv35w==
Date: Mon, 16 Feb 2026 10:23:59 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v23 2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20260216102359.37586219@wsk>
In-Reply-To: <20260206112454.2e9a686f@wsk>
References: <20260204232135.1024665-1-lukasz.majewski@mailbox.org>
	<20260204232135.1024665-3-lukasz.majewski@mailbox.org>
	<20260205182805.196fd832@kernel.org>
	<20260206112454.2e9a686f@wsk>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: 251ff2ea1f4baad21a7
X-MBO-RS-META: z4bao4g3s7pd9hey7cm8gwcj5wtksdmj
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258846-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD5F7141EE1
X-Rspamd-Action: no action

Hi Jakub,

> Hi Jakub,
>=20
> > On Thu,  5 Feb 2026 00:21:30 +0100 Lukasz Majewski wrote: =20
> > > This patch series provides support for More Than IP L2 switch
> > > embedded in the imx287 SoC.
> > >=20
> > > This is a two port switch (placed between uDMA[01] and
> > > MAC-NET[01]), which can be used for offloading the network
> > > traffic.
> > >=20
> > > It can be used interchangeably with current FEC driver - to be
> > > more specific: one can use either of it, depending on the
> > > requirements.
> > >=20
> > > The biggest difference is the usage of DMA - when FEC is used,
> > > separate DMAs are available for each ENET-MAC block.
> > > However, with switch enabled - only the DMA0 is used to
> > > send/receive data to/form switch (and then switch sends them to
> > > respecitive ports).
> > >=20
> > > Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
> > > Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>   =20
> >=20
> > Transient build failure here:
> >=20
> > drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1072:32: warning:
> > variable =E2=80=98priv=E2=80=99 set but not used [-Wunused-but-set-vari=
able] 1072 |
> >       struct mtip_ndev_priv *priv; |
> > ^~~~
> >=20
> > I sent out the AI code reviews while at it, without looking at them.
> > So please approach them with caution.. =20
>=20
> IMHO, issues pointed with AI review have been at discussed and
> (to my best knowledge) addressed.
>=20
> Shall I prepare next version of this patch set?
>=20

I'm a bit confused regarding the next steps for this driver.

There was no reply regarding my last question - and I don't know how I
shall proceed...

--=20
Best regards,

=C5=81ukasz Majewski

