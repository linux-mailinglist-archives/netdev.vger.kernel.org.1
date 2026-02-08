Return-Path: <netdev+bounces-257862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PsudAYzeiGnWxgQAu9opvQ
	(envelope-from <netdev+bounces-257862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 20:05:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9EF109F61
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 20:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B12C7300C588
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D302DB7B9;
	Sun,  8 Feb 2026 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9k97C03";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="anP+Wse6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0E2512FF
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770577543; cv=none; b=aJXsp1rLVXwG78VTbWf5/EvTRP9iA4/jIgBBpoWsCgMlUV1SpwbsL2zIychRGXSc8s79RlodWYPkQ6ArN6VvhO0+RiIOLMSGo1fSGWU5tR9tDRzjjPMR7VpPj33NQAaiMaaNmhQZpuceygp5zQ9WSKEjuzlZwpAE9/cReZdjl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770577543; c=relaxed/simple;
	bh=mF0X2Z97liRTLoxb/+A5+gHzHT35lBKEAoOIYWN6zZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPOO6UfPQ4vkk4s4IAf6OA7TsZKRsPiRmF4lQnPHBkzlWYPAC44cmvBmH4yjI2c9Cems4RIRQbYiF8OBueQ/18Sf14fylAMznwGCxBi6+0xcTONaGXuBCQP8Upty3iKqN7pZk+KyobFzv/VsnRkLmKKDHeSVSmkupMNZh1ehf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9k97C03; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=anP+Wse6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770577542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAUbNWFcWqBaeICgPVBiAHTHjnBn8lRT7FGSkP8LuE4=;
	b=X9k97C032cxdQo2ywXyVR6ufotdwUVmRxAa2edyetzijRNEPvS47ENFKd/nob1hOG7uf79
	0GffK7bSuWrWODPbT0BshcEB3kRIn6WWE9YGtnnrFhKC5gjer1tvuG0Y5Gc8fDDtPjQLnj
	w3/quS6jlREzD8xu36vf/HTp+kVOUxI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-L9H5fJdQOSa669u88DvF1Q-1; Sun, 08 Feb 2026 14:05:41 -0500
X-MC-Unique: L9H5fJdQOSa669u88DvF1Q-1
X-Mimecast-MFC-AGG-ID: L9H5fJdQOSa669u88DvF1Q_1770577540
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so19007415e9.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770577540; x=1771182340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JAUbNWFcWqBaeICgPVBiAHTHjnBn8lRT7FGSkP8LuE4=;
        b=anP+Wse6vi1oSbT6rM34wi4Cx719SOLeqlupQX8+w6bgJjUGIqTaXXaPVMiqqTgd37
         Nj2e+BUBFtwdmL+5zeHEIJxdPjXOwr3/LvChh83uZzTOKU0j0n/OCqMYTeEPPDvhHuMa
         m93kSHkWjgtBzjqUT0XSfEjsoY2iQ1csqaX/j8weCVbWX2GQu5a1q0BvgsRYONErvAl2
         BBdhGswZJsOpSSwqocaI3bX9zDarrWTwSTIgPqs2YfKYbzBTYS0k+dIKSND5b0RJN3nc
         hau6NVNiny+wOeexmMTJAeMB9aNeZZ65ewR3Bxs8MhEGC/o8eTLuT7WM/emjy6ls2JCr
         rYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770577540; x=1771182340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAUbNWFcWqBaeICgPVBiAHTHjnBn8lRT7FGSkP8LuE4=;
        b=ar5PqyQLqtWyvd7NVeybplDjmCfz8W342PSZgAQwpLGYUsIIrkJjojri74j08ge2D2
         ztJnxu95mVNtd0A9d2MTjjKc9X6TrzsTTfUiHUkwPyBUufUFjNo4sgadVNkzAKIMRaF6
         ZyfkVf6f+lXiK6SV8m3s3ieZLLidQE6Ui99uF0V6CbvV0OR012T9O8GTQfIq3fi5lGts
         2r1LlxmviBXlJo0C4HGRdhzNmnfN53T1GjyRf20JKZy5sFxYnLen+5AyIJN3wspzk9mF
         ZvAKcav7dPkmqbu1/TqIplnn2OPnbB+ZKswJflPGh5BZpC+Lz2CjQiYoX4abSeQ4jIJG
         v4QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSNgHi/LSaSkqGXteQG69wcAp6QKDqR32my30IaTJGbqcAjm8TJdV18ZS4dYUNm3DMQL18wJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUJv6E4d3OA8+RaQj6tPb1rrpSLTeMPhA5iI+f69xfzmdwGtK
	Brd97FpEYNpY4MEbdtqKjchvqo+yfGQj7+cW9wCHGM3Y7p7yF/PSy34/xGczh7ftfHeeLh2sXzc
	Ab4HRkYqhx9w4KVxZq1ijK4NlkQ2PVPxpVDG2TYPKUk+U64BuXvMkCo4YfA==
X-Gm-Gg: AZuq6aJEMqCTVJwWpDJJIlAV9LngDXPvpDICKiMq7Ce6zoXpJM97kHQepmbeWBLBe2S
	Y+HbSJ+kT/XY85oGf9XHqiFfnOgkxnBbTueqYlpVq1r4kbSvXIAHPNH4IYbaLIYQXoLLgf+KSgZ
	tEQrcGq1F8Fg7v2o5v092chYjXmYGp9F2EOW0Tx4GrhcRw4+mL1GbYJAhThkYTylihkjxZqY0gY
	m8ExLjU3uTsxPZ6IAGreCun4H88mVECNX3brGBtG1s9M45JNZlqrpksBgElY7Cj/cBFng+3R5Ai
	QKd+jjr4SKTEaK01J5t4FoCpDKG1geETaMaLi0LzVteyH1lZWJSC12uMgyfHYMUHxsHFgFuVpAc
	FWW7UbFk9XJRalKFHdnCfWyOoMYCWB6Zonw==
X-Received: by 2002:a05:600c:468b:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-48320229220mr133646885e9.31.1770577539404;
        Sun, 08 Feb 2026 11:05:39 -0800 (PST)
X-Received: by 2002:a05:600c:468b:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-48320229220mr133646465e9.31.1770577538666;
        Sun, 08 Feb 2026 11:05:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206b8bbbsm324176955e9.3.2026.02.08.11.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 11:05:38 -0800 (PST)
Date: Sun, 8 Feb 2026 14:05:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6] virtio_net: add page_pool support for buffer
 allocation
Message-ID: <20260208140302-mutt-send-email-mst@kernel.org>
References: <20260208175410.1910001-1-vishs@meta.com>
 <20260208131355-mutt-send-email-mst@kernel.org>
 <3e6f368f-8c52-487c-816c-4dae13c70478@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6f368f-8c52-487c-816c-4dae13c70478@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257862-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pp_params.dev:url,meta.com:email]
X-Rspamd-Queue-Id: 3C9EF109F61
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 10:56:15AM -0800, Vishwanath Seshagiri wrote:
> On 2/8/26 10:42 AM, Michael S. Tsirkin wrote:
> > On Sun, Feb 08, 2026 at 09:54:10AM -0800, Vishwanath Seshagiri wrote:
> > > Use page_pool for RX buffer allocation in mergeable and small buffer
> > > modes to enable page recycling and avoid repeated page allocator calls.
> > > skb_mark_for_recycle() enables page reuse in the network stack.
> > > 
> > > Big packets mode is unchanged because it uses page->private for linked
> > > list chaining of multiple pages per buffer, which conflicts with
> > > page_pool's internal use of page->private.
> > > 
> > > Implement conditional DMA premapping using virtqueue_dma_dev():
> > > - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
> > >    handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
> > > - When NULL (VDUSE, direct physical): page_pool handles allocation only,
> > >    submit via virtqueue_add_inbuf_ctx()
> > > 
> > > This preserves the DMA premapping optimization from commit 31f3cd4e5756b
> > > ("virtio-net: rq submits premapped per-buffer") while adding page_pool
> > > support as a prerequisite for future zero-copy features (devmem TCP,
> > > io_uring ZCRX).
> > > 
> > > Page pools are created in probe and destroyed in remove (not open/close),
> > > following existing driver behavior where RX buffers remain in virtqueues
> > > across interface state changes.
> > > 
> > > Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> > > ---
> > > Changes in v6:
> > > - Drop page_pool_frag_offset_add() helper and switch to page_pool_alloc_va();
> > >    page_pool_alloc_netmem() already handles internal fragmentation internally
> > >    (Jakub Kicinski)
> > > - v5:
> > >    https://lore.kernel.org/virtualization/20260206002715.1885869-1-vishs@meta.com/
> > > 
> > > Benchmark results:
> > > 
> > > Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP
> > > 
> > > Small packets (64 bytes, mrg_rxbuf=off):
> > >    1Q:  853,493 -> 868,923 pps  (+1.8%)
> > >    2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
> > >    4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
> > >    8Q: 6,082,590 -> 6,156,894 pps (+1.2%)
> > > 
> > > Mergeable RX (64 bytes):
> > >    1Q:   766,168 ->   814,493 pps  (+6.3%)
> > >    2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
> > >    4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
> > >    8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)
> > > 
> > > Mergeable RX (1500 bytes):
> > >    1Q:   741,579 ->   785,442 pps  (+5.9%)
> > >    2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
> > >    4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
> > >    8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)
> > > 
> > >   drivers/net/Kconfig      |   1 +
> > >   drivers/net/virtio_net.c | 434 +++++++++++++++++++--------------------
> > >   2 files changed, 217 insertions(+), 218 deletions(-)
> > > 
> > > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > > index ac12eaf11755..f1e6b6b0a86f 100644
> > > --- a/drivers/net/Kconfig
> > > +++ b/drivers/net/Kconfig
> > > @@ -450,6 +450,7 @@ config VIRTIO_NET
> > >   	depends on VIRTIO
> > >   	select NET_FAILOVER
> > >   	select DIMLIB
> > > +	select PAGE_POOL
> > >   	help
> > >   	  This is the virtual network driver for virtio.  It can be used with
> > >   	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index db88dcaefb20..5055df56e4a7 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -26,6 +26,7 @@
> > >   #include <net/netdev_rx_queue.h>
> > >   #include <net/netdev_queues.h>
> > >   #include <net/xdp_sock_drv.h>
> > > +#include <net/page_pool/helpers.h>
> > >   static int napi_weight = NAPI_POLL_WEIGHT;
> > >   module_param(napi_weight, int, 0444);
> > > @@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
> > >   	u32 max_usecs;
> > >   };
> > > -/* The dma information of pages allocated at a time. */
> > > -struct virtnet_rq_dma {
> > > -	dma_addr_t addr;
> > > -	u32 ref;
> > > -	u16 len;
> > > -	u16 need_sync;
> > > -};
> > > -
> > >   /* Internal representation of a send virtqueue */
> > >   struct send_queue {
> > >   	/* Virtqueue associated with this send _queue */
> > > @@ -356,8 +349,10 @@ struct receive_queue {
> > >   	/* Average packet length for mergeable receive buffers. */
> > >   	struct ewma_pkt_len mrg_avg_pkt_len;
> > > -	/* Page frag for packet buffer allocation. */
> > > -	struct page_frag alloc_frag;
> > > +	struct page_pool *page_pool;
> > > +
> > > +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
> > > +	bool use_page_pool_dma;
> > >   	/* RX: fragments + linear part + virtio header */
> > >   	struct scatterlist sg[MAX_SKB_FRAGS + 2];
> > > @@ -370,9 +365,6 @@ struct receive_queue {
> > >   	struct xdp_rxq_info xdp_rxq;
> > > -	/* Record the last dma info to free after new pages is allocated. */
> > > -	struct virtnet_rq_dma *last_dma;
> > > -
> > >   	struct xsk_buff_pool *xsk_pool;
> > >   	/* xdp rxq used by xsk */
> > > @@ -521,11 +513,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> > >   			       struct virtnet_rq_stats *stats);
> > >   static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
> > >   				 struct sk_buff *skb, u8 flags);
> > > -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> > > +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> > > +					       struct sk_buff *head_skb,
> > >   					       struct sk_buff *curr_skb,
> > >   					       struct page *page, void *buf,
> > >   					       int len, int truesize);
> > >   static void virtnet_xsk_completed(struct send_queue *sq, int num);
> > > +static void free_unused_bufs(struct virtnet_info *vi);
> > >   enum virtnet_xmit_type {
> > >   	VIRTNET_XMIT_TYPE_SKB,
> > > @@ -706,15 +700,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> > >   	return p;
> > >   }
> > > +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
> > > +			     bool allow_direct)
> > > +{
> > > +	if (page_pool_page_is_pp(page))
> > > +		page_pool_put_page(rq->page_pool, page, -1, allow_direct);
> > > +	else
> > > +		put_page(page);
> > > +}
> > > +
> > >   static void virtnet_rq_free_buf(struct virtnet_info *vi,
> > >   				struct receive_queue *rq, void *buf)
> > >   {
> > >   	if (vi->mergeable_rx_bufs)
> > > -		put_page(virt_to_head_page(buf));
> > > +		virtnet_put_page(rq, virt_to_head_page(buf), false);
> > >   	else if (vi->big_packets)
> > >   		give_pages(rq, buf);
> > >   	else
> > > -		put_page(virt_to_head_page(buf));
> > > +		virtnet_put_page(rq, virt_to_head_page(buf), false);
> > 
> > equivalently:
> > 
> > 	if (vi->big_packets && !vi->mergeable_rx_bufs)
> >    		give_pages(rq, buf);
> > 	else
> > 		virtnet_put_page(rq, virt_to_head_page(buf), false);
> > 
> > and then it matches the check we have like in 10 places in
> > this file.
> > 
> > maybe it's time for a helper that does vi->big_packets &&
> > !vi->mergeable_rx_bufs?
> > 
> > maybe virtnet_no_page_pool()?
> 
> Good idea. I will create the virtnet_no_page_pool() api and use
> that for making intent clear.
> 
> > 
> > 
> > 
> > 
> > >   }
> > >   static void enable_rx_mode_work(struct virtnet_info *vi)
> > > @@ -876,10 +879,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >   		skb = virtnet_build_skb(buf, truesize, p - buf, len);
> > >   		if (unlikely(!skb))
> > >   			return NULL;
> > > +		/* Big packets mode chains pages via page->private, which is
> > > +		 * incompatible with the way page_pool uses page->private.
> > > +		 * Currently, big packets mode doesn't use page pools.
> > > +		 */
> > > +		if (vi->big_packets && !vi->mergeable_rx_bufs) {
> > > +			page = (struct page *)page->private;
> > > +			if (page)
> > > +				give_pages(rq, page);
> > > +		}
> > > -		page = (struct page *)page->private;
> > > -		if (page)
> > > -			give_pages(rq, page);
> > >   		goto ok;
> > >   	}
> > > @@ -925,133 +934,18 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >   	hdr = skb_vnet_common_hdr(skb);
> > >   	memcpy(hdr, hdr_p, hdr_len);
> > >   	if (page_to_free)
> > > -		put_page(page_to_free);
> > > +		virtnet_put_page(rq, page_to_free, true);
> > >   	return skb;
> > >   }
> > > -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
> > > -{
> > > -	struct virtnet_info *vi = rq->vq->vdev->priv;
> > > -	struct page *page = virt_to_head_page(buf);
> > > -	struct virtnet_rq_dma *dma;
> > > -	void *head;
> > > -	int offset;
> > > -
> > > -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> > > -
> > > -	head = page_address(page);
> > > -
> > > -	dma = head;
> > > -
> > > -	--dma->ref;
> > > -
> > > -	if (dma->need_sync && len) {
> > > -		offset = buf - (head + sizeof(*dma));
> > > -
> > > -		virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
> > > -							offset, len,
> > > -							DMA_FROM_DEVICE);
> > > -	}
> > > -
> > > -	if (dma->ref)
> > > -		return;
> > > -
> > > -	virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
> > > -				     DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> > > -	put_page(page);
> > > -}
> > > -
> > >   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> > >   {
> > >   	struct virtnet_info *vi = rq->vq->vdev->priv;
> > > -	void *buf;
> > >   	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> > > -	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > -	if (buf)
> > > -		virtnet_rq_unmap(rq, buf, *len);
> > > -
> > > -	return buf;
> > > -}
> > > -
> > > -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> > > -{
> > > -	struct virtnet_info *vi = rq->vq->vdev->priv;
> > > -	struct virtnet_rq_dma *dma;
> > > -	dma_addr_t addr;
> > > -	u32 offset;
> > > -	void *head;
> > > -
> > > -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> > > -
> > > -	head = page_address(rq->alloc_frag.page);
> > > -
> > > -	offset = buf - head;
> > > -
> > > -	dma = head;
> > > -
> > > -	addr = dma->addr - sizeof(*dma) + offset;
> > > -
> > > -	sg_init_table(rq->sg, 1);
> > > -	sg_fill_dma(rq->sg, addr, len);
> > > -}
> > > -
> > > -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> > > -{
> > > -	struct page_frag *alloc_frag = &rq->alloc_frag;
> > > -	struct virtnet_info *vi = rq->vq->vdev->priv;
> > > -	struct virtnet_rq_dma *dma;
> > > -	void *buf, *head;
> > > -	dma_addr_t addr;
> > > -
> > > -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> > > -
> > > -	head = page_address(alloc_frag->page);
> > > -
> > > -	dma = head;
> > > -
> > > -	/* new pages */
> > > -	if (!alloc_frag->offset) {
> > > -		if (rq->last_dma) {
> > > -			/* Now, the new page is allocated, the last dma
> > > -			 * will not be used. So the dma can be unmapped
> > > -			 * if the ref is 0.
> > > -			 */
> > > -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> > > -			rq->last_dma = NULL;
> > > -		}
> > > -
> > > -		dma->len = alloc_frag->size - sizeof(*dma);
> > > -
> > > -		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
> > > -						  dma->len, DMA_FROM_DEVICE, 0);
> > > -		if (virtqueue_map_mapping_error(rq->vq, addr))
> > > -			return NULL;
> > > -
> > > -		dma->addr = addr;
> > > -		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
> > > -
> > > -		/* Add a reference to dma to prevent the entire dma from
> > > -		 * being released during error handling. This reference
> > > -		 * will be freed after the pages are no longer used.
> > > -		 */
> > > -		get_page(alloc_frag->page);
> > > -		dma->ref = 1;
> > > -		alloc_frag->offset = sizeof(*dma);
> > > -
> > > -		rq->last_dma = dma;
> > > -	}
> > > -
> > > -	++dma->ref;
> > > -
> > > -	buf = head + alloc_frag->offset;
> > > -
> > > -	get_page(alloc_frag->page);
> > > -	alloc_frag->offset += size;
> > > -
> > > -	return buf;
> > > +	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > >   }
> > >   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > > @@ -1067,9 +961,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > >   		return;
> > >   	}
> > > -	if (!vi->big_packets || vi->mergeable_rx_bufs)
> > > -		virtnet_rq_unmap(rq, buf, 0);
> > > -
> > >   	virtnet_rq_free_buf(vi, rq, buf);
> > >   }
> > > @@ -1335,7 +1226,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
> > >   		truesize = len;
> > > -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> > > +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
> > >   						    buf, len, truesize);
> > >   		if (!curr_skb) {
> > >   			put_page(page);
> > > @@ -1771,7 +1662,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> > >   	return ret;
> > >   }
> > > -static void put_xdp_frags(struct xdp_buff *xdp)
> > > +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
> > >   {
> > >   	struct skb_shared_info *shinfo;
> > >   	struct page *xdp_page;
> > > @@ -1781,7 +1672,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> > >   		shinfo = xdp_get_shared_info_from_buff(xdp);
> > >   		for (i = 0; i < shinfo->nr_frags; i++) {
> > >   			xdp_page = skb_frag_page(&shinfo->frags[i]);
> > > -			put_page(xdp_page);
> > > +			virtnet_put_page(rq, xdp_page, true);
> > >   		}
> > >   	}
> > >   }
> > > @@ -1873,7 +1764,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
> > >   	if (page_off + *len + tailroom > PAGE_SIZE)
> > >   		return NULL;
> > > -	page = alloc_page(GFP_ATOMIC);
> > > +	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
> > >   	if (!page)
> > >   		return NULL;
> > > @@ -1897,7 +1788,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
> > >   		off = buf - page_address(p);
> > >   		if (check_mergeable_len(dev, ctx, buflen)) {
> > > -			put_page(p);
> > > +			virtnet_put_page(rq, p, true);
> > >   			goto err_buf;
> > >   		}
> > > @@ -1905,21 +1796,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
> > >   		 * is sending packet larger than the MTU.
> > >   		 */
> > >   		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> > > -			put_page(p);
> > > +			virtnet_put_page(rq, p, true);
> > >   			goto err_buf;
> > >   		}
> > >   		memcpy(page_address(page) + page_off,
> > >   		       page_address(p) + off, buflen);
> > >   		page_off += buflen;
> > > -		put_page(p);
> > > +		virtnet_put_page(rq, p, true);
> > >   	}
> > >   	/* Headroom does not contribute to packet length */
> > >   	*len = page_off - XDP_PACKET_HEADROOM;
> > >   	return page;
> > >   err_buf:
> > > -	__free_pages(page, 0);
> > > +	page_pool_put_page(rq->page_pool, page, -1, true);
> > >   	return NULL;
> > >   }
> > > @@ -1969,6 +1860,12 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
> > >   	unsigned int metasize = 0;
> > >   	u32 act;
> > > +	if (rq->use_page_pool_dma) {
> > > +		int off = buf - page_address(page);
> > > +
> > > +		page_pool_dma_sync_for_cpu(rq->page_pool, page, off, len);
> > > +	}
> > > +
> > 
> > hmm no this is wrong i think:
> > 
> >          struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
> >          int off = buf - page_address(page);
> > 
> > you should sync from hdr not from buf.
> 
> Yeah, the sync offset should be from where device actually writes. I
> will add change it in v7.
> 
> > 
> > 
> > besides did not receive_small already sync?
> > we do not need two syncs.
> 
> Yes, 2 syncs are redundant. I will keep it in receive_small, so that
> two syncs do not happen.
> 
> > 
> > 
> > 
> > 
> > >   	if (unlikely(hdr->hdr.gso_type))
> > >   		goto err_xdp;
> > > @@ -1996,7 +1893,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
> > >   			goto err_xdp;
> > >   		buf = page_address(xdp_page);
> > > -		put_page(page);
> > > +		virtnet_put_page(rq, page, true);
> > >   		page = xdp_page;
> > >   	}
> > > @@ -2028,13 +1925,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
> > >   	if (metasize)
> > >   		skb_metadata_set(skb, metasize);
> > > +	skb_mark_for_recycle(skb);
> > > +
> > >   	return skb;
> > >   err_xdp:
> > >   	u64_stats_inc(&stats->xdp_drops);
> > >   err:
> > >   	u64_stats_inc(&stats->drops);
> > > -	put_page(page);
> > > +	virtnet_put_page(rq, page, true);
> > >   xdp_xmit:
> > >   	return NULL;
> > >   }
> > > @@ -2056,6 +1955,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
> > >   	 */
> > >   	buf -= VIRTNET_RX_PAD + xdp_headroom;
> > > +	if (rq->use_page_pool_dma) {
> > > +		int offset = buf - page_address(page);
> > > +
> > > +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > > +	}
> > 
> > 
> > similar issue I think. off by header len.
> 
> ack. will change it in v7.
> 
> > 
> > > +
> > >   	len -= vi->hdr_len;
> > >   	u64_stats_add(&stats->bytes, len);
> > > @@ -2082,12 +1987,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
> > >   	}
> > >   	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
> > > -	if (likely(skb))
> > > +	if (likely(skb)) {
> > > +		skb_mark_for_recycle(skb);
> > >   		return skb;
> > > +	}
> > >   err:
> > >   	u64_stats_inc(&stats->drops);
> > > -	put_page(page);
> > > +	virtnet_put_page(rq, page, true);
> > >   	return NULL;
> > >   }
> > > @@ -2142,7 +2049,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
> > >   		}
> > >   		u64_stats_add(&stats->bytes, len);
> > >   		page = virt_to_head_page(buf);
> > > -		put_page(page);
> > > +		virtnet_put_page(rq, page, true);
> > >   	}
> > >   }
> > > @@ -2253,7 +2160,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
> > >   		offset = buf - page_address(page);
> > >   		if (check_mergeable_len(dev, ctx, len)) {
> > > -			put_page(page);
> > > +			virtnet_put_page(rq, page, true);
> > >   			goto err;
> > >   		}
> > > @@ -2272,7 +2179,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
> > >   	return 0;
> > >   err:
> > > -	put_xdp_frags(xdp);
> > > +	put_xdp_frags(rq, xdp);
> > >   	return -EINVAL;
> > >   }
> > > @@ -2337,7 +2244,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
> > >   		if (*len + xdp_room > PAGE_SIZE)
> > >   			return NULL;
> > > -		xdp_page = alloc_page(GFP_ATOMIC);
> > > +		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
> > >   		if (!xdp_page)
> > >   			return NULL;
> > > @@ -2347,7 +2254,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
> > >   	*frame_sz = PAGE_SIZE;
> > > -	put_page(*page);
> > > +	virtnet_put_page(rq, *page, true);
> > >   	*page = xdp_page;
> > > @@ -2393,6 +2300,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
> > >   		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> > >   		if (unlikely(!head_skb))
> > >   			break;
> > > +
> > > +		skb_mark_for_recycle(head_skb);
> > >   		return head_skb;
> > >   	case XDP_TX:
> > > @@ -2403,10 +2312,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
> > >   		break;
> > >   	}
> > > -	put_xdp_frags(&xdp);
> > > +	put_xdp_frags(rq, &xdp);
> > >   err_xdp:
> > > -	put_page(page);
> > > +	virtnet_put_page(rq, page, true);
> > >   	mergeable_buf_free(rq, num_buf, dev, stats);
> > >   	u64_stats_inc(&stats->xdp_drops);
> > > @@ -2414,7 +2323,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
> > >   	return NULL;
> > >   }
> > > -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> > > +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> > > +					       struct sk_buff *head_skb,
> > >   					       struct sk_buff *curr_skb,
> > >   					       struct page *page, void *buf,
> > >   					       int len, int truesize)
> > > @@ -2446,7 +2356,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> > >   	offset = buf - page_address(page);
> > >   	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> > > -		put_page(page);
> > > +		virtnet_put_page(rq, page, true);
> > >   		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
> > >   				     len, truesize);
> > >   	} else {
> > > @@ -2475,6 +2385,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > >   	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> > >   	head_skb = NULL;
> > > +
> > > +	if (rq->use_page_pool_dma)
> > > +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > > +
> > 
> > nice but where is the sync for reset of buffers?
> > 
> > >   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
> > >   	if (check_mergeable_len(dev, ctx, len))
> > > @@ -2499,6 +2413,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > >   	if (unlikely(!curr_skb))
> > >   		goto err_skb;
> > > +
> > > +	skb_mark_for_recycle(head_skb);
> > >   	while (--num_buf) {
> > >   		buf = virtnet_rq_get_buf(rq, &len, &ctx);
> > 
> > ok so we have recycling.
> > I *think* that since below you set PP_FLAG_DMA_MAP, then page_pool does
> > not sync_for_device on recycle;
> > so CPU can write into packet data (e.g. XDP_PASS) and leave dirty cachelines.
> > After reuse, on non-coherent DMA that can corrupt later packets unless you add
> > PP_FLAG_DMA_SYNC_DEV (with max_len/offset) or do an explicit
> > dma_sync_for_device before requeue.
> > 
> > 
> > See Documentation/core-api/dma-api-howto.rst
> > 
> > I agree it's annoying since maybe we did not touch it at all.
> > 
> 
> Right. I initially left it out since dma_sync_for_device is a no-op on
> coherent platforms where virtio-net is typically deployed, but it's
> needed for correctness on non-coherent architectures. Will add
> PP_FLAG_DMA_SYNC_DEV with appropriate max_len/offset in v7.


erm. pls document assumptions like this in the future.


> > 
> > 
> > 
> > >   		if (unlikely(!buf)) {
> > > @@ -2517,7 +2433,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > >   			goto err_skb;
> > >   		truesize = mergeable_ctx_to_truesize(ctx);
> > > -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> > > +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
> > >   						    buf, len, truesize);
> > >   		if (!curr_skb)
> > >   			goto err_skb;
> > > @@ -2527,7 +2443,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > >   	return head_skb;
> > >   err_skb:
> > > -	put_page(page);
> > > +	virtnet_put_page(rq, page, true);
> > >   	mergeable_buf_free(rq, num_buf, dev, stats);
> > >   err_buf:
> > > @@ -2666,32 +2582,41 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > >   static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > >   			     gfp_t gfp)
> > >   {
> > > -	char *buf;
> > >   	unsigned int xdp_headroom = virtnet_get_headroom(vi);
> > >   	void *ctx = (void *)(unsigned long)xdp_headroom;
> > > -	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> > > +	unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> > > +	struct page *page;
> > > +	dma_addr_t addr;
> > > +	char *buf;
> > >   	int err;
> > >   	len = SKB_DATA_ALIGN(len) +
> > >   	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > -	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > > -		return -ENOMEM;
> > > -
> > > -	buf = virtnet_rq_alloc(rq, len, gfp);
> > > +	buf = page_pool_alloc_va(rq->page_pool, &len, gfp);
> > >   	if (unlikely(!buf))
> > >   		return -ENOMEM;
> > >   	buf += VIRTNET_RX_PAD + xdp_headroom;
> > > -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
> > > +	if (rq->use_page_pool_dma) {
> > > +		page = virt_to_head_page(buf);
> > > +		addr = page_pool_get_dma_addr(page) +
> > > +		       (buf - (char *)page_address(page));
> > > -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
> > > -	if (err < 0) {
> > > -		virtnet_rq_unmap(rq, buf, 0);
> > > -		put_page(virt_to_head_page(buf));
> > > +		sg_init_table(rq->sg, 1);
> > > +		sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
> > > +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> > > +						    buf, ctx, gfp);
> > > +	} else {
> > > +		sg_init_one(rq->sg, buf, vi->hdr_len + GOOD_PACKET_LEN);
> > > +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
> > > +					      buf, ctx, gfp);
> > >   	}
> > > +	if (err < 0)
> > > +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
> > > +				   -1, false);
> > >   	return err;
> > >   }
> > > @@ -2764,13 +2689,14 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
> > >   static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > >   				 struct receive_queue *rq, gfp_t gfp)
> > >   {
> > > -	struct page_frag *alloc_frag = &rq->alloc_frag;
> > >   	unsigned int headroom = virtnet_get_headroom(vi);
> > >   	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
> > >   	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
> > > -	unsigned int len, hole;
> > > -	void *ctx;
> > > +	unsigned int len, alloc_len;
> > > +	struct page *page;
> > > +	dma_addr_t addr;
> > >   	char *buf;
> > > +	void *ctx;
> > >   	int err;
> > >   	/* Extra tailroom is needed to satisfy XDP's assumption. This
> > > @@ -2779,39 +2705,36 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > >   	 */
> > >   	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > > -	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > > -		return -ENOMEM;
> > > -
> > > -	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > > -		len -= sizeof(struct virtnet_rq_dma);
> > > -
> > > -	buf = virtnet_rq_alloc(rq, len + room, gfp);
> > > +	alloc_len = len + room;
> > > +	buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);
> > >   	if (unlikely(!buf))
> > >   		return -ENOMEM;
> > >   	buf += headroom; /* advance address leaving hole at front of pkt */
> > > -	hole = alloc_frag->size - alloc_frag->offset;
> > > -	if (hole < len + room) {
> > > -		/* To avoid internal fragmentation, if there is very likely not
> > > -		 * enough space for another buffer, add the remaining space to
> > > -		 * the current buffer.
> > > -		 * XDP core assumes that frame_size of xdp_buff and the length
> > > -		 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
> > > -		 */
> > > -		if (!headroom)
> > > -			len += hole;
> > > -		alloc_frag->offset += hole;
> > > -	}
> > > -	virtnet_rq_init_one_sg(rq, buf, len);
> > > +	if (!headroom)
> > > +		len = alloc_len - room;
> > >   	ctx = mergeable_len_to_ctx(len + room, headroom);
> > > -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
> > > -	if (err < 0) {
> > > -		virtnet_rq_unmap(rq, buf, 0);
> > > -		put_page(virt_to_head_page(buf));
> > > +
> > > +	if (rq->use_page_pool_dma) {
> > > +		page = virt_to_head_page(buf);
> > > +		addr = page_pool_get_dma_addr(page) +
> > > +		       (buf - (char *)page_address(page));
> > > +
> > > +		sg_init_table(rq->sg, 1);
> > > +		sg_fill_dma(rq->sg, addr, len);
> > > +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> > > +						    buf, ctx, gfp);
> > > +	} else {
> > > +		sg_init_one(rq->sg, buf, len);
> > > +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
> > > +					      buf, ctx, gfp);
> > >   	}
> > > +	if (err < 0)
> > > +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
> > > +				   -1, false);
> > >   	return err;
> > >   }
> > > @@ -3128,7 +3051,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >   		return err;
> > >   	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
> > > -					 MEM_TYPE_PAGE_SHARED, NULL);
> > > +					 vi->rq[qp_index].page_pool ?
> > > +						MEM_TYPE_PAGE_POOL :
> > > +						MEM_TYPE_PAGE_SHARED,
> > > +					 vi->rq[qp_index].page_pool);
> > >   	if (err < 0)
> > >   		goto err_xdp_reg_mem_model;
> > > @@ -3168,6 +3094,81 @@ static void virtnet_update_settings(struct virtnet_info *vi)
> > >   		vi->duplex = duplex;
> > >   }
> > > +static int virtnet_create_page_pools(struct virtnet_info *vi)
> > > +{
> > > +	int i, err;
> > > +
> > > +	if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > +		return 0;
> > > +
> > > +	for (i = 0; i < vi->max_queue_pairs; i++) {
> > > +		struct receive_queue *rq = &vi->rq[i];
> > > +		struct page_pool_params pp_params = { 0 };
> > > +		struct device *dma_dev;
> > > +
> > > +		if (rq->page_pool)
> > > +			continue;
> > > +
> > > +		if (rq->xsk_pool)
> > > +			continue;
> > > +
> > > +		pp_params.order = 0;
> > > +		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
> > > +		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
> > > +		pp_params.netdev = vi->dev;
> > > +		pp_params.napi = &rq->napi;
> > > +
> > > +		/* Check if backend supports DMA API (e.g., vhost, virtio-pci).
> > > +		 * If so, use page_pool's DMA mapping for premapped buffers.
> > > +		 * Otherwise (e.g., VDUSE), page_pool only handles allocation.
> > > +		 */
> > > +		dma_dev = virtqueue_dma_dev(rq->vq);
> > > +		if (dma_dev) {
> > > +			pp_params.dev = dma_dev;
> > > +			pp_params.flags = PP_FLAG_DMA_MAP;
> > > +			pp_params.dma_dir = DMA_FROM_DEVICE;
> > > +			rq->use_page_pool_dma = true;
> > > +		} else {
> > > +			pp_params.dev = vi->vdev->dev.parent;
> > > +			pp_params.flags = 0;
> > > +			rq->use_page_pool_dma = false;
> > > +		}
> > > +
> > > +		rq->page_pool = page_pool_create(&pp_params);
> > > +		if (IS_ERR(rq->page_pool)) {
> > > +			err = PTR_ERR(rq->page_pool);
> > > +			rq->page_pool = NULL;
> > > +			goto err_cleanup;
> > > +		}
> > > +	}
> > > +	return 0;
> > > +
> > > +err_cleanup:
> > > +	while (--i >= 0) {
> > > +		struct receive_queue *rq = &vi->rq[i];
> > > +
> > > +		if (rq->page_pool) {
> > > +			page_pool_destroy(rq->page_pool);
> > > +			rq->page_pool = NULL;
> > > +		}
> > > +	}
> > > +	return err;
> > > +}
> > > +
> > > +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < vi->max_queue_pairs; i++) {
> > > +		struct receive_queue *rq = &vi->rq[i];
> > > +
> > > +		if (rq->page_pool) {
> > > +			page_pool_destroy(rq->page_pool);
> > > +			rq->page_pool = NULL;
> > > +		}
> > > +	}
> > > +}
> > > +
> > >   static int virtnet_open(struct net_device *dev)
> > >   {
> > >   	struct virtnet_info *vi = netdev_priv(dev);
> > > @@ -6287,17 +6288,6 @@ static void free_receive_bufs(struct virtnet_info *vi)
> > >   	rtnl_unlock();
> > >   }
> > > -static void free_receive_page_frags(struct virtnet_info *vi)
> > > -{
> > > -	int i;
> > > -	for (i = 0; i < vi->max_queue_pairs; i++)
> > > -		if (vi->rq[i].alloc_frag.page) {
> > > -			if (vi->rq[i].last_dma)
> > > -				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
> > > -			put_page(vi->rq[i].alloc_frag.page);
> > > -		}
> > > -}
> > > -
> > >   static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> > >   {
> > >   	struct virtnet_info *vi = vq->vdev->priv;
> > > @@ -6441,10 +6431,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >   		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
> > >   		vi->sq[i].vq = vqs[txq2vq(i)];
> > >   	}
> > > -
> > >   	/* run here: ret == 0. */
> > > -
> > >   err_find:
> > >   	kfree(ctx);
> > >   err_ctx:
> > > @@ -6945,6 +6933,14 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   			goto free;
> > >   	}
> > > +	/* Create page pools for receive queues.
> > > +	 * Page pools are created at probe time so they can be used
> > > +	 * with premapped DMA addresses throughout the device lifetime.
> > > +	 */
> > > +	err = virtnet_create_page_pools(vi);
> > > +	if (err)
> > > +		goto free_irq_moder;
> > > +
> > >   #ifdef CONFIG_SYSFS
> > >   	if (vi->mergeable_rx_bufs)
> > >   		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
> > > @@ -6958,7 +6954,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   		vi->failover = net_failover_create(vi->dev);
> > >   		if (IS_ERR(vi->failover)) {
> > >   			err = PTR_ERR(vi->failover);
> > > -			goto free_vqs;
> > > +			goto free_page_pools;
> > >   		}
> > >   	}
> > > @@ -7075,9 +7071,11 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   	unregister_netdev(dev);
> > >   free_failover:
> > >   	net_failover_destroy(vi->failover);
> > > -free_vqs:
> > > +free_page_pools:
> > > +	virtnet_destroy_page_pools(vi);
> > > +free_irq_moder:
> > > +	virtnet_free_irq_moder(vi);
> > >   	virtio_reset_device(vdev);
> > > -	free_receive_page_frags(vi);
> > >   	virtnet_del_vqs(vi);
> > >   free:
> > >   	free_netdev(dev);
> > > @@ -7102,7 +7100,7 @@ static void remove_vq_common(struct virtnet_info *vi)
> > >   	free_receive_bufs(vi);
> > > -	free_receive_page_frags(vi);
> > > +	virtnet_destroy_page_pools(vi);
> > >   	virtnet_del_vqs(vi);
> > >   }
> > > -- 
> > > 2.47.3
> > 


