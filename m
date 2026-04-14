Return-Path: <netdev+bounces-278258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PusGW+P3WnIfgkAu9opvQ
	(envelope-from <netdev+bounces-278258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED33F4A3B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5550E3024283
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3322579E;
	Tue, 14 Apr 2026 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouL92XBh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27DC8E6;
	Tue, 14 Apr 2026 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776127849; cv=none; b=n+ejKwDncN3G+SeWsRV7/14QhvRpJDPYR1iU8FmBkM+0J5brYIwGJpj9LWEsju1bQvRf6w5ll2KIfk3XA9cM2hN0KxraI9O7+HqC8Cazly3RDCsxKEzXyon00cRQKGyc9qF0CjSAXjLBe8KEFeZRiESzgy/ftOYeSHTxzkepQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776127849; c=relaxed/simple;
	bh=IWxyKhckWY7+sHOpuC6y6ZfK3FkZsU1LMf8Fxaa1QmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FN4ExtVac9EsaLMv2GNN0PyCW3soIK/GPgfwO3UfZitOwYCqwziE3Sp60SR1djMEkFfm7ldhNsEnDMSfitJ21IGKb/TvK09qtFswlhU+NKJglYfi2kN+10oAhFBE0e+WU8UjEMSzEEEBaz25rZ9mv9IARXuQlKZVwiGOtSu8a34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouL92XBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98F6C2BCAF;
	Tue, 14 Apr 2026 00:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776127849;
	bh=IWxyKhckWY7+sHOpuC6y6ZfK3FkZsU1LMf8Fxaa1QmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ouL92XBh6xR9+rttBQM7DmCDNIE9xNaX0NItFv70QWqZmcmwxarYqtDBYFXXIc6sA
	 hAaKFYu3JQoaiYy6PMSnIkH2KzNZ+cM7PCYPyDULRmfiC2Ubvs+duX+R41mLvhnHtj
	 29MUk//kSzdNQDNpPVxqGy96RDWFvzgq7aTqKB7zgsIluINpjZzhy1wdXc21oYK1qf
	 IbHe7yoWAXH2HLLK/FNCbWdWq4ASDWDOosTY6gUb8T/FoE3s3zzi/heNbDr3jTDMcZ
	 Le/HQMMg4cyZvc/GuG/6Anou6SQDbkehT17sosO1m53w/ywViRPkL3dsvkebdoHeYX
	 99e3Ey75gcjLw==
Date: Mon, 13 Apr 2026 17:50:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Paolo Valerio <pvalerio@redhat.com>,
 Conor Dooley <conor@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 13/14] net: macb: use context swapping in
 .set_ringparam()
Message-ID: <20260413175040.352378c5@kernel.org>
In-Reply-To: <20260410-macb-context-v2-13-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
	<20260410-macb-context-v2-13-af39f71d40b6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278258-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEED33F4A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 21:52:01 +0200 Th=C3=A9o Lebrun wrote:
> ethtool_ops.set_ringparam() is implemented using the primitive close /
> update ring size / reopen sequence. Under memory pressure this does not
> fly: we free our buffers at close and cannot reallocate new ones at
> open. Also, it triggers a slow PHY reinit.
>=20
> Instead, exploit the new context mechanism and improve our sequence to:
>  - allocate a new context (including buffers) first
>  - if it fails, early return without any impact to the interface
>  - stop interface
>  - update global state (bp, netdev, etc)
>  - pass buffer pointers to the hardware
>  - start interface
>  - free old context.
>=20
> The HW disable sequence is inspired by macb_reset_hw() but avoids
> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
>=20
> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
> over register writes which would be redundant (because values have not
> changed).
>=20
> The generic context swapping parts are isolated into helper functions
> macb_context_swap_start|end(), reusable by other operations (change_mtu,
> set_channels, etc).

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 81beb67b206a..340ae7d881c6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3081,6 +3081,89 @@ static void macb_configure_dma(struct macb *bp)
>  	}
>  }
> =20
> +static void macb_context_swap_start(struct macb *bp)
> +{
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	unsigned int q;
> +	u32 ctrl;
> +
> +	/* Disable software Tx, disable HW Tx/Rx and disable NAPI. */
> +
> +	netif_tx_disable(bp->netdev);

AFAIR netif_tx_disable() just stops all the queues, if the NAPIs and
whatever else may wake queues is still running the queues may get
restarted right away.

> +	spin_lock_irqsave(&bp->lock, flags);
> +
> +	ctrl =3D macb_readl(bp, NCR);
> +	macb_writel(bp, NCR, ctrl & ~(MACB_BIT(RE) | MACB_BIT(TE)));
> +
> +	macb_writel(bp, TSR, -1);
> +	macb_writel(bp, RSR, -1);
> +
> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		queue_writel(queue, IDR, -1);
> +		queue_readl(queue, ISR);
> +		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +			queue_writel(queue, ISR, -1);
> +	}
> +

