Return-Path: <netdev+bounces-72499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88738858607
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 20:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278B3B20764
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 19:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59616135402;
	Fri, 16 Feb 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="swpTPR8L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E491350F5
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110826; cv=none; b=JpSOTPgfltl6uw1UdgzfX5VIechUTXiNn0KS45hazkqaxwRZixIHrQamA1I77kVvBOTOHoa5Tt5NyZ2/zjdWnrJMpg89FXn1MShRDhi4Ka2VXGYWCI3YzLVBAPXAe4eLqo+uoedKJR5JfJChMp+3iY/7uXy5/dn8M8QeWCztC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110826; c=relaxed/simple;
	bh=TgLmdFPB+Rlekl0oJwZ7rIzh2GaTZNizdqpSU3U4xcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUzC2YYLhYyG6/QixQh7wP+PjQf4dAbN12CgykCbDabVK4BvlKU4wr8C64enAjnonavgJgL6vw5leHA34sSIHmnB+cojL7SkxqYJEzQD3GONPaKsQHkaKtubvT98UK5FfhOH5h0+8DXkENMoQ+vXAgnm86cWpTnor/M31PX36i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=swpTPR8L; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso109101139f.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708110824; x=1708715624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QFI9noFNd/a2nIPIvYd4uyTuHBm778lzm80fZQcuTc=;
        b=swpTPR8L2oRvYKpTeYC84LwKNqedcFk9U3dx1PZYVMUztBwhBGj0yl1vc9bGZVvRSk
         57G8RE5yiJA3Z4l97dpPFPzR8yYa1wYWd6mufH7hl5FX0gV37s/8p/oSwrQvNEa/actt
         W2K5FKyEl7teZzfX2JYFkbnLkIU9u5eBkHfqKFw2nS5YNPZNJmDOTAMlJ+FVhCH7iZ5A
         pI95sBZhaev8qE9oKclWNeipejwA06q9Z0hccHXr9H4RUiR19QclS9XRa5vUq3+GHGXe
         6dNYLrfKWypHXXswhFftJxRJh9AfOK94a3lRQY0teKRWqztghLQ7p5hcj4pTWtxgJ9HG
         AqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708110824; x=1708715624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QFI9noFNd/a2nIPIvYd4uyTuHBm778lzm80fZQcuTc=;
        b=NAhQvhDoODZct5jQv7rZInL1f9NsfFVlHSQWTS9Yfrxip5NORwQbK2EEQKofmuHAf0
         oGVWjRSS9cCFlqi2uqAa3cveNY/+kORviiVNwQx0N3XsYTnDar25ZL1oUu1hd2DB/3wt
         flCX6eJ1P5fWtnqGqLQPf2sJOuBbF18/2bU4uYSHtEpwNTGE5N4ywiWrLlGxNHGocBoX
         1/LGf5OV6TZJlVlIppuerYZ9rp3r7sR2WrjVQCBdrfuyFjeQiLzv3c382bYc1qke3NZ3
         Moky8fCv298vVf7xNU1cYgK1VA1f3eA/1FfMDnRMP0LO809qtQb+jHZAAVcxfLMn7aXh
         LtMw==
X-Forwarded-Encrypted: i=1; AJvYcCWHHUYQjZOz1P524YhZvbUdMw9TXVEVT1ex5Ee/e2NFtPigAc13v7jfjEImJrliZ9cWZDxSNmI8yAV0tF0mYZjYfOYBS/Nt
X-Gm-Message-State: AOJu0YySt+DmK9eRErH1S8yNOWV4Hj5ILeRE4py5zOQrm9yhVWvY9wJC
	hdCF1z0hp+5rSsRJGQrNmlNfbuKNZ7eOp0/i6lEFNLN2EGIKbKWgsjCAWcXKc0Q=
X-Google-Smtp-Source: AGHT+IGgGCyalWJQEo34y3vSYXAPSBsxPXy6kHLDkgDt/XMVQYJjpW8B4RjF3po2JMrgAE4Ec/hE2A==
X-Received: by 2002:a05:6602:2110:b0:7c4:3e65:dde with SMTP id x16-20020a056602211000b007c43e650ddemr6801569iox.11.1708110823779;
        Fri, 16 Feb 2024 11:13:43 -0800 (PST)
Received: from [192.168.1.132] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k1-20020a02c641000000b00473fac5cf2csm115696jan.92.2024.02.16.11.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 11:13:43 -0800 (PST)
Message-ID: <cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
Date: Fri, 16 Feb 2024 12:13:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs between
 ports
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
References: <20240215194325.1364466-1-dw@davidwei.uk>
 <ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-16 03:38, Paolo Abeni wrote:
> Hi,
> 
> On Thu, 2024-02-15 at 11:43 -0800, David Wei wrote:
>> This patchset adds the ability to link two netdevsim ports together and
>> forward skbs between them, similar to veth. The goal is to use netdevsim
>> for testing features e.g. zero copy Rx using io_uring.
>>
>> This feature was tested locally on QEMU, and a selftest is included.
> 
> this apparently causes rtnetlink.sh self-tests failures:
> 
> https://netdev.bots.linux.dev/flakes.html?tn-needle=rtnetlink-sh
> 
> example failure:
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/467721/18-rtnetlink-sh/stdout
> 
> the ipsec_offload test (using netdevsim) fails.

Thanks for catching this Paulo. Can I sort this out in a separate patch,
as the rtnetlink.sh test is disabled in CI right now?

> 
> @Jakub: it looks like the rtnetlink.sh test is currently ignored by
> patchwork, skimming over the recent failures they are roughly
> correlated to this series submission: the test looks otherwise
> reasonably stable to me.
> 
> Cheers,
> 
> Paolo
> 

