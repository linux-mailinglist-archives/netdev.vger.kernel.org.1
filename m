Return-Path: <netdev+bounces-283021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C1AF9Hr82lg8wEAu9opvQ
	(envelope-from <netdev+bounces-283021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:54:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0434A9025
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C23430053D6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB883D9DAA;
	Thu, 30 Apr 2026 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdyJQPxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F803D8112;
	Thu, 30 Apr 2026 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593242; cv=none; b=LvHwR9Qr+EuC6bq21SvKv+E2Fl28lbVEM2cAymX5HCx23aJ5bPDdeGGGXXs1JLD20jkpMgHSTtQrWsu1I1r+ZR50cF4HeBhHG2qRWRWXAhEP1MlmtZLmgi08uPyIMaKBEH4dzIGcyQN/Bj3BbZ/IMazR1TRBhKMkJAp/3aTVlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593242; c=relaxed/simple;
	bh=b5TYgV4qXWjKafYFHZZm/Ie3pRPzvewM0QmNUOdSH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0s+imiu6IS7eXYjzPhKc/Yu36ciFlPvdQTQ/mGwkETfktVHhaNzAQ7nGLNdIa+VGR7gMYXzbNyl7DwFd8smmnYNZeDauyk3nD6hWawPP9ZR354zhAjRwXcrHRLPPyjUDUqz+FuIQdYOScsUIVhU/Y/Q69LvCad8Jh8xpBB036k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdyJQPxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4520CC2BCB3;
	Thu, 30 Apr 2026 23:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777593242;
	bh=b5TYgV4qXWjKafYFHZZm/Ie3pRPzvewM0QmNUOdSH2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bdyJQPxO3zZmjh15isdVudCWmfRR8zXYzi5lNuRtvn4NTUpDuA0sgT3cjY3HL4CvH
	 yJQJp3z7HsT7cYaaWKI5c34K6C7XqA0JiSUb139zOei/FMkhxzO8q4XFKoNrgmObTP
	 3vYiaiS1IFzyrwQcNzXchuN0zl9sBlBYAOjp68XzMBwQAQLNcL8qV+38WgP+jM0J1m
	 OuNF83DTCYLY6HlZGVgQc0EV2M4bzxqbJpuqTF7JxabrwrLfHWY7Gw/tqbvSlxdRn/
	 OZbT2F7Wh17P3GqkzWM/zicaUZy8J4Y9dyabLA4U/fDt2+KE3LraQoFJDdfrgVkZde
	 FRlFfahuz3aCQ==
Date: Thu, 30 Apr 2026 16:54:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Haavard Skinnemoen"
 <hskinnemoen@atmel.com>, "Jeff Garzik" <jeff@garzik.org>, "Paolo Valerio"
 <pvalerio@redhat.com>, "Conor Dooley" <conor@kernel.org>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2 2/4] net: macb: drop in-flight Tx SKBs on close
Message-ID: <20260430165400.78a81cf4@kernel.org>
In-Reply-To: <DI6MK3PFX8EE.1R1567RYTUVNL@bootlin.com>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
	<20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
	<20260429193446.5985abea@kernel.org>
	<DI6MK3PFX8EE.1R1567RYTUVNL@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AD0434A9025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283021-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 18:20:01 +0200 Th=C3=A9o Lebrun wrote:
>  - In macb_get_stats(), replace:
>=20
>       netdev_stats_to_stats64(nstat, &bp->dev->stats);
>=20
>    by:
>=20
>       for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queu=
e) {
>          u64_stats_fetch_begin(...);
>          nstat->rx_packets +=3D queue->stats.rx_packets;
>          nstat->tx_packets +=3D queue->stats.tx_packets;

you'd probably catch this when doing the real implementation but beware
of updating nstat directly in the fetch loop since the loop may retry

>          // ... same for all stats ...
>       }
>=20
>  - Also the struct name (struct queue_stats) deserves a driver prefix.
>=20
> Notice we don't drop tx_dropped from `ethtool -S`. It might be useful to
> get per-queue stats and it doesn't cost much. We need per-queue
> counters anyway, let's keep exposing them.

There's a dedicated API now for exposing pre-queue stats.=20
Since tx_dropped was always zero we can as well delete it from ethtool
-S and think about adding netdev queue stats in net-next

