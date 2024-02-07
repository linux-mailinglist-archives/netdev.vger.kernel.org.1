Return-Path: <netdev+bounces-69696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A76F84C313
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4208028D409
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF2F9EF;
	Wed,  7 Feb 2024 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB47q0Lw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1652134A5
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276451; cv=none; b=dgFQWm7RqxttXTtvALDtOQFv2o6abuaRvZr0exysps3pvkVerx8tlFfVH8VfdrUXq8xMcrJ6VtrjWZHs6ER6cXMRw4aY2L85Wr5IYgMxTTPyYzWfiGXp2txPd0uZdN/BD2NV0lk2EtKEnAi7Ki8SgqVyWeFU7r4aHKBZuk2RCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276451; c=relaxed/simple;
	bh=qsE//gaQh/ELevMsklLn/ApppxOTlK4xCHYMHM46s2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RocVhktUCUJChC7YA0r9ZUEFoigX+CX6qGQ2XlLNwmF4gWs0ed2WBBfFjYcCiZzbq1AvPQzLXbubiynN64x7m66PHHIUk8zleNG0G83KeIUv3lP6d6krKnTJaoE4wta/obwCu9EPmsFPGH6vAGphK9Nw8BMxJXmod9cy8rYjPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cB47q0Lw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707276448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECyPdLbuQ8n+CIX5LY9BuiN4WFH5pGMhm7CI6F18Oro=;
	b=cB47q0LwVLp0f+1wvJ6ZyQGxoTr7qMwDQsOH6MFAk54gI5YSBUpxjFyfStZodn4WtM4T8N
	fhaC4CWzRqaLpUPo/US3azQuy8nYoZ/ERChsznwpHpy3IbVwtmndZcMhAiQwiaM+wEl6CO
	JueMgUKzxmpT57HnciBkAX+DAAifkik=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-IZ2yXtQcPPaM3-jkyDsfxQ-1; Tue, 06 Feb 2024 22:27:27 -0500
X-MC-Unique: IZ2yXtQcPPaM3-jkyDsfxQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e04ef89a15so178761b3a.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 19:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707276446; x=1707881246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECyPdLbuQ8n+CIX5LY9BuiN4WFH5pGMhm7CI6F18Oro=;
        b=r4T/qqeNqlXfKvNKeQXM4vHvyib3SxRsotk6H5UKxgSl5f6jI6WGhINLeEYp47qLVl
         IhYVTD56n9YfVptvNBVArGlAtwiG/gFLcXJwm3JE/14oBxsY0uwVb28Xf0tBudckE9xY
         0PkNIMTTTet1n/DKO4KU3J8Fqdg6kZex+s/yExHPRth1dz001s1jV0I5DBIy4TOeLvBz
         MqT3I0cq6/7jMW6nMocgKU4gbzLutuyi45LJqa0OhqOyp9RFE98FOXWY4K2zh+YFdDo4
         gEVLUNkJqwDR39F5TBGKIvBJsSosxijU4qT/Km+AamVt2aL+kOwEY0LlcLB9p7ckt5fq
         FN/g==
X-Gm-Message-State: AOJu0YzITCDJ5mM5GnHNnQWZtaiVCLLZEZQ0LYhyR6rRgFlshS0gduv/
	R4OmrTsf0WceHBdSxE0U1up/DnbMb14mH2+CwQDaCIL4zqDwgwQAJUZZ5OJWk1LnaYW0eRTZ/3V
	tigTVMdoYKHUveTmA6M7+LAiM1c044S8+8e280VXmtkpuBibMK2/XQSgo4WdAIUO7D+KfEkHOgz
	pWpnFRhmCSnC/ob76x4GJABWOnnueh
X-Received: by 2002:aa7:84c6:0:b0:6dd:84ce:4602 with SMTP id x6-20020aa784c6000000b006dd84ce4602mr1445735pfn.6.1707276446477;
        Tue, 06 Feb 2024 19:27:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOduHPoLP4mCVG39rBl1Z8IToYghCDdc8bbnZRY4nXuhv/6H/c+FYVQ3yUyKyTYydLTVyAuvDaqusFQbjMZgQ=
X-Received: by 2002:aa7:84c6:0:b0:6dd:84ce:4602 with SMTP id
 x6-20020aa784c6000000b006dd84ce4602mr1445717pfn.6.1707276446144; Tue, 06 Feb
 2024 19:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206145154.118044-1-sgarzare@redhat.com>
In-Reply-To: <20240206145154.118044-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Feb 2024 11:27:14 +0800
Message-ID: <CACGkMEs-FAz7Xv7j6k3grq97q9qO18Em2bLDS4qBaCDZS7+gbQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: fail enabling virtqueue in certain conditions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:52=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
> the driver to enable virtqueue before setting DRIVER_OK. If the driver
> tries anyway, better to fail right away as soon as we get the ioctl.
> Let's also update the documentation to make it clearer.
>
> We had a problem in QEMU for not meeting this requirement, see
> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.co=
m/

Maybe it's better to only enable cvq when the backend supports
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK. Eugenio, any comment on this?

>
> Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK=
 backend feature")
> Cc: eperezma@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
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

As discussed, without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we don't
know if parents can do vq_ready after driver_ok.

So maybe we need to keep this behaviour to unbreak some "legacy" userspace?

For example ifcvf did:

static void ifcvf_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev,
                                    u16 qid, bool ready)
{
  struct ifcvf_hw *vf =3D vdpa_to_vf(vdpa_dev);

        ifcvf_set_vq_ready(vf, qid, ready);
}

And it did:

void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready)
{
        struct virtio_pci_common_cfg __iomem *cfg =3D hw->common_cfg;

        vp_iowrite16(qid, &cfg->queue_select);
        vp_iowrite16(ready, &cfg->queue_enable);
}

Though it didn't advertise VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK?

Adding LingShan for more thought.

Thanks

>                 ops->set_vq_ready(vdpa, idx, s.num);
>                 return 0;
>         case VHOST_VDPA_GET_VRING_GROUP:
> --
> 2.43.0
>


