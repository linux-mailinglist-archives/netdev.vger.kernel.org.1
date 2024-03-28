Return-Path: <netdev+bounces-82740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E381988F863
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C141C21C71
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0534545;
	Thu, 28 Mar 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJDniCui"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967852561F
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609610; cv=none; b=qTjVnIxrMsi1SBudveiqj98o3owQNDF6bQWrKZ2dno3p82huLkSpndnbdK24NzZcT7NR3AGYYIDwrCwGgWK/ONHD6/RN8nwFndPhrsOGlZ805etWwpJiMDj9bSZdBvZeYgSqiM2KllU6+KyULcrhUbOUSjFNOuInGEv9dPYeb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609610; c=relaxed/simple;
	bh=rWUEtU0RNdJV8JflDmOnHRHkp+n8OyVdKJqpGZl5iwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXMQve4Z245rUvv2KJIaFK1RkWb66AnLpjy95pUdjFDcSdi2kd/izHX5XRlUR9mEVVWxUPv62Hb+tSloAo/JwPWYJ/r5zer3ByOcUb0J+U571SucbYYJl9uXRZtH7FFQzRfWiG4V9GMTZu3uwCNpEUpjLyOvZpFTqzzzHX0zhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJDniCui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711609607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bnDouKQUa1KFdv6sPVLtYBCuBumGNcRSCwaUxiEVNw=;
	b=CJDniCuiamXtKPJQ/tlj5opR5EwAaW0+yd/Y6ozinbrnruaErT9XExN83d9T6UlWvp1D/9
	kT/E+Nxg1F1QYrRqsx5mV/a65ZCrkM4ObqTAqXZEntBPowvpgytH7KTXmEdsrXW40nGn/Z
	9+vXlLfsPOVTARmhGHEAZHmZB332Uq0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-dBRZL917PCS1h8qp347mAQ-1; Thu, 28 Mar 2024 03:06:45 -0400
X-MC-Unique: dBRZL917PCS1h8qp347mAQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ea83747e30so771183b3a.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609604; x=1712214404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bnDouKQUa1KFdv6sPVLtYBCuBumGNcRSCwaUxiEVNw=;
        b=YrEkSX1FrkqtpX2n/r8XBiXd4rud4Fs+E8NCGfs2KAlzCuLa5/j56+VTqeRl67bWsc
         kwf6nJ7XaZDAYJHWxMUa/fUoy3+A/kPEb5U6J2ex0Fhyp2DEqOv9N4lIiu1IJqjaYMTi
         DPgCqTWi0BoQ/DS5KNsflvg7h+CLRkj8l0gnZeqQlFRzugE9C48r1Y4NQo5lKZnhviA3
         54azWQUjO7iCdzmtAbKrnD3SV4Iu+4Q2gNcjmeDSmrH76PsETnAQuxJKXDO8E2Ak0deP
         n/qWfC1P3FkG/TPRsfQzanxVFe1OfODmE1BcGExIgxbu6MThlzbDQdWmMwuPKWEHj71S
         1dxw==
X-Forwarded-Encrypted: i=1; AJvYcCWlY1/b0SGbBAQ3DGdt1e0AMaAv2fa4ZbrLxiAZbHbXFK2rrTjfhx5Pgvpmul9/Q4MpnYXf7Rv1/7l5uZkKoSogjNhSnR3u
X-Gm-Message-State: AOJu0YyTOVZ78xvq+nuXNCipcEZU1zgtgEb4DFhrzkx6xdw6SG0CKE05
	Tok1PQokZs+Yzi33B0hstL94VPg+urOIU4uInCnZjz0t28RQAPXJUGKFygsfHJGHb8fJG31VN/d
	adlwiI4hbXxeSrMcw7RlllzpDl9/Z1AUI5Dg+Zo4g91oA2nkRhf+/aWJqUi3G86W+SRluKWDtbE
	JxtWk8CgNCLG5/diUd/wFIAWBLgctF
X-Received: by 2002:a05:6a20:8427:b0:1a3:81d2:29f with SMTP id c39-20020a056a20842700b001a381d2029fmr2801596pzd.17.1711609604520;
        Thu, 28 Mar 2024 00:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1CQGXYHWT4HkvLD4Yunmea/2pSjRrMA+FI4rzfQdiIMS1QMvFkNcdQpc5EwZEahWf0bT8RKZgwK/RMww7m8A=
X-Received: by 2002:a05:6a20:8427:b0:1a3:81d2:29f with SMTP id
 c39-20020a056a20842700b001a381d2029fmr2801581pzd.17.1711609604186; Thu, 28
 Mar 2024 00:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 15:06:33 +0800
Message-ID: <CACGkMEsmnzEUmaffn3ueY1JtbJ4UzLpr9o0s4j1jwoVuO-yy8Q@mail.gmail.com>
Subject: Re: [PATCH vhost v6 06/10] virtio_ring: no store dma info when unmap
 is not needed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As discussed:
> http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_yC21=
bgGkKZh845w@mail.gmail.com
>
> When the vq is premapped mode, the driver manages the dma
> info is a good way.
>
> So this commit make the virtio core not to store the dma
> info and release the memory which is used to store the dma
> info.
>
> If the use_dma_api is false, the memory is also not allocated.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 120 ++++++++++++++++++++++++++++-------
>  1 file changed, 97 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1f7c96543d58..08e4f6e1d722 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -69,23 +69,26 @@
>
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc_extra *indir_desc;    /* Indirect descriptor, i=
f any. */
> +       struct vring_desc_dma *indir_desc;      /* Indirect descriptor, i=
f any. */
>  };
>
>  struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc_extra *indir_desc; /* Indirect descriptor, if a=
ny. */
> +       struct vring_desc_dma *indir_desc; /* Indirect descriptor, if any=
. */
>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
>  };
>
>  struct vring_desc_extra {
> -       dma_addr_t addr;                /* Descriptor DMA addr. */
> -       u32 len;                        /* Descriptor length. */
>         u16 flags;                      /* Descriptor flags. */
>         u16 next;                       /* The next desc state in a list.=
 */
>  };
>
> +struct vring_desc_dma {
> +       dma_addr_t addr;                /* Descriptor DMA addr. */
> +       u32 len;                        /* Descriptor length. */

This seems to be odd, flag should be part of dma info.

To reduce the changeset, I would split out next.

Thank


