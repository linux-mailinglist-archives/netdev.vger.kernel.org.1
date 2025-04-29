Return-Path: <netdev+bounces-186729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E2AA0ACC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 13:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3453E1B6618B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E02C2585;
	Tue, 29 Apr 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mgMlg5tj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897554654
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927363; cv=none; b=WmxT7vDb8lB+Vw6Pwl50pfNNdqsxvFrPJD9YtN8dcbk2C4aeFIYCm+LMqi+W2DJEhuU6vbRVQkSSzRpPo4iMv/r7IiHjL8empk3o659/SlKokTHF7Z72zo7ix3FB8xTnFiPtD9DH2BYO4KtodWF1V0qkHybf4Ul0MpIkaGCaneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927363; c=relaxed/simple;
	bh=S1KXbpbgbkY0HRKJbRzwryfsgt4Q8unJV85Ro7hxvdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkWjPAZ8KT92dU9Mfsb7Yzg+0VNZmGTiy7hIYT4vU336l1IyVicROoyfkp3vRAWrfpnYLG9AwuHgp1wmF94FBf/gOZ4uBMUncafOJiaHiZK8L/e2PVBPKUpEiZ38t7sp1S5LgqihvxmlOt+98eXljgVLDdE+Ou+Fl5suaVnen28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mgMlg5tj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ede096d73so39967505e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745927359; x=1746532159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6Ep7JQLbh/0OSttSyB3ZrT5OcRbXsWFcwrDvopJDMQ=;
        b=mgMlg5tj+XRIwfDHAOr2xH7YG/kW9y09/ifCRR9YMt//NfDfivTi7XnOY5oMv19PFK
         4Su9MmUlSfOkh7VmaTCxrr1quUiZh0sracaOts9aRZ8ykwYBnLA0o1RwZK8OhQ/Nys+3
         D4+RCRGAZXb3/jvdEi4o49GbBmrRXoPvUoTZG7WcfcdWVBRvX6Vytz6NcUEBt4OQUZdX
         Ck6amPtLA74Wegw4ThBo6kSGrEi3M6I5Gwtr92t8PtGMjqWt+umRy135crEWGCxxpzAx
         9nQS5VhxMxarzYgBbkPPpnbicGPZN4Ls8upPPnbmD9GDB/RIDSQjnOyulszqyJL8vJ5P
         yM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745927359; x=1746532159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6Ep7JQLbh/0OSttSyB3ZrT5OcRbXsWFcwrDvopJDMQ=;
        b=ukT7FGDfAbgd9YvxhTEzaULcgHew7HwF4R2wFr0AQs1iGspto27cjW1volMedr4FG7
         YXUfw3soNOvIPNZp/O2VIFc7E88TCIOne+sSoI/dI1Mfo2g2kFDvX5axyjKke2HXbBsb
         D8i3MqnYKV1TsmBihtPT6lfyb7HSrE2q6jC1FsYlVJgd1PMdLS3Z4bVgBPGiOv30wskF
         DFSEJ07i2qas548oH1+fPOBjRDcJSYMNhc3wrVn1FmBlQaqJIy11SNwAzNdxL19IPZow
         16MpELYo58CFYk/FBwCdoCz5wa9bisAoq7TIn0jIE7/ar/QZvivsfpbAaSnj4AhO+GUO
         iLQA==
X-Forwarded-Encrypted: i=1; AJvYcCU3OtNJfPX4N/5g9CVr+E4ku21HkVXR5appbWpTatOhTeAYo67n/4wLnVyC7M2+BvR4eiJZLKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3ffCEanrpuwOy4kKg4ex3zGOFNqai2jf0trZ/WOz4vTdOeoS
	Bn/l54o7FmkisE9Ib8lODFV51z99Tor/kRzhvpf179tQ9IMSdsTt8/j2n4ekltM=
X-Gm-Gg: ASbGncuQf+hJeQEfMPqdTh3j//jLUiH9TxLoPQw8ZG6VtbLmC/cm8mAqXn15Jljyd16
	oxOFTYsm5Ggz+TV6b/80JADv35/7bc6z9zGiijuueRKmyZ/a+/q8dLDJn0NVNiQ+cmKI+5Pv5wL
	IhVyYd/PLWNluNPbB0ZG3GikqJMdWESQsWEcAnMsZhZR41ED1hiRAsghwQRyZ+UH1vfmu68fkHr
	AnrJTYZ1D11RCw98pJZZXF5BmopInQfwZz0I0Gg9xTDhZqv2b6AGirCESiWKwsOriAaDl6pSCq8
	xnfA4ChzJoqT0HjMY23MpGR9gXfWJrIqVHb0Kf7VHfI/2lyT5GyXGRNtt13IyjS4THd5
X-Google-Smtp-Source: AGHT+IEUjvyH0tgnDxelZAHB/MKhdUs/tGd45sq0OoA+2vbaVv+OIG7YaWT9Y8qZpRSDyz+/1d7jJw==
X-Received: by 2002:a05:600c:a016:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-441ac84f216mr28642265e9.7.1745927359430;
        Tue, 29 Apr 2025 04:49:19 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5303c08sm153150445e9.13.2025.04.29.04.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:49:18 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:49:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 02/15] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <fy5y73vfqfajxnm6hkzd5h4rw4xohz6tormbi6mgnnerptomlv@jwsxzuqdn7io>
References: <20250425214808.507732-1-saeed@kernel.org>
 <20250425214808.507732-3-saeed@kernel.org>
 <20250428161031.2e64b41f@kernel.org>
 <ospcqxhtsx62h4zktieruueip7uighwzaeagyohuhpd5m3s4gw@ec4oxjsu4isy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ospcqxhtsx62h4zktieruueip7uighwzaeagyohuhpd5m3s4gw@ec4oxjsu4isy>

Tue, Apr 29, 2025 at 09:20:40AM +0200, jiri@resnulli.us wrote:
>Tue, Apr 29, 2025 at 01:10:31AM +0200, kuba@kernel.org wrote:
>>On Fri, 25 Apr 2025 14:47:55 -0700 Saeed Mahameed wrote:
>>> +/**
>>> + * enum devlink_var_attr_type - Dynamic attribute type type.
>>
>>we no longer have "dynamic" in the name
>>
>>> + */
>>> +enum devlink_var_attr_type {
>>> +	/* Following values relate to the internal NLA_* values */
>>> +	DEVLINK_VAR_ATTR_TYPE_U8 = 1,
>>> +	DEVLINK_VAR_ATTR_TYPE_U16,
>>> +	DEVLINK_VAR_ATTR_TYPE_U32,
>>> +	DEVLINK_VAR_ATTR_TYPE_U64,
>>> +	DEVLINK_VAR_ATTR_TYPE_STRING,
>>> +	DEVLINK_VAR_ATTR_TYPE_FLAG,
>>> +	DEVLINK_VAR_ATTR_TYPE_NUL_STRING = 10,
>>> +	DEVLINK_VAR_ATTR_TYPE_BINARY,
>>> +	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
>>> +	/* Any possible custom types, unrelated to NLA_* values go below */
>>> +};
>>> +
>>>  enum devlink_attr {
>>>  	/* don't change the order or add anything between, this is ABI! */
>>>  	DEVLINK_ATTR_UNSPEC,
>>
>>>  static int
>>> -devlink_param_type_to_nla_type(enum devlink_param_type param_type)
>>> +devlink_param_type_to_var_attr_type(enum devlink_param_type param_type)
>>>  {
>>>  	switch (param_type) {
>>>  	case DEVLINK_PARAM_TYPE_U8:
>>> -		return NLA_U8;
>>> +		return DEVLINK_VAR_ATTR_TYPE_U8;
>>>  	case DEVLINK_PARAM_TYPE_U16:
>>> -		return NLA_U16;
>>> +		return DEVLINK_VAR_ATTR_TYPE_U16;
>>>  	case DEVLINK_PARAM_TYPE_U32:
>>> -		return NLA_U32;
>>> +		return DEVLINK_VAR_ATTR_TYPE_U32;
>>>  	case DEVLINK_PARAM_TYPE_STRING:
>>> -		return NLA_STRING;
>>> +		return DEVLINK_VAR_ATTR_TYPE_STRING;
>>>  	case DEVLINK_PARAM_TYPE_BOOL:
>>> -		return NLA_FLAG;
>>> +		return DEVLINK_VAR_ATTR_TYPE_FLAG;
>>>  	default:
>>>  		return -EINVAL;
>>
>>Why do you keep the DEVLINK_PARAM_TYPE_* defines around?
>>IMO it'd be fine to just use them directly instead of adding 
>>the new enum, fmsg notwithstanding. But failing that we can rename 
>>in the existing in-tree users to DEVLINK_VAR_ATTR_TYPE_* right?
>>What does this translating back and forth buy us?
>
>Sure, I can do that in a separate patch. I think I will send these
>patchset separatelly prior to Saeed's patchset.

Hmm, on a second thought, we expose DEVLINK_PARAM_TYPE_* to drivers to
specify type of driver-specific params:
git grep DEVLINK_PARAM_TYPE_
I would like to keep it as part of devlink param api. Looks nicer to me.
Downside is this switch-case, but who really cares?

Thanks!

>
>>

