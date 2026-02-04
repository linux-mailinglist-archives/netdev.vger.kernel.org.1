Return-Path: <netdev+bounces-256521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E21HI+wgmn/YAMAu9opvQ
	(envelope-from <netdev+bounces-256521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:35:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66CE0E8A
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F4EB300B448
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957F2BEC4E;
	Wed,  4 Feb 2026 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNHeVh7J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUccI0eZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F193D994
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172552; cv=pass; b=l8FvA7b/mzLW1FOcw8rXDJ5CvczwWLZOlm6tsLjPvVGsUKICZNP5t8eVuH6SsWcZ2hhyG69aQlPiqi/+KaDYvIkIuZ1/w2XyKP24uUEBmEeyyKVQZiEsecPGY8JsIhhn96aE+As5UpNh0BvjrRiQAo3GXA9J4bFJwIJg7kD0lT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172552; c=relaxed/simple;
	bh=iAaNt9DR5KG+DoqvriYz6+4cymPhn2gB6+UFiuKFNMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsAUYE9anqyq1SzmGQsSUaxemlTmGk0mp36XJa7h8w1odkoIYM2bsrt/7uvEp+GmCL5hv43HRG4WmReqziWvBy6RxakeLuFm9YtAhII8n0ywk5D0yjjl3SeK/plsM1hDCKdxV1MpQpqlSTX2ajAoNHbGrnVnf6NINIii9JFh7cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNHeVh7J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUccI0eZ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770172549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhKOlfcFWD+uB2awU+d1TWqY24KooxMltjMVauKkIzE=;
	b=TNHeVh7J9PxJPzg4eUe1Vs+038sfmcM+0vsy8xZkcmk3/Ae3foozwjLx8RNyKq7n8q4gSY
	bgjDDy1oQoTmYZwK3ZPGa62O1LftQTy3w20p+HItINOVLGBTlm6vqK4iQLYlu/ln3Sq/59
	PQcI3zHu/Agk5a8eU/CddXbH3MB1Mn4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-I1n2tmdCOYuTV82-zXrjuw-1; Tue, 03 Feb 2026 21:35:48 -0500
X-MC-Unique: I1n2tmdCOYuTV82-zXrjuw-1
X-Mimecast-MFC-AGG-ID: I1n2tmdCOYuTV82-zXrjuw_1770172547
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352de7a89e1so5384815a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 18:35:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770172547; cv=none;
        d=google.com; s=arc-20240605;
        b=Vep3TdhZQYJlheSjxkwq02QAClrnic8+qsd7taXWEijitzxfenSMybnF8LN7fawTF+
         ONLEn9itaXiw5SuCmza5hg4jVvrEl8IM2BPZPV/b4DqSCPAAetRxZSkcepUDPZ7VVMUr
         bWpk2DuQCHdypeklgmk2qp+ql6RzCstM1nvuSgchYBLmKf2iUrdZYS48rFuzJtgjE0E6
         mhpCEAf8stayd7yfc2lfv67CsDqTSJazqp3qT/+7Zi9Q7Yi11fQJVMSw8GLWaVmpO4Dl
         0FKDFOq9MEBW5bK1FAeuKEowbK145l5CYfM+UJf+Ts2n79eLmK4ddSYivmpCKJfabm3k
         YaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EhKOlfcFWD+uB2awU+d1TWqY24KooxMltjMVauKkIzE=;
        fh=LgsozMpvcR/UDWX0FSOSIp9cM7q/Lh8027VwahNT/i4=;
        b=kEu0MUaTjPni9hIQEGjO18dUBQhK0LAqR3hLnN/F25xiy47D06XfKlB2Wvrl8Bnu8M
         /DD936F1ev/PJupdUf9GQEBvDobzxohArEZJ3QwssDtRhFL3cZti/I+5seR9eqpn8TAI
         BFflhSOcfgW4nwrvkc6xPQj7Det7Y94sXDCTTCQHB/P9hExhfXosty61ZCGy7wv7Z3kN
         7Y88SWv/hrNrSbgcemvTBMwjrYmuVbLJqKE22whqvu0OpgUn5cMZjsos1SV9RSz2asIT
         MKWI130YZwAjrEFUpjERZQfZ2bGfpzE05MVkgoHQ9GWmmp+23LZjCN9bvR5kZ+ksmN0J
         H1eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770172547; x=1770777347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhKOlfcFWD+uB2awU+d1TWqY24KooxMltjMVauKkIzE=;
        b=NUccI0eZaiYgQ0ZvnJ/AU9UNAilwcPnPX3inKvFLaYqRFaUcKJgV9hY2Vt17U1NRSA
         X9t8r3m0O6xdt+bFsP7Nbp6nFUAv1KQ68ayxJ2OAXIG1mrjrpRg7MifczfGQ0eOU2rHn
         9GUh6UdBD+8HVLl2mLjrcBHtHK1daHIJu+2xSJogx6QZH9sGSJFzbaBP50njuYzepp8w
         HjBTs/rR3F8R1gt/oTjqvhWxfUC3Mb2bk3TNpWTZ73D89hvh2/tzTACZOtRedlG4/UJ0
         hwBy0vflihr+FvkXnwkliBty8jtMHtXnPk6oTepjH0BDswtb3jFEjuoPUlPSAg3N/poT
         WqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172547; x=1770777347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhKOlfcFWD+uB2awU+d1TWqY24KooxMltjMVauKkIzE=;
        b=WuajjoZBeGloFtJgiIpie9lkRrAHfU2YCb/03atwx9V1zpRlut84u/4ZP4sosOhTJZ
         ufRHZW0BRw2nBEDTJHiOQ1f/HG4UzZJ6XOkpB6L6gtbITxBMwsJT+0nqPrQ0giUlzkfX
         +n8fh4tSiqVTsm7klD/RHs4usUGpCtGVtdtYV7JNkIVl9yYBOx7UsW0BrBK7qeUWemnm
         cXTMLB43XGe1gA/SNre0HKIlKg030eCDf4m+b/ywxG5o+PZvOAojMgFoCGN043mELpFR
         ZJEhybIfmPQOubo18jlVB2rInItPuZY39KtnvoxNhBqEKGSgm0ITeq4/CjIU3aZgAI6g
         apGg==
X-Forwarded-Encrypted: i=1; AJvYcCXZYLH1jJTxgWO88OYKOD4v5WyVKqP5iCKES+O8lFdV1klMgpAQRnG/8ScnMxerfovX5+Mxdac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXn9slJVOIrtHRCbCPLhmRRzpXjz5D38IGYwdoRfdiiGSiod7N
	Zuerl/rpda23zVCEU+nTSxM9Z11zPqAIxvtTxbm60LdTIbTLxwLHpp7r3aY3mXi+jLNbQcyyDEw
	Bql/7JZp3iB1B6pCmMlv8U5OIoRwrHa5Ayz1hk61yAtPHxE73HduyQ25N+R1OKfx5q0S70LFExx
	sZCfgTSKrHObHqkALk7g1WkTbGYLIhVjM4
X-Gm-Gg: AZuq6aJFk2qHWXPA6y2vNesqw9LwrBT7LSfA+29rOqaQNyF0uldUixOFinKvN45bISJ
	+E0kpoMAYjOoN5DRp3mHaMyJdiGfEbaZiPXYhr3ePb60WrD6/lk/O31wYfoQABEhFtBsvDPhxFw
	H4zRWBTbELiWyTqfYxcE9jeWRW4MkCgMFR3YqxX8F9/GlKoMWO6+yxwSxWpePwDe67bEk=
X-Received: by 2002:a17:90b:2dcd:b0:349:7f0a:381b with SMTP id 98e67ed59e1d1-354870cb817mr1048073a91.8.1770172546942;
        Tue, 03 Feb 2026 18:35:46 -0800 (PST)
X-Received: by 2002:a17:90b:2dcd:b0:349:7f0a:381b with SMTP id
 98e67ed59e1d1-354870cb817mr1048045a91.8.1770172546331; Tue, 03 Feb 2026
 18:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203231021.1331392-1-vishs@meta.com> <20260203231021.1331392-2-vishs@meta.com>
In-Reply-To: <20260203231021.1331392-2-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Feb 2026 10:35:35 +0800
X-Gm-Features: AZwV_QiEV6wIiNHzPzJ4QTzxZSsk-pA2HHJFpbTJmuo89R1a1cXT5mCVpUiE2aI
Message-ID: <CACGkMEvWteyikWuZ1uiudHQKGaoYduqftAMGaQCK0=QiOJo3fQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] virtio_net: add page_pool support for
 buffer allocation
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256521-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 9D66CE0E8A
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 7:10=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.com=
> wrote:
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
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 360 ++++++++++++++++++++++-----------------
>  2 files changed, 206 insertions(+), 155 deletions(-)
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
> index db88dcaefb20..52632361c1f8 100644
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
> @@ -706,15 +714,24 @@ static struct page *get_a_page(struct receive_queue=
 *rq, gfp_t gfp_mask)
>         return p;
>  }
>
> +static void virtnet_put_page(struct receive_queue *rq, struct page *page=
,
> +                            bool allow_direct)
> +{
> +       if (page_pool_page_is_pp(page))
> +               page_pool_put_page(rq->page_pool, page, -1, allow_direct)=
;
> +       else
> +               put_page(page);
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
> @@ -877,9 +894,12 @@ static struct sk_buff *page_to_skb(struct virtnet_in=
fo *vi,
>                 if (unlikely(!skb))
>                         return NULL;
>
> -               page =3D (struct page *)page->private;
> -               if (page)
> -                       give_pages(rq, page);
> +               if (!rq->page_pool) {
> +                       page =3D (struct page *)page->private;
> +                       if (page)
> +                               give_pages(rq, page);
> +               }
> +
>                 goto ok;
>         }
>
> @@ -914,7 +934,10 @@ static struct sk_buff *page_to_skb(struct virtnet_in=
fo *vi,
>                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
>                                 frag_size, truesize);
>                 len -=3D frag_size;
> -               page =3D (struct page *)page->private;
> +               if (!rq->page_pool)
> +                       page =3D (struct page *)page->private;
> +               else
> +                       page =3D NULL;

The check seems to be unnecessary as page_to_skb() will be only called
by big and mergeable. And we goto ok for mergeable before.

>                 offset =3D 0;
>         }
>
> @@ -925,7 +948,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>         hdr =3D skb_vnet_common_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
>         if (page_to_free)
> -               put_page(page_to_free);
> +               virtnet_put_page(rq, page_to_free, true);
>
>         return skb;
>  }
> @@ -965,93 +988,10 @@ static void virtnet_rq_unmap(struct receive_queue *=
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
> @@ -1067,9 +1007,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqu=
eue *vq, void *buf)
>                 return;
>         }
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
> -               virtnet_rq_unmap(rq, buf, 0);
> -
>         virtnet_rq_free_buf(vi, rq, buf);
>  }
>
> @@ -1335,7 +1272,7 @@ static int xsk_append_merge_buffer(struct virtnet_i=
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
> @@ -1771,7 +1708,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         return ret;
>  }
>
> -static void put_xdp_frags(struct xdp_buff *xdp)
> +static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq=
)

Nit: rq may come first to align with append_frags()?

>  {
>         struct skb_shared_info *shinfo;
>         struct page *xdp_page;
> @@ -1781,7 +1718,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>                 shinfo =3D xdp_get_shared_info_from_buff(xdp);
>                 for (i =3D 0; i < shinfo->nr_frags; i++) {
>                         xdp_page =3D skb_frag_page(&shinfo->frags[i]);
> -                       put_page(xdp_page);
> +                       virtnet_put_page(rq, xdp_page, true);
>                 }
>         }
>  }
> @@ -1873,7 +1810,7 @@ static struct page *xdp_linearize_page(struct net_d=
evice *dev,
>         if (page_off + *len + tailroom > PAGE_SIZE)
>                 return NULL;
>
> -       page =3D alloc_page(GFP_ATOMIC);
> +       page =3D page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>         if (!page)
>                 return NULL;
>
> @@ -1897,7 +1834,7 @@ static struct page *xdp_linearize_page(struct net_d=
evice *dev,
>                 off =3D buf - page_address(p);
>
>                 if (check_mergeable_len(dev, ctx, buflen)) {
> -                       put_page(p);
> +                       virtnet_put_page(rq, p, true);
>                         goto err_buf;
>                 }
>
> @@ -1905,21 +1842,21 @@ static struct page *xdp_linearize_page(struct net=
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
>         *len =3D page_off - XDP_PACKET_HEADROOM;
>         return page;
>  err_buf:
> -       __free_pages(page, 0);
> +       page_pool_put_page(rq->page_pool, page, -1, true);
>         return NULL;
>  }
>
> @@ -1962,7 +1899,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>         unsigned int headroom =3D vi->hdr_len + header_offset;
>         struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf + header_offset;
>         struct page *page =3D virt_to_head_page(buf);
> -       struct page *xdp_page;
> +       struct page *xdp_page =3D NULL;

This seems unnecessary.

>         unsigned int buflen;
>         struct xdp_buff xdp;
>         struct sk_buff *skb;
> @@ -1996,7 +1933,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>                         goto err_xdp;
>
>                 buf =3D page_address(xdp_page);
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>                 page =3D xdp_page;
>         }
>
> @@ -2028,13 +1965,15 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
>         if (metasize)
>                 skb_metadata_set(skb, metasize);
>
> +       skb_mark_for_recycle(skb);
> +
>         return skb;
>
>  err_xdp:
>         u64_stats_inc(&stats->xdp_drops);
>  err:
>         u64_stats_inc(&stats->drops);
> -       put_page(page);
> +       virtnet_put_page(rq, page, true);
>  xdp_xmit:
>         return NULL;
>  }
> @@ -2082,12 +2021,14 @@ static struct sk_buff *receive_small(struct net_d=
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
> @@ -2142,7 +2083,7 @@ static void mergeable_buf_free(struct receive_queue=
 *rq, int num_buf,
>                 }
>                 u64_stats_add(&stats->bytes, len);
>                 page =3D virt_to_head_page(buf);
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>         }
>  }
>
> @@ -2253,7 +2194,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>                 offset =3D buf - page_address(page);
>
>                 if (check_mergeable_len(dev, ctx, len)) {
> -                       put_page(page);
> +                       virtnet_put_page(rq, page, true);
>                         goto err;
>                 }
>
> @@ -2272,7 +2213,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>         return 0;
>
>  err:
> -       put_xdp_frags(xdp);
> +       put_xdp_frags(xdp, rq);
>         return -EINVAL;
>  }
>
> @@ -2337,7 +2278,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>                 if (*len + xdp_room > PAGE_SIZE)
>                         return NULL;
>
> -               xdp_page =3D alloc_page(GFP_ATOMIC);
> +               xdp_page =3D page_pool_alloc_pages(rq->page_pool, GFP_ATO=
MIC);
>                 if (!xdp_page)
>                         return NULL;
>
> @@ -2347,7 +2288,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>
>         *frame_sz =3D PAGE_SIZE;
>
> -       put_page(*page);
> +       virtnet_put_page(rq, *page, true);
>
>         *page =3D xdp_page;
>
> @@ -2393,6 +2334,8 @@ static struct sk_buff *receive_mergeable_xdp(struct=
 net_device *dev,
>                 head_skb =3D build_skb_from_xdp_buff(dev, vi, &xdp, xdp_f=
rags_truesz);
>                 if (unlikely(!head_skb))
>                         break;
> +
> +               skb_mark_for_recycle(head_skb);
>                 return head_skb;
>
>         case XDP_TX:
> @@ -2403,10 +2346,10 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
>                 break;
>         }
>
> -       put_xdp_frags(&xdp);
> +       put_xdp_frags(&xdp, rq);
>
>  err_xdp:
> -       put_page(page);
> +       virtnet_put_page(rq, page, true);
>         mergeable_buf_free(rq, num_buf, dev, stats);
>
>         u64_stats_inc(&stats->xdp_drops);
> @@ -2414,7 +2357,8 @@ static struct sk_buff *receive_mergeable_xdp(struct=
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
> @@ -2446,7 +2390,7 @@ static struct sk_buff *virtnet_skb_append_frag(stru=
ct sk_buff *head_skb,
>
>         offset =3D buf - page_address(page);
>         if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>                 skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>                                      len, truesize);
>         } else {
> @@ -2499,6 +2443,8 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>
>         if (unlikely(!curr_skb))
>                 goto err_skb;
> +
> +       skb_mark_for_recycle(head_skb);
>         while (--num_buf) {
>                 buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
>                 if (unlikely(!buf)) {
> @@ -2517,7 +2463,7 @@ static struct sk_buff *receive_mergeable(struct net=
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
> @@ -2527,7 +2473,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>         return head_skb;
>
>  err_skb:
> -       put_page(page);
> +       virtnet_put_page(rq, page, true);
>         mergeable_buf_free(rq, num_buf, dev, stats);
>
>  err_buf:
> @@ -2666,32 +2612,42 @@ static void receive_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
>  static int add_recvbuf_small(struct virtnet_info *vi, struct receive_que=
ue *rq,
>                              gfp_t gfp)
>  {
> -       char *buf;
>         unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
>         void *ctx =3D (void *)(unsigned long)xdp_headroom;
>         int len =3D vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_=
headroom;
> +       unsigned int offset;
> +       struct page *page;
> +       dma_addr_t addr;
> +       char *buf;
>         int err;
>
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
> +       if (rq->use_page_pool_dma) {
> +               addr =3D page_pool_get_dma_addr(page) + offset;
> +               addr +=3D VIRTNET_RX_PAD + xdp_headroom;
>
> -       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx=
, gfp);
> -       if (err < 0) {
> -               virtnet_rq_unmap(rq, buf, 0);
> -               put_page(virt_to_head_page(buf));
> +               sg_init_table(rq->sg, 1);
> +               sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
> +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> +                                                   buf, ctx, gfp);
> +       } else {
> +               sg_init_one(rq->sg, buf, vi->hdr_len + GOOD_PACKET_LEN);
> +               err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
> +                                             buf, ctx, gfp);
>         }
>
> +       if (err < 0)
> +               page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
> +                                  -1, false);
>         return err;
>  }
>
> @@ -2764,13 +2720,15 @@ static unsigned int get_mergeable_buf_len(struct =
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
> -       void *ctx;
> +       unsigned int offset;
> +       struct page *page;
> +       dma_addr_t addr;
>         char *buf;
> +       void *ctx;
>         int err;
>
>         /* Extra tailroom is needed to satisfy XDP's assumption. This
> @@ -2779,18 +2737,14 @@ static int add_recvbuf_mergeable(struct virtnet_i=
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
> @@ -2800,18 +2754,27 @@ static int add_recvbuf_mergeable(struct virtnet_i=
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
> +       if (rq->use_page_pool_dma) {
> +               addr =3D page_pool_get_dma_addr(page) + offset;
> +               addr +=3D headroom;
> +
> +               sg_init_table(rq->sg, 1);
> +               sg_fill_dma(rq->sg, addr, len);
> +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> +                                                   buf, ctx, gfp);
> +       } else {
> +               sg_init_one(rq->sg, buf, len);
> +               err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
> +                                             buf, ctx, gfp);
>         }
>
> +       if (err < 0)
> +               page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
> +                                  -1, false);
>         return err;
>  }
>
> @@ -3128,7 +3091,10 @@ static int virtnet_enable_queue_pair(struct virtne=
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
> @@ -3168,6 +3134,81 @@ static void virtnet_update_settings(struct virtnet=
_info *vi)
>                 vi->duplex =3D duplex;
>  }
>
> +static int virtnet_create_page_pools(struct virtnet_info *vi)
> +{
> +       int i, err;
> +
> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
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

This check could be moved out of the loop.

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
> @@ -3770,7 +3811,6 @@ static int virtnet_close(struct net_device *dev)
>          * open
>          */
>         cancel_work_sync(&vi->config_work);
> -

Unnecessary changes.

>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 virtnet_disable_queue_pair(vi, i);
>                 virtnet_cancel_dim(vi, &vi->rq[i].dim);
> @@ -6442,9 +6482,6 @@ static int virtnet_find_vqs(struct virtnet_info *vi=
)
>                 vi->sq[i].vq =3D vqs[txq2vq(i)];
>         }
>
> -       /* run here: ret =3D=3D 0. */
> -
> -

Seems some leftovers of some temporary change.

>  err_find:
>         kfree(ctx);
>  err_ctx:
> @@ -6945,6 +6982,14 @@ static int virtnet_probe(struct virtio_device *vde=
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
> @@ -6958,7 +7003,7 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>                 vi->failover =3D net_failover_create(vi->dev);
>                 if (IS_ERR(vi->failover)) {
>                         err =3D PTR_ERR(vi->failover);
> -                       goto free_vqs;
> +                       goto free_page_pools;
>                 }
>         }
>
> @@ -7075,7 +7120,10 @@ static int virtnet_probe(struct virtio_device *vde=
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
> @@ -7104,6 +7152,8 @@ static void remove_vq_common(struct virtnet_info *v=
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


