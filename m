Return-Path: <netdev+bounces-179381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A6A7C3A5
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0FF3BE1A9
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266A521CC55;
	Fri,  4 Apr 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zVw6GkWW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE617A318
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793418; cv=none; b=Ug8BkIKzZ4zSibZfQeLuRHhvVEVGiHJzTUonhbznekjUZ18ZeRZiFimxMgw/0zySXCvdbvxUMiujB3syDcN3bFNd1jN5IFhFIbdU/lHwlh3I9dXWru2IUetQIV7LWc0B4okW+qWQCJr3VoFH5kfaY6GM5RC0raODd3xX89MSc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793418; c=relaxed/simple;
	bh=kDpA9bw7tIP9rQ70HT/F3y51e+3Sme/oGjyukvEZO1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sS1QxSmi7sQeK6Fz28MPzGlNsXRMfeyFm5NGAmeWYYVUTdyOvl8TwnCpLEjGByOGgvILnKhbDT4Ndb10Yt3imL1Val58HWfh+/lu6Kggedx8sQ6WRfgT7bTXjr/lCKrANcgWWg1cu7vkeX3BsNacDmSWZbRCiOxif4yTjsWTPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zVw6GkWW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22622ddcc35so31905935ad.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743793415; x=1744398215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dH2hxZRu+9FwNeyFyLJe8fSFMPlqTXV1JQLEbcO7L6Y=;
        b=zVw6GkWWMiRJmbTfmYj+515J8naYr/rHmoYnmGyBnH3slM7W3ivcIhxNrreCD11Q4h
         YpRRzSp4oVbctbYVRBxe05cdNSxD2mCivC9kTwRyoZdRumC81pVNoj+2qUYPusIdi5Wo
         k1vGS6N/Ot77AaGRUM6iIF50GsQoWanClS1kYj7mIt/v4rlivYVqCJb9LenA/DSQu97x
         0uQMSkkhB51o2rF0XZy48psPxJAY8xFOh04ouko03QlW19kmZw8MqZslxNj8GUPfQtIr
         UIkng9RehTRXrMu2yVQwrK3fB/G/bKdzjSx6X4LybuDZ+riua7NQzO6Q7uRJbfbB+fCU
         j7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743793415; x=1744398215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dH2hxZRu+9FwNeyFyLJe8fSFMPlqTXV1JQLEbcO7L6Y=;
        b=GQyDjZUCmTin2yQNo2M+UQPyaeCyV2DnJzKBhCjP6YsLCuRcHOUkT9qBGCPOoHT/Qg
         CKlsjmFQFyXTzuCjxT0/dy1BDKvVF46oDPgdUNziwYHmugOxxOCcZ/fpL6qWP+u+/r/f
         8rFEywpogdbitpzr+QH4sMQ/MmhJCJW/D+wNIfUBVz5U7ZiqTpWnKlcnj0vLop+7psVL
         yLV87kb4pOmIjOvgQUs3zKMKW1bMtGa0UG8C2vSQ5EyVIF5qEskiTFhHOeLpo/136p8t
         je74GWx7Fp9+MrXANTcDBIlGqj2rNa5t0JhN0OLOFJt6JtGxZ2gdF4xhnJ6rD8JZeMwK
         MBtw==
X-Forwarded-Encrypted: i=1; AJvYcCX5MIttVXwt80cIrpOKnzs5IICCitCIlVyDwlhGqY95b8Yq3nyUmPui25gg34YW6vKcm8lQuCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNDnAD9qOHNcBOLXFKpTtlq5drNCD0bBrgth8XV79Cbii9tlV
	H5YZ0U0I8dCb2V/Bg9gd6CGngfKofFejcNLEn2ZgriSKksP9DxTccrNL99le+g==
X-Gm-Gg: ASbGncsaKZddSHShsTdOtS0BMtBbVdeClWCwFrEKjb0o4aKK039xwRY2b1E9EKNyMcq
	kD2w+qDXN/jT/qIhT9ulZ14Y7JctQYYu5EK67Qj7Il+PpcL/YiV4diZOQE4AYSITP1vBvKqV+Y5
	7mrHubELFtJU/dqYui9+Q3V2EJj1ZYyZnKSgwahZSXgIwUpunJfVYYoBLxHdETgmegfF86soKcD
	xqMaiADjfJjr8JbRFZJa2ZZLHktxc+Z4/uZuyiXZeTkAmwE/dggpflBDTgM/ND4QRjdVZr+VOK2
	SO43xzFakpQuPAxjCg31LtWuT5s+GAG9iU4aUgvLioR9Ne6N4bMMcbKt1CxITD49O0aSIhTY2KI
	wDRB4ybWsurs5g6Q=
X-Google-Smtp-Source: AGHT+IGAs4f9a+7nrDVm3VKvorD+MW5EnW+gSbU4tnowK4SNySgFx0Q3Dy0vJIRaY8zSc2Azgf+GHg==
X-Received: by 2002:a17:903:1aac:b0:224:10a2:cad5 with SMTP id d9443c01a7336-22a954f9e54mr10170775ad.10.1743793415610;
        Fri, 04 Apr 2025 12:03:35 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:8485:ad62:3938:da65:566f? ([2804:7f1:e2c3:8485:ad62:3938:da65:566f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad95esm36167935ad.10.2025.04.04.12.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 12:03:35 -0700 (PDT)
Message-ID: <00bd48eb-eb2d-4194-a458-6203aeba6a81@mojatatu.com>
Date: Fri, 4 Apr 2025 16:03:26 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 11/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with ETS parent
To: Jakub Kicinski <kuba@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-6-xiyou.wangcong@gmail.com>
 <8bd1d8be-b7ee-4c32-83a9-9560f8985628@mojatatu.com>
 <20250404114123.727bc324@kernel.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250404114123.727bc324@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2025 15:41, Jakub Kicinski wrote:
> On Fri, 4 Apr 2025 13:59:39 -0300 Victor Nogueira wrote:
>> On 03/04/2025 18:16, Cong Wang wrote:
>>> Add a test case for FQ_CODEL with ETS parent to verify packet drop
>>> behavior when the queue becomes empty. This helps ensure proper
>>> notification mechanisms between qdiscs.
>>>
>>> Note this is best-effort, it is hard to play with those parameters
>>> perfectly to always trigger ->qlen_notify().
>>>
>>> Cc: Pedro Tammela <pctammela@mojatatu.com>
>>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>>
>> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> 
> Hi!
> 
> Any ideas what is causing the IFE failure? Looks like it started
> happening when this series landed in the testing tree but I don't
> see how it could be related ?

Yes, I saw that, but since it succeeded on retry and, as you said,
it doesn't seem to be related to this series, it looks more like
those IFE tests are a bit unstable. I talked to Pedro and we are
taking a look at it.

cheers,
Victor

