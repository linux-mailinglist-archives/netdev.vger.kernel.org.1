Return-Path: <netdev+bounces-71324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21624852FA2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AA91F21526
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334D13717C;
	Tue, 13 Feb 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="A+zYgRTp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDD53370
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824111; cv=none; b=rVM0ZNgqzAyfZLtIPVNpYb56jgi7RdCE9TtkxYvK+LAX9KAXhSfVIBmsGl5qtcPM/RSMg8O2rg0Dg3nOiTK0ZKPdSKidJNzgb5GNnN9g7RPWPgBSHz8hX5HmEDV4oS3Yl9ZbshE4g9DKo0SFvclvewRn6ijmpJ1LLsnuEZfenEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824111; c=relaxed/simple;
	bh=dCPKjR7CL+Jaz/gMx80h4klJP/j0fNadXzskc1lVmwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca/2s3svUH34hX9krjHwj39deAAzZeWClMUtCgbIFSqEN6MBbqzw1GUXsLdUY6nJr7MDfsPB4WPZvEBlAOk9SeqUW09qP3iaFckNXacviAOuBDSK1221AZ0w0w17xyVIbAKdW5XaZKp6VuXp4xT5zzWJ8J+TdOj7pjKHM7NUfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=A+zYgRTp; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0aabed735so55107411fa.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707824107; x=1708428907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ8bp23+ggv8wr3fBlwZDd44tUu1TI0wSokojBTeNU8=;
        b=A+zYgRTpA6CxFoLNSv0Jtscvk/UjHuhb7hmJbPp3ttWN6KqnDZC7ZDmE/V33hxhrZJ
         te/jQVHBZsN2mgqXVl04RgOum1z3oIiFkjx22Qt9Dsck4exDgiS4DrqjX+DdWYRImP8m
         9aPfdIMwnJtBTJXyv1qAxjq9p/dfBsz4H6p2dBPUwNwAsb4d9drET3AjC03ON1W20qrI
         CWuD38A6QFrvIyCA2az3Jevz3o9VM63vPIrc0UMF7J9KwW88cz6gwXCk5FnVfnYfmHL1
         eMmvrwgrR8gAVsG8DI9VQ3Q9Q9yIRAgjfWw8s3JeOt0If0O8x0hwYS6agHJGXl7v6qRX
         cQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707824107; x=1708428907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ8bp23+ggv8wr3fBlwZDd44tUu1TI0wSokojBTeNU8=;
        b=RYIkzYoGezm6wn9uNIk8sR0DrJPNZA2TwpFVeaCL1st1fCf2si4mlAanOqKK9oAEiv
         +XdZXVHP0rd77nRZPLQDtKmkXNhkbwfZQTc3subuv9aKgcyoCfA67ond5uubUjqSofLa
         jyXYOXxyU/qLqQCokMQReNYmy5f17hpkLy0PCt+8R6RjF25bs6otjpD/Z7L+KRLUwuVF
         FoCu+0dc/Xdfhy83mZd5GxAG/83hq5s70a2VdNSanNkSyW//p60f88YTF8pDUhFaenDV
         ZeLYY3S5ZsEo4+TpxzhM1sqBdwTaflWvBHkz1TdbydBRXMtflNM1umtrypisWdbX8QHD
         3TJA==
X-Forwarded-Encrypted: i=1; AJvYcCU7bO3DPhffFAjtX8uzj01sGwEj2hF57+KTBc/dNcMs+s9jg57O3/xWDw2Yh/vIRwgUap8MqiPAfkRhdjZ0yd7cePS1fG3P
X-Gm-Message-State: AOJu0YxrYPqds7nLaEgSY1Vjg1julYGuru5TB4O5+mQ2cItn6Q/HBkqC
	8jUoxaF1AjqQzJxLbO4XRTccaBWCn9DJ12jhqStvifJCjBDsNOVe4CKWqpuCXuQ=
X-Google-Smtp-Source: AGHT+IGZNa4xV9rDYQSuFFlBbPC6+OB2Cxc6GrXsRPziFgnG3taFMBKsuDpM/LyVZs/3XMa8oKuWPg==
X-Received: by 2002:a2e:7d03:0:b0:2d0:e666:5b4d with SMTP id y3-20020a2e7d03000000b002d0e6665b4dmr6816611ljc.21.1707824106579;
        Tue, 13 Feb 2024 03:35:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUwBsGYhH5jC4Cf+AVJ4WELV1Q/TjcJnUZUT7GClfYev4BcDvOGRziDsBQPtWlEuFhQqpbJezZjRumdeZTZKWJl0IfQjMvMucXw8BpGbXWoeTxW2oxfSoziG69Jl3VK0rSxftDGOzgMlsTqekZ6BsJbH3ag81Pu7lihsp2n5K+xSXZ/rX1BVj+yl253CSB6UE2sn/7zG6wEVCsdswJI7LJ2NTHdGC+MJfkFsPLtNHoubvQTOJcIwps5bTyv1A7BBQwOpORY0maPvLmkia9sSr2Z9UlLc6C2oJ4F5hqjOHOMek4cUuM2ahyfW8jirx7z1nuRejPB5tV0ySAFzXdKME+kaTgpwSHfCE0CDLPf0C/28jvhmw84hNrIn5f1cF8GEZXnvNebZWsMEQMrZUPHBxzsf4irCnRUxwbG84OAHUMj80QIBKU1cYPhHCU/VnqyTLSuehAskci8weaY1KmfL3zBYJzt0BkutVA9GEkHBI4BySdiiCE
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b004117e45f12esm3640188wmq.22.2024.02.13.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:35:06 -0800 (PST)
Date: Tue, 13 Feb 2024 12:35:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [iwl-next v1 6/7] ice: enable_rdma devlink param
Message-ID: <ZctT5kBdbjcxygQT@nanopsycho>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
 <20240213073509.77622-7-michal.swiatkowski@linux.intel.com>
 <ZcsxRRrVvnhjLxn3@nanopsycho>
 <Zcs9XeZmd2E1IHKs@mev-dev>
 <bb501538-29d5-4930-97b6-1c02f1b7ecba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb501538-29d5-4930-97b6-1c02f1b7ecba@intel.com>

Tue, Feb 13, 2024 at 11:19:49AM CET, wojciech.drewek@intel.com wrote:
>
>
>On 13.02.2024 10:58, Michal Swiatkowski wrote:
>> On Tue, Feb 13, 2024 at 10:07:17AM +0100, Jiri Pirko wrote:
>>> Tue, Feb 13, 2024 at 08:35:08AM CET, michal.swiatkowski@linux.intel.com wrote:
>>>> Implement enable_rdma devlink parameter to allow user to turn RDMA
>>>> feature on and off.
>>>>
>>>> It is useful when there is no enough interrupts and user doesn't need
>>>> RDMA feature.
>>>>
>>>> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
>>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>> ---
>>>> drivers/net/ethernet/intel/ice/ice_devlink.c | 32 ++++++++++++++++++--
>>>> drivers/net/ethernet/intel/ice/ice_lib.c     |  8 ++++-
>>>> drivers/net/ethernet/intel/ice/ice_main.c    | 18 +++++------
>>>> 3 files changed, 45 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>>>> index b82ff9556a4b..4f048268db72 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>>>> @@ -1675,6 +1675,19 @@ ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
>>>> 	return 0;
>>>> }
>>>>
>>>> +static int ice_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
>>>> +					    union devlink_param_value val,
>>>> +					    struct netlink_ext_ack *extack)
>>>> +{
>>>> +	struct ice_pf *pf = devlink_priv(devlink);
>>>> +	bool new_state = val.vbool;
>>>> +
>>>> +	if (new_state && !test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> static const struct devlink_param ice_devlink_params[] = {
>>>> 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>>>> 			      ice_devlink_enable_roce_get,
>>>> @@ -1700,6 +1713,8 @@ static const struct devlink_param ice_devlink_params[] = {
>>>> 			      ice_devlink_msix_min_pf_get,
>>>> 			      ice_devlink_msix_min_pf_set,
>>>> 			      ice_devlink_msix_min_pf_validate),
>>>> +	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>>>> +			      NULL, NULL, ice_devlink_enable_rdma_validate),
>>>> };
>>>>
>>>> static void ice_devlink_free(void *devlink_ptr)
>>>> @@ -1776,9 +1791,22 @@ ice_devlink_set_switch_id(struct ice_pf *pf, struct netdev_phys_item_id *ppid)
>>>> int ice_devlink_register_params(struct ice_pf *pf)
>>>> {
>>>> 	struct devlink *devlink = priv_to_devlink(pf);
>>>> +	union devlink_param_value value;
>>>> +	int err;
>>>> +
>>>> +	err = devlink_params_register(devlink, ice_devlink_params,
>>>
>>> Interesting, can't you just take the lock before this and call
>>> devl_params_register()?
>>>
>> I mess up a locking here and also in subfunction patchset. I will follow
>> you suggestion and take lock for whole init/cleanup. Thanks.
>> 
>>> Moreover, could you please fix your init/cleanup paths for hold devlink
>>> instance lock the whole time?
>>>
>> You right, I will prepare patch for it.
>
>I think my patch implements your suggestion Jiri:
>https://lore.kernel.org/netdev/20240212211202.1051990-5-anthony.l.nguyen@intel.com/

This patch is based on the one in your link apparently. I think it is
incomplete. Idk


>
>> 
>>>
>>> pw-bot: cr
>>>
>>>
>>>> +				      ARRAY_SIZE(ice_devlink_params));
>>>> +	if (err)
>>>> +		return err;
>>>>
>>>> -	return devlink_params_register(devlink, ice_devlink_params,
>>>> -				       ARRAY_SIZE(ice_devlink_params));
>>>> +	devl_lock(devlink);
>>>> +	value.vbool = test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>>>> +	devl_param_driverinit_value_set(devlink,
>>>> +					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
>>>> +					value);
>>>> +	devl_unlock(devlink);
>>>> +
>>>> +	return 0;
>>>> }
>>>>
>>>> void ice_devlink_unregister_params(struct ice_pf *pf)
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>>>> index a30d2d2b51c1..4d5c3d699044 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>>>> @@ -829,7 +829,13 @@ bool ice_is_safe_mode(struct ice_pf *pf)
>>>>  */
>>>> bool ice_is_rdma_ena(struct ice_pf *pf)
>>>> {
>>>> -	return test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>>>> +	union devlink_param_value value;
>>>> +	int err;
>>>> +
>>>> +	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
>>>> +					      DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
>>>> +					      &value);
>>>> +	return err ? false : value.vbool;
>>>> }
>>>>
>>>> /**
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> index 824732f16112..4dd59d888ec7 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> @@ -5177,23 +5177,21 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>>>> 	if (err)
>>>> 		goto err_init;
>>>>
>>>> +	err = ice_init_devlink(pf);
>>>> +	if (err)
>>>> +		goto err_init_devlink;
>>>> +
>>>> 	devl_lock(priv_to_devlink(pf));
>>>> 	err = ice_load(pf);
>>>> 	devl_unlock(priv_to_devlink(pf));
>>>> 	if (err)
>>>> 		goto err_load;
>>>>
>>>> -	err = ice_init_devlink(pf);
>>>> -	if (err)
>>>> -		goto err_init_devlink;
>>>> -
>>>> 	return 0;
>>>>
>>>> -err_init_devlink:
>>>> -	devl_lock(priv_to_devlink(pf));
>>>> -	ice_unload(pf);
>>>> -	devl_unlock(priv_to_devlink(pf));
>>>> err_load:
>>>> +	ice_deinit_devlink(pf);
>>>> +err_init_devlink:
>>>> 	ice_deinit(pf);
>>>> err_init:
>>>> 	pci_disable_device(pdev);
>>>> @@ -5290,12 +5288,12 @@ static void ice_remove(struct pci_dev *pdev)
>>>> 	if (!ice_is_safe_mode(pf))
>>>> 		ice_remove_arfs(pf);
>>>>
>>>> -	ice_deinit_devlink(pf);
>>>> -
>>>> 	devl_lock(priv_to_devlink(pf));
>>>> 	ice_unload(pf);
>>>> 	devl_unlock(priv_to_devlink(pf));
>>>>
>>>> +	ice_deinit_devlink(pf);
>>>> +
>>>> 	ice_deinit(pf);
>>>> 	ice_vsi_release_all(pf);
>>>>
>>>> -- 
>>>> 2.42.0
>>>>
>>>>

