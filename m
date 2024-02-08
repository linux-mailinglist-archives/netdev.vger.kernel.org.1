Return-Path: <netdev+bounces-70360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EEE84E7FB
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D01F2D8F6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7A20DCD;
	Thu,  8 Feb 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyI0OpCr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90E208DC
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418092; cv=none; b=AD2eoGS9UZTz9HSk/n8P9G16SeZdDISOYw2TcamJ0yqkIbrTf5pXpWUlxYe14BH/xzNdovKC7RR4k1GujiqJKAeLyLVYUUHhnVVQcOsX5lyD0Ee1mrT8NcKfjETj++GeSHIZSAjo8OYlT2DxqjrRyhUFQt9sP9ljf2cv5wV/Sz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418092; c=relaxed/simple;
	bh=quq+0bz+Z09V5iRx/KLxQCPDSxI9JhwWDhy2p7OS22I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hP+MKL8RC/Dk+Jtoklk7eWn/5b0aIxPre70IptV9yKWBH/Fk22aoF/RAWcN7GNRkQ6Znx5RezPLft0orpmx66x8uifQ05FlOiq1TFx6pwFkBkxywiuBJUvwqu+hqjVQwt2YgaYXa2pcOU2o414LrteBY+r7FrpHVcpi83d3PbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyI0OpCr; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc746ddc43bso120982276.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707418090; x=1708022890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxlSqydgouYVjRHItwiLwGlBpF4gNbrT7K9OqNgkqGI=;
        b=DyI0OpCr83B6UFzTLIWAbeZzf+eTrb8wK1E1LIn0DEMBBWlTYUDDVzgJES/hkW3JIb
         010X+gGhKash3WCDFzupNmWdY60Cd5aQAjvOPiMuV8Sn2Y3szfBK6YW0UI7l305dAugp
         aFHAb1Qs9Gl4Wq+PG7sU5Hg+1vOxtbjoIKAcvwD+AT6ZGvYhpExJ+yluwzWOPZMq2OUL
         D6WRX0xjzp4QWTGIPtPB8GyzWydbSto/2FwkEGDzhRj33VhOQb8f7AZvBuDwiheXW1BN
         3kopVWtIYPkLajJUUHcTlotHATEq5vuZ6TMEAnFKkYtEZv9Jjdl3384ZgqSFdvm9O0oS
         q64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707418090; x=1708022890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxlSqydgouYVjRHItwiLwGlBpF4gNbrT7K9OqNgkqGI=;
        b=hmQcfoeeWxxf1vyc2gfEwwWrOyUyCUtIOEuTctOgPuhM0tUKNVE8/M7q+h+ApG2YKj
         ocH2q3qVfpojjqNhuBCToCeeVSaZVRyijLI9GgoBNlqOt76hRYCOLKeKWV9HKcQX1UV2
         v3coXvIP/OutHswJZgd9UIF/vHJvthgHrLrMiqZ3D49xtd8RoEjVC/uhxofr46leh7vy
         Qhzr4p3vunDwtoDMnyXke46k0yRwBLD/jOAHN6qZ+uEQl+ppuN3PK8+CbDCOTIB3wGy3
         vHpWpk0jH4hD7sMQUKYbTfcdvX+sLmCm5m7cvOz8wwZqxvRgE0pEcnZIs+M5xY6F5brO
         0mPg==
X-Forwarded-Encrypted: i=1; AJvYcCWY7p9HW7pEpasiv+5NqfjHbFPaNyHPTOnD/Gt6WfvJWKzEoXmZZetVcngnEKrIQ9idDXp5kujn8xdqvAK1iuaQWW6rYRMv
X-Gm-Message-State: AOJu0YwAFqUJEVuri93qp6vUqV53YjRnmRKVq1m5kcuxvHEsSP2xEWwg
	wEyLaPrWIgIhBNdxPPMTep68zo6/G24aMqlM/yTMLC0WtTxKX3Wz
X-Google-Smtp-Source: AGHT+IGNCUluP0gt+m7KfyMgFJO4avjOt7/JTKPaY2GA5sWg/NNXrG7/bAb8i4dEmG45OVSQgW/7lQ==
X-Received: by 2002:a25:9183:0:b0:dc6:cbb9:e with SMTP id w3-20020a259183000000b00dc6cbb9000emr308599ybl.41.1707418089881;
        Thu, 08 Feb 2024 10:48:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMDfw2NXsOmCB2NGnFHC7BLjsVK/4CU0shS/4ROo+4IO4KwTSLXRxAoHlZJPpm4EDMXJgIH2t+GdKS9TKjoRDHN9xw9O6JYtwTo3E2H5mF3HMksuNZ3yJ4qtUJsC7MaccAFGuZYrALDIeYHvorLtq7zGIrPMTJhBvukE7gZf1bXegY6BWp8zutn8IT0Q6b1/QMAOFaVoNey9yrtuFQB/9rFtMIUxscldJbFhbCF09xKHYjbBlgfOd7muRpDVbyW3l4sENrlwyJxnY9oejRejKy6hhpuYN1aAaE6JlljgjlKW2CfWITp1Fnq292cAiEIl8F1DzPbjy98MIXUVdj
Received: from ?IPV6:2600:1700:6cf8:1240:5e6:c5a5:2276:a32? ([2600:1700:6cf8:1240:5e6:c5a5:2276:a32])
        by smtp.gmail.com with ESMTPSA id b32-20020a25aea0000000b00dc74b3052c5sm97035ybj.33.2024.02.08.10.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 10:48:09 -0800 (PST)
Message-ID: <875df24f-2bf7-4878-9221-27f7f92635f1@gmail.com>
Date: Thu, 8 Feb 2024 10:48:08 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/5] Remove expired routes with a separated
 list of routes.
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, thinker.li@gmail.com,
 netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, liuhangbin@gmail.com
Cc: kuifeng@meta.com
References: <20240207192933.441744-1-thinker.li@gmail.com>
 <f8f40c760f274a7780c5ab491e7eb75e9ca0098b.camel@redhat.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f8f40c760f274a7780c5ab491e7eb75e9ca0098b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/8/24 03:55, Paolo Abeni wrote:
> Note that we have a selftest failure in the batch including this series
> for the fib_tests:
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/456022/6-fib-tests-sh/stdout
> 
> I haven't digged much, but I fear its related. Please have a look.
> 
> For more info on how to reproduce the selftest environment:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> Thanks,
> 
> Paolo
> 

To David and Hangbin,

This specific case failed for the first time and passed on all following
rounds. It is very time sensitive. Do you think it is OK to
run "sysctl -wq net.ipv6.route.flush=1" to force a synchronized gc?


