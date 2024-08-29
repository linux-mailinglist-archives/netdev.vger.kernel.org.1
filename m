Return-Path: <netdev+bounces-123171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE5963EB4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD214281F04
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0E18C02A;
	Thu, 29 Aug 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVhbGnBe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC2181328
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920517; cv=none; b=cGlPe0lnJOjF2x4ArbX9Q1XAkPTT2GxLdOFtyWDuTy6JkXI/MRnBHuDPxVHttqx2GEwmsOFWUUNwAgLDRHaQAzDfS8UjOo24zD6u9rg2v/Bd2ylC2gmYjuw9PBf7cBweRH2bQYJ/vbPyp+u/ZJ/crN6vOs+PLGd7xCouxDqoMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920517; c=relaxed/simple;
	bh=niNKKgEBYnfmhH+WcSZ2c8MjqN1b0H5B++lOzpK3/nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwZI7VONBHxdD0rI5RQ8TUAtzWT+I3wdLjQNCxv3/V1cBGC5GRDZYAgI07ILTsQ3oBttf2ODDvo6L68EEXINatGtDoLzOAFmM+XN9EpAXZilyaFmUQiX2QMximTroha6UWg8Xw5nW+eXZMPrmTmF3GLqzxwEeaNEZqxZ84Mo+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVhbGnBe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724920514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLUymKuWt+NKQEaSszi9iMsr44QlqAxs4bJEIt+NlX4=;
	b=gVhbGnBe8xAVsjGBUIzYYva6O1zTLMj3FC/k/L5oTfAk5Wq3shxN6Qrdm7+2rLz5/E8l+S
	9zKKfXrV3x3imMxYHibyAz1/cwRECnYLioswQivhm75PqBNVedXzj3XWF1elfHpxHDfAH9
	cHMkuu/R9NNpPRm3h0+JxVdTaBz8GrM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201--sjSSDceMnuncaxPimU07w-1; Thu, 29 Aug 2024 04:35:12 -0400
X-MC-Unique: -sjSSDceMnuncaxPimU07w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280f233115so4060245e9.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 01:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920511; x=1725525311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLUymKuWt+NKQEaSszi9iMsr44QlqAxs4bJEIt+NlX4=;
        b=YH9Hkgf1x8vKoTOSNIiKRNxmEj+5V2FP05gSEiyQ9jHR179VeIaQzY0SJj6Sx06FWI
         yIZIaPFr1e3UYSY3sSA34wbHrj0n55kD5DKH2TryhmCuUHa3t6taAGlNpoh1Qx85Udw8
         0oY73q6RMmuQT6+BG/TY/n8vHCG6k1m0V9oLyUhkpG/2TQoFCypZz8PSF64u4CvxyH5r
         KN77TSSD1mntyUCkBuChvRrWzSFIsQu0howrOAyt0YwMVCzUdYs8Y0GnY+Sa4bjgXOQo
         9l+QtvtIyQy5G60ig2Ocvb2c6J7QJsUUX1gmrPWidePsCH2RWy9He5t5oUISqn32XLfY
         uvKQ==
X-Gm-Message-State: AOJu0YyDvetGYRQExo/tiaY9h1NIgsuX7nXUto5nz6vI4x8M2x6V3IHA
	XjGRLxH8w9g0yljsLDNEBiwuqTMJOcEAg1ToaJj9mpY2+t0PdhtREuj2o6xTBZA2eGFZHsXI/TD
	+HBspfOxRSfC/VqYrUzUpjjUu4J9C9paT8IzdG3wbC69R5OBaTad51g==
X-Received: by 2002:a05:600c:1914:b0:428:52a:3580 with SMTP id 5b1f17b1804b1-42bb02c071cmr13817465e9.3.1724920510998;
        Thu, 29 Aug 2024 01:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEInkswj2i86rE05dq/qQudbVYtuioUD9hZw1RN+aFdYAm3WNKMqJjr1DkacydPx99iOnthYw==
X-Received: by 2002:a05:600c:1914:b0:428:52a:3580 with SMTP id 5b1f17b1804b1-42bb02c071cmr13817235e9.3.1724920510473;
        Thu, 29 Aug 2024 01:35:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb85ffbadsm3711905e9.12.2024.08.29.01.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 01:35:10 -0700 (PDT)
Message-ID: <399397e3-467a-41aa-8bad-90c80954764a@redhat.com>
Date: Thu, 29 Aug 2024 10:35:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: netfilter: nft_queue.sh: reduce test
 file size for debug build
To: Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
References: <20240826192500.32efa22c@kernel.org>
 <20240827090023.8917-1-fw@strlen.de> <20240828154940.447ddc7d@kernel.org>
 <20240829080109.GB30766@breakpoint.cc>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829080109.GB30766@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 10:01, Florian Westphal wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
>> On Tue, 27 Aug 2024 11:00:12 +0200 Florian Westphal wrote:
>>> The sctp selftest is very slow on debug kernels.
>>
>> I think there may be something more going on here? :(
>>
>> For reference net-next-2024-08-27--12-00 is when this fix got queued:
>>
>> https://netdev.bots.linux.dev/contest.html?executor=vmksft-nf-dbg&test=nft-queue-sh
>>
>> Since then we still see occasional flakes. But take a look at
>> the runtime. If it's happy the test case takes under a minute.
>> When it's unhappy it times out (after 5 minutes). I'll increase
>> the timeout to 10 minutes, but 1min vs 5min feels like it may
>> be getting stuck rather than being slow..
> 
> Yes, its stuck.  Only reason I could imagine is that there is a 2s
> delay between starting the nf_queue test prog and the first packet
> getting sent.  That would make the listener exit early and then
> socat sender would hang.

As the root cause for this latter hang-up looks unrelated, and this 
patch is improving the current CI status, I'll apply it as-is.

The other issue will be fixed by a separated patch.

Thanks,

Paolo



