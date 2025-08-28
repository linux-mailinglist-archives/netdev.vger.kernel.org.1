Return-Path: <netdev+bounces-217798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7548B39DB9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5C33B7B88
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4F30F958;
	Thu, 28 Aug 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3B09t/G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203730C604
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385375; cv=none; b=XrfoVi6cIftloxh3FHf3+wegzCxVltCxfiz/Kg28gdZ66prdCKxAv7bUVTSPHzcYxnCUYXPOAJElg8pvVWj03C4U0gOD//QlYpIIuJcv9f+gyvWjeg0aFmYzUglnvhzp6AWNLFkZZPHX8M+O2/5tiHpoNE6vfj7eIUwy1jKb7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385375; c=relaxed/simple;
	bh=t8Q8MldBXPK2bmNiYBP9KCliXUGjoS4WpRc5G2SPg60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjKbpdxSOSXXEu5OFk9wl+eylsCIrccm/XflW20Ms65iXL6uLkTKv3eqWORpYeT5eZOMaJSVIAq/xb3k3D8FozmJDeF8LEbe++BrPNy1UwioE08b+9+Tqw/6vhlnASXW0Hs6h/LmyLstbhRt0EjnToEJzjWCxh7RZxe0SQQVH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3B09t/G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756385371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29IhiQqgTr3yIV26x5LQEzqzOYDfqx1jPvdNgKdjByw=;
	b=D3B09t/Gw5uPhnApKhmpQDEc5zeCYC2a+n0/DDdPR+z7IoGWm1KMfizdnVAEvaEQHfLZSK
	QbGQw4M7C49w2IZ2z5N1zZS7ySlxtup4KQOMTylbHsTN3W46oZHafL+SNVjA3eiI+Yzk3C
	13/voMMW9iKNBmgO+bC3LZcH+O01u9E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-krU1t9YlNMegn6_DQi0EyA-1; Thu, 28 Aug 2025 08:49:30 -0400
X-MC-Unique: krU1t9YlNMegn6_DQi0EyA-1
X-Mimecast-MFC-AGG-ID: krU1t9YlNMegn6_DQi0EyA_1756385369
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c7990941d3so501457f8f.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 05:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756385369; x=1756990169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29IhiQqgTr3yIV26x5LQEzqzOYDfqx1jPvdNgKdjByw=;
        b=bkkq9CtCwwk0TVFSzQB+EL3Nofixlp2+80ZWzoQfKsLIhZQL43AFG0RxHQrsaopqsO
         lfFKk7KRwlqjUvWzoN4ZQ8Gjj9XNelhOVBXdQCGjqX4DZ8n01TZyg3JTCPzpCnxPqeY0
         EkeCmqntv75rStU+Ps72XaT5y12kYHTV28WmhMVzxr15FSTAgs0pNmA366mWRvaWDgDF
         +fdq7b24/3dBm0yNYp3dES2/cUgJKOjzIK4uM4H1drwHJXs10sKQjDF5aVUIbBvIBtH8
         E8TeiXNE72Q2O7nrPAdPeGJWDYTvVG62ozKhRXVgRsRKsuUJKYh8HVrqn3ZIh2iYaQ+b
         if6w==
X-Forwarded-Encrypted: i=1; AJvYcCXPTiKh6B3k8a2XRCyci2Hzmeqt3/hloxlAwMesF1xVfxsTeBE51pITMK3gAz9Xft3xXJh7wU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMOlQAVQqEjWeTqG5yyBAIDXGIbQJJl3tgkO3Ky9dzeeiBDID
	TCOQJa6+biEhnKZCwlIlho0Yf8B3cttP4gyGBpjIyEPpm5OJ4wVepJUsXl5rQRX3iFtok3704eA
	yTQe+b20un4dX+DJ+R1w/Ibwbw+bH1sMMV8PM51nKwgUnziWJRM3J8yuLrQ==
X-Gm-Gg: ASbGncvBr9SQXqBP2WXNjwlXKxpy3myqYkE6Y0pHLlL8kNrYid25lIavAo51aVcASzx
	JtEBKN9M2F+Oy1qyRiD/+qN9XPp/OfOjQhqXrcxQvF/C4ZEt9BwRQNjTP9EhbGToLu/PV6JsfUf
	mFMKFwfSq63aZeqUNVd2vmqaTsYNpfmw3BL85UBit9ajuPPBQsqMQri+IMLSEsTpaqj7ifGA/zn
	xJBHZP6qVROCsKAhQyXTbzHiJcD/NuqA1T0+CDvKr0VseGeysOL1ght+proveskjiOOdNNCtv/Q
	598XPNpQIyrX8zkjoSO1HXrHGYeypfDfeFJFzwZw/Oo=
X-Received: by 2002:a05:6000:2089:b0:3cd:7200:e031 with SMTP id ffacd0b85a97d-3cd7200e16emr3015142f8f.28.1756385369155;
        Thu, 28 Aug 2025 05:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb8z3eeaocT8UEeIm9El3fyqn3b1E+fVi40gmkpX1EXQEdYKsegzAxvCKzrJbuZrPLG8bZyg==
X-Received: by 2002:a05:6000:2089:b0:3cd:7200:e031 with SMTP id ffacd0b85a97d-3cd7200e16emr3015120f8f.28.1756385368650;
        Thu, 28 Aug 2025 05:49:28 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm73332135e9.14.2025.08.28.05.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 05:49:28 -0700 (PDT)
Message-ID: <f865bca4-40e3-4e65-9269-6c0f0ae9ad22@redhat.com>
Date: Thu, 28 Aug 2025 15:49:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] i40e: add devlink param to control VF MAC address
 limit
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, przemyslawx.patynowski@intel.com,
 netdev@vger.kernel.org, horms@kernel.org, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
References: <20250823094952.182181-1-mheib@redhat.com>
 <pdanf5ciga5ddl7xyi2zkltcznyz4wtnyqyaqm7f5oqpcrubfz@ma4juoq4qlph>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <pdanf5ciga5ddl7xyi2zkltcznyz4wtnyqyaqm7f5oqpcrubfz@ma4juoq4qlph>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiri

On 8/28/25 2:43 PM, Jiri Pirko wrote:
> Sat, Aug 23, 2025 at 11:49:52AM +0200, mheib@redhat.com wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> This patch introduces a new devlink runtime parameter that controls
>> the maximum number of MAC filters allowed per VF.
>>
>> The parameter is an integer value. If set to a non-zero number, it is
>> used as a strict per-VF cap. If left at zero, the driver falls back to
>> the default limit calculated from the number of allocated VFs and
>> ports.
>>
>> This makes the limit policy explicit and configurable by user space,
>> instead of being only driver internal logic.
>>
>> Example command to enable per-vf mac limit:
>> - devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
>> 	value 12 \
>> 	cmode runtime
>>
>> - Previous discussion about this change:
>>   https://lore.kernel.org/netdev/20250805134042.2604897-1-dhill@redhat.com
>>
>> Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every trusted VF")
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> ---
>> Documentation/networking/devlink/i40e.rst     | 22 ++++++++
>> drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
>> .../net/ethernet/intel/i40e/i40e_devlink.c    | 56 ++++++++++++++++++-
>> .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 25 +++++----
>> 4 files changed, 95 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
>> index d3cb5bb5197e..f8d5b00bb51d 100644
>> --- a/Documentation/networking/devlink/i40e.rst
>> +++ b/Documentation/networking/devlink/i40e.rst
>> @@ -7,6 +7,28 @@ i40e devlink support
>> This document describes the devlink features implemented by the ``i40e``
>> device driver.
>>
>> +Parameters
>> +==========
>> +
>> +.. list-table:: Driver specific parameters implemented
>> +    :widths: 5 5 90
>> +
>> +    * - Name
>> +      - Mode
>> +      - Description
>> +    * - ``max_mac_per_vf``
>> +      - runtime
>> +      - Controls the maximum number of MAC addresses a VF can use on i40e devices.
>> +
>> +        By default (``0``), the driver enforces its internally calculated per-VF
>> +        MAC filter limit, which is based on the number of allocated VFS.
>> +
>> +        If set to a non-zero value, this parameter acts as a strict cap:
>> +        the driver enforces the maximum of the user-provided value and ignore
>> +        internally calculated limit.
>> +
>> +        The default value is ``0``.
>> +
>> Info versions
>> =============
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>> index 801a57a925da..d2d03db2acec 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>> @@ -574,6 +574,10 @@ struct i40e_pf {
>> 	struct i40e_vf *vf;
>> 	int num_alloc_vfs;	/* actual number of VFs allocated */
>> 	u32 vf_aq_requests;
>> +	/* If set to non-zero, the device uses this value
>> +	 * as maximum number of MAC filters per VF.
>> +	 */
>> +	u32 max_mac_per_vf;
>> 	u32 arq_overflows;	/* Not fatal, possibly indicative of problems */
>> 	struct ratelimit_state mdd_message_rate_limit;
>> 	/* DCBx/DCBNL capability for PF that indicates
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> index cc4e9e2addb7..8532e40b5c7d 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> @@ -5,6 +5,42 @@
>> #include "i40e.h"
>> #include "i40e_devlink.h"
>>
>> +static int i40e_max_mac_per_vf_set(struct devlink *devlink,
>> +				   u32 id,
>> +				   struct devlink_param_gset_ctx *ctx,
>> +				   struct netlink_ext_ack *extack)
>> +{
>> +	struct i40e_pf *pf = devlink_priv(devlink);
>> +
>> +	pf->max_mac_per_vf = ctx->val.vu32;
>> +	return 0;
>> +}
>> +
>> +static int i40e_max_mac_per_vf_get(struct devlink *devlink,
>> +				   u32 id,
>> +				   struct devlink_param_gset_ctx *ctx)
>> +{
>> +	struct i40e_pf *pf = devlink_priv(devlink);
>> +
>> +	ctx->val.vu32 = pf->max_mac_per_vf;
>> +	return 0;
>> +}
>> +
>> +enum i40e_dl_param_id {
>> +	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>> +	I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
> What's so i40 specific about this? Sounds pretty generic to be.
>
>
>
>> +};
>> +
>> +static const struct devlink_param i40e_dl_params[] = {
>> +	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
>> +			     "max_mac_per_vf",
>> +			     DEVLINK_PARAM_TYPE_U32,
>> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>> +			     i40e_max_mac_per_vf_get,
>> +			     i40e_max_mac_per_vf_set,
>> +			     NULL),
>> +};
>> +
>> static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
>> {
>> 	u8 dsn[8];
>> @@ -165,7 +201,19 @@ void i40e_free_pf(struct i40e_pf *pf)
>>   **/
>> void i40e_devlink_register(struct i40e_pf *pf)
>> {
>> -	devlink_register(priv_to_devlink(pf));
>> +	int err;
>> +	struct devlink *dl = priv_to_devlink(pf);
>> +	struct device *dev = &pf->pdev->dev;
>> +
>> +	err = devlink_params_register(dl, i40e_dl_params,
>> +				      ARRAY_SIZE(i40e_dl_params));
>> +	if (err) {
>> +		dev_err(dev,
>> +			"devlink params register failed with error %d", err);
>> +	}
>> +
>> +	devlink_register(dl);
>> +
>> }
>>
>> /**
>> @@ -176,7 +224,11 @@ void i40e_devlink_register(struct i40e_pf *pf)
>>   **/
>> void i40e_devlink_unregister(struct i40e_pf *pf)
>> {
>> -	devlink_unregister(priv_to_devlink(pf));
>> +	struct devlink *dl = priv_to_devlink(pf);
>> +
>> +	devlink_unregister(dl);
>> +	devlink_params_unregister(dl, i40e_dl_params,
>> +				  ARRAY_SIZE(i40e_dl_params));
>> }
>>
>> /**
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> index 081a4526a2f0..e7c0c791eed1 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> @@ -2935,19 +2935,23 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
>> 		if (!f)
>> 			++mac_add_cnt;
>> 	}
>> -
>> -	/* If this VF is not privileged, then we can't add more than a limited
>> -	 * number of addresses.
>> +	/* Determine the maximum number of MAC addresses this VF may use.
>> +	 *
>> +	 * - For untrusted VFs: use a fixed small limit.
>> +	 *
>> +	 * - For trusted VFs: limit is calculated by dividing total MAC
>> +	 *  filter pool across all VFs/ports.
>> 	 *
>> -	 * If this VF is trusted, it can use more resources than untrusted.
>> -	 * However to ensure that every trusted VF has appropriate number of
>> -	 * resources, divide whole pool of resources per port and then across
>> -	 * all VFs.
>> +	 * - User can override this by devlink param "max_mac_per_vf".
>> +	 *   If set its value is used as a strict cap.
>> 	 */
>> -	if (!vf_trusted)
>> +	if (!vf_trusted) {
>> 		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
>> -	else
>> +	} else {
>> 		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
>> +		if (pf->max_mac_per_vf > 0)
>> +			mac_add_max = pf->max_mac_per_vf;
>> +	}
>>
>> 	/* VF can replace all its filters in one step, in this case mac_add_max
>> 	 * will be added as active and another mac_add_max will be in
>> @@ -2961,7 +2965,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
>> 			return -EPERM;
>> 		} else {
>> 			dev_err(&pf->pdev->dev,
>> -				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
>> +				"Cannot add more MAC addresses: trusted VF reached its maximum allowed limit (%d)\n",
>> +				mac_add_max);
>> 			return -EPERM;
>> 		}
>> 	}
>> -- 
>> 2.47.3
>>
If i understand correctly, you’re asking whether this parameter could be 
added as a generic devlink parameter
rather than a driver-specific one?


if that the case, Yes, it could be made generic, but I initially 
implemented it as driver specific because I was targeting i40e only,
and I thought a generic approach might not be acceptable at this stage


I do plan to extend this to other drivers, as mentioned in the v1 patch 
here:
  - 
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20250821233930.127420-1-mheib@redhat.com/
For now, i'm pushing hard to get this patch into i40e since it affects a 
customer. Once it's accepted i can extend it
to other drivers and convert it to the generic devlink parameter.


Thanks,


