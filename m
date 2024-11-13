Return-Path: <netdev+bounces-144443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280619C75A7
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 16:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E1AB24604
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AF7757EB;
	Wed, 13 Nov 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WYEV8c1B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10433FE
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510458; cv=none; b=uI5SUYFGhpQ9u6RpT+ERFFRi2DVa1BlXUWXjFrL4GlO0QPNXAKsZVdylpcyWPT9A1jf6iJhaNEss5keeRfutMzAjidgrzf/vdHEweApuP55nCWODWzHWKEr7Qpw9wKOVVZp0kC1vN0C1sPHD6enTmMEIlti7q93xrZt3euN36Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510458; c=relaxed/simple;
	bh=iwTQ6QZn74jR3NSu9q5INrInKGUMQX5Cm4G14lNSz3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzgWUJqcdP3z2QW3B5NBBLbtprwSC9tDNaiBSjt1uFQJFC/YdcZCg6KZZqbAQUKjpFIOj2HtWznoCEB+HGetEpD2hHEW1Q9XtevBrO4tCRyHz47oZl5pI0s4J7zgeSMlTtz17cppOYPA14QhVK2J0H0c+HhPiQvNm9Jk/natgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=WYEV8c1B; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso4257757fac.1
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731510455; x=1732115255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUXfT5LbwCtNVc6zLtCSEDjWsVHJbvn+tz9JggVl+0Y=;
        b=WYEV8c1B0UVrhX0GiC4zimAplR4+BQgeQPoKQqJoxs8z2B3nqja5gAwqw6rXggon7t
         BgiRnCXWKBVGhtvzahyXpIxOQmN5QUHBQ1LAd6GCNf14LT7/NRUcSnz0GSw4mVEBHuwh
         AUB1h9Z+cLYDFNSiiq1dBO8j1yETpDkBIAZyfBAX0A4agdcT4t/MQ9cDwyVd9fT6NXuv
         a2VkduUv/Xq1UyFOl2f9Q7+MD9j4yooHkJjNmIy3nvw9x+5ZSgowLpw/s0/WpYMNp4wj
         ryxNCuOEilY/fLKSH7bhTvCxxG9o/YfUtOJB+GK06FddZr8gmpFXTxxwyX7n+OoDFc8d
         qbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510455; x=1732115255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUXfT5LbwCtNVc6zLtCSEDjWsVHJbvn+tz9JggVl+0Y=;
        b=T3ouBKZkViPRQiLPb1PY+sMtMBxSYWiHOIGqJwrE9JNMSf0BbLhV/qF/srgBPFDScX
         HPtv0B0JpExgAXAZpecVmPLiaJ+N6IZCwAGiJ+avjuMYDHRf/E2IAeeF41lcrkf0DOsc
         FrxSqYteMUJ77Te2RHfurm79ZCkQ0V/W1mqeIZF2ht4k27CnHzeR5DVcM8Dy82qlpjep
         U+gOfkg57HfKpKNd+wmOruQ4VOUX5mKvqXzv9Ce2tyGghaoHf7MkStkc+jeyB/ebOHOo
         RrOgl7JbwRTTZQGHC1oSyHx+p706F6JUBQ3aUU6n87FPlr/mJ+w//nxdGsTZmm65mwPt
         Fm4w==
X-Forwarded-Encrypted: i=1; AJvYcCWaQYu5SYkOZJ9ra+ixHPOJ4BSBFtxTIWcb5HgAUxBjSOLkpdRQaMew42DDDbdYUqfCaA5B5CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEniLUqedt7IJJzTy3g18adYGBtmRpvPaNY7TSULj7KHnlWbL
	gbnReKCgWXgs1zRq5wg9fsTW3Fqdyrgla2Q1Qu5y9N+PewQtbUbMkyrjkxZUsA==
X-Google-Smtp-Source: AGHT+IEDB9CxI8MR5vDrvtjhoHKPvW0hO9z27i301Giir0OgKIhsjtvneGhaR0fW0r2eag8oUlyVww==
X-Received: by 2002:a05:6870:9e8e:b0:270:1fc6:18 with SMTP id 586e51a60fabf-295e8ccb3c2mr3666738fac.3.1731510454802;
        Wed, 13 Nov 2024 07:07:34 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:1eb0:5ce6:8274:8cf5:b576? ([2804:7f1:e2c0:1eb0:5ce6:8274:8cf5:b576])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee494fb095sm2951435eaf.6.2024.11.13.07.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:07:34 -0800 (PST)
Message-ID: <08748e91-0ed4-41f7-8c4d-85690e5fd845@mojatatu.com>
Date: Wed, 13 Nov 2024 12:07:30 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sched: u32: Add test case for systematic hnode
 IDR leaks
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 horms@kernel.org, alexandre.ferrieux@orange.com, netdev@vger.kernel.org
References: <20241113100428.360460-1-alexandre.ferrieux@orange.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20241113100428.360460-1-alexandre.ferrieux@orange.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 07:04, Alexandre Ferrieux wrote:
> Add a tdc test case to exercise the just-fixed systematic leak of
> IDR entries in u32 hnode disposal. Given the IDR in question is
> confined to the range [1..0x7FF], it is sufficient to create/delete
> the same filter 2048 times to fill it up and get a nonzero exit
> status from "tc filter add".
> 
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

