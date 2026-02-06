Return-Path: <netdev+bounces-257517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFIdAozBhWnEFwQAu9opvQ
	(envelope-from <netdev+bounces-257517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:25:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22669FC9E2
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 906903009828
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 10:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FB937104D;
	Fri,  6 Feb 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Q+guTtEN"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A83624C4;
	Fri,  6 Feb 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770373509; cv=none; b=G2kCvvVRzFpdF76fIxWk1XHCETy37qU0lUQZsFxBVMs89EnGe/KOlqn/dczmvAqkYx0WAAWuKivl8NE9xRQPc4Ts6palj6ObfzfRLn/I0KR4UOTAPQcfFJL1fqCeiurbwik0MFZ6/lRQsqzi0eJDJbKZfji8wJqsvGZUByTqg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770373509; c=relaxed/simple;
	bh=/MrCMk1XqmJv4v+raVshn8mmcHW5OWo2dw/7KEjMkUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIq4IftngT5K6Adhe4JnKlL2WycORKjQVb0Ed8tjIU+wdGIiAEP+nviG0fu+O/u10hGXfLw6Kfk21M/yaVaaTBXmw8azQ5COey7KjnDDRg/0IabJxLdXa8sMlTd+1KWosJokzY9gBNVnSuohFeZM67ooe+0tCxEDoirOGows8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Q+guTtEN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f6qwK2Bl2z9tp0;
	Fri,  6 Feb 2026 11:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770373505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOfHMKbNXy3MxrUvKuYFlc2euBi7oH7iiv3EqWTkTe0=;
	b=Q+guTtENwgC5TbwQgdx1Frin7BHRBTLNH+jgV8zl/vj7XoqV/IVMLIGrfcA1N7f0zodGNf
	f1SOpF8U8TqIwqcLPhN7MwDaaV3nLmuYFalA5LwH9nG5QgWkaGr8ibG1uiM49PAJCo1FRc
	1UebMpyjMe0IkZjc9VhNpLJTyl4VKbpL82p+GkYxXoqUvLBd9Y7sBAxfusunf+U4aJM7ih
	6imcTswZXvX/En7KJXYxP7bH01uL3d516agiwxtsNvHrNtmZJZmcsdQ7Y34BAwHL8svGUB
	CHxNTfBJVKnmMQr0txQQe9v5OJCpX5gX88MCrPhurOeHz9X3aNhrRmcLVSYsXA==
Date: Fri, 6 Feb 2026 11:24:54 +0100
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
Message-ID: <20260206112454.2e9a686f@wsk>
In-Reply-To: <20260205182805.196fd832@kernel.org>
References: <20260204232135.1024665-1-lukasz.majewski@mailbox.org>
	<20260204232135.1024665-3-lukasz.majewski@mailbox.org>
	<20260205182805.196fd832@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: db1cc35f512114a3232
X-MBO-RS-META: w9x5nk7bybc1tfbnhh3ap1diw3eq7r7n
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257517-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mailbox.org:email,mailbox.org:dkim]
X-Rspamd-Queue-Id: 22669FC9E2
X-Rspamd-Action: no action

Hi Jakub,

> On Thu,  5 Feb 2026 00:21:30 +0100 Lukasz Majewski wrote:
> > This patch series provides support for More Than IP L2 switch
> > embedded in the imx287 SoC.
> >=20
> > This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> > which can be used for offloading the network traffic.
> >=20
> > It can be used interchangeably with current FEC driver - to be more
> > specific: one can use either of it, depending on the requirements.
> >=20
> > The biggest difference is the usage of DMA - when FEC is used,
> > separate DMAs are available for each ENET-MAC block.
> > However, with switch enabled - only the DMA0 is used to
> > send/receive data to/form switch (and then switch sends them to
> > respecitive ports).
> >=20
> > Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
> > Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch> =20
>=20
> Transient build failure here:
>=20
> drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1072:32: warning:
> variable =E2=80=98priv=E2=80=99 set but not used [-Wunused-but-set-variab=
le] 1072 |
>       struct mtip_ndev_priv *priv; |
> ^~~~
>=20
> I sent out the AI code reviews while at it, without looking at them.
> So please approach them with caution..

IMHO, issues pointed with AI review have been at discussed and
(to my best knowledge) addressed.

Shall I prepare next version of this patch set?

--=20
Best regards,

=C5=81ukasz Majewski

