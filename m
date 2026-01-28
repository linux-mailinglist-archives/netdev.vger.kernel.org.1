Return-Path: <netdev+bounces-254497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIUQHR6SemlC8AEAu9opvQ
	(envelope-from <netdev+bounces-254497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:47:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0502A9BD9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4BA930157CC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B132C159A;
	Wed, 28 Jan 2026 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SyOhNsIE"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EA26CE2C;
	Wed, 28 Jan 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640472; cv=none; b=o/XL+i3CrR4NBEV82jgeUfCXazQYcuPSjsU3IIWy4BJ0astCo7KDMeYaTVhUIS3jPts8DvNn7r75BwIwdfxCbHuN7xyjM6OhX8w4z1sZGxp7m3bzL+m9w0pJYRmhkfE+g4aq8ejYV2mK/DJntDpyPJa/oJVKzgK5tO0iyfSCaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640472; c=relaxed/simple;
	bh=ialA5TyIBgxp+uDi4ejZ5ByJ3omyVvwj+aptox/jc5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFJSCPgEOXW7q7GIoCsKfZOjzUCH79nmRIxZFG3HoxWndnLvhqBfvv1HZNTblyCvF+FSNIilH8OzEXU1fhzPTnNlOE2gJZp0F1w3+X2P4zV5CWjRuHrM0okj6EVZH4MZiT8lm9+v1xBcru5r9Pz0CeNELRQK4uH3+I6TyokAk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SyOhNsIE; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1cqQ2Kkhz9tgG;
	Wed, 28 Jan 2026 23:47:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769640466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4upRbVfTJ07DQH6ODb25K7X4KuRaWDl+UDpNd35zMs=;
	b=SyOhNsIE+x9Koof+yayV9dROTmHkxZR2tmaXFlmoeW44lqFagrJdNkWousn1cicP7XiTHY
	DawN7wl5LiqsBW7AI9VDIXQGPfHLD75VGtrYTxK4GHSaIscGr7Oc2u6pL2eHuY5pF9atMn
	TxO+WldlLcQx6UyyJicNCkghMB3b0GmC0f71pRK72knE8HDQQF1hcFodMBMVwoErd2t1GD
	4ySioLnGAQcrYpsAfeezykD6ZZykeyhtLymTdatgn3vu2W516EW4EVlmuXZHIBUNLDMwFt
	A2i27xDC8jmDdSGiW8OyduPz0t+el9ptTDlA2mkwQcHx1amp3Uc3Kwg1jT/lvA==
Date: Wed, 28 Jan 2026 23:47:36 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, horms@kernel.org, shawnguo@kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, wahrenst@gmx.net, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org, richardcochran@gmail.com,
 edumazet@google.com, andrew+netdev@lunn.ch, robh@kernel.org,
 krzk+dt@kernel.org
Subject: Re: [net-next,v20,2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20260128234736.49bd70b3@wsk>
In-Reply-To: <ed0e1af1-0210-4461-8939-3e4e35d74dae@lunn.ch>
References: <20260126103400.1683125-3-lukasz.majewski@mailbox.org>
	<20260128022549.4151341-1-kuba@kernel.org>
	<20260128224125.246bcf41@wsk>
	<ed0e1af1-0210-4461-8939-3e4e35d74dae@lunn.ch>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: 686151c5d01e846fd34
X-MBO-RS-META: 5xys9hdxh1j3adjqtyn71d9ygs5oeaky
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254497-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,pengutronix.de,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E0502A9BD9
X-Rspamd-Action: no action

Hi Andrew,

> On Wed, Jan 28, 2026 at 10:41:25PM +0100, =C5=81ukasz Majewski wrote:
> > Hi Jakub,
> >  =20
> > > This is an AI-generated review =20
> >=20
> > AI is going to take the "Maintainer's" job :D =20
>=20
> We had a bit of a discussion about this.
>=20
> Our observations so far is that AI finds different sorts of issues,
> which human reviewer often don't spot. It also does get things wrong,
> so we spend some time sanity checking its reports. So overall, it
> might actually increase the workload, but also increase the quality of
> the code which gets committed.
>=20

Frankly - from the MTIP L2 switch patch set review - the AI review does
a _really_ good job ...

It finds non trivial issues - with very deep insights to function's
call dependencies.

> 	Andrew



--=20
Best regards,

=C5=81ukasz Majewski

