Return-Path: <netdev+bounces-109845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED092A119
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9F0B257A9
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3B84E04;
	Mon,  8 Jul 2024 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhP/sgOR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D181728
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437954; cv=none; b=BqVT/ifRmK6A16YYogmsF8PBqc2oZw/ETQoV5Ta5goxewioiDTuKN1xnSOdAonliXvUQ+qpo+UDCQFsuQ7ODi88r6SMGI5bTM5Wj/HqhFtlgS8ubuVHZk5gsLxCQ00Wrsd7O2vzvWllsZT2lxmWe0MOvjjRpDE8eVlybJ+Zj578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437954; c=relaxed/simple;
	bh=wSXAufGS33A+g31uLFNE5gMkFnYRYUjMJqfaxxbqvlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmQD8rocIDUlHnnp6a0js1TEP7ePLLkkdfr6wX4NoRjlQgHomKnL6MMWuaNwgMQeWiOya1+pnEmIUFHuJzlQbQALDSroSgK22/FZDasrN7NNsrmv9FH0kTWHROpLDq2tc/1pF51/i2u2e4KfINfiS2gi3vg25vlJJukqJXKiPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AhP/sgOR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720437951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbjlsnNLRZ3Y3h4bS5hjT+as3LF63nqqhBb1T5h2agU=;
	b=AhP/sgOR4RG0aO4Hh+ZvnK3lv1TGibiKLbkis8ZJl6ZuvMSlUdE2/+miW/he8DoiVpta+Z
	DAwHNkcjm89o3bYeRFU0uu/wwsNdR+rNlMR2K7Rr9tLhiPx34O7ix8Z8Qty+ELdAx7jyxK
	V/oUHWsQrAcWTyxjAUGXJMYWtstrFlo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-cN0zwModPeaiCkunPoZfoA-1; Mon, 08 Jul 2024 07:25:50 -0400
X-MC-Unique: cN0zwModPeaiCkunPoZfoA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52eaef92c91so1531932e87.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 04:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437948; x=1721042748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbjlsnNLRZ3Y3h4bS5hjT+as3LF63nqqhBb1T5h2agU=;
        b=asugUipm8ASZhjw5wI0KMSHFUoxvkE0YA60f1paLWPRNTtgmN87+H5z/mRibrWVbSi
         qLJIcTm2CnyYudyQ2WL1a9b5/6H5LKVpVEb3vhGKOm/59jfQQ7bYwTzqaeS+gdIk+6Dt
         25cvOe2cjxzMW14Mod7fxHkd+LWJm10XuEMIctnYD9QsBf77QbzILzodMA/3dHYxoC4O
         AWjo7DIOihnCXcgfIJerdslzU3WgfmYWnbfVY6y+dQzaMKpTK8ibGLclmnU9q9w01ScK
         tdtLI24czTv+EburQFYQlRXtHtGUbgiJY5b5UhqdAIamhEKrobmoWZ/LOoA/qCEXwoVk
         mDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwP4Vt7Foi8ZTrAmGkQp+4IVGgcRPciLxjqM4qAIoXVbuHUjMQyP2p8NNmfOwafLb09lvc+9ohY/b8pW6+Usre/cTL9VMp
X-Gm-Message-State: AOJu0YzmnFuHCPh/zVP2AChiZRjmJ6hX5Y8bxbYuA8oi6SL2doshd95u
	LJyvpuSKnESXX4CkVjtqvP+fqreHsCMFOX3r8xoAvYefDYQqBKOdTEa5ddilYYhF/RY+ZoVgQxC
	5av4+uK+VMyO2t+fGNzCigSAqo5EJfPFx1xDWK4fYirL+imIYZQ251g==
X-Received: by 2002:ac2:5dcb:0:b0:52c:dda1:5db1 with SMTP id 2adb3069b0e04-52ea0719788mr6849929e87.67.1720437948512;
        Mon, 08 Jul 2024 04:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4an8RKcAHlkP4SpdhvIfOcH9d3f3yG6Oc24mAEVDoPz82fV114LsKh2i7viRb5K4t/8C0bw==
X-Received: by 2002:ac2:5dcb:0:b0:52c:dda1:5db1 with SMTP id 2adb3069b0e04-52ea0719788mr6849913e87.67.1720437947876;
        Mon, 08 Jul 2024 04:25:47 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2519a4sm160086225e9.35.2024.07.08.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:25:47 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:25:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Tariq Toukan <tariqt@nvidia.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Message-ID: <20240708072443-mutt-send-email-mst@kernel.org>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com>
 <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
 <CAJaqyWeHDD0drkAZQqEP_ZfbUPscOmM7T8zXRie5Q14nfAV0sg@mail.gmail.com>
 <c6dc541919a0cc78521364dbf4db32293cf1071e.camel@nvidia.com>
 <20240708071005-mutt-send-email-mst@kernel.org>
 <27ef979aff26d3614091a4b966fc8b1d866e236f.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27ef979aff26d3614091a4b966fc8b1d866e236f.camel@nvidia.com>

On Mon, Jul 08, 2024 at 11:17:06AM +0000, Dragos Tatulea wrote:
> On Mon, 2024-07-08 at 07:11 -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 08, 2024 at 11:01:39AM +0000, Dragos Tatulea wrote:
> > > On Wed, 2024-07-03 at 18:01 +0200, Eugenio Perez Martin wrote:
> > > > On Wed, Jun 26, 2024 at 11:27 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > > > 
> > > > > On Wed, 2024-06-19 at 17:54 +0200, Eugenio Perez Martin wrote:
> > > > > > On Mon, Jun 17, 2024 at 5:09 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > > > > > 
> > > > > > > Currently, hardware VQs are created right when the vdpa device gets into
> > > > > > > DRIVER_OK state. That is easier because most of the VQ state is known by
> > > > > > > then.
> > > > > > > 
> > > > > > > This patch switches to creating all VQs and their associated resources
> > > > > > > at device creation time. The motivation is to reduce the vdpa device
> > > > > > > live migration downtime by moving the expensive operation of creating
> > > > > > > all the hardware VQs and their associated resources out of downtime on
> > > > > > > the destination VM.
> > > > > > > 
> > > > > > > The VQs are now created in a blank state. The VQ configuration will
> > > > > > > happen later, on DRIVER_OK. Then the configuration will be applied when
> > > > > > > the VQs are moved to the Ready state.
> > > > > > > 
> > > > > > > When .set_vq_ready() is called on a VQ before DRIVER_OK, special care is
> > > > > > > needed: now that the VQ is already created a resume_vq() will be
> > > > > > > triggered too early when no mr has been configured yet. Skip calling
> > > > > > > resume_vq() in this case, let it be handled during DRIVER_OK.
> > > > > > > 
> > > > > > > For virtio-vdpa, the device configuration is done earlier during
> > > > > > > .vdpa_dev_add() by vdpa_register_device(). Avoid calling
> > > > > > > setup_vq_resources() a second time in that case.
> > > > > > > 
> > > > > > 
> > > > > > I guess this happens if virtio_vdpa is already loaded, but I cannot
> > > > > > see how this is different here. Apart from the IOTLB, what else does
> > > > > > it change from the mlx5_vdpa POV?
> > > > > > 
> > > > > I don't understand your question, could you rephrase or provide more context
> > > > > please?
> > > > > 
> > > > 
> > > > My main point is that the vdpa parent driver should not be able to
> > > > tell the difference between vhost_vdpa and virtio_vdpa. The only
> > > > difference I can think of is because of the vhost IOTLB handling.
> > > > 
> > > > Do you also observe this behavior if you add the device with "vdpa
> > > > add" without the virtio_vdpa module loaded, and then modprobe
> > > > virtio_vdpa?
> > > > 
> > > Aah, now I understand what you mean. Indeed in my tests I was loading the
> > > virtio_vdpa module before adding the device. When doing it the other way around
> > > the device doesn't get configured during probe.
> > >  
> > > 
> > > > At least the comment should be something in the line of "If we have
> > > > all the information to initialize the device, pre-warm it here" or
> > > > similar.
> > > Makes sense. I will send a v3 with the commit + comment message update.
> > 
> > 
> > Is commit update the only change then?
> I was planning to drop the paragraph in the commit message (it is confusing) and
> edit the comment below (scroll down to see which).
> 
> Let me know if I should send the v3 or not. I have it prepared.

You can do this but pls document that the only change is in commit log.


> > 
> > > > 
> > > > > Thanks,
> > > > > Dragos
> > > > > 
> > > > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 ++++++++++++++++++++++++++++++++-----
> > > > > > >  1 file changed, 32 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index 249b5afbe34a..b2836fd3d1dd 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > > > >         mvq = &ndev->vqs[idx];
> > > > > > >         if (!ready) {
> > > > > > >                 suspend_vq(ndev, mvq);
> > > > > > > -       } else {
> > > > > > > +       } else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
> > > > > > >                 if (resume_vq(ndev, mvq))
> > > > > > >                         ready = false;
> > > > > > >         }
> > > > > > > @@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> > > > > > >                                 goto err_setup;
> > > > > > >                         }
> > > > > > >                         register_link_notifier(ndev);
> > > > > > > -                       err = setup_vq_resources(ndev, true);
> > > > > > > -                       if (err) {
> > > > > > > -                               mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> > > > > > > -                               goto err_driver;
> > > > > > > +                       if (ndev->setup) {
> > > > > > > +                               err = resume_vqs(ndev);
> > > > > > > +                               if (err) {
> > > > > > > +                                       mlx5_vdpa_warn(mvdev, "failed to resume VQs\n");
> > > > > > > +                                       goto err_driver;
> > > > > > > +                               }
> > > > > > > +                       } else {
> > > > > > > +                               err = setup_vq_resources(ndev, true);
> > > > > > > +                               if (err) {
> > > > > > > +                                       mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> > > > > > > +                                       goto err_driver;
> > > > > > > +                               }
> > > > > > >                         }
> > > > > > >                 } else {
> > > > > > >                         mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
> > > > > > > @@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
> > > > > > >                 if (mlx5_vdpa_create_dma_mr(mvdev))
> > > > > > >                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
> > > > > > >         }
> > > > > > > +       setup_vq_resources(ndev, false);
> > > > > > >         up_write(&ndev->reslock);
> > > > > > > 
> > > > > > >         return 0;
> > > > > > > @@ -3836,8 +3845,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > > > > > >                 goto err_reg;
> > > > > > > 
> > > > > > >         mgtdev->ndev = ndev;
> > > > > > > +
> > > > > > > +       /* For virtio-vdpa, the device was set up during device register. */
> > > > > > > +       if (ndev->setup)
> > > > > > > +               return 0;
> > > > > > > +
> This comment updated to:
> 
> /* The VQs might have been pre-created during device register.
>  * This happens when virtio_vdpa is loaded before the vdpa device is added.
>  */
> 
> 
> > > > > > > +       down_write(&ndev->reslock);
> > > > > > > +       err = setup_vq_resources(ndev, false);
> > > > > > > +       up_write(&ndev->reslock);
> > > > > > > +       if (err)
> > > > > > > +               goto err_setup_vq_res;
> > > > > > > +
> > > > > > >         return 0;
> > > > > > > 
> > > > > > > +err_setup_vq_res:
> > > > > > > +       _vdpa_unregister_device(&mvdev->vdev);
> > > > > > >  err_reg:
> > > > > > >         destroy_workqueue(mvdev->wq);
> > > > > > >  err_res2:
> > > > > > > @@ -3863,6 +3885,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> > > > > > > 
> > > > > > >         unregister_link_notifier(ndev);
> > > > > > >         _vdpa_unregister_device(dev);
> > > > > > > +
> > > > > > > +       down_write(&ndev->reslock);
> > > > > > > +       teardown_vq_resources(ndev);
> > > > > > > +       up_write(&ndev->reslock);
> > > > > > > +
> > > > > > >         wq = mvdev->wq;
> > > > > > >         mvdev->wq = NULL;
> > > > > > >         destroy_workqueue(wq);
> > > > > > > 
> > > > > > > --
> > > > > > > 2.45.1
> > > > > > > 
> > > > > > 
> > > > > 
> > > > 
> > > 
> > 
> Thanks,
> Dragos
> 


