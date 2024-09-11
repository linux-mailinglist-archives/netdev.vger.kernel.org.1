Return-Path: <netdev+bounces-127208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75409748EA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543EF1F26E16
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186740849;
	Wed, 11 Sep 2024 03:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ls3QgDyG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE437171
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026412; cv=none; b=LogGJUbJegghMvWFkCe9daJH/C8GY4qngc3rm9RgcZ3Tx11xPu74Kj1Z9AlP+F8bis1TBoIm7JGxD8m36czinUcLY9GOMUyqBSnS511yi+OvDSRdRdy99A2fMcyE9CG8DXiYBJ0GsrW7qo0wEScb/C5hg72Q9IQACbDl/UCE5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026412; c=relaxed/simple;
	bh=wFhKcLxyN1ykNiZvxwjOMXoiE6l+99pEcKDjgw165jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt1/LVSJ4y/q9+iyN1Ts2XC+WSoTP6eT+zuSgyF9FQBg28KHd5TU7goAQ+CLYzfmErS/6mVASDbMxOl5w7gdEsCviEJ/T8lM6F5efZCO/nRDjJDPlxUwW9HY/2RUirKDiq1HkY+g3MhNvlmHFew4o4BEdlKiiuI+R2wQgyJhS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ls3QgDyG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1L3Rw9FQGILLm4dgDngRRTfcF5g+8GVlGOUuhGIUJk=;
	b=Ls3QgDyGPKFZu8Ykt60cQ1uclCaZvwAQo6J+ubP/H+uoOLHCQc00xl8cIlTmQmS6pirP/P
	xMibDZinbpE9MReL3F/3OWWf/X5vNaQPHwKahAo7486Ef1MlOHOjU4aTcB8iCcBFrtDwFS
	cMhFrn8IaRTxLXjskHQqcie4gpyD1Qk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-LqPy1IpPPRiDq_YH0CSJug-1; Tue, 10 Sep 2024 23:46:47 -0400
X-MC-Unique: LqPy1IpPPRiDq_YH0CSJug-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d8a1a63f3dso6375453a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 20:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026406; x=1726631206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1L3Rw9FQGILLm4dgDngRRTfcF5g+8GVlGOUuhGIUJk=;
        b=XA/cxtAAOqjHmYgy/4AQA4Zx0ZZiX9YZwkEg9WQ+v8oPxQcpMWJSwRZDUHFvo42swq
         tg5nmk/VwXI772NjD8lFWz+GHpf+ibthv5mhUgpqdiV1dE3nq3PvMc0qKWlpHXUcH6Kb
         ha3BKz+4DtBZP/4HM5ClMuBAS6+cl3Oso6O6RifR3xEZFl08+i31r3fITbSfqgWgdAHK
         talDgD05/b2vAIRkUwt9Pm5zVnogMepCEjFfC+2Tm0EGNrMQA/Vt7O1Ari4/oQPSKCjP
         ZkLR8WV39X13u19Zt2K0Shvqkj99DEQcJfFS/gFgvdoffzxuEzydTkH1N4latRAm4U+n
         CKmA==
X-Gm-Message-State: AOJu0YxlJPLbPEj1wk2ma8jwr0bYTJDwrX0prIs0+O8PINd4yVR/+6Wb
	vELn2r7GdII+nkrhGt/5tJEETJkAe6WGEPAWFADj/m6nziFoPFPFEj5UmM35Rf1FdWvz+SJRX/S
	jhdM7QvHgUqdkF4pZ+sGBZFm0pVoOj1iCNIdkT2bTOLX/nGSC1hAvh3eeWEcDfofhIggO3y3ZrF
	1m0NzHGsUg0QxhEmOYo7ZP4atqjvsF
X-Received: by 2002:a17:90a:77ca:b0:2d8:8ead:f013 with SMTP id 98e67ed59e1d1-2dad4efdfa9mr16150970a91.7.1726026406202;
        Tue, 10 Sep 2024 20:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnCJEXli9KWBQMuW7cPrQvykkXNDs1S+lxJ6nyJ9QJcR1HThFRnYJ3qTpH47dKeRKcUVxzNps+IZHyuAdt/B4=
X-Received: by 2002:a17:90a:77ca:b0:2d8:8ead:f013 with SMTP id
 98e67ed59e1d1-2dad4efdfa9mr16150940a91.7.1726026405725; Tue, 10 Sep 2024
 20:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:46:30 +0800
Message-ID: <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
Subject: Re: [PATCH net-next 02/13] virtio_ring: split: harden dma unmap for indirect
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> 1. this commit hardens dma unmap for indirect

I think we need to explain why we need such hardening. For example
indirect use stream mapping which is read-only from the device. So it
looks to me like it doesn't require hardening by itself.

> 2. the subsequent commit uses the struct extra to record whether the
>    buffers need to be unmapped or not.

It's better to explain why such a decision could not be implied with
the existing metadata.

>  So we need a struct extra for
>    every desc, whatever it is indirect or not.

If this is the real reason, we need to tweak the title.

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 122 ++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 228e9fbcba3f..582d2c05498a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,9 +67,16 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>
> +struct vring_desc_extra {
> +       dma_addr_t addr;                /* Descriptor DMA addr. */
> +       u32 len;                        /* Descriptor length. */
> +       u16 flags;                      /* Descriptor flags. */
> +       u16 next;                       /* The next desc state in a list.=
 */
> +};
> +
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
> +       struct vring_desc_extra *indir; /* Indirect descriptor, if any. *=
/

Btw, it might be worth explaining that this will be allocated with an
indirect descriptor table so we won't stress more to the memory
allocator.

Thanks


