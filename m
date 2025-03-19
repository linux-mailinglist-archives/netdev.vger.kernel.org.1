Return-Path: <netdev+bounces-176098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FA7A68C33
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50313176328
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A52505D6;
	Wed, 19 Mar 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1G1nGvsf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E6720767A
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385377; cv=none; b=bSrVXlz+ozFeeBsW+6dNEFeY0x9owTLnQ/jt2kmShLRqkB7yXCSOb+E41DJjyKRzv/sDxOiQHoYRvwwcCDDN2G4c54IbN6MYEjkq5xIsbwL++I6aYjMp98ylzm/GWddUl429sZ6rksDt6fo6h/5f8mCVhebQR3aZBUkoU4Vrra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385377; c=relaxed/simple;
	bh=8j87BHyygiadRzRGO/QhaNl6TUnlqMAOJuQSrE2hCyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv0NyzGDrb1f1dI7fUyMm3nb4MeywH5Mfdf35Ze9+KuHvyMMXRJPw8Uh7s7QIWQhLNGyP7m86Tbpp+U+ckjwOmK127JCrFd0Ph+PIMcWZMOk4F5HMLotkKVwSnVszOu1peTFr176m5Tmv+IICmMIF3AB6kO99U9Ohiym9eUl5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1G1nGvsf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391342fc148so4345812f8f.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742385373; x=1742990173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXPTCWfzwO75XNo9I+VOj2DO+K3iLW4hVxFHCM8UTT4=;
        b=1G1nGvsfkLdEJg5JVkD8YiU14UczW+d2wruX+rUHfqVGmJ6RcOJema6AnCEYqqL52Y
         Zz0po2supZAiwxIt7XFK2/22PqR6su03l6Spuh+BIH/MYRUFqyUBDcKColy3rZEmWMa/
         zcRmwGbN/4O9akqKNa1UFVNUXkg7WCFEBHYtZSIl6PpqrUC+PJlsG9kwNo5F5fe2UJbv
         ipSqzlLdlet5cchjF8cYAKB+VcP6CiFub+hmbcZxroOprJTKGibuthmC4+EQGjlCkxzQ
         26uWkIns1cSn1bjojZh49LaN/v1VW2OgqsswJZyXYIjgkTNsuBSSG4ze8wFLKigoI96e
         dSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385373; x=1742990173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXPTCWfzwO75XNo9I+VOj2DO+K3iLW4hVxFHCM8UTT4=;
        b=THVTBPtJn+RrNXXTVLB9nxml8u7I+SVPF3BaNnKXbA3lznlsQgjFv1gM6xrXSRqZz9
         vt28AWpGqu1qcMBdx1ckY25USHZZxdThzjCfKFBwbcpcpxbhn0YAEAwCoJIwEh172Jrw
         MF5cS94HZaI7NcwMl0abbPQUJlNUoal4nQpnLb/P6VtVyxhsL6msiW0BHA9FWxS0VyuF
         9xv/wpBJ/TQo1fQtcxE1fJS9VkvSrwRRHFzzGrZwMf2BFZKhz/au0W1JnFOhk26mwzXj
         tY1bkFOtxr5meGT/4EBe1lX/fRb4Pq1FtRQ4gMmauEaHr2TBBl5FsdcfawNi1/qioPWQ
         YJ1g==
X-Forwarded-Encrypted: i=1; AJvYcCV5fy5vAVGR5hWkkKPj3R/RbeoiFMRpV/XWnaEoDupbmdJVDNCTZC1OtxUIhqMPSS2oCfx143g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx38OWGfdIGiVf8w0w8W9UCikcPRIB7iuAVXKg1RBX6faDhguzz
	EjQm+9GMmKMoqv9v8OVkng8Svx8jBO1GA1/cWTD3W74/NCfCg/mDxefsSV2naKI=
X-Gm-Gg: ASbGncsNxuS9r9TtY7Emb6VPIzjDIjzLZvE5QJ+5nYc4OBxugoPd6pi5919C636qd1V
	D3PbtzntDqA6g4ByT1+1D4eMJ1j/KQuZ7Vg91wiLva7aANFWn1FgutBISo9V/54jooIjbxm5cE9
	TCNvHUvTPuWK0t5Df9JWsUtTo44pFVPSppBz1bTWz7RI+fUvcH4Z1R4f9hZW/aPzpwkEx6ODihe
	AhXir0yQdYZLHCXKQaYIhb6Kf5wDZK9PQJ/p6ouM1SnafkPt10sVYhQ8deUsKgR3u332Q3n/27N
	TnInDOqO+P4+Wgl/ywxvV56Y8ynIk77IiXGD0x0EwvmRQ3CDRoBzx4wl11WptONUwGzvV24=
X-Google-Smtp-Source: AGHT+IH4nRdA2ON/Q3A5+NuiN2g3FhLrtA2yTcFcyK8rLez814fNUmsLTgY1+F2/q1MtPJny3v3PGA==
X-Received: by 2002:adf:a3c5:0:b0:391:4231:40a with SMTP id ffacd0b85a97d-399739de3b6mr1917393f8f.33.1742385373216;
        Wed, 19 Mar 2025 04:56:13 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978f185c6esm16643077f8f.94.2025.03.19.04.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:56:12 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:56:04 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Dumazet, Eric" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, 
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"dakr@kernel.org" <dakr@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>, 
	"Knitter, Konrad" <konrad.knitter@intel.com>, "cjubran@nvidia.com" <cjubran@nvidia.com>
Subject: Re: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink
 instance for PFs on same chip
Message-ID: <emj5f7xfdcnkemdairmpyiqmq5aoj2uqr7bxhfiezqm4zeuchu@wuplknrtviud>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-3-jiri@resnulli.us>
 <CO1PR11MB5089BDFAF1B498FE9FDDA3FCD6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <3be26dca-3230-4fd6-8421-652f95c72163@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be26dca-3230-4fd6-8421-652f95c72163@intel.com>

Wed, Mar 19, 2025 at 09:21:52AM +0100, przemyslaw.kitszel@intel.com wrote:
>On 3/18/25 23:05, Keller, Jacob E wrote:
>> 
>> 
>> > -----Original Message-----
>> > From: Jiri Pirko <jiri@resnulli.us>
>
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> > @@ -0,0 +1,150 @@
>> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> > +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>> > +
>> > +#include <linux/device/faux.h>
>> > +#include <linux/mlx5/driver.h>
>> > +#include <linux/mlx5/vport.h>
>> > +
>> > +#include "sh_devlink.h"
>> > +
>> > +static LIST_HEAD(shd_list);
>> > +static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
>
>I essentially agree that faux_device could be used as-is, without any
>devlink changes, works for me.
>That does not remove the need to invent the name at some point ;)

What name? Name of faux device? Sure. In case of ice it's probably PCI DSN

>
>we have resolved this in similar manner, that's fine, given my
>understanding that you cannot let faux to dispatch for you, like:
>faux_get_instance(serial_number_equivalent)

Not sure what you are asking TBH.


>
>> > +
>> > +/* This structure represents a shared devlink instance,
>> > + * there is one created for PF group of the same chip.
>> > + */
>> > +struct mlx5_shd {
>> > +	/* Node in shd list */
>> > +	struct list_head list;
>> > +	/* Serial number of the chip */
>> > +	const char *sn;
>> > +	/* List of per-PF dev instances. */
>> > +	struct list_head dev_list;
>> > +	/* Related faux device */
>> > +	struct faux_device *faux_dev;
>> > +};
>> > +
>> 
>> For ice, the equivalent of this would essentially replace ice_adapter I imagine.
>
>or "ice_adapter will be the ice equivalent"

Oh yes, that makes sense.


>
>> 
>> > +static const struct devlink_ops mlx5_shd_ops = {
>
>please double check if there is no crash for:
>$ devlink dev info the/faux/thing

Will do, but why do you think so?


>
>> > +};
>> > +
>> > +static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
>> > +{
>> > +	struct devlink *devlink;
>> > +	struct mlx5_shd *shd;
>> > +
>> > +	devlink = devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd),
>
>sizeof(*shd)

Sure.


>
>I like that you reuse devlink_alloc(), with allocation of priv data,
>that suits also our needs
>
>> > &faux_dev->dev);
>> > +	if (!devlink)
>> > +		return -ENOMEM;
>> > +	shd = devlink_priv(devlink);
>> > +	faux_device_set_drvdata(faux_dev, shd);
>> > +
>> > +	devl_lock(devlink);
>> > +	devl_register(devlink);
>> > +	devl_unlock(devlink);
>> > +	return 0;
>> > +}
>
>[...]
>
>> > +int mlx5_shd_init(struct mlx5_core_dev *dev)
>> > +{
>> > +	u8 *vpd_data __free(kfree) = NULL;
>
>so bad that netdev mainainers discourage __free() :(
>perhaps I should propose higher abstraction wrapper for it
>on April 1st
>
>> > +	struct pci_dev *pdev = dev->pdev;
>> > +	unsigned int vpd_size, kw_len;
>> > +	struct mlx5_shd *shd;
>> > +	const char *sn;
>
>I would extract name retrieval, perhaps mlx5_shd_get_name()?

I had that, did not really make the code nicer :)


>
>> > +	char *end;
>> > +	int start;
>> > +	int err;
>> > +
>> > +	if (!mlx5_core_is_pf(dev))
>> > +		return 0;
>> > +
>> > +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>> > +	if (IS_ERR(vpd_data)) {
>> > +		err = PTR_ERR(vpd_data);
>> > +		return err == -ENODEV ? 0 : err;
>
>what? that means the shared devlink instance is something you will
>work properly without?

Not sure. This is something that should not happen for any existing
device.


>
>> > +	}
>> > +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
>> > &kw_len);
>> > +	if (start < 0) {
>> > +		/* Fall-back to SN for older devices. */
>> > +		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>> > +
>> > PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>> > +		if (start < 0)
>> > +			return -ENOENT;
>> > +	}
>> > +	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> > +	if (!sn)
>> > +		return -ENOMEM;
>> > +	end = strchrnul(sn, ' ');
>> > +	*end = '\0';
>> > +
>> > +	guard(mutex)(&shd_mutex);
>
>guard()() is a no-no too, per "discouraged by netdev maintainers",
>and here I'm on board with discouraging ;)

That's a fight with windmills. It will happen sooner than later anyway.
It is just too conventient. I don't understand why netdev has to have
special treat comparing to the rest of the kernel all the time...


>
>> > +	list_for_each_entry(shd, &shd_list, list) {
>> > +		if (!strcmp(shd->sn, sn)) {
>> > +			kfree(sn);
>> > +			goto found;
>> > +		}
>> > +	}
>> > +	shd = mlx5_shd_create(sn);
>> > +	if (!shd) {
>> > +		kfree(sn);
>> > +		return -ENOMEM;
>> > +	}
>> 
>> How is the faux device kept in memory? I guess its reference counted
>> somewhere?
>
>get_device()/put_device() with faxu_dev->dev as argument
>
>But I don't see that reference being incremented in the list_for_each.
>
>Jiri keeps "the counter" as the implicit observation of shd list size :)
>which is protected by mutex

Yep. Why isn't that enough? I need the list anyway. Plus, I'm using the
list to reference count shd, not the fauxdev. Fauxdev is explicitly
create/destroyed by calling appropriate function. I belive that is the
correct way (maybe the only way?) to instantiate/deinstantiate faux.

