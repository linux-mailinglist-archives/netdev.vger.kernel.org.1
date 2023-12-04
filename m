Return-Path: <netdev+bounces-53539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BD7803A1E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE41F20C73
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4054F2DF7D;
	Mon,  4 Dec 2023 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mj00cFNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3F0C6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:24:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso18161545e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 08:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701707076; x=1702311876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30JU6VBsVhDThEHQuNQZC01M5fmKcw5wFFaVMEFGEP4=;
        b=mj00cFNzPQP6d9jfvFjLsfzHq1YC4pMgrbVY4poJ6axyPtpDPy88+GgoxCgc03e8TB
         GSxp1gCmW/tjRoAi9yoHJfjzEVKNmFv6aDxT4fQ3olb4cJe/fLz1oKW+fiCbFJrZEbSG
         hKLHilS4uKstyUQgUH0SvqK/Zqqd64f2JjE4UszM/hWqkNg4tjQ1+gXbRlPQRFYBX1CO
         WuTg0kuZ1YL1BGrEYD30tk/GfV/L+UKg1s8Go86sXaEhrdPArKKIWegDffT9/Y646LOR
         qaKWx39/upcTwwrj+Pt5FhV2yegVKY+cHh07uUCaS2jUkCGWpt8j3B7hNb1jXmPFR0Zn
         ZGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707076; x=1702311876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30JU6VBsVhDThEHQuNQZC01M5fmKcw5wFFaVMEFGEP4=;
        b=ruWUqjJ6aZNBLMH55PB4a2l3xVTpSrvwYoztiHW++DcwAt6UzKSqZqEm3RjZ+tqVcU
         liKdzU4JZf05eswNxellfMwSMvCF4yCLASeIlTK6+W3/28J0fnVXDVAX0n6T5WpWWVEk
         uoj7f/olLm4NVtXRTekjMR0Rv1ak/vP+lGIlbQPgfz+UWO3BORTeVkUIRULSj3f809s7
         3m1XSJot2cnKqE3x39YQrP3k6Av+6YAAFX3XyTBAF56CY9uao7b2lfVKp9HzDu7uGp+p
         oksp/oevJrf6qY9W4TOLWvN56VZv8n4Ae2VjoRCjvzTUjGALXU2A2j6/yQaDe1fZHWxr
         IrvA==
X-Gm-Message-State: AOJu0YzFSo1kFrATBMX/U9H4sw7FmjsbvpMk3a1u3Su2CRrpE561T34a
	eGxdRySGuml4cvCb/4YwqqrCSQ==
X-Google-Smtp-Source: AGHT+IFXrs/P2TfD7Db1al+ev+zr1DHb4ZFBqdVucXzjKzSdSI3ci4B8aWO7i8GljfeOrMxPiPZ+HQ==
X-Received: by 2002:adf:f80e:0:b0:333:3d0a:504f with SMTP id s14-20020adff80e000000b003333d0a504fmr1762404wrp.25.1701707076298;
        Mon, 04 Dec 2023 08:24:36 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q4-20020a05600000c400b003333fa3d043sm5909505wrx.12.2023.12.04.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:24:35 -0800 (PST)
Date: Mon, 4 Dec 2023 17:24:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <ZW39QoYQUSyIr89P@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
 <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>

Mon, Nov 27, 2023 at 04:40:22PM CET, przemyslaw.kitszel@intel.com wrote:
>On 11/23/23 19:15, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 

[...]


>> diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
>> index fa9afe3e6d9b..33a8e51dea68 100644
>> --- a/net/devlink/netlink.c
>> +++ b/net/devlink/netlink.c
>> @@ -17,6 +17,79 @@ static const struct genl_multicast_group devlink_nl_mcgrps[] = {
>>   	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
>>   };
>> +int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
>> +				      struct genl_info *info)
>> +{
>> +	struct nlattr **attrs = info->attrs;
>> +	struct devlink_obj_desc *flt;
>> +	size_t data_offset = 0;
>> +	size_t data_size = 0;
>> +	char *pos;
>> +
>> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
>> +		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
>> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
>> +		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
>> +
>> +	flt = kzalloc(sizeof(*flt) + data_size, GFP_KERNEL);
>
>instead of arithmetic here, you could use struct_size()

That is used for flex array, yet I have no flex array here.

>
>> +	if (!flt)
>> +		return -ENOMEM;
>> +
>> +	pos = (char *) flt->data;
>> +	if (attrs[DEVLINK_ATTR_BUS_NAME]) {
>> +		data_offset += nla_strscpy(pos,
>> +					   attrs[DEVLINK_ATTR_BUS_NAME],
>> +					   data_size) + 1;
>> +		flt->bus_name = pos;
>> +		pos += data_offset;
>> +	}
>> +	if (attrs[DEVLINK_ATTR_DEV_NAME]) {
>> +		nla_strscpy(pos, attrs[DEVLINK_ATTR_DEV_NAME],
>> +			    data_size - data_offset);
>> +		flt->dev_name = pos;
>> +	}
>> +
>> +	/* Don't attach empty filter. */
>> +	if (!flt->bus_name && !flt->dev_name) {
>> +		kfree(flt);
>> +		flt = NULL;
>> +	}
>> +
>

[...]

