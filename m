Return-Path: <netdev+bounces-230684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F970BED2AE
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8ED11898D16
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A95231A21;
	Sat, 18 Oct 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="uKI+mMVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E7227B9F
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760801778; cv=none; b=UGYdS7a4t1x6yGzBlBQ7z5AtkWrVkfXbdysbTpp4I5v9LWA3xuwK1ayhsrsYUIsopD1f+YTjkw1hh0XJqDegzFaNZBj/nvYRlz3k2MsqtesUeaWig6uJER0qIAD4toyQnez8TM+0tuNhDO9/OfYFgoggoAa0hIsP2QOcU2js3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760801778; c=relaxed/simple;
	bh=HKGMpN/OFBCHOskvCiqGCvOnHaF502mjxLZhN56t/N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKlI60ek9ZPF2WW+0V+wR7D/l2JZyScts3D9gcFUUC5MR/v7xutD1kTnLt2XbmuYV0g9iKjzl+Yet0DY0iky9+ZOcnvM3Bg0FvC5E9rGB0iDkzKJuhIivs2VDMoMAUD5LMpDBLw/7IZDMw5pIzpMb462zMu6Kk3Q/zWLXYG+oFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=uKI+mMVR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-88ec598fa11so428937985a.0
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760801775; x=1761406575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBehRj2J0Fcvnu3LPHoi98PBaamFYlDHjRLa/b4kuk4=;
        b=uKI+mMVR/sBedUVlHRn6dAEFZ32+8T87vAWRw9SxoYURMnqM+TtQBu7U/oTtDeE7cl
         sHZSeuSl7BrMbXXKnLf7CxufIfqprK6w3um6JxEZWMycwGeIEnH6DqMz5gKhgUXc9Nik
         4YL9sIe3X95EHJfjFfoJV7abQa0Eq3aAbaFMbtmG3McuZU4GpPt393sRBrL95v+1HCme
         tN8ItdFVMtlERyrtU+a1nZs2hqD2rELl/S13BLy+8HuymbQGoHrwb6mL72v0+ZEcWORW
         My0kPdg74OFa4Vf3KUry2vaJ6Cov5EXA5RMRTKDYRykix4HjmBlsPmt+WWK9xG3Wzt+9
         ID0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760801775; x=1761406575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBehRj2J0Fcvnu3LPHoi98PBaamFYlDHjRLa/b4kuk4=;
        b=UOwNgh6KoTfYunpkPzQelyriUn7Q8ta5Z9tiD6vGdRCU2JzWqEiy359l+m+mVaavbT
         2dqu9fJAMoN8iXzcRTwDCt+/3oG/PpHKXLsKOLqP3G8RTK3dnnO3gNs/gqWi0N91sB/x
         0X9Y0vqSpQIjPBync8rUX2pfFUlWgv5gCxirVz9n4wofthRvsjAFqKECwjaJp/p9lUHU
         EXVl1LwEW1FhsYPrN7YnrSHvL8zG5bzR4K2JfqrK2jJeVFeJDLF2CTS//1q2+BCgpjcc
         fGDRN5OPpa6fy2w/I0zGmY0vTzUhdyRah2SMh1VeEXbYxcu44ueGWlMCN5oKEZhCBSj8
         2r4A==
X-Forwarded-Encrypted: i=1; AJvYcCUSeGb6VMViQpNzhjkybWWZi/XAUoX0WQN90nN29LWe7/8Q/+E0zLQArq8BX/D2kr6qcEwRX+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5/UTHNfbnIax0nh8Xl+BVeOr5eFak7whNjEQYZqYo+Z+ho5J
	zo4E1eDG3DKeobfGDTnNdynCbjPPnknlOqUWK1x/7QQMQQejqbvoCcH7TUjvjwI1JQ==
X-Gm-Gg: ASbGncvA8PCIV/xrHA1eYHJHAbMDuKKHdRvk0RzsUyMQUifYeXADKraVzOkYzrfWKoW
	NcjHej/IkJPQDsw685rthT3Hw9l6BJopVAOCHlotRvL+/f7QAHdwZZNpeTLPv4xFZqnI7hLj57b
	o+5J884LW7OcdG/WRDiWw+tSUicAPaXDuGG/mPgzF5unWFyt4Rg6vh9MdwdvebxK/2yl1InFyyJ
	DVR9ouVDHmjHIHTnCAmhY9fnIqOIz9O7J5pT9Um7Amu6X5GLxdcDgPTtbwGUhLL9tkrm6l2LM7g
	TIwpe0u43sZa6uiV/NT7IiM8UKN8LVfhywL1CEYyK9Qk8B9zvKQ2VDjws9aLugyVd7SvFmOKmii
	GjErwK0n5dPbTW9jjmXTSQ5wg93/G9mQu/NjfrhIS2g0enOOhBNddHuiAT+6/cZ+qFbNq1Wx3QF
	zXbQ==
X-Google-Smtp-Source: AGHT+IFXbMHvjfgGSrYKRcU1sFFL+GQDsN3U1NlV4sor6nqowwjcMnCgwfLW4KImBzuFI7FutWgzXQ==
X-Received: by 2002:a05:620a:4082:b0:813:3a81:1a49 with SMTP id af79cd13be357-88f0f45255bmr1546091985a.12.1760801775278;
        Sat, 18 Oct 2025 08:36:15 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::a165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cfb57e3csm185096885a.61.2025.10.18.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:36:14 -0700 (PDT)
Date: Sat, 18 Oct 2025 11:36:11 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <6640b191-d25b-4c4e-ac67-144357eb5cc3@rowland.harvard.edu>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
 <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
 <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018172156.69e93897.michal.pecio@gmail.com>

On Sat, Oct 18, 2025 at 05:21:56PM +0200, Michal Pecio wrote:
> Existing r8152-cfgselector and the planned ax88179-cfgselector
> implement the following logic:
> 
> IF a device has particular IDs
>    (same id_table as in the vendor interface driver)
> 
> IF the vendor interface driver is loaded
>    (ensured by loading it together with cfgselector)
> 
> IF the vendor driver supports this device
>    (calls internal vendor driver code)
> 
> THEN select the vendor configuration
> 
> 
> It was a PITA, but I have a working proof of concept for r8152.
> 
> Still missing is automatic reevaluation of configuration choice when
> the vendor driver is loaded after device connection (e.g. by udev).
> Those cfgselectors can do it because it seems that registering a new
> device (but not interface) driver forces reevaluation.

It looks like something else is missing too...

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index d29edc7c616a..eaf21c30eac1 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1119,6 +1119,29 @@ void usb_deregister(struct usb_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(usb_deregister);
>  
> +/**
> + * usb_driver_preferred - check if this is a preferred interface driver
> + * @drv: interface driver to check (device drivers are ignored)
> + * @udev: the device we are looking up a driver for
> + * Context: must be able to sleep
> + *
> + * TODO locking?
> + */
> +bool usb_driver_preferred(struct device_driver *drv, struct usb_device *udev)
> +{
> +	struct usb_driver *usb_drv;
> +
> +	if (is_usb_device_driver(drv))
> +		return false;
> +
> +	usb_drv = to_usb_driver(drv);
> +
> +	return usb_drv->preferred &&
> +		usb_device_match_id(udev, usb_drv->id_table) &&
> +		usb_drv->preferred(udev);
> +}
> +EXPORT_SYMBOL_GPL(usb_driver_preferred);

> diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
> index a48994e11ef3..1923e6f4923b 100644
> --- a/drivers/usb/core/generic.c
> +++ b/drivers/usb/core/generic.c
> @@ -49,11 +49,17 @@ static bool is_uac3_config(struct usb_interface_descriptor *desc)
>  	return desc->bInterfaceProtocol == UAC_VERSION_3;
>  }
>  
> +static int prefer_vendor(struct device_driver *drv, void *data)
> +{
> +	return usb_driver_preferred(drv, data);
> +}
> +
>  int usb_choose_configuration(struct usb_device *udev)
>  {
>  	int i;
>  	int num_configs;
>  	int insufficient_power = 0;
> +	bool class_found = false;
>  	struct usb_host_config *c, *best;
>  	struct usb_device_driver *udriver;
>  
> @@ -169,6 +175,12 @@ int usb_choose_configuration(struct usb_device *udev)
>  #endif
>  		}
>  
> +		/* Check if we have a preferred vendor driver for this config */
> +		else if (bus_for_each_drv(&usb_bus_type, NULL, (void *) udev, prefer_vendor)) {
> +			best = c;
> +			break;
> +		}

How are prefer_vendor() and usb_driver_preferred() supposed to know 
which configuration is being considered?

(Also, is prefer_vendor() really needed?  Can't you just pass 
usb_driver_preferred as the argument to bus_for_each_drv()?  Maybe after 
changing the type of its second argument to void * instead of struct 
usb_device *?)

Alan Stern

