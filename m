Return-Path: <netdev+bounces-69594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E684BC41
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 18:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DC32886B5
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82D12E68;
	Tue,  6 Feb 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWofQWcu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850C17984
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240981; cv=none; b=B4sjT97UuXBGce4Qoec3W1pGDykqElmjtji9N6U+LDuskfV+xoJRiWx6/RqqauHbfek3pWIkR63s9a3rrVJdNsmrKnGzXwIiRxb2ZmU2WQ2btHNN0ZtM8QmKRGNQep2H0M53i+w0El3+iThVlRgyi0Vu70smm2SBx/OCrQAIqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240981; c=relaxed/simple;
	bh=EgGDBbZ8+lAAJFJm66AGG91meRlr6iHc9QtL3E559gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as8ep8UOQ3WG1cgxvQcxMklgP6q3LeNvoc4ki2ZhL92O9VymQeCXLSP6IIMzuPrHnvcxq/MAfbWmWlck7KOsoTPpGHdWlp2mId9Id8UcN8ZpiseFU5kUrY0nab6q1y4xAMN73H1/x0A8RR5WewO/oO9nH34Nv10wn6DJvDv1tDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWofQWcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707240978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZENp1XRarjD9Kp7owUS6q4NwHgfnf3F2xZAxgOWi78s=;
	b=GWofQWculi2VckgXH7GFv8e9/tB+MXDqm4uAm9d/f5thpsBDnlu6jegoeOJexvdGQKzjVr
	0kZXvyjQRRpIbPwMn3PuGlT/5eTftVMjG37WH1WzOO0CfjCOsqtoW02/7hdRoorqhECdyl
	5/x5hcS5BA4jqVKyeC4GluMn0uQuc1c=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-Lnx8FUspPdCGlhOKgb_SqA-1; Tue, 06 Feb 2024 12:36:17 -0500
X-MC-Unique: Lnx8FUspPdCGlhOKgb_SqA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5f874219ff9so10588137b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 09:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240977; x=1707845777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZENp1XRarjD9Kp7owUS6q4NwHgfnf3F2xZAxgOWi78s=;
        b=rK6uFNgMFzA5kcnHHOQ1GnnilUEWGmAfCjdXRdH57CuTdJKkkapW8JLafbuOeBvtKq
         zNJr0VB+a4xbV/qfIkVk/GrYnYHqrmalUMWees/Z86vFi14BHUoc48BTPLSH1apwTkqJ
         bN5PbyK5hed10QEwkuVszcUV+DIu1LCQaAnG8GnzqYyUgo9OBZIY2M7xtpc+G2RV6Dxa
         4tQrbiHyU7lAhtaU4xwWMiViHDpyinboHdP8U9eJ5UFgdVjNSIcwmp56YNKfBUEzAY6v
         TKupVbDO2Zr2GXxxbakdIVCdUrEubYJnvwplC9oQjfqIXdrXevwXBdBNvJp1SU4J3kJw
         5BAQ==
X-Gm-Message-State: AOJu0YzfaYKlqQa21eJMydSx82h7fvxkpRkYobRaRu+2U5LOMe2E9h1d
	Zn9nA3oC6SDOQU3BQT1+11JpLC2WhUwOZdNbpCVFbVBrUfl7bGVTEF9J0JzUCCDP3rmPkV8Pj0R
	yxW941ChrY0fdsSu3e5b3nrCiNFjAgmI6tQAFskEGKzd+iUw7T6eNKXeyaKrVjpcUChKHSKw1N8
	7PKa6r0Q5ZPdTT2RTOZFqp0xRCu7k/
X-Received: by 2002:a81:4ccb:0:b0:604:1e7:ed34 with SMTP id z194-20020a814ccb000000b0060401e7ed34mr1902288ywa.8.1707240976837;
        Tue, 06 Feb 2024 09:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxsoLYqSSMbCU77v90TG/WTQz3YG6Xm36n5Tc/zJRrQZ98F/A62FMnndvspiR9Sa5128FVBYVrznfqUq5khHM=
X-Received: by 2002:a81:4ccb:0:b0:604:1e7:ed34 with SMTP id
 z194-20020a814ccb000000b0060401e7ed34mr1902267ywa.8.1707240976523; Tue, 06
 Feb 2024 09:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206145154.118044-1-sgarzare@redhat.com>
In-Reply-To: <20240206145154.118044-1-sgarzare@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 6 Feb 2024 18:35:40 +0100
Message-ID: <CAJaqyWc2GuTk4dKW98qPunKpOMVGZwWYZ4zpjp4KrGoAoqRwNw@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: fail enabling virtqueue in certain conditions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:52=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
> the driver to enable virtqueue before setting DRIVER_OK. If the driver
> tries anyway, better to fail right away as soon as we get the ioctl.
> Let's also update the documentation to make it clearer.
>
> We had a problem in QEMU for not meeting this requirement, see
> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.co=
m/
>
> Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK=
 backend feature")
> Cc: eperezma@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  include/uapi/linux/vhost_types.h | 3 ++-
>  drivers/vhost/vdpa.c             | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index d7656908f730..5df49b6021a7 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -182,7 +182,8 @@ struct vhost_vdpa_iova_range {
>  /* Device can be resumed */
>  #define VHOST_BACKEND_F_RESUME  0x5
>  /* Device supports the driver enabling virtqueues both before and after
> - * DRIVER_OK
> + * DRIVER_OK. If this feature is not negotiated, the virtqueues must be
> + * enabled before setting DRIVER_OK.
>   */
>  #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
>  /* Device may expose the virtqueue's descriptor area, driver area and
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..1fba305ba8c1 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -651,6 +651,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa=
 *v, unsigned int cmd,
>         case VHOST_VDPA_SET_VRING_ENABLE:
>                 if (copy_from_user(&s, argp, sizeof(s)))
>                         return -EFAULT;
> +               if (!vhost_backend_has_feature(vq,
> +                       VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) &&
> +                   (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +                       return -EINVAL;
>                 ops->set_vq_ready(vdpa, idx, s.num);
>                 return 0;
>         case VHOST_VDPA_GET_VRING_GROUP:
> --
> 2.43.0
>


