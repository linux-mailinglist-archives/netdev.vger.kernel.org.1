Return-Path: <netdev+bounces-181990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6CDA8740C
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 23:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D95188F78E
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118AB481CD;
	Sun, 13 Apr 2025 21:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585801EB36
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744580063; cv=none; b=IlYaK1NJWmhBwsNVS/KWq0cuXrq5FPwHgz/pu3i6gfCuMtC4KukkwAyeknKCjNjA3GJEtzK1Mcq1WX6C4058DJ5Wt182/wy9sdxl8ZrZt0t2dSpaGv+5Wcn+Q3tQkByYjGIG+lXplvJAyYu7KFbf2JfQ7XTPB9zjCeCfV22yHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744580063; c=relaxed/simple;
	bh=KazbEz929nwZrvt12XlQujXV8p8r6I7jJkJfIKGgT3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGH0BH1lMPIItPvabYGVmAzVv4b21V/zNyE8KVBpRfBTIH317t26ktS/mxi/KNgufUwgdSNZjm7KQsT9URlnLRxz6nuHbI1cCEZHOT3O9pOgD6QCGsldGozqwV0LAYLRFGpslh2n8FtYWXaO2pklFkjMO7tuw2yhvzsdgrWH4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so572432266b.0
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 14:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744580059; x=1745184859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oY9DAo74r4exJprf7TJtFDjlUJmPXgaf3ueWxOaOJyw=;
        b=oz4r0xYJfBLQLmso3lHsTiaKppAwSe18m0gxOJMHXkJTSie179sIeR2+n3yVTdekNi
         RRy9NYDq4n89UDZF8HQXy+qurA5TM4qvIQWUS1NwA4Z2v8yp9XkhvnMNBNtxiYYTvDfK
         Gjiz/yrZnwBxbjJVYqBJB4v3NT5lGzMLqPdTrLtcJycXMnYYDYR63A2vvmXqjD7Uc09z
         w/Mg85sznshZDDQ3MLsPFgy/H4Vk4RN/shjjmDae4+ds2d/I/O+Cu9z5UDGHeZlWyXjq
         Rj9Oeax6Xeu99vGLlV2q9u8/O++mGx7zUR66ztLlS78McfHDsSBpErJ9YYLBP3FAHrD5
         mQdg==
X-Forwarded-Encrypted: i=1; AJvYcCU7p7B2heFOWlfknFke9eT23v9wnHmRtG1Oqp5BDo+ZreekMRZX20HE6DnLBH27E8qzCXktVO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUb852S4j6Uzcb2zLTnKoa9PBc66H6jfUXyJ0htxAof++32UrJ
	0WmTN8dOWXL/PSZzxvB24FobcF7Gax7B020ZcdKII6bJIzwxZ9PSnHTe3g==
X-Gm-Gg: ASbGnctlh67IDmwtga7gom9hVus12t6n0hRbkP8g/JwUwqLKf78fpFUq6sWzHl4vpK1
	qitCynVcHxgH32K2DTuvCl/wQM8pOiS2xI52qbk4TWwB4BWT9AsLVcoLwXhX5pw0lQtGQWah08g
	b8DZriYZ+FBsWoa7m1rcOaADKYTnCTWVz3YSHnYEfkZIf4RGq17hqFeagwtSWXaXLWl4cXN5kU0
	+rmhLdGGFY3DpXA3YA32dYL9pa7FLyUz2sv5eLrGmkT6Uv+n39UGmJQFecURly5s7Es9/fGLdoD
	/yye5BnYF9A73MgyBBzOotG+ebIcJUydTToclDXa0g/WOhOegH7KokLXlMVEl1GV+A+qfdkIcpO
	qv9MpmQI=
X-Google-Smtp-Source: AGHT+IG0t3nAXqCqb3B24ba6YdgSLbeS24vuu3x39YaNdujNcVKuWQholBtQa6Nc6IHsIuQ3PMT8rQ==
X-Received: by 2002:a17:906:6a0f:b0:ac3:48e4:f8bb with SMTP id a640c23a62f3a-acad36a08dbmr904460266b.41.1744580059293;
        Sun, 13 Apr 2025 14:34:19 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc2d0sm797099966b.137.2025.04.13.14.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 14:34:18 -0700 (PDT)
Message-ID: <e747a278-7cc9-433f-b093-56487c629d3a@grimberg.me>
Date: Mon, 14 Apr 2025 00:34:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
To: Aurelien Aptel <aaptel@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Simon Horman <horms@kernel.org>, kuba@kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com
References: <20250303095304.1534-1-aaptel@nvidia.com>
 <20250303095304.1534-16-aaptel@nvidia.com>
 <20250304174510.GI3666230@kernel.org> <253jz8cyqst.fsf@nvidia.com>
 <20250403044320.GA22803@lst.de> <253cydizv99.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253cydizv99.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/04/2025 16:24, Aurelien Aptel wrote:
> Christoph Hellwig <hch@lst.de> writes:
>> Btw, just as a reminder nvme code has to go through the nvme tree, and
>> there is absolutely no consesnsus on this feature yet.
> Sagi, could you give your input on this?

As mentioned before, my personal opinion is in favor of getting this 
upstream. 6 years into nvme-tcp,
some people (which are allergic to rdma) are asking for less CPU 
utilization. This would be an optional
compromise to these users. I've expressed concerns that this offload has 
been poorly designed because
it does not interoperate with TLS (offload nor SW). This is somewhat of 
a turn off. I will say that having this
work with TLS offload would make it a more appealing feature than what 
it is right now.

I think that the hesitance is understandable given the history of 
storage offload engines which never really
justified their own existence.

As mentioned before, I acked the series, as I think that this could 
benefit users, despite adding foreign single-vendor
offload code to the driver (granted, not a niche vendor).

