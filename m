Return-Path: <netdev+bounces-256944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HPVCtoUhGnQyAMAu9opvQ
	(envelope-from <netdev+bounces-256944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:56:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A1EE6EB
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70208301BCF0
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 03:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7512E7F38;
	Thu,  5 Feb 2026 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LywEHK66";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx9IvcNk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB812DB78A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263711; cv=pass; b=u+PwvPaAY4Co98vjCRbPhJB0rMAbFcsRuZPAqwzB5YX8cofYbN6a+CdB4nKQjDgRK0Rvnpl5Dhj06XiIxBiZ0iP0MnO80RqxWlfBQwmrb9kpd3jMwKd5jG4865hEAoVFrIsTWW1mHjaSRnBKXm4rBSl9CJbnuBaa+71/lJPZIPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263711; c=relaxed/simple;
	bh=yQ+/qIdsSrnwbr6nE+vWLrH8Nj+O4Y7hs/EbVrwH9Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjyn1OH90IvjRmaOl/oZfzV7n52iug/G8B+Ee1pHk+q1uG+/6qsnwl5Jt1+mg5HaL1nQ7xtYe/6f6v/evR14ucYM7e2E/Ooq1gtAlrbJkwRHutfCMIMQXED7wFzr/gIdbStT0Hfah80Qab37pBjiPqogwJGLF7xbN16CwI9/SQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LywEHK66; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qx9IvcNk; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770263710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I4wiHK4vuKnP4ath3SaZ9xx45LrwQZ1CCNfZkbkb7c=;
	b=LywEHK66+RqmFpG5zgtkTNy7rVo4pkIPRxiiSSrwpeXL9o+oP7Lxw/SO8hDuCabah7jZKS
	Pou+hySym6esgekSkdUwjmFlek2rWQJmBZcKoWB1DfiEsO/75Bqe78OzTbR6m0dHKeJrT/
	X3WY81qPRg2YOC9sDMq2NOCZsvLL63k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-C2usOfb0PxCsEby1FJMaTw-1; Wed, 04 Feb 2026 22:55:09 -0500
X-MC-Unique: C2usOfb0PxCsEby1FJMaTw-1
X-Mimecast-MFC-AGG-ID: C2usOfb0PxCsEby1FJMaTw_1770263708
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a76f2d7744so5183005ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 19:55:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770263708; cv=none;
        d=google.com; s=arc-20240605;
        b=dpEg/3MjakpBscDRk8znDFlVodveE1H+UYoUz0QgtllNzD9tbkOinfvrOBs4qn8rep
         Cu3091MNUp+K5eX2vBeLmQSJ7TSejpXntXgy2Wzpx8tnN8GUdw8mXhWEnM8DCReLEw4S
         h13RGY+Kh7ogu/vWO51vUgTid5pCDg8eLglUNOS+fk6vbNVqSq3Gz0+14HQWZID3x94u
         OiW/erInCoPO8PvBRgWXOm3NPMXPAeOIYo0PjH+dTbNvD9zwbMz6L/BmvajRKdwHqBZB
         mJ24X2hCf/+ZnaRUaft5p1Iiwv7vNZLDT22682bxhkxwcPO783FxX7SA0L4ugv1MElux
         nCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3I4wiHK4vuKnP4ath3SaZ9xx45LrwQZ1CCNfZkbkb7c=;
        fh=uuJloCIEP3kvE7GoNLgdLRfXmsC+QQ2+UM+0ZKRhoaQ=;
        b=lEX6Dtjd36jDwZuKLUuN0sgzqMG2mhZ5JOF19BOtP3eygGZSJ31lhpaVsYHFyZrrgt
         Z9DDdnEQCmcllT9y381ep1xl1knflUz/dX1+pr0h5hZ+LKk7sS4v05x7yOBvWV+OFoBy
         RJQhZ97IJ/6CPVC8bkKbamTKwPpgiO112EBfjyMwo7iDpi5VhOC1KWEyvuB2cbYElHiu
         DOwuVGxcM0t4LYn+BiAxjkHhzIWRGpJ8E1wz6URqKn+Y8Jr0HM0yiRpP/Z94K6242n3/
         LQaPRLbcjaPp2ud2mswNc4lTm6CsRTdidvhwmiajUOFUpE84FuCM54lpwS4d0wS4oKaI
         KY1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770263708; x=1770868508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3I4wiHK4vuKnP4ath3SaZ9xx45LrwQZ1CCNfZkbkb7c=;
        b=Qx9IvcNkEeVIyOYJPIzuAZvDKnOHnw/sW4xEQauvU9ZJdlofnSh7U6mcfVQoQ+5is0
         XMVuZqbO8+vXq7lamT7tsrIkmUrQ/auz4mjH1tmiEsJt30o0wSSJPtdbkQsS4T/VPAnL
         NndmJiCHJ1jbhajVfZYEcned67auwyRJGYFbV2RT340G57FT24w9rjTcJTUBU6IubVQp
         AD29tw5+daA0G4zlkB5U+wm7lGHcJI7OG73NNFkJB0DLH/iGu4An+tKSLOVyQltn0lrO
         GVoqytchbm+Hm2yEooOdK5BcnuAHXPCs2eR5Cy6FYH7Wl1gI2JVLWKxdrd+osb5lL42g
         7mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263708; x=1770868508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3I4wiHK4vuKnP4ath3SaZ9xx45LrwQZ1CCNfZkbkb7c=;
        b=qIiJkR1SrsMcGc3X1JlWaxTamKcvSwmhnQdBEsVVQBZ89bv3QR1tob3cIsK+AOU3YX
         UXrtdo7KVWAEeLve7kUaKag13inTgJ95qiCDCCcJ5QzUn/Ed3XqU22PjrE/hHvUD48lQ
         A1rCLlZrMByXpkPFh5leribN25qaxTH/kBCc+5Dll47gjbQIbG0pT436gzD9pUgLMppm
         0omrMXx6CMjqftGbh0U2BO9RBMiURK02sefIPfJxFrllkm6BjA+ZL53IJIBg/i15VO/i
         jgxHZdNlK4zdp66woajPatxO/mI/n56Ppmsqw0h+I/T0XvcdpsuZwhNbNuS454nV6PYj
         nzpg==
X-Forwarded-Encrypted: i=1; AJvYcCUu5ur7Yr2JT+qKLosQTXtgyzgkRueIYb7MQkjsTmqPYaPlCeVUsoWS1s6Cuuxuk8HUi+ODZNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgB1xK/tBQeQzj3iQKdrn9qnlvwqks4K/cUrC/IKZ7BEGr7Bj
	nyPYTyHhs+bDDDg4ukAOtlDnTlljDIKKoZk+QOPmHuAgHNFoaessZldLcvlteAhxsPnYVac2C45
	d0yGtdBXjbhj7f2jHLDHCwSddqs6CWyJuvrhKxG8uKylHxOmT4pRuV6AfDNbfBlm+o9+AQ/1VFd
	BNxeOgbJO/238ecukBeE6QKW13Tk+2C6EH
X-Gm-Gg: AZuq6aI7DWBxTJGZ3yBO9gvXw/9gteNRcdkO126I/2tHPkcUWELdQ3oKFYg37Q6ssJ1
	qMQjYfYVLqZsuSJSbP2urzsd29t4r142cpXh2ltAhUI/z/EtO+HDfXizNAFgA995I40OmjJY1ch
	M94RzpUtSdEGWQTk/JnMwdEQUfC4W/n1tN6pF5qRGXNBVeoG8JPzLnCAHc6A4ZOjuzBA==
X-Received: by 2002:a17:902:ef07:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a933fbb91bmr55345425ad.34.1770263708209;
        Wed, 04 Feb 2026 19:55:08 -0800 (PST)
X-Received: by 2002:a17:902:ef07:b0:2a1:3e15:380e with SMTP id
 d9443c01a7336-2a933fbb91bmr55341925ad.34.1770263702958; Wed, 04 Feb 2026
 19:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204193617.1200752-1-vishs@meta.com> <20260204193617.1200752-2-vishs@meta.com>
In-Reply-To: <20260204193617.1200752-2-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 11:54:51 +0800
X-Gm-Features: AZwV_QiGiEnnkcU-RVALFrf_34MIEhko_WcvnVlIybPAOQb-EXjvuh7K8OffMaM
Message-ID: <CACGkMEuJ1LXg+WOryC9Fnk3NRJVhvzy+h8p5-fJFWUu1z8Yqtg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] virtio_net: add page_pool support for
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256944-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8A2A1EE6EB
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 3:36=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.com=
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
>  drivers/net/virtio_net.c | 351 ++++++++++++++++++++++-----------------
>  2 files changed, 201 insertions(+), 151 deletions(-)
>

Looks good overall, just one spot.

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

This patch still uses virtnet_rq_unmap() for free_receive_page_frags()
which looks like a bug.

Thanks


