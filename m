Return-Path: <netdev+bounces-136411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1092E9A1B04
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F981C214EB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345B1C2DCC;
	Thu, 17 Oct 2024 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEQ4zPQF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5C1C2427
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147884; cv=none; b=sgwrt3vVzwVpkbjbk/0ImMqhrqjcsCN61hf+yqacyzBbbvAxWmtRFIqT2nXUNViJCxK+BiPMl8CSzCtn1aEzTYRHmP+mUhm92xLMudBo+XOBBxNuo+pSrkkgabSpPoWkftVQJxZZKJQRP71TvphuqgEMZK8IgQcJfqJfSCPwG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147884; c=relaxed/simple;
	bh=xvSTe7MkagrupWBAefdjJyXtMIcCbckwXBrGdN7d9l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrrtqxXp9cJIRlFAdbr2NbfGkV5TCTAVGKEFmeA6X9fc3yANOEgiLE9185UCkPUmnTrPbFMNelII1wIs+8ZCYyvsjPdio1Yet89XlpZVBCkWtrrP5QHf81vXxJ3Aprd5uU5daY7nam3tC8PK2QkE6CaNcIWhFLzquXRgqvmcEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEQ4zPQF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729147882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xay7m0WxFpn21Bz1X2gL8BD4WBjxqjm+qohOUPEun3M=;
	b=gEQ4zPQF2q0oulrsX+aV9HuJu/SU3XLu+eNJKibpwvY0syrUg2pTfx5/B84+2d7sGsYByS
	OlKRXF/azZR9TYI+9FSol5JhqH/lKY0pIjnQOZWU15NhUey1VQrgF1EGCeD31UvE9dJrK5
	7wuhtyhefAcBqEYG2SmeCQ0N8Wg8dxE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-2WKxluqCMKaeEirGzU04zg-1; Thu, 17 Oct 2024 02:51:19 -0400
X-MC-Unique: 2WKxluqCMKaeEirGzU04zg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e479829c8so678622b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 23:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147879; x=1729752679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xay7m0WxFpn21Bz1X2gL8BD4WBjxqjm+qohOUPEun3M=;
        b=wMtO82y6o7MPbdDE4oa+Bi07GBEvo16opDnZbNN/xdoQPJj9PPME/aJsrWg7sJ8MHq
         RblsUUHDfjwGEU6lEHcX/vuGVp1Bb8h+eVhHh3DTftD/nhNEw+xCwhoBMoXEZBvdOT6N
         GjBJ7SIilnrCZsEdGMpdeGVhZjV85JozJnc8hRLqdkoqkbd2GUM2a3AoMcplodwUl9rx
         g7hQNYAvFWLMYiOo8P3cNMAO4gZTRZD9v3IWGVL6Ow3jq+G8M5DXVwQyKu8Ytbb9bRgu
         1LSwzmwLw9f/JSl8bI0lR0I4r4aI8CKT/gAYjNKpRS66hXFfb709Msgby61wMsVC5SNi
         Rrtg==
X-Forwarded-Encrypted: i=1; AJvYcCW/oafgdgt22huLzrRsT+9wsRMpTYVJ/eG3620NOKbL5c4fSA9LyIY+mmu/uOoU2/agLN13eSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbIyYrmtjiTZSyoXpTJ7EjF9M75sU4jobky9xViBsHncqyX+6
	W8Txy3D1jKdik3zCi6pE0wRJAQZM/vna2S19zi4CHS1FoNj656nAZnTMACdkXSTu1xzPkY8ldx4
	QeljXKO7JLb8biBoKySRW2hihSPd3GahGJNzpLYfrGMjdm8eJkZ+nBvLYELd/8DSx4is+Rf6uYN
	lSP81+viJHOxbb9de0fYT7EdP8N10a
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-71e6489127amr18954649b3a.0.1729147878716;
        Wed, 16 Oct 2024 23:51:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGSON7GqEf790y/2ntpuXKji/SEhnmlTHIdPHQBAwq6YDA8De1J3fJmL4zC3Yp6zQMaH7+G3U/d3cye43jIOs=
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id
 d2e1a72fcca58-71e6489127amr18954637b3a.0.1729147878273; Wed, 16 Oct 2024
 23:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
In-Reply-To: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 14:51:06 +0800
Message-ID: <CACGkMEsovgv9=jj76dfATHWHY7c6NAmiqKDaARDGYju-A6zaKg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: fix integer overflow in stats
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	"Colin King (gmail)" <colin.i.king@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Static analysis on linux-next has detected the following issue
> in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :
>
>         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
>                 queue_type =3D VIRTNET_Q_TYPE_CQ;
>                 ctx->bitmap[queue_type]   |=3D VIRTIO_NET_STATS_TYPE_CVQ;
>                 ctx->desc_num[queue_type] +=3D ARRAY_SIZE(virtnet_stats_c=
vq_desc);
>                 ctx->size[queue_type]     +=3D sizeof(struct virtio_net_s=
tats_cvq);
>         }
>
> ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
> VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
>
> include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL <=
< 32)
>
> ..and hence the bit-wise or operation won't set any bits in ctx->bitmap
> because 1ULL < 32 is too wide for a u32.
>
> In fact, the field is read into a u64:
>
>        u64 offset, bitmap;
> ....
>        bitmap =3D ctx->bitmap[queue_type];
>
> so to fix, it is enough to make bitmap an array of u64.
>
> Fixes: 941168f8b40e5 ("virtio_net: support device stats")
> Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


