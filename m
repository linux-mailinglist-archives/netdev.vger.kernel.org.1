Return-Path: <netdev+bounces-236543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10CC3DCE6
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 00:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD993B3AEE
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77DE357A2C;
	Thu,  6 Nov 2025 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3G1DDF1J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1B35773B
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471294; cv=none; b=PkSFyx+TZIuZNHRHibGQrkOMRytY4FN7xCGlV2zUV7BJ958AqOW1fNhWeFPtyQLtOg7iyUIuVeE75GlWJFiV9bx79w+nCeBvHitEfoBkB9RfJ7BptlDfR7Efu1DIXYjGcMtvKXtOsg1750CuYlLq2J1aCdldz1/ZQfuE0cHXB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471294; c=relaxed/simple;
	bh=Bssuky49KgzsBbl93nxGJPM72qehHS0AHF2yOa7tEJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Plbscm+YHABKZ8TDCTi/lSXlb+qgMSSPkozOLrstkjNW7Czs/wMFjsWRE5xJ2S6UdQ5783AxzneUDo4LlLCAWFrWPTSCXAVjgpLBPg8s5ArzL4SI80F55QC6zl0bAxQdLv1wryDDo+1z9uVX1Ce5aPyQ/xZefBqUIajXfsYK8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3G1DDF1J; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed82e82f0fso1559021cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 15:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762471291; x=1763076091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgqQMv8vC1wnvm8jLlkIn4alZVszPP8l8LlzETRj8QA=;
        b=3G1DDF1JFmZfPkbOQeJ8B96axX0JFB/PgZsEhVJ6kEVsVq9Pux5msW2qh79rORZhwq
         NkVo2fiUmLhZEk2C5FOe1qB4a9l8JkQIMxL5gx2HEoLgD3IW7WrkluhnDdFhC659EW3K
         ZnTJzsXzc0ZUT75fyqtWOkVmVZWq8YxED3XRH0D/wi5ivOCu4cHI9xLHeDC4VJGALncy
         Bq2MRqXA7A9GEjafBmSjRe7lVNmjDJqKXM9WYY9dKvTI5+9B0m7StRN/2vLE83bmE4LG
         1fqcwoWXczip1F3eKYr6NWC/rKipoCRbBgOQKeub7cyosIqyC66Z1WRG5DBMV++BIetg
         fFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471291; x=1763076091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgqQMv8vC1wnvm8jLlkIn4alZVszPP8l8LlzETRj8QA=;
        b=fDfu7XMcH40o9kizFY4OHbTeHwzcKamYUsbjo5IBpBoyLIoigs2jrnMklSoRJJ6UXn
         +9tQJ7Vy6wo3OZNnuWaqB2q9MktRRuBeQoA4YPkbpjjhTcmegV4TtVRm5MZhQDPe6wVe
         CODoy49au9r/GCX3YHx92PnnKXYkkHBZKaRz2QLmhn6fm3Ac4NCLO0UxcJngtmYV9QBA
         OwhdBo6GGzXyEybxyx4OVzNcCx/dsw9KSs27jwT2jPftUwXKAtr/UQX450rd7IQpOR1K
         wGLkZXbzzgfZWLL9tFDuDKCuBvvHf+k6pDZsa+3wWhV4tWHBwiciS+7Md5yuX26FX1q3
         0UoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXar3B6wFgbtReTaloSsOxEZiDCqZbAc/uE0M5uswh6kJIdQMgd6r6X5Ru3YmGD9x0dtJ9juvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8KUAVsGjwFF5s9oVcSdgGZdyLSarGg5GE2QD5WzIESRub+/K
	O9RkvcV6YslvpTE/uHzPs7wYlPUSXJ9U/fXJfBHBE3uA03mLG50KimiV634khaRbXqs=
X-Gm-Gg: ASbGncv6jkHWWKQfyBrIcFXHeuIVw2wAdV8F56F8QNrr+O7YykcO+Z+PIlm+Hw5aWki
	8oH5gzprvFjEKfkhg3Xvog0piUcCIyBIWKS0BBqGjWh61SyWJZ29WUg8pyUmt2XY2wNNCtc3tnZ
	2tz1I4Fi1SyCOfer2Lp2t8nCpH924fc1PUAJHPd461/UcLew+aWZtyVCOq4BNoiba7cLqg+7Aow
	ucOHeWsxs5C8LLAplqH/IcR0WkkrlICKgOiwc12FKNtYEXhmXxn20u7LXZZk7ZYYAM5GYjjNN+4
	JNRbwbavlj2DwtBUzvhRHMZF/r5ZsEYqQSxVGBNjo1UqfDQYgemOCLbgrw5qWSc+HKBYXQnzrZ+
	36OhbSblSdz+0xz4ZV5IdtknFNqJhzRaHSkI3YTmJFK5q16jaXTrJvVJxUGBAy7jzr6Jh4akq
X-Google-Smtp-Source: AGHT+IFs8nv2iSTBNiLQbQjkP0+tXreSWwWDjWUWICeAfSmO4PhPgvjHoBW7ZL7oOwk5O9rhFRsK0g==
X-Received: by 2002:a05:622a:2d5:b0:4e8:ae80:3e68 with SMTP id d75a77b69052e-4ed9496461fmr14560731cf.22.1762471290999;
        Thu, 06 Nov 2025 15:21:30 -0800 (PST)
Received: from [10.0.0.167] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed813f7333sm27047761cf.36.2025.11.06.15.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 15:21:30 -0800 (PST)
Message-ID: <c39297cf-daab-43e0-82c7-3210d570e427@kernel.dk>
Date: Thu, 6 Nov 2025 16:21:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] reverse ifq refcount
To: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20251104224458.1683606-1-dw@davidwei.uk>
 <358f1bb5-d0c2-491e-ad56-4c2f512debfa@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <358f1bb5-d0c2-491e-ad56-4c2f512debfa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 9:10 AM, Pavel Begunkov wrote:
> On 11/4/25 22:44, David Wei wrote:
>> Reverse the refcount relationship between ifq and rings i.e. ring ctxs
>> and page pool memory providers hold refs on an ifq instead of the other
>> way around. This makes ifqs an independently refcounted object separate
>> to rings.
>>
>> This is split out from a larger patchset [1] that adds ifq sharing. It
>> will be needed for both ifq export and import/sharing later. Split it
>> out as to make dependency management easier.
>>
>> [1]: https://lore.kernel.org/io-uring/20251103234110.127790-1-dw@davidwei.uk/
> 
> FWIW, if 1-3 are merged I can take the rest to the mix with
> dependencies for David's work, but it should also be fine if
> all 7 go into io_uring-6.19 there shouldn't be any conflicts.

Let's just stuff them into for-6.19/io_uring and avoid the extra
roundtrip.

-- 
Jens Axboe


