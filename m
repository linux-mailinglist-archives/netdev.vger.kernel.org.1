Return-Path: <netdev+bounces-156517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25DA06C00
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 04:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4A51888BD3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E73136658;
	Thu,  9 Jan 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="FEkYADZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85951C4A
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736393220; cv=none; b=nesUyG2zIQKKZMZKQBc4dwLsSNiZsgzZTVNmWscjqunWYDt/nrK2B4W4ouIlCuo6NQ4bF12SCdc5eCj0HNofcmbD92V0eqkPRbhnFfFOYsNzkU/WRyv5lmmA69vo+bR2yX5KexKlZLZpqeQi/Q5N80qhwaaU+X6Ayq7mqMBwf0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736393220; c=relaxed/simple;
	bh=nPdvVR8N8j8Yx0KIPYySa+IOLme3kcjl7tqJ9EaOsLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRSdjqpZVrU6NhXfmYEhdqaeTN9ngbZjoJlB4UmxsXWsE9Roci6GqoIywfGQpaXaYoQxYV+wU7lZNOmt1Rf5ykHjOT1Q6cyjcoZMzJZwhZOXaoFHph8rZz3ysmv7HxK0pBQXoCklN7UZE8GahHLTbCMonttzGKEdwMbvYe02Y1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=FEkYADZ+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21631789fcdso20645575ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 19:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1736393218; x=1736998018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzuVW+OPCT+RHQ0ks4dicbQ5JZOeyDFGTM+oaD9Mb3E=;
        b=FEkYADZ+jyhLP3cBYODzLcxPlI/1W2IL+q5tjZ8sysHs5dxoeICeZ2A6UVM85mI1m5
         LkTygTTIfMxQkbOB8mEVwfy03ZhcrjRHDv3GD9rLpzv1Q/jajpAt/QQfEsUi1ryFavWs
         FyZFkOTPE845queTQU1/R2n+uTqsP6iNmvMBr9JtEhCQtMGAFPuIvxAQF7cj/mpFzYa3
         1GmOJ7xFlfs9dpi9Cby+s33Zzsy5jCXPyYA5bAyTBr9CXUtjyKvTs7NZR5dVHrUov/lB
         d0sgxVi7dbE/yFyJ0h3wVTyz6bCkJtWt77bFbJl5e2zrQEPI03t3m2QrHAQT79yfEJjS
         8Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736393218; x=1736998018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vzuVW+OPCT+RHQ0ks4dicbQ5JZOeyDFGTM+oaD9Mb3E=;
        b=RMFbhzcyNEBL1jhJ6598Koe0+WA7TJJXUu+Cx1lm3FqzrPAO19IcnzucnA8BPtWkwn
         0vDnMd7m3tXxJXKaiMGFMjId1nFjc38fWzEnTr1qo7orbV4PmAuVjNtusG+kRs+n21uS
         ZHV9wTt15zLbkiMNomjNouF/9SrypQp7iBNJhPF6+CDH9JKohls2c0FZEth85aDdzZ6H
         QAJmXgVBaFxIWQdY9/+3Hnsx/FR+saQXGcWgYZPizl/7LhQG91URhsHMwWzF4CdZPpMR
         IOLwByuSxsG2PoHXR0wiNY3/eRrUn9q5UlFtlHqgxSl8m8Ada8igvYFEyTJ0THiVq5dJ
         GlCA==
X-Forwarded-Encrypted: i=1; AJvYcCWabnRW3MgD5uNino1YBJLfyCNL3MUU5IAeQUgeIMrIsR9k5fk32C0m0zwwaR0u//AxPX0KjE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZaxxmr0uvdTxJO50gZXrmX96IDRmi+PHrImyYDD7OZSQj3Ekg
	DNUJfbw+VTsoQPyw9OHWDr8vqgIHJPtxdog8vWqvR6LL1Do7AV2253ryihbtDgg=
X-Gm-Gg: ASbGncuMb4aJaQtyfnFvcLBYktqu3nKxRpw7hQIGEZ22UyGAxQDIi/I7D/LELVRdpWi
	qYUvza0oUqm9m36HGd/dlpmeiV7iqMRB51hhDZE792TYTIAgaYnd8zY4Xk3s3de/MQgiYASh6tN
	1JCWg9O25god9lsnPDzRFRVM20IOj/JymYBTEvFR10wJdkOJilINlNheKPtewU04ehwNuvpl3/K
	X+nUyntiFbZdFCo+fyZ9oPa2HYNGn674cedDJ+XJ08P1BgyTw/AzP+dzhp5WP3Z/DyvgeXTqI/x
	mi2WIqYvN5EnCDSILIko3ihncpnDjWQsYZu71ZJ/
X-Google-Smtp-Source: AGHT+IEkDKkKZMDtdD5Juv0GWBv1ipKP+wto2lLIwnmxILwjlfimkoSSXpONvzILV/4efJhapoRqsA==
X-Received: by 2002:a05:6a21:9017:b0:1e1:b023:6c89 with SMTP id adf61e73a8af0-1e89cb8f314mr2249602637.15.1736393218401;
        Wed, 08 Jan 2025 19:26:58 -0800 (PST)
Received: from [10.54.24.59] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad848020sm36008714b3a.81.2025.01.08.19.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 19:26:57 -0800 (PST)
Message-ID: <0d625c8b-f1e0-4562-aee0-b4cbc8fc5737@shopee.com>
Date: Thu, 9 Jan 2025 11:26:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
 <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
 <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
 <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
 <87e945f6-2811-0ddb-1666-06accd126efb@gmail.com>
 <0d98fed8-38e3-4118-82c9-26cefeb5ee7a@shopee.com>
 <32775382-9079-4652-9cd5-ff0aa6b5fd9e@intel.com>
 <1ade15b1-f533-4cc6-8522-2d725532e251@shopee.com>
 <bb5dbf24-ef80-4220-8b07-40eed9ac15ae@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <bb5dbf24-ef80-4220-8b07-40eed9ac15ae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/9 05:06, Tony Nguyen wrote:
> 
> 
> On 1/7/2025 7:36 PM, Haifeng Xu wrote:
>>
>>
>> On 2025/1/8 01:16, Tony Nguyen wrote:
> 
> ...
> 
>>>
>>> What's your ntuple filter setting? If it's off, I suspect it may be the Flow Director ATR (Application Targeting Routing) feature which will utilize all queues. I believe if you turn on ntuple filters this will turn that feature off.
>>
>> Yes, our ntuple filter setting is off. After turning on the ntuple filters, I compare the delta of recieved packets,
>> only 0~15 rx rings are non-zero, other rx rings are zero.
>>
>> If we want to spread the packets across 0~62, how can we tune the NIC setting?
>> we have enabled 63 rx queues, irq_affinity and rx-flow-hash, but the 0~15 cpu
>> received more packets than others.
> 
> As Jakub mentioned earlier, HW RSS is only supported on this device for 16 queues. ATR will steer bi-directional traffic to utilize additional queues, however, once its exhausted it will fallback to RSS, which is why CPUs 0-15 are receiving more traffic than the others. I'm not aware of a way to evenly spread the traffic beyond the 16 HW supported RSS queues for this device.

Ok, thanks!

> 
> Thanks,
> Tony
> 
>> Thanks!
> 
> 


