Return-Path: <netdev+bounces-68503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967B68470B1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92F71C21245
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7231185A;
	Fri,  2 Feb 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hGtFVit1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B04402
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878505; cv=none; b=B9CTIJi1v2Dqcx5EMM5vnyEze+H5OQi4E9/epNFxM7gQivZQ8cLJEOVXREX4p6Rwf0oqWJ4p7lzHmPnR3+aCcF4vXzSan+h6ECllUD4uUt087SUJ6m2byFU/nYInAuarVYOCBlJ+vz21RFRtLdiOX7a0ZwQVAwFgcQKvOmJdB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878505; c=relaxed/simple;
	bh=oxWRUtNngJpQklv/0odmbpgwJkpix7OpLuZXrTQS8L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfnMH/IiGlLi5numZS8g1iPc5GPmwb+gRXFbp+MDswAzXoSvqchm9nS/gqpYxxcqH8eK8vbQpM6EiJavlCyFVsDnGiELUtFmI0vJxiN6RXTO/56+E0V4E1owJunhUCXmM5LcoNgQEdtJ/jVZLlIVsG7rZTVRabcKs6pAXb4l2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hGtFVit1; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-33aeb088324so1393249f8f.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706878501; x=1707483301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eR/dFc0FSIzqoTvjBxZEJZ91ap+psJ88vvlb+kp86+8=;
        b=hGtFVit15AwUrCitUfblieMSlCMwWNLLJv7ayXFmpHv7jhjllTjxHYsa1cv2cdTp1k
         9V0Yx0ihi3FKTxphOzmg6DNs+YqyWtL0neORIUJRowRAlZTlx8kJxMKVA2y+oqoMkNNl
         jS0SM1cHeNDKFfDP297cjzDD07+LFizzL4gleWs+i9uY11wiSkK+QusokFNXLtLdFsva
         g7+E/4J0ktYir9MeBwN/YVld2g5PEzE20Y+oyVg5jKnzCYfHdYnxVJizHwWfiVxrU3PL
         W50HxYdgGNjUWJbTBSZVC0ZqPUtjFc1ypa4LL0gnJfo7abTJRxfTu3s7HUvozHFOznta
         hTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878501; x=1707483301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eR/dFc0FSIzqoTvjBxZEJZ91ap+psJ88vvlb+kp86+8=;
        b=qzaaNDqeW7Uu8ibtCgGmS3J1Co4ow//vAUMPutiBQ7K8QKkjOokxp5lcVUIoywboGR
         RGT/SluK/gL4YOQxsEqriG1KMiQPrIQJpK7fHGcw8Z3USZG4zH11Gb8wjyMnJWDhFQ3G
         NXbxLs+59wd81Z7t6Rj+NNWC8mGjT/yfYpkdq95X1JnGHSc1UvElubp2RAuM45EoWDZT
         kizDdl5pm3GRNGbLO/LaVZoxC6NQVF92KIZxoDDxP6S/Y0EN2bMH6ah0NBeLpKy36ErN
         pFBM9gdqOkZlmHp+4lMzLdBW1e2jtMCg9v8wBNEwAmXxTb8jfqCSioYGY0jXNiTFXwuS
         B8RQ==
X-Gm-Message-State: AOJu0Yzef0xiXeN25mJ2GbMsUs8suQmb0dMfH7E/0zYhzNC9QwLJ/cXU
	gk/8BaLlzvkEyL26rH/ManbZ3faNpdXcT7uQkboSL77xoBlYlMOx5OWqiy8CAD4=
X-Google-Smtp-Source: AGHT+IE/2FdigyWjZNKrXHq/LWQW6xjNLjO9qfOBbCTabr7EeD/WYvGIL4H0Ua2h2egOGCXPHz5pYQ==
X-Received: by 2002:a5d:64ee:0:b0:33b:17c9:ef7e with SMTP id g14-20020a5d64ee000000b0033b17c9ef7emr4080836wri.42.1706878501337;
        Fri, 02 Feb 2024 04:55:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQjK5Ya2zy2kPx6E2cfyv4OBZqXUiiEOO7NM1TgE+ats5pGqS88/qcyJZHZi5uWRs5gmNoSYd3lSAnDBVO6XMO5pTV1murivHBUG5SBkOZ2zUUfcaHUylAcfHOTbg7D3l7wa6m1ygdP8GC+9KWGyeKdrxCT12Y41HJfhRGXJYeyafffraHw9AeqY8CVK97PI6vDbGtn+lsaIZdy4mT0oAORbcNf3OFOCz8p3mx5lrRvuGWJTtoI8RE0dJLm0brgJE9uvReP1EG/uU3GRX1ssUtAL4cndp7FvhOgBvTLMVtqFOAUIkbmFCPxA==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b00337d6f0013esm1860901wru.107.2024.02.02.04.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:55:00 -0800 (PST)
Date: Fri, 2 Feb 2024 13:54:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix unaligned access in
 ice_create_lag_recipe
Message-ID: <ZbzmIbKG34AvMF8J@nanopsycho>
References: <20240131115823.541317-1-mschmidt@redhat.com>
 <Zbo6aIJMckCdObs1@nanopsycho>
 <8c35a3f0-26a2-4bdd-afe1-dcd11fb67405@intel.com>
 <48ce5a45-4d95-4d12-83ef-ee7d15bb9773@redhat.com>
 <f58984ba-08d4-4f6c-a4ea-0f3976a3f426@intel.com>
 <15af160b-54b1-4f27-ad72-01fc27601f69@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15af160b-54b1-4f27-ad72-01fc27601f69@intel.com>

Fri, Feb 02, 2024 at 01:40:18PM CET, aleksander.lobakin@intel.com wrote:
>From: Alexander Lobakin <aleksander.lobakin@intel.com>
>Date: Fri, 2 Feb 2024 13:39:28 +0100
>
>> From: Michal Schmidt <mschmidt@redhat.com>
>> Date: Thu, 1 Feb 2024 19:40:17 +0100
>> 
>>> On 1/31/24 17:59, Alexander Lobakin wrote:
>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>> Date: Wed, 31 Jan 2024 13:17:44 +0100
>>>>
>>>>> Wed, Jan 31, 2024 at 12:58:23PM CET, mschmidt@redhat.com wrote:
>>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
>>>>>> b/drivers/net/ethernet/intel/ice/ice_lag.c
>>>>>> index 2a25323105e5..d4848f6fe919 100644
>>>>>> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
>>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>>>>>> @@ -1829,9 +1829,7 @@ static int ice_create_lag_recipe(struct ice_hw
>>>>>> *hw, u16 *rid,
>>>>>>     new_rcp->content.act_ctrl_fwd_priority = prio;
>>>>>>     new_rcp->content.rid = *rid | ICE_AQ_RECIPE_ID_IS_ROOT;
>>>>>>     new_rcp->recipe_indx = *rid;
>>>>>> -    bitmap_zero((unsigned long *)new_rcp->recipe_bitmap,
>>>>>> -            ICE_MAX_NUM_RECIPES);
>>>>>> -    set_bit(*rid, (unsigned long *)new_rcp->recipe_bitmap);
>>>>>> +    put_unaligned_le64(BIT_ULL(*rid), new_rcp->recipe_bitmap);
>>>>>
>>>>> Looks like there might be another incorrect bitmap usage for this in
>>>>> ice_add_sw_recipe(). Care to fix it there as well?
>>>>
>>>> Those are already fixed in one switchdev series and will be sent to IWL
>>>> soon.
>>>> I believe this patch would also make no sense after it's sent.
>>>
>>> Hi Alexander,
>>> When will the series be sent?
>>> The bug causes a kernel panic. Will the series target net.git?
>> 
>> The global fix is here: [0]
>> It's targeting net-next.
>> 
>> I don't know what the best way here would be. Target net instead or pick
>> your fix to net and then fix it properly in net-next?
>
>Sorry, forgot to paste the link :clownface:
>
>[0]
>https://lore.kernel.org/intel-wired-lan/20240130025146.30265-2-steven.zou@intel.com

Just put this into -net, no? I don't see why not.

>
>Thanks,
>Olek

