Return-Path: <netdev+bounces-69174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5C1849F77
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330C01F23562
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658573589C;
	Mon,  5 Feb 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ofPN21K1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAB36B0E
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150509; cv=none; b=sHIOW5OihxZWljVMDymWL62+DAYKTg7/lprVVam/r5+4Cd93vtMaIjngepvDZzto45sElcZ1/Bo4qcsNmSmb+0tA6Y7XfjzLcE4+XHVi9thTrleK7Psco29h5CkiAd+fS9qqII9Vflsd5YjOPr6CCy2JSNTXVDpMjLBFPzLgB7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150509; c=relaxed/simple;
	bh=+yaE1VJC6QUjUoZUni7DKzE4kaw+7Py8ny8BIiCrnZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDu8VLMOk6EODPVm7fT+YSNHOMFmBgZ2BKq36ByOxmLW1PwPLX0LXUYoYCO5fr69pzB+rEF9YMdULyCHaG630cPQbUxap+jf5/XfUEVV9JDgC5MPXbT9cy3PuYPAHFBdPMPuoeeM3zzq5+7Sy6h/65lKCr8sr+Mox3k+mXqw1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ofPN21K1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29631796acdso2113777a91.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707150506; x=1707755306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcsbQTvQGG1NmlhBrEyH/K59TBAz+MvdMoeLEVdmYgU=;
        b=ofPN21K1iFZcZcaq6nc90n8v3B3aDvednYPlawqEiBvNep/jtKgVbIBLXSh4gajCCT
         c9jmogkTJNSP4f0MVVCqlXLRzRZhZX/LIAfb8wqgR8k1uDvvOMt/8euJ2pjqZfFSCVt4
         WAnHfTd+S5dv7rhtBxICDhdjGujYt0J4XercLQuZ4o3VpT4BI3glgchqMx6uI9/sBrdc
         QPNu4/cuByL48Zbue51skjd3O5jy7x1qUuuIBhItQa5Vgj+05ScFy0+lTAllLyLpwYeQ
         fsRoUeBC0KX5nUzSYa4W6XIeLRW2Iw2iVM97w0qmmME/NzxZKMpD4y+vT//uZKK42rKV
         qVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150506; x=1707755306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcsbQTvQGG1NmlhBrEyH/K59TBAz+MvdMoeLEVdmYgU=;
        b=XygwGEwVpby7Pvc/KZxx7Gp9pcWiqZsk9MmJHr2ehtVd1UXlHsCgyVMZ7+cazcV7Ks
         cwZ7nvh0HBWEawHoxq5WhT1njt9QFBb1yOeWrBxHMret3f6efZ8OSEvt/MJ4IYSUhUC0
         ASCC/yh5K5DtjYH1iz5ypUQ/vUT/mFjEbCr7J/7mC6FbM1aSbt1VXbW6OpSe7groVYGf
         +L17vyCszh5Lc5DzSyeFRCE84ZFrjdinIhx45R93GVA4DnFCgyYcERGyj0n4YjYj7mBf
         ZIT76qqSW0eyG6a53o4UFjee74XVsbokvOyx3Y+753RTSdegc6U1EvGRZxAunoYiJUeC
         9lCw==
X-Gm-Message-State: AOJu0Yz8acW7347smU/KCRsOQielR8jJWpmTup6SedgdRWsWdMUsRAeI
	0b7zOQ3pImENsyrWxkkatSMtHu31cC0FDa3szYy1QiSPgivB3niGCyfi4dDLNg==
X-Google-Smtp-Source: AGHT+IGnFm0542ZBhwrZn/vKiCxYF//C3REJ/vIMwVq1MgfjxK6SeeHbkhC52kvxbE6VP2UiTN96iQ==
X-Received: by 2002:a17:90b:33c8:b0:296:abfd:1980 with SMTP id lk8-20020a17090b33c800b00296abfd1980mr1716551pjb.23.1707150506595;
        Mon, 05 Feb 2024 08:28:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWEebqBsfz7IIqu+fdNR3v8b0xN8gsBdw9f8Kbk08hmEWbU1zzlSSaddeicKAiTjL/aP1Gj4xMaV9O6bzdDy8M9vzS4c0AGZvGF7Y6er6kWdUmZyAVM+z5y76tkGhor7fe4zdr+wHZkWmBJx1hAfmOUU9Li+4xPDngo7acBaXIffSWgOBgSy8YYG1/W/+knz05Qwsmv8/gGTNcOh62rO+dVY7qNmnBiX7emj3O0yGO6AniKaChZsaB+21dpXqKIU1GPEuxRvbi934AP
Received: from ?IPV6:2804:7f1:e2c1:b337:7778:d3aa:dde2:173c? ([2804:7f1:e2c1:b337:7778:d3aa:dde2:173c])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090ad24500b00295c8c120dbsm5391893pjw.20.2024.02.05.08.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 08:28:26 -0800 (PST)
Message-ID: <4342ac71-105f-4ed4-83b7-ede3ab7255f2@mojatatu.com>
Date: Mon, 5 Feb 2024 13:28:22 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc
 tests
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, pctammela@mojatatu.com
References: <20240202020726.529170-1-victor@mojatatu.com>
 <20240202210025.555deef9@kernel.org>
 <b45bdefe-ee3b-4a07-a397-0b2f87ca56d3@mojatatu.com>
 <20240204083325.41947dbd@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20240204083325.41947dbd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/02/2024 13:33, Jakub Kicinski wrote:
> On Sat, 3 Feb 2024 17:15:32 -0300 Victor Nogueira wrote:
>>> I think this breaks the TDC runner.
>>> I'll toss it from patchwork, I can revive it when TDC is fixed (or you
>>> tell me that I'm wrong).
>>
>> Oh, I think you caught an issue with the process.
>> The executor was using the release iproute2 instead of iproute2-next,
>> which I tested on. I'm wondering if other tests in nipa are using
>> iproute2-next or release iproute2. The issue only arises if you have
>> patches in net-next that are not in the release iproute2. We will fix
>> the executor shortly.
> 
> We merge iproute2 into iprout2-next locally and build the combined
> thing, FWIW. I haven't solved the problem of pending patches, yet,
> tho :( If the iproute2-next patches are just on the list but not
> merged the new tests will fail.

In this case both were merged into -next trees. It's just the executor
that needed fixing.
For features merged into net-next but not yet in iproute2-next perhaps
nipa can be used to catch such issues?
Should I resend the patch now that the executor is fixed?

