Return-Path: <netdev+bounces-74051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9F85FBF8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EF12894B5
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C1314A4C0;
	Thu, 22 Feb 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeZNiHxt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76C14C5A3
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614717; cv=none; b=KgGgFdumPpLE7XWTRQnfT2Bu7rBd44aXRw/qwHhbvdAmzgMjll4xeQQ8WI9CQ4HZEcFz3oxCfTI3T+9iRxqfhy05QfISEOybaH2+fONIam4g+myPqgC1u1PGMHtuvCYrBE8sicNbqacU48/4hfWGkNtEZtqLVGknRhri4Um66DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614717; c=relaxed/simple;
	bh=2nHeGSw/Y0bu/0rFODKaGA3bo8+cj6tJuf8IA1hGEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcS3v0ilgG4nv867/VozBcAtqAQGnWLvzz+r234PXKEQa5hHtC7bj9xoKS9ZvrWrN1d2pk+HHhhrWE59LsrmW14lSe6VpOSCZDiMVZ/l1EGpZGh7Go6pZKQAWA4Y7UMQwfgZC3QDUg7r+A1wBgvj+6OxBeHmnhNComPzGTT4jIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeZNiHxt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412730e5b95so18720615e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708614714; x=1709219514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZdeavs8ARZ4Wp8jVIIq5rYX8CQepVWYtNx7IdtKagA=;
        b=VeZNiHxtvtZwKy/iwYUtH6ubigGXm4t/ZNRSfgRtK3OZMuYCQwPvzTbMuIUamhdduY
         N+nOlR4+VsstAAJUxg6kRM/BQ9a19WZ95EAgO9xbOY6XXCc38dEUEEMQ1sHsYudUCYcz
         sOaXg57w0KMBZr3tuM457coSnaQnP+c08o8KaXdxir0eLieYLRAQBbyFJMzx6PQAFqlk
         X2Ng/f9JJR0MtXqLKzWLbECZBCpCyOtnWlYGiR0/3jb9KgkuxFSxlWdOEkBrv41yvNca
         DbNDZmuODTjp6NcpMj8U2MDsNr/sdN0eDbBHaqJwKRoH2+u2CReT5YdSy8Z2NYw9p262
         VxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614714; x=1709219514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZdeavs8ARZ4Wp8jVIIq5rYX8CQepVWYtNx7IdtKagA=;
        b=QHULtSsEX8L+uyirdS7iDYUBexSkdG0Ijrx7DHrsbpKyCVs/ZZzRdr1Az8FyWPrrV9
         x2mTE0qu3+AJtVkMAuRvw4vzu5Bl8NzOYohsDsR2WCzkla8KEqCVPKFxjEiQzWdJuQkT
         Fdtn8Yp+wFRxWNhNuRvmYMIEd6BPwzPN3z0rb9d5/YoT672S1fpkaeptkvp6fDiigIeK
         tOQgci4K4ltBwDNTEpaxli1Cw8yV2STEnBNVbShhwcjtbhW76RMBB7llWD6ChfJtXo+j
         hXkBXxDlvojDSU9fsBcwyuA/fhXi9RAsJZos55Deaununk7fTsq0ltrfqRSo7yZw08dX
         sifw==
X-Forwarded-Encrypted: i=1; AJvYcCVZOFdxAV7zgPp6Dz8pW9pWrHEgxsXqGk8pq3U6kS9fSE0tAcSU9iadVgUv+D8EAAws6wHJGT3gndSmhJDr7tZDw2OI0z6F
X-Gm-Message-State: AOJu0YxVuJJscD5d3HUxhThLG5KsBnGP+49RMHclSn4UCdgIYClx4mDR
	j1uRymjrMI10XcwAM557s69w0ul8JW08YN6BP+2USYh9frcEdyYQ3gfWkR54wgg=
X-Google-Smtp-Source: AGHT+IH5VhU9UCTY6WCZTJEB3gZr9zWbimtj+EBEQnbqM+B6oMV2+MqMrPueMl04ish8T7F7PfrFzw==
X-Received: by 2002:a05:600c:190f:b0:412:8560:1baf with SMTP id j15-20020a05600c190f00b0041285601bafmr1129700wmq.26.1708614714030;
        Thu, 22 Feb 2024 07:11:54 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05600c4e0f00b004128f41a13fsm369363wmq.38.2024.02.22.07.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:11:53 -0800 (PST)
Message-ID: <e0a65f94-73b8-4a27-87d8-8fa3d8e88e7c@linaro.org>
Date: Thu, 22 Feb 2024 16:11:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] thermal: intel: Set THERMAL_TRIP_FLAG_RW_TEMP
 directly
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <3281804.44csPzL39Z@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3281804.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:34, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some Intel thermal drivers need/want the temperature of their trip
> points to be set by user space via sysfs and so they pass nonzero
> writable trip masks during thermal zone registration for this purpose.
> 
> It is now possible to achieve the same result by setting the
> THERMAL_TRIP_FLAG_RW_TEMP trip flag directly, so modify the drivers
> in question to do that instead of using a nonzero writable trips mask.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

I've reviewed the changes. Some changes in the DTS are opaque for me, so 
I can not give my reviewed-by tag but the acked-by


Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


