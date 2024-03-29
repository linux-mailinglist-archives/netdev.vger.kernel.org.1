Return-Path: <netdev+bounces-83268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A960A8917F8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2060C1F22D73
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480F6A8D8;
	Fri, 29 Mar 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbfF9mx3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103606A34B
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712541; cv=none; b=h843Gl2gE4r8CYKEZR+7jJ/ms/zrToS7pKV6mLk1klnXnCq/Tl1qt3JpHmMrMEAODAdLaMiFTKEcpppMeXBfUup5QGdokBAgYENsBRfqhlKzQLnAJUHhx2U7DJXJT9lrnrFbLDTJ6YcOuKDDbKHEFJSGQvfN8Ph75H2IotCGv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712541; c=relaxed/simple;
	bh=CnPyW/y5UQrILS7vE5ScOzPk56jpnW7Bki+iQBNgkGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChwhytNv+h3TqwwZCyApaa4pH+UpcVHHh+XnQF0PV77QOkadIgfSFB6hKWhQVDVG0EHz02IKwY9RIgHRRMeA2JWRsUuZPw1H14p0MpEZlnfC4SSD/qi619Mz2a11r4q/qsCukn0TlBsy49bOf7e1efPwzC5UZ8aOVM2jsIe/Ku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbfF9mx3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711712537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BsDTTyNU5pgUTxWeniUBybyV1pHa+zj3gLQFOaKcJw=;
	b=MbfF9mx3nMXRUAWUk9UHZVuJmnuw7d+qVPMgVbohXLClfVfNMoJxDTY0dRYjf+3WWn0YM6
	pizkDJNu8+1N0A6Lpov4nMsHJWosTP06kpph4by4+quM6tk6xAbXFlqEAipNVVCHg5p9Z0
	SbLhGz/QBVG8WKWE0TcDhgvaJCuLRQY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-XkTHTwJtPYiwr8i3BkwWpQ-1; Fri, 29 Mar 2024 07:42:16 -0400
X-MC-Unique: XkTHTwJtPYiwr8i3BkwWpQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d6d3815f9bso18645931fa.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 04:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711712535; x=1712317335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BsDTTyNU5pgUTxWeniUBybyV1pHa+zj3gLQFOaKcJw=;
        b=mOnNuUxyQ5NsJU/onDxZ0nLI3YG9aWLNwkZbcPXTeanjH3YU7RR7e398UpYnP+AqER
         kKsKbZm2P1Bd7AVQwn8n0SucsEL9ShnbOb2CRNz3M3MT0asM8nFamQu3W8Ttq9gKgQV+
         iF3hu7GJHlAPr+wiBeRjHTtD65GAJAXx4CpzaC7wJ739JyCTcIPQDq7xvVK1OfhG6mIu
         JP1VLbHsuLBNBC6nyBmNaEoGT9X/Q0/CosdVGsrkmOZRTWf0ezYu7NSdd/k2C8CHWGtI
         mKwokf+XkCqtEH/u3lt0iByqmZVHy2ZLxeEFu5fXrP3Mn+KJFJFeQWxG2+3L6f7QQn0h
         /66g==
X-Forwarded-Encrypted: i=1; AJvYcCWaVNhhppTAmTmpSkdW5A4K9jZcCep+ho9+WxDB5+Sohg9eYjq7tGeBtCCwsg9Cm6RQJn4mufmC/XQYTwGvuXuYOUkBP3Dm
X-Gm-Message-State: AOJu0YyI3HkFwMcNzFVEUB0JU4ulAp37/SHALexncn5dtany0Mx+SEIA
	dZMfXHhSWk24TV7T7TRWHKJBTuLagpoYuRjPCL/JIpVgLYfdrNmY6vsZizkhRqpXDMGMkC6Y/NP
	U8AfthJYBHKFRBMDOPEsDRZavEaxo/OdbAXt79NvajG2+npd98SI9fA==
X-Received: by 2002:a2e:9659:0:b0:2d6:e148:2463 with SMTP id z25-20020a2e9659000000b002d6e1482463mr1428746ljh.24.1711712535145;
        Fri, 29 Mar 2024 04:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEACBjwkvqDUtHOsu+pH/smraarLJWyQq+BtaLZf+sEYEs2CGiOj/cy+sTyYbp3cXHSv/vHng==
X-Received: by 2002:a2e:9659:0:b0:2d6:e148:2463 with SMTP id z25-20020a2e9659000000b002d6e1482463mr1428676ljh.24.1711712534737;
        Fri, 29 Mar 2024 04:42:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709062ec700b00a46abaeeb1csm1837128eji.104.2024.03.29.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:42:14 -0700 (PDT)
Date: Fri, 29 Mar 2024 12:42:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	v9fs@lists.linux.dev, kvm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/22] virtio: store owner from modules with
 register_virtio_driver()
Message-ID: <oaoiehcpkjs3wrhc22pwx676pompxml2z5dcq32a6fvsyntonw@hnohrbbp6wpm>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>

On Wed, Mar 27, 2024 at 01:40:54PM +0100, Krzysztof Kozlowski wrote:
>Modules registering driver with register_virtio_driver() might forget to
>set .owner field.  i2c-virtio.c for example has it missing.  The field
>is used by some of other kernel parts for reference counting
>(try_module_get()), so it is expected that drivers will set it.
>
>Solve the problem by moving this task away from the drivers to the core
>amba bus code, just like we did for platform_driver in
>commit 9447057eaff8 ("platform_device: use a macro instead of
>platform_driver_register").
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---
> Documentation/driver-api/virtio/writing_virtio_drivers.rst | 1 -
> drivers/virtio/virtio.c                                    | 6 ++++--
> include/linux/virtio.h                                     | 7 +++++--
> 3 files changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/driver-api/virtio/writing_virtio_drivers.rst b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
>index e14c58796d25..e5de6f5d061a 100644
>--- a/Documentation/driver-api/virtio/writing_virtio_drivers.rst
>+++ b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
>@@ -97,7 +97,6 @@ like this::
>
> 	static struct virtio_driver virtio_dummy_driver = {
> 		.driver.name =  KBUILD_MODNAME,
>-		.driver.owner = THIS_MODULE,
> 		.id_table =     id_table,
> 		.probe =        virtio_dummy_probe,
> 		.remove =       virtio_dummy_remove,
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index f173587893cb..9510c551dce8 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -362,14 +362,16 @@ static const struct bus_type virtio_bus = {
> 	.remove = virtio_dev_remove,
> };
>
>-int register_virtio_driver(struct virtio_driver *driver)
>+int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
> {
> 	/* Catch this early. */
> 	BUG_ON(driver->feature_table_size && !driver->feature_table);
> 	driver->driver.bus = &virtio_bus;
>+	driver->driver.owner = owner;
>+

`.driver.name =  KBUILD_MODNAME` also seems very common, should we put
that in the macro as well?

> 	return driver_register(&driver->driver);
> }
>-EXPORT_SYMBOL_GPL(register_virtio_driver);
>+EXPORT_SYMBOL_GPL(__register_virtio_driver);
>
> void unregister_virtio_driver(struct virtio_driver *driver)
> {
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index b0201747a263..26c4325aa373 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -170,7 +170,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
>
> /**
>  * struct virtio_driver - operations for a virtio I/O driver
>- * @driver: underlying device driver (populate name and owner).
>+ * @driver: underlying device driver (populate name).
>  * @id_table: the ids serviced by this driver.
>  * @feature_table: an array of feature numbers supported by this driver.
>  * @feature_table_size: number of entries in the feature table array.
>@@ -208,7 +208,10 @@ static inline struct virtio_driver *drv_to_virtio(struct device_driver *drv)
> 	return container_of(drv, struct virtio_driver, driver);
> }
>
>-int register_virtio_driver(struct virtio_driver *drv);
>+/* use a macro to avoid include chaining to get THIS_MODULE */
>+#define register_virtio_driver(drv) \
>+	__register_virtio_driver(drv, THIS_MODULE)
>+int __register_virtio_driver(struct virtio_driver *drv, struct module *owner);
> void unregister_virtio_driver(struct virtio_driver *drv);
>
> /* module_virtio_driver() - Helper macro for drivers that don't do
>
>-- 
>2.34.1
>


