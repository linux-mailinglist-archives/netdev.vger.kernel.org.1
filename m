Return-Path: <netdev+bounces-264779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF8cEdbOqmkNXQEAu9opvQ
	(envelope-from <netdev+bounces-264779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:55:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC034221283
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136EA313B4B3
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EAB38F23F;
	Fri,  6 Mar 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KSLV+Asz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441ED38F231;
	Fri,  6 Mar 2026 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801320; cv=none; b=MJC066tHkFSkr10YLFAEt10HKR6K8h8kePxHg0TkBPPEcqivOgq/QUHb7VC5sicw9ghnlZBhqEtQepHl8W54/U/+xEYcMCaZHnnMdIpFpLHIjPZILvf4zSB2a4kROI3kCU974QU+2qG0puMdIq2N2Jpk2Jc3F+Vo2z6WXMamwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801320; c=relaxed/simple;
	bh=qPicryEkwijXPwqofzoau04znhdrfvIHnu6/Pyv8VUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVihGVd7dXXnplZN/r+bv3cO7uB41wrjZLFJgFk/+vbevr61DUIqZT3ZLghXXc4iT2ZnoyoWk9jfipOI30NgKLHHgYtQbdh3BH4hvL8xGO74PyLdGHpbmxdQSqtNvtKguN92o3iPTh0hk2Bs8QJfMoxg3960Emt22roScN8NTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KSLV+Asz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC50A1A2D23;
	Fri,  6 Mar 2026 12:48:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEF445FF92;
	Fri,  6 Mar 2026 12:48:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C126103699D2;
	Fri,  6 Mar 2026 13:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772801310; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FkZSFQh+KvpketIOrBtEelxV6rwNiCRVKYCWCZUIhEw=;
	b=KSLV+Asz8WIYjHDBTLUnCDHxCh86N/EhI3LyQKwjdzdWns3qJQA4RavwYkb70hzWBNNCT4
	xKlaqWKEg0WCzgTZJU+/nb7YjDneVLt82ijLzRYw6FhNH02v1herHWe9vtJF4Ej4LkdCV6
	KnCWz6qxbFPOU/2NL661KQaOLbXrq8kDswrMXSgIaogUEhuOON/2mp4ITWIB5Ova+DcKq4
	YjJuJr4qZOPXlYPHq7eBRvw1PqCyT9RrmYvjFA0OSa346a9S6+dlf4VoePMBoMgRRIKQhx
	VtT66m1EHlvByauqhG/yS/af69G41C+sBtGmgh9/L4+AREexPyIfsVy+ljcRHw==
Message-ID: <74089907-d7d3-4242-92a5-909812779932@bootlin.com>
Date: Fri, 6 Mar 2026 13:48:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] net: macb: add Tx zero-copy AF_XDP support
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
 <20260304-macb-xsk-v1-8-ba2ebe2bdaa3@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260304-macb-xsk-v1-8-ba2ebe2bdaa3@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: BC034221283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264779-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Hi Théo,

On 04/03/2026 19:24, Théo Lebrun wrote:
> Add a new buffer type (to `enum macb_tx_buff_type`). Near the end of
> macb_tx_complete(), we go and read the XSK buffers using
> xsk_tx_peek_release_desc_batch() and append those buffers to our Tx
> ring.
> 
> Additionally, in macb_tx_complete(), we signal to the XSK subsystem
> number of bytes completed and conditionally mark the need_wakeup
> flag.
> 
> Lastly, we update XSK wakeup by writing the TCOMP bit in the per-queue
> IMR register, to ensure NAPI scheduling will take place.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

[...]

> +static void macb_xdp_xmit_zc(struct macb *bp, unsigned int queue_index, int budget)
> +{
> +	struct macb_queue *queue = &bp->queues[queue_index];
> +	struct xsk_buff_pool *xsk = queue->xsk_pool;
> +	dma_addr_t mapping;
> +	u32 slot_available;
> +	size_t bytes = 0;
> +	u32 batch;
> +
> +	guard(spinlock_irqsave)(&queue->tx_ptr_lock);
> +
> +	/* This is a hard error, log it. */
> +	slot_available = CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size);
> +	if (slot_available < 1) {
> +		netif_stop_subqueue(bp->dev, queue_index);
> +		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
> +			   queue->tx_head, queue->tx_tail);
> +		return;
> +	}
> +
> +	batch = min_t(u32, slot_available, budget);
> +	batch = xsk_tx_peek_release_desc_batch(xsk, batch);
> +	if (!batch)
> +		return;
> +
> +	for (u32 i = 0; i < batch; i++) {
> +		struct xdp_desc *desc = &xsk->tx_descs[i];
> +
> +		mapping = xsk_buff_raw_get_dma(xsk, desc->addr);
> +		xsk_buff_raw_dma_sync_for_device(xsk, mapping, desc->len);
> +
> +		macb_xdp_submit_buff(bp, queue_index, (struct macb_tx_buff){
> +			.ptr = NULL,
> +			.mapping = mapping,
> +			.size = desc->len,
> +			.mapped_as_page = false,
> +			.type = MACB_TYPE_XSK,
> +		});
> +
> +		bytes += desc->len;
> +	}
> +
> +	/* Make newly initialized descriptor visible to hardware */
> +	wmb();
> +	spin_lock(&bp->lock);
> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> +	spin_unlock(&bp->lock);

this lock is also taken in interrupt context, this should probably use a
irqsave/restore variant. Now, there are a few other parts of this driver
that use a plain spin_lock() call and except for the paths that actually
run in interrupt context, they don't seem correct to me :(

Maxime



