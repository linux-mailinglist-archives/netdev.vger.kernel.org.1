Return-Path: <netdev+bounces-176097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D20A68C18
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FC43BE9E9
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3D4254B05;
	Wed, 19 Mar 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NNa3Q+lM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B5254AF0
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384694; cv=none; b=lZ1demaJanT+Wc1VyZWBS5YaMt6VKf5d7f+qssEAKizcGv/vlPkB7rXeEqtKejCtktLQbVl3A61uShM6Sw57tquxPPINiwH3Sn/taLBrnbxB0qvegE5t8Jdw0FKRlZg9jSFDG1TpaOLJ55DjPeyOnerOslxa1/uWzt5N8HlHMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384694; c=relaxed/simple;
	bh=N6AdJ3TbT8OCi9hzZ3yrOuPsAiZKpeWBdZtMekloC7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgxr6pLTprNWjDCy+hcmEAOXi0Cj/F8Ai1vvBCjxJ7ujviTrcje4LwE0CCaIBhEgUhfPgPEjxJKHazpzGR+3smSc7OWVPf2nFhyprKTT2pKGwdVrEF18fdzcaooYesEh0aBZVy+MqB2qDZtTiNFoZ8VNsf4xpC+InOK8IfimqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NNa3Q+lM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2484128f8f.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742384690; x=1742989490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SqEPmKE7zexzl/Ct5RiyD7KipPiZVA6KU26zXI23iw=;
        b=NNa3Q+lMr8oS5SeXKaRF/gVNmL9UGh0bAkFYe5UFs9Q4fz1LRJFHoz92nI9A+Nq0k2
         6uHLJfJEvZZpd0XJVniOdbtPCW1Bllm8EPi+xOXmAofAb290M+cKlr2bnqBed4gfniyr
         ALzNmLwoZ9DePZotZChqkxpXzd7b6yqbbstJRvsnEo3sFzZQDSnNe9fPx1DXCLkj9mj3
         eAKONu2A/EmnrDYLtbXNYxdXAn0JozaQPwZOj4fOLgOuiaTBYjvZID+Mr+07VD6ygYoL
         ADKf5a34AT/oPWMeI3rvEIKahuRP4sLTnfVyUAYQSyEeCMdEi5d07NGoAg1BvSAcU72c
         o3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384690; x=1742989490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SqEPmKE7zexzl/Ct5RiyD7KipPiZVA6KU26zXI23iw=;
        b=qntgBocq1+obw+h/6DAwj+j5cNEEs5UhVV2bdo5Kh2pLENm4DwTo7+yhIxmnSKKypH
         2xxQkv64HI9sXPUrQplA1MWP+eR43U0x+ZqAlSE4911H4DEoS7IiNU9ZkAWni7UhDag8
         Q03fdxTQ2eH5LdxL86c6/Clo1YkYtrKRLzOcsjDnPHX2Z0amR/H+BT8sPJCvmQ3s++gP
         s+qpy8YP16c+6TpGhOi692HfLJTWtVIMxu88zVp2OJ6VYYTzGikCZKNA1RwWWbrGeD2/
         ZdEgKXvDCLXIuSN8PEAB9+FMEUNHXX/jgyfGe1nAsk9ti4IcswpS2uDJjXbs5XEpavxc
         cEPQ==
X-Gm-Message-State: AOJu0Yxa4s8eKlbo6v0bxznkZRxm08lKT40JTRlD2oRzmrgo3TU6hRqs
	k2lun8OE/VzEZLf+Zrr1/GkAX4iuD7aMY8EglzyGvdIvtAIE+y8F/5OAFzyVeZ0=
X-Gm-Gg: ASbGncsYG/4Xlxbw8yKs4rSQEM/j8yIc3GSxGqXlVcymiaB/8g6VL9qCk/osZM00yZR
	kNHdoR4xI8TUxNXWY1ycqRWi90HZMvzjj83HF3z3odGYptCVumt7gOkNUo7HRHFBa/jEkjuKmBo
	CahtDrTE9L5k3qGlCTu4ZOIwholcEukL+50iH/lZCaJlI72b/vBqSts9os4sAh6LFW3L+CNzPol
	rxeX8JrDGIYkrdCueYXDYpE8nguET1u3uRnk4twYFfQAwpRrQMKr3vauVFjiz+5d7Jr8BAtF8jo
	WZ9p62QvLZfecD3fdu1OnkErmrBtw5MRDTYC3a/sNedbOZxTlyQ6dRVbmHB7pNGi3Hv3TTw=
X-Google-Smtp-Source: AGHT+IGfNUCsMR3zkTuhi0Nh7w6UgmTDjHO6wcNLi0SfTaPCL/Kwtf1xhlEg+FrQcsZDNWO1lgwqBw==
X-Received: by 2002:a5d:6c6a:0:b0:391:3bdb:af5d with SMTP id ffacd0b85a97d-399739c8ff2mr2689627f8f.28.1742384689575;
        Wed, 19 Mar 2025 04:44:49 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888117csm20460287f8f.44.2025.03.19.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:44:49 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:44:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "Dumazet, Eric" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, 
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"dakr@kernel.org" <dakr@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>, 
	"Knitter, Konrad" <konrad.knitter@intel.com>, "cjubran@nvidia.com" <cjubran@nvidia.com>
Subject: Re: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink
 instance for PFs on same chip
Message-ID: <e6ioea475mj73ijqrjsuxausfekawf3xgav6xtbutr64ab4vb4@dlyjvq4pdef3>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-3-jiri@resnulli.us>
 <CO1PR11MB5089BDFAF1B498FE9FDDA3FCD6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5089BDFAF1B498FE9FDDA3FCD6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>

Tue, Mar 18, 2025 at 11:05:23PM +0100, jacob.e.keller@intel.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, March 18, 2025 5:47 AM
>> To: netdev@vger.kernel.org
>> Cc: davem@davemloft.net; Dumazet, Eric <edumazet@google.com>;
>> kuba@kernel.org; pabeni@redhat.com; saeedm@nvidia.com; leon@kernel.org;
>> tariqt@nvidia.com; andrew+netdev@lunn.ch; dakr@kernel.org;
>> rafael@kernel.org; gregkh@linuxfoundation.org; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; cratiu@nvidia.com; Keller, Jacob E
>> <jacob.e.keller@intel.com>; Knitter, Konrad <konrad.knitter@intel.com>;
>> cjubran@nvidia.com
>> Subject: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink instance for
>> PFs on same chip
>> 
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Multiple PFS may reside on the same physical chip, running a single
>> firmware. Some of the resources and configurations may be shared among
>> these PFs. Currently, there is not good object to pin the configuration
>> knobs on.
>> 
>> Introduce a shared devlink, instantiated upon probe of the first PF,
>> removed during remove of the last PF. Back this shared devlink instance
>> by faux device, as there is no PCI device related to it.
>> 
>> Make the PF devlink instances nested in this shared devlink instance.
>> 
>> Example:
>> 
>> $ devlink dev
>> pci/0000:08:00.0:
>>   nested_devlink:
>>     auxiliary/mlx5_core.eth.0
>> faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
>>   nested_devlink:
>>     pci/0000:08:00.0
>>     pci/0000:08:00.1
>> auxiliary/mlx5_core.eth.0
>> pci/0000:08:00.1:
>>   nested_devlink:
>>     auxiliary/mlx5_core.eth.1
>> auxiliary/mlx5_core.eth.1
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  .../net/ethernet/mellanox/mlx5/core/Makefile  |   4 +-
>>  .../net/ethernet/mellanox/mlx5/core/main.c    |  18 +++
>>  .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 150 ++++++++++++++++++
>>  .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  10 ++
>>  include/linux/mlx5/driver.h                   |   5 +
>>  5 files changed, 185 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> index 568bbe5f83f5..510850b6e6e2 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> @@ -16,8 +16,8 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o
>> pagealloc.o \
>>  		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
>>  		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o
>> events.o wq.o lib/gid.o \
>>  		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o
>> diag/fs_tracepoint.o \
>> -		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o
>> diag/reporter_vnic.o \
>> -		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
>> +		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o
>> diag/rsc_dump.o \
>> +		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o
>> fs_pool.o
>> 
>>  #
>>  # Netdev basic
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> index 710633d5fdbe..e1217a8bf4db 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> @@ -74,6 +74,7 @@
>>  #include "mlx5_irq.h"
>>  #include "hwmon.h"
>>  #include "lag/lag.h"
>> +#include "sh_devlink.h"
>> 
>>  MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>>  MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX
>> series) core driver");
>> @@ -1554,10 +1555,17 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>>  	int err;
>> 
>>  	devl_lock(devlink);
>> +	if (dev->shd) {
>> +		err = devl_nested_devlink_set(priv_to_devlink(dev->shd),
>> +					      devlink);
>> +		if (err)
>> +			goto unlock;
>> +	}
>>  	devl_register(devlink);
>>  	err = mlx5_init_one_devl_locked(dev);
>>  	if (err)
>>  		devl_unregister(devlink);
>> +unlock:
>>  	devl_unlock(devlink);
>>  	return err;
>>  }
>> @@ -1998,6 +2006,13 @@ static int probe_one(struct pci_dev *pdev, const struct
>> pci_device_id *id)
>>  		goto pci_init_err;
>>  	}
>> 
>> +	err = mlx5_shd_init(dev);
>> +	if (err) {
>> +		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
>> +			      err);
>> +		goto shd_init_err;
>> +	}
>> +
>>  	err = mlx5_init_one(dev);
>>  	if (err) {
>>  		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
>> @@ -2009,6 +2024,8 @@ static int probe_one(struct pci_dev *pdev, const struct
>> pci_device_id *id)
>>  	return 0;
>> 
>>  err_init_one:
>> +	mlx5_shd_uninit(dev);
>> +shd_init_err:
>>  	mlx5_pci_close(dev);
>>  pci_init_err:
>>  	mlx5_mdev_uninit(dev);
>> @@ -2030,6 +2047,7 @@ static void remove_one(struct pci_dev *pdev)
>>  	mlx5_drain_health_wq(dev);
>>  	mlx5_sriov_disable(pdev, false);
>>  	mlx5_uninit_one(dev);
>> +	mlx5_shd_uninit(dev);
>>  	mlx5_pci_close(dev);
>>  	mlx5_mdev_uninit(dev);
>>  	mlx5_adev_idx_free(dev->priv.adev_idx);
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> new file mode 100644
>> index 000000000000..671a3442525b
>> --- /dev/null
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> @@ -0,0 +1,150 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>> +
>> +#include <linux/device/faux.h>
>> +#include <linux/mlx5/driver.h>
>> +#include <linux/mlx5/vport.h>
>> +
>> +#include "sh_devlink.h"
>> +
>> +static LIST_HEAD(shd_list);
>> +static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
>> +
>> +/* This structure represents a shared devlink instance,
>> + * there is one created for PF group of the same chip.
>> + */
>> +struct mlx5_shd {
>> +	/* Node in shd list */
>> +	struct list_head list;
>> +	/* Serial number of the chip */
>> +	const char *sn;
>> +	/* List of per-PF dev instances. */
>> +	struct list_head dev_list;
>> +	/* Related faux device */
>> +	struct faux_device *faux_dev;
>> +};
>> +
>
>For ice, the equivalent of this would essentially replace ice_adapter I imagine.

Yep.


>
>> +static const struct devlink_ops mlx5_shd_ops = {
>> +};
>> +
>> +static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
>> +{
>> +	struct devlink *devlink;
>> +	struct mlx5_shd *shd;
>> +
>> +	devlink = devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd),
>> &faux_dev->dev);
>> +	if (!devlink)
>> +		return -ENOMEM;
>> +	shd = devlink_priv(devlink);
>> +	faux_device_set_drvdata(faux_dev, shd);
>> +
>> +	devl_lock(devlink);
>> +	devl_register(devlink);
>> +	devl_unlock(devlink);
>> +	return 0;
>> +}
>> +
>> +static void mlx5_shd_faux_remove(struct faux_device *faux_dev)
>> +{
>> +	struct mlx5_shd *shd = faux_device_get_drvdata(faux_dev);
>> +	struct devlink *devlink = priv_to_devlink(shd);
>> +
>> +	devl_lock(devlink);
>> +	devl_unregister(devlink);
>> +	devl_unlock(devlink);
>> +	devlink_free(devlink);
>> +}
>> +
>> +static const struct faux_device_ops mlx5_shd_faux_ops = {
>> +	.probe = mlx5_shd_faux_probe,
>> +	.remove = mlx5_shd_faux_remove,
>> +};
>> +
>> +static struct mlx5_shd *mlx5_shd_create(const char *sn)
>> +{
>> +	struct faux_device *faux_dev;
>> +	struct mlx5_shd *shd;
>> +
>> +	faux_dev = faux_device_create(THIS_MODULE, sn, NULL,
>> &mlx5_shd_faux_ops);
>> +	if (!faux_dev)
>> +		return NULL;
>> +	shd = faux_device_get_drvdata(faux_dev);
>> +	if (!shd)
>> +		return NULL;
>> +	list_add_tail(&shd->list, &shd_list);
>> +	shd->sn = sn;
>> +	INIT_LIST_HEAD(&shd->dev_list);
>> +	shd->faux_dev = faux_dev;
>> +	return shd;
>> +}
>> +
>> +static void mlx5_shd_destroy(struct mlx5_shd *shd)
>> +{
>> +	list_del(&shd->list);
>> +	kfree(shd->sn);
>> +	faux_device_destroy(shd->faux_dev);
>> +}
>> +
>> +int mlx5_shd_init(struct mlx5_core_dev *dev)
>> +{
>> +	u8 *vpd_data __free(kfree) = NULL;
>> +	struct pci_dev *pdev = dev->pdev;
>> +	unsigned int vpd_size, kw_len;
>> +	struct mlx5_shd *shd;
>> +	const char *sn;
>> +	char *end;
>> +	int start;
>> +	int err;
>> +
>> +	if (!mlx5_core_is_pf(dev))
>> +		return 0;
>> +
>> +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>> +	if (IS_ERR(vpd_data)) {
>> +		err = PTR_ERR(vpd_data);
>> +		return err == -ENODEV ? 0 : err;
>> +	}
>> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
>> &kw_len);
>> +	if (start < 0) {
>> +		/* Fall-back to SN for older devices. */
>> +		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>> +
>> PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>> +		if (start < 0)
>> +			return -ENOENT;
>> +	}
>> +	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> +	if (!sn)
>> +		return -ENOMEM;
>> +	end = strchrnul(sn, ' ');
>> +	*end = '\0';
>> +
>> +	guard(mutex)(&shd_mutex);
>> +	list_for_each_entry(shd, &shd_list, list) {
>> +		if (!strcmp(shd->sn, sn)) {
>> +			kfree(sn);
>> +			goto found;
>> +		}
>> +	}
>> +	shd = mlx5_shd_create(sn);
>> +	if (!shd) {
>> +		kfree(sn);
>> +		return -ENOMEM;
>> +	}
>
>How is the faux device kept in memory? I guess its reference counted somewhere? But I don't see that reference being incremented in the list_for_each.

There is one faux created in mlx5_shd_create() for one shd instance.
Reference counting is done by &shd->dev_list. See mlx5_shd_uninit()
where mlx5_shd_destroy() is called.



>
>> +found:
>> +	list_add_tail(&dev->shd_list, &shd->dev_list);
>> +	dev->shd = shd;
>> +	return 0;
>> +}
>> +
>> +void mlx5_shd_uninit(struct mlx5_core_dev *dev)
>> +{
>> +	struct mlx5_shd *shd = dev->shd;
>> +
>> +	if (!dev->shd)
>> +		return;
>> +
>> +	guard(mutex)(&shd_mutex);
>> +	list_del(&dev->shd_list);
>> +	if (list_empty(&shd->dev_list))
>> +		mlx5_shd_destroy(shd);
>> +}
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> new file mode 100644
>> index 000000000000..67df03e3c72e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>> +
>> +#ifndef __MLX5_SH_DEVLINK_H__
>> +#define __MLX5_SH_DEVLINK_H__
>> +
>> +int mlx5_shd_init(struct mlx5_core_dev *dev);
>> +void mlx5_shd_uninit(struct mlx5_core_dev *dev);
>> +
>> +#endif /* __MLX5_SH_DEVLINK_H__ */
>> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
>> index 46bd7550adf8..78f1f034568f 100644
>> --- a/include/linux/mlx5/driver.h
>> +++ b/include/linux/mlx5/driver.h
>> @@ -721,6 +721,8 @@ enum mlx5_wc_state {
>>  	MLX5_WC_STATE_SUPPORTED,
>>  };
>> 
>> +struct mlx5_shd;
>> +
>>  struct mlx5_core_dev {
>>  	struct device *device;
>>  	enum mlx5_coredev_type coredev_type;
>> @@ -783,6 +785,9 @@ struct mlx5_core_dev {
>>  	enum mlx5_wc_state wc_state;
>>  	/* sync write combining state */
>>  	struct mutex wc_state_lock;
>> +	/* node in shared devlink list */
>> +	struct list_head shd_list;
>> +	struct mlx5_shd *shd;
>>  };
>> 
>>  struct mlx5_db {
>> --
>> 2.48.1
>

