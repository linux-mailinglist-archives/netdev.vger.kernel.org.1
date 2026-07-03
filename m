Return-Path: <netdev+bounces-304325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 75p0F3EsR2raTwAAu9opvQ
	(envelope-from <netdev+bounces-304325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 05:28:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B07846FE33B
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 05:28:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gibson.dropbear.id.au header.s=202606 header.b=UiZQpKMD;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304325-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304325-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 315AA3066271
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B1F2FF672;
	Fri,  3 Jul 2026 03:24:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228DB253340;
	Fri,  3 Jul 2026 03:24:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049095; cv=none; b=Gp0cElEWxciUh31We7el+/u+vfFha3IiJ2uWVMoO55kls+4ZQ7cbfG0EAZgqycyRrezjpgOwPqxCriTY1VW6AAz9mBfnj/Q02rBqbHbCG+/1Bf5gJakqyycsWk8kwso6i/n6IRMkstj8Ei54uMjy5qi4eJipbYYezFi2dWWl5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049095; c=relaxed/simple;
	bh=CNajv3EoPl0wz3cOXsyZNSRUzSKpJ1jsRGcW8Qgrqqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOZ67m++zaMX3TsP1J/2EYOuSGAEqOFTyUcCQB5B4rj3ZBfq5xQ4G4dDgtCeSHhcSD7C/O6ceQZxCkAoNzF0pkW2mYBQ6iE2lvFQojwmxRhMnTWUKEAGdeu/E1Al3BeZHQcJmKqJ+kiBRZkh66p7QErrDk6mQwI70bhRqvxJivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=UiZQpKMD; arc=none smtp.client-ip=150.107.74.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202606; t=1783049080;
	bh=i97xl//wIbQ1VuAZlAyelUsusGL+BZXHQ/1wUz9fKfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UiZQpKMD6JI/My/WTntiBDHRhpCqhC3zCV6l35tReghfKBYsJ4ysFdJ0Bvbd/gJ7r
	 cKLLTYDSLNhQrqPimpo+Gbj1JmFpgUg7cQEDYoPZg6qSGhZoyaLjpSNREizGKjPv5w
	 qFYDjA1b+3CpXix52RXKfdLgaZC5gGdoXdHY+aNpfhRKrAP0RfbOYX2Tle6OZ7eD5n
	 JNCvj0uDsYdq34GBnpdlEA4Uiuvw0WoQwI6UgtO/6OTX+VsTKdQWGY9GkdOoqATcyn
	 JNbdT8d+4fR+6md5+pJqDXFfUoKK1wO2K52k2Ufzlfw6yby/6oXkPXyV84EbmRRHEh
	 g9/keY6sUx4BA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4grzdN0ZhXz4xSR; Fri, 03 Jul 2026 13:24:40 +1000 (AEST)
Date: Fri, 3 Jul 2026 13:06:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: emac: mal: fix W1C write race in ICINTSTAT
 clearing
Message-ID: <akcnQEiJYfAtPqN1@zatzit>
References: <20260702234923.1320412-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260702234923.1320412-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202606];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dropbear.id.au];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304325-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dropbear.id.au:url,gibson.dropbear.id.au:from_mime,gibson.dropbear.id.au:dkim,zatzit:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B07846FE33B

On Thu, Jul 02, 2026 at 04:49:23PM -0700, Rosen Penev wrote:
> The ICINTSTAT register is write-1-to-clear (W1C).  The read-modify-write
> pattern in both mal_txeob() and mal_rxeob() can lose interrupts: if a bit
> that should not be cleared is already asserted when mfdcri() reads the
> register, it is included in the read value, retained by the bitwise OR, a=
nd
> then written back as 1 - inadvertently clearing a pending but unhandled
> interrupt.
>=20
> Fix by writing only the specific bit to clear (ICINTSTAT_ICTX for TXEOB,
> ICINTSTAT_ICRX for RXEOB).  W1C semantics guarantee that writing 0 to the
> other bits has no effect.

Wow, it's a long time since I thought about the MAL.

> Fixes: 1d3bb996481e ("Device tree aware EMAC driver")

This doesn't appear correct.  The lines in question were added by
fbcc4bacee30c ("ibm_newemac: MAL support for PowerPC 405EZ")

> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Assuming ICINTSTAT is indeed a W1C register (or "read/clear" as I
believe they were termed in the 405 documentation) the change looks
correct.  However, I no longer have access to the documentation that
would let me verify that.  I would absolutely not trust an LLM to know
if that's the case, since it's a fairly arbitrary and specific detail
of an obscure CPU.  That said, that the previous code has an | rather
than &~ and presumably at least somewhat worked does suggest it's
read/clear rather than plain read/write.

> ---
>  drivers/net/ethernet/ibm/emac/mal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/i=
bm/emac/mal.c
> index 4025bc36ae16..eab7a487bf08 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.c
> +++ b/drivers/net/ethernet/ibm/emac/mal.c
> @@ -282,8 +282,7 @@ static irqreturn_t mal_txeob(int irq, void *dev_insta=
nce)
> =20
>  #ifdef CONFIG_PPC_DCR_NATIVE
>  	if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
> -		mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
> -				(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICTX));
> +		mtdcri(SDR0, DCRN_SDR_ICINTSTAT, ICINTSTAT_ICTX);
>  #endif
> =20
>  	return IRQ_HANDLED;
> @@ -302,8 +301,7 @@ static irqreturn_t mal_rxeob(int irq, void *dev_insta=
nce)
> =20
>  #ifdef CONFIG_PPC_DCR_NATIVE
>  	if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
> -		mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
> -				(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICRX));
> +		mtdcri(SDR0, DCRN_SDR_ICINTSTAT, ICINTSTAT_ICRX);
>  #endif
> =20
>  	return IRQ_HANDLED;
> --=20
> 2.55.0
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

