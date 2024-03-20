Return-Path: <netdev+bounces-80855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C35881534
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACD21C22442
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9730A5466C;
	Wed, 20 Mar 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XHgD0N30"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A936137
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950781; cv=none; b=JSI7XS8dRBRVLwPqY3SbYoc0aqsjgXRSLw0jWJq/QXrZOSikwq1uE/Lw8PIkQbEfZRVzusm5nzJ0n38McCn3Zi3ZLT4EtRkSFYcshvd52PP4eRqxniy/YRbZrvYTLioGXQcldVosc08vE7+ShBuD/nTYRlaLU4Fn0nnSebcIjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950781; c=relaxed/simple;
	bh=s6NQedUXfZwfZWCI8U68XDjk31dsNA/Vfqft+OrXjBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COReb05UzXDEk6IigptXXNBNNYb4Q9lr7+WoSwcm1hFz5MC1KhOov5IjSESgl2MvfHx/ITazh/sXz+7wRIn1LWm5GjEGfj6zgdZQDy6rk5xu13LIY4YIh7dDq5Svunx9oG54pbfJplcJjfi9iqAVAT+cposw9sSAjEV8h+yx1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XHgD0N30; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3417a3151c4so2491933f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710950778; x=1711555578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8jmgWz3VAY8ZzreiulUbSiKLh7pUnFJyujK1sVIPS0=;
        b=XHgD0N30+56AvxO3Koh50UrU+fvuMVJzH5XHI66m5HQeHUc5XywJAHgdhcV/wQS2Qn
         48v6f+1G1pNAzO69QBv05Q1QDu3Nugs9TjZJxUB+v+MKYXdVUAJGmsF7Z1RS6AmWvdo1
         T8zq6vi/RXNdsyhG1ANCzCAPweApB2YA9rAOD0BBIdMyncuuff72vRp1QV06UMnRTAUT
         cRgMbeIXZWRUHAIpcNinepaiSUKbiXdxCD3gR/4CQIg8AayqHRarH7qCRAEPy6ZVusoc
         d0dMAeUpiaOFOr+srddJZRLpSMDdikuvjsz6fWfU8U2YymLz+dOxz0IO/lAAz8+Tq9Lo
         lWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950778; x=1711555578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8jmgWz3VAY8ZzreiulUbSiKLh7pUnFJyujK1sVIPS0=;
        b=CLuR08z1WPRV3RDGW/PrfeJGrS4nqZky/R0CoUIMQwRBaUCVKbVhbwGAbxZs/r40b6
         Yb1MnXGiMWMSW9rhbP24jR0ZBPykNfDyb6TQP2ROaUQZPx+asCQ07VwXlqfeC1/mvueu
         rdbjSlrJmZ2QTV4GYKpnpzSfT5SjTPx+cVJq5zYD9zLet1kgczE3ZI8XCR5J7ftYrjMY
         i5BW6Q5mbNqMlkX2ZCjzA0/GBYRnEvReg9xrUUWD8w0NqQD6FqxVCTx9LNFJoJkGo7EH
         OHaR4o1ZqwPKvKgD4asyPsTmvqKo40GRdL5bX7+3mkaVivEoKz0Y96/q0lszK11hMPrs
         0fZg==
X-Forwarded-Encrypted: i=1; AJvYcCWJQaSyO5FWwfQOm6vjLMU2KVNjpYp3/iL6lh/mU03eCMDTQcX4mmNIataQcY5rBPEeuUGVGuDlUpck5gFEF59vQNzl5VEA
X-Gm-Message-State: AOJu0YwFeO0Ebu9afQJsrJLwC5dzBOYspWHRgvq+ZBhZB1q7scucLNOK
	hz4MlRbLT/8zpBJrjetZrbPbyzLyDTOr2kY+18UMj9zXECnFeSmoAIuMd9bBGDQ=
X-Google-Smtp-Source: AGHT+IETNVMK8m1jhOjqYEXAI9aTcnCW2E/0idMKApIbeQQjKSCih1HznLYl7yI8UjVpUVh5TwQcZQ==
X-Received: by 2002:a05:6000:ad2:b0:33e:c7e2:2b64 with SMTP id di18-20020a0560000ad200b0033ec7e22b64mr11376760wrb.42.1710950778011;
        Wed, 20 Mar 2024 09:06:18 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id o9-20020adfe809000000b0033ec6ebf878sm14939300wrm.93.2024.03.20.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:06:17 -0700 (PDT)
Date: Wed, 20 Mar 2024 17:06:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: Claus Hansen Ries <chr@terma.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"wei.fang@nxp.com" <wei.fang@nxp.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"harini.katakam@amd.com" <harini.katakam@amd.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"wanghai38@huawei.com" <wanghai38@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: ll_temac: platform_get_resource replaced by
 wrong function
Message-ID: <ZfsJeGf0uRgKxj-W@nanopsycho>
References: <f512ff25a2cd484791757c18facb526c@terma.com>
 <20240320152246.GU185808@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320152246.GU185808@kernel.org>

Wed, Mar 20, 2024 at 04:22:46PM CET, horms@kernel.org wrote:
>On Wed, Mar 20, 2024 at 02:19:15PM +0000, Claus Hansen Ries wrote:
>> From: Claus Hansen Ries <chr@terma.com>
>> 
>> Hope I am resubmitting this correctly, I've fixed the issues in 
>> the original submission.
>
>For future reference, the text above probably belongs
>below the scissors ("---"). But I don't think there
>is a need to resubmit just because of that.

Well, otherwise this will be in the git history forever :)


>
>> 
>> platform_get_resource was replaced with devm_platform_ioremap_resource_byname 
>> and is called using 0 as name. This eventually ends up in platform_get_resource_byname
>> in the call stack, where it causes a null pointer in strcmp.
>> 
>> 	if (type == resource_type(r) && !strcmp(r->name, name))
>> 
>> It should have been replaced with devm_platform_ioremap_resource.
>> 
>> Fixes: bd69058f50d5 ("net: ll_temac: Use devm_platform_ioremap_resource_byname()")
>> Signed-off-by: Claus Hansen Ries <chr@terma.com>
>> Cc: stable@vger.kernel.org
>> ---
>> v2:
>>   - fix accidently converting tabs to spaces and wording in commit message
>> v1: https://marc.info/?l=linux-netdev&m=171087828129633&w=2
>
>Thanks,
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>

