Return-Path: <netdev+bounces-131269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7098DF1F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE88E28768F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211741D0B88;
	Wed,  2 Oct 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCQUFXVd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181C1D0977
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882797; cv=none; b=Hg4KVvhk0UXCj2Afmj4k/i5KhtYiJsuEZO1BmpFJE6BdrkuiWLyO7OpZgJhlG8vJZqZ4GC2PWqg+7yY+oL62DS4a34XkvSpHZl7Ie5bHBpAQ+xjv5R8UK/mZWMgP2w1JqxDIpyX4vHuUgd4AsSQOt8kXeRQPooedhdA5uhwo/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882797; c=relaxed/simple;
	bh=RFdJkpDGbx3s1bzFZDCZhotY8DsS+71Pw3ivg9SSzl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ot0EZiNAPutpPClagbSHtH0ybepxIX6ZER8ERMCN4tdy8k7W6wPcvIT+TCT3o1J0yApmWQoGm+C7TNV+ZqJSssa6ze9ZJ4miUSUeC607tSn2ZpKVbEHyL7FYh2w7noWW72fAKIzFVfrz+f+GpDtcfZUVxmkxOjpi5QOsZKKHJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCQUFXVd; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso339076439f.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727882794; x=1728487594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYKbJgHppNCK2O+vgOoljAZ1VQv5p/e6cb7EA+V191s=;
        b=FCQUFXVdO0M4VJziIEH7Lc9XA5VRIybzEnWzA/ftYDbkWxBp5bM20GsjLr/4mR8uea
         mBkfMUJYtFodHgC2S0FBy9du14c3aEZNpdom15LlOyyMjUE4BJlEE0wfgAoMO16uawBf
         p5vBf6EJNcmxDgfyuFe2cARJpHHRjsol/Amig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882794; x=1728487594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYKbJgHppNCK2O+vgOoljAZ1VQv5p/e6cb7EA+V191s=;
        b=Ejx5CvPxV5npsvGZwDmyzb6pCmhylG9GfEizd9hjOcYeMwekCYvRCJ0gFubb14EmeT
         HIxFLZx8GvlytqjoVrx5BqFQ5enhDFMfULujrNcRMc0qC9F+cC97TpjRZktr7Anii4rJ
         VZAzCLAIUrC96lJ2BYtrP3lgMPA3Ma7hUgFq1/Dv5e7RP3c26xO2A+pfZhEYMxUM6XGJ
         7C31GHPu0NJvVu4G25jMjutCrTKgICRVYp5ff4//OAo3q/CcWVOqie/0cVotq6y62eN1
         Il4Jid+Y6RQNJrTD2Ejmt/SYwelYUW/YfDBiNbYcyHPR4HqWtje1Zez5vn+Ya6Px+a5n
         XGxw==
X-Forwarded-Encrypted: i=1; AJvYcCXt77p/EC4vPVt2ljmI+04fFM2Wo5dW3ZdxYbbEx+Efv9Zip+Pg3NMDVz8s7s2hZ99s+uJhnIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2++PW5zCH/Re6Okv0tsFvn5DmDxrMwccCDdsfnZm003B9gKt
	Rx0l/I04xEF66ruo+c8urHD+La8JNnlkPnt/KKdFQ1LIe1JF4aBpanE5KDJ/UB0HwW/W+ZEpexn
	k
X-Google-Smtp-Source: AGHT+IGhnflfk5+RdkCoZNej/SFEckcTXCsKhNhe1yEhe/m+8I1HbRsWtek+lwIeiq/Ss3EbEZtXMw==
X-Received: by 2002:a05:6602:3fca:b0:82d:16a3:55b3 with SMTP id ca18e2360f4ac-834d848e6a3mr346857939f.10.1727882794545;
        Wed, 02 Oct 2024 08:26:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888860978sm3148531173.69.2024.10.02.08.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:26:34 -0700 (PDT)
Message-ID: <241d131b-faed-42f4-a8c6-93cd95b68181@linuxfoundation.org>
Date: Wed, 2 Oct 2024 09:26:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update core.c
To: Jakub Kicinski <kuba@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Okan Tumuklu <okantumukluu@gmail.com>, shuah@kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, netdev@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240930220649.6954-1-okantumukluu@gmail.com>
 <7dcaa550-4c12-4c2e-9ae2-794c87048ea9@linuxfoundation.org>
 <20240930-plant-brim-b8178db46885@spud> <20241002062751.1b08e89a@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002062751.1b08e89a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 07:27, Jakub Kicinski wrote:
> On Mon, 30 Sep 2024 23:20:45 +0100 Conor Dooley wrote:
>> (do netdev folks even want scoped cleanup?),
> 
> Since I have it handy... :)
> 
> Quoting documentation:
> 
>    Using device-managed and cleanup.h constructs
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
>    Netdev remains skeptical about promises of all "auto-cleanup" APIs,
>    including even ``devm_`` helpers, historically. They are not the preferred
>    style of implementation, merely an acceptable one.
>    
>    Use of ``guard()`` is discouraged within any function longer than 20 lines,
>    ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
>    still (weakly) preferred.
>    
>    Low level cleanup constructs (such as ``__free()``) can be used when building
>    APIs and helpers, especially scoped iterators. However, direct use of
>    ``__free()`` within networking core and drivers is discouraged.
>    Similar guidance applies to declaring variables mid-function.
>    
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

Thank you. This will be helpful for new developers such as this
patch submitter to understand the scope of cleanup patches.

thanks,
-- Shuah

