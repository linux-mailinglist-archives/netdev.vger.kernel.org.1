Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E41741299
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjF1Nfd (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 09:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231644AbjF1Neu (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 09:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687959243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UH+6DzHmT9BOK6i8ZFFx7ObF6dyBrHM2rZAy+FrcXEQ=;
        b=STKDixlVrtFL9W1j1tlsasTGuVFdjyzqhfyxZAKvCWj81hKdIboIlzyU0EjC0gih1F5L7Y
        EDMuxGteZt9t7usX0xr82WEMLV8Fq/n0sFZTa9w3JCHeh36brQumNjE84PtmJ4rUg0Q22N
        I8CyJ1V/yDj5yWrW7+xk6mrl1NMio7g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-WUDS4uQLP1yK1fYIDBa_RQ-1; Wed, 28 Jun 2023 09:33:58 -0400
X-MC-Unique: WUDS4uQLP1yK1fYIDBa_RQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f814f78af2so25692795e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 06:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959230; x=1690551230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UH+6DzHmT9BOK6i8ZFFx7ObF6dyBrHM2rZAy+FrcXEQ=;
        b=Qhw49sN1Ad0z96BAEUPRejk81P7OAzDlRHUUnK+s7vDtYYbfVCc26MFS+KzawHs4rD
         x4UEWJOXF4bHQThcRd8UTfrq+NIvA0gct+Szf+6NxNERXt6h1d1h8hIf6RDSd970FJKa
         /i2Fvh3G3iYP6RAuMFNS2WlKC4ZIPRPcYrlXS5yaLUbxN8Tf4jud9VDjhclfcNd2wZLA
         9SnqKKPt/gUz3FF5PA2WT8yM2CuDCuZOltJ7odVYJMTfnMFBGTJf9eh7ReFSIh3TQSfJ
         2Tc3Y4r4IBoDlFPv7dFUc5oJNuSg0V/HCVDCt7TgwbHlDYDpwUL6yPtHlTNmivRhzk+z
         SLng==
X-Gm-Message-State: AC+VfDyk4N4oFwEXLgTXirIkSr1O8O5Nl90fJyuh6gkaVMaBZy+TwjFZ
        i5abJSJcQmpARuRATzDAaCABSfSTfn2nHQgIQzWnGPfwrl55wjoqxUr3kiFoBBdzmmYYY8B8ljz
        fld1CqA6Y+nGU3FZSK7MUzCOSyZk=
X-Received: by 2002:a7b:c38b:0:b0:3fa:93b0:a69c with SMTP id s11-20020a7bc38b000000b003fa93b0a69cmr6934345wmj.24.1687959230338;
        Wed, 28 Jun 2023 06:33:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/tm490XfeHRJ5iUVZLicoUhEVOSF0007FXe0J1iKzXE2Icpx2jHf5tOV3kAL+rQUIgP4h9g==
X-Received: by 2002:a7b:c38b:0:b0:3fa:93b0:a69c with SMTP id s11-20020a7bc38b000000b003fa93b0a69cmr6934327wmj.24.1687959229902;
        Wed, 28 Jun 2023 06:33:49 -0700 (PDT)
Received: from redhat.com ([2.52.153.110])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b003fa999cefc0sm8076525wml.36.2023.06.28.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:33:49 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:33:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230628093334-mutt-send-email-mst@kernel.org>
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org>
 <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
 <20230528073139-mutt-send-email-mst@kernel.org>
 <CACGkMEvcjjGRfNYeZaG0hS8R2fnpve62QFv_ReRTXxCUKwf36w@mail.gmail.com>
 <CACGkMEtgZ_=L2noqdADgNTr_E7s3adw=etvcFt3G7ZERQq43_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtgZ_=L2noqdADgNTr_E7s3adw=etvcFt3G7ZERQq43_g@mail.gmail.com>
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, May 31, 2023 at 09:07:25AM +0800, Jason Wang wrote:
> On Mon, May 29, 2023 at 9:21 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Sun, May 28, 2023 at 7:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, May 26, 2023 at 09:31:34AM +0800, Jason Wang wrote:
> > > > On Thu, May 25, 2023 at 3:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, May 25, 2023 at 11:43:34AM +0800, Jason Wang wrote:
> > > > > > On Wed, May 24, 2023 at 5:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, May 24, 2023 at 04:18:41PM +0800, Jason Wang wrote:
> > > > > > > > This patch convert rx mode setting to be done in a workqueue, this is
> > > > > > > > a must for allow to sleep when waiting for the cvq command to
> > > > > > > > response since current code is executed under addr spin lock.
> > > > > > > >
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > ---
> > > > > > > > Changes since V1:
> > > > > > > > - use RTNL to synchronize rx mode worker
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
> > > > > > > >  1 file changed, 52 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index 56ca1d270304..5d2f1da4eaa0 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -265,6 +265,12 @@ struct virtnet_info {
> > > > > > > >       /* Work struct for config space updates */
> > > > > > > >       struct work_struct config_work;
> > > > > > > >
> > > > > > > > +     /* Work struct for config rx mode */
> > > > > > >
> > > > > > > With a bit less abbreviation maybe? setting rx mode?
> > > > > >
> > > > > > That's fine.
> > > > > >
> > > > > > >
> > > > > > > > +     struct work_struct rx_mode_work;
> > > > > > > > +
> > > > > > > > +     /* Is rx mode work enabled? */
> > > > > > >
> > > > > > > Ugh not a great comment.
> > > > > >
> > > > > > Any suggestions for this. E.g we had:
> > > > > >
> > > > > >         /* Is delayed refill enabled? */
> > > > >
> > > > > /* OK to queue work setting RX mode? */
> > > >
> > > > Ok.
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > > +     bool rx_mode_work_enabled;
> > > > > > > > +
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >       /* Does the affinity hint is set for virtqueues? */
> > > > > > > >       bool affinity_hint_set;
> > > > > > > >
> > > > > > > > @@ -388,6 +394,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
> > > > > > > >       spin_unlock_bh(&vi->refill_lock);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void enable_rx_mode_work(struct virtnet_info *vi)
> > > > > > > > +{
> > > > > > > > +     rtnl_lock();
> > > > > > > > +     vi->rx_mode_work_enabled = true;
> > > > > > > > +     rtnl_unlock();
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void disable_rx_mode_work(struct virtnet_info *vi)
> > > > > > > > +{
> > > > > > > > +     rtnl_lock();
> > > > > > > > +     vi->rx_mode_work_enabled = false;
> > > > > > > > +     rtnl_unlock();
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> > > > > > > >                                   struct virtqueue *vq)
> > > > > > > >  {
> > > > > > > > @@ -2341,9 +2361,11 @@ static int virtnet_close(struct net_device *dev)
> > > > > > > >       return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > > > +static void virtnet_rx_mode_work(struct work_struct *work)
> > > > > > > >  {
> > > > > > > > -     struct virtnet_info *vi = netdev_priv(dev);
> > > > > > > > +     struct virtnet_info *vi =
> > > > > > > > +             container_of(work, struct virtnet_info, rx_mode_work);
> > > > > > > > +     struct net_device *dev = vi->dev;
> > > > > > > >       struct scatterlist sg[2];
> > > > > > > >       struct virtio_net_ctrl_mac *mac_data;
> > > > > > > >       struct netdev_hw_addr *ha;
> > > > > > > > @@ -2356,6 +2378,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > > >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
> > > > > > > >               return;
> > > > > > > >
> > > > > > > > +     rtnl_lock();
> > > > > > > > +
> > > > > > > >       vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
> > > > > > > >       vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
> > > > > > > >
> > > > > > > > @@ -2373,14 +2397,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > > >               dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
> > > > > > > >                        vi->ctrl->allmulti ? "en" : "dis");
> > > > > > > >
> > > > > > > > +     netif_addr_lock_bh(dev);
> > > > > > > > +
> > > > > > > >       uc_count = netdev_uc_count(dev);
> > > > > > > >       mc_count = netdev_mc_count(dev);
> > > > > > > >       /* MAC filter - use one buffer for both lists */
> > > > > > > >       buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
> > > > > > > >                     (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
> > > > > > > >       mac_data = buf;
> > > > > > > > -     if (!buf)
> > > > > > > > +     if (!buf) {
> > > > > > > > +             netif_addr_unlock_bh(dev);
> > > > > > > > +             rtnl_unlock();
> > > > > > > >               return;
> > > > > > > > +     }
> > > > > > > >
> > > > > > > >       sg_init_table(sg, 2);
> > > > > > > >
> > > > > > > > @@ -2401,6 +2430,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > > >       netdev_for_each_mc_addr(ha, dev)
> > > > > > > >               memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
> > > > > > > >
> > > > > > > > +     netif_addr_unlock_bh(dev);
> > > > > > > > +
> > > > > > > >       sg_set_buf(&sg[1], mac_data,
> > > > > > > >                  sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
> > > > > > > >
> > > > > > > > @@ -2408,9 +2439,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > > >                                 VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
> > > > > > > >               dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
> > > > > > > >
> > > > > > > > +     rtnl_unlock();
> > > > > > > > +
> > > > > > > >       kfree(buf);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > > > +{
> > > > > > > > +     struct virtnet_info *vi = netdev_priv(dev);
> > > > > > > > +
> > > > > > > > +     if (vi->rx_mode_work_enabled)
> > > > > > > > +             schedule_work(&vi->rx_mode_work);
> > > > > > > > +}
> > > > > > > > +
> > > > > > >
> > > > > > > >  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
> > > > > > > >                                  __be16 proto, u16 vid)
> > > > > > > >  {
> > > > > > > > @@ -3181,6 +3222,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
> > > > > > > >
> > > > > > > >       /* Make sure no work handler is accessing the device */
> > > > > > > >       flush_work(&vi->config_work);
> > > > > > > > +     disable_rx_mode_work(vi);
> > > > > > > > +     flush_work(&vi->rx_mode_work);
> > > > > > > >
> > > > > > > >       netif_tx_lock_bh(vi->dev);
> > > > > > > >       netif_device_detach(vi->dev);
> > > > > > >
> > > > > > > Hmm so queued rx mode work will just get skipped
> > > > > > > and on restore we get a wrong rx mode.
> > > > > > > Any way to make this more robust?
> > > > > >
> > > > > > It could be done by scheduling a work on restore.
> > > >
> > > > Rethink this, I think we don't need to care about this case since the
> > > > user processes should have been frozened.
> > >
> > > Yes but not the workqueue. Want to switch to system_freezable_wq?
> >
> > Yes, I will do it in v2.
> 
> Actually, this doesn't work. Freezable workqueue can only guarantee
> when being freezed the new work will be queued and not scheduled until
> thaw. So the ktrhead that is executing the workqueue is not freezable.
> The busy loop (even with cond_resched()) will force suspend in this
> case.
> 
> I wonder if we should switch to using a dedicated kthread for
> virtio-net then we can allow it to be frozen.
> 
> Thanks
> 

So what's the plan then?

> >
> > Thanks
> >
> > >
> > > > And that the reason we don't
> > > > even need to hold RTNL here.
> > > >
> > > > Thanks
> > > >
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > @@ -3203,6 +3246,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> > > > > > > >       virtio_device_ready(vdev);
> > > > > > > >
> > > > > > > >       enable_delayed_refill(vi);
> > > > > > > > +     enable_rx_mode_work(vi);
> > > > > > > >
> > > > > > > >       if (netif_running(vi->dev)) {
> > > > > > > >               err = virtnet_open(vi->dev);
> > > > > > > > @@ -4002,6 +4046,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > > > >       vdev->priv = vi;
> > > > > > > >
> > > > > > > >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > > > > > > > +     INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
> > > > > > > >       spin_lock_init(&vi->refill_lock);
> > > > > > > >
> > > > > > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> > > > > > > > @@ -4110,6 +4155,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > > > >       if (vi->has_rss || vi->has_rss_hash_report)
> > > > > > > >               virtnet_init_default_rss(vi);
> > > > > > > >
> > > > > > > > +     enable_rx_mode_work(vi);
> > > > > > > > +
> > > > > > > >       /* serialize netdev register + virtio_device_ready() with ndo_open() */
> > > > > > > >       rtnl_lock();
> > > > > > > >
> > > > > > > > @@ -4207,6 +4254,8 @@ static void virtnet_remove(struct virtio_device *vdev)
> > > > > > > >
> > > > > > > >       /* Make sure no work handler is accessing the device. */
> > > > > > > >       flush_work(&vi->config_work);
> > > > > > > > +     disable_rx_mode_work(vi);
> > > > > > > > +     flush_work(&vi->rx_mode_work);
> > > > > > > >
> > > > > > > >       unregister_netdev(vi->dev);
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >

