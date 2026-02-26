Return-Path: <netdev+bounces-261117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPWZE6mmn2mHdAQAu9opvQ
	(envelope-from <netdev+bounces-261117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:49:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC919FEFB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44DC6300BEBC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75FC3195F0;
	Thu, 26 Feb 2026 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6/rU9/n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84891372B57
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070564; cv=none; b=No21R+kYTaFfVNIZlVf5NdCDbxuCo7+iWxSzEibquf2kN7WfZyypP85vRItt5bjWBYzoaQeKvUCDl30vV5hEgJEP2PcfWZosHXaouzghpV/IjGNutzBvVmd0jP09y6P5jnEN4/H5T6maHq4GDU9M4eCqk4imL2EBjtia9FUabas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070564; c=relaxed/simple;
	bh=AzUQJuezjL43RkLqsykXOvmq23zwAxEz28YQ6NLiTX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nw8/uVyh2XKEdMn3VL69ndFny4J+HpNSL8hzB5M+/iAo8Q+6MtXWceEGm/4h8mqc+3sQTxypo8teQiPcQsGwwZrbH+zMebTmalM1muiotRCOlVj9rNRoMEdnLr12f6w8bIUSOrhT8mL7WK79C5v3F0LnZsL45qvh51B3mN5XPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6/rU9/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEB3C116D0;
	Thu, 26 Feb 2026 01:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772070564;
	bh=AzUQJuezjL43RkLqsykXOvmq23zwAxEz28YQ6NLiTX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a6/rU9/nIKoX7BWmWG+Uer9MyJyvQa51xJfOgs/Fl/CKiExwI57gEah0vh6q8F0NA
	 kWRM7T7eYf9hNrwMzf8YVa5a2nkQyJzDlF0lbQprj6zo0LB3kMW693JBz2I0xFhxlL
	 3wOVgLEb7cgQDCcicnUMT4zpUVYnf/IUgtw6epLTFXcvJG44/JjiQsN7DQaia3Fh5R
	 i8gU1raNbKUM16b36jEj6wJuwqAMMGVZyf3vI7fEW27shbWhKK6WOf/0OsX+AIQOY4
	 l4j9nCIn//NH0xHn5umPk8NpGpgLDZ0cpdJwrUjMSIFrZ6gviZjKD34Oh0vnMJtzgy
	 CGNTkazHevCoA==
Date: Wed, 25 Feb 2026 17:49:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>, <edumazet@google.com>,
 <nicolas.ferre@microchip.com>, <pabeni@redhat.com>,
 <linux@armlinux.org.uk>, <phil@raspberrypi.com>, =?UTF-8?B?R3LDqWdvcnk=?=
 Clement <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/5] net: cadence: macb: add EEE register definitions
 and capability flag
Message-ID: <20260225174922.5f6517e5@kernel.org>
In-Reply-To: <DGO7VZMIEFXR.1XGID5EK3Y72A@bootlin.com>
References: <20260225091558.51157-1-nb@tipi-net.de>
	<20260225091558.51157-2-nb@tipi-net.de>
	<DGO7VZMIEFXR.1XGID5EK3Y72A@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70CC919FEFB
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 18:26:18 +0100 Th=C3=A9o Lebrun wrote:
> On Wed Feb 25, 2026 at 10:15 AM CET, Nicolai Buchwitz wrote:
> > Add register and bitfield definitions for the Cadence GEM MAC's
> > IEEE 802.3az Energy Efficient Ethernet (EEE) support: =20
>=20
> nit: could this patch be squashed into [3/5]?

Maybe split into two in fact, the relevant part squashed into patch 2
and the rest in patch 3?

