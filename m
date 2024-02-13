Return-Path: <netdev+bounces-71226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B7852BCF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D002285844
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB81B598;
	Tue, 13 Feb 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="b+4H2k5x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF71B7E2
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814762; cv=none; b=HyAskRdQRHwR0TBH0RbfzqxYJiqBrjRcI+rImcH9P/kHmyEO3UC4KCA0hWrCf6BwHCc3uVMGL2DlDLsbFOn4dkbzzMR4Qrbuvho6+VyE39Ea1bn0BIjxF1tlI5S+5a6HspKrbwZXSA9DOBbJClgHSv6v4UpItvtZrutx04PLePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814762; c=relaxed/simple;
	bh=9qVHZPB+NqFBVQo5ogWkd+6wAFCE5O4H8xyA36m/Fnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJsY9ZEcHPi1APpUOKBfRp6Z2t9npIrTEPNBx5WVO+xyj2XeQkklIzfGOl5piQ5wOYmq3atU+SW+A++A4Ez9AjOhGXBovp1LfX35TzwHIbnHb0nZIUf/b6tbmO5pyEKVkmcS99e4PkmcBaDWg7O1O+2XspLDNtv56z4Af6BnTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=b+4H2k5x; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5116063585aso5188116e87.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707814757; x=1708419557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEbY3U8Rg7pv2qjZXnKxmOIcGJvtbWXqdL3oXqDr1Dk=;
        b=b+4H2k5xrI9cZW5XjLKVOJK0c9M9k7gAh1CQtufeFEgHlschBnY7xnVDjjKUdrZYet
         Ufc/elYvc42u7HGDa+cUQZ52hOol8Xr3q0rRu2qJKefrXOEHJnJLCcGP1F9xX3cV+5Wk
         TV8mzD+0F6XuLI2fMCan0RB3Gd/LsM6uql5dvdxdl+QwAJDobrM1uG2yst5un/6JBdvs
         OGd+y0lOXSdhJIvYCTQvoX1OkplBLokhOrT6wiGH0bpY8YvNYBvViEUrupF6PfCZh6Y1
         j0C1UG+t/W7AsXyvSkqsNCbTOp92lNFq1Lx5O6S5nQS2GsByC3/OC8p+K5yL/ej0B/GU
         7HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814757; x=1708419557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEbY3U8Rg7pv2qjZXnKxmOIcGJvtbWXqdL3oXqDr1Dk=;
        b=XQIvFE/h5nX8C6oLFdTNyuxOsA5irv2ThQyEx/ZXQAkWzIWPStcZ9VtFiMyrILdRIh
         0B6FIfcVHMmqPLdB867Twqyj62g4JlUeus7wUxD2BZ5vO3uwmsBvGaLaLzkVg1imeVM/
         d5xRIVxXteCYJt8OfS7euIZiXwJ+2ejN8v17V/6KrrRvRT5dEPYZ8TDYoaHWHxzWLsP3
         ePj3ekhaSIU5fT0DFMMJYS2RCyfOL33RpBthLX1oQd1Y6B08bqqy6DG5+4SC/2c/vbaf
         B9xR8yH33skwO8bqFGE7HQrz8vMPJKwaYeuNe+bn6cNu/BXfHpgnDiQIz88hJXeMktl1
         FEZQ==
X-Gm-Message-State: AOJu0YyXiXMyUnwb0zzr0jCfmK/vF+u5T+6qsNYyxDUSZIGl0j90dX8n
	Kwhmg3ukhZHPzeL6ws8/EhCF/ki9O1Z6OR8+sA6gbbAD5w4+ABCHq8f0oJY9PaWVdeeoAsaEdAx
	hIwk=
X-Google-Smtp-Source: AGHT+IFl8ozD91h/S32cyeg8lvKDyRacKzrqeV7wPqcANzStS/Sbt2pwSb8cuBqejSOiexv2qDtk+A==
X-Received: by 2002:ac2:5dc1:0:b0:511:4752:fbb8 with SMTP id x1-20020ac25dc1000000b005114752fbb8mr5432195lfq.37.1707814757540;
        Tue, 13 Feb 2024 00:59:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8N0K9MBnS9vwHToohfs2aDlonZa+z+URL7qg03wnxDfqj6deGXhN0ZwvhrngXQfCj40QT3jEoCes/oJXMDPpZXltc8RVyIQCjY1EVmTuawxHpuTQkwq/qgAXcbrYHdyRr1WOCpu6xe2lj7FV/JkTmjBtG/TM7c3z+hSQYx6IpwHnMyaQp+2P1zDJj3H5hgoEWAJYMn2s/Q4kNPN6xnzl3AGRFrYS6UHMjYaELhlwn/u9s0HaPlDGVjFeuIxBRikxZN0VDEquqZWXyML1lv5XoJWTo7Ak9A3mI1WqNDTi2foArTDJX+Ds8Gr7a/dhbaVwlAHMNuURxZk3B6j0ufwySpDv0fpxqUUY233KQtd/2KF6f35UVNGyqJMVsHUAzIvM5HIBQHxyw75HfaIFpO3aM5Ktg
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bi25-20020a05600c3d9900b00411ccc97bf5sm94246wmb.47.2024.02.13.00.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:59:17 -0800 (PST)
Date: Tue, 13 Feb 2024 09:59:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 07/15] ice: add auxiliary device sfnum attribute
Message-ID: <ZcsvYt4-f_MHT3QC@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-8-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213072724.77275-8-michal.swiatkowski@linux.intel.com>

Tue, Feb 13, 2024 at 08:27:16AM CET, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Add read only sysfs attribute for each auxiliary subfunction
>device. This attribute is needed for orchestration layer
>to distinguish SF devices from each other since there is no
>native devlink mechanism to represent the connection between
>devlink instance and the devlink port created for the port
>representor.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_sf_eth.c | 31 +++++++++++++++++++++
> 1 file changed, 31 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>index ab90db52a8fc..abee733710a5 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>@@ -224,6 +224,36 @@ static void ice_sf_dev_release(struct device *device)
> 	kfree(sf_dev);
> }
> 
>+static ssize_t
>+sfnum_show(struct device *dev, struct device_attribute *attr, char *buf)
>+{
>+	struct devlink_port_attrs *attrs;
>+	struct auxiliary_device *adev;
>+	struct ice_sf_dev *sf_dev;
>+
>+	adev = to_auxiliary_dev(dev);
>+	sf_dev = ice_adev_to_sf_dev(adev);
>+	attrs = &sf_dev->dyn_port->devlink_port.attrs;
>+
>+	return sysfs_emit(buf, "%u\n", attrs->pci_sf.sf);
>+}
>+
>+static DEVICE_ATTR_RO(sfnum);
>+
>+static struct attribute *ice_sf_device_attrs[] = {
>+	&dev_attr_sfnum.attr,
>+	NULL,
>+};
>+
>+static const struct attribute_group ice_sf_attr_group = {
>+	.attrs = ice_sf_device_attrs,
>+};
>+
>+static const struct attribute_group *ice_sf_attr_groups[2] = {
>+	&ice_sf_attr_group,
>+	NULL
>+};
>+
> /**
>  * ice_sf_eth_activate - Activate Ethernet subfunction port
>  * @dyn_port: the dynamic port instance for this subfunction
>@@ -262,6 +292,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
> 	sf_dev->dyn_port = dyn_port;
> 	sf_dev->adev.id = id;
> 	sf_dev->adev.name = "sf";
>+	sf_dev->adev.dev.groups = ice_sf_attr_groups;

Ugh. Custom driver sysfs files like this are always very questionable.
Don't do that please. If you need to expose sfnum, please think about
some common way. Why exactly you need to expose it?

pw-bot: cr


> 	sf_dev->adev.dev.release = ice_sf_dev_release;
> 	sf_dev->adev.dev.parent = &pdev->dev;
> 
>-- 
>2.42.0
>
>

