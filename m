Return-Path: <netdev+bounces-299700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aek3AY6rMGppWAUAu9opvQ
	(envelope-from <netdev+bounces-299700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:49:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B9A68B565
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:49:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=YFK99coD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299700-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299700-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5073B30707FA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F4D37AA8C;
	Tue, 16 Jun 2026 01:48:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F828506F
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:48:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574537; cv=none; b=dw6jU2aJKs7QkKl3ZQ7C7B8TJd1pJm3aXJgO46dJVU6OM2avNP07/CuRYZ5OI+8ZXPVNuBIXAuyl1Q//JYZDP4M36tmIPTGtkJT0rxkm/0KkAnwonolzvLx3rLkD4IERv93ylcOTGbX8fhOWejkn95qJRZGY46wKRha/BhfHM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574537; c=relaxed/simple;
	bh=7XzaTINS1hJ1Lb5cVNmfOrlVwdiU2qOLDLUP7Onxwlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIjFpS2CiGjmXpp58SJR5l/vTSvU/ZbwDet6Y/hfyRer/LH8JgDXdhJw4suxm8dd3wm0Ef9bgORJoZYvPHGYX3wudVrZBN9JquYptaobPjkjDTn047iphzRhWZd5gWB0F6lJ+a9ggtIAP7gyvHc068iAo7Th3eGIuj6YLdxnoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YFK99coD; arc=none smtp.client-ip=95.215.58.186
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781574523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHUiwhB6MxO/dEKOjoHtoTJVpYMZ13oa1KW9nfW9n8w=;
	b=YFK99coDlLb66IZyZ/GSWrWiihMwrsMHY9bUpadDOzWix1wdKTNnEsYpchceVv/0hJ/aMm
	iIMttjX+aRPAMQoFK9aENpgrHug3nDQ4wLdjjHesS6O5PObwxapCey8U5x29rUrCfR+ZrT
	KnvTS5s9BvRilJ+xYKRChap/IiVDFPY=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 minhquangbui99@gmail.com, kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 eperezma@redhat.com
Subject: Re: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
Date: Tue, 16 Jun 2026 09:48:28 +0800
Message-ID: <y6i9tzXeQS-8Gft2xqLmIQ@linux.dev>
In-Reply-To: <1781491685.0613394-1-xuanzhuo@linux.alibaba.com>
References:
 <20260611025644.2431148-1-dongml2@chinatelecom.cn>
 <20260611025644.2431148-2-dongml2@chinatelecom.cn>
 <1781491685.0613394-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299700-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:minhquangbui99@gmail.com,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:eperezma@redhat.com,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55B9A68B565

On 2026/6/15 10:48 Xuan Zhuo <xuanzhuo@linux.alibaba.com> write:
> On Thu, 11 Jun 2026 10:56:43 +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > During packet receiving in virtio-net, the rq can be empty, which means
> > "rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
> > virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
> > can be empty too, which means we can't allocate anything from
> > xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.
> >
[...]
> >
> > +	need_wakeup = xsk_uses_need_wakeup(pool);
> >  	xsk_buffs = rq->xsk_buffs;
> >
> > +	/* If both rq->vq and fill ring are empty, and then the user submit
> > +	 * all the chunks to the fill ring and check the wake up flag
> > +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> > +	 * we will lose the chance to wake up the rx napi, so we have to
> > +	 * set the need_wakeup flag here.
> > +	 */
> > +	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
> > +		xsk_set_rx_need_wakeup(pool);
> 
> Is Condition A here too strict? We should trigger the wakeup under a wider range
> of scenarios.

Hi, Xuan. Thinks for your reviewing :)

The logic here is a addition logic to the origin wake up logic, which I planed
to fix a race condition. However, this race condition seems not likely to happen,
as we discussed in this thread:

https://lore.kernel.org/netdev/rHZz5_ylT4WggoZ-Ic2Q4w@linux.dev/

So this patch is not necessary, and I'll send the 2nd patch standalone.

Thanks!
Menglong Dong

> 
> > +
> >  	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> >  	if (!num) {
> > -		if (xsk_uses_need_wakeup(pool)) {
> > +		if (need_wakeup) {
> >  			xsk_set_rx_need_wakeup(pool);
> >  			/* Return 0 instead of -ENOMEM so that NAPI is
> >  			 * descheduled.
> > @@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
> >  		}
> >
> >  		return -ENOMEM;
> > -	} else {
> > -		xsk_clear_rx_need_wakeup(pool);
> >  	}
> >
> >  	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > @@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
> >  			goto err;
> >  	}
> >
> > +	if (need_wakeup) {
> > +		if (rq->vq->num_free)
> > +			/* We have free buffers, so we'd better wake up the
> > +			 * rx napi as soon as possible.
> > +			 */
> > +			xsk_set_rx_need_wakeup(pool);
> 
> Is the purpose of waking up RX NAPI to invoke try_fill_recv? However,
> virtnet_poll does not call try_fill_recv directly. it is done
> conditionally.
> 
> Thanks.
> 
> 
> > +		else
> > +			xsk_clear_rx_need_wakeup(pool);
> > +	}
> > +
> >  	return num;
> >
> >  err:
> > --
> > 2.54.0
> >
> 
> 




