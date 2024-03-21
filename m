Return-Path: <netdev+bounces-80941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1675881C07
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 05:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AE31F213FA
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 04:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E71E4B2;
	Thu, 21 Mar 2024 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xlnj+mqJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA66FBF
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 04:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996455; cv=none; b=bFnJMcB8xBfIfZGW73stqY5RIgana+xLuFw4/sNaXktGqBAgA4Bd88rfVLw6SwYbTVM5SBjhbhzUbz4VRZikhBj98lSiu8vX5nafz6sxcJ87tnckRuqe7Z/Pc1SbVYdOHlXvkv8USsJ9PQYmmZdfA2IH0pw+/trdChoTP/bzb8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996455; c=relaxed/simple;
	bh=FzlUkh/H3PbaE/6rvjuQ59WfzY/3yeTercRcek9n7MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMFQqjczzzopiWIuPGo3TbsJfcwbmcevYZZwgSpyMNbvoe6tGDKxwO/DhvbRM9nz8WnEIng2CYmcMK1TRtjIE/Vfuf59FIuS8em2xSfvIhXU//7G4eNM8smgxcMI57rZdxO09Zr0AK1kCQJs2bFpzJpQuxZLa5TK52uPKKFemLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xlnj+mqJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710996452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R25xG+GYTZrVm6e0l/eGbmaWKputPFk5P5+kIKivy9A=;
	b=Xlnj+mqJ3iF/lhSpe9Nr46Hq03nKbmJDYyQHRUCDaksygeYQQ6013cz4vFI0aMalSadO6b
	v5lu4xs3CSyLMIOQ/eNcGyG1BrSa8w5LCBn18P8DGdTepBTtepSzseKWLEmy0LoGpCen/E
	4PNpYPJ45YkySBXNrJGrEbADUxOEWFM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-4DllJ9Z8MfKfv6Qkp3nYjg-1; Thu, 21 Mar 2024 00:47:30 -0400
X-MC-Unique: 4DllJ9Z8MfKfv6Qkp3nYjg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so416703a12.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 21:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710996449; x=1711601249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R25xG+GYTZrVm6e0l/eGbmaWKputPFk5P5+kIKivy9A=;
        b=QBSpmTTc1q5WlLeOaaAtgQoU7oJs0G92aPJQpzh6Sg1TEC698MEqg6TubgSOk+Jgj0
         WVEmZNf/Nc9jTigeyYXjdhyT9gWqMiJ8RgyYv0Ggqrdqpo0hmWDYaS6N3NtxGKLmBobR
         avLeZjhi4ckc4y8P4/f/WUFMJSsrzSuLXh173v8MBNJHfOQtuCMtuHMd+sGgEoYi5hM1
         pW9GCI5v57qUFrof8Ko8dWTpITzhfrX0s183i1KIHo1AB9JSMD37eSQ5Jr8rXuZy1j2N
         VBVd8K4Uy3O+fwuIddp0TkRGsalBkfYiN77hiSAvwwOrNCDhSzVfM5LqLlc3g4brjXpn
         XDVw==
X-Forwarded-Encrypted: i=1; AJvYcCUZfWpWXwAFR1NFt6Py+UOMkn3O+as9IM9XEyBFkb72tWVedgm4LaB0T5tD3PSUvfeeIUbS4/ubQ2hgk8lACPIcLtEYS0i1
X-Gm-Message-State: AOJu0Yy1JVUJSKejeVpbF5OwNSTT1jdoN7HIuITU2R/7VBJb2KQzshn2
	1q60m9Vc8kv0Mtp2kCqaRBMo99CPznc9zj0vryA6kBW3AI289Q7/FkgY3vc2PQfwCpawIKHSEdp
	k6Njp794WYa4PW+xN+6bGZbq9zb6W/9TnR2AxJOToqnt0dYdxMAtOVhJM7w/OWKNq/C2LBASesQ
	CSNsjfRHW8QvWDC9x6x4ZuWEx+NL02
X-Received: by 2002:a17:90b:805:b0:29f:ce37:50d8 with SMTP id bk5-20020a17090b080500b0029fce3750d8mr7560810pjb.17.1710996449284;
        Wed, 20 Mar 2024 21:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyDhQJUmAvKGCX0+SMStEIsEjG/lNtxS4uSp3iypJcJ5+avMQtxZkO4K4D+IcRdQ5QWbJwZqi+MUMIMi3IObg=
X-Received: by 2002:a17:90b:805:b0:29f:ce37:50d8 with SMTP id
 bk5-20020a17090b080500b0029fce3750d8mr7560798pjb.17.1710996449003; Wed, 20
 Mar 2024 21:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com> <20240312033557.6351-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240312033557.6351-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 12:47:18 +0800
Message-ID: <CACGkMEs_DT1309_hj8igcvX7H1sU+-s_OP6Jnp-c=0kmu+ia_g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 03/10] virtio_ring: packed: structure the
 indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional. But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 0dfbd17e5a87..22a588bba166 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -72,9 +72,16 @@ struct vring_desc_state_split {
>         struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
>  };
>
> +struct vring_packed_desc_indir {
> +       dma_addr_t addr;                /* Descriptor Array DMA addr. */
> +       u32 len;                        /* Descriptor Array length. */
> +       u32 num;
> +       struct vring_packed_desc desc[];
> +};
> +
>  struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
> -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if =
any. */
> +       struct vring_packed_desc_indir *indir_desc; /* Indirect descripto=
r, if any. */

Maybe it's better just to have a vring_desc_extra here.

Thanks


