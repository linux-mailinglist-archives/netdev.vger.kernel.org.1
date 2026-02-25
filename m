Return-Path: <netdev+bounces-260796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNFvLhS3nmnwWwQAu9opvQ
	(envelope-from <netdev+bounces-260796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:47:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC01945FA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13B9E302BDDD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED630C35E;
	Wed, 25 Feb 2026 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cVlQchii"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8529BDAD;
	Wed, 25 Feb 2026 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009232; cv=none; b=VDECSwA6krAuW5/J6N8BPQ90PzeY8XPqSv3+VTzgnBG+lWVTsuv3GHELeUhyHiKY+VgxJPt/FwiYffTIxWfL/BOkrU65GmOnZj0CSUoVLARoHzXNKgo9jrVdCPYwgLwEWvXQbO8AQ95zjqHIIL19V+o4fUyexDacspWxGw19sUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009232; c=relaxed/simple;
	bh=J0xQlvBaT1CYJzoXhT+Hqqxjx8UNG50bDfPQ6DkbRoc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=KaUhpx/nPb6iOCN3i65OQcXUti3b5+F7UZ6K0/58BYNufeX9Kyy0dCEAVZBSDR0+feeYsy6By6+KkMYk33bB9m24MKE+tOY52Y6PRREoqBFhOzwYMegCJevdrvpLf9IDxfjZ3bUWLkamKmrqq8C7iMryrI3XYGE5XEjQCM2YuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cVlQchii; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772009227; h=Message-ID:Subject:Date:From:To;
	bh=rEo0rrJ0NbhWhP4748gknPgRXYAsuEdXqjPgMHubl+0=;
	b=cVlQchiijdqPGBxpQy0+nZjJEt6sEj2gx1Weha434hUcfJXT1gsJTkQPDhS7UIXleN2GRnWF981OvZJAXqO7c3b4IwYOHOyq4WLx34cZF1WDE+XH9iTe5eNg/TifL52Q80M9s6ygVb6AvfWLA1SMLA+96GcPpMm6jXR1fZ6ZgV4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WzlrSwg_1772009226 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 16:47:06 +0800
Message-ID: <1772008398.9732423-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 RESEND net-next] virtio_net: add page_pool support for buffer allocation
Date: Wed, 25 Feb 2026 16:33:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 David Wei <dw@davidwei.uk>,
 Matteo Croce <technoboy85@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20260225044910.1328791-1-vishs@meta.com>
In-Reply-To: <20260225044910.1328791-1-vishs@meta.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260796-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pp_params.dev:url,meta.com:email]
X-Rspamd-Queue-Id: 1ABC01945FA
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 20:49:10 -0800, Vishwanath Seshagiri <vishs@meta.com> wrote:
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes to enable page recycling and avoid repeated page allocator calls.
> skb_mark_for_recycle() enables page reuse in the network stack.
>
> Big packets mode is unchanged because it uses page->private for linked
> list chaining of multiple pages per buffer, which conflicts with
> page_pool's internal use of page->private.
>
> Implement conditional DMA premapping using virtqueue_dma_dev():
> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>   handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>   submit via virtqueue_add_inbuf_ctx()
>
> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
> support as a prerequisite for future zero-copy features (devmem TCP,
> io_uring ZCRX).
>
> Page pools are created in probe and destroyed in remove (not open/close),
> following existing driver behavior where RX buffers remain in virtqueues
> across interface state changes.
>
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
> Resend for net-next window (no changes from v7).
> - v7:
>   https://lore.kernel.org/virtualization/20260210014305.3236342-1-vishs@meta.com/
>
> Changes in v7:
> - Replace virtnet_put_page() helper with direct page_pool_put_page()
>   calls (Xuan Zhuo)
> - Add virtnet_no_page_pool() helper to consolidate big_packets mode check
>   (Michael S. Tsirkin)
> - Add DMA sync_for_cpu for subsequent buffers in xdp_linearize_page() when
>   use_page_pool_dma is set (Michael S. Tsirkin)
> - Remove unused pp_params.dev assignment in non-DMA path
> - Add page pool recreation in virtnet_restore_up() for freeze/restore support (Chris Mason's
> Review Prompt)
> - v6:
>   https://lore.kernel.org/virtualization/20260208175410.1910001-1-vishs@meta.com/
>
> Changes in v6:
> - Drop page_pool_frag_offset_add() helper and switch to page_pool_alloc_va();
>   page_pool_alloc_netmem() already handles internal fragmentation internally
>   (Jakub Kicinski)
> - v5:
>   https://lore.kernel.org/virtualization/20260206002715.1885869-1-vishs@meta.com/
>
> Benchmark results:
>
> Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP
>
> Small packets (64 bytes, mrg_rxbuf=off):
>   1Q:  853,493 -> 868,923 pps  (+1.8%)
>   2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
>   4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
>   8Q: 6,082,590 -> 6,156,894 pps (+1.2%)
>
> Mergeable RX (64 bytes):
>   1Q:   766,168 ->   814,493 pps  (+6.3%)
>   2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
>   4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
>   8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)
>
> Mergeable RX (1500 bytes):
>   1Q:   741,579 ->   785,442 pps  (+5.9%)
>   2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
>   4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
>   8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)
>
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 467 ++++++++++++++++++++-------------------
>  2 files changed, 243 insertions(+), 225 deletions(-)
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index ac12eaf11755..f1e6b6b0a86f 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -450,6 +450,7 @@ config VIRTIO_NET
>  	depends on VIRTIO
>  	select NET_FAILOVER
>  	select DIMLIB
> +	select PAGE_POOL
>  	help
>  	  This is the virtual network driver for virtio.  It can be used with
>  	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..32aede2b1ed5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <net/page_pool/helpers.h>
>
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
>  	u32 max_usecs;
>  };
>
> -/* The dma information of pages allocated at a time. */
> -struct virtnet_rq_dma {
> -	dma_addr_t addr;
> -	u32 ref;
> -	u16 len;
> -	u16 need_sync;
> -};
> -
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>  	/* Virtqueue associated with this send _queue */
> @@ -356,8 +349,10 @@ struct receive_queue {
>  	/* Average packet length for mergeable receive buffers. */
>  	struct ewma_pkt_len mrg_avg_pkt_len;
>
> -	/* Page frag for packet buffer allocation. */
> -	struct page_frag alloc_frag;
> +	struct page_pool *page_pool;
> +
> +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
> +	bool use_page_pool_dma;
>
>  	/* RX: fragments + linear part + virtio header */
>  	struct scatterlist sg[MAX_SKB_FRAGS + 2];
> @@ -370,9 +365,6 @@ struct receive_queue {
>
>  	struct xdp_rxq_info xdp_rxq;
>
> -	/* Record the last dma info to free after new pages is allocated. */
> -	struct virtnet_rq_dma *last_dma;
> -
>  	struct xsk_buff_pool *xsk_pool;
>
>  	/* xdp rxq used by xsk */
> @@ -521,11 +513,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			       struct virtnet_rq_stats *stats);
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>  				 struct sk_buff *skb, u8 flags);
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +					       struct sk_buff *head_skb,
>  					       struct sk_buff *curr_skb,
>  					       struct page *page, void *buf,
>  					       int len, int truesize);
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> +static void free_unused_bufs(struct virtnet_info *vi);
> +static void virtnet_del_vqs(struct virtnet_info *vi);
>
>  enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
> @@ -706,15 +701,18 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>
> +static bool virtnet_no_page_pool(struct virtnet_info *vi)
> +{

Can we check vi->page_pool?

In virtnet_create_page_pools, we can check
"vi->big_packets && !vi->mergeable_rx_bufs" directly.

Then other calls will be more efficient.


> +	return vi->big_packets && !vi->mergeable_rx_bufs;
> +}
> +
>  static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  				struct receive_queue *rq, void *buf)
>  {
> -	if (vi->mergeable_rx_bufs)
> -		put_page(virt_to_head_page(buf));
> -	else if (vi->big_packets)
> +	if (virtnet_no_page_pool(vi))
>  		give_pages(rq, buf);
>  	else
> -		put_page(virt_to_head_page(buf));
> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
>  }
>


[...]


>
>  err_buf:
> @@ -2666,32 +2586,40 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  			     gfp_t gfp)
>  {
> -	char *buf;
>  	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>  	void *ctx = (void *)(unsigned long)xdp_headroom;
> -	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> +	unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> +	struct page *page;
> +	dma_addr_t addr;
> +	char *buf;
>  	int err;
>
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> -	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> -		return -ENOMEM;
> -
> -	buf = virtnet_rq_alloc(rq, len, gfp);
> +	buf = page_pool_alloc_va(rq->page_pool, &len, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
>
>  	buf += VIRTNET_RX_PAD + xdp_headroom;
>
> -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
> +	if (rq->use_page_pool_dma) {
> +		page = virt_to_head_page(buf);
> +		addr = page_pool_get_dma_addr(page) +
> +		       (buf - (char *)page_address(page));
>
> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
> -	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> -		put_page(virt_to_head_page(buf));
> +		sg_init_table(rq->sg, 1);
> +		sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> +						    buf, ctx, gfp);
> +	} else {
> +		sg_init_one(rq->sg, buf, vi->hdr_len + GOOD_PACKET_LEN);
> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
> +					      buf, ctx, gfp);
>  	}

Maybe we should introduce a helper to do this, as the merge mode needs this
too.


Thanks.

