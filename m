Return-Path: <netdev+bounces-110149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7F92B1E4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DFF1F220E0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B41514F8;
	Tue,  9 Jul 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FnlgmJId"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCC15250A;
	Tue,  9 Jul 2024 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512863; cv=none; b=JN0zafXjMSi8n/gcGpnighoEgX20IlozxSf8b43Bu4B2/iUr/NhjkgvFPfma0myEjMX+wiuib1JaExJkO2OSQqAiZVVlfFxpU4mKSpp7uaWXI4U3ds6qtHGEf5THYIFDnXZJ6QL2lQhoBNccwaBAQ4tqnmWZmhdfrkhV18lbo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512863; c=relaxed/simple;
	bh=RVtax/cydPCAPKnVI29kmRdNNf9y+jOhNkNxY9oFnzw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jmPOOfiUfTF9uBnKKWClE5XhugNHiQ4OArDOvTN+syBbXaYtOO2HRwF6Iqv8tw53dDTi9UBEB/FlNVyG5dHsuHjlw+/lgltC8SycXx2K7kPkSkeVdquZcpuui8g+ko1G7Pvn/jM1wPVhJGDVdasAgkRK0COzUHX/SPBgq31UfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FnlgmJId; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720512854; h=Message-ID:Subject:Date:From:To;
	bh=k4jnaRkPam0+HSWdw9HZ3KM1KrQVxWzXC5dPh+aQ7+A=;
	b=FnlgmJIdzxiuWPLuVyV2GnfZHCyi4KguqSta7qaQrxHE2/RxCca0/ur/D0p1LQnv4MHqBXLrgnxbLG45X9jLs2HJh302gJK0RAaaoiBrqi5SjHSjNcA6aaCaUbRiOZFeyY4JG9q2rfhqHENwMk5dOGLJPbdZ4bmEKmNXiM8bH8c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WAB1v0T_1720512853;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WAB1v0T_1720512853)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 16:14:13 +0800
Message-ID: <1720512843.116356-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 2/3] virtio: allow driver to disable the configure change notification
Date: Tue, 9 Jul 2024 16:14:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
 "Gia-Khanh Nguyen" <gia-khanh.nguyen@oracle.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20240709080214.9790-1-jasowang@redhat.com>
 <20240709080214.9790-3-jasowang@redhat.com>
In-Reply-To: <20240709080214.9790-3-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue,  9 Jul 2024 16:02:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
> Sometime, it would be useful to disable the configure change
> notification from the driver. So this patch allows this by introducing
> a variable config_change_driver_disabled and only allow the configure
> change notification callback to be triggered when it is allowed by
> both the virtio core and the driver. It is set to false by default to
> hold the current semantic so we don't need to change any drivers.
>
> The first user for this would be virtio-net.
>
> Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  drivers/virtio/virtio.c | 39 ++++++++++++++++++++++++++++++++++++---
>  include/linux/virtio.h  |  7 +++++++
>  2 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 73bab89b5326..23a96fbc2810 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -127,10 +127,12 @@ static void __virtio_config_changed(struct virtio_device *dev)
>  {
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>
> -	if (!dev->config_core_enabled)
> +	if (!dev->config_core_enabled || dev->config_driver_disabled)
>  		dev->config_change_pending = true;
> -	else if (drv && drv->config_changed)
> +	else if (drv && drv->config_changed) {
>  		drv->config_changed(dev);
> +		dev->config_change_pending = false;
> +	}
>  }
>
>  void virtio_config_changed(struct virtio_device *dev)
> @@ -143,6 +145,38 @@ void virtio_config_changed(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(virtio_config_changed);
>
> +/**
> + * virtio_config_driver_disable - disable config change reporting by drivers
> + * @dev: the device to reset
> + *
> + * This is only allowed to be called by a driver and disalbing can't
> + * be nested.
> + */
> +void virtio_config_driver_disable(struct virtio_device *dev)
> +{
> +	spin_lock_irq(&dev->config_lock);
> +	dev->config_driver_disabled = true;
> +	spin_unlock_irq(&dev->config_lock);
> +}
> +EXPORT_SYMBOL_GPL(virtio_config_driver_disable);
> +
> +/**
> + * virtio_config_driver_enable - enable config change reporting by drivers
> + * @dev: the device to reset
> + *
> + * This is only allowed to be called by a driver and enabling can't
> + * be nested.
> + */
> +void virtio_config_driver_enable(struct virtio_device *dev)
> +{
> +	spin_lock_irq(&dev->config_lock);
> +	dev->config_driver_disabled = false;
> +	if (dev->config_change_pending)
> +		__virtio_config_changed(dev);
> +	spin_unlock_irq(&dev->config_lock);
> +}
> +EXPORT_SYMBOL_GPL(virtio_config_driver_enable);
> +
>  static void virtio_config_core_disable(struct virtio_device *dev)
>  {
>  	spin_lock_irq(&dev->config_lock);
> @@ -156,7 +190,6 @@ static void virtio_config_core_enable(struct virtio_device *dev)
>  	dev->config_core_enabled = true;
>  	if (dev->config_change_pending)
>  		__virtio_config_changed(dev);
> -	dev->config_change_pending = false;
>  	spin_unlock_irq(&dev->config_lock);
>  }
>
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index a6f6df72f01a..2be73de6f1f3 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -116,6 +116,8 @@ struct virtio_admin_cmd {
>   * @index: unique position on the virtio bus
>   * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>   * @config_core_enabled: configuration change reporting enabled by core
> + * @config_driver_disabled: configuration change reporting disabled by
> + *                          a driver
>   * @config_change_pending: configuration change reported while disabled
>   * @config_lock: protects configuration change reporting
>   * @vqs_list_lock: protects @vqs.
> @@ -133,6 +135,7 @@ struct virtio_device {
>  	int index;
>  	bool failed;
>  	bool config_core_enabled;
> +	bool config_driver_disabled;
>  	bool config_change_pending;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock;
> @@ -163,6 +166,10 @@ void __virtqueue_break(struct virtqueue *_vq);
>  void __virtqueue_unbreak(struct virtqueue *_vq);
>
>  void virtio_config_changed(struct virtio_device *dev);
> +
> +void virtio_config_driver_disable(struct virtio_device *dev);
> +void virtio_config_driver_enable(struct virtio_device *dev);
> +
>  #ifdef CONFIG_PM_SLEEP
>  int virtio_device_freeze(struct virtio_device *dev);
>  int virtio_device_restore(struct virtio_device *dev);
> --
> 2.31.1
>

