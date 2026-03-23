Return-Path: <netdev+bounces-270579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HVgMLpbwWnbSQQAu9opvQ
	(envelope-from <netdev+bounces-270579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:26:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1967D2F64E5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2506733EFFF5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202B3B27F7;
	Mon, 23 Mar 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VUoXweeR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E162737E0
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278327; cv=none; b=mG9wuvloUZDdjwPVKrtwJN4Z6qKPDx6V6TrbAa5kMthJuZgPHNOHe1lu/Wtj5bY6WAyuWZHC0wunqHB0mknc5nWNACi5KrRk0UVFRsWUeeBOG6cRzA3ltwa9nyzJkvKE7eOasPneVsAV/7lkF+xze0Yy0e5DF906KqeyEYGW6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278327; c=relaxed/simple;
	bh=dO99bE1GtMKgGvF/kcWYp/iTc8mPmbeq7Vx07AuRUpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEI78xXF0guXWo23AaIxbnWChvRWoxgMmatYSbhk7k/GT03mcn7f4Y5D7Uj0XIxhcNOZRDrX7Od80tPc/UaKVX+ubeTjnbRi0vsiu1/CUyowm2vadABOUlaB9ZFHSapMZJ/YGhif5F1RQcf+gvQq4jEq/fGTzla4R3lf9oCePtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VUoXweeR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b2965d4bso2059719f8f.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774278322; x=1774883122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xK/cBXDbg1RfTlOTXfp0e8QtWHl2tXpDg/z3vWJ2eTw=;
        b=VUoXweeRJbD/ryEsQy+ZJYsJ6d/kwl3lElq6uRQyj41h7ShFdxTRnQYhQK/5gzRd8W
         ad/D/pTu6pD6B5H6rryQITo5e0Pq7Oh9zfhGfgMmf9Hc6TVOQAaQh8MHnQb+RXgDhhlY
         euHUnvfL9FX8nOudAwwNSHhIg6atckVWj+gihiqB/BSpetJgG9DFt/eeTQpio8a4EUMM
         Fx4dXc5BXCVPA5+GIpA9itJ/YyoswoxjMu404YHBu9DZN4dIsvu1srzGxNznbO7Zc4L1
         lmJlsGdc3BU6kUCpAsGrNypgmnv/Rer5t8djqYoP/FYm9jKvPX/Xd/kcxn4k8fhtrq3b
         w4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774278322; x=1774883122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK/cBXDbg1RfTlOTXfp0e8QtWHl2tXpDg/z3vWJ2eTw=;
        b=ES3Uz2LIRegXQPubuKgiqDKvpSLxlvxnFGXWK8V9gHQumnUt3bJgaD17DkZKMDjNOL
         aspYGxZtLu9Z79FlhQbEEJwfSrAI9CjngRoG1tQCKEVXXuAsBRXNw6Bko42mUEAR3S24
         /H2+qXEmNATH54Scoubbz+dKZoD8nIIJs/NilwgxRJ5UCwyr7Xfa35pFBBOnL0HuPPUH
         NAH5moK64+F/W+NledrvwziYHOjuNlRMiU49RGzfI9sFua2u55QtK9L18Wwr+8oKZNXc
         gbpoVN7eH6QBfjl+pQ4OOuzihsEb9jCaPLgEeBXObzUkpDRgduIrZjYS6sP2rQxzOPBM
         BMGA==
X-Gm-Message-State: AOJu0YxfhM+51D7FXsHXXLpPTQjUm2Zkq1o9nTDIZr4SOCPD5Jb9sxRQ
	7G7OKc8yJev6eulkAloAxUFb6o+J8E0G2QIxfc2VL/MC34cNb15/48Mb/QDpRHJtP48=
X-Gm-Gg: ATEYQzxoQKmnFqSKLB5hWbhzEz055jWWTFPvl41WV3ZpAywcM6rXTgzaA3XoH9LRqrV
	50yObUeOtkmesU8DkiNAr7R//zr6VHaEe0o9Jv0ZxVX6GOvji9uvh8TwkVsqu1x4r5B1Pl4hadZ
	DPbWmDimrGSgAlCam9v59Q5QRnEtxfR8iWlWwqDoTVGhQQnYxA4Jl+W43gPIN3NaGuEwxJGTow8
	Lm6Ppksr/A4INquBj6dfb5iw1yMwmMLqSbhMnpBxhXqwTfzaIDPASvXFGcXMzVGFA1iLA9x47tO
	/DpkzsXIlPoo8f1uPH2uNNDXMlQVMBZnHX55dbATdqGnvbQHRXKw6PUpexwyAjHaNL2eTSLOs2C
	+Lxexo7Nh70PxNvxpKdC+wchnjAAGJ7ngZpZlZ0t7HF4dV4rsPQIyYSBO70p1w+Dyg4GlzsnAPu
	phceP70igyMt1tcu5UEOUGvezTUnvS9Ro1TgE=
X-Received: by 2002:a05:6000:40c7:b0:43b:5097:6f60 with SMTP id ffacd0b85a97d-43b6427d243mr19058325f8f.32.1774278321804;
        Mon, 23 Mar 2026 08:05:21 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm32447345f8f.32.2026.03.23.08.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:05:21 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:05:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 13/13] net/mlx5: Add a shared devlink
 instance for PFs on same chip
Message-ID: <ib6r4armffxw3f56fxxor3bg4ejhnsfg5ddg4dncae5u6lonty@ds6bfkjoykbl>
References: <20260312100407.551173-1-jiri@resnulli.us>
 <20260312100407.551173-14-jiri@resnulli.us>
 <bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com>
 <c37ee2a7-8e19-4aaa-aaf3-4cd5a9c171d1@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c37ee2a7-8e19-4aaa-aaf3-4cd5a9c171d1@amperemail.onmicrosoft.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270579-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1967D2F64E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sat, Mar 21, 2026 at 12:37:06AM +0100, admiyo@amperemail.onmicrosoft.com wrote:
>
>
>0005:01:00.0 Ethernet controller: Mellanox Technologies MT27710 Family
>[ConnectX-4 Lx]

Cool. Will try to reproduce this locally. Thanks!




>0005:01:00.1 Ethernet controller: Mellanox Technologies MT27710 Family
>[ConnectX-4 Lx]
>
>On 3/20/26 19:16, Adam Young wrote:
>> This breaks on my system:
>> 
>> On 7.0.0 It boots fine.  With net-next/main currently at this commit
>> 
>> 
>> commit 8737d7194d6d5947c3d7d8813895b44a25b84477 (net-next/main,
>> net-next/HEAD)
>> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>> Date:   Fri Mar 13 17:28:36 2026 +0100
>> 
>> I get:
>> 
>> [   21.859081] mlx5_core 0005:01:00.0: probe_one:2017:(pid 10):
>> mlx5_shd_init failed with error code -2
>> [   21.863266] mlx5_core 0005:01:00.0: probe with driver mlx5_core failed
>> with error -2
>> [   21.866360] mlx5_core 0005:01:00.1: probe_one:2017:(pid 10):
>> mlx5_shd_init failed with error code -2
>> [   21.869937] mlx5_core 0005:01:00.1: probe with driver mlx5_core failed
>> with error -2
>> 
>> 
>> I am happy to help debug:   what do you need from me?
>> 
>> 
>> On 3/12/26 06:04, Jiri Pirko wrote:
>> > From: Jiri Pirko <jiri@nvidia.com>
>> > 
>> > Use the previously introduced shared devlink infrastructure to create
>> > a shared devlink instance for mlx5 PFs that reside on the same physical
>> > chip. The shared instance is identified by the chip's serial number
>> > extracted from PCI VPD (V3 keyword, with fallback to serial number
>> > for older devices).
>> > 
>> > Each PF that probes calls mlx5_shd_init() which extracts the chip serial
>> > number and uses devlink_shd_get() to get or create the shared instance.
>> > When a PF is removed, mlx5_shd_uninit() calls devlink_shd_put()
>> > to release the reference. The shared instance is automatically destroyed
>> > when the last PF is removed.
>> > 
>> > Make the PF devlink instances nested in this shared devlink instance,
>> > allowing userspace to identify which PFs belong to the same physical
>> > chip.
>> > 
>> > Example:
>> > 
>> > pci/0000:08:00.0: index 0
>> >    nested_devlink:
>> >      auxiliary/mlx5_core.eth.0
>> > devlink_index/1: index 1
>> >    nested_devlink:
>> >      pci/0000:08:00.0
>> >      pci/0000:08:00.1
>> > auxiliary/mlx5_core.eth.0: index 2
>> > pci/0000:08:00.1: index 3
>> >    nested_devlink:
>> >      auxiliary/mlx5_core.eth.1
>> > auxiliary/mlx5_core.eth.1: index 4
>> > 
>> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> > ---
>> > v2->v3:
>> > - removed "const" from "sn"
>> > - passing driver pointer to devlink_shd_get()
>> > ---
>> >   .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
>> >   .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++++++
>> >   .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 61 +++++++++++++++++++
>> >   .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
>> >   include/linux/mlx5/driver.h                   |  1 +
>> >   5 files changed, 94 insertions(+), 2 deletions(-)
>> >   create mode 100644
>> > drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> >   create mode 100644
>> > drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> > 
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> > b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> > index 8ffa286a18f5..d39fe9c4a87c 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> > @@ -16,8 +16,9 @@ mlx5_core-y :=    main.o cmd.o debugfs.o fw.o eq.o
>> > uar.o pagealloc.o \
>> >           transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
>> >           fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o
>> > dev.o events.o wq.o lib/gid.o \
>> >           lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o
>> > diag/fs_tracepoint.o \
>> > -        diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o
>> > diag/reporter_vnic.o \
>> > -        fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
>> > lib/nv_param.o
>> > +        diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o
>> > diag/rsc_dump.o \
>> > +        diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o
>> > wc.o fs_pool.o \
>> > +        lib/nv_param.o
>> >     #
>> >   # Netdev basic
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > index fdc3ba20912e..1c35c3fc3bb3 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> > @@ -74,6 +74,7 @@
>> >   #include "mlx5_irq.h"
>> >   #include "hwmon.h"
>> >   #include "lag/lag.h"
>> > +#include "sh_devlink.h"
>> >     MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>> >   MODULE_DESCRIPTION("Mellanox 5th generation network adapters
>> > (ConnectX series) core driver");
>> > @@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>> >       int err;
>> >         devl_lock(devlink);
>> > +    if (dev->shd) {
>> > +        err = devl_nested_devlink_set(dev->shd, devlink);
>> > +        if (err)
>> > +            goto unlock;
>> > +    }
>> >       devl_register(devlink);
>> >       err = mlx5_init_one_devl_locked(dev);
>> >       if (err)
>> >           devl_unregister(devlink);
>> > +unlock:
>> >       devl_unlock(devlink);
>> >       return err;
>> >   }
>> > @@ -2005,6 +2012,13 @@ static int probe_one(struct pci_dev *pdev,
>> > const struct pci_device_id *id)
>> >           goto pci_init_err;
>> >       }
>> >   +    err = mlx5_shd_init(dev);
>> > +    if (err) {
>> > +        mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
>> > +                  err);
>> > +        goto shd_init_err;
>> > +    }
>> > +
>> >       err = mlx5_init_one(dev);
>> >       if (err) {
>> >           mlx5_core_err(dev, "mlx5_init_one failed with error code
>> > %d\n",
>> > @@ -2018,6 +2032,8 @@ static int probe_one(struct pci_dev *pdev,
>> > const struct pci_device_id *id)
>> >       return 0;
>> >     err_init_one:
>> > +    mlx5_shd_uninit(dev);
>> > +shd_init_err:
>> >       mlx5_pci_close(dev);
>> >   pci_init_err:
>> >       mlx5_mdev_uninit(dev);
>> > @@ -2039,6 +2055,7 @@ static void remove_one(struct pci_dev *pdev)
>> >       mlx5_drain_health_wq(dev);
>> >       mlx5_sriov_disable(pdev, false);
>> >       mlx5_uninit_one(dev);
>> > +    mlx5_shd_uninit(dev);
>> >       mlx5_pci_close(dev);
>> >       mlx5_mdev_uninit(dev);
>> >       mlx5_adev_idx_free(dev->priv.adev_idx);
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> > b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> > new file mode 100644
>> > index 000000000000..bc33f95302df
>> > --- /dev/null
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> > @@ -0,0 +1,61 @@
>> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> > +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
>> > reserved. */
>> > +
>> > +#include <linux/mlx5/driver.h>
>> > +#include <net/devlink.h>
>> > +
>> > +#include "sh_devlink.h"
>> > +
>> > +static const struct devlink_ops mlx5_shd_ops = {
>> > +};
>> > +
>> > +int mlx5_shd_init(struct mlx5_core_dev *dev)
>> > +{
>> > +    u8 *vpd_data __free(kfree) = NULL;
>> > +    struct pci_dev *pdev = dev->pdev;
>> > +    unsigned int vpd_size, kw_len;
>> > +    struct devlink *devlink;
>> > +    char *sn, *end;
>> > +    int start;
>> > +    int err;
>> > +
>> > +    if (!mlx5_core_is_pf(dev))
>> > +        return 0;
>> > +
>> > +    vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>> > +    if (IS_ERR(vpd_data)) {
>> > +        err = PTR_ERR(vpd_data);
>> > +        return err == -ENODEV ? 0 : err;
>> > +    }
>> > +    start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
>> > &kw_len);
>> > +    if (start < 0) {
>> > +        /* Fall-back to SN for older devices. */
>> > +        start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>> > +                             PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>> > +        if (start < 0)
>> > +            return -ENOENT;
>> > +    }
>> > +    sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> > +    if (!sn)
>> > +        return -ENOMEM;
>> > +    /* Firmware may return spaces at the end of the string, strip
>> > it. */
>> > +    end = strchrnul(sn, ' ');
>> > +    *end = '\0';
>> > +
>> > +    /* Get or create shared devlink instance */
>> > +    devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
>> > +    kfree(sn);
>> > +    if (!devlink)
>> > +        return -ENOMEM;
>> > +
>> > +    dev->shd = devlink;
>> > +    return 0;
>> > +}
>> > +
>> > +void mlx5_shd_uninit(struct mlx5_core_dev *dev)
>> > +{
>> > +    if (!dev->shd)
>> > +        return;
>> > +
>> > +    devlink_shd_put(dev->shd);
>> > +}
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> > b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> > new file mode 100644
>> > index 000000000000..8ab8d6940227
>> > --- /dev/null
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> > @@ -0,0 +1,12 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>> > +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
>> > reserved. */
>> > +
>> > +#ifndef __MLX5_SH_DEVLINK_H__
>> > +#define __MLX5_SH_DEVLINK_H__
>> > +
>> > +#include <linux/mlx5/driver.h>
>> > +
>> > +int mlx5_shd_init(struct mlx5_core_dev *dev);
>> > +void mlx5_shd_uninit(struct mlx5_core_dev *dev);
>> > +
>> > +#endif /* __MLX5_SH_DEVLINK_H__ */
>> > diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
>> > index 04dcd09f7517..1268fcf35ec7 100644
>> > --- a/include/linux/mlx5/driver.h
>> > +++ b/include/linux/mlx5/driver.h
>> > @@ -798,6 +798,7 @@ struct mlx5_core_dev {
>> >       enum mlx5_wc_state wc_state;
>> >       /* sync write combining state */
>> >       struct mutex wc_state_lock;
>> > +    struct devlink *shd;
>> >   };
>> >     struct mlx5_db {
>> 

