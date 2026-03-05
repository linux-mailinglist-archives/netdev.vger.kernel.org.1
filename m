Return-Path: <netdev+bounces-264369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLAFAZF5qWl77wAAu9opvQ
	(envelope-from <netdev+bounces-264369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:39:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E7211D0D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B12EF302EE98
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB533F369;
	Thu,  5 Mar 2026 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZvtSFWZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nN5tvZ4T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6555248F66
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714306; cv=none; b=DMP/s/zR5U0bQosfJ/8+b+pFRi1pWHD9aGnQ1QzJri064YroQ0yw8A3yZW6GCPZR4Ujq9ykxnEDvfK0ryWO2hF8LKMabAFHws7sx6r0h0moZ6PnIdyE6Xn8vizp66PK6lk0nYQhM6q1NSX7Ny28NFQKCqDMpvjV13LMVwuJYVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714306; c=relaxed/simple;
	bh=UG3FkYLNDSzsJCxanWzpTmPafSNTH+j2vyMNj3hvegA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRBdUmOIzF9Uqo4lVGnx/iwVBpPtZfpqYjxtI7TVKyzaVpEgIgwpOn+sBHRp37S4ziQ8Rv2cVzyAcvBqrYI9EY/wU+iTg7qZKd4RrdhEAC68s50gEDYzTP5SSPllEzMjwOLH+0CmBsbV/efvciRBUktxioCzcF62WhJcOIM8PIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZvtSFWZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nN5tvZ4T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772714303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUQHegcfaVZ8OOS01CV5bqsZ1M11ZENMvG4/XDhiePI=;
	b=AZvtSFWZnrclV9h1mrELWkHQgcPaHXrwgWYoXQBCE+Z5Ikm1vCiBai7ug6Hg6cvOEfjY3o
	l3Xg8LyCXxW7TqJX+zCu0/DoYiwzzc1kBWPhuwrBVBjJKnKJt4Vk2BXF0H5vZhj/dzmSpt
	AZbcpaSwyia24JoaZldidTwipvTpf68=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-IZeH3l-ENkmSWEP9ZIeArg-1; Thu, 05 Mar 2026 07:38:21 -0500
X-MC-Unique: IZeH3l-ENkmSWEP9ZIeArg-1
X-Mimecast-MFC-AGG-ID: IZeH3l-ENkmSWEP9ZIeArg_1772714301
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso65113835e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772714300; x=1773319100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUQHegcfaVZ8OOS01CV5bqsZ1M11ZENMvG4/XDhiePI=;
        b=nN5tvZ4TT0ruGk+UBokhepyBLTG9ZikcEgAUsHh0FCcgWrdjRv3ocpmhvqGuYlN0vM
         /NHi64K3NPFkcTegSMSOeAAzzw5VDTkVD+evnrzFvs9I4pwLLdcZf9NQ72K2oSWEw6qj
         UzrxAwaGOdb2Pb50tegfS8r3plT8+IrGFJxPUx3p+uSuzbCb3w7rTTsP5kmY/WhKHclz
         mnlK33h0Wo2BfbkZFVH4yBap7ezSkHtIKvdj3ldr2lGtZlKYbMpz5NVrCYBK0ddf8TBm
         8Ov1EVUDLvfDqk8GaVcWG94dq5bpExB84nE6EKvkkTHPcycty7kM1gyHA1pafRbcDYgs
         rMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714300; x=1773319100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUQHegcfaVZ8OOS01CV5bqsZ1M11ZENMvG4/XDhiePI=;
        b=Vh9L6Po4UtU9MaMdyFcVDUJcn5yz390FTIGPJ4DMll61g5NhzOC/HsQC7s+1NtB/3Q
         16e+HjWi3MZEAuhjm486yBhAgFhMyTeNmY7H/gRei59CSUtxbth0AdF6A5s8bEkUscM8
         oaCavSSPLSndJrmx+UfGGSk4DUp8ed0TVNdreblTZ8inx+TCaEhDpKrqz8VZsql6m4ai
         dbmVN3W3Qpi0AK9UzB2ueqf0DvWiG8fkmUeQKkMmFW2/1ZrGVTQZbDtFtBDEw7AbV6ep
         7e7Zud7IPn+x/jZrgbZ3oEejvoGBqFPXfWufzalY2Q5Tpp/8JKei0DWAw43+/liBX5x8
         NzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCURHXHT/iXh+K5XK+6kHu5kBl4mzwkZ8pvk+7Iqx8y7jYQ7Z+LAjW/f/kF0w14sZd3lyMjM6Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZm46RFTynFCp4Vfwr7LUsnSBOtq2U3iyjENTEOjBXx7U8i96
	obaW5Ap9I3EfRIWARBGVSr21UL0YH70OmX/Ora3bfQDs/FQ+UwZoGm17qZu3BshLKZxGoI1xUcT
	wGhG9/MQDOMBlnkx/trTXwo8jZ+u1dqOFeOgTJGIKPFPTZuohHoitdVXnwpymQrow8A==
X-Gm-Gg: ATEYQzzQtaLKkdMxRdzr4CUqj181Q/HLorvf4TWusJGAPacg43ZPGiatKt2PIRQ4alb
	r64mcbJAgpjzJfun+j7xLVP9aCZqVCr4x05hqaTR/9S2SdwgyxnOgEzETtrndOIrrPRZqiG2tin
	r+LA7CcONqpznHb7zpIpled/1r8U37n7li4WT+U2CP+aQyrvxkfBEkEQVLawmVcKDnGi6/OvRfP
	gYiusyIpneCCy580lsBI90Xug2q1+Vd1jknA82GpINihpRK2U8YICIUh5e5EH0alqPhXxXM+E8X
	yzzZISRNNzX/wpZWF4AqggaMFF0TVe8KaFup/MNQeDwq2wzneDh4fuAG2QiP2+o6ts4AHHLEym/
	ulifp5bibAALoVFQSFMKu+Q8JsgYW27XODzIL7vYFC2yeNg==
X-Received: by 2002:a05:600c:4688:b0:47e:e7e5:ff32 with SMTP id 5b1f17b1804b1-485198a3bc4mr87974655e9.34.1772714300129;
        Thu, 05 Mar 2026 04:38:20 -0800 (PST)
X-Received: by 2002:a05:600c:4688:b0:47e:e7e5:ff32 with SMTP id 5b1f17b1804b1-485198a3bc4mr87973815e9.34.1772714299322;
        Thu, 05 Mar 2026 04:38:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851aceb94dsm56301675e9.4.2026.03.05.04.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:38:18 -0800 (PST)
Date: Thu, 5 Mar 2026 07:38:14 -0500
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
Subject: Re: [PATCH net-next v10] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260305073638-mutt-send-email-mst@kernel.org>
References: <20260303074253.3449987-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303074253.3449987-1-vishs@meta.com>
X-Rspamd-Queue-Id: 563E7211D0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264369-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pp_params.dev:url,meta.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:42:53PM -0800, Vishwanath Seshagiri wrote:
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
> Changes in v10:
> - add_recvbuf_small: use alloc_len to avoid clobbering len (Michael S. Tsirkin)

this was not my comment though?

> - v9:
>   https://lore.kernel.org/virtualization/20260302041005.1627210-1-vishs@meta.com/ 
> 
> Changes in v9:
> - Fix virtnet_skb_append_frag() for XSK callers (Michael S. Tsirkin)
> - v8:
>   https://lore.kernel.org/virtualization/e824c5a3-cfe0-4d11-958f-c3ec82d11d37@meta.com/  
> 
> Changes in v8:
> - Remove virtnet_no_page_pool() helper, replace with direct !rq->page_pool
>   checks or inlined conditions (Xuan Zhuo)
> - Extract virtnet_rq_submit() helper to consolidate DMA/non-DMA buffer
>   submission in add_recvbuf_small() and add_recvbuf_mergeable()
> - Add skb_mark_for_recycle(nskb) for overflow frag_list skbs in
>   virtnet_skb_append_frag() to ensure page_pool pages are returned to
>   the pool instead of freed via put_page()
> - Rebase on net-next (kzalloc_objs API)
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
>  drivers/net/virtio_net.c | 466 ++++++++++++++++++++-------------------
>  2 files changed, 237 insertions(+), 230 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 17108c359216..b2fd90466bab 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -452,6 +452,7 @@ config VIRTIO_NET
>  	depends on VIRTIO
>  	select NET_FAILOVER
>  	select DIMLIB
> +	select PAGE_POOL
>  	help
>  	  This is the virtual network driver for virtio.  It can be used with
>  	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..d722031604bf 100644
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
> @@ -709,12 +704,10 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  				struct receive_queue *rq, void *buf)
>  {
> -	if (vi->mergeable_rx_bufs)
> -		put_page(virt_to_head_page(buf));
> -	else if (vi->big_packets)
> +	if (!rq->page_pool)
>  		give_pages(rq, buf);
>  	else
> -		put_page(virt_to_head_page(buf));
> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
>  }
>  
>  static void enable_rx_mode_work(struct virtnet_info *vi)
> @@ -876,10 +869,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		skb = virtnet_build_skb(buf, truesize, p - buf, len);
>  		if (unlikely(!skb))
>  			return NULL;
> +		/* Big packets mode chains pages via page->private, which is
> +		 * incompatible with the way page_pool uses page->private.
> +		 * Currently, big packets mode doesn't use page pools.
> +		 */
> +		if (!rq->page_pool) {
> +			page = (struct page *)page->private;
> +			if (page)
> +				give_pages(rq, page);
> +		}
>  
> -		page = (struct page *)page->private;
> -		if (page)
> -			give_pages(rq, page);
>  		goto ok;
>  	}
>  
> @@ -925,133 +924,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	hdr = skb_vnet_common_hdr(skb);
>  	memcpy(hdr, hdr_p, hdr_len);
>  	if (page_to_free)
> -		put_page(page_to_free);
> +		page_pool_put_page(rq->page_pool, page_to_free, -1, true);
>  
>  	return skb;
>  }
>  
> -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
> -{
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	struct page *page = virt_to_head_page(buf);
> -	struct virtnet_rq_dma *dma;
> -	void *head;
> -	int offset;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	head = page_address(page);
> -
> -	dma = head;
> -
> -	--dma->ref;
> -
> -	if (dma->need_sync && len) {
> -		offset = buf - (head + sizeof(*dma));
> -
> -		virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
> -							offset, len,
> -							DMA_FROM_DEVICE);
> -	}
> -
> -	if (dma->ref)
> -		return;
> -
> -	virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
> -				     DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> -	put_page(page);
> -}
> -
>  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  {
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	void *buf;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -	if (buf)
> -		virtnet_rq_unmap(rq, buf, *len);
> -
> -	return buf;
> -}
> -
> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> -{
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	struct virtnet_rq_dma *dma;
> -	dma_addr_t addr;
> -	u32 offset;
> -	void *head;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	head = page_address(rq->alloc_frag.page);
> -
> -	offset = buf - head;
> -
> -	dma = head;
> -
> -	addr = dma->addr - sizeof(*dma) + offset;
> -
> -	sg_init_table(rq->sg, 1);
> -	sg_fill_dma(rq->sg, addr, len);
> -}
> -
> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> -{
> -	struct page_frag *alloc_frag = &rq->alloc_frag;
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	struct virtnet_rq_dma *dma;
> -	void *buf, *head;
> -	dma_addr_t addr;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	head = page_address(alloc_frag->page);
> -
> -	dma = head;
> -
> -	/* new pages */
> -	if (!alloc_frag->offset) {
> -		if (rq->last_dma) {
> -			/* Now, the new page is allocated, the last dma
> -			 * will not be used. So the dma can be unmapped
> -			 * if the ref is 0.
> -			 */
> -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> -			rq->last_dma = NULL;
> -		}
> -
> -		dma->len = alloc_frag->size - sizeof(*dma);
> -
> -		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
> -						  dma->len, DMA_FROM_DEVICE, 0);
> -		if (virtqueue_map_mapping_error(rq->vq, addr))
> -			return NULL;
> -
> -		dma->addr = addr;
> -		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
> -
> -		/* Add a reference to dma to prevent the entire dma from
> -		 * being released during error handling. This reference
> -		 * will be freed after the pages are no longer used.
> -		 */
> -		get_page(alloc_frag->page);
> -		dma->ref = 1;
> -		alloc_frag->offset = sizeof(*dma);
> -
> -		rq->last_dma = dma;
> -	}
> -
> -	++dma->ref;
> -
> -	buf = head + alloc_frag->offset;
> -
> -	get_page(alloc_frag->page);
> -	alloc_frag->offset += size;
> +	BUG_ON(!rq->page_pool);
>  
> -	return buf;
> +	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>  }
>  
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> @@ -1067,9 +949,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>  		return;
>  	}
>  
> -	if (!vi->big_packets || vi->mergeable_rx_bufs)
> -		virtnet_rq_unmap(rq, buf, 0);
> -
>  	virtnet_rq_free_buf(vi, rq, buf);
>  }
>  
> @@ -1335,7 +1214,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>  
>  		truesize = len;
>  
> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>  						    buf, len, truesize);
>  		if (!curr_skb) {
>  			put_page(page);
> @@ -1771,7 +1650,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	return ret;
>  }
>  
> -static void put_xdp_frags(struct xdp_buff *xdp)
> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>  {
>  	struct skb_shared_info *shinfo;
>  	struct page *xdp_page;
> @@ -1781,7 +1660,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>  		shinfo = xdp_get_shared_info_from_buff(xdp);
>  		for (i = 0; i < shinfo->nr_frags; i++) {
>  			xdp_page = skb_frag_page(&shinfo->frags[i]);
> -			put_page(xdp_page);
> +			page_pool_put_page(rq->page_pool, xdp_page, -1, true);
>  		}
>  	}
>  }
> @@ -1873,7 +1752,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  	if (page_off + *len + tailroom > PAGE_SIZE)
>  		return NULL;
>  
> -	page = alloc_page(GFP_ATOMIC);
> +	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>  	if (!page)
>  		return NULL;
>  
> @@ -1896,8 +1775,12 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  		p = virt_to_head_page(buf);
>  		off = buf - page_address(p);
>  
> +		if (rq->use_page_pool_dma)
> +			page_pool_dma_sync_for_cpu(rq->page_pool, p,
> +						   off, buflen);
> +
>  		if (check_mergeable_len(dev, ctx, buflen)) {
> -			put_page(p);
> +			page_pool_put_page(rq->page_pool, p, -1, true);
>  			goto err_buf;
>  		}
>  
> @@ -1905,21 +1788,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  		 * is sending packet larger than the MTU.
>  		 */
>  		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> -			put_page(p);
> +			page_pool_put_page(rq->page_pool, p, -1, true);
>  			goto err_buf;
>  		}
>  
>  		memcpy(page_address(page) + page_off,
>  		       page_address(p) + off, buflen);
>  		page_off += buflen;
> -		put_page(p);
> +		page_pool_put_page(rq->page_pool, p, -1, true);
>  	}
>  
>  	/* Headroom does not contribute to packet length */
>  	*len = page_off - XDP_PACKET_HEADROOM;
>  	return page;
>  err_buf:
> -	__free_pages(page, 0);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	return NULL;
>  }
>  
> @@ -1996,7 +1879,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  			goto err_xdp;
>  
>  		buf = page_address(xdp_page);
> -		put_page(page);
> +		page_pool_put_page(rq->page_pool, page, -1, true);
>  		page = xdp_page;
>  	}
>  
> @@ -2028,13 +1911,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>  
> +	skb_mark_for_recycle(skb);
> +
>  	return skb;
>  
>  err_xdp:
>  	u64_stats_inc(&stats->xdp_drops);
>  err:
>  	u64_stats_inc(&stats->drops);
> -	put_page(page);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  xdp_xmit:
>  	return NULL;
>  }
> @@ -2056,6 +1941,13 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	 */
>  	buf -= VIRTNET_RX_PAD + xdp_headroom;
>  
> +	if (rq->use_page_pool_dma) {
> +		int offset = buf - page_address(page) +
> +			     VIRTNET_RX_PAD + xdp_headroom;
> +
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> +	}
> +
>  	len -= vi->hdr_len;
>  	u64_stats_add(&stats->bytes, len);
>  
> @@ -2082,12 +1974,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	}
>  
>  	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
> -	if (likely(skb))
> +	if (likely(skb)) {
> +		skb_mark_for_recycle(skb);
>  		return skb;
> +	}
>  
>  err:
>  	u64_stats_inc(&stats->drops);
> -	put_page(page);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	return NULL;
>  }
>  
> @@ -2142,7 +2036,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>  		}
>  		u64_stats_add(&stats->bytes, len);
>  		page = virt_to_head_page(buf);
> -		put_page(page);
> +		page_pool_put_page(rq->page_pool, page, -1, true);
>  	}
>  }
>  
> @@ -2252,8 +2146,12 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  		page = virt_to_head_page(buf);
>  		offset = buf - page_address(page);
>  
> +		if (rq->use_page_pool_dma)
> +			page_pool_dma_sync_for_cpu(rq->page_pool, page,
> +						   offset, len);
> +
>  		if (check_mergeable_len(dev, ctx, len)) {
> -			put_page(page);
> +			page_pool_put_page(rq->page_pool, page, -1, true);
>  			goto err;
>  		}
>  
> @@ -2272,7 +2170,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  	return 0;
>  
>  err:
> -	put_xdp_frags(xdp);
> +	put_xdp_frags(rq, xdp);
>  	return -EINVAL;
>  }
>  
> @@ -2337,7 +2235,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  		if (*len + xdp_room > PAGE_SIZE)
>  			return NULL;
>  
> -		xdp_page = alloc_page(GFP_ATOMIC);
> +		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>  		if (!xdp_page)
>  			return NULL;
>  
> @@ -2347,7 +2245,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  
>  	*frame_sz = PAGE_SIZE;
>  
> -	put_page(*page);
> +	page_pool_put_page(rq->page_pool, *page, -1, true);
>  
>  	*page = xdp_page;
>  
> @@ -2393,6 +2291,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>  		if (unlikely(!head_skb))
>  			break;
> +
> +		skb_mark_for_recycle(head_skb);
>  		return head_skb;
>  
>  	case XDP_TX:
> @@ -2403,10 +2303,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		break;
>  	}
>  
> -	put_xdp_frags(&xdp);
> +	put_xdp_frags(rq, &xdp);
>  
>  err_xdp:
> -	put_page(page);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	mergeable_buf_free(rq, num_buf, dev, stats);
>  
>  	u64_stats_inc(&stats->xdp_drops);
> @@ -2414,7 +2314,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  	return NULL;
>  }
>  
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +					       struct sk_buff *head_skb,
>  					       struct sk_buff *curr_skb,
>  					       struct page *page, void *buf,
>  					       int len, int truesize)
> @@ -2429,6 +2330,9 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  		if (unlikely(!nskb))
>  			return NULL;
>  
> +		if (head_skb->pp_recycle)
> +			skb_mark_for_recycle(nskb);
> +
>  		if (curr_skb == head_skb)
>  			skb_shinfo(curr_skb)->frag_list = nskb;
>  		else
> @@ -2446,7 +2350,10 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  
>  	offset = buf - page_address(page);
>  	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> -		put_page(page);
> +		if (head_skb->pp_recycle)
> +			page_pool_put_page(rq->page_pool, page, -1, true);
> +		else
> +			put_page(page);
>  		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>  				     len, truesize);
>  	} else {
> @@ -2475,6 +2382,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>  
>  	head_skb = NULL;
> +
> +	if (rq->use_page_pool_dma)
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> +
>  	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>  
>  	if (check_mergeable_len(dev, ctx, len))
> @@ -2499,6 +2410,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  
>  	if (unlikely(!curr_skb))
>  		goto err_skb;
> +
> +	skb_mark_for_recycle(head_skb);
>  	while (--num_buf) {
>  		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>  		if (unlikely(!buf)) {
> @@ -2513,11 +2426,17 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		u64_stats_add(&stats->bytes, len);
>  		page = virt_to_head_page(buf);
>  
> +		if (rq->use_page_pool_dma) {
> +			offset = buf - page_address(page);
> +			page_pool_dma_sync_for_cpu(rq->page_pool, page,
> +						   offset, len);
> +		}
> +
>  		if (check_mergeable_len(dev, ctx, len))
>  			goto err_skb;
>  
>  		truesize = mergeable_ctx_to_truesize(ctx);
> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>  						    buf, len, truesize);
>  		if (!curr_skb)
>  			goto err_skb;
> @@ -2527,7 +2446,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	return head_skb;
>  
>  err_skb:
> -	put_page(page);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	mergeable_buf_free(rq, num_buf, dev, stats);
>  
>  err_buf:
> @@ -2658,6 +2577,24 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	virtnet_receive_done(vi, rq, skb, flags);
>  }
>  
> +static int virtnet_rq_submit(struct receive_queue *rq, char *buf,
> +			     int len, void *ctx, gfp_t gfp)
> +{
> +	if (rq->use_page_pool_dma) {
> +		struct page *page = virt_to_head_page(buf);
> +		dma_addr_t addr = page_pool_get_dma_addr(page) +
> +				  (buf - (char *)page_address(page));
> +
> +		sg_init_table(rq->sg, 1);
> +		sg_fill_dma(rq->sg, addr, len);
> +		return virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> +						     buf, ctx, gfp);
> +	}
> +
> +	sg_init_one(rq->sg, buf, len);
> +	return virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> +}
> +
>  /* Unlike mergeable buffers, all buffers are allocated to the
>   * same size, except for the headroom. For this reason we do
>   * not need to use  mergeable_len_to_ctx here - it is enough
> @@ -2666,32 +2603,27 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  			     gfp_t gfp)
>  {
> -	char *buf;
>  	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>  	void *ctx = (void *)(unsigned long)xdp_headroom;
> -	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> +	unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> +	unsigned int alloc_len;
> +	char *buf;
>  	int err;
>  
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> -	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> -		return -ENOMEM;
> -


reepating my comment from v9:

> -	buf = virtnet_rq_alloc(rq, len, gfp);
> +	alloc_len = len;
> +	buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);

So alloc_len can increase here when at end of page ...


>  	if (unlikely(!buf))
>  		return -ENOMEM;
>  
>  	buf += VIRTNET_RX_PAD + xdp_headroom;
>  
> -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
> -
> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
> -	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> -		put_page(virt_to_head_page(buf));
> -	}
> +	err = virtnet_rq_submit(rq, buf, vi->hdr_len + GOOD_PACKET_LEN, ctx, gfp);
>  
> +	if (err < 0)
> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
>  	return err;
>  }
>  


but then is not used until end of function and does not update the truesize.



> @@ -2764,13 +2696,12 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>  static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  				 struct receive_queue *rq, gfp_t gfp)
>  {
> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>  	unsigned int headroom = virtnet_get_headroom(vi);
>  	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>  	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
> -	unsigned int len, hole;
> -	void *ctx;
> +	unsigned int len, alloc_len;
>  	char *buf;
> +	void *ctx;
>  	int err;
>  
>  	/* Extra tailroom is needed to satisfy XDP's assumption. This
> @@ -2779,39 +2710,22 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	 */
>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>  
> -	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> -		return -ENOMEM;
> -
> -	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> -		len -= sizeof(struct virtnet_rq_dma);
> -
> -	buf = virtnet_rq_alloc(rq, len + room, gfp);
> +	alloc_len = len + room;
> +	buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
>  
>  	buf += headroom; /* advance address leaving hole at front of pkt */
> -	hole = alloc_frag->size - alloc_frag->offset;
> -	if (hole < len + room) {
> -		/* To avoid internal fragmentation, if there is very likely not
> -		 * enough space for another buffer, add the remaining space to
> -		 * the current buffer.
> -		 * XDP core assumes that frame_size of xdp_buff and the length
> -		 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
> -		 */
> -		if (!headroom)
> -			len += hole;
> -		alloc_frag->offset += hole;
> -	}
>  
> -	virtnet_rq_init_one_sg(rq, buf, len);
> +	if (!headroom)
> +		len = alloc_len - room;
>  
>  	ctx = mergeable_len_to_ctx(len + room, headroom);
> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
> -	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> -		put_page(virt_to_head_page(buf));
> -	}
>  
> +	err = virtnet_rq_submit(rq, buf, len, ctx, gfp);
> +
> +	if (err < 0)
> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
>  	return err;
>  }
>  
> @@ -2963,7 +2877,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  	int packets = 0;
>  	void *buf;
>  
> -	if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +	if (rq->page_pool) {
>  		void *ctx;
>  		while (packets < budget &&
>  		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
> @@ -3128,7 +3042,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  		return err;
>  
>  	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
> -					 MEM_TYPE_PAGE_SHARED, NULL);
> +					 vi->rq[qp_index].page_pool ?
> +						MEM_TYPE_PAGE_POOL :
> +						MEM_TYPE_PAGE_SHARED,
> +					 vi->rq[qp_index].page_pool);
>  	if (err < 0)
>  		goto err_xdp_reg_mem_model;
>  
> @@ -3168,6 +3085,82 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>  		vi->duplex = duplex;
>  }
>  
> +static int virtnet_create_page_pools(struct virtnet_info *vi)
> +{
> +	int i, err;
> +
> +	if (vi->big_packets && !vi->mergeable_rx_bufs)
> +		return 0;
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		struct receive_queue *rq = &vi->rq[i];
> +		struct page_pool_params pp_params = { 0 };
> +		struct device *dma_dev;
> +
> +		if (rq->page_pool)
> +			continue;
> +
> +		if (rq->xsk_pool)
> +			continue;
> +
> +		pp_params.order = 0;
> +		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
> +		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
> +		pp_params.netdev = vi->dev;
> +		pp_params.napi = &rq->napi;
> +
> +		/* Use page_pool DMA mapping if backend supports DMA API.
> +		 * DMA_SYNC_DEV is needed for non-coherent archs on recycle.
> +		 */
> +		dma_dev = virtqueue_dma_dev(rq->vq);
> +		if (dma_dev) {
> +			pp_params.dev = dma_dev;
> +			pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +			pp_params.dma_dir = DMA_FROM_DEVICE;
> +			pp_params.max_len = PAGE_SIZE;
> +			pp_params.offset = 0;
> +			rq->use_page_pool_dma = true;
> +		} else {
> +			/* No DMA API (e.g., VDUSE): page_pool for allocation only. */
> +			pp_params.flags = 0;
> +			rq->use_page_pool_dma = false;
> +		}
> +
> +		rq->page_pool = page_pool_create(&pp_params);
> +		if (IS_ERR(rq->page_pool)) {
> +			err = PTR_ERR(rq->page_pool);
> +			rq->page_pool = NULL;
> +			goto err_cleanup;
> +		}
> +	}
> +	return 0;
> +
> +err_cleanup:
> +	while (--i >= 0) {
> +		struct receive_queue *rq = &vi->rq[i];
> +
> +		if (rq->page_pool) {
> +			page_pool_destroy(rq->page_pool);
> +			rq->page_pool = NULL;
> +		}
> +	}
> +	return err;
> +}
> +
> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		struct receive_queue *rq = &vi->rq[i];
> +
> +		if (rq->page_pool) {
> +			page_pool_destroy(rq->page_pool);
> +			rq->page_pool = NULL;
> +		}
> +	}
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -5715,6 +5708,10 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  	if (err)
>  		return err;
>  
> +	err = virtnet_create_page_pools(vi);
> +	if (err)
> +		goto err_del_vqs;
> +
>  	virtio_device_ready(vdev);
>  
>  	enable_rx_mode_work(vi);
> @@ -5724,12 +5721,24 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  		err = virtnet_open(vi->dev);
>  		rtnl_unlock();
>  		if (err)
> -			return err;
> +			goto err_destroy_pools;
>  	}
>  
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> +	return 0;
> +
> +err_destroy_pools:
> +	virtio_reset_device(vdev);
> +	free_unused_bufs(vi);
> +	virtnet_destroy_page_pools(vi);
> +	virtnet_del_vqs(vi);
> +	return err;
> +
> +err_del_vqs:
> +	virtio_reset_device(vdev);
> +	virtnet_del_vqs(vi);
>  	return err;
>  }
>  
> @@ -5857,7 +5866,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	/* In big_packets mode, xdp cannot work, so there is no need to
>  	 * initialize xsk of rq.
>  	 */
> -	if (vi->big_packets && !vi->mergeable_rx_bufs)
> +	if (!vi->rq[qid].page_pool)
>  		return -ENOENT;
>  
>  	if (qid >= vi->curr_queue_pairs)
> @@ -6287,17 +6296,6 @@ static void free_receive_bufs(struct virtnet_info *vi)
>  	rtnl_unlock();
>  }
>  
> -static void free_receive_page_frags(struct virtnet_info *vi)
> -{
> -	int i;
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		if (vi->rq[i].alloc_frag.page) {
> -			if (vi->rq[i].last_dma)
> -				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
> -			put_page(vi->rq[i].alloc_frag.page);
> -		}
> -}
> -
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
> @@ -6401,7 +6399,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  	vqs_info = kzalloc_objs(*vqs_info, total_vqs);
>  	if (!vqs_info)
>  		goto err_vqs_info;
> -	if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +	if (vi->mergeable_rx_bufs || !vi->big_packets) {
>  		ctx = kzalloc_objs(*ctx, total_vqs);
>  		if (!ctx)
>  			goto err_ctx;
> @@ -6441,10 +6439,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
>  		vi->sq[i].vq = vqs[txq2vq(i)];
>  	}
> -
>  	/* run here: ret == 0. */
>  
> -
>  err_find:
>  	kfree(ctx);
>  err_ctx:
> @@ -6945,6 +6941,14 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			goto free;
>  	}
>  
> +	/* Create page pools for receive queues.
> +	 * Page pools are created at probe time so they can be used
> +	 * with premapped DMA addresses throughout the device lifetime.
> +	 */
> +	err = virtnet_create_page_pools(vi);
> +	if (err)
> +		goto free_irq_moder;
> +
>  #ifdef CONFIG_SYSFS
>  	if (vi->mergeable_rx_bufs)
>  		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
> @@ -6958,7 +6962,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->failover = net_failover_create(vi->dev);
>  		if (IS_ERR(vi->failover)) {
>  			err = PTR_ERR(vi->failover);
> -			goto free_vqs;
> +			goto free_page_pools;
>  		}
>  	}
>  
> @@ -7075,9 +7079,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	unregister_netdev(dev);
>  free_failover:
>  	net_failover_destroy(vi->failover);
> -free_vqs:
> +free_page_pools:
> +	virtnet_destroy_page_pools(vi);
> +free_irq_moder:
> +	virtnet_free_irq_moder(vi);
>  	virtio_reset_device(vdev);
> -	free_receive_page_frags(vi);
>  	virtnet_del_vqs(vi);
>  free:
>  	free_netdev(dev);
> @@ -7102,7 +7108,7 @@ static void remove_vq_common(struct virtnet_info *vi)
>  
>  	free_receive_bufs(vi);
>  
> -	free_receive_page_frags(vi);
> +	virtnet_destroy_page_pools(vi);
>  
>  	virtnet_del_vqs(vi);
>  }
> -- 
> 2.47.3


