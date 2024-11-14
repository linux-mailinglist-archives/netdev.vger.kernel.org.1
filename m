Return-Path: <netdev+bounces-144817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6369C8825
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13229B2C7E7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BE1DD556;
	Thu, 14 Nov 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYJhEral"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBB18BC10;
	Thu, 14 Nov 2024 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580224; cv=none; b=l23chheQ/HH0ctljPp9hnvLJ617OBi+OHTIPGRl5KBJ5gPhKmZWnxoQDpdX5tY+Dsw5dYrqLRp6zgXSTA/EZ0cjyPrEHc+g/xiwjG8WTZu1Rpag0izKjPiJ0MH29eDpHJ6zwHIXDd2+X5HJAI1Xih0zBW1Zw1kdMBfXfUn6ED7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580224; c=relaxed/simple;
	bh=CQt4uRKvF7PH6iw9VUENoNmTzQnzRcZZTAq8zpiNlyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7J7O0n3tlOlpG4Og4Ff1dGW6cAKG/PN989IGN1SNZqgRfdv6UNmaRQbWv77EQyzwRylskXWdPEOFDrMAegqy6jraSFV4YjcA4hQ/cW06xV53s3sE2IzkgnBIp2rinQiBygt1l778kXmqWfDpJimMBeEizs+XpYPFpTJV0M1nCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYJhEral; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e59746062fso399923a91.2;
        Thu, 14 Nov 2024 02:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731580222; x=1732185022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsmX5OjlUHZqgK1VFRrX2wcj4M9agmD+HJSEbNg/BSw=;
        b=aYJhEralEKRWIBO+LsG+tYgBNSzpjLwwcgjIr42CKUSYKeZVpD0d5UeoQoIWy4tOfJ
         /ksdWzIbd9tSl7DkgMJZh2OIZTGBNP+dJwRuF8iXM4EFg5xUKAO7kvllp1jwayv2DKVy
         H8hMwl6DAtqZsyN5lYtOBymIm4qCRZohJeq0q6mqyCoRNr79OzOpSp2fTHbUW2BixfR8
         7sbgehq3mpIQdMkjwpYAWvRQMuioCqS5sK6era1Q6mgEoP0aXMp59uSsXRH5oYc68V0f
         KU+xL6HWkV3yrhT5P3OBopP0Ut1LZM4aus/1dV+QR6Z57zXx0MOHq351OR4kHmYQ0txS
         j1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580222; x=1732185022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsmX5OjlUHZqgK1VFRrX2wcj4M9agmD+HJSEbNg/BSw=;
        b=tXsI20JmTUnZQkp3qYOkZlpl5fwzlIhXs1htEuJrfRN+5j1ElYsef9wZ968WQxGwOT
         rRaA9jNWfCnuiwGSUbNcf6TmIWSEztTLqf+2qP4mp4TTNmK0yOPlQ8n8ebdO2fAS/KWP
         qDtrhMRVRIEszDlXZlXAlLh0Iis7uf1bRoBsltrVj/UnnLEUpCsWBCx/YbZdNUoT7DmL
         CJ+m7WA3/wYsOI0EqF+EeTiQTukR5fy2E30rtyxqXqIylcj6khCQ/Nx0VP0IbwMgupSw
         ThbpCZYf1T5/m1O2xqaJB2KRQdA6LKSuRgyTScqNilz0RbcZq0WOMDYGeZ+K3GpIDcWI
         Y00g==
X-Forwarded-Encrypted: i=1; AJvYcCUHaBv6I6zc1buTVxQSHND2/yDhaurtg81j+uUCdPZ0u5znp6hcrpLlc+FYNFgHs5y8/mNQhdCFKjqPKv8=@vger.kernel.org, AJvYcCWKF1ByE4NO2QvRE4fiGrMgRFCOPDNLMxE9E4K235aqzqbGB/AjAIsLzFuOq48UMJ5UBnGh4LIl@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnYk5kxAeE0vRvWWDLdo3jN+7wN7gL7sqjtiLldr0s6X8VmNE
	jkR9xx1fjDv/QNajJLcGhuGPa12Cb3T3LJ419ll7DSZo5mWt1lQw
X-Google-Smtp-Source: AGHT+IHZpkchUXNpFzup3sYTufcuGWMmZX6+H1JgY+pCJWs9UNr+vLNKYAd+25zUI44mAy0CCzYLcA==
X-Received: by 2002:a17:90b:268b:b0:2d3:c638:ec67 with SMTP id 98e67ed59e1d1-2e9f2b3e437mr8182895a91.0.1731580221993;
        Thu, 14 Nov 2024 02:30:21 -0800 (PST)
Received: from [192.168.6.2] ([223.104.40.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c678d4sm7772495ad.110.2024.11.14.02.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:30:21 -0800 (PST)
Message-ID: <2e315da5-adcf-4f04-b0b5-4b416164ba3d@gmail.com>
Date: Thu, 14 Nov 2024 18:30:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chcr_ktls: fix a possible null-pointer dereference in
 chcr_ktls_dev_add()
To: Simon Horman <horms@kernel.org>
Cc: ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 almasrymina@google.com, dtatulea@nvidia.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
References: <20241030132352.154488-1-islituo@gmail.com>
 <20241104160713.GE2118587@kernel.org>
 <CADm8TemexVr3gcuhKJ9M4PLDg2bF85nhT17a8J1uf_qqj_fKiQ@mail.gmail.com>
 <20241108133425.GC4507@kernel.org>
Content-Language: en-US
From: Tuo Li <islituo@gmail.com>
In-Reply-To: <20241108133425.GC4507@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/11/8 21:34, Simon Horman wrote:
> On Tue, Nov 05, 2024 at 07:32:31AM +0800, Tuo Li wrote:
>> Hi Simon,
>>
>> Thanks for your reply! It is very helpful.
>> Any further feedback will be appreciated.
> 
> Hi Tuo Li,
> 
> 1. Please don't top-post on Linux mailing lists.

Apologies for the top-posting; I will avoid that in the future.

> 2. I think you need to do some careful analysis to understand
>    if the condition you are concerned about can occur or not:
>    can u_ctx ever be NULL in these code paths?

I have carefully reviewed the code paths, but I could not find any instance
where the variable u_ctx is assigned a NULL value. It might be a defensive
check to handle potential NULL values.


