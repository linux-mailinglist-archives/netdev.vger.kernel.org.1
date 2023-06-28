Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7517C740B03
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjF1ITP (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 04:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233760AbjF1IMi (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 04:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cTND2wcrFvf5T3HdGEC88WLZ2tC38KyAB0FmRrOrTk=;
        b=APlIzu0aF5zOHR51ZpdPPAiQCOBIXIbgWfWn8IPNq5MuIw1NFYiT2ENRDPgqOmSiV/mWdO
        8l70Q7cyhM65lKUU0FJxnWAUuNZZF4CbJYabIpRtsWFzfpUgBV7mx/Lc8Jxz8SfMY39tQj
        zJZSJxPG9C+b0lAA1f8E+yD6PtQcfKw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-cxoqUg5HMEiO8GiyC5EpeA-1; Wed, 28 Jun 2023 04:11:40 -0400
X-MC-Unique: cxoqUg5HMEiO8GiyC5EpeA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6990c799dso30552751fa.0
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 01:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939899; x=1690531899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cTND2wcrFvf5T3HdGEC88WLZ2tC38KyAB0FmRrOrTk=;
        b=B13Ubs/5oew0N2fdPP9/dUFrnPZSuOkpTCGysF/kHmydqtmMIe4WoAIkAhwmsGjcH4
         jRcvPKs5unuuoMlMjQI3PliiID7nFdVufBF3dRfw5qUssOIFRaV1sz/ZQKCAPiU2c8rF
         gJDfaf/6OYs1U//1VEcDSbpSiOpvss27B+1aft006siulGQleSqlChJdHMpA7r1NnLum
         WvYbyHtlYCtkxTDTU7SDNMS7+XdRZQ9863VmaCgeeMaK6r9oy7GY0/jQADXN3wh8UQBK
         Tb1nRpy8EHJouFM0dZNboVT7UmX+wQvn5Fn8Lj4WUqcglptrXl4B0KJdkqViZuDsf7jA
         zfNg==
X-Gm-Message-State: AC+VfDx6T5VjwmSl56l/5mktcTV4V1hE+GJVmV9rQo5qtvfquZ8Jckr2
        +JoWMpDR+n4kWmiG+7iEj0roPlx9jg8Rthv5n98ZaSrEEFKGwSpsNBIdA9RubOa91109sd9mO7x
        eCUNbSni1KsX6i3iv3dMT6PfVSOVQgHuV
X-Received: by 2002:a2e:b0c3:0:b0:2b6:a75b:c5f2 with SMTP id g3-20020a2eb0c3000000b002b6a75bc5f2mr5105443ljl.32.1687939899075;
        Wed, 28 Jun 2023 01:11:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hL8AvEQrWFOAL7w+oejp5DdV0UlLp5XupFg/wppPG5fuNsIH20ieYEPTpEECGwRrlsQbTp1I7XJfrVR4E4LE=
X-Received: by 2002:a2e:b0c3:0:b0:2b6:a75b:c5f2 with SMTP id
 g3-20020a2eb0c3000000b002b6a75bc5f2mr5105426ljl.32.1687939898789; Wed, 28 Jun
 2023 01:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-4-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-4-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 16:11:27 +0800
Message-ID: <CACGkMEs2V2gqGOv1jd-ZrT-9HHnSU6dhC=1zUojHRDGCeG2E7w@mail.gmail.com>
Subject: Re: [RFC 3/4] vduse: Add the function for get/free the mapp pages
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

On Wed, Jun 28, 2023 at 2:59=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> From: Your Name <you@example.com>
>
> Add the function for get/free pages, ad this info
> will saved in dev->reconnect_info

I think this should be squashed to patch 2 otherwise it fixes a bug
that is introduced in patch 2?

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 35 ++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 1b833bf0ae37..3df1256eccb4 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1313,6 +1313,35 @@ static struct vduse_dev *vduse_dev_get_from_minor(=
int minor)
>         return dev;
>  }
>
> +int vduse_get_vq_reconnnect(struct vduse_dev *dev, u16 idx)
> +{
> +       struct vdpa_reconnect_info *area;
> +       void *addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> +
> +       area =3D &dev->reconnect_info[idx];
> +
> +       area->addr =3D virt_to_phys(addr);
> +       area->vaddr =3D (unsigned long)addr;
> +       area->size =3D PAGE_SIZE;
> +       area->index =3D idx;
> +
> +       return 0;
> +}
> +
> +int vduse_free_vq_reconnnect(struct vduse_dev *dev, u16 idx)
> +{
> +       struct vdpa_reconnect_info *area;
> +
> +       area =3D &dev->reconnect_info[idx];
> +       if ((area->size =3D=3D PAGE_SIZE) && (area->addr !=3D NULL)) {
> +               free_page(area->vaddr);
> +               area->size =3D 0;
> +               area->addr =3D 0;
> +               area->vaddr =3D 0;
> +       }
> +
> +       return 0;
> +}
>
>  static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
>  {
> @@ -1446,6 +1475,10 @@ static int vduse_destroy_dev(char *name)
>                 mutex_unlock(&dev->lock);
>                 return -EBUSY;
>         }
> +       for (int i =3D 0; i < dev->vq_num; i++) {
> +
> +               vduse_free_vq_reconnnect(dev, i);
> +       }
>         dev->connected =3D true;
>         mutex_unlock(&dev->lock);
>
> @@ -1583,6 +1616,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>                 INIT_WORK(&dev->vqs[i].kick, vduse_vq_kick_work);
>                 spin_lock_init(&dev->vqs[i].kick_lock);
>                 spin_lock_init(&dev->vqs[i].irq_lock);
> +
> +               vduse_get_vq_reconnnect(dev, i);

Can we delay the allocated until fault?

Thanks

>         }
>
>         ret =3D idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
> --
> 2.34.3
>

