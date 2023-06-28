Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10496740BF6
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjF1Izx (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 04:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233685AbjF1IJp (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 04:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpBHuqgFMq924SVEU5PVhg79o4Lnwc8I8AxFIOnjXWg=;
        b=ggWEdtNaWoZW1N5CzCyW+uEIlPe7cMOjsDlrz9wC8ynafBTGpG6fMnWoNpJYHcypuwiHCK
        wSlaALJRh+f3YdelB3oBrvFLlrY75txQFdNErDabkJBLQk78Dl0suNiDQr9RRwzwZJQjeI
        /VsFFHOJgNdzzMtUPb5VTc2alFV2H2I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-u0PDKsexPduLAO41nEgxAw-1; Wed, 28 Jun 2023 04:08:53 -0400
X-MC-Unique: u0PDKsexPduLAO41nEgxAw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b69b2eb3f7so28147711fa.1
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 01:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939732; x=1690531732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpBHuqgFMq924SVEU5PVhg79o4Lnwc8I8AxFIOnjXWg=;
        b=LNdpgJuUvUrcj4MTlhsrA2naKpyMBOrDvbPN2oTyXnEynNhwwjx/O0mqCkOMA+C0uO
         gZToXttItjNLy4/jTjEltXWBqwOJ2Rt64c6mTPDV0H3i5Oa1WZpucmp+wCEymmBtfQYo
         xMUVrfMSEjotDrhvU7jgftoitxyc+K/90NpgdTTq2AeyHbmtQ1X9dZ2aXtylXUx/PsW6
         b3NI4ZarAaKOrhxCoflAJSbOz6Xg8kKjlmySSmiZs2MZ21PpCcn9uIAHYKndoEeqZj8c
         E938eUopiZv3xPA//urVGhihDYo+P42raF9+4UqgHpfujFsbNGFL9uLmg36q9JfHLdFP
         qPKA==
X-Gm-Message-State: AC+VfDzlodypMlT3H3c2Oi3JS5QgfPj7zdpwhHiClYCdARHNTNBgbgmM
        t17+BuQYVgdIVm6RRiKp0jNbvSQq26DTvNkP3eODa2SUINfEGzhuA8vmI7TTt9YlED4hPfv15l9
        rqVQhDkZHyFH5w838MVfsjbYgOO4eamda
X-Received: by 2002:a2e:6a10:0:b0:2b6:a76b:c39e with SMTP id f16-20020a2e6a10000000b002b6a76bc39emr4223206ljc.35.1687939731900;
        Wed, 28 Jun 2023 01:08:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+2Gicsdplyts+dFUSGHhnRnz2PbkDycBiBNT+Jwcbz1g8KzKNLvTR0NgEfWGTD+ab672YFJAqtl48gc9cCKM=
X-Received: by 2002:a2e:6a10:0:b0:2b6:a76b:c39e with SMTP id
 f16-20020a2e6a10000000b002b6a76bc39emr4223191ljc.35.1687939731611; Wed, 28
 Jun 2023 01:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-3-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-3-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 16:08:39 +0800
Message-ID: <CACGkMEuzrFP96qcFL0M=nGiQ9t57-EzOhZmB3No-8T8pMAWTxw@mail.gmail.com>
Subject: Re: [RFC 2/4] vduse: Add file operation for mmap
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
> Add the operation for mmap, The user space APP will
> use this function to map the pages to userspace

Please be specific in the log. E.g why and what the main goal for this mmap=
.

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 49 ++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index f845dc46b1db..1b833bf0ae37 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1313,6 +1313,54 @@ static struct vduse_dev *vduse_dev_get_from_minor(=
int minor)
>         return dev;
>  }
>
> +
> +static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> +{
> +       struct vduse_dev *dev =3D vmf->vma->vm_file->private_data;
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       u16 index =3D vma->vm_pgoff;
> +
> +       struct vdpa_reconnect_info *info;
> +       info =3D &dev->reconnect_info[index];
> +
> +       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK, PFN_DOWN(info-=
>addr),
> +                           PAGE_SIZE, vma->vm_page_prot))

I'm not sure if this can work e.g do we want to use separate pages for
each virtqueue (I think the answer is yes).

> +               return VM_FAULT_SIGBUS;
> +       return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vduse_vm_ops =3D {
> +       .fault =3D vduse_vm_fault,
> +};
> +
> +static int vduse_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct vduse_dev *dev =3D file->private_data;
> +       struct vdpa_reconnect_info *info;
> +       unsigned long index =3D vma->vm_pgoff;
> +
> +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> +               return -EINVAL;
> +       if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> +               return -EINVAL;
> +
> +       if (index > 65535)
> +               return -EINVAL;
> +
> +       info =3D &dev->reconnect_info[index];
> +       if (info->addr & (PAGE_SIZE - 1))
> +               return -EINVAL;
> +       if (vma->vm_end - vma->vm_start !=3D info->size) {
> +               return -ENOTSUPP;
> +       }

How can userspace know the correct size (info->size) here?

> +
> +       vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP=
);

Why do you need VM_IO, VM_PFNMAP and VM_DONTDUMP here?

Thanks

> +       vma->vm_ops =3D &vduse_vm_ops;
> +
> +       return 0;
> +}
> +
>  static int vduse_dev_open(struct inode *inode, struct file *file)
>  {
>         int ret;
> @@ -1345,6 +1393,7 @@ static const struct file_operations vduse_dev_fops =
=3D {
>         .unlocked_ioctl =3D vduse_dev_ioctl,
>         .compat_ioctl   =3D compat_ptr_ioctl,
>         .llseek         =3D noop_llseek,
> +       .mmap           =3D vduse_mmap,
>  };
>
>  static struct vduse_dev *vduse_dev_create(void)
> --
> 2.34.3
>

