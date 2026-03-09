Return-Path: <netdev+bounces-265657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFFkFRX/rmkLLgIAu9opvQ
	(envelope-from <netdev+bounces-265657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:10:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3223D6A8
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A12603055961
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F242D0601;
	Mon,  9 Mar 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WgoNt6ez"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FBF2D239B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075857; cv=none; b=O6/m3zwa2PZggv8S7m2lzzJTeN3nVgRkKW3+pLrgvOMD5v0A4RdHrMD9tR/vNxIrt95HPqME6nIUbaBY7Vd3B/IS5poHLGMf3ShpzDi0nANUBTD9QhaXahFxJW6bwTzTIv+yFaKolkxO+4yyj7I1pozzsT/ngOaGbxAi78WkXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075857; c=relaxed/simple;
	bh=NiF6bFfgTim6jzSR75qsynoAVuuE+F+Fq0yIfiEY/kc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=dr/STvgyZbmOReKW6Orf/INLRrd1ZuVBXZHTjVlsvAJWUNXwU00GUDPhBaB8vSfi8n2wZPp/k2PYTJtAvDE3umgnJyMo8UUH50j72piU+D1qq7XVs0MdeEulfdczmf7UeMRvIdZLKV/M84fuKxVEk7vaOlx55JAGcI+T9/IgvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WgoNt6ez; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CED8A4E425DB;
	Mon,  9 Mar 2026 17:04:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A2A225FFB8;
	Mon,  9 Mar 2026 17:04:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D923910369BCE;
	Mon,  9 Mar 2026 18:04:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773075850; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kHhouP4qyGD8tDVu8tvq9+4XEQtGMkz7O9rBI79x4X8=;
	b=WgoNt6ezw9NfGRY0PQGcHBq0PYT+vZRCnsAYB19frTRJMUCf55cylecWelc6ALxrFH/Opi
	l7J2I5Spj+a7nCcHLz6uWkHnHSfdHInKIKguxjHOx76q12/eXZh6WlDg8u5O1k/FKF/mlC
	TwbYCvMvd/lwgtao+do5IpTpBOrpu1QCjDffYrmtXsnv3wMQd7yHR/IYmtrcJzZka0+r5A
	LJ1fq2kQ/oGgnR9eGAOMai0Mltn+PqMq7W1zin/m5gl4jpRtumIX9RlgFmD1FxPpXfSu0Y
	9C2KJ9z2qE3bRWcaQcX6qvn7ye8LM2q8KCSUTPJrgghe+eEqs563CZ1hk9Z4Yg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 18:04:06 +0100
Message-Id: <DGYEXIY7VNHX.1IUJHFGOJ1B9S@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Paolo Valerio"
 <pvalerio@redhat.com>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
 <20260305-macb-set-channels-v1-1-28e3a96a3dc3@bootlin.com>
 <20260306190948.44d23f8f@kernel.org>
In-Reply-To: <20260306190948.44d23f8f@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: AEF3223D6A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:url,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat Mar 7, 2026 at 4:09 AM CET, Jakub Kicinski wrote:
> On Thu, 05 Mar 2026 18:20:14 +0100 Th=C3=A9o Lebrun wrote:
>> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
>> +		return -EOPNOTSUPP;
>
> Why not set max to 1 in this case?

With !QUEUE_DISABLE, we only know how to run with all queues enabled.
It doesn't imply that max_num_queues =3D=3D 1.

MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE (BIT0) in the
per-queue register RBQP disables queue Rx. If we don't have that
capability we can have multiple queues (if HW supports it) but we must
always run with all enabled.

The correct way to deal with `!(bp->caps & MACB_CAPS_QUEUE_DISABLE)`
would be something like:

static void macb_get_channels(struct net_device *netdev,
			      struct ethtool_channels *ch)
{
	struct macb *bp =3D netdev_priv(netdev);

	ch->max_combined =3D bp->max_num_queues;
	ch->combined_count =3D bp->num_queues;

	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
		/* we know how disable individual queues */
		ch->min_combined =3D 1;
	else
		/* we only support running with all queues active */
		ch->min_combined =3D bp->max_num_queues;
}

But ch->min_combined does not exist.

>
>> +	if (!count || ch->rx_count || ch->tx_count)
>> +		return -EINVAL;
>
> Core should check this for you already
>
>> +	if (count > bp->max_num_queues)
>> +		return -EINVAL;
>
> and this

Noted thanks!

>> +	if (count =3D=3D old_count)
>> +		return 0;
>> +
>> +	if (running)
>> +		macb_close(bp->dev);
>> +
>> +	bp->num_queues =3D count;
>> +	netif_set_real_num_queues(bp->dev, count, count);
>> +
>> +	if (running) {
>> +		ret =3D macb_open(bp->dev);
>> +		if (ret) {
>> +			bp->num_queues =3D old_count;
>> +			netif_set_real_num_queues(bp->dev, old_count, old_count);
>> +			macb_open(bp->dev);
>
> both macb_open() calls may fail under memory pressure
> For new functionality we ask drivers to allocate all necessary
> resources upfront then just swap them in and reconfigure HW

The main reason we want to set queue count is memory savings. If we take
the Mobileye EyeQ5 SoC, it has a small 32MiB RAM alias usable for DMA.
If we waste it on networking we have less available for the remaining
peripherals. Is there some way we could avoid upfront allocations?

.set_ringparam() can help to avoid memory waste by using many small
queues. But our main target config is a single large queue (common with
AF_XDP zero-copy when userspace wants a single socket). In that case we
waste `(max_num_queues - 1) / max_num_queues` percent: 75% with
max_num_queues=3D4 on Mobileye EyeQ5 & EyeQ6H, ie Mobileye boards on my
desk at the moment.

I wonder if we'll see GEM IPs that have >4 queues. HW manual indicates
up to 16 is supported.

Thanks Jakub,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

