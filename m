Return-Path: <netdev+bounces-79557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B75E879DE9
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359E9281B76
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4535D14374F;
	Tue, 12 Mar 2024 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XogGqnUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F35143732
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280416; cv=none; b=EIkJYzwHq/IE8SAv/viMFhyCfG9ybN/XuWUE/MQib+SxOG72h/qTdeoj8kOx5HpAzqCHNJI9g88Ugljo717AHQj+c/EZQBv8MIMeCx5dVtPHuQ+QTULXNKly/G7CT/9JrMkMGam2Caa5apdtR47/bOMrMhRHiPbpuDDblMAal7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280416; c=relaxed/simple;
	bh=GoH2vZtMQEyHzGMu+xjFvhPYeQ0PSvOxNtV0ej76tc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov/TAZdZwx/hBG+IN36WHWTKIhJ9yadFlpE7W45BMnpCYxqla/wpdthWccBfcXJJRtHI4aBjltGcZpivAuN341CY0fuQdPMqKpmWQNlAy++F6BELuj5po2FwWMOAG19DhwExcUOgJfE4OATBJsrotl54J6g2VRCcXd5YD6TScBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XogGqnUM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd3c6c8dbbso10043105ad.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 14:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710280414; x=1710885214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgAoRXoGVuTzBazMoZQBPTv5bpPC2DD6aVA+CvxbndY=;
        b=XogGqnUM7Bh5JnuGKX06R/t/aiIHEjMIZc3n0YJXm9qy17C5KE2EMmkT4jIjsZRc+H
         iHaaWfyDOtg8cY1T1XXgkM4hhZcfH6mx4cBz6rxxk0LoEPf/RIlo/H2Cz5XlBawAjnC4
         cHVf975xy9zEAKCSx7CRpeU54++CYA5IrKic0EY03Y/Jf7lwgNRe00mWQGzhOLtakdy9
         QsO2GuZIeP5uUUbpkU8epQ6F+4dNH0DKJQVU5lzhkC/3iuJhYkoDXfhqjQYYOeYUiTk1
         cveG00kt4oO+O0PdddOwdQCvFbawaTvKxu6zdu9ZR4I06nMVbZ35RE5bFb1pz6PUxr5l
         9xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280414; x=1710885214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgAoRXoGVuTzBazMoZQBPTv5bpPC2DD6aVA+CvxbndY=;
        b=PhsEiaFwBPhMpxCLfZE3vm7qZ/Gq+PLfmhfebxUhpfUKg9pt0T6jRzX3Ntyg5A/RHn
         fGkfCTLB07W0U92I+/jjA91XifJCUhifg8opplrPTEqQXFAd1y3815dUxp4wxfe81n5T
         DNHWv1NcQHAZQP0wb2z3MFbQDoIQ+/l1zW/LTQKfPAvWHxWId7F5AE77MZ6aHnnppoy5
         vdt2rGdAcoqVdjauzEiXy9E5Nr6CQx8LbscHL2P2SwMIoAJeMmyCXDMGKuRV+J5nZ0DJ
         dyRg3c6S4mOXC75dlzS7R/lSSBBYQtFT3b1UH5PdLXhsWmBu/KWeZ48zAcGooK9nBN8I
         +V1A==
X-Forwarded-Encrypted: i=1; AJvYcCVRjV/ruez1wYaQpDZSzL7lB5ZgRkCJyafdfykwZzfbsSTz06Xc3PgCQO/rlz66gyauvCdNIFZ16GMA/uALtSxE7lXc3Gc/
X-Gm-Message-State: AOJu0YyK4ylZVd3gUxWK+tk/pzqqAAD52IJ1SLovWngK23zWAHUR3Evc
	fhKxWkjDJX4t5ExVfL1sbUVf279+/ftlshrkmwuQAOPj4UJ58kYEqjY2ZQLGrDc=
X-Google-Smtp-Source: AGHT+IFm+/i67+6f03mMl5NqpTg05G9OjYuNth18e7nFR3xYoxgZgBTMSLZXo7FSveVxVdE8GFo8GA==
X-Received: by 2002:a17:902:8a91:b0:1dd:7350:29f6 with SMTP id p17-20020a1709028a9100b001dd735029f6mr3069799plo.3.1710280414017;
        Tue, 12 Mar 2024 14:53:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b001dd69a072absm7228013plf.178.2024.03.12.14.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:53:33 -0700 (PDT)
Message-ID: <72921846-16d0-438f-a6b0-eef704542e6d@kernel.dk>
Date: Tue, 12 Mar 2024 15:53:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.9
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
 <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
 <20240312133427.1a744844@kernel.org> <20240312134739.248e6bd3@kernel.org>
 <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
 <39c3c4dc-d852-40b3-a662-6202c5422acf@kernel.dk>
 <20240312144806.5f9c5d8e@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240312144806.5f9c5d8e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 3:48 PM, Jakub Kicinski wrote:
> On Tue, 12 Mar 2024 15:40:07 -0600 Jens Axboe wrote:
>> Hmm, I wonder if the below will fix it. At least from the timer side,
>> we should not be using the cached clock.
>>
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 9a85bfbbc45a..646b50e1c914 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
>>  	unsigned seq;
>>  	u64 vrate;
>>  
>> -	now->now_ns = blk_time_get_ns();
>> +	now->now_ns = ktime_get_ns();
>>  	now->now = ktime_to_us(now->now_ns);
>>  	vrate = atomic64_read(&ioc->vtime_rate);
> 
> Let me try this, 'cause doing the revert while listening to some
> meeting is beyond me :)

Thanks! I think the better fix is probably the one below. I pondered
adding a WARN_ON_ONCE() here, but I think just checking for in_task
state is probably the saner way forward, just in case... But I strongly
suspect the previous one should sort it for you.


diff --git a/block/blk.h b/block/blk.h
index a19b7b42e650..5cac4e29ae17 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -534,7 +534,7 @@ static inline u64 blk_time_get_ns(void)
 {
 	struct blk_plug *plug = current->plug;
 
-	if (!plug)
+	if (!plug || !in_task())
 		return ktime_get_ns();
 
 	/*

-- 
Jens Axboe


