Return-Path: <netdev+bounces-280984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJqZGQBY62nkKwAAu9opvQ
	(envelope-from <netdev+bounces-280984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:46:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49D45DF83
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E7A33002F77
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9033BBA12;
	Fri, 24 Apr 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zm8A+H/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8D2E541F
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031163; cv=none; b=H/u7uKlRxdMelv3D6f83L9sDUUldYwSA0CwJN5cxFK0Fci5suHjR+tAhdwqAIoMbtOrFx7LHGR5g4uVk1LSJwmRljTOx/bS92ckbd1FOuR4OIr9OAkYjGgwr/WLjyjVSIdsmXiYlBhTRGRJevuysphwHVld1Uv9dU4q23QIyUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031163; c=relaxed/simple;
	bh=iG6kvuYKy4PVgX6KxrGZO2O/x6Whpm5n/sKQKAGIJxU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=H54SaT+784urlhIbwgAC5z1jsy/Eu9ig6c1oE4m0fb3D+R8jMlPcd7YrzHU6peckTIl+/BYg9IpPBCCjvStnnAURaOPIjfdaZD55OTXLRSl7ElzBh+pPboolkvZb6UZ1rlZl6xGrwG8OfdPyWudh+HivRkIkX8QmOYoVezkZ7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zm8A+H/G; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CEDC11A33EE;
	Fri, 24 Apr 2026 11:45:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93151604EB;
	Fri, 24 Apr 2026 11:45:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1541D107207E5;
	Fri, 24 Apr 2026 13:45:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777031157; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n+VWjQO83UQsDt3zzbFqqJvhoTr5kbeVeca5EVj2Kzg=;
	b=Zm8A+H/G/mP+m/lJfEbKMNNEsh7ZTRxaZ/BsoEqENX5whrSqtijGjPRJseNoHlXH6rFyfp
	hJRRuQKDhP8rP8KnM1rm2WSZrhjnLQhRLvhJ8g/j/NMwvnxPlaa9Uup4lt95kS1CxIybzH
	fjMczj13C8qUSAGslnJ9UrG/2jn6pEMEa21rT+7VW8KiDoRBb2j/JUMbVUmNmqouhErhCd
	fLk1NEUhVIu9EEQCuzuvthhZOIAfFXf8YBo4wkEZNWE7Dq1Sb9EOsOh4RnECC30dxj7AeA
	m9uhi8ntKLaLAgjzfu4FTrr8L4Zd6scQFnwm/Ge1NMLpBFustwGP1pIbB0q/3g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 13:45:43 +0200
Message-Id: <DI1CYTCTJVH5.38AMR1X2NPLR@bootlin.com>
Subject: Re: [PATCH net] net: macb: drop in-flight Tx SKBs on close
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Haavard Skinnemoen" <hskinnemoen@atmel.com>, "Jeff Garzik"
 <jeff@garzik.org>, "Paolo Valerio" <pvalerio@redhat.com>, "Conor Dooley"
 <conor@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com>
 <1030f36978e299123c914917a15b934b@tipi-net.de>
In-Reply-To: <1030f36978e299123c914917a15b934b@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8E49D45DF83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280984-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello Nicolai,

On Fri Apr 24, 2026 at 12:30 PM CEST, Nicolai Buchwitz wrote:
> On 24.4.2026 12:01, Th=C3=A9o Lebrun wrote:
>> [...]
>
>>=20
>>  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> +		dropped =3D CIRC_CNT(queue->tx_head, queue->tx_tail,
>> +				   bp->tx_ring_size);
>> +		queue->stats.tx_dropped +=3D dropped;
>> +		bp->dev->stats.tx_dropped +=3D dropped;
>
> AFAIUI CIRC_CNT counts descriptor slots, not packets. A fragmented
> skb uses multiple slots so tx_dropped would be overcounted?

Ah yes, agreed. dropped is the count of !!macb_tx_skb(queue, tail)->skb.

>> +		for (tail =3D queue->tx_tail; tail !=3D queue->tx_head; tail++)
>> +			macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
>
> I might be missing something, but couldn't this crash on the
> macb_alloc_consistent() -> out_err path after a previous close
> with in-flight frames?
>
> 1. First close: the new loop runs and frees skbs, but tx_head and
>     tx_tail are not reset. kfree(tx_skb) sets it to NULL.
> 2. Second open: macb_alloc_consistent() fails early (e.g. the tx
>     dma_alloc_coherent on the first line) and jumps to out_err.
> 3. macb_free_consistent() runs again. CIRC_CNT is non-zero (stale
>     from previous session). macb_tx_skb() dereferences queue->tx_skb
>     which is NULL.
>
> Or if the failure happens later, the loop would iterate over a
> freshly kmalloc'd (uninitialized) tx_skb array and macb_tx_unmap()
> would read garbage mapping/skb pointers.
>
> Maybe reset tx_head =3D tx_tail =3D 0 after the loop, or guard with
> if (queue->tx_skb)?

Ah yes, guarding on queue->tx_skb sounds good for the error case of
macb_alloc_coherent(). I didn't notice we could land in free with
queue->tx_skb NULL. But it is also surprising to keep stall head/tail
cursors. I'll probably reset them as well for V2.

So along the lines of:

static void macb_free_consistent(struct macb *bp)
{
	// ... as before ...

	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) {
		if (queue->tx_skb) {
			for (tail =3D queue->tx_tail; tail !=3D queue->tx_head; tail++) {
				if (macb_tx_skb(queue, tail)->skb)
					dropped++;
				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
			}

			queue->stats.tx_dropped +=3D dropped;
			bp->dev->stats.tx_dropped +=3D dropped;

		}

		kfree(queue->tx_skb);
		queue->tx_skb =3D NULL;
		queue->tx_head =3D 0;
		queue->tx_tail =3D 0;
		queue->tx_ring =3D NULL;
		queue->rx_ring =3D NULL;
	}
}

Thanks for the swift review!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


