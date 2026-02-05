Return-Path: <netdev+bounces-256906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kzVXFY75g2nwwQMAu9opvQ
	(envelope-from <netdev+bounces-256906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:59:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC706EDCF2
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 404173006B6A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102B29992B;
	Thu,  5 Feb 2026 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Alxs/MLo"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D486EEBA
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770256778; cv=none; b=TisGh0xKlODI0wMP83Mdu/DnuRNGJJMhCkiAN6FsxT7aK22K6HcPvmQzcWdoqN8daBpvi/fI/5JOP2Zh66OQCxcW2hrMn2GRKN3nnMyscyzUmqpB50A+GolQK81XAADa1x8607TvNDo0nfA43wiOzTQfogVLZgLdLr5yKQ9KX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770256778; c=relaxed/simple;
	bh=jFxj8iSbohr5VOpph7O15cEl6DvfO14RjYXtupblvW4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Z4iPxb9xzyeleaJqW80j2+52nSfJMEm2BUQKkWWS137xaLF8dYloxiAFIJpqQOP4OgAigeokldpBfohXTICvOVW3/V+VRI3F1LjoDNMgMQYHdj/xIH//tr8kvVP6p9V0a31BYBHoiqylQs4LFSikoG35D2yI2c280s34HQyp/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Alxs/MLo; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770256768; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=hQ/mDfuMMJCo56jWoAqCdKRmfuI3JnLWh7cg3t9eN5M=;
	b=Alxs/MLo7ufjBdLedYHX0v4uKZgFIOWRFgjG+fwtKHEuOUnsUKM6F4oWWbtszwIZNtO6WOFpud9GyR3mDb4/iHG4Wm/chmcDKnLduipphgAkBnU9G6Ce+baNBCjmnz+f/ZhhI6voD8PbX5u3aPlyaKZWHTyRMvPMQC261D9NEHo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WyZ2Djo_1770256766 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Feb 2026 09:59:27 +0800
Message-ID: <1770256081.5424275-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [net-next,v25,4/6] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Thu, 5 Feb 2026 09:48:01 +0800
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,redhat.com,linux.dev,davemloft.net,linux.alibaba.com,gmail.com,google.com,mucse.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: DC706EDCF2
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 20:12:37 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue,  3 Feb 2026 20:00:55 -0800 Jakub Kicinski wrote:
> > > +	err =3D enet_bind_new_q_and_cfg(enet, ctx);
> > > +	if (err) {
> > > +		netdev_err(enet->netdev,
> > > +			   "eea reset: bind new queues failed. err %d\n",
> > > +			   err);
> > > +
> > > +		return err;
> > > +	}
> >
> > When enet_bind_new_q_and_cfg() fails, what happens to the queues alloca=
ted
> > by eea_alloc_rxtx_q_mem() at line 289? They're now assigned to ctx->rx =
and
> > ctx->tx but haven't been bound to enet yet.
> >
> > After eea_netdev_stop() sets enet->started =3D false, a subsequent call=
 to
> > eea_netdev_stop() will return early at line 228 without calling
> > eea_free_rxtx_q_mem(). If enet_bind_new_q_and_cfg() fails before bindin=
g,
> > the queues remain in ctx with no cleanup path.
> >
> > The comment suggests deferring cleanup to "normal NIC cleanup" but
> > eea_net_remove() doesn't call eea_free_rxtx_q_mem(), and future reset
> > attempts would allocate new queues without freeing these.
>
> I think AI is slightly confused here but so am I. I don't get where you
> free he previous resources in this flow. The "bind_new_q_and_cfg" just
> overrides stuff, who frees the old set of rings?
>
> Also as I already mentioned in previous manual review you are not
> pre-allocating enough. You should also request necessary extra IRQs
> _before_ you start tearing down the old state.

Regarding this point, I did some experimentation and believe there are seve=
ral
issues. First, since request_irq requires passing the RX structure as callb=
ack
data, we cannot reuse the same IRQ directly=C3=A2=E2=82=AC=E2=80=9Dwe must =
first free the existing
IRQ and then request a new one. To safely free an IRQ, the most reasonable
approach is to stop the backend NIC's operations before releasing the IRQ. =
This
constraint means we can only free the IRQ after tearing down the NIC. I've
reviewed implementations of other NIC drivers, and they generally follow si=
milar
logic.

Moreover, I believe it would be quite difficult to achieve this with only m=
inor
modifications. In the future, we might consider introducing a proxy or an
intermediate structure to serve as the IRQ callback data, which could enabl=
e IRQ
reuse. However, that would likely require more substantial changes. Given t=
hat
we've already done extensive review and refinement, I'd prefer to avoid
introducing major refactoring at this stage.

Thanks.



>
> > > +static struct sk_buff *eea_rx_build_split_hdr_skb(struct eea_net_rx =
*rx,
> > > +						  struct eea_rx_ctx *ctx)
> > > +{
> > > +	struct eea_rx_meta *meta =3D ctx->meta;
> > > +	struct sk_buff *skb;
> > > +	u32 truesize;
> > > +
> > > +	dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
> > > +				ctx->hdr_len, DMA_FROM_DEVICE);
> > > +
> > > +	skb =3D napi_alloc_skb(&rx->napi, ctx->hdr_len);
> > > +	if (unlikely(!skb))
> > > +		return NULL;
> > > +
> > > +	truesize =3D meta->headroom + ctx->len;
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
> > Is the truesize calculation correct for split header mode? Looking at l=
ine
> > 255, truesize is calculated as meta->headroom + ctx->len.
> >
> > In eea_rx_post() at line 500, buffers are allocated with space for
> > [headroom][data][tailroom], where tailroom is typically 128 bytes for
> > skb_shared_info. The tailroom is reserved but not included in the trues=
ize
> > calculation here.
> >
> > When eea_consume_rx_buffer() advances meta->offset by only
> > (headroom + data_len), the reserved tailroom space remains unconsumed. =
After
> > alignment in meta_align_offset(), the next fragment may overlap with the
> > previous fragment's tailroom space.
> >
> > Compare with the non-split header path in eea_rx_build_skb() at line 29=
0,
> > which includes shinfo_size in truesize:
> >
> >     truesize =3D meta->headroom + ctx->len + shinfo_size;
> >
> > Should the split header path also include meta->tailroom or shinfo_size=
 in
> > the truesize calculation?
>
> This one - I think the AI is just confused by how frags work.
>

