Return-Path: <netdev+bounces-71625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB73854434
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C451C210C3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1D613C;
	Wed, 14 Feb 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XesXY7tn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7306FA8
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900339; cv=none; b=oft8XGjZNEtAYWH7+zlqMBaPI6O0X9zsRn9eeEuNfi4Yvb0S5I19tfX8H+NKM1kaQ9oPtew549xmvvJU+wkq5myM/+Dysl+ppE96auxRZUy7ViPDYZT8AX00UPp6Bkbqmyfzs7xJk5zi/YoN9KtsIc+IhVnw5SCE9dD3L3ECIwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900339; c=relaxed/simple;
	bh=bEPaXtq7wakXl60X5wdXiMr7CvRCQQUpZp0VD6wn07Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L10+O66tY1UDAfAo0UFmQoKWMMStmz3veeAt6YT5aw5gcP6IyKNKj7dJZKmq09sfkrWpnO4BnO9HkvfpUXnrE/mRQdL4mU0pJ5FP8JrLgFncITnEUOpDRLHRADwfCeSvcOhlJUg1w1nN3yhY755wEM87g7rqdcwiUevR3k4+0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XesXY7tn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso792738566b.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 00:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707900334; x=1708505134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvVZfskenABlsHEG7R+cYwzn8/7MBLlR+4aluprlmm4=;
        b=XesXY7tnJR+oCq4BU5J0wrs2OWPwXmAW5Qnlbov+gua3i1PLUYA78rzYPS+Qv80Ndy
         XnbS/a5LV2fmEEw25n2IKfPGRPQoOfxSLGI2EF6QHilTXXZSJTQkQTYA8t+jR2dnR8Q6
         bqHtmqgj9zdFh1czq3DwbJhtqoWjor7bm32IDM2B1aX1IDzWmRMMn0usW387nuq5bNvO
         8iebSay9FR0g8LbycCYp7XVxujW6BQ4ayp4y7aqu0MHUTKqZXz7FhPcCLt5YFBG/bnDm
         IuhHXEFu9guaDEwJWTmJow0ajOf95V6zHAFdVQRNaz3/jWXQJdZ00taV44P7jMMFIJCx
         AqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900334; x=1708505134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvVZfskenABlsHEG7R+cYwzn8/7MBLlR+4aluprlmm4=;
        b=rwFdVeKO2qvjX7ZYMIwCWUB4pyplSEvp+ycD+rLlNuWL32zSxFHfGkECBdzOcrhiho
         DyBgGvyo6i6ZbSGgbKb2P5vkRoZL0SequjK0PRi9+245vRw/kMKb65I8m3JN566h5mt5
         pld2Rx7g9+CWvrqQa+JttS9l4yQ4XLRtglEh4VIZDxOFMevOZw1bHNh3V1Z/1yyK4Yoq
         b5B8DT6qhz/QrR62RESEAM/+/nOaEt+58EYopg86zH33gMMzAgnG6TSOZhagYmIGBh6l
         uiP6LLnFFtj5sYgxuZCC5X7dnUNmvZuYNgYBRzmAWdy/zcRsJpfatBFKsVSMoDV0B3KR
         HbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXXgXdoJn2aSDwWu66UlzaYXJdyraxREn2hEwOsoAEKtB53mhpzdzOrzSyDy/7WZbGxsOv3TA3uj58vk9MQFcJFJbsl6wo
X-Gm-Message-State: AOJu0Ywfje5PFqGgDhkIqCZPhLhtJVcGDrchVOUY9dindWWh+e8x10Rv
	MDa8cca6UZ0pAMtfgg8d/DcVdCH3Nspx9Z3NsuwalvL9n5t0H2uzbxXPDV3dG0o=
X-Google-Smtp-Source: AGHT+IFcEAOk9jLAoB8ej5kYTb9E5YsOIJ4weVq3TJ/Ub5DTXuJe90w5RDNz63pZ5/s0pV5uBhQZdA==
X-Received: by 2002:a17:906:acf:b0:a3d:2f12:78ee with SMTP id z15-20020a1709060acf00b00a3d2f1278eemr1311197ejf.50.1707900333592;
        Wed, 14 Feb 2024 00:45:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5NGii4MuCSyEEPc8TxM9aqkORnM5iMtZJJkRxbSuJTnaDix2LMOFiFnEXsHPQBr+oMtg+rOVTrzhjwdY050hG8nLcWyjIQh2iRXl2mYdYCkAJd8/OuDGZYKM12CC9o9GKR0CMs+mXpYSbvStxp8vOdvchoUWwSZ7mdOWb6CGWJN+f4DUKKHT6dTKdijtqaFqXHYRBZya2SnB/H7vmkSDNp302ObiB+BpA5dUPbLpKo9dd+RTUS4YbnZMUqoEoXmhR1B1f8CUm8K8SAQhdxAGDrdQs9gth/re7R9BN+pTXXS0/Ll4yOkw0K3XMGo7eqtFfKjuQ2vvM/Xt2rJcQcMM+kkN0H+n4DplysN9kVKfIhxb4Q8KxDrimkNhaCZQFrs2rr5xRCUJK6v1BQFZ0C1OpPv25tViw514KJno=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id vv3-20020a170907a68300b00a3d29f0afeasm757863ejc.2.2024.02.14.00.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:45:32 -0800 (PST)
Date: Wed, 14 Feb 2024 09:45:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.kubiak@intel.com, maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com, przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com, pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 07/15] ice: add auxiliary device sfnum attribute
Message-ID: <Zcx9qWyr4IXn8rXa@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-8-michal.swiatkowski@linux.intel.com>
 <ZcsvYt4-f_MHT3QC@nanopsycho>
 <Zcs8LsRrbOfUdIL7@mev-dev>
 <ZctSpPamhrlF4ILg@nanopsycho>
 <ZctYm9CVJzV+uxip@mev-dev>
 <6b62fe60-b1e2-49e0-b374-775ef42d07dd@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b62fe60-b1e2-49e0-b374-775ef42d07dd@intel.com>

Tue, Feb 13, 2024 at 11:04:00PM CET, jacob.e.keller@intel.com wrote:
>
>
>On 2/13/2024 3:55 AM, Michal Swiatkowski wrote:
>> On Tue, Feb 13, 2024 at 12:29:40PM +0100, Jiri Pirko wrote:
>>> Tue, Feb 13, 2024 at 10:53:50AM CET, michal.swiatkowski@linux.intel.com wrote:
>>>> On Tue, Feb 13, 2024 at 09:59:14AM +0100, Jiri Pirko wrote:
>>>>> Tue, Feb 13, 2024 at 08:27:16AM CET, michal.swiatkowski@linux.intel.com wrote:
>>>>>> From: Piotr Raczynski <piotr.raczynski@intel.com>
>>>>>>
>>>>>> Add read only sysfs attribute for each auxiliary subfunction
>>>>>> device. This attribute is needed for orchestration layer
>>>>>> to distinguish SF devices from each other since there is no
>>>>>> native devlink mechanism to represent the connection between
>>>>>> devlink instance and the devlink port created for the port
>>>>>> representor.
>>>>>>
>>>>>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>>>>>> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>>>>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>>>> ---
>>>>>> drivers/net/ethernet/intel/ice/ice_sf_eth.c | 31 +++++++++++++++++++++
>>>>>> 1 file changed, 31 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>>>>>> index ab90db52a8fc..abee733710a5 100644
>>>>>> --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>>>>>> @@ -224,6 +224,36 @@ static void ice_sf_dev_release(struct device *device)
>>>>>> 	kfree(sf_dev);
>>>>>> }
>>>>>>
>>>>>> +static ssize_t
>>>>>> +sfnum_show(struct device *dev, struct device_attribute *attr, char *buf)
>>>>>> +{
>>>>>> +	struct devlink_port_attrs *attrs;
>>>>>> +	struct auxiliary_device *adev;
>>>>>> +	struct ice_sf_dev *sf_dev;
>>>>>> +
>>>>>> +	adev = to_auxiliary_dev(dev);
>>>>>> +	sf_dev = ice_adev_to_sf_dev(adev);
>>>>>> +	attrs = &sf_dev->dyn_port->devlink_port.attrs;
>>>>>> +
>>>>>> +	return sysfs_emit(buf, "%u\n", attrs->pci_sf.sf);
>>>>>> +}
>>>>>> +
>>>>>> +static DEVICE_ATTR_RO(sfnum);
>>>>>> +
>>>>>> +static struct attribute *ice_sf_device_attrs[] = {
>>>>>> +	&dev_attr_sfnum.attr,
>>>>>> +	NULL,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct attribute_group ice_sf_attr_group = {
>>>>>> +	.attrs = ice_sf_device_attrs,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct attribute_group *ice_sf_attr_groups[2] = {
>>>>>> +	&ice_sf_attr_group,
>>>>>> +	NULL
>>>>>> +};
>>>>>> +
>>>>>> /**
>>>>>>  * ice_sf_eth_activate - Activate Ethernet subfunction port
>>>>>>  * @dyn_port: the dynamic port instance for this subfunction
>>>>>> @@ -262,6 +292,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
>>>>>> 	sf_dev->dyn_port = dyn_port;
>>>>>> 	sf_dev->adev.id = id;
>>>>>> 	sf_dev->adev.name = "sf";
>>>>>> +	sf_dev->adev.dev.groups = ice_sf_attr_groups;
>>>>>
>>>>> Ugh. Custom driver sysfs files like this are always very questionable.
>>>>> Don't do that please. If you need to expose sfnum, please think about
>>>>> some common way. Why exactly you need to expose it?
>>>>
>>>> Uh, hard question. I will drop it and check if it still needed to expose
>>>> the sfnum, probably no, as I have never used this sysfs during testing.
>>>>
>>>> Should devlink be used for it?
>>>
>>> sfnum is exposed over devlink on the port representor. If you need to
>>> expose it on the actual SF, we have to figure it out. But again, why?
>>>
>>>
>
>I vaguely remember some internal discussion about orchestration software
>wanting to know which subfunction was associated with which auxiliary
>device. However, I think a much better solution would be to expose the
>auxiliary device ID out of devlink_port instead, through devlink port.
>
>I can't find any notes on this and it was quite some time ago so maybe
>things have changed.
>
>If we enable support for user-space configurable sfnum, then we can just
>have the orchestration software pick its sfnum (or check the netlink
>return value from the port add), so probably this is not that useful.

This is already solved by nested devlink. When you properly call
devl_port_fn_devlink_set(), you link the SF devlink instance with the
eswitch port representor. Then the user sees:

$ devlink port
pci/0000:08:00.1/98304: type eth netdev eth4 flavour pcisf controller 0 pfnum 1 sfnum 109 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state active opstate attached roce enable
      nested_devlink:
        auxiliary/mlx5_core.sf.2



