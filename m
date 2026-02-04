Return-Path: <netdev+bounces-256686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGjQBNw2g2kwjAMAu9opvQ
	(envelope-from <netdev+bounces-256686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:09:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DB5E595C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2254D30276B9
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983203D9045;
	Wed,  4 Feb 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i69LGXaw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8628727F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206576; cv=none; b=GR2A34pLwre0zpPtqlLgumiHxOjhFuiZJettCQRf98csjo8lHMTt7PJibMtOR2tT/jfC32spfx/zJDKdYLZQHXiRtx1HjZeQHa6SqcLUvKiN98hMISi8zE6HufEcvjFHjjd4eSGk01VUvjLEQb4JEdVnYSgS2zr42UvjbKoNDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206576; c=relaxed/simple;
	bh=3ywqktAHwas+gjtottmC7MLNDdcnrWVO6DGDzrzNQD0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=rcOKk+PMpICTOkDDxdLfIqOX6uxI3mkl6/3Q7ubKZN0BPJyaJ9fa3dce5Us9CgoLbOWcIFUZpgp8sZmR7BqW3QYKptlKYyAESQcuK+Z/zHuR4tMlgAmPNN5xoOkvL8ORid63vnJYD6E2XYtZhP/RYclI9XjftKR8JCPR6Xu/wGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i69LGXaw; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770206567; h=Message-ID:Subject:Date:From:To;
	bh=YqQDW6R62ey1uY1RoAvvQNpAMqZuUf05gtPjECXDXqg=;
	b=i69LGXawsDCOjoL92ASIIZ5C582mWR3e/uIei7oe5NrlB6aSO1v7XDJyesWMIc2kcd8HKPGh0J7UtEEDZYNEYOT1i73xX9EVHPGt+Js4cnnEAnxAQFVMR96WLPInJoR3bDAAXlVqe62SusLgEzjDmiOaveAXJe4CpTOW5vi138Q=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WyWuRXF_1770206566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Feb 2026 20:02:46 +0800
Message-ID: <1770205572.2731752-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [net-next,v25,4/6] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Wed, 4 Feb 2026 19:46:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: lorenzo@kernel.org,
 andrew+netdev@lunn.ch,
 pabeni@redhat.com,
 vadim.fedorenko@linux.dev,
 davem@davemloft.net,
 guwen@linux.alibaba.com,
 lulie@linux.alibaba.com,
 hkallweit1@gmail.com,
 edumazet@google.com,
 lukas.bulwahn@redhat.com,
 andrew@lunn.ch,
 dong100@mucse.com,
 dust.li@linux.alibaba.com,
 netdev@vger.kernel.org
References: <20260202090638.46836-1-xuanzhuo@linux.alibaba.com>
 <20260202090638.46836-5-xuanzhuo@linux.alibaba.com>
 <20260204040054.1698677-2-kuba@kernel.org>
 <20260203201237.35c5f756@kernel.org>
In-Reply-To: <20260203201237.35c5f756@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,redhat.com,linux.dev,davemloft.net,linux.alibaba.com,gmail.com,google.com,mucse.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256686-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81DB5E595C
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 20:12:37 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue,  3 Feb 2026 20:00:55 -0800 Jakub Kicinski wrote:
> > > +	err = enet_bind_new_q_and_cfg(enet, ctx);
> > > +	if (err) {
> > > +		netdev_err(enet->netdev,
> > > +			   "eea reset: bind new queues failed. err %d\n",
> > > +			   err);
> > > +
> > > +		return err;
> > > +	}
> >
> > When enet_bind_new_q_and_cfg() fails, what happens to the queues allocated
> > by eea_alloc_rxtx_q_mem() at line 289? They're now assigned to ctx->rx and
> > ctx->tx but haven't been bound to enet yet.
> >
> > After eea_netdev_stop() sets enet->started = false, a subsequent call to
> > eea_netdev_stop() will return early at line 228 without calling
> > eea_free_rxtx_q_mem(). If enet_bind_new_q_and_cfg() fails before binding,
> > the queues remain in ctx with no cleanup path.
> >
> > The comment suggests deferring cleanup to "normal NIC cleanup" but
> > eea_net_remove() doesn't call eea_free_rxtx_q_mem(), and future reset
> > attempts would allocate new queues without freeing these.
>
> I think AI is slightly confused here but so am I. I don't get where you
> free he previous resources in this flow. The "bind_new_q_and_cfg" just
> overrides stuff, who frees the old set of rings?


	err = eea_alloc_rxtx_q_mem(ctx);
	if (err) {
		netdev_warn(enet->netdev,
			    "eea reset: alloc q failed. stop reset. err %d\n",
			    err);
		return err;
	}

	eea_netdev_stop(enet->netdev); <---- here call eea_free_rxtx_q_mem

	err = enet_bind_new_q_and_cfg(enet, ctx);
	if (err) {
		netdev_err(enet->netdev,
			   "eea reset: bind new queues failed. err %d\n",
			   err);

		return err;
	}

	err = eea_active_ring_and_irq(enet);
	if (err) {
		netdev_err(enet->netdev,
			   "eea reset: active new ring and irq failed. err %d\n",
			   err);
		return err;
	}

	eea_start_rxtx(enet->netdev);

>
> Also as I already mentioned in previous manual review you are not
> pre-allocating enough. You should also request necessary extra IRQs
> _before_ you start tearing down the old state.


I might have misunderstood your point; I will implement it that way in the next
version.

Thanks.

>
> > > +static struct sk_buff *eea_rx_build_split_hdr_skb(struct eea_net_rx *rx,
> > > +						  struct eea_rx_ctx *ctx)
> > > +{
> > > +	struct eea_rx_meta *meta = ctx->meta;
> > > +	struct sk_buff *skb;
> > > +	u32 truesize;
> > > +
> > > +	dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
> > > +				ctx->hdr_len, DMA_FROM_DEVICE);
> > > +
> > > +	skb = napi_alloc_skb(&rx->napi, ctx->hdr_len);
> > > +	if (unlikely(!skb))
> > > +		return NULL;
> > > +
> > > +	truesize = meta->headroom + ctx->len;
> > > +
> > > +	skb_put_data(skb, ctx->meta->hdr_addr, ctx->hdr_len);
> > > +
> > > +	if (ctx->len) {
> > > +		skb_add_rx_frag(skb, 0, meta->page,
> > > +				meta->offset + meta->headroom,
> > > +				ctx->len, truesize);
> > > +
> > > +		eea_consume_rx_buffer(rx, meta, truesize);
> > > +	}
> >
> > Is the truesize calculation correct for split header mode? Looking at line
> > 255, truesize is calculated as meta->headroom + ctx->len.
> >
> > In eea_rx_post() at line 500, buffers are allocated with space for
> > [headroom][data][tailroom], where tailroom is typically 128 bytes for
> > skb_shared_info. The tailroom is reserved but not included in the truesize
> > calculation here.
> >
> > When eea_consume_rx_buffer() advances meta->offset by only
> > (headroom + data_len), the reserved tailroom space remains unconsumed. After
> > alignment in meta_align_offset(), the next fragment may overlap with the
> > previous fragment's tailroom space.
> >
> > Compare with the non-split header path in eea_rx_build_skb() at line 290,
> > which includes shinfo_size in truesize:
> >
> >     truesize = meta->headroom + ctx->len + shinfo_size;
> >
> > Should the split header path also include meta->tailroom or shinfo_size in
> > the truesize calculation?
>
> This one - I think the AI is just confused by how frags work.
>

