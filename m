Return-Path: <netdev+bounces-271063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHyMGHKOwmneewQAu9opvQ
	(envelope-from <netdev+bounces-271063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:15:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0CE309216
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0BF30A164F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD7345CD0;
	Tue, 24 Mar 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ReflY+QB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C43CC9F4
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357335; cv=none; b=XGIF0HYVaBXDNSIRoC0ond6K/65Jcdnqyo155b4u+HwTmo/uTYeiFxMAMum2kM6qc7wSJ87E2zFwBjeDzVq5qXjGFW2KILTpNDTndJRnVgoEWmeW8MXK/iNbXqsf/GYMMgk9+pq8JluavsGb5HS1XCW6eSh99KpmpMzlwzdP4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357335; c=relaxed/simple;
	bh=iH+8nMJ+Gx2BUOZ05IBDCgtLVuNf2PciAGOreblsBTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiHSlq4jyWjbaIAqOsGoZTgu8gJ0HdCXUeDcKtG8HT9XERW0I96Ii0nO9x8cLXCeUM1NciAw6Y+jVoPO4yTcLMFkXmAM5fSGLJWFSopGL7VVj0pGVQRWKhUjdcufCnpdA90q5z1AfCnRBqCN9Vkq2SIT7nm3g1z1TwyYhcx8kbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ReflY+QB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so8810765e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774357332; x=1774962132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2+t2Qf3QvHovGsqJwobXChl1JyVBxvgvfqIjcVOT4is=;
        b=ReflY+QBTBeYq/Lr7PPkhIyNWZ4+e6j6fr1Pi5yNN9bqF7uY0lbWi2Ob0xNdZg9Iup
         th8wX9NaiMmMoV6qAtKBH3rRMFZjjELsI5XAkPvgwNta1dtnKOXWPk0cyIa5f1PfPvWM
         t8LWvdIBFnCroSWzJNtLUhOT48DuGSvWGDA7Kmmz1KbezOU3ZoO8l3HkZAaOViAuTZr7
         wKpTkudHlwdVIbEa6mP3hC+ZM4piVP3nmOeQU24SO5mDHt4O2HhNpM7DGyhVVNivW+I1
         8+ANpAfhn8/1A/OBbwp+Zh2q8ORkyNnT20moQ9StTYY8min+rBTIfnxn04CvnYrLVb0U
         QX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774357332; x=1774962132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+t2Qf3QvHovGsqJwobXChl1JyVBxvgvfqIjcVOT4is=;
        b=LkwYulPrQZ+0ZcIDrYsWLk9reyXigZe5Si3WtWRUJRdqee8zBPdhg4NTN8yHoNBVwi
         dHRhs86fJltbrYnxGRkFqvh9uePbqfWxqSv4KxyFKMMcgZK7ZM9iCgA/KhHp7xnK5ozJ
         78BRZsoeG+SGbcKcx5TuTLVSX3HAQbrljwzGBzPk9EESnsrK2MoQ68omCXxgihus5ogV
         1VhEqg5PXT1J4QrwNPzBLIksHdk6VXfvco9TecdF29C+rb4fIxK8qFR3TQVaGluwePWe
         eCzmSo/wu9gMbkvwV64RGu9Gy679+Cn2htjFUV2Ksqd9yLCgLYavtNP+1t2rTnYEJBk2
         mLTA==
X-Gm-Message-State: AOJu0YxE7v1e19/YsQoTemaC1TZMHR+HKU00HVb2zh9/1c7UrQWn3psb
	Fp72wys+ib9NOd+cPDJgtCH4tz76uJtWrVPnrvVw6cEg6HZliXxcpGcD4Hzqr/FPTDU=
X-Gm-Gg: ATEYQzy3x7V3mZPUZBWgfgWzlJavIaWFQJg1TJCuc19li1RQQbu1fu+Am5yT7v9FVjJ
	kb23j+XYq0dMQAIdBS6JPYU+M8WRK62Tup6+8VsHlpp6GKEUvB4Rce4yEU6YcsW87R8BQEACpVO
	N8WQQOHpsga8cNU8J7RCshzgaNr+8dp2kjdbNsQY5985CAsEAUhM2NhfExmYWfd/FoIkkvMJBaC
	TLizLEYDwhH3T5rt7TFXJ4u59GImjX6nZTH/xsjMXfSItaQXbpGuoFmW9NRrWCLCq1+NpAJ3MXJ
	LsfkCWQP7Y/3LRZbjXgT/VeZ/y5yKcgjtZ29XxLxLNLha17nqcB6ET5ImeBdqaa5M7AvkU0VpmD
	2NX3XpZtS7CMdCiyvDUeQeoaTHRJ8c1PcpEX5gGzsBPx6JpWbVLzj+UgtYYY5K/r4QBdgrbqunK
	jPUP+Itut1k6Vi4djMAn2uEJ0AyIjR3tTt0dc=
X-Received: by 2002:a05:600c:47ca:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-4870169a1eemr122188205e9.12.1774357327203;
        Tue, 24 Mar 2026 06:02:07 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871169384dsm54132135e9.1.2026.03.24.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:02:06 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:02:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 13/13] net/mlx5: Add a shared devlink
 instance for PFs on same chip
Message-ID: <sim5ddxllwk5dwnbax4w4ieseziqnis7j2hr2vffaymzsvxcsw@b5q2r4shnlg7>
References: <20260312100407.551173-1-jiri@resnulli.us>
 <20260312100407.551173-14-jiri@resnulli.us>
 <bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com>
 <c37ee2a7-8e19-4aaa-aaf3-4cd5a9c171d1@amperemail.onmicrosoft.com>
 <ib6r4armffxw3f56fxxor3bg4ejhnsfg5ddg4dncae5u6lonty@ds6bfkjoykbl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ib6r4armffxw3f56fxxor3bg4ejhnsfg5ddg4dncae5u6lonty@ds6bfkjoykbl>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-271063-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mellanox.com:email,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,onmicrosoft.com:email,resnulli.us:email]
X-Rspamd-Queue-Id: BD0CE309216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Mar 23, 2026 at 04:05:19PM +0100, jiri@resnulli.us wrote:
>Sat, Mar 21, 2026 at 12:37:06AM +0100, admiyo@amperemail.onmicrosoft.com wrote:
>>
>>
>>0005:01:00.0 Ethernet controller: Mellanox Technologies MT27710 Family
>>[ConnectX-4 Lx]
>
>Cool. Will try to reproduce this locally. Thanks!
>

Hi. Testing this with:
08:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
works fine. What's your output of "devlink dev info"?


>
>
>
>>0005:01:00.1 Ethernet controller: Mellanox Technologies MT27710 Family
>>[ConnectX-4 Lx]
>>
>>On 3/20/26 19:16, Adam Young wrote:
>>> This breaks on my system:
>>> 
>>> On 7.0.0 It boots fine.  With net-next/main currently at this commit
>>> 
>>> 
>>> commit 8737d7194d6d5947c3d7d8813895b44a25b84477 (net-next/main,
>>> net-next/HEAD)
>>> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>>> Date:   Fri Mar 13 17:28:36 2026 +0100
>>> 
>>> I get:
>>> 
>>> [   21.859081] mlx5_core 0005:01:00.0: probe_one:2017:(pid 10):
>>> mlx5_shd_init failed with error code -2
>>> [   21.863266] mlx5_core 0005:01:00.0: probe with driver mlx5_core failed
>>> with error -2
>>> [   21.866360] mlx5_core 0005:01:00.1: probe_one:2017:(pid 10):
>>> mlx5_shd_init failed with error code -2
>>> [   21.869937] mlx5_core 0005:01:00.1: probe with driver mlx5_core failed
>>> with error -2
>>> 
>>> 
>>> I am happy to help debug:   what do you need from me?
>>> 
>>> 
>>> On 3/12/26 06:04, Jiri Pirko wrote:
>>> > From: Jiri Pirko <jiri@nvidia.com>
>>> > 
>>> > Use the previously introduced shared devlink infrastructure to create
>>> > a shared devlink instance for mlx5 PFs that reside on the same physical
>>> > chip. The shared instance is identified by the chip's serial number
>>> > extracted from PCI VPD (V3 keyword, with fallback to serial number
>>> > for older devices).
>>> > 
>>> > Each PF that probes calls mlx5_shd_init() which extracts the chip serial
>>> > number and uses devlink_shd_get() to get or create the shared instance.
>>> > When a PF is removed, mlx5_shd_uninit() calls devlink_shd_put()
>>> > to release the reference. The shared instance is automatically destroyed
>>> > when the last PF is removed.
>>> > 
>>> > Make the PF devlink instances nested in this shared devlink instance,
>>> > allowing userspace to identify which PFs belong to the same physical
>>> > chip.
>>> > 
>>> > Example:
>>> > 
>>> > pci/0000:08:00.0: index 0
>>> >    nested_devlink:
>>> >      auxiliary/mlx5_core.eth.0
>>> > devlink_index/1: index 1
>>> >    nested_devlink:
>>> >      pci/0000:08:00.0
>>> >      pci/0000:08:00.1
>>> > auxiliary/mlx5_core.eth.0: index 2
>>> > pci/0000:08:00.1: index 3
>>> >    nested_devlink:
>>> >      auxiliary/mlx5_core.eth.1
>>> > auxiliary/mlx5_core.eth.1: index 4
>>> > 
>>> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>> > ---
>>> > v2->v3:
>>> > - removed "const" from "sn"
>>> > - passing driver pointer to devlink_shd_get()
>>> > ---
>>> >   .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
>>> >   .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++++++
>>> >   .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 61 +++++++++++++++++++
>>> >   .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
>>> >   include/linux/mlx5/driver.h                   |  1 +
>>> >   5 files changed, 94 insertions(+), 2 deletions(-)
>>> >   create mode 100644
>>> > drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>> >   create mode 100644
>>> > drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>> > 
>>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>> > b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>> > index 8ffa286a18f5..d39fe9c4a87c 100644
>>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>> > @@ -16,8 +16,9 @@ mlx5_core-y :=    main.o cmd.o debugfs.o fw.o eq.o
>>> > uar.o pagealloc.o \
>>> >           transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
>>> >           fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o
>>> > dev.o events.o wq.o lib/gid.o \
>>> >           lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o
>>> > diag/fs_tracepoint.o \
>>> > -        diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o
>>> > diag/reporter_vnic.o \
>>> > -        fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
>>> > lib/nv_param.o
>>> > +        diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o
>>> > diag/rsc_dump.o \
>>> > +        diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o
>>> > wc.o fs_pool.o \
>>> > +        lib/nv_param.o
>>> >     #
>>> >   # Netdev basic
>>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> > b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> > index fdc3ba20912e..1c35c3fc3bb3 100644
>>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> > @@ -74,6 +74,7 @@
>>> >   #include "mlx5_irq.h"
>>> >   #include "hwmon.h"
>>> >   #include "lag/lag.h"
>>> > +#include "sh_devlink.h"
>>> >     MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>>> >   MODULE_DESCRIPTION("Mellanox 5th generation network adapters
>>> > (ConnectX series) core driver");
>>> > @@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>>> >       int err;
>>> >         devl_lock(devlink);
>>> > +    if (dev->shd) {
>>> > +        err = devl_nested_devlink_set(dev->shd, devlink);
>>> > +        if (err)
>>> > +            goto unlock;
>>> > +    }
>>> >       devl_register(devlink);
>>> >       err = mlx5_init_one_devl_locked(dev);
>>> >       if (err)
>>> >           devl_unregister(devlink);
>>> > +unlock:
>>> >       devl_unlock(devlink);
>>> >       return err;
>>> >   }
>>> > @@ -2005,6 +2012,13 @@ static int probe_one(struct pci_dev *pdev,
>>> > const struct pci_device_id *id)
>>> >           goto pci_init_err;
>>> >       }
>>> >   +    err = mlx5_shd_init(dev);
>>> > +    if (err) {
>>> > +        mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
>>> > +                  err);
>>> > +        goto shd_init_err;
>>> > +    }
>>> > +
>>> >       err = mlx5_init_one(dev);
>>> >       if (err) {
>>> >           mlx5_core_err(dev, "mlx5_init_one failed with error code
>>> > %d\n",
>>> > @@ -2018,6 +2032,8 @@ static int probe_one(struct pci_dev *pdev,
>>> > const struct pci_device_id *id)
>>> >       return 0;
>>> >     err_init_one:
>>> > +    mlx5_shd_uninit(dev);
>>> > +shd_init_err:
>>> >       mlx5_pci_close(dev);
>>> >   pci_init_err:
>>> >       mlx5_mdev_uninit(dev);
>>> > @@ -2039,6 +2055,7 @@ static void remove_one(struct pci_dev *pdev)
>>> >       mlx5_drain_health_wq(dev);
>>> >       mlx5_sriov_disable(pdev, false);
>>> >       mlx5_uninit_one(dev);
>>> > +    mlx5_shd_uninit(dev);
>>> >       mlx5_pci_close(dev);
>>> >       mlx5_mdev_uninit(dev);
>>> >       mlx5_adev_idx_free(dev->priv.adev_idx);
>>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>> > b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>> > new file mode 100644
>>> > index 000000000000..bc33f95302df
>>> > --- /dev/null
>>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>> > @@ -0,0 +1,61 @@
>>> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>> > +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
>>> > reserved. */
>>> > +
>>> > +#include <linux/mlx5/driver.h>
>>> > +#include <net/devlink.h>
>>> > +
>>> > +#include "sh_devlink.h"
>>> > +
>>> > +static const struct devlink_ops mlx5_shd_ops = {
>>> > +};
>>> > +
>>> > +int mlx5_shd_init(struct mlx5_core_dev *dev)
>>> > +{
>>> > +    u8 *vpd_data __free(kfree) = NULL;
>>> > +    struct pci_dev *pdev = dev->pdev;
>>> > +    unsigned int vpd_size, kw_len;
>>> > +    struct devlink *devlink;
>>> > +    char *sn, *end;
>>> > +    int start;
>>> > +    int err;
>>> > +
>>> > +    if (!mlx5_core_is_pf(dev))
>>> > +        return 0;
>>> > +
>>> > +    vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>>> > +    if (IS_ERR(vpd_data)) {
>>> > +        err = PTR_ERR(vpd_data);
>>> > +        return err == -ENODEV ? 0 : err;
>>> > +    }
>>> > +    start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
>>> > &kw_len);
>>> > +    if (start < 0) {
>>> > +        /* Fall-back to SN for older devices. */
>>> > +        start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>>> > +                             PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>>> > +        if (start < 0)
>>> > +            return -ENOENT;
>>> > +    }
>>> > +    sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>>> > +    if (!sn)
>>> > +        return -ENOMEM;
>>> > +    /* Firmware may return spaces at the end of the string, strip
>>> > it. */
>>> > +    end = strchrnul(sn, ' ');
>>> > +    *end = '\0';
>>> > +
>>> > +    /* Get or create shared devlink instance */
>>> > +    devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
>>> > +    kfree(sn);
>>> > +    if (!devlink)
>>> > +        return -ENOMEM;
>>> > +
>>> > +    dev->shd = devlink;
>>> > +    return 0;
>>> > +}
>>> > +
>>> > +void mlx5_shd_uninit(struct mlx5_core_dev *dev)
>>> > +{
>>> > +    if (!dev->shd)
>>> > +        return;
>>> > +
>>> > +    devlink_shd_put(dev->shd);
>>> > +}
>>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>> > b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>> > new file mode 100644
>>> > index 000000000000..8ab8d6940227
>>> > --- /dev/null
>>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>> > @@ -0,0 +1,12 @@
>>> > +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>> > +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
>>> > reserved. */
>>> > +
>>> > +#ifndef __MLX5_SH_DEVLINK_H__
>>> > +#define __MLX5_SH_DEVLINK_H__
>>> > +
>>> > +#include <linux/mlx5/driver.h>
>>> > +
>>> > +int mlx5_shd_init(struct mlx5_core_dev *dev);
>>> > +void mlx5_shd_uninit(struct mlx5_core_dev *dev);
>>> > +
>>> > +#endif /* __MLX5_SH_DEVLINK_H__ */
>>> > diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
>>> > index 04dcd09f7517..1268fcf35ec7 100644
>>> > --- a/include/linux/mlx5/driver.h
>>> > +++ b/include/linux/mlx5/driver.h
>>> > @@ -798,6 +798,7 @@ struct mlx5_core_dev {
>>> >       enum mlx5_wc_state wc_state;
>>> >       /* sync write combining state */
>>> >       struct mutex wc_state_lock;
>>> > +    struct devlink *shd;
>>> >   };
>>> >     struct mlx5_db {
>>> 

