Return-Path: <netdev+bounces-136881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC99A3794
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF13B21ADB
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D925818C035;
	Fri, 18 Oct 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqD4yZL0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327E189BA2
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237735; cv=none; b=cN7dxD4iMrLT1o2dqYI5HpL9XZhkptrRI8WsJ6Uf7Qr+d5zxKWooBPdaRuyLU+4PC4dyv3v54+M0nJQ8ylm3Jwuv3IolYRHycA8SpCvXjI8WNS8ilxePNKTfwrG+EaXcX0V11vPyd149W7Z6+VvmFmWxqQUe5ssdfBF9dNypE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237735; c=relaxed/simple;
	bh=7WIKQZ3bFs31Lm3+ADlRBG9/mPugYP9lIP5utWTpFkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXJUK+zCYxgYvAQiv3FrEluad1QVzUbu9nU4IWXKcINjYq3L9YpgDn0ndIVdt779arLa+cG64ddzSOIzyPu7nBcfhm+fQkyGBd2LU3Ancc2uYSfmDz9CvLiUNVIIZy3W1+Ut+7RGUMzyBUQq7OlPOA4wNV6WeXrU54dnzPyMRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqD4yZL0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729237733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWwqDCRQRriv7iO+TF5BdNeT3COFjejJcbVDi7gJc3s=;
	b=AqD4yZL0ta7mX15ivnC36+uLz7nB05x5qSiCXwS6Smue5KmetZ7nEeorHVtnlUTld2NH5e
	u/DcQOlrHa1klLB3W/dLsKRDnBqG5rBPbQCdaYJV5VQypTI/a4TJ2RwwpfEN3tJ1b9upke
	tn7IrD6U68nX7MOXWt10Xk5mG43RTs4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-9RANddoOMjuaHDoDRjs20Q-1; Fri, 18 Oct 2024 03:48:51 -0400
X-MC-Unique: 9RANddoOMjuaHDoDRjs20Q-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e578061ffso2127458b3a.1
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 00:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237731; x=1729842531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWwqDCRQRriv7iO+TF5BdNeT3COFjejJcbVDi7gJc3s=;
        b=IE1csWpa+bw9rVvupHcB8a1R8o23XnwFdnUoDl4gg3l48BsL5h2VhoknxUF3oUqDv1
         sWHD5Ix1E25lG6XizkRG5z37n46FmPtX2lZB8Pmsx1y/sC1K7uu3MhfjWF/T74ZLO/bN
         ifk9NmLA24mqrjvVzqeTcISa4tS9oT3fnkcQLzo57ETqVoFWWLDMsGWd1nItg9oYzaBm
         /3mHxUrhEEMiJ0gYSRLNBIDYPupjevXuIF2baYatqGURJUMdXNlKgzAPkj+8aKg+N7FD
         EKDZB3xac0/DEJdnadne5XQVq/XJNeAlTMFYjNgEqsxdh9NmL5miicZ+SHw5Ye9j0iNu
         RWog==
X-Gm-Message-State: AOJu0YxQ44sL+o/sPlJXnUnUkx6bbcH9hT8jGte4iBGLAobznSXWercQ
	pTKJzGS3feHTIS/X+QbAkA0ViIorUh1YKUy29wLs/o14BJtk1Q9Njc8UUeJ/ika78vC8ZjLirJF
	rpch1OPmvblpVeouMlsml0hEIQKKGu14sDpIkw7uAZLucd6El4XPBlrTjUrz684cqygQIE4Vicf
	IhzsUAjy70tvjj6uLj84AfiOluicbr
X-Received: by 2002:a05:6a00:148a:b0:71e:702c:a680 with SMTP id d2e1a72fcca58-71ea333bb6cmr1958809b3a.26.1729237730769;
        Fri, 18 Oct 2024 00:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeq5/l12Y0xHoQ3SV0L8TPnM1KncduSW3O8hgGIChJWyNDBJxrvC/Uq2wMVQQ5ibg2nGFEaa+jRg9RDh7D9SI=
X-Received: by 2002:a05:6a00:148a:b0:71e:702c:a680 with SMTP id
 d2e1a72fcca58-71ea333bb6cmr1958774b3a.26.1729237729975; Fri, 18 Oct 2024
 00:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com> <20241014031234.7659-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241014031234.7659-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 15:48:38 +0800
Message-ID: <CACGkMEvP99H0qEUsgkznS6brMbJcwV8BP37Fht28G2KtP-PLow@mail.gmail.com>
Subject: Re: [PATCH 2/5] virtio_net: introduce vi->mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, if we want to judge the rx work mode, we have to use such codes:
>
> 1. merge mode: vi->mergeable_rx_bufs
> 2. big mode:   vi->big_packets && !vi->mergeable_rx_bufs
> 3. small:     !vi->big_packets && !vi->mergeable_rx_bufs
>
> This is inconvenient and abstract, and we also have this use case:
>
> if (vi->mergeable_rx_bufs)
>     ....
> else if (vi->big_packets)
>     ....
> else
>
> For this case, I think switch-case is the better choice.
>
> So here I introduce vi->mode to record the virtio-net work mode.
> That is helpful to judge the work mode and choose the branches.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 61 +++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 59a99bbaf852..14809b614d62 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -385,6 +385,12 @@ struct control_buf {
>         virtio_net_ctrl_ack status;
>  };
>
> +enum virtnet_mode {
> +       VIRTNET_MODE_SMALL,
> +       VIRTNET_MODE_MERGE,
> +       VIRTNET_MODE_BIG
> +};

I'm not sure if this can ease or not.

[...]

> +       if (vi->mergeable_rx_bufs)
> +               vi->mode =3D VIRTNET_MODE_MERGE;
> +       else if (vi->big_packets)
> +               vi->mode =3D VIRTNET_MODE_BIG;

Maybe we can just say big_packets doesn't mean big mode.

> +       else
> +               vi->mode =3D VIRTNET_MODE_SMALL;
> +
>         if (vi->any_header_sg)
>                 dev->needed_headroom =3D vi->hdr_len;

Anyhow this seems not a fix so it should be a separate series than patch 1?

Thanks

>
> --
> 2.32.0.3.g01195cf9f
>


