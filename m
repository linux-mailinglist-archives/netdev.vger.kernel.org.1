Return-Path: <netdev+bounces-75221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042DA868A8C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AF71F24946
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BF55E68;
	Tue, 27 Feb 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuFGgcfv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76505467C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021472; cv=none; b=jqmAWIDwVCRZqEshpqh/ZyJEFCkqg78idDW2jvkfRXEj/C7Td9quC7EJgIPbXTHJfeEBkGQNvfqqTr36qf0y4PlaEb8ae9dOSCuwGNFsqlg/OdQUTYXkE1JyIeHpCcdiTRb24zBQaYz9V9Pdn16V2zr2nalj3YRlPHNCCxc/CA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021472; c=relaxed/simple;
	bh=LlUzjmFJCqA3b6wMzrD9VzeLdRCOEOuJWh8LmNE3df8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9Rj1oeD+S5vJgev9k2WUSK/H0wsNx1tKNObJEf1cgyaTgS/LJslpsJvlVscmPgJMFVShtz/9wU2AlHy3+msOmO3dEfNpum5+01JPrfJS9OTwSEdEJ+cwEnc9BzdB0tfn/Q3VsUpERtKtB69HyCjNQSYiwsG2kYsIYy6p0tUHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuFGgcfv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709021469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6piSwraRWXigsSpLo1mJkUOURoZoNM0+ReFijy4zgE=;
	b=KuFGgcfvJkR5FGS6vXal2mgrKFRwf4gL96DfTaZ2IkqlW6h6+crib83KC8GbKHqs/2DBD4
	V6w8Mx7Exyvpv/1NI4Kj8iWgtkDZ2BcaINykgl0wQXwtKyo/yW0Q/cu6KOVxBwxjHrbuuM
	WdBnilgIVDMrYCG65kqn7MLPX6Iy+RM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ifzkGTwUO8GqtLkk90ciTw-1; Tue, 27 Feb 2024 03:11:07 -0500
X-MC-Unique: ifzkGTwUO8GqtLkk90ciTw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d36736772so2008061f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 00:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021466; x=1709626266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6piSwraRWXigsSpLo1mJkUOURoZoNM0+ReFijy4zgE=;
        b=pOLTRm99lJkbyV+293g3w5+LIbmpfYysa0fuzLTvs2Xf4migvHVKabeU7ajk9XSKeh
         QGoU3YU3haVUUFCMBqNm6Fh4mqfa6zGd1OykACG4alkKw27P+LuzH79CQQGuijhXN3SS
         8UP3Ml/Bkw3phUycF8HWNd8oVUv8RghRDXxBhtd8V+Yx/VUO67BrZ9bgF8NBpXafHAf/
         0yhnyWBaCB0krpGtU+Y7yavaNyf3O4T+dX/iK5R7aQv7GdCgZpKu+calY8BW4NiLpEfL
         Os+dTFXFSeTqGWkUv4gstvUoUqVcBPnajw4orxF0u19b754lWKKdy77lQYYVTYF8OBDH
         JxUw==
X-Forwarded-Encrypted: i=1; AJvYcCUc2lxwl4Dq00Dsfy7gUxDKUpWHGeH/1I7pb6zS11P0a7b+r3S9t7COitMKk8hIbsrgF8QWc7e6Pleoy038yoDaWxi+MMuJ
X-Gm-Message-State: AOJu0YwqmhZItCvOJHU1YC6K4HBVSshjduhhMg/QLPGa5dxCDBG7vQBy
	MlgJaOF6rfaLbFtC44svzBvDr8/7kaRQY7otuZDNdOS7rUyNfkUn+B8zFeBJRh9pXYzyAJNX9Hb
	hx7Hfpzay0gNCRqb+4aVzbwoIVy7M2ivAh4iIbFzop8WQ92WwJ1imag==
X-Received: by 2002:a05:6000:543:b0:33d:1cc1:bb08 with SMTP id b3-20020a056000054300b0033d1cc1bb08mr6479114wrf.22.1709021466138;
        Tue, 27 Feb 2024 00:11:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/6MsCvDlDBzEAD2kHoP7xH4bJls44k+euCH2Jy+sXwYW1QJ5MsJbNsJeC3EZSDAqi5wmzJw==
X-Received: by 2002:a05:6000:543:b0:33d:1cc1:bb08 with SMTP id b3-20020a056000054300b0033d1cc1bb08mr6479102wrf.22.1709021465753;
        Tue, 27 Feb 2024 00:11:05 -0800 (PST)
Received: from [10.43.2.89] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ch12-20020a5d5d0c000000b0033dabeacab2sm10648037wrb.39.2024.02.27.00.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:11:05 -0800 (PST)
Message-ID: <af1b28e3-dd5f-4e31-a891-9dc038a92a34@redhat.com>
Date: Tue, 27 Feb 2024 09:11:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] ice: add ice_adapter for shared data across
 PFs on the same NIC
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20240226151125.45391-1-mschmidt@redhat.com>
 <20240226151125.45391-2-mschmidt@redhat.com> <Zd2JuVAyHigIy5NR@nanopsycho>
Content-Language: en-US
From: Michal Schmidt <mschmidt@redhat.com>
In-Reply-To: <Zd2JuVAyHigIy5NR@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 08:05, Jiri Pirko wrote:
> Mon, Feb 26, 2024 at 04:11:23PM CET, mschmidt@redhat.com wrote:
>> There is a need for synchronization between ice PFs on the same physical
>> adapter.
>>
>> Add a "struct ice_adapter" for holding data shared between PFs of the
>> same multifunction PCI device. The struct is refcounted - each ice_pf
>> holds a reference to it.
>>
>> Its first use will be for PTP. I expect it will be useful also to
>> improve the ugliness that is ice_prot_id_tbl.
>>
>> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
>> ---
>> drivers/net/ethernet/intel/ice/Makefile      |  3 +-
>> drivers/net/ethernet/intel/ice/ice.h         |  2 +
>> drivers/net/ethernet/intel/ice/ice_adapter.c | 67 ++++++++++++++++++++
>> drivers/net/ethernet/intel/ice/ice_adapter.h | 22 +++++++
>> drivers/net/ethernet/intel/ice/ice_main.c    |  8 +++
>> 5 files changed, 101 insertions(+), 1 deletion(-)
>> create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
>> create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
>>
>> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>> index cddd82d4ca0f..4fa09c321440 100644
>> --- a/drivers/net/ethernet/intel/ice/Makefile
>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>> @@ -36,7 +36,8 @@ ice-y := ice_main.o	\
>> 	 ice_repr.o	\
>> 	 ice_tc_lib.o	\
>> 	 ice_fwlog.o	\
>> -	 ice_debugfs.o
>> +	 ice_debugfs.o  \
>> +	 ice_adapter.o
>> ice-$(CONFIG_PCI_IOV) +=	\
>> 	ice_sriov.o		\
>> 	ice_virtchnl.o		\
>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>> index 365c03d1c462..1ffecbdd361a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice.h
>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>> @@ -77,6 +77,7 @@
>> #include "ice_gnss.h"
>> #include "ice_irq.h"
>> #include "ice_dpll.h"
>> +#include "ice_adapter.h"
>>
>> #define ICE_BAR0		0
>> #define ICE_REQ_DESC_MULTIPLE	32
>> @@ -544,6 +545,7 @@ struct ice_agg_node {
>>
>> struct ice_pf {
>> 	struct pci_dev *pdev;
>> +	struct ice_adapter *adapter;
>>
>> 	struct devlink_region *nvm_region;
>> 	struct devlink_region *sram_region;
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> new file mode 100644
>> index 000000000000..deb063401238
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// SPDX-FileCopyrightText: Copyright Red Hat
>> +
>> +#include <linux/cleanup.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <linux/slab.h>
>> +#include <linux/xarray.h>
>> +#include "ice_adapter.h"
>> +
>> +static DEFINE_MUTEX(ice_adapters_lock);
> 
> Why you need and extra mutex and not just rely on xarray lock?

I suppose I could use xa_lock() and the __xa_{load,store} calls. 
Alright, let's see what it will look like...
Thanks,
Michal


>> +static DEFINE_XARRAY(ice_adapters);
>> +
>> +static unsigned long ice_adapter_index(const struct pci_dev *pdev)
>> +{
>> +	unsigned int domain = pci_domain_nr(pdev->bus);
>> +
>> +	WARN_ON((unsigned long)domain >> (BITS_PER_LONG - 13));
>> +	return ((unsigned long)domain << 13) |
>> +	       ((unsigned long)pdev->bus->number << 5) |
>> +	       PCI_SLOT(pdev->devfn);
>> +}
>> +
>> +struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>> +{
>> +	unsigned long index = ice_adapter_index(pdev);
>> +	struct ice_adapter *a;
>> +
>> +	guard(mutex)(&ice_adapters_lock);
>> +
>> +	a = xa_load(&ice_adapters, index);
>> +	if (a) {
>> +		refcount_inc(&a->refcount);
>> +		return a;
>> +	}
>> +
>> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
>> +	if (!a)
>> +		return NULL;
>> +
>> +	refcount_set(&a->refcount, 1);
>> +
>> +	if (xa_is_err(xa_store(&ice_adapters, index, a, GFP_KERNEL))) {
>> +		kfree(a);
>> +		return NULL;
>> +	}
>> +
>> +	return a;
>> +}
>> +
>> +void ice_adapter_put(const struct pci_dev *pdev)
>> +{
>> +	unsigned long index = ice_adapter_index(pdev);
>> +	struct ice_adapter *a;
>> +
>> +	guard(mutex)(&ice_adapters_lock);
>> +
>> +	a = xa_load(&ice_adapters, index);
>> +	if (WARN_ON(!a))
>> +		return;
>> +
>> +	if (!refcount_dec_and_test(&a->refcount))
>> +		return;
>> +
>> +	WARN_ON(xa_erase(&ice_adapters, index) != a);
>> +	kfree(a);
>> +}
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> new file mode 100644
>> index 000000000000..cb5a02eb24c1
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* SPDX-FileCopyrightText: Copyright Red Hat */
>> +
>> +#ifndef _ICE_ADAPTER_H_
>> +#define _ICE_ADAPTER_H_
>> +
>> +#include <linux/refcount_types.h>
>> +
>> +struct pci_dev;
>> +
>> +/**
>> + * struct ice_adapter - PCI adapter resources shared across PFs
>> + * @refcount: Reference count. struct ice_pf objects hold the references.
>> + */
>> +struct ice_adapter {
>> +	refcount_t refcount;
>> +};
>> +
>> +struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
>> +void ice_adapter_put(const struct pci_dev *pdev);
>> +
>> +#endif /* _ICE_ADAPTER_H */
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 9c2c8637b4a7..4a60957221fc 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -5093,6 +5093,7 @@ static int
>> ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>> {
>> 	struct device *dev = &pdev->dev;
>> +	struct ice_adapter *adapter;
>> 	struct ice_pf *pf;
>> 	struct ice_hw *hw;
>> 	int err;
>> @@ -5145,7 +5146,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>>
>> 	pci_set_master(pdev);
>>
>> +	adapter = ice_adapter_get(pdev);
>> +	if (!adapter)
>> +		return -ENOMEM;
>> +
>> 	pf->pdev = pdev;
>> +	pf->adapter = adapter;
>> 	pci_set_drvdata(pdev, pf);
>> 	set_bit(ICE_DOWN, pf->state);
>> 	/* Disable service task until DOWN bit is cleared */
>> @@ -5196,6 +5202,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>> err_load:
>> 	ice_deinit(pf);
>> err_init:
>> +	ice_adapter_put(pdev);
>> 	pci_disable_device(pdev);
>> 	return err;
>> }
>> @@ -5302,6 +5309,7 @@ static void ice_remove(struct pci_dev *pdev)
>> 	ice_setup_mc_magic_wake(pf);
>> 	ice_set_wake(pf);
>>
>> +	ice_adapter_put(pdev);
>> 	pci_disable_device(pdev);
>> }
>>
>> -- 
>> 2.43.2
>>
>>
> 


