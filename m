Return-Path: <netdev+bounces-274572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHf2LKx6zmmMnwYAu9opvQ
	(envelope-from <netdev+bounces-274572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:18:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4F38A5C3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C9FC30F005D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C12D949C;
	Thu,  2 Apr 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mTUnTzsy"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE83E715C;
	Thu,  2 Apr 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139092; cv=none; b=iyrBODHKlxiRzcmZwMDJyeTT5Tee2hO5eqOWpUlGNoXkQs/ZJDhpSsOr9BHhauY/iM7F/QKNjKkEtcZjWYPpQZECKl0SyVn/YHkgQqXMQp6oDtcagZ+z/l39g+FDz5R9zhnMsBErTGxf07n7mO1eFvEX1Ng5QlFm4umgvqjJng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139092; c=relaxed/simple;
	bh=vSvOJMywDX1Dp4g8jKCdfWkYlFrhYqz4NkTXZxOL6mM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VrO44iXHmDk4F3u3gsIytWSLV5aASwhKpHqT9mkmCfM33bbq0R0ffPY2J6axRC+Z0Opv+CncCFNHRZaoT8fQI18p80qQtCYhFnLAE7jDcJMpX0sV648KoCZ1mqCJUv41pIHjSzVrS4Y9R5B4UsKeLog7/9dPDGYdPMX1zq10GI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mTUnTzsy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0DF281A30FB;
	Thu,  2 Apr 2026 14:11:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CDBA95FDEB;
	Thu,  2 Apr 2026 14:11:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 409F410450264;
	Thu,  2 Apr 2026 16:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775139085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F+1R4q8i6GJ7YHYI0qiErpl7+oF0W1MmTLsQ9Hqk7x8=;
	b=mTUnTzsyKsL7bqQhm4KFzonWj0QwypgK7cO+GGKuk1SMX8BWV6zJmMypHbmP6/OPiUJ6Gj
	XGV2IZvS88+SUQwKLr0g8R+58PeavkILrbVgOZ1TTDRRwQVtHJO7yPClg2ZN6RvXUYtVja
	sPCEijf0sUCvFjD1ow0DQl+BQeV3KIlRoyPM7A1Luuy5/gvVmuDk6gg9oOq3Gto55VUMxS
	+SPoEewMPl6RBRVee6oX4+CVYWSlkQ6hBAss+am2xJbHSj7ngcU3pPfAFGCCinKkCk+FEA
	BpVozzZGyZRnEJyR76YRrOi4KS7Mw3qDqGN+W/kFwEl/85e93uyBi06FcAdLiA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 16:11:21 +0200
Message-Id: <DHIQAC7SA3E0.2U7L5MI8IQ4SH@bootlin.com>
Subject: Re: [PATCH net-next 06/11] net: macb: introduce macb_context struct
 for buffer management
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "Paolo Valerio" <pvalerio@redhat.com>, "Conor
 Dooley" <conor@kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-6-9590c5ab7272@bootlin.com>
 <70b176b84fbff4a57d7f6be5f42fc753@tipi-net.de>
In-Reply-To: <70b176b84fbff4a57d7f6be5f42fc753@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274572-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,mobileye.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: 23A4F38A5C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Apr 2, 2026 at 1:22 PM CEST, Nicolai Buchwitz wrote:
> On 1.4.2026 18:39, Th=C3=A9o Lebrun wrote:
>> Whenever an operation requires buffer realloc, we close the interface,
>> update parameters and reopen. To improve reliability under memory
>> pressure, we should rather alloc new buffers, reconfigure HW and free
>> old buffers. This requires MACB to support having multiple "contexts"
>> in parallel.
>>=20
>> Introduce this concept by adding the macb_context struct, which owns=20
>> all
>> queue buffers and the parameters associated. We do not yet support
>> multiple contexts in parallel, because all functions access bp->ctx
>> (the currently active context) directly.
>>=20
>> Steps:
>>=20
>>  - Introduce `struct macb_context` and its children `struct macb_rxq`
>>    and `struct macb_txq`. Context fields are stolen from `struct macb`
>>    and rxq/txq fields are from `struct macb_queue`.
>>=20
>>    Making it two separate structs per queue simplifies accesses: we=20
>> grab
>>    a txq/rxq local variable and access fields like txq->head instead of
>>    queue->tx_head. It also anecdotally improves data locality.
>>=20
>>  - macb_init_dflt() does not set bp->ctx->{rx,tx}_ring_size to default
>>    values as ctx is not allocated yet. Instead, introduce
>>    bp->configured_{rx,tx}_ring_size which get updated on user requests.
>>=20
>>  - macb_open() starts by allocating bp->ctx. It gets freed in the
>>    open error codepath or by macb_close().
>>=20
>>  - Guided by compile errors, update all codepaths. Most diff is=20
>> changing
>>    `queue->tx_*` to `txq->*` and `queue->rx_*` to `rxq->*`, with a new
>>    local variable. Also rx_buffer_size / rx_ring_size / tx_ring_size
>>    move from bp to bp->ctx.
>>=20
>>    Introduce two helpers macb_tx|rx() functions to convert macb_queue
>>    pointers.
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.h      |  49 ++--
>>  drivers/net/ethernet/cadence/macb_main.c | 442=20
>> ++++++++++++++++++-------------
>>  2 files changed, 296 insertions(+), 195 deletions(-)
>>=20
>
>> [...]
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index d5023fdc0756..0f63d9b89c11 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
>> [...]
>
>> @@ -3596,14 +3677,15 @@ static void macb_get_regs(struct net_device=20
>> *netdev, struct ethtool_regs *regs,
>>  			  void *p)
>>  {
>>  	struct macb *bp =3D netdev_priv(netdev);
>> +	struct macb_txq *txq =3D &bp->ctx->txq[0];
>
> bp->ctx is NULL when the interface is down. This will crash if
> ethtool -d is called while the interface is not running. Same
> issue below in macb_get_ringparam().

Agreed. Will check if context is alive and use default values otherwise.
Something like this for V2:

static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *r=
egs,
			  void *p)
{
	dma_addr_t tx_dma_tail =3D 0, tx_dma_head =3D 0;
	struct macb *bp =3D netdev_priv(netdev);
	unsigned int tail =3D 0, head =3D 0;
	struct macb_txq *txq;
	u32 *regs_buff =3D p;

	regs->version =3D (macb_readl(bp, MID) & ((1 << MACB_REV_SIZE) - 1))
			| MACB_GREGS_VERSION;

	if (bp->ctx) {
		txq =3D &bp->ctx->txq[0];
		tail =3D macb_tx_ring_wrap(bp->ctx, txq->tail);
		head =3D macb_tx_ring_wrap(bp->ctx, txq->head);
		tx_dma_tail =3D macb_tx_dma(&bp->queues[0], tail);
		tx_dma_head =3D macb_tx_dma(&bp->queues[0], head);
	}

	regs_buff[0]  =3D macb_readl(bp, NCR);
	regs_buff[1]  =3D macb_or_gem_readl(bp, NCFGR);
	regs_buff[2]  =3D macb_readl(bp, NSR);
	regs_buff[3]  =3D macb_readl(bp, TSR);
	regs_buff[4]  =3D macb_readl(bp, RBQP);
	regs_buff[5]  =3D macb_readl(bp, TBQP);
	regs_buff[6]  =3D macb_readl(bp, RSR);
	regs_buff[7]  =3D macb_readl(bp, IMR);

	regs_buff[8]  =3D tail;
	regs_buff[9]  =3D head;
	regs_buff[10] =3D tx_dma_tail;
	regs_buff[11] =3D tx_dma_head;

	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED))
		regs_buff[12] =3D macb_or_gem_readl(bp, USRIO);
	if (macb_is_gem(bp->caps))
		regs_buff[13] =3D gem_readl(bp, DMACFG);
}

>
>>  	unsigned int tail, head;
>>  	u32 *regs_buff =3D p;
>>=20
>>  	regs->version =3D (macb_readl(bp, MID) & ((1 << MACB_REV_SIZE) - 1))
>>  			| MACB_GREGS_VERSION;
>>=20
>> -	tail =3D macb_tx_ring_wrap(bp, bp->queues[0].tx_tail);
>> -	head =3D macb_tx_ring_wrap(bp, bp->queues[0].tx_head);
>> +	tail =3D macb_tx_ring_wrap(bp, txq->tail);
>> +	head =3D macb_tx_ring_wrap(bp, txq->head);
>>=20
>>  	regs_buff[0]  =3D macb_readl(bp, NCR);
>>  	regs_buff[1]  =3D macb_or_gem_readl(bp, NCFGR);
>> @@ -3682,8 +3764,8 @@ static void macb_get_ringparam(struct net_device=
=20
>> *netdev,
>>  	ring->rx_max_pending =3D MAX_RX_RING_SIZE;
>>  	ring->tx_max_pending =3D MAX_TX_RING_SIZE;
>>=20
>> -	ring->rx_pending =3D bp->rx_ring_size;
>> -	ring->tx_pending =3D bp->tx_ring_size;
>> +	ring->rx_pending =3D bp->ctx->rx_ring_size;
>> +	ring->tx_pending =3D bp->ctx->tx_ring_size;
>
> Same NULL ctx issue as above. This one could just read from
> bp->configured_{rx,tx}_ring_size instead.

Agreed with the fix, easy one.

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


