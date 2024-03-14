Return-Path: <netdev+bounces-79910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC587C06A
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C7F1F238CE
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE171B27;
	Thu, 14 Mar 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QnpQFYBw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454671741
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430561; cv=none; b=U6pIxzQ8oq/6Bg8ZhQkNnA4xfYgXvGFQP0o9jd6neAF0dK6VVXerwRCchGHd2j9Sx5H3DsEaJMxvSufBUQFpWSfra9oH5zfbgHxK2JhQzBhiyGd4h81T+rCndfok7Ob+OnxRIQ6JUiRKjhFNTY1hE17JVNrxeAih95oFZnRR7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430561; c=relaxed/simple;
	bh=eM734vb9xUexlVACzQFX/BVRnw+6JF6fzxbUKHT2tkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiV34strYJSFt/5qIgklpXBUrH4SoYBNkYN3ElghFz9CIlHNyfEEqSxywVPtJngvt+abSJQ6ge3Nvus8BWfQaVvR9REkKsztyrRai+rRq2D3DWP1O4DcrQpZOBIPcYMAVmfXqOrT5gBxLqaLMKQ1MRg4EZ0Ipj3S59WcZc+4Esw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QnpQFYBw; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-366478a02baso1914755ab.0
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710430557; x=1711035357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8m6RYp3Or4a+DPO1B3zljGsIMd+DNLdiEhGRBtPs78=;
        b=QnpQFYBw5nOHE9/P2JG0/jHKV/WhbLf+fCiWhVKVjpLaWuO2dD5ENy3Qr8C40NH3A6
         lUaiTPY7pLUI+aXAkUan+eDb3qXSmlp78ZuItBK4qt0h2yKnbbLT2fsvOmloIfB5eDRV
         a3qQeIQd1I7cV1VAaboCN7Qcp4ApWdOgMbhBW8UyRW46uhZ8wg9sOb0uyXlS2Wjkyfzk
         EAdPiSXfKQf6UJ+Xvww2XdYurUumLbtgVCSo46y2tFf2+CWSeao20KWR6sRa5WW42rBL
         Hzm0TG0O9l739aDALgV9Xm8Uu+iTiyu7klqhACKI9rhzwcdlGO970Ut9hDrkTdRWq7QP
         2mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430557; x=1711035357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8m6RYp3Or4a+DPO1B3zljGsIMd+DNLdiEhGRBtPs78=;
        b=DtIxQhBvEuGYlNLUFMkafZzhnsbGXQlZ6s03quOv9PW62PTZS9t4whVNxOzn7Q99FY
         7smrnKI7cufcND0q5kijhiIqub1jJKHNYCcdVyGYRYJY7OJ7NmGx8GFM9jBOIMaimZXd
         CNWPxUHvdVbkqgb/JOWkBp7m9cjoRiprtyVJT4P9XGq397BSSaqTQ1syQVj7ke+iAPK6
         KAFa2HZFKVSMMv8901gcaxemEIlHyvSAKFLeqZaT9uL3diBbpUsOdM39DZlYNv/Rispk
         mTBLsEHSEBbsp80N/RvFKyoHrFT/SD6p0N5kjxkoaXAI6T7r/WUmlyaC3MCRBWc7W/So
         rBUg==
X-Forwarded-Encrypted: i=1; AJvYcCUQSH13Qgali+j53TAC8se9a1pIwE9QhZlwgrMBu3mNA76yisrpLk5ZH5hpqwbK5D2sFcuFDfyIBN0Is1px7Syj0YCOdvxA
X-Gm-Message-State: AOJu0YwFi8QkMYKvO4TtM6Ph+fuPodozAOebHtbXTY4XrGm031pOqWEy
	I9U62ZbV780PbPdCzI6ym5nWNCfu1csuyf5oeysbIeI9B5JG7JWM7mG/yffRXyg=
X-Google-Smtp-Source: AGHT+IHmMET+XQkb9fCPqsFHuiuWejVcRYpOpiE2dYaty3xKoiZUV6r+NlK8JpLekSdI/s3pte2XNQ==
X-Received: by 2002:a92:6f10:0:b0:366:7d03:eb51 with SMTP id k16-20020a926f10000000b003667d03eb51mr1756525ilc.2.1710430556924;
        Thu, 14 Mar 2024 08:35:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a20-20020a056e02121400b0036671d56e27sm202119ilq.58.2024.03.14.08.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:35:56 -0700 (PDT)
Message-ID: <b24043fc-ceee-4e84-8c92-de412a7557ae@kernel.dk>
Date: Thu, 14 Mar 2024 09:35:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove {revc,send}msg_copy_msghdr() from exports
To: Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <1b6089d3-c1cf-464a-abd3-b0f0b6bb2523@kernel.dk>
 <b44a7fe3ec2c595786d520382045cf7b5ffce3da.camel@redhat.com>
 <cb9b4e2c09131901a97c233ab2e18cb8970e09a3.camel@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cb9b4e2c09131901a97c233ab2e18cb8970e09a3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 9:16 AM, Paolo Abeni wrote:
> On Thu, 2024-03-14 at 11:46 +0100, Paolo Abeni wrote:
>> On Tue, 2024-03-12 at 09:55 -0600, Jens Axboe wrote:
>>> The only user of these was io_uring, and it's not using them anymore.
>>> Make them static and remove them from the socket header file.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ## Form letter - net-next-closed
>>
>> The merge window for v6.9 has begun and we have already posted our pull
>> request. Therefore net-next is closed for new drivers, features, code
>> refactoring and optimizations. We are currently accepting bug fixes
>> only.
>>
>> Please repost when net-next reopens after March 25th.
>>
>> RFC patches sent for review only are obviously welcome at any time.
>>
>> See:
>> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> 
> Jakub noted that waiting another cycle just to do a very safe cleanup
> would be a pity. I guess we can do a one-off exception here for good
> reason.

Thanks, seemed pretty silly to defer, and given the nature of the patch,
there's no way it could've been sent "in time" anyway as the io_uring
pull needed to go in first.

Besides, I would never remember to resend the cleanup and hence it
would've been lost.

-- 
Jens Axboe


