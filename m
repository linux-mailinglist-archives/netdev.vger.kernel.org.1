Return-Path: <netdev+bounces-224664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFCFB87B0A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 04:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3041C25350
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88FB23E334;
	Fri, 19 Sep 2025 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpDvzZYu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAD1862A
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247935; cv=none; b=omo1SbTR8+R/A7YQDaQxmkmX429ip1+gKxJNOixC0W9EljnjYgp78Y9Y5DWXyUI/9JbzblXVdHog+tXvB/DU5D6jz7V/EIFQ4CpclzaSX7B8YBFNbzCbIj5ldMrzx+nius78L2imqrA1KfDsEAuPnrQ+2WzzvMI0T/6OYR8EaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247935; c=relaxed/simple;
	bh=VuBGy/Zu/mySTTTY3L1RI3B8W7Q1gIBkN5jQ/zIOlc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7G8+rRob3riRHHvAbjXp8zKFxtoqs34fBrN7RVftm5KSvxRyAxnPXUPhCvFRHs4u4aNtuk55pdkmGQvjfDbAi7TTraXWb/GFo1ouBOFDTmSWfZoXmjZiq7edeSeqjmBAASNq7IHq+C4Z5tEnE+YrHLo7XYDjaIZoWfcDLbeXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpDvzZYu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758247931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDgjUaWucf5m2XRF5I2ikU7gc9TowCe3ao+cs/ZTo2c=;
	b=cpDvzZYuN6wIwW+dKLK5B7FFUbd9KZR/Hywq9slUX9tScViNwm/vRsNNbe2HoOZvBqrDhz
	/XGHJpE1uYtFHfiWUJ6DlT650zecvHudEQbQKFbWrXFud/hSJtKiTXo/TbKC7AAfUusMnz
	x2JhXO3s68ITTwappCpLahqJPBEKMvU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-qf-UEauoN76Nn-jLDhfC9w-1; Thu, 18 Sep 2025 22:12:08 -0400
X-MC-Unique: qf-UEauoN76Nn-jLDhfC9w-1
X-Mimecast-MFC-AGG-ID: qf-UEauoN76Nn-jLDhfC9w_1758247928
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so2327746a91.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758247927; x=1758852727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDgjUaWucf5m2XRF5I2ikU7gc9TowCe3ao+cs/ZTo2c=;
        b=GEsgcMBsSx1Re/WfkgTsz/PFR4URzKKdPCQQtjvDXd0Ljf6sUcmFJiIb5GYOXtszra
         guTNOgXmO9OC5VFGpahFm+b0QsFjW3xrAndTcBZsdo9XdDBNehAO+HRkaTlr2hE2eB8+
         7zLopYfeljz/dD9vbWXbmLOOT+ixIF2bA93c/2KaZ3NU5/eO6OF/t536WpbTwL4fdWXG
         y35BcaO+NXk5M3HDmW77jb5C6As8IrZOuRJhuFg8E5SFtDh/FBAXFQV7h1iWYWxFZkM1
         jiYmELy6ntaDhusfVM8NHfFe//YYEHsXOnhhXBH8HchLG0O2J5vrFq+TfuEm07lJjN18
         jAQA==
X-Gm-Message-State: AOJu0YyIqHRC5G9xp4q3+RAHveKAHDCArtfV7VxzQPNwSweTh4CJTnaA
	mSY0uZNMcyuh2nUsCZhhD/WQJBE3/ST167ABLpxubpGkkJECHdcToNriEnQFdp+OGHHnJENB8zu
	EONmyW1xVUekXTo9dCC/ftM0Fj6Z/LWIbzkGP/+4eM739NLfZ6ufCPh/qcGpoY0ayJJBI+rb7LT
	zsf6ILRzHA/wyIPUnbDhm+I0mzCF469R1niqZbFgSpb27RKA==
X-Gm-Gg: ASbGnctHrafJegnffhmhxTCsJhiRhfqWhHEYWShxe+utJUQueWN+6jah1c2Olf2SUyi
	Lv3URZimZ3lrrLPUuatvO4bfZdA1eG1Xjc0T90RGrnJ+CLFWkkAnmPWFhRGsOzow8BhfNyb5GpM
	a/IZUaf8PZicN9WkErzg==
X-Received: by 2002:a17:90b:2787:b0:32d:90c7:c63b with SMTP id 98e67ed59e1d1-33098372be8mr1834587a91.30.1758247927364;
        Thu, 18 Sep 2025 19:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0dA6uOL8zBSD4ifIfanjSRCgJfG2G7xQhezPfql9HN4fAQL3hx5mizJh0fKSXGQHgP4VGfWBEjqgiGhANTmc=
X-Received: by 2002:a17:90b:2787:b0:32d:90c7:c63b with SMTP id
 98e67ed59e1d1-33098372be8mr1834571a91.30.1758247926875; Thu, 18 Sep 2025
 19:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 10:11:55 +0800
X-Gm-Features: AS18NWB0qAf9gkfL6TujRcG_tVjSEKwQSfq6IiG9N7XzHSpu5Nco7jPOo01Et1U
Message-ID: <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix incorrect flags recording in big mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
>
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
>
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packet=
s handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 975bdc5dab84..6e6e74390955 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
>          */
>         flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>
> -       if (vi->mergeable_rx_bufs)
> +       if (vi->mergeable_rx_bufs) {
>                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, xdp=
_xmit,
>                                         stats);
> -       else if (vi->big_packets)
> +       } else if (vi->big_packets) {
> +               void *p;
> +
> +               p =3D page_address((struct page *)buf);
> +               flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flags;
> +

Patch looks good but a I have a nit:

It looks better to move this above?

if (vi->big_packets) {
               void *p =3D page_address((struct page *)buf);
               flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flags;
} else
               flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;

To avoid twice the calculations and reuse the comment.

>                 skb =3D receive_big(dev, vi, rq, buf, len, stats);
> -       else
> +       } else {
>                 skb =3D receive_small(dev, vi, rq, buf, ctx, len, xdp_xmi=
t, stats);
> +       }
>
>         if (unlikely(!skb))
>                 return;
> --
> 2.32.0.3.g01195cf9f
>

Thanks


