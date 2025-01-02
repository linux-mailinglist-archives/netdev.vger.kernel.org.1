Return-Path: <netdev+bounces-154683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE799FF706
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE4E1616B7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5D192D7C;
	Thu,  2 Jan 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="CvdrKFGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D14A95E
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735807405; cv=none; b=mAD6UapzbhzKAXXx+VVGTpOAW930LTUXoJrazuru5+7CJAE7Eg1rqYeDPeQb35ED6jR1NCAEGpnIB8rgYF82GN7JgDD2VL/vnMXzfMjWS4tOJXQD6sDAafcnKsW/he9RoNu6m0FrQ6zeuf/NoONLMH9quMTqoJp2f45HM6rqgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735807405; c=relaxed/simple;
	bh=idBudSH9VEhOH7c2b627druTjHPf2xAKroCaCAuqPHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqhWjGqCY+xgN3fl02SbT7khJ8NNQxtYEu9522hLhOiiXXAPHjQGD/syTkC3fbSNwos0YtPMTZL2fi5mUiZl7K2nPqkYGEQJptXDy6/WWgKiV/5M9Bo0N3P67AnJnZncJpsPTg+hB49cvH73eXo9t7HW7Ko173826TNMzrsa3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=CvdrKFGw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2162c0f6a39so158886645ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 00:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1735807403; x=1736412203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONF0KLB8jTWoJqOoJVre/hdtr5usKsOw9G8OfagGSbo=;
        b=CvdrKFGwt80i38t62SWDxTLe7MtyC8haxR55WuHPonYqO3oiO5ijGNYK1Tsgv8bpgX
         bochQgwZLwCoZ1gkpAWupqEwX/NJWI6WBZ852CtlFq3Vu7r28IYiJxZq4pKu0CgoFxXh
         sjWCkDskUhQOES/pL1HnW0MFO4787hZzwzLOuWBYLUKafEUEkqfwkuuS9K5UyQRccMvg
         wlAQ0V5hpuUybV5PZfGNHy31lI2MGXm/BPagR+quPW8YiWs1H8ywa6sX44lPbJjLqftQ
         USHX6H76Dj0ZrgMvmpxKecll5OUJHkrywfRL7r8B+gf7BizKhpLCOwzPmsBA7OCBLPRR
         4wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735807403; x=1736412203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ONF0KLB8jTWoJqOoJVre/hdtr5usKsOw9G8OfagGSbo=;
        b=hs4nwgmNO4C5QnpqaK3hl3Fzxx2A2z2mOfGbgP+jFKxSmPdTIcrI3q21XXPvCE6gkL
         DDtC2cggMCBOHyHj10hsPAHYDW8mSI7LZyNEALQ7g7/jzwcFDRDF8rr7++cCXaxvtLzw
         W0SOlnwZvkbmW2O7qBoViimexthZVNysul4+BHvMNG03K9kKtgZ+7QKgmzaYkSxML4tC
         PoByQ2Lk2RAaOCCgEcd9Ufuvt/VTqqSrVxWVuh+kQDElDMvxad6npUo0estjBDsLs+7M
         XFQaV3ZBdDHHlZ7VVmCfCZAz9EIf5AlNkqQB1LVeKP4REKuPeOj3Jz/g3sjPgsEtxPEA
         hZQg==
X-Forwarded-Encrypted: i=1; AJvYcCW08yNxZM8DlhW0KEbDlkoICXLH1rnspyPliz0P6Ept6iIRZFt4uFHOxKJjKJZiyDgOyf33oeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKLDJEQtzHOvVhXulhhEqBopsJ44M3rUK4xSN9QsO7p9sls9R
	9A5/XsYQcDCIVNSi3ki8fexJsI4ZkvCn56ff9Z0cFgkHWih18AbFbnotED3BZCI=
X-Gm-Gg: ASbGncsIP5gEeSAX+qZQhNpsSiN70NVXey/3SspaMTiG8PQceHF+SZFApZGvUbyIXMS
	QQnyEPMyNz/5t6a29HNHErBpzLtGnxlAsLqDMqGstcIPq3bITo8dKH6Y6I3pWMQyHr7AmDRgZ5l
	GQLXmZ9BsNTHvIyPsTkrUFGhGVndbluuWYEk/SDjCRJzl5knAIJPHm2Pau9SawnJUNDsm4VS/+7
	EZVs67q05PrTupIFnnl2lNHmLMaiHNw+Uz94JozzBB8VhaL8grYQACRhxzUKjPHeb5fhXFT1fZS
	vNh/4FyWb5rnnCp1Vx8Zvg59b3PSFEYWwGSMYFmH
X-Google-Smtp-Source: AGHT+IH7Lu5G4PLy5eUlGX4y+me42DxYsY+XwbXTrn5GV+CYxwrLSLjZv8CM42PQIV0m1+E6UMoW/Q==
X-Received: by 2002:a05:6a20:7488:b0:1e1:a789:1b4d with SMTP id adf61e73a8af0-1e5e1f57c97mr59944805637.15.1735807403083;
        Thu, 02 Jan 2025 00:43:23 -0800 (PST)
Received: from [10.54.24.59] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72b5bde56f8sm3606447b3a.162.2025.01.02.00.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 00:43:22 -0800 (PST)
Message-ID: <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
Date: Thu, 2 Jan 2025 16:43:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Eric Dumazet <edumazet@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/1/2 16:13, Eric Dumazet wrote:
> On Thu, Jan 2, 2025 at 4:53 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> Hi masters,
>>
>>         We use the Intel Corporation 82599ES NIC in our production environment. And it has 63 rx queues, every rx queue interrupt is processed by a single cpu.
>>         The RSS configuration can be seen as follow:
>>
>>         RX flow hash indirection table for eno5 with 63 RX ring(s):
>>         0:      0     1     2     3     4     5     6     7
>>         8:      8     9    10    11    12    13    14    15
>>         16:      0     1     2     3     4     5     6     7
>>         24:      8     9    10    11    12    13    14    15
>>         32:      0     1     2     3     4     5     6     7
>>         40:      8     9    10    11    12    13    14    15
>>         48:      0     1     2     3     4     5     6     7
>>         56:      8     9    10    11    12    13    14    15
>>         64:      0     1     2     3     4     5     6     7
>>         72:      8     9    10    11    12    13    14    15
>>         80:      0     1     2     3     4     5     6     7
>>         88:      8     9    10    11    12    13    14    15
>>         96:      0     1     2     3     4     5     6     7
>>         104:      8     9    10    11    12    13    14    15
>>         112:      0     1     2     3     4     5     6     7
>>         120:      8     9    10    11    12    13    14    15
>>
>>         The maximum number of RSS queues is 16. So I have some questions about this. Will other cpus except 0~15 receive the rx interrupts?
>>
>>         In our production environment, cpu 16~62 also receive the rx interrupts. Was our RSS misconfigured?
> 
> It really depends on which cpus are assigned to each IRQ.
> 

Hi Eric,

Each irq was assigned to a single cpu, for exapmle:

irq	cpu

117      0
118      1

......

179      62

All cpus trigger interrupts not only cpus 0~15. 
It seems that the result is inconsistent with the RSS hash value.


Thanks!

> Look at /proc/irq/{IRQ_NUM}/smp_affinity
> 
> Also you can have some details in Documentation/networking/scaling.rst


