Return-Path: <netdev+bounces-254520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDJ8CO3Lemmu+gEAu9opvQ
	(envelope-from <netdev+bounces-254520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:54:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6663AB44F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5E72300599B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D23596E8;
	Thu, 29 Jan 2026 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIMoIkFD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vnrl6eQI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E76357A52
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655273; cv=pass; b=nYQQHglW4jEZjne2jcD9BMaqKQYrj4dqzTanF2td0RDwdHLXm6Ig7QWHxR9I7hVPp827yRbr2NugFGvEFjBtD/1qpOFJl61VaH5lvFDWuDJXFCCAdDcq7/6Z9vTHrykp8G38pG+8dd2L/lW5jYuYDExhT65xpcrSjJiWZr/Mt6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655273; c=relaxed/simple;
	bh=3++DLxY8b+hXcjWzkAUBOTkvJ5IO6iL1BqojY8N8YTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dURJEQVR5/KPiGBBraP55HkSfYpRhqXg+YV+CeAPxyIZZnRUDtnZgjoHeZQCYlsOliuNbCMs6cMQV1ix2i7D9I2ZPqVazWElovmQisaf+v6oK1k7gTVf/s+KeF3DUtGLlAhkgoR/77v9u0T+Vh9AoL1Ytn10jU1vQY6/n+u5I7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIMoIkFD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vnrl6eQI; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769655264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwXsP6EOSE0xF26dGbuyMlNisZeP3XeMsruwC/nVwAE=;
	b=PIMoIkFDj7MkhLQQT6olrCo+2DaWo8U5p+D8pHpt6ZQDK7E4I03kpFK8G8/sjhZCNDzx+r
	rTaVrDkoLEJZp4GnnRpMG/G4+HNbYv+3HQcJ6RbIJUOpc64G89aDlYxOmN0Mf6QPGNf32+
	p5YsWLO0q2ba6B7UDa//mrK4pYEIKcY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-_vTO8sJnMmqo8M5-WowIpw-1; Wed, 28 Jan 2026 21:54:22 -0500
X-MC-Unique: _vTO8sJnMmqo8M5-WowIpw-1
X-Mimecast-MFC-AGG-ID: _vTO8sJnMmqo8M5-WowIpw_1769655262
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a13be531b2so4441355ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769655262; cv=none;
        d=google.com; s=arc-20240605;
        b=Vod1Q+le3izTRrjOKIEVxaJBrQ5RcR8ijsSCKpJ4iNxtax933HGqMEvkSpWx/Tolhp
         OBudbM4v+ZoXongQS/POltukA7Sj2xZGS+1p91Wr5s1C/UzP5Wa7Bx8hMjyDyDT0O15r
         dLlXgRETrRcyePtaPQwwd06RZaYNF9+Q/p+yG5DD7+JOiPHFHSYhcJsfQkJGp3c9G4y7
         6kax7U7mTo5PtCLVEAtKlfHZzBWdv7nKLcIJa36UlumqXI2B5H3MyWJQK6SBuhm3eA8Q
         lLV28lz3cnWKs7nv70I3xt7B1c2uNxClUtOlbnPxGXRgSNLzg715iACcq8zt7fyghLLO
         y5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SwXsP6EOSE0xF26dGbuyMlNisZeP3XeMsruwC/nVwAE=;
        fh=NB4i04L8DsY8WzIo+j2Db1bv6j55DKlRAvCWC7Di95w=;
        b=GTwMbBpTGNYxArvFjirot/bsqItK4hGv7r4STqDt+xkgmFfEw6MvpgtsBY8WFJ8wwG
         AYB4YwXVE5QAIVaRtIPg0YF/jfdRv3DgRyuiLDcctI/lVHRf7qnNXVONmHjd5bHWPUNm
         1mPcto8oVAwYYWTzKDafBpk6THi7jKX5MwIbsfBh8yidKrmfC5R7VMGAoI1zdTPjGWdr
         3bRsOHwH6u9NTA1jeGFWYIR8yFgZth1MPAMxWACQGONqVSyP4BlTWnRfTZaiz9sTdeF1
         nco8SqoMAvX/A5jBiIfr8t0bfuFFWyiL9PLMwLgSrcPSW04m06YugzeyI+/FotfplpeA
         J/Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769655262; x=1770260062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwXsP6EOSE0xF26dGbuyMlNisZeP3XeMsruwC/nVwAE=;
        b=Vnrl6eQIYWhd/bjz4LRKKP4wTKtudz+t/qqz4k3KlDAf9WX2T3rfGg6UVqBTwHMUhq
         qMfYyjfEM40u0+7MYqalbyxRb1Zi8+WNNB+VD8C7SMhR4zGS24L8/xi7kIBUT2cYq7gS
         HwOp3FdZBf2PBo3Plh7715UMWDXmKp+aEF6J/PA7tMTqIt9GtJQft5ut0RD3VXCtL4h8
         jPIiwF76pOM4rQkTzvOlN/8GzVy3ZM9gIUW/XWQo9yqIpu+xw2HkjCfbErSkdIHFfFtK
         2jqxvg7PUx5goHqx21xb15IlDEurx8yLtacRtwrrdXk+duSMV/bBR5vUM40AxOPK78Kz
         TiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769655262; x=1770260062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SwXsP6EOSE0xF26dGbuyMlNisZeP3XeMsruwC/nVwAE=;
        b=c8CKJ+SbAVOluWvJzl3u0CUWfGYgDeGB7NWRq0FQbHaMh13nhEQuBcrD11pS7iLy0s
         th8GSK5dE1X+n5KvcP8uRFQ+xmU5hsJy+9oGNVF624Gn3gMO1/sJvLvn4OQ6edr/7gYw
         iw29WIZN9rCd/m+VMpswlutYvxMWyAkXBE7dAeyzfK/rrkI8hUcuHuAe6Zusf9JW7WE/
         6EsJvvIGDsVrjOpBDxeFG7uSHUzQT5VBIaRiXoynyLS54TMKsEtoSwTQpigk6bwcXuB0
         Cait/xFR8bLoPoR8GB8+8gnxm4b85jR8wHGGq/Q3Yg3Cet5KEmr5QoziETZHUdPSEZ/R
         RUfA==
X-Forwarded-Encrypted: i=1; AJvYcCVSBGmRnwHlkb2EU/uulS4F1Dbf90ESvukSoMhSjuQ+lC/KHz+r6WAjOr1R4+7ErF2nsieEArQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjf4rRWdEf8lSn/3X9WqiCdFTn2YxvC/xAshX5c/IV9ZKf4Rd
	0VF2fHvIpj0EPToLgNoxEnTid/+Lt2Svz3mmwXu8Efot38XVEzMsyllYBVAcPT+XE9BfotpHxZD
	q7pgnZpGKIOpk34p8BKTbvPim/b2KxpsHBTgB8dG2A/dr1TRba3MojUeq0DlTutdIS8ocQtHD34
	P1ro1dY44ijG95wJ+6ecpCkqE51IPVlKgA
X-Gm-Gg: AZuq6aIDkC/hWp7jINdHa8BGN2sdcWQdmZCQ9rcDcWhsI5Fcpy6XukhAbVh0Enhi4bk
	YDw+TwYtVhlrn9jiNVVI1MzSr0nm/gTq3ZlxJecFGFK+dl2t8Bas1N4xXYYth1Z3YbqsZXEy1ws
	93oB+OtnWv8hB1FwHAkJg9aG/lRH8HQdTks1ZZczoyilMyyx7CxOBVemrQz+mNwmWB
X-Received: by 2002:a17:902:d4cf:b0:2a8:7827:bb32 with SMTP id d9443c01a7336-2a87827bd1amr66619835ad.15.1769655261255;
        Wed, 28 Jan 2026 18:54:21 -0800 (PST)
X-Received: by 2002:a17:902:d4cf:b0:2a8:7827:bb32 with SMTP id
 d9443c01a7336-2a87827bd1amr66619535ad.15.1769655260587; Wed, 28 Jan 2026
 18:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128212031.1431746-1-vishs@meta.com> <20260128212031.1431746-2-vishs@meta.com>
In-Reply-To: <20260128212031.1431746-2-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jan 2026 10:54:08 +0800
X-Gm-Features: AZwV_QikU-UgDxV8Mssi_mdr2yQfyE2ERhJ8s7zxq9j5fzvf9EkkvfjyEVRNpok
Message-ID: <CACGkMEtdEQzTfbAM23acZ1VJtuGb37oTDqyNctfRLMYDWMb-Tw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] virtio_net: add page_pool support for
 buffer allocation
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254520-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B6663AB44F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 5:20=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.co=
m> wrote:
>
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
> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
> sending control virtqueue commands while ndo_close is tearing down
> device state, avoiding virtqueue corruption during concurrent operations.
>
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 353 ++++++++++++++++++++++-----------------
>  2 files changed, 203 insertions(+), 151 deletions(-)
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index ac12eaf11755..f1e6b6b0a86f 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -450,6 +450,7 @@ config VIRTIO_NET
>         depends on VIRTIO
>         select NET_FAILOVER
>         select DIMLIB
> +       select PAGE_POOL
>         help
>           This is the virtual network driver for virtio.  It can be used =
with
>           QEMU based VMMs (like KVM or Xen).  Say Y or M.
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..df2a5fc5187e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <net/page_pool/helpers.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -359,6 +360,11 @@ struct receive_queue {
>         /* Page frag for packet buffer allocation. */
>         struct page_frag alloc_frag;
>
> +       struct page_pool *page_pool;
> +
> +       /* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
> +       bool use_page_pool_dma;
> +
>         /* RX: fragments + linear part + virtio header */
>         struct scatterlist sg[MAX_SKB_FRAGS + 2];
>
> @@ -521,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp=
_prog, struct xdp_buff *xdp,
>                                struct virtnet_rq_stats *stats);
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive=
_queue *rq,
>                                  struct sk_buff *skb, u8 flags);
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +                                              struct sk_buff *head_skb,
>                                                struct sk_buff *curr_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize);
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> +static void free_unused_bufs(struct virtnet_info *vi);
>
>  enum virtnet_xmit_type {
>         VIRTNET_XMIT_TYPE_SKB,
> @@ -706,15 +714,21 @@ static struct page *get_a_page(struct receive_queue=
 *rq, gfp_t gfp_mask)
>         return p;
>  }
>
> +static void virtnet_put_page(struct receive_queue *rq, struct page *page=
,
> +                            bool allow_direct)
> +{
> +       page_pool_put_page(rq->page_pool, page, -1, allow_direct);
> +}
> +
>  static void virtnet_rq_free_buf(struct virtnet_info *vi,
>                                 struct receive_queue *rq, void *buf)
>  {
>         if (vi->mergeable_rx_bufs)
> -               put_page(virt_to_head_page(buf));
> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>         else if (vi->big_packets)
>                 give_pages(rq, buf);
>         else
> -               put_page(virt_to_head_page(buf));
> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>  }
>
>  static void enable_rx_mode_work(struct virtnet_info *vi)
> @@ -877,9 +891,6 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                 if (unlikely(!skb))
>                         return NULL;
>
> -               page =3D (struct page *)page->private;
> -               if (page)
> -                       give_pages(rq, page);

Note that the page_to_skb() will be used by the big mode. So this
change may break big mode.

>                 goto ok;
>         }
>
> @@ -914,18 +925,14 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
>                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
>                                 frag_size, truesize);
>                 len -=3D frag_size;
> -               page =3D (struct page *)page->private;

And this.

>                 offset =3D 0;
>         }
>
> -       if (page)
> -               give_pages(rq, page);
> -
>  ok:
>         hdr =3D skb_vnet_common_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
>         if (page_to_free)
> -               put_page(page_to_free);
> +               virtnet_put_page(rq, page_to_free, true);
>
>         return skb;
>  }
> @@ -965,93 +972,10 @@ static void virtnet_rq_unmap(struct receive_queue *=
rq, void *buf, u32 len)
>  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void=
 **ctx)
>  {
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       void *buf;
> -
> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -       if (buf)
> -               virtnet_rq_unmap(rq, buf, *len);
> -
> -       return buf;
> -}
> -
> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, =
u32 len)
> -{
> -       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct virtnet_rq_dma *dma;
> -       dma_addr_t addr;
> -       u32 offset;
> -       void *head;
> -
> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -       head =3D page_address(rq->alloc_frag.page);
> -
> -       offset =3D buf - head;
> -
> -       dma =3D head;
> -
> -       addr =3D dma->addr - sizeof(*dma) + offset;
> -
> -       sg_init_table(rq->sg, 1);
> -       sg_fill_dma(rq->sg, addr, len);
> -}
> -
> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t =
gfp)
> -{
> -       struct page_frag *alloc_frag =3D &rq->alloc_frag;
> -       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct virtnet_rq_dma *dma;
> -       void *buf, *head;
> -       dma_addr_t addr;
>
>         BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>
> -       head =3D page_address(alloc_frag->page);
> -
> -       dma =3D head;
> -
> -       /* new pages */
> -       if (!alloc_frag->offset) {
> -               if (rq->last_dma) {
> -                       /* Now, the new page is allocated, the last dma
> -                        * will not be used. So the dma can be unmapped
> -                        * if the ref is 0.
> -                        */
> -                       virtnet_rq_unmap(rq, rq->last_dma, 0);
> -                       rq->last_dma =3D NULL;
> -               }
> -
> -               dma->len =3D alloc_frag->size - sizeof(*dma);
> -
> -               addr =3D virtqueue_map_single_attrs(rq->vq, dma + 1,
> -                                                 dma->len, DMA_FROM_DEVI=
CE, 0);
> -               if (virtqueue_map_mapping_error(rq->vq, addr))
> -                       return NULL;
> -
> -               dma->addr =3D addr;
> -               dma->need_sync =3D virtqueue_map_need_sync(rq->vq, addr);
> -
> -               /* Add a reference to dma to prevent the entire dma from
> -                * being released during error handling. This reference
> -                * will be freed after the pages are no longer used.
> -                */
> -               get_page(alloc_frag->page);
> -               dma->ref =3D 1;
> -               alloc_frag->offset =3D sizeof(*dma);
> -
> -               rq->last_dma =3D dma;
> -       }
> -
> -       ++dma->ref;
> -
> -       buf =3D head + alloc_frag->offset;
> -
> -       get_page(alloc_frag->page);
> -       alloc_frag->offset +=3D size;
> -
> -       return buf;
> +       return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>  }
>
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> @@ -1067,9 +991,6 @@ static void virtnet_rq_unmap_free_buf(struct virtque=
ue *vq, void *buf)
>                 return;
>         }
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
> -               virtnet_rq_unmap(rq, buf, 0);
> -
>         virtnet_rq_free_buf(vi, rq, buf);
>  }
>
> @@ -1335,7 +1256,7 @@ static int xsk_append_merge_buffer(struct virtnet_i=
nfo *vi,
>
>                 truesize =3D len;
>
> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_skb,=
 page,
> +               curr_skb  =3D virtnet_skb_append_frag(rq, head_skb, curr_=
skb, page,
>                                                     buf, len, truesize);
>                 if (!curr_skb) {
>                         put_page(page);
> @@ -1771,7 +1692,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         return ret;
>  }
>
> -static void put_xdp_frags(struct xdp_buff *xdp)
> +static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq=
)
>  {
>         struct skb_shared_info *shinfo;
>         struct page *xdp_page;
> @@ -1781,7 +1702,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>                 shinfo =3D xdp_get_shared_info_from_buff(xdp);
>                 for (i =3D 0; i < shinfo->nr_frags; i++) {
>                         xdp_page =3D skb_frag_page(&shinfo->frags[i]);
> -                       put_page(xdp_page);
> +                       virtnet_put_page(rq, xdp_page, true);
>                 }
>         }
>  }
> @@ -1897,7 +1818,7 @@ static struct page *xdp_linearize_page(struct net_d=
evice *dev,
>                 off =3D buf - page_address(p);
>
>                 if (check_mergeable_len(dev, ctx, buflen)) {
> -                       put_page(p);
> +                       virtnet_put_page(rq, p, true);
>                         goto err_buf;
>                 }
>
> @@ -1905,14 +1826,14 @@ static struct page *xdp_linearize_page(struct net=
_device *dev,
>                  * is sending packet larger than the MTU.
>                  */
>                 if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> -                       put_page(p);
> +                       virtnet_put_page(rq, p, true);
>                         goto err_buf;
>                 }
>
>                 memcpy(page_address(page) + page_off,
>                        page_address(p) + off, buflen);
>                 page_off +=3D buflen;
> -               put_page(p);
> +               virtnet_put_page(rq, p, true);
>         }
>
>         /* Headroom does not contribute to packet length */
> @@ -1962,7 +1883,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>         unsigned int headroom =3D vi->hdr_len + header_offset;
>         struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf + header_offset;
>         struct page *page =3D virt_to_head_page(buf);
> -       struct page *xdp_page;
> +       struct page *xdp_page =3D NULL;
>         unsigned int buflen;
>         struct xdp_buff xdp;
>         struct sk_buff *skb;
> @@ -1996,7 +1917,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>                         goto err_xdp;
>
>                 buf =3D page_address(xdp_page);
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>                 page =3D xdp_page;
>         }
>
> @@ -2028,13 +1949,19 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
>         if (metasize)
>                 skb_metadata_set(skb, metasize);
>
> +       if (!xdp_page)
> +               skb_mark_for_recycle(skb);

I wonder would it better to use page pool in xdp_linearize_page() as
well to simply the codes here?

> +
>         return skb;
>
>  err_xdp:
>         u64_stats_inc(&stats->xdp_drops);
>  err:
>         u64_stats_inc(&stats->drops);
> -       put_page(page);
> +       if (xdp_page)
> +               put_page(page);
> +       else
> +               virtnet_put_page(rq, page, true);

And here, and the similar path in mergeable XDP handling.

>  xdp_xmit:
>         return NULL;
>  }
> @@ -2082,12 +2009,14 @@ static struct sk_buff *receive_small(struct net_d=
evice *dev,
>         }
>
>         skb =3D receive_small_build_skb(vi, xdp_headroom, buf, len);
> -       if (likely(skb))
> +       if (likely(skb)) {
> +               skb_mark_for_recycle(skb);
>                 return skb;
> +       }
>
>  err:
>         u64_stats_inc(&stats->drops);
> -       put_page(page);
> +       virtnet_put_page(rq, page, true);
>         return NULL;
>  }
>
> @@ -2142,7 +2071,7 @@ static void mergeable_buf_free(struct receive_queue=
 *rq, int num_buf,
>                 }
>                 u64_stats_add(&stats->bytes, len);
>                 page =3D virt_to_head_page(buf);
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>         }
>  }
>
> @@ -2253,7 +2182,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>                 offset =3D buf - page_address(page);
>
>                 if (check_mergeable_len(dev, ctx, len)) {
> -                       put_page(page);
> +                       virtnet_put_page(rq, page, true);
>                         goto err;
>                 }
>
> @@ -2272,7 +2201,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>         return 0;
>
>  err:
> -       put_xdp_frags(xdp);
> +       put_xdp_frags(xdp, rq);
>         return -EINVAL;
>  }
>
> @@ -2347,7 +2276,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>
>         *frame_sz =3D PAGE_SIZE;
>
> -       put_page(*page);
> +       virtnet_put_page(rq, *page, true);
>
>         *page =3D xdp_page;
>
> @@ -2369,6 +2298,7 @@ static struct sk_buff *receive_mergeable_xdp(struct=
 net_device *dev,
>         struct page *page =3D virt_to_head_page(buf);
>         int offset =3D buf - page_address(page);
>         unsigned int xdp_frags_truesz =3D 0;
> +       struct page *org_page =3D page;
>         struct sk_buff *head_skb;
>         unsigned int frame_sz;
>         struct xdp_buff xdp;
> @@ -2393,6 +2323,8 @@ static struct sk_buff *receive_mergeable_xdp(struct=
 net_device *dev,
>                 head_skb =3D build_skb_from_xdp_buff(dev, vi, &xdp, xdp_f=
rags_truesz);
>                 if (unlikely(!head_skb))
>                         break;
> +               if (page =3D=3D org_page)
> +                       skb_mark_for_recycle(head_skb);
>                 return head_skb;
>
>         case XDP_TX:
> @@ -2403,10 +2335,13 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
>                 break;
>         }
>
> -       put_xdp_frags(&xdp);
> +       put_xdp_frags(&xdp, rq);
>
>  err_xdp:
> -       put_page(page);
> +       if (page !=3D org_page)
> +               put_page(page);
> +       else
> +               virtnet_put_page(rq, page, true);
>         mergeable_buf_free(rq, num_buf, dev, stats);
>
>         u64_stats_inc(&stats->xdp_drops);
> @@ -2414,7 +2349,8 @@ static struct sk_buff *receive_mergeable_xdp(struct=
 net_device *dev,
>         return NULL;
>  }
>
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +                                              struct sk_buff *head_skb,
>                                                struct sk_buff *curr_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize)
> @@ -2446,7 +2382,7 @@ static struct sk_buff *virtnet_skb_append_frag(stru=
ct sk_buff *head_skb,
>
>         offset =3D buf - page_address(page);
>         if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>                 skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>                                      len, truesize);
>         } else {
> @@ -2495,10 +2431,12 @@ static struct sk_buff *receive_mergeable(struct n=
et_device *dev,
>         }
>
>         head_skb =3D page_to_skb(vi, rq, page, offset, len, truesize, hea=
droom);
> +       if (unlikely(!head_skb))
> +               goto err_skb;
> +
>         curr_skb =3D head_skb;
>
> -       if (unlikely(!curr_skb))
> -               goto err_skb;

This change sees to be useless?

> +       skb_mark_for_recycle(head_skb);
>         while (--num_buf) {
>                 buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
>                 if (unlikely(!buf)) {
> @@ -2517,7 +2455,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>                         goto err_skb;
>
>                 truesize =3D mergeable_ctx_to_truesize(ctx);
> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_skb,=
 page,
> +               curr_skb  =3D virtnet_skb_append_frag(rq, head_skb, curr_=
skb, page,
>                                                     buf, len, truesize);
>                 if (!curr_skb)
>                         goto err_skb;
> @@ -2527,7 +2465,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>         return head_skb;
>
>  err_skb:
> -       put_page(page);
> +       virtnet_put_page(rq, page, true);
>         mergeable_buf_free(rq, num_buf, dev, stats);
>
>  err_buf:
> @@ -2666,6 +2604,8 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>  static int add_recvbuf_small(struct virtnet_info *vi, struct receive_que=
ue *rq,
>                              gfp_t gfp)
>  {
> +       unsigned int offset;
> +       struct page *page;
>         char *buf;
>         unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
>         void *ctx =3D (void *)(unsigned long)xdp_headroom;
> @@ -2675,23 +2615,30 @@ static int add_recvbuf_small(struct virtnet_info =
*vi, struct receive_queue *rq,
>         len =3D SKB_DATA_ALIGN(len) +
>               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> -       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> -               return -ENOMEM;
> -
> -       buf =3D virtnet_rq_alloc(rq, len, gfp);
> -       if (unlikely(!buf))
> +       page =3D page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
> +       if (unlikely(!page))
>                 return -ENOMEM;
>
> +       buf =3D page_address(page) + offset;
>         buf +=3D VIRTNET_RX_PAD + xdp_headroom;
>
> -       virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
> +       sg_init_table(rq->sg, 1);
>
> -       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx=
, gfp);
> -       if (err < 0) {
> -               virtnet_rq_unmap(rq, buf, 0);
> -               put_page(virt_to_head_page(buf));
> +       if (rq->use_page_pool_dma) {
> +               dma_addr_t addr =3D page_pool_get_dma_addr(page) + offset=
;
> +
> +               addr +=3D VIRTNET_RX_PAD + xdp_headroom;
> +               sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
> +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, =
buf,
> +                                                   ctx, gfp);
> +       } else {
> +               sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_LEN=
);
> +               err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, c=
tx, gfp);
>         }
>
> +       if (err < 0)
> +               page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
> +                                  -1, false);
>         return err;
>  }
>
> @@ -2764,11 +2711,12 @@ static unsigned int get_mergeable_buf_len(struct =
receive_queue *rq,
>  static int add_recvbuf_mergeable(struct virtnet_info *vi,
>                                  struct receive_queue *rq, gfp_t gfp)
>  {
> -       struct page_frag *alloc_frag =3D &rq->alloc_frag;
>         unsigned int headroom =3D virtnet_get_headroom(vi);
>         unsigned int tailroom =3D headroom ? sizeof(struct skb_shared_inf=
o) : 0;
>         unsigned int room =3D SKB_DATA_ALIGN(headroom + tailroom);
>         unsigned int len, hole;
> +       unsigned int offset;
> +       struct page *page;
>         void *ctx;
>         char *buf;
>         int err;
> @@ -2779,18 +2727,14 @@ static int add_recvbuf_mergeable(struct virtnet_i=
nfo *vi,
>          */
>         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>
> -       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> -               return -ENOMEM;
> -
> -       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_=
dma) > alloc_frag->size)
> -               len -=3D sizeof(struct virtnet_rq_dma);
> -
> -       buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> -       if (unlikely(!buf))
> +       page =3D page_pool_alloc_frag(rq->page_pool, &offset, len + room,=
 gfp);
> +       if (unlikely(!page))
>                 return -ENOMEM;
>
> +       buf =3D page_address(page) + offset;
>         buf +=3D headroom; /* advance address leaving hole at front of pk=
t */
> -       hole =3D alloc_frag->size - alloc_frag->offset;
> +
> +       hole =3D PAGE_SIZE - (offset + len + room);
>         if (hole < len + room) {
>                 /* To avoid internal fragmentation, if there is very like=
ly not
>                  * enough space for another buffer, add the remaining spa=
ce to
> @@ -2800,18 +2744,27 @@ static int add_recvbuf_mergeable(struct virtnet_i=
nfo *vi,
>                  */
>                 if (!headroom)
>                         len +=3D hole;
> -               alloc_frag->offset +=3D hole;
>         }
>
> -       virtnet_rq_init_one_sg(rq, buf, len);
> -
>         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> -       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx=
, gfp);
> -       if (err < 0) {
> -               virtnet_rq_unmap(rq, buf, 0);
> -               put_page(virt_to_head_page(buf));
> +
> +       sg_init_table(rq->sg, 1);
> +
> +       if (rq->use_page_pool_dma) {
> +               dma_addr_t addr =3D page_pool_get_dma_addr(page) + offset=
;
> +
> +               addr +=3D headroom;
> +               sg_fill_dma(rq->sg, addr, len);
> +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, =
buf,
> +                                                   ctx, gfp);
> +       } else {
> +               sg_set_buf(&rq->sg[0], buf, len);
> +               err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, c=
tx, gfp);
>         }
>
> +       if (err < 0)
> +               page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
> +                                  -1, false);
>         return err;
>  }
>
> @@ -3128,7 +3081,10 @@ static int virtnet_enable_queue_pair(struct virtne=
t_info *vi, int qp_index)
>                 return err;
>
>         err =3D xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
> -                                        MEM_TYPE_PAGE_SHARED, NULL);
> +                                        vi->rq[qp_index].page_pool ?
> +                                               MEM_TYPE_PAGE_POOL :
> +                                               MEM_TYPE_PAGE_SHARED,
> +                                        vi->rq[qp_index].page_pool);
>         if (err < 0)
>                 goto err_xdp_reg_mem_model;
>
> @@ -3168,6 +3124,81 @@ static void virtnet_update_settings(struct virtnet=
_info *vi)
>                 vi->duplex =3D duplex;
>  }
>
> +static int virtnet_create_page_pools(struct virtnet_info *vi)
> +{
> +       int i, err;
> +
> +       for (i =3D 0; i < vi->curr_queue_pairs; i++) {

This should be max_queue_paris, or page pools for new enabled queue
pairs need to be created on demand during set_queues().

> +               struct receive_queue *rq =3D &vi->rq[i];
> +               struct page_pool_params pp_params =3D { 0 };
> +               struct device *dma_dev;
> +
> +               if (rq->page_pool)
> +                       continue;
> +
> +               if (rq->xsk_pool)
> +                       continue;
> +
> +               if (!vi->mergeable_rx_bufs && vi->big_packets)
> +                       continue;
> +
> +               pp_params.order =3D 0;
> +               pp_params.pool_size =3D virtqueue_get_vring_size(rq->vq);
> +               pp_params.nid =3D dev_to_node(vi->vdev->dev.parent);
> +               pp_params.netdev =3D vi->dev;
> +               pp_params.napi =3D &rq->napi;
> +
> +               /* Check if backend supports DMA API (e.g., vhost, virtio=
-pci).
> +                * If so, use page_pool's DMA mapping for premapped buffe=
rs.
> +                * Otherwise (e.g., VDUSE), page_pool only handles alloca=
tion.
> +                */
> +               dma_dev =3D virtqueue_dma_dev(rq->vq);
> +               if (dma_dev) {
> +                       pp_params.dev =3D dma_dev;
> +                       pp_params.flags =3D PP_FLAG_DMA_MAP;
> +                       pp_params.dma_dir =3D DMA_FROM_DEVICE;
> +                       rq->use_page_pool_dma =3D true;
> +               } else {
> +                       pp_params.dev =3D vi->vdev->dev.parent;
> +                       pp_params.flags =3D 0;
> +                       rq->use_page_pool_dma =3D false;
> +               }
> +
> +               rq->page_pool =3D page_pool_create(&pp_params);
> +               if (IS_ERR(rq->page_pool)) {
> +                       err =3D PTR_ERR(rq->page_pool);
> +                       rq->page_pool =3D NULL;
> +                       goto err_cleanup;
> +               }
> +       }
> +       return 0;
> +
> +err_cleanup:
> +       while (--i >=3D 0) {
> +               struct receive_queue *rq =3D &vi->rq[i];
> +
> +               if (rq->page_pool) {
> +                       page_pool_destroy(rq->page_pool);
> +                       rq->page_pool =3D NULL;
> +               }
> +       }
> +       return err;
> +}
> +
> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +               struct receive_queue *rq =3D &vi->rq[i];
> +
> +               if (rq->page_pool) {
> +                       page_pool_destroy(rq->page_pool);
> +                       rq->page_pool =3D NULL;
> +               }
> +       }
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> @@ -3771,6 +3802,8 @@ static int virtnet_close(struct net_device *dev)
>          */
>         cancel_work_sync(&vi->config_work);
>
> +       vi->rx_mode_work_enabled =3D false;
> +
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 virtnet_disable_queue_pair(vi, i);
>                 virtnet_cancel_dim(vi, &vi->rq[i].dim);
> @@ -3807,6 +3840,11 @@ static void virtnet_rx_mode_work(struct work_struc=
t *work)
>
>         rtnl_lock();
>
> +       if (!vi->rx_mode_work_enabled) {
> +               rtnl_unlock();
> +               return;
> +       }

Is this a separated fix? I don't see the connection to the page pool.

> +
>         *promisc_allmulti =3D !!(dev->flags & IFF_PROMISC);
>         sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>
> @@ -6945,6 +6983,14 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>                         goto free;
>         }
>
> +       /* Create page pools for receive queues.
> +        * Page pools are created at probe time so they can be used
> +        * with premapped DMA addresses throughout the device lifetime.
> +        */
> +       err =3D virtnet_create_page_pools(vi);
> +       if (err)
> +               goto free_irq_moder;
> +
>  #ifdef CONFIG_SYSFS
>         if (vi->mergeable_rx_bufs)
>                 dev->sysfs_rx_queue_group =3D &virtio_net_mrg_rx_group;
> @@ -6958,7 +7004,7 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>                 vi->failover =3D net_failover_create(vi->dev);
>                 if (IS_ERR(vi->failover)) {
>                         err =3D PTR_ERR(vi->failover);
> -                       goto free_vqs;
> +                       goto free_page_pools;
>                 }
>         }
>
> @@ -7075,7 +7121,10 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>         unregister_netdev(dev);
>  free_failover:
>         net_failover_destroy(vi->failover);
> -free_vqs:
> +free_page_pools:
> +       virtnet_destroy_page_pools(vi);
> +free_irq_moder:
> +       virtnet_free_irq_moder(vi);
>         virtio_reset_device(vdev);
>         free_receive_page_frags(vi);
>         virtnet_del_vqs(vi);
> @@ -7104,6 +7153,8 @@ static void remove_vq_common(struct virtnet_info *v=
i)
>
>         free_receive_page_frags(vi);
>
> +       virtnet_destroy_page_pools(vi);
> +
>         virtnet_del_vqs(vi);
>  }
>
> --
> 2.47.3
>

Thanks


