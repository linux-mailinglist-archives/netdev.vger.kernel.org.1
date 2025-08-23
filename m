Return-Path: <netdev+bounces-216204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8DB3280A
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 11:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426FDAC5BDA
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCEF224AE6;
	Sat, 23 Aug 2025 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJJIbV8P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD453BB48
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755942935; cv=none; b=iTnc4X5UftpVOZR8Ti9HBBzGvTPyuIFfg0I2CeWYUBK/jdxZTSR/seUnm0okIH/MpKWRzrcLtbxj+Nnfa+VAOT8cC/Ao6jPKjQbs3ohr9e0ZsSdF5JTSZP3dOb62Ow/WGyskWotc63XmGZ4nEd14ESUuIb27w8D8aNHk8M+Dhss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755942935; c=relaxed/simple;
	bh=I/NsseXrIuohiGAzYezw8hqBRQzmqjeNCI1U6ItAoFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yc7w6INbDrRGh8FbBkHjUNYFSycDyfNl+m5/iAmaO+9hUJHh3FAwunEcDDoCiCI3IUC6xjFo6yiK7e4xC7/YgFN/FweVEw/i2ZAU995iOWuaAYgg6lzJyrDk1T6l4YLJyo3IB5G2McixftFzAFYTAPRqOZySlaQX403gj/ksm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJJIbV8P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755942932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJRTU7xQcrHqjtGf0jDczE0LpVrmI9Kmr/4ZyPcx9Pw=;
	b=gJJIbV8Pm4WOKbZcpPCz6q9DzIKpp2oJe3PYYL7Q1v+Pw5xDhqjlg3T4xSNBOIciGx2SAi
	GAzBJgcOIewYGfkvGJSlr4B5dCoX1aIPD9AflqM21q45vYd4rXDpkqFkmO9dKpYWrg3Fac
	L5fweOEHo4xm1RwTtEUrVPrmc+xLcS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-2SuTkw9KNu-wNDyrIYpGUw-1; Sat, 23 Aug 2025 05:55:30 -0400
X-MC-Unique: 2SuTkw9KNu-wNDyrIYpGUw-1
X-Mimecast-MFC-AGG-ID: 2SuTkw9KNu-wNDyrIYpGUw_1755942929
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9e4157303so2009872f8f.2
        for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 02:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755942929; x=1756547729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJRTU7xQcrHqjtGf0jDczE0LpVrmI9Kmr/4ZyPcx9Pw=;
        b=Mbi08hmW/ClEsVFxUmcSvXFxHYSUKOeGqUyT5Yc7tPSE7jljtIIVTMgMNtjkmmUh9f
         JxsjUI1KIZilUrEYZ71awpth56LUyUyX3wnj04ByU+0g7qADiWgHj8NYa8X52U7k6PbC
         9LvV0RFpbiGA8D7T8jgCgMAXbCu4Y+/NDXjr3qghbWKm5as/vAjV6+5geFvrXvABQIIA
         xg0dydMUb9lfTnmGtNmGCVIaIp39kEdE5xgGAFT97gNZhQ6+bJzczOU1pdApf6uiiRFa
         zYxbeCeCePRjeR5PY2PobYkccNVPHrYnWTnkGHVb4CqqI4+0yQxRhX6GOmnpJRPBLBhW
         Z7bg==
X-Forwarded-Encrypted: i=1; AJvYcCV1VuIXpt1Jf/WBpP/XpqPL3gLqPmdA+2fBZVzwXj9vendMeDAOsOdDIPvmLfgFhzbo7FQ0Zso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9L5TnGdDsDQkEEU9X7pIrwSErPQgNxZEzLGK9n0aMVw79a8d
	GKmNt6/8SD8gfaSawT777t/PghebZDznlhj5mfu9yiAvr9pr/hX2/yVD8levwgKUAkhhfmphQZu
	l8wNBMgx5pf8s7upSsVK9Nn0JskGdfhioU1MYkEAvZXFu4a9EvLDnVhb6og==
X-Gm-Gg: ASbGnctysATXjWWrev7tihZIzF1p9JBa7O30CYzx35dpDIBhxmHi1M0H18M/EbrWLfg
	aGV7EaYDTo099QKd0yVcpMJQop+ntYhf/9u541GgTDsFm1CYnDUwj8+GZZTwMqllpBRbas5uFZC
	uqfGzL9kT5A1QQsx8AnXRwW4xE7vAKWSuSGYw9E6ISvwu5Xvuj+LIqbJGxx8Pe56l03e4cX+lCt
	2TeydnKhZ0JU89mWoXE1Ekc7aZ1z3K9KA6q62x2QEBBjKShK4TJ834DfoZLzilPKyA5ZALpi9fQ
	EmtOGL8usJk3udK7f4FqQkjrMQmvGN+DE2u+JWlO0KY=
X-Received: by 2002:a5d:64ed:0:b0:3b9:16ac:4f8b with SMTP id ffacd0b85a97d-3c5dcc0da2bmr3904286f8f.50.1755942929162;
        Sat, 23 Aug 2025 02:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDd2aQ7j8dTvaofCMIeJpKfGZazONCY9/CgH5Oqqvd+1zoSPgxPl531KoOoLOxfCHQtV47xg==
X-Received: by 2002:a5d:64ed:0:b0:3b9:16ac:4f8b with SMTP id ffacd0b85a97d-3c5dcc0da2bmr3904273f8f.50.1755942928668;
        Sat, 23 Aug 2025 02:55:28 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711f89a11sm2928208f8f.64.2025.08.23.02.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 02:55:28 -0700 (PDT)
Message-ID: <f2a0eb8b-2238-4bd2-bc81-eb0284fea6c8@redhat.com>
Date: Sat, 23 Aug 2025 12:55:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: add devlink param to control VF MAC address
 limit
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20250821233930.127420-1-mheib@redhat.com>
 <41eae08f-5f77-4099-bcd4-ccc7bbcf6426@intel.com>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <41eae08f-5f77-4099-bcd4-ccc7bbcf6426@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thank you for the review. All comments have been addressed in v2.
On 8/22/25 12:09 PM, Przemek Kitszel wrote:
> On 8/22/25 01:39, mheib@redhat.com wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> This patch introduces a new devlink runtime parameter
>> to control whether the VF MAC filter limit feature is
>> enabled or disabled.
>>
>> When the parameter is set to non-zero, the driver enforces the per-VF 
>> MAC
>> filter limit calculated from the number of allocated VFs and ports.
>> When the parameter is unset (zero), no limit is applied and behavior
>> remains as before commit cfb1d572c986
>>     ("i40e: Add ensurance of MacVlan resources for every trusted VF").
>>
>> This implementation allows us to toggle the feature through devlink
>> while preserving old behavior. In the future, the parameter can be
>> extended to represent a configurable "max MACs per VF" value, but for
>> now it acts as a simple on/off switch.
>>
>> Example command to enable per-vf mac limit:
>>   - devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
>>     value 1 \
>>     cmode runtime
>>
>> Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for 
>> every trusted VF")
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>
> thank you for the patch, I have a few questions/objections
>
> 1. it git-conflicts with [1], please post your next revision based on
> Tony's (fixes) tree dev-queue branch [2]
>
> 2a. it is good practice to link to the previous discussions, and CC
> individuals involved (Jake, Simon)
>
> 2b. for changes that utilize given subsystem (devlink), you need to CC
> respective maintainers (Jiri)
>
> 3. it would really be better to treat not-zero values as strict limit
>
> 4. this idea is not limited to i40e, the parameter should be global
> (for all drivers to implement), as it seems generic enough
>
> 5. when someone will make a per-given-VF param, this one will not be
> deprecated but will still work as a cap (max) value. (Leaving it at
> zero will be ofc perfectly fine).
Sure, I would be happy to add this to other drivers. Currently, I’m not 
aware of any other driver that has a per-VF MAC limit implemented.
If you know of any, please point me to them.
Otherwise, I will go through the drivers I’m working with and check 
whether they have such a limit or not.
>
> [1] 
> https://lore.kernel.org/intel-wired-lan/20250813104552.61027-9-przemyslaw.kitszel@intel.com/T/#mac68de249365b8c4fa83054592dd98f0f789fab4
>
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/log/?h=dev-queue
>
>> ---
>>   Documentation/networking/devlink/i40e.rst     | 19 +++++++
>>   drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
>>   .../net/ethernet/intel/i40e/i40e_devlink.c    | 56 ++++++++++++++++++-
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 14 ++++-
>>   4 files changed, 89 insertions(+), 4 deletions(-)
>>
>
Thanks,



