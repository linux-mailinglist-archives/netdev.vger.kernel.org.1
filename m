Return-Path: <netdev+bounces-273832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMtKOQGAzGn0TQYAu9opvQ
	(envelope-from <netdev+bounces-273832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:16:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7681B373AFE
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56ED53075D44
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9B1DF751;
	Wed,  1 Apr 2026 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVscnBww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFB28690
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009685; cv=none; b=DixQ3uH0C54qDkNk1ztS3H7Kv7U02bhkfs9ZDi3m458mt7c6Ew9QC68zKEhPHt1I7vYIF37SXrjecjYZqfit6UDLZgTiuZGPUHy6G+UnqJfnXrDpvFwphTVV/L0ff9F3YmO3oF76MLcDZKhepLmEg0KUfx3MYh9/IFOY0UdUiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009685; c=relaxed/simple;
	bh=RKIRkB7dwIPp5lClJ0dJhiaIpEWh1SS1HK0MYCHKxr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocnhcyhIa1oIdLc+lwQpSkv4nvgza/4q5e/2EXooZz3s9Nv+UiT4bEu0qN361MU3UsKtuAIVW3uRC2r5UMtor9lCyZ/MNXlR4cUiuf3vvOpX+D5YCJa87MJM8eTceAobPTNxX7sA7InLt58PbKMBMmx5la++G30FZBuUm2jb7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVscnBww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58A3C19423;
	Wed,  1 Apr 2026 02:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775009685;
	bh=RKIRkB7dwIPp5lClJ0dJhiaIpEWh1SS1HK0MYCHKxr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZVscnBwwOBiFAsll4NVdYRbBAXWGY8Ze/q5YwnVc+YFVTOgSiYDhd7PjpdKVSSRf1
	 6iFNAFS4dU5D/Ejz42tpLoP1cxj04gmQwSeiuzKdKsL6AFRSoU+7aj5WimTnqTrKNy
	 RUyZEDtqo+c95zRN23P/OXEF3lTNteHrTtzfvOrrd5PodIcSlkphGia0tnzYkWmNZR
	 zlWfqubtg+AdVRV37GjaT2gL82zGETBvkBtKb+5m37vAyng7+rKl33icWM9rMFracm
	 OCm2g/DfYdSyDMxfg6ItV0dj1++M1g2OsJRPwk2weREjPgoTJSXZ/OP1whKseQrmrQ
	 8GP1uk/qqOt3w==
Date: Tue, 31 Mar 2026 19:14:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 netdev@vger.kernel.org, Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
Subject: Re: [PATCH net] net: ethernet: cortina: Fix SKB leak
Message-ID: <20260331191444.79ed1da9@kernel.org>
In-Reply-To: <20260330-gemini-ethernet-fix-v1-1-18783a45d13a@kernel.org>
References: <20260330-gemini-ethernet-fix-v1-1-18783a45d13a@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[googlemail.com,lunn.ch,davemloft.net,google.com,redhat.com,rere.qmqm.pl,vger.kernel.org,nebelreich.de];
	TAGGED_FROM(0.00)[bounces-273832-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebelreich.de:email]
X-Rspamd-Queue-Id: 7681B373AFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 08:00:29 +0200 Linus Walleij wrote:
> From: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
>=20
> Under sustained RX load (e.g. large file transfers over the network), the
> device freezes completely and requires a hard power cycle. No kernel panic
> or oops is produced; the system simply stops responding.
>=20
> In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
> gmac_get_queue_page() returns NULL for the second page of a multi-page
> fragment, the driver logs an error and continues =E2=80=94 but does not f=
ree the
> in-progress skb that was already being assembled via napi_build_skb() /
> napi_get_frags():
>=20
>     gpage =3D gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
>     if (!gpage) {
>         dev_err(geth->dev, "could not find mapping\n");
>         /* BUG: skb leaked here */
>         port->stats.rx_dropped++;
>        continue;
>     }
>=20
> This path is distinct from the similar block in gmac_cleanup_rxq(), which
> correctly only logs "could not find page" without an skb in flight.
>=20
> Each occurrence of this error path leaks one skb. Under sustained traffic
> the leak exhausts kernel memory, causing the observed lockup.
>=20
> Free the in-progress skb via napi_free_frags() before continuing, matching
> the pattern already used elsewhere in the driver.
>=20
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethe=
rnet")
> Signed-off-by: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Thanks for handling (what I assume to be) an external report Linus!

Not sure I'm connecting the dots here, tho.
Apparently skb is a static variable in this function(!?) so the skb
should be flushed on the next SOP?

Also I don't see how potential memory leak squares with the first
sentence of the commit which reads:

  device freezes completely and requires a hard power cycle

how can kernel mem leak cause a device to wedge?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> index 4824232f4890..723d90d5fdf3 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1491,6 +1491,10 @@ static unsigned int gmac_rx(struct net_device *net=
dev, unsigned int budget)
>  		gpage =3D gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
>  		if (!gpage) {
>  			dev_err(geth->dev, "could not find mapping\n");
> +			if (skb) {
> +				napi_free_frags(&port->napi);
> +				skb =3D NULL;
> +			}
>  			continue;
>  		}
>  		page =3D gpage->page;
>=20
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260330-gemini-ethernet-fix-604c28c53da1
>=20
> Best regards,


