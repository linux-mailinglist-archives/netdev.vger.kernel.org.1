Return-Path: <netdev+bounces-220669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD88B47A62
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1C7161D2D
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE423ABA7;
	Sun,  7 Sep 2025 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFxKIvJ3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522F10E3
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239658; cv=none; b=QuU0B4Vqru/lP5ngZ8DmTfAA0p7IQDw0sWeoVMg51z9/ZSFzxVMdgFNHCAVrGHqtrQjmahFVUeGwBwx/QnRlfb9n3Zx//fM0bnByEoJ1+PIuP8/ZuXJRDpGpwiC2WRfDlBH8VkncgiGHsbWUJcKp9lh5TwFOJkFV4OddsvQt2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239658; c=relaxed/simple;
	bh=iAvMdaWuyboUwlU6n2zUnckYEL3bd92vEJCN1ugvwq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgR8EFzFBxRuPAsfHJywab7Zj3S3xvZclJfJGaOja8oV4k6+whefpRjrGANVv5GBADhuUICLbLGG4C+vi3zrZqk/77mnO5Aj9W57c6abrsoRuOooIzBbXoHcnUuml/0HbxKm01tbaQhRnto6yET69lPaEo9wDLwhRGMATnDLYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFxKIvJ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757239655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnnYBGJLuU87m/TYWsgCWAzurW6kZLYOyTeZ7Z1OKbU=;
	b=QFxKIvJ3AMoy8ul20El0JzKdzJwvrmd96oRov79BDg3z9qLINcMVzuswmw9yb1C+a+ejFP
	t9Vbmov9m9nBHDZNb89edZ03ySMIQ03wgMsh4FOQaKzo9ZUPsIj0u6bBnR2XT3c1ymwKpm
	EUIwfRqWnhaY6CcoibPdwFUTxx/nPh8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-sYI0-QwaP4ypPYlCrIpsbA-1; Sun, 07 Sep 2025 06:07:33 -0400
X-MC-Unique: sYI0-QwaP4ypPYlCrIpsbA-1
X-Mimecast-MFC-AGG-ID: sYI0-QwaP4ypPYlCrIpsbA_1757239652
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so1706881f8f.1
        for <netdev@vger.kernel.org>; Sun, 07 Sep 2025 03:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757239652; x=1757844452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnnYBGJLuU87m/TYWsgCWAzurW6kZLYOyTeZ7Z1OKbU=;
        b=mW65KdpDiwHSd9HvFFE9qTktjF/nLFs5/3l6Wyyu/zVwojP5wC2g88MI8uV77Oa2Bs
         8E4xtCKjHHlsi5Eg4j3n6ilbTAsC6ClL3wUp/uJdXdXtU3RfnlgMzi5g1RaYqNWChaeg
         7/jCIxgJ605tlSOW8JvJGkVhvO+e5n7kwXHFAo9UaG70sFEkJYwSuAfs1ZxWkMm+Uhsf
         V4aXlWNdqh7UUd/p6b4cRGLUMAQJ+1OWkTxo6/jEimfrGqN/2DICUutomj2GhSEBkWtj
         dy9YM0PlDOW09RPyQpQ0SFFu6Ka5OIFfM8TAdIg1KA1f2aelnlvI8dttaWqWW2J6ph5d
         A3iw==
X-Forwarded-Encrypted: i=1; AJvYcCX8cpUzu+1EyiEffVLTzjKCPTUkzA11LZUr6+s8ZEnz6XI9ud5m7VxC1jSyrY7bnqS/VXMxpVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Qta1niakIIyYgYdhQ1wTBjjDHlAwjUTjYJ643LjvpwJgkImR
	rfIXFStcyJKg2k5RYpotzzxk2CE6nuFJmbyF67OmF7S1Tzd3P7trTbWHrZOUmV7+82sZssLJMlL
	gAQaXJtwWu+qGzZmBQCP/9bJAr9kOSEfnZVA9t41+q644w4esrwxRisBlDQ==
X-Gm-Gg: ASbGncsx9LjsCp2ZabhD6K4AAKYKCGTS21PqEX4Z7+xE3UAky/a2kWIvvuLB4aPa9is
	aMmOJHTAD97YKz8ZGhO54+W9Om0sWQCvmcXAEUJ0KXIlL22/ATg+oiOOeQJYJzE0PIVjIbAX2Xr
	hcRJQUmW+tzotXaiMpudWRTYAd5xjxVzgCLQm/8rzUn02HflEeXLHbJztll+wo8RAxl7fOZdy5X
	vdxIeJMTLjxWEWKspOXnn82s1qny4wDCddBhmM6kgrji0Ir6TyQa+/uqblU1KKPr/+wbEcZz4tG
	zthNl7W6nObFOEl/VbLksaudGQ7dvtGoL2mCk0C/h/8=
X-Received: by 2002:a5d:64e4:0:b0:3e0:152a:87bb with SMTP id ffacd0b85a97d-3e64392b6camr2784005f8f.31.1757239652071;
        Sun, 07 Sep 2025 03:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdnOLhg7b9jF423cv+4EKzrwVRujfCTbhh8PbaI9gyYT0tkEGWRqv07DZlKchYFI78NSvaJA==
X-Received: by 2002:a5d:64e4:0:b0:3e0:152a:87bb with SMTP id ffacd0b85a97d-3e64392b6camr2783990f8f.31.1757239651669;
        Sun, 07 Sep 2025 03:07:31 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e18537589dsm11894722f8f.54.2025.09.07.03.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 03:07:31 -0700 (PDT)
Message-ID: <5ad712d1-47ce-446e-bc96-e03b72459eee@redhat.com>
Date: Sun, 7 Sep 2025 13:07:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v3,2/2] i40e: support generic devlink param
 "max_mac_per_vf"
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, przemyslawx.patynowski@intel.com,
 jiri@resnulli.us, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
References: <20250903214305.57724-1-mheib@redhat.com>
 <20250903214305.57724-2-mheib@redhat.com>
 <20250905122530.GB553991@horms.kernel.org>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <20250905122530.GB553991@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

Thanks for the review i fixed it in v4.


On 9/5/25 3:25 PM, Simon Horman wrote:
> On Thu, Sep 04, 2025 at 12:43:05AM +0300, mheib@redhat.com wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> Currently the i40e driver enforces its own internally calculated per-VF MAC
>> filter limit, derived from the number of allocated VFs and available
>> hardware resources. This limit is not configurable by the administrator,
>> which makes it difficult to control how many MAC addresses each VF may
>> use.
>>
>> This patch adds support for the new generic devlink runtime parameter
>> "max_mac_per_vf" which provides administrators with a way to cap the
>> number of MAC addresses a VF can use:
>>
>> - When the parameter is set to 0 (default), the driver continues to use
>>    its internally calculated limit.
>>
>> - When set to a non-zero value, the driver applies this value as a strict
>>    cap for VFs, overriding the internal calculation.
>>
>> Important notes:
>>
>> - The configured value is a theoretical maximum. Hardware limits may
>>    still prevent additional MAC addresses from being added, even if the
>>    parameter allows it.
>>
>> - Since MAC filters are a shared hardware resource across all VFs,
>>    setting a high value may cause resource contention and starve other
>>    VFs.
>>
>> - This change gives administrators predictable and flexible control over
>>    VF resource allocation, while still respecting hardware limitations.
>>
>> - Previous discussion about this change:
>>    https://lore.kernel.org/netdev/20250805134042.2604897-2-dhill@redhat.com
>>    https://lore.kernel.org/netdev/20250823094952.182181-1-mheib@redhat.com
>>
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>> ---
>>   Documentation/networking/devlink/i40e.rst     | 32 +++++++++++++
>>   drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
>>   .../net/ethernet/intel/i40e/i40e_devlink.c    | 48 ++++++++++++++++++-
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 31 ++++++++----
>>   4 files changed, 105 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
>> index d3cb5bb5197e..524524fdd3de 100644
>> --- a/Documentation/networking/devlink/i40e.rst
>> +++ b/Documentation/networking/devlink/i40e.rst
>> @@ -7,6 +7,38 @@ i40e devlink support
>>   This document describes the devlink features implemented by the ``i40e``
>>   device driver.
>>   
>> +Parameters
>> +==========
>> +
>> +.. list-table:: Generic parameters implemented
>> +    :widths: 5 5 90
>> +
>> +    * - Name
>> +      - Mode
>> +      - Notes
>> +    * - ``max_mac_per_vf``
>> +      - runtime
>> +      - Controls the maximum number of MAC addresses a VF can use
>> +        on i40e devices.
>> +
>> +        By default (``0``), the driver enforces its internally calculated per-VF
>> +        MAC filter limit, which is based on the number of allocated VFS.
>> +
>> +        If set to a non-zero value, this parameter acts as a strict cap:
>> +        the driver will use the user-provided value instead of its internal
>> +        calculation.
>> +
>> +        **Important notes:**
>> +        - MAC filters are a **shared hardware resource** across all VFs.
> 
> Sorry for not noticing this before sending my previous response.
> 
> make htmldocs is unhappy about the line above. Could you look into it?
> 
> .../i40e.rst:33: ERROR: Unexpected indentation. [docutils]
> 
>> +          Setting a high value may cause other VFs to be starved of filters.
>> +
>> +        - This value is a **theoretical maximum**. The hardware may return
>> +          errors when its absolute limit is reached, regardless of the value
>> +          set here.
>> +
>> +        The default value is ``0`` (internal calculation is used).
>> +
>> +
> 
> ...
> 


