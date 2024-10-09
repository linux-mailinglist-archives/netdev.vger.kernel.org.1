Return-Path: <netdev+bounces-133714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B354B996C58
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F211281B66
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024A198A32;
	Wed,  9 Oct 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XnXmNlhR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B7197543
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481160; cv=none; b=rnsCZmrSawkd6eAtufahSJzPgGT4DSPIs1rEHtHxyrGbnBS1rWrnA9YqzfRX48m4CKAPvhEPwQ/dROPZBLjI4FEF3e5NlTzUDp3P+vv695yBZncNpezn9WRSwX7EtO/kpRiHrQ3PwU+fhXvQ6MUmseihVVA3pgvtQyRp53fid4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481160; c=relaxed/simple;
	bh=rieN8lDGOtXsAzoQS5gZsKZHKclXWZIOVtHEEzNsVPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk924Un7F5zypjeLWLCvEhGsKbCB83jBLUiNjQyaL19xPe5+NgiXTlytHV6hjpTXXhfoYTqYaz9FkYPL4QEIP1G1hbD+A+qnNH3WEOycP8ZmbuYrW3maqXgXArEGiZxp9h8+HrwPo8zgNwnr6yDgTRKqaz9rn9IFmkBpQW/kJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XnXmNlhR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9951fba3b4so511685066b.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728481157; x=1729085957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3ROAsPZzM6tf9FssZJwSDBj5iS/PN2tHy2ShelbS2c=;
        b=XnXmNlhRDTb83wkUqlKupxOdmDHCEiwgLbb5JpUgUdwHuJRoE7WqSU7EfIp32DBLCT
         /LBqT5LRHx+QDgoh9lR/aJEXqJ32pqlzwMfGHdYea6PaGdvtPCdNl2i4SQbSBYTqZcCY
         kqIElNXY+Y2nq6ttgpq4PhhDEMelnUH1LKZNJ0pj+s2P6CH2Sjgd8DSI/nv9wBcMVLrZ
         RMEBUmhcFHpg+g+x4Vp+pE+c9oieU/etxJPwE/yk/gCLK/azLmjoQ0zumiUOpR3jwENm
         hQlojggJB9YyrBmVGJYuLV0QrpUwvI0xfaqY7A47v/a1LlDCITidL/8+XbJ+Y/HDOX1X
         mxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481157; x=1729085957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3ROAsPZzM6tf9FssZJwSDBj5iS/PN2tHy2ShelbS2c=;
        b=CeVuFUCYz9hjv6t/y4Kq2gX8eekVjx7+JBRNPDhLV6QBUoevL5mhpM355HGSgkEj0s
         +1Jv0F7RWMPxfOiEz0yi+w3eEfCWZq4LGl7hL6MV5OtwQ3/82CRKhSsyY+yBTOLL1HJH
         mEPsy/7o7jszvk/W2ikxFclGw4P89SxbKJwgjr2P6MFfdgg1P71Ceg8Q9xb5ucx9DVIb
         An21txnvWs5excBXrYJUrei6X/JNW0WiolAoSZi037TN9RHC85y66ammPvKqkSol9GjX
         9z76CFQtrLobD9SxLf23gRvLMzVgtJzqaTFpdL+ctLdw/Jom+4EWWl1jNqJb4XkB3iMd
         /cog==
X-Gm-Message-State: AOJu0YzWZiNThEruq+fUeRXPKOSpH0z+38neezxHELJcyhNdJ/G1hGIG
	y054ikoWVoY9ex6jRtV8eGvCvLkGK9xosNDKEpPzfx2U2FBm8FE7DLt21nxfpkk=
X-Google-Smtp-Source: AGHT+IFEGDdUJX3tr14+WoPbQIDZXtVTDb7Pv6aVMVFujhrgtKJ5MGJ7JzkD8Po421ijXSRiMld6sg==
X-Received: by 2002:a17:907:6e8b:b0:a93:a664:a257 with SMTP id a640c23a62f3a-a998d334db7mr210520866b.61.1728481156963;
        Wed, 09 Oct 2024 06:39:16 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994ce357b2sm494526166b.144.2024.10.09.06.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:39:16 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:39:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Maciek Machnikowski <maciek@machnikowski.net>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com
Subject: Re: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Message-ID: <ZwaHgKED9kHvWeHP@nanopsycho.orion>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
 <0655aa46-498d-4e8e-be6c-be5fb630c006@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0655aa46-498d-4e8e-be6c-be5fb630c006@linux.dev>

Wed, Oct 09, 2024 at 03:33:13PM CEST, vadim.fedorenko@linux.dev wrote:
>On 09/10/2024 13:25, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> In order to allow driver expose quality level of the clock it is
>> running, introduce a new netlink attr with enum to carry it to the
>> userspace. Also, introduce an op the dpll netlink code calls into the
>> driver to obtain the value.
>
>The idea is good, it matches with the work Maciek is doing now in terms
>of improving POSIX clock interface. See a comment below.
>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   Documentation/netlink/specs/dpll.yaml | 28 +++++++++++++++++++++++++++
>>   drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>>   include/linux/dpll.h                  |  4 ++++
>>   include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>   4 files changed, 75 insertions(+)
>> 
>> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
>> index f2894ca35de8..77a8e9ddb254 100644
>> --- a/Documentation/netlink/specs/dpll.yaml
>> +++ b/Documentation/netlink/specs/dpll.yaml
>> @@ -85,6 +85,30 @@ definitions:
>>             This may happen for example if dpll device was previously
>>             locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>       render-max: true
>> +  -
>> +    type: enum
>> +    name: clock-quality-level
>> +    doc: |
>> +      level of quality of a clock device.
>> +    entries:
>> +      -
>> +        name: prc
>> +        value: 1
>> +      -
>> +        name: ssu-a
>> +      -
>> +        name: ssu-b
>> +      -
>> +        name: eec1
>> +      -
>> +        name: prtc
>> +      -
>> +        name: eprtc
>> +      -
>> +        name: eeec
>> +      -
>> +        name: eprc
>> +    render-max: true
>>     -
>>       type: const
>>       name: temp-divider
>> @@ -252,6 +276,10 @@ attribute-sets:
>>           name: lock-status-error
>>           type: u32
>>           enum: lock-status-error
>> +      -
>> +        name: clock-quality-level
>> +        type: u32
>> +        enum: clock-quality-level
>>     -
>>       name: pin
>>       enum-name: dpll_a_pin
>> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>> index fc0280dcddd1..689a6d0ff049 100644
>> --- a/drivers/dpll/dpll_netlink.c
>> +++ b/drivers/dpll/dpll_netlink.c
>> @@ -169,6 +169,25 @@ dpll_msg_add_temp(struct sk_buff *msg, struct dpll_device *dpll,
>>   	return 0;
>>   }
>> +static int
>> +dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device *dpll,
>> +				 struct netlink_ext_ack *extack)
>> +{
>> +	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>> +	enum dpll_clock_quality_level ql;
>> +	int ret;
>> +
>> +	if (!ops->clock_quality_level_get)
>> +		return 0;
>> +	ret = ops->clock_quality_level_get(dpll, dpll_priv(dpll), &ql, extack);
>> +	if (ret)
>> +		return ret;
>> +	if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
>> +		return -EMSGSIZE;
>> +
>> +	return 0;
>> +}
>> +
>>   static int
>>   dpll_msg_add_pin_prio(struct sk_buff *msg, struct dpll_pin *pin,
>>   		      struct dpll_pin_ref *ref,
>> @@ -557,6 +576,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
>>   	if (ret)
>>   		return ret;
>>   	ret = dpll_msg_add_lock_status(msg, dpll, extack);
>> +	if (ret)
>> +		return ret;
>> +	ret = dpll_msg_add_clock_quality_level(msg, dpll, extack);
>>   	if (ret)
>>   		return ret;
>>   	ret = dpll_msg_add_mode(msg, dpll, extack);
>> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>> index 81f7b623d0ba..e99cdb8ab02c 100644
>> --- a/include/linux/dpll.h
>> +++ b/include/linux/dpll.h
>> @@ -26,6 +26,10 @@ struct dpll_device_ops {
>>   			       struct netlink_ext_ack *extack);
>>   	int (*temp_get)(const struct dpll_device *dpll, void *dpll_priv,
>>   			s32 *temp, struct netlink_ext_ack *extack);
>> +	int (*clock_quality_level_get)(const struct dpll_device *dpll,
>> +				       void *dpll_priv,
>> +				       enum dpll_clock_quality_level *ql,
>> +				       struct netlink_ext_ack *extack);
>>   };
>>   struct dpll_pin_ops {
>> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>> index b0654ade7b7e..0572f9376da4 100644
>> --- a/include/uapi/linux/dpll.h
>> +++ b/include/uapi/linux/dpll.h
>> @@ -79,6 +79,26 @@ enum dpll_lock_status_error {
>>   	DPLL_LOCK_STATUS_ERROR_MAX = (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
>>   };
>> +/**
>> + * enum dpll_clock_quality_level - if previous status change was done due to a
>> + *   failure, this provides information of dpll device lock status error. Valid
>> + *   values for DPLL_A_LOCK_STATUS_ERROR attribute
>> + */
>> +enum dpll_clock_quality_level {
>> +	DPLL_CLOCK_QUALITY_LEVEL_PRC = 1,
>> +	DPLL_CLOCK_QUALITY_LEVEL_SSU_A,
>> +	DPLL_CLOCK_QUALITY_LEVEL_SSU_B,
>> +	DPLL_CLOCK_QUALITY_LEVEL_EEC1,
>> +	DPLL_CLOCK_QUALITY_LEVEL_PRTC,
>> +	DPLL_CLOCK_QUALITY_LEVEL_EPRTC,
>> +	DPLL_CLOCK_QUALITY_LEVEL_EEEC,
>> +	DPLL_CLOCK_QUALITY_LEVEL_EPRC,
>
>I think it would be great to provide some explanation of levels here.
>People coming from SDH area may not be familiar with some of them. Or at
>least mention ITU-T/IEEE recommendations documents to get the meanings
>of these levels.

Okay, I can put a reference to ITU document.


>
>> +
>> +	/* private: */
>> +	__DPLL_CLOCK_QUALITY_LEVEL_MAX,
>> +	DPLL_CLOCK_QUALITY_LEVEL_MAX = (__DPLL_CLOCK_QUALITY_LEVEL_MAX - 1)
>> +};
>> +
>>   #define DPLL_TEMP_DIVIDER	1000
>>   /**
>> @@ -180,6 +200,7 @@ enum dpll_a {
>>   	DPLL_A_TEMP,
>>   	DPLL_A_TYPE,
>>   	DPLL_A_LOCK_STATUS_ERROR,
>> +	DPLL_A_CLOCK_QUALITY_LEVEL,
>>   	__DPLL_A_MAX,
>>   	DPLL_A_MAX = (__DPLL_A_MAX - 1)
>

