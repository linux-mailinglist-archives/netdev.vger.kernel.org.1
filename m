Return-Path: <netdev+bounces-217702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0384DB39982
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE22E3B2361
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679583090F5;
	Thu, 28 Aug 2025 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6cLkHDU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959483093C6
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376391; cv=none; b=jiFfonF1kYf3H93ktL5tChVEvqosJEpn0IQdoIyGZNqLGkL1bK68oVj4JrywkDu4q+YnGk763JtMWMfVYXIyRQ4UbJpip2XmVtnpQPDseEB6L2y1Qz2bJqitvdcfN/WUW9Atzd4Td4ZUaBk8Z9FFIhxLJgwOZOGFe2OqNAEvzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376391; c=relaxed/simple;
	bh=jM2/WkKEJxUG2rB7/Qc1u6FwrBpxhbFqW37SnEuE49Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUBaTi1neB+1rrl2I/ueuBxqJfEONlGfQ1uabTrs5E35FmHg8XAXkCdk+d993KuIEoEc03tfsGTsQlsW/S5Xl+PhOBcHgoxuqyAtz5kb9YKPS+lOq3IxLa26wx3wj5yS/bYgYCvnxZgETYwU4FG7x085JR3GwDhtrQ6mI211HaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6cLkHDU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756376388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hG2R1Bkv9qVosRscKm612j4UuXS2eUujrOM+V+p/8pg=;
	b=P6cLkHDUG2D73EIrQbcJ61ipAS3b87if7iLwwRGF0Uk2nIFzLP9y8DVIQ0tyoP2mIa8im3
	eGqIeD4iuCP2EpSF1O/rDN7WeDIX+8YFjOsc2VLrFnVlsnZzOvnQxKMROYbLk//qEtcxDa
	WkNEfXvTj9n/dP+7uWq0gG0tAet3I0M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-7W6FSm4ZMf6byaITjFSN9g-1; Thu, 28 Aug 2025 06:19:44 -0400
X-MC-Unique: 7W6FSm4ZMf6byaITjFSN9g-1
X-Mimecast-MFC-AGG-ID: 7W6FSm4ZMf6byaITjFSN9g_1756376383
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c6ae25997cso484111f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376383; x=1756981183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hG2R1Bkv9qVosRscKm612j4UuXS2eUujrOM+V+p/8pg=;
        b=R3Bng0qLk5HPwOwtlXPyp2o52X9q9VDZYCU4JF8RnjH7zIaQXC8zQOX3NosE8y4K4x
         0zdncjFBet4sAFB3jL8fKNtLsMHaj5dhGdIlIU9C6Roc+1fS5+DWQq5/SJJBDoM/Au6N
         /u+28Wb23JMiHP0vW78XzQ6pgB+zrU88vGK5rWIQJlq15Ot/dPee6pyHrHEY6Wdh7rQV
         umgchyXMdxvMXfMkrSbEoz9RBF+bGmOQvoqaVenQxmSBHVfhmVns8+ofjZ8Z+KrXdigD
         /JXO+MsWrG4cINxFM9CIQLbHyLDHIkUlbwHeHNjQ+A6O0Sv/AJi4so0wVo5cEsXDJoT4
         WnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKvgf8cyZgZyF8lCyTusOKbMggXqNe3IpPtyKi2DAR9V387+pcXOPN7yM4s5yDblLi5oxySZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08wh35yXX5vcfGTYmWzeiUyU8xQCFog35glhZHgU1uQgnpBkM
	K4KVRNDMAkzlvnSguXj6+GLj+b+lbF514tQWeHLgB2syGcsLQH/qOqzX4WPfEDu0t2KCTwJ24eH
	fW7NWmAIBUigmUeHkslfIWSbe09vPNAGLIBEgqiTojWDHQSVzhMnqZNV6lw==
X-Gm-Gg: ASbGncs8FJELWFgx8hli/7nE/XUAA8iuUXjCv43DOgzpZ6jk1dDUA74RypIynLKzPPD
	lyWvuyweiZ7YWudcc632xex8CDfNX2pTk4oSy0kuhkBYMiB/j1BKIhuGr0tB3aQkzCFP10aoHvo
	ELtkEY0xc9hIsU0qBeJWPQ2pb1tKFaXjp+Znz8HyhvG74CCJbal5P2TM+JYGxfhG7v2cmDpKm2r
	l6a0MURd0ycuRwtfmnAJusw1TW6IRTW6oEkZexMX19+iNYWSa1VUhUzUGucW+Da//bEkXRC+A1b
	TF1XgGzGDUakI0L/yosQTaunFGDxGLhxBu3R1dikHNE=
X-Received: by 2002:a05:6000:2404:b0:3c0:5db6:aed with SMTP id ffacd0b85a97d-3c5dcefd13fmr20040155f8f.54.1756376382563;
        Thu, 28 Aug 2025 03:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUf9+VMVyT64li5grrkXarbkMEhZPAVzNfHJOMsvP5ckUlCR6vIpiQ2+ofJ4hBc+vAMdF9dA==
X-Received: by 2002:a05:6000:2404:b0:3c0:5db6:aed with SMTP id ffacd0b85a97d-3c5dcefd13fmr20040133f8f.54.1756376382106;
        Thu, 28 Aug 2025 03:19:42 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca8f2811d9sm13194551f8f.20.2025.08.28.03.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:19:41 -0700 (PDT)
Message-ID: <31709a8a-f314-4522-830d-ec81b9435f10@redhat.com>
Date: Thu, 28 Aug 2025 13:19:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] i40e: add devlink param to control VF MAC address
 limit
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: przemyslawx.patynowski@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org, horms@kernel.org, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com
References: <20250823094952.182181-1-mheib@redhat.com>
 <fe840844-4fcd-49bf-a613-c5a99934a347@intel.com>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <fe840844-4fcd-49bf-a613-c5a99934a347@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tony,


On 8/28/25 12:14 AM, Tony Nguyen wrote:
>
>
> On 8/23/2025 2:49 AM, mheib@redhat.com wrote:
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
>>   - devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
>>     value 12 \
>>     cmode runtime
>>
>> - Previous discussion about this change:
>> https://lore.kernel.org/netdev/20250805134042.2604897-1-dhill@redhat.com
>>
>> Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for 
>> every trusted VF")
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> ---
>>   Documentation/networking/devlink/i40e.rst     | 22 ++++++++
>>   drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
>>   .../net/ethernet/intel/i40e/i40e_devlink.c    | 56 ++++++++++++++++++-
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 25 +++++----
>>   4 files changed, 95 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/networking/devlink/i40e.rst 
>> b/Documentation/networking/devlink/i40e.rst
>> index d3cb5bb5197e..f8d5b00bb51d 100644
>> --- a/Documentation/networking/devlink/i40e.rst
>> +++ b/Documentation/networking/devlink/i40e.rst
>> @@ -7,6 +7,28 @@ i40e devlink support
>>   This document describes the devlink features implemented by the 
>> ``i40e``
>>   device driver.
>>   +Parameters
>> +==========
>> +
>> +.. list-table:: Driver specific parameters implemented
>> +    :widths: 5 5 90
>> +
>> +    * - Name
>> +      - Mode
>> +      - Description
>> +    * - ``max_mac_per_vf``
>> +      - runtime
>> +      - Controls the maximum number of MAC addresses a VF can use on 
>> i40e devices.
>
> Are you intending for this to be for all VFs or only trusted? The 
> changes look to be only for trusted VFs, but it's not clear to me from 
> the documentation/comments.
>
>> +        By default (``0``), the driver enforces its internally 
>> calculated per-VF
>> +        MAC filter limit, which is based on the number of allocated 
>> VFS.
>> +
>> +        If set to a non-zero value, this parameter acts as a strict 
>> cap:
>> +        the driver enforces the maximum of the user-provided value 
>> and ignore
>> +        internally calculated limit.
>
> The filters are a shared resource. This will allow over-subscription; 
> other VFs could be starved
> of filters due to this. Since the user/PF is controlling, this is 
> probably ok but should be documented. Also, since these are shared, 
> this value acts as a theoretical max value, the hardware will start 
> returning errors when its limit are reached.
>
>> +        The default value is ``0``.
>> +
>>   Info versions
>>   =============
>>   diff --git a/drivers/net/ethernet/intel/i40e/i40e.h 
>> b/drivers/net/ethernet/intel/i40e/i40e.h
>> index 801a57a925da..d2d03db2acec 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>> @@ -574,6 +574,10 @@ struct i40e_pf {
>>       struct i40e_vf *vf;
>>       int num_alloc_vfs;    /* actual number of VFs allocated */
>>       u32 vf_aq_requests;
>> +    /* If set to non-zero, the device uses this value
>> +     * as maximum number of MAC filters per VF.
>> +     */
>> +    u32 max_mac_per_vf;
>>       u32 arq_overflows;    /* Not fatal, possibly indicative of 
>> problems */
>>       struct ratelimit_state mdd_message_rate_limit;
>>       /* DCBx/DCBNL capability for PF that indicates
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c 
>> b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> index cc4e9e2addb7..8532e40b5c7d 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> @@ -5,6 +5,42 @@
>>   #include "i40e.h"
>>   #include "i40e_devlink.h"
>>   +static int i40e_max_mac_per_vf_set(struct devlink *devlink,
>> +                   u32 id,
>> +                   struct devlink_param_gset_ctx *ctx,
>> +                   struct netlink_ext_ack *extack)
>> +{
>> +    struct i40e_pf *pf = devlink_priv(devlink);
>> +
>> +    pf->max_mac_per_vf = ctx->val.vu32;
>> +    return 0;
>> +}
>> +
>> +static int i40e_max_mac_per_vf_get(struct devlink *devlink,
>> +                   u32 id,
>> +                   struct devlink_param_gset_ctx *ctx)
>> +{
>> +    struct i40e_pf *pf = devlink_priv(devlink);
>> +
>> +    ctx->val.vu32 = pf->max_mac_per_vf;
>> +    return 0;
>> +}
>> +
>> +enum i40e_dl_param_id {
>> +    I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>> +    I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
>> +};
>> +
>> +static const struct devlink_param i40e_dl_params[] = {
>> +    DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
>> +                 "max_mac_per_vf",
>> +                 DEVLINK_PARAM_TYPE_U32,
>> +                 BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>> +                 i40e_max_mac_per_vf_get,
>> +                 i40e_max_mac_per_vf_set,
>> +                 NULL),
>> +};
>> +
>>   static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t 
>> len)
>>   {
>>       u8 dsn[8];
>> @@ -165,7 +201,19 @@ void i40e_free_pf(struct i40e_pf *pf)
>>    **/
>>   void i40e_devlink_register(struct i40e_pf *pf)
>>   {
>> -    devlink_register(priv_to_devlink(pf));
>> +    int err;
>
> RCT; declarations should order from longest to shortest.
>
>> +    struct devlink *dl = priv_to_devlink(pf);
>> +    struct device *dev = &pf->pdev->dev;
>> +
>> +    err = devlink_params_register(dl, i40e_dl_params,
>> +                      ARRAY_SIZE(i40e_dl_params));
>> +    if (err) {
>> +        dev_err(dev,
>> +            "devlink params register failed with error %d", err);
>> +    }
>
> Braces not needed here.
>
> Thanks,
> Tony
>

Thank you for your review.
yes agree this need to be more documented i updated the devlink param 
documentation to include your comment.
and fixed the minor code issue all in v3.
thanks.


