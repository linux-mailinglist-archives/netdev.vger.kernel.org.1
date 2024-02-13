Return-Path: <netdev+bounces-71298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D9852F4D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE37AB20AA3
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9161364C1;
	Tue, 13 Feb 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BHltxfaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B73364DB
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823788; cv=none; b=SFlM86q/SqJBhWSCLMw/6D/+B+9xPx9+1j3iPWQbh87jhjgnMVeh+3WDT+qug3MMHGt1QzhGNUVw8H1+HuLtMQs6BJCXhMnK7GUpPB4DFjdRui9nAfWRyShGGJjW9z1vPoEv7tT3cdeQmNkIRx0KfxCfIfuPJRGIlCAz4ers25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823788; c=relaxed/simple;
	bh=Wbbu8vRd6dUoFUIGkgSvT3wlhAp+E98rQo0MKSfIq88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDU9kv9TxzH7UmyfGtND1Re80MfztjdPVZ8wgz7VTUMLShe0g/oYlaa+1WcMgE5FeB2Gr7JHIj7AW67SCA1gYe4XXtPxRwc8jmgcTSBlLPpulVAxAAJ02JNFpQNtM5zH9OkVtZhCkHT2bX2gp1ccD7Ghowt27gTyxpnnKGroOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BHltxfaq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d107900457so8016681fa.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707823784; x=1708428584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOLKpGa2tRS0E6nd85j3XSyiNZMP4W3BXrx8+I184rE=;
        b=BHltxfaqwXvgGV6jHGg5HKfA81QBNm6CN0kRQzhxyK41S5GUWgdBCGvawbHjT0+j9R
         k1GzC6t1aKhkwD/d82CuBvqG/XFHeip4ywx6XMQO+sjt+lXCV/jEC+62IYEtZwBPEFT1
         6Oz/g402326Ch3P7Ccbsh9xJrhHnLo1Hd2vZ0rrWim81UUqDxQ2blMVBFpWIJxSnEUPe
         EkXY+FaSOFhmMLEgdYKvRtTRBjWAzvcJz+6/iHqAgQJ4Eaq+NX7iLe+mIkEo2x3YD2Qd
         G74MsmKQv7AKLoJB+ytmnKh6AsVw6UmtpFkAQQL/kKHKUd31Gv3JKKugKU8EzLEYkWQW
         uSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823784; x=1708428584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOLKpGa2tRS0E6nd85j3XSyiNZMP4W3BXrx8+I184rE=;
        b=L3cYwglSbcnKJVXBupVSwmYEqLLXi2YUVUsuSy7+7hBFz7R785ZWbMV72NZcOVyivu
         2hFXwLcGqgoP/Cfyb70h60zAwZ4j/G4bSXHp9UDJ99Yvy+nxi0uxYdiIyJc4UbMpYnCW
         F+jQqmCzEPCDutNZy/svSpAon8tzCZ4DgCPhhqOA/v1FFYRS9lu4D8nBtbTPOs2hO1N/
         4coZkBPH95WxeGh45ANU52lCVi3Fuzj/fq1lLDH783Owe3D8F1TDsQUCHfr1FZPZnks+
         lmYK0n6HhqcxnuMZNMvVtI1JVefZaaqVSar6QcSk0v/4XYxML1H1R5vYvULtlOsGZFi7
         Z6nw==
X-Forwarded-Encrypted: i=1; AJvYcCWlrkrQ/TsIAg7XGRE/K8iBZg2R3AT/tWi7ojfvNJqDJoTHL34a/oZIROycRkCQ7EG4v+7ATPcAwAxFDP/PRMFLu2eGJ5m1
X-Gm-Message-State: AOJu0Yy/5o2dIa9rV8lQ5iWFCr9G3UQ297V7mt9PZB8rt+gnYHpQXaju
	5ci5BViCpb1ysuLL36RU7dhVpO5zgUNmqTDxv9Uy7pkoKcYAzHBvFJTcZ/Z4ozg=
X-Google-Smtp-Source: AGHT+IHaykZ6piYnH9ORlAdb7q49pdyzDZJicVeq/kX5x59ewYxcvJElUrBPPt8xCWVX09s5lVrUGw==
X-Received: by 2002:a2e:b0d7:0:b0:2d0:cc80:dc94 with SMTP id g23-20020a2eb0d7000000b002d0cc80dc94mr5820546ljl.19.1707823784260;
        Tue, 13 Feb 2024 03:29:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEwI42cyBgO9bl04zzXCtXzhH8Fg8mVv62uPoeIy4mUvSUcvqerKLrNL9gwFjb+qVqj5jj4lvZY+ArEU9XK4FTu8vJ/ha+TLX0EZtpxOrnuJThl9CgGwXfVNu/K7zI2RXSNsRQB6tZYIXmSIviIZVFsAnSRNfw0yTSxlmIyD6OKy2GqFVuFl29I1SUk/Rf0xOoPcHHreAx7O7LmeLGLn+/Q7ApYzSYqY6dbMTQdEVCgkTDVCRwaPSr4/bHyL3lshYLk2AP4+E9Q19q9DgLLQS92SeX3hFYDlFOB8TCtl9Z8regl5s8DSm0eaIgvDDhWubU52CRAZo0w5sIbyuh9jcPI/SEYGD38QAH+uAyUOEYt/TmYr3CzmQmGJDQk/KD00JeMisYG2FoeYrlxrLU3M+vHz7T
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p16-20020adfcc90000000b0033b2497fdaesm9258714wrj.95.2024.02.13.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:29:43 -0800 (PST)
Date: Tue, 13 Feb 2024 12:29:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 07/15] ice: add auxiliary device sfnum attribute
Message-ID: <ZctSpPamhrlF4ILg@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-8-michal.swiatkowski@linux.intel.com>
 <ZcsvYt4-f_MHT3QC@nanopsycho>
 <Zcs8LsRrbOfUdIL7@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcs8LsRrbOfUdIL7@mev-dev>

Tue, Feb 13, 2024 at 10:53:50AM CET, michal.swiatkowski@linux.intel.com wrote:
>On Tue, Feb 13, 2024 at 09:59:14AM +0100, Jiri Pirko wrote:
>> Tue, Feb 13, 2024 at 08:27:16AM CET, michal.swiatkowski@linux.intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >
>> >Add read only sysfs attribute for each auxiliary subfunction
>> >device. This attribute is needed for orchestration layer
>> >to distinguish SF devices from each other since there is no
>> >native devlink mechanism to represent the connection between
>> >devlink instance and the devlink port created for the port
>> >representor.
>> >
>> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >---
>> > drivers/net/ethernet/intel/ice/ice_sf_eth.c | 31 +++++++++++++++++++++
>> > 1 file changed, 31 insertions(+)
>> >
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>> >index ab90db52a8fc..abee733710a5 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>> >+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>> >@@ -224,6 +224,36 @@ static void ice_sf_dev_release(struct device *device)
>> > 	kfree(sf_dev);
>> > }
>> > 
>> >+static ssize_t
>> >+sfnum_show(struct device *dev, struct device_attribute *attr, char *buf)
>> >+{
>> >+	struct devlink_port_attrs *attrs;
>> >+	struct auxiliary_device *adev;
>> >+	struct ice_sf_dev *sf_dev;
>> >+
>> >+	adev = to_auxiliary_dev(dev);
>> >+	sf_dev = ice_adev_to_sf_dev(adev);
>> >+	attrs = &sf_dev->dyn_port->devlink_port.attrs;
>> >+
>> >+	return sysfs_emit(buf, "%u\n", attrs->pci_sf.sf);
>> >+}
>> >+
>> >+static DEVICE_ATTR_RO(sfnum);
>> >+
>> >+static struct attribute *ice_sf_device_attrs[] = {
>> >+	&dev_attr_sfnum.attr,
>> >+	NULL,
>> >+};
>> >+
>> >+static const struct attribute_group ice_sf_attr_group = {
>> >+	.attrs = ice_sf_device_attrs,
>> >+};
>> >+
>> >+static const struct attribute_group *ice_sf_attr_groups[2] = {
>> >+	&ice_sf_attr_group,
>> >+	NULL
>> >+};
>> >+
>> > /**
>> >  * ice_sf_eth_activate - Activate Ethernet subfunction port
>> >  * @dyn_port: the dynamic port instance for this subfunction
>> >@@ -262,6 +292,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
>> > 	sf_dev->dyn_port = dyn_port;
>> > 	sf_dev->adev.id = id;
>> > 	sf_dev->adev.name = "sf";
>> >+	sf_dev->adev.dev.groups = ice_sf_attr_groups;
>> 
>> Ugh. Custom driver sysfs files like this are always very questionable.
>> Don't do that please. If you need to expose sfnum, please think about
>> some common way. Why exactly you need to expose it?
>
>Uh, hard question. I will drop it and check if it still needed to expose
>the sfnum, probably no, as I have never used this sysfs during testing.
>
>Should devlink be used for it?

sfnum is exposed over devlink on the port representor. If you need to
expose it on the actual SF, we have to figure it out. But again, why?


>
>Thanks
>
>> 
>> pw-bot: cr
>> 
>> 
>> > 	sf_dev->adev.dev.release = ice_sf_dev_release;
>> > 	sf_dev->adev.dev.parent = &pdev->dev;
>> > 
>> >-- 
>> >2.42.0
>> >
>> >

