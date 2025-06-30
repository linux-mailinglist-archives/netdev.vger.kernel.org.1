Return-Path: <netdev+bounces-202500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDEDAEE189
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C133B46C3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74828C013;
	Mon, 30 Jun 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pkru7PAe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76028B50A
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295287; cv=none; b=rFUArTk0AvIuYw1wCCF0n8IDdRhZGX4XbrwDQiWzGL/VE70vDLxRGFuglWDok++kRYUIXVUwn8Iqbw00kcDQv2IOi0jkOfH+7RsTxV46UKj2rO/m0E3Zkb858Q04K+tzsiohivOuFaKtJntyu2uTffiT7md/hQx0Y9cL2btv/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295287; c=relaxed/simple;
	bh=aLt1ZrspkXVq+7ZfamJt97k2eAHB68alTdtmafLRht0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edIebmnNFLT9PZNQ5jFx7NZLyrDMUE124QaErU+/5jXYYcdNY0sMKFm9E7v/atCiEKRik9yE3wvbyJx8t3CN8/T/ywaDCmqk3LEedmKhbLNQtZR+x5wU8bqVGTxCe3JPbvFx0Ha8dquxRpH7WbGC/MQhP0zgNv+OsRgSKVuoq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pkru7PAe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751295284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDq2W9BFH4O+4v2QDHUZ/OXiJmC+AYZucENKup8acvQ=;
	b=Pkru7PAezTy5zufVpIbGa1IxYWo1GaEIHRtEtVZ+rvMmy6Ow6rW9pVSQSLZXjgsPzr/fh5
	tjGZNgfhuTRRv6u7iqWKl1FKcNgXHYuThCCZ5MDXLH01nv8cHVQN4ALKgCSgr067mUwoXB
	AqZmJ+zwuZBg374j9ouDxkrB4qh5zjY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-VcDM1RG5NN2uOkdkHJVJew-1; Mon, 30 Jun 2025 10:54:42 -0400
X-MC-Unique: VcDM1RG5NN2uOkdkHJVJew-1
X-Mimecast-MFC-AGG-ID: VcDM1RG5NN2uOkdkHJVJew_1751295282
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae0de1a6a80so178339066b.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295282; x=1751900082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDq2W9BFH4O+4v2QDHUZ/OXiJmC+AYZucENKup8acvQ=;
        b=MZEMmCRhoyVMFw/dBq7/Wa2DTCg96ztbJWIMWSxvaHlS0kexxKnnF5u6ahtOunKrJg
         RR1HLPRxp7wc/OzwslvaqAeqF9vEVxvOIMHHjUOISdEvDGLmlzna7tsuac8KVaoKoT3k
         /7tvGqJx49uNgofVcCNWOFpeQG41BHv4Jm7+qdcyjf+tRxLRK9UzZB1Ykjh4pjEOM+NP
         flwqBXELULASaPzA9+x8tj211Rs5LOCIcfR3Gr2dZJbu/o8VGHSg+ping0BTqJyO3Jtu
         l6bpA7OPBKIEMf5NRHB8sWC+BPH47umEIC5/VbGZ5n5ciVvJ9nOnB7Wdm+kderBzbiCu
         +JeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUur4OIMqFiMe1/lxynIG9n7XolvHthVkpjyL6uAusdgQZryx4iNjYsJVR4uKkFCSidVEWNTM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/yim2+5aq1B/wS+fJgjn/Z/Es0BHlKjmA6UQhjOMOVGObqZ6
	Np3WxlXZWy9gefEAawsGJVF2cZhGZJxohOYU4CRqUl/jxG1iZZ9Ck59L0gFNwPufsdqL8j3EN5F
	ghwU+uNACt9zcBUXuvlr5GN3DLObT0x6mUSsAyLYXI6d3Xfgn6gzkApW4uA==
X-Gm-Gg: ASbGncvoYYqAzWLl6j69DHeXGytSbuxwI8pGwoqAOHkfHd8QnKpYTYZrUPGDgWJyg9L
	4vm4whP5vyhMNXnMkpLnHUoggjR/t+wJU+qYnc4zI1raaD45vYDQGOlKRL5cQQtQ70LWx7P2GQ3
	yXzqBhJve3dkUX/glNjlo1mFNsPkAxqdZHGt3139ch8DZVX2X7wsIl722DBHQ1TCtf9TPiy5bql
	tY0P9lngbGwgufBG5D8nlMR80kWdZ9D5t58p64OObn1IYo166/EDMSQxZ3wqH02aU0EJzbihd8L
	X6DIXSnSZus=
X-Received: by 2002:a17:907:3c83:b0:ad8:e477:970c with SMTP id a640c23a62f3a-ae34fdc67demr1187814566b.23.1751295281519;
        Mon, 30 Jun 2025 07:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiDVHztt+YTUkaG1BJuQ7w5s/kr8yY1OSJDtV0Axqaw2I4tijYVvqW2nsMVoPwIigNr7w4kQ==
X-Received: by 2002:a17:907:3c83:b0:ad8:e477:970c with SMTP id a640c23a62f3a-ae34fdc67demr1187812466b.23.1751295280964;
        Mon, 30 Jun 2025 07:54:40 -0700 (PDT)
Received: from redhat.com ([31.187.78.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bbfdsm688648166b.115.2025.06.30.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:54:40 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:54:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: fix a rtnl_lock() deadlock during probing
Message-ID: <20250630105328-mutt-send-email-mst@kernel.org>
References: <20250630095109.214013-1-zuozhijie@bytedance.com>
 <20250630103240-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630103240-mutt-send-email-mst@kernel.org>

On Mon, Jun 30, 2025 at 10:50:55AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 30, 2025 at 05:51:09PM +0800, Zigit Zo wrote:
> > This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
> > the virtio-net driver is still probing with rtnl_lock() hold, this will
> > cause a recursive mutex in netdev_notify_peers().
> > 
> > Fix it by skip acking the annouce in virtnet_config_changed_work() when
> > probing. The annouce will still get done when ndo_open() enables the
> > virtio_config_driver_enable().
> 
> I am not so sure it will be - while driver is not loaded, device does
> not have to send interrupts, and there's no rule I'm aware of that says
> we'll get one after DRIVER_OK.
> 
> How about, we instead just schedule the work to do it later?
> 
> 
> Also, there is another bug here.
> If ndo_open did not run, we actually should not send any announcements.
> 
> Do we care if carrier on is set on probe or on open?
> If not, let's just defer this to ndo_open?

Hmm yes I think we do, device is visible to userspace is it not?

Hmm.  We can keep the announce bit set in vi->status and on open, check
it and then schedule a work to do the announcement.


> 
> > We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
> > QEMU sending the announce_self rapidly while booting.
> > 
> > [  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
> > [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
> > [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
> > [  494.168260] Call Trace:
> > [  494.168329]  <TASK>
> > [  494.168389]  __schedule+0x27c/0x6b0
> > [  494.168495]  schedule+0x33/0x110
> > [  494.168585]  schedule_preempt_disabled+0x15/0x30
> > [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
> > [  494.168835]  __mutex_lock_slowpath+0x13/0x20
> > [  494.168949]  mutex_lock+0x3c/0x50
> > [  494.169039]  rtnl_lock+0x15/0x20
> > [  494.169128]  netdev_notify_peers+0x12/0x30
> > [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
> > [  494.169377]  virtnet_probe+0xa48/0xe00
> > [  494.169484]  ? vp_get+0x4d/0x100
> > [  494.169574]  virtio_dev_probe+0x1e9/0x310
> > [  494.169682]  really_probe+0x1c7/0x410
> > [  494.169783]  __driver_probe_device+0x8c/0x180
> > [  494.169901]  driver_probe_device+0x24/0xd0
> > [  494.170011]  __driver_attach+0x10b/0x210
> > [  494.170117]  ? __pfx___driver_attach+0x10/0x10
> > [  494.170237]  bus_for_each_dev+0x8d/0xf0
> > [  494.170341]  driver_attach+0x1e/0x30
> > [  494.170440]  bus_add_driver+0x14e/0x290
> > [  494.170548]  driver_register+0x5e/0x130
> > [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
> > [  494.170788]  register_virtio_driver+0x20/0x40
> > [  494.170905]  virtio_net_driver_init+0x97/0xb0
> > [  494.171022]  do_one_initcall+0x5e/0x340
> > [  494.171128]  do_initcalls+0x107/0x230
> > [  494.171228]  ? __pfx_kernel_init+0x10/0x10
> > [  494.171340]  kernel_init_freeable+0x134/0x210
> > [  494.171462]  kernel_init+0x1b/0x200
> > [  494.171560]  ret_from_fork+0x47/0x70
> > [  494.171659]  ? __pfx_kernel_init+0x10/0x10
> > [  494.171769]  ret_from_fork_asm+0x1b/0x30
> > [  494.171875]  </TASK>
> > 
> > Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
> > Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> > ---
> >  drivers/net/virtio_net.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e53ba600605a..0290d289ebee 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6211,7 +6211,8 @@ static const struct net_device_ops virtnet_netdev = {
> >  	.ndo_tx_timeout		= virtnet_tx_timeout,
> >  };
> >  
> > -static void virtnet_config_changed_work(struct work_struct *work)
> > +static void __virtnet_config_changed_work(struct work_struct *work,
> > +					  bool check_announce)
> >  {
> >  	struct virtnet_info *vi =
> >  		container_of(work, struct virtnet_info, config_work);
> 
> So this will be schedule_announce instead of check_announce?
> 
> 
> 
> 
> > @@ -6221,7 +6222,7 @@ static void virtnet_config_changed_work(struct work_struct *work)
> >  				 struct virtio_net_config, status, &v) < 0)
> >  		return;
> >  
> > -	if (v & VIRTIO_NET_S_ANNOUNCE) {
> > +	if (check_announce && (v & VIRTIO_NET_S_ANNOUNCE)) {
> >  		netdev_notify_peers(vi->dev);
> >  		virtnet_ack_link_announce(vi);
> >  	}
> > @@ -6244,6 +6245,11 @@ static void virtnet_config_changed_work(struct work_struct *work)
> >  	}
> >  }
> >  
> > +static void virtnet_config_changed_work(struct work_struct *work)
> > +{
> > +	__virtnet_config_changed_work(work, true);
> > +}
> > +
> >  static void virtnet_config_changed(struct virtio_device *vdev)
> >  {
> >  	struct virtnet_info *vi = vdev->priv;
> > @@ -7030,7 +7036,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  	   otherwise get link status from config. */
> >  	netif_carrier_off(dev);
> >  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > -		virtnet_config_changed_work(&vi->config_work);
> > +		/* The check_annouce work will get scheduled when ndo_open()
> > +		 * doing the virtio_config_driver_enable().
> > +		 */
> > +		__virtnet_config_changed_work(&vi->config_work, false);
> >  	} else {
> >  		vi->status = VIRTIO_NET_S_LINK_UP;
> >  		virtnet_update_settings(vi);
> > 
> > base-commit: 2def09ead4ad5907988b655d1e1454003aaf8297
> > -- 
> > 2.49.0


