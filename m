Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0AE740B05
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 10:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjF1ITj (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 04:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233777AbjF1IOT (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 04:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687940009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2B1ynmbT0UkVLiBLPkihB9uufQdZmbcV3Hls/wgSG4U=;
        b=A5qeOayM0dK13lLqMZ8/Jec4IukNslQCV4l1FpqSjGoauOrmk9Cwz54ZPgio/f31g0RTsP
        fkO5x7fa9zNdJdBplHzUP/vAuFELJqJM9LzhIDlV5oETVkAAx8yDbp7BKTeON2BkiIXZC/
        wM77R6tNappoED1Rx3klwUlBdyYUwBY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-eNWdh1maPWmThJ6mLpfoyA-1; Wed, 28 Jun 2023 04:13:27 -0400
X-MC-Unique: eNWdh1maPWmThJ6mLpfoyA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6b98ac356so6970711fa.1
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 01:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940006; x=1690532006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B1ynmbT0UkVLiBLPkihB9uufQdZmbcV3Hls/wgSG4U=;
        b=Y3yr5neBxa3f3AkxtbasI0WRpvdgsG24bgu6o8HgTNYNCjrB+eoQ22MHVD+231RTfN
         1n4lYZhz0WTcx4dwk17zXpQ6QXBE6F6UEkr2WFCJfQWS8ewvrmobbHHhQaHfeiscyEcp
         Z3C9Rr+7NTswKb62WoQgQfd+Vn3E76J7q3fk6kKQOfMquL5UslkWYfAa8gAbQsCW7WpE
         SCbxffXcp/5Ex7UQGK2+fbCMjbIEykdrLXicIx9gS6iGB9mPfkuDZCBajMDVQTZvZfU7
         YLmqdwKcPZa4FjW7O41eD0C1IgUbxBWTBKnK0vkV8QythhBeKxY6o1cIxlqbSy49Trmr
         iztA==
X-Gm-Message-State: AC+VfDzxcty1iZPZi8X/i32Vglnm8aiEjxapCG1IU1b2/9qqHxd9DheO
        AACwHaI4IwkX5eRbRagTdkdqJIpKzY5pk8nqrWcPT2WGWRdnYyqbgStbNXavehleARQHcrVj0FM
        GLyoVk0l7DrhjjX8l8ssTRPcmVbEfDJSv
X-Received: by 2002:a2e:9943:0:b0:2b6:9909:79b6 with SMTP id r3-20020a2e9943000000b002b6990979b6mr6308002ljj.40.1687940006183;
        Wed, 28 Jun 2023 01:13:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5hUOUptmy1cz/bmc0SQBwJ16zCTf1sq+b8bGF74Opubi8l0hmlcMZJAcxolSBWuUoW13vUTOVfJelNLYP6OGc=
X-Received: by 2002:a2e:9943:0:b0:2b6:9909:79b6 with SMTP id
 r3-20020a2e9943000000b002b6990979b6mr6307993ljj.40.1687940005910; Wed, 28 Jun
 2023 01:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-5-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-5-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 16:13:14 +0800
Message-ID: <CACGkMEtN7pE4FK2-504JC3A1tcfPjy9QejJiTyvXD7nt49KLvA@mail.gmail.com>
Subject: Re: [RFC 4/4] vduse: update the vq_info in ioctl
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, maxime.coquelin@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, Jun 28, 2023 at 3:00=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> From: Your Name <you@example.com>
>
> in VDUSE_VQ_GET_INFO, driver will sync the last_avail_idx
> with reconnect info, I have olny test the split mode, so

Typo, should be "only".

> only use this here, will add more information later
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 3df1256eccb4..b8e453eac0ce 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -141,6 +141,11 @@ static u32 allowed_device_id[] =3D {
>         VIRTIO_ID_NET,
>  };
>
> +struct vhost_reconnect_vring {
> +       uint16_t last_avail_idx;
> +       bool avail_wrap_counter;
> +};

Should this belong to uAPI?

> +
>  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
>  {
>         struct vduse_vdpa *vdev =3D container_of(vdpa, struct vduse_vdpa,=
 vdpa);
> @@ -1176,6 +1181,17 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>                                 vq->state.split.avail_index;
>
>                 vq_info.ready =3D vq->ready;
> +               struct vdpa_reconnect_info *area;
> +
> +               area =3D &dev->reconnect_info[index];
> +               struct vhost_reconnect_vring *log_reconnect;
> +
> +               log_reconnect =3D (struct vhost_reconnect_vring *)area->v=
addr;

What if userspace doesn't do mmap()?

Thanks

> +               if (log_reconnect->last_avail_idx !=3D
> +                   vq_info.split.avail_index) {
> +                       vq_info.split.avail_index =3D
> +                               log_reconnect->last_avail_idx;
> +               }
>
>                 ret =3D -EFAULT;
>                 if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
> --
> 2.34.3
>

