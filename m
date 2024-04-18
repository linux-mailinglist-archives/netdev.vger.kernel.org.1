Return-Path: <netdev+bounces-89003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8588A930F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CA91F21D63
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99DB757E7;
	Thu, 18 Apr 2024 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEm9HJ8a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964871727
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421610; cv=none; b=IeAFFZexOuGmp4ByPEdMAe5jWCmOek2nThPsBx55w/y+8LB4zmsPSAhWvHAkReX6nL1Aedx9TQmbL9tyZJjhI+fPHim9sSkyLVBuuLYQ8hbN5NTEkzjnJaE2D7I6YT8y3ksB92eNECOF9WwnVpFqnr4xbeZTAr4GDqNEuMPa6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421610; c=relaxed/simple;
	bh=hPDepYOxZkPDNS5W9loYpVnE+cA9KTqLbhUSRklTJqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4HPVji2fkehVhSfp5dz3aePSeem+jY3LnptQ7Pc+9Mwo3xUTcQ/mtWQlPbPabgMnkWxM94U4KxxhytesAwPbPJqbRQBwpHd4Ypouxk7FwKImaBpHn/M9OcmQo0G+UVlkQVdEf2rCH/ZC9C5GQlNTxWkKINDY6yIn4n+jyYf9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEm9HJ8a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713421608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Co+J/IEmR0gHg13sO9R+LS6Bt2YubSKjtOCe81CGia8=;
	b=EEm9HJ8aFp0B9RktVH6UZAluC6X257/IuV6CEao4UwAWl9w5m2+dEOMmUemuv+GBD8FQrB
	oPFDfgc3sklgGjcDtNvQ6bsllTmyUlEnDRJtqJg2TR+m4ybCeBw/kumDzGy5HlewGz63WU
	N1HOmQTDgbbjDTOhMy30aAH5/4q5OaY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-fj79aOAdNem5nnT413O5Wg-1; Thu, 18 Apr 2024 02:26:45 -0400
X-MC-Unique: fj79aOAdNem5nnT413O5Wg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed33476d82so681039b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421605; x=1714026405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co+J/IEmR0gHg13sO9R+LS6Bt2YubSKjtOCe81CGia8=;
        b=MxR5QrPjFGleNTVmrEM1ugeqpMctAdVYehz66IGWi73NSOln4yXPQjnvK/uo9e1LcH
         ZjZsv1HPFVxVMTbL3C8lHa1z5u6ePrekUqpy5Dig7BB4Jx/54NpjJ12tBVmy4t7zfzXN
         RaKlvqmmG2doYOH7CwzI0n++MaikwkKD8k1TMVIOVnXBl8e/w7jmcQCiM9/SxIl/iBmY
         PjIamSqrrVVNEwu2jzGxKcfYh9RsDCdiT+hLXdAYX71PHX6ED1mGTW947rb9naeAWKnv
         CetVGbox58yf6VqjtmWx22KWvYcc5iuWXwp+RhIilUPjWNgAO8zzTYOCfvfQ2fn6rQ/7
         Xmiw==
X-Forwarded-Encrypted: i=1; AJvYcCUMZnEouAbNyYcaOIFBY/B2WwgedAY2gxm92yTV+ZKxSifM/qmJGT/ddPzczhGhQVCA1MNALk+eotsdQa1PXdXrM2jiiUSX
X-Gm-Message-State: AOJu0Yx0cKoWpM/517wthFpIbGeNyHsFabE2zc4TCfVGagwQEHQtTgJo
	LMU5i2qP8BlPwq9/FuFxzKUd2D1pjbT5dFAbD6bbXxbsGtNirB4CTTrxo3aV5G2H0X2tIzf5FuI
	s7aG2o+wsIq2ntBbWDqWM2UIG20fCPZQIN1EPHlAGDQ1dMCoXmzXs6g7NUhg+RY1H1k9Py6RWPC
	URnND9jv8Ov3Or818DtfDPPoVneozh
X-Received: by 2002:aa7:8895:0:b0:6ea:7468:1f31 with SMTP id z21-20020aa78895000000b006ea74681f31mr2004005pfe.30.1713421604835;
        Wed, 17 Apr 2024 23:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu1YQNTHlp2GTN5tAG/tZSABZjo8dGXzop5NP4wWmMp69Xrzd9pAfXN5wd84TRB6iUCTyi7ybj6/3bOAiqli0=
X-Received: by 2002:aa7:8895:0:b0:6ea:7468:1f31 with SMTP id
 z21-20020aa78895000000b006ea74681f31mr2003998pfe.30.1713421604498; Wed, 17
 Apr 2024 23:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:26:33 +0800
Message-ID: <CACGkMEv2_wmXsh5uZhfZLQTtJX9633NdRL4KZrHumsTcr70-Sw@mail.gmail.com>
Subject: Re: [PATCH vhost 5/6] virtio_net: enable premapped by default
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Currently, big, merge, and small modes all support the premapped mode.
> We can now enable premapped mode by default. Furthermore,
> virtqueue_set_dma_premapped() must succeed when called immediately after
> find_vqs(). Consequently, we can assume that premapped mode is always
> enabled.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7ea7e9bcd5d7..f0faf7c0fe59 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -860,15 +860,13 @@ static void *virtnet_rq_alloc(struct receive_queue =
*rq, u32 size, gfp_t gfp)
>
>  static void virtnet_rq_set_premapped(struct virtnet_info *vi)
>  {
> -       int i;
> -
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;
> +       int i, err;
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> +               err =3D virtqueue_set_dma_premapped(vi->rq[i].vq);
> +
> +               /* never happen */
> +               BUG_ON(err);

Nit:

Maybe just a BUG_ON(virtqueue_set_dma_premapped()).

Btw, if there's no way to disable pre mapping, maybe it's better to
rename virtqueue_set_dma_premapped() to
virtqueue_enable_dma_premapped(ing).

Thanks

>
>                 vi->rq[i].do_dma =3D true;
>         }
> --
> 2.32.0.3.g01195cf9f
>


