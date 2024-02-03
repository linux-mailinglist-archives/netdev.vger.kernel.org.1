Return-Path: <netdev+bounces-68854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FC8488AA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0FF285859
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237885FB86;
	Sat,  3 Feb 2024 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sBxF96rq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D45FDB3
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706991340; cv=none; b=FEE0/5fDJORQz0WkB9cfm7XddbPIfG0KWY04s3qVs6hOvcVmXQK+xaKsLKCc4m918xY56tOefZtwfeS7JCSHPSDKT5k/gienqqQk9t4HjRurqNytLh+PJPJV3R2MOgv8Ds/WAf9AWKec9jDGaWMn2U7UYd2qkkMCCJFKoiBg9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706991340; c=relaxed/simple;
	bh=O7461ryidGZ7LY1MQSmhNsmIFK51Lmm5HCMXXva98yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhPRisVbkwm5AOHhF3Go/thLrXRCz2h5jWWbLmVtZjpUDQfQajJOf9p+GFUN0IsLYIc9l0Y9+G+oogSVRqYIB49THkiXOyJKBoZc0rgO4QQQes0ksl1r7CqvTK8hTMgsnv5hbibREx1NWT5QBMfP6ShSVuLydxJVcUpizMzyVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=sBxF96rq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8aadc624dso24905435ad.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706991337; x=1707596137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VM1SFdzq94VHxam9Dm2BzXjFjW1O8NyuHN2QMpYkH2w=;
        b=sBxF96rqwXceerm1zTXr56Z7FeRlZ3qoWBqmGENa6PP9VP2/MzfvQz5iGAERHTc4aU
         nLLkeRpkiqcyMqe0XUpG49/cOWMcaN7uMomVYfHCB8FBz2LjUvn9wGd5FInHq+VT76cF
         kIu7uLdjTNQmz5MFoiVba9VLjD4ZhvjgYPKCK0k6qLTE7jewD+fLRmH8cdR0Sjs7OfQy
         VOMLxAmOqhsjQCgQJteyYBdnc7keZl8lq6u44h2LUXneqWH/2015E0fqXyprxRhBYOQ6
         cfG7j9OehREBiEPXLBnSundQIv6JUoqabj+GVJq6Qk42BbbQUfpjp6udipnnDqKuY0Wb
         MUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706991337; x=1707596137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VM1SFdzq94VHxam9Dm2BzXjFjW1O8NyuHN2QMpYkH2w=;
        b=N3PU1qW7QF9Tjv6Kx6QAIfxrKAWG0wtWw9PLDxQzglUJmiVALSa1aXe5ldcQtbI4O4
         82tRbZcFm+HjKRXALtu4pC3UcyrcX0Kch7ZnOgexgBUtg2mzKSSFSYCbHbR4MTGCxiWW
         hrvTopbjjV1qqjjmqOQIeNUe3QXrbpM+o9mTXrXAgLLYefxURbJgQ/5UJ1Ie2cyn5GOq
         ING76iVGngoSpeFMGKvUP6UzF5ofETJfbDIP8ATpu+/EJgbepUMLOiAr3DbLS+I/YARt
         CzEiiX3c2bFXp87nXsFZEilIqeInZk4g3M/Koc3riu7eMVU31eyXoFNpIZPZW/gR6Ncq
         eVDA==
X-Gm-Message-State: AOJu0YwwlSPO5K3BJJT/qXP269sAbUPCQs/ZZ1syxQHCpn7DKD7rvTVm
	k4hjKi/3EshQny2tt1586XEhJBkF/W1HEfKzAfVXlaRMWnFRnbAkCbPdlj5Vyg==
X-Google-Smtp-Source: AGHT+IHzDh0ScHeWpzh4NPiKssYOYrykpCn+TX5cGy6h1dIrRFenWNY4B5O3eti/mxmfbGUeRo+niQ==
X-Received: by 2002:a17:902:eb89:b0:1d8:b51c:6b79 with SMTP id q9-20020a170902eb8900b001d8b51c6b79mr6464129plg.7.1706991337325;
        Sat, 03 Feb 2024 12:15:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUx+/OBEA2ZzzYRC10RHVNG4snlonGNGL24/wAXBfOXWU0Kze60cthQrJ8dIpLbtfvC4mdFPSGO89JZPaFIhkgxPwZETtpxHW/Pf3JJdXATnMKd24XY841b4L++Bv9h+MsXcoiHNZrjBWJx8A45nyHJLqUF2llbsbTAAzZFQPJitKB/TNP4Q4jyDTAlrK8WwJbal1CtW+/2+Eq77lKRFPDkEF7ID2xgDEUKxgsSYSpJtAIpB8NZZQEe+Zc/i0yoCygNlOmLqgZ83z7R
Received: from ?IPV6:2804:7f1:e2c1:b337:7778:d3aa:dde2:173c? ([2804:7f1:e2c1:b337:7778:d3aa:dde2:173c])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709026b8200b001d9396ac4ffsm3558273plk.284.2024.02.03.12.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 12:15:36 -0800 (PST)
Message-ID: <b45bdefe-ee3b-4a07-a397-0b2f87ca56d3@mojatatu.com>
Date: Sat, 3 Feb 2024 17:15:32 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc
 tests
To: Jakub Kicinski <kuba@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, pctammela@mojatatu.com
References: <20240202020726.529170-1-victor@mojatatu.com>
 <20240202210025.555deef9@kernel.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20240202210025.555deef9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/2024 02:00, Jakub Kicinski wrote:
> On Thu,  1 Feb 2024 23:07:26 -0300 Victor Nogueira wrote:
>> Add 8 new mirred tdc tests that target mirred to block:
>>
>> - Add mirred mirror to egress block action
>> - Add mirred mirror to ingress block action
>> - Add mirred redirect to egress block action
>> - Add mirred redirect to ingress block action
>> - Try to add mirred action with both dev and block
>> - Try to add mirred action without specifying neither dev nor block
>> - Replace mirred redirect to dev action with redirect to block
>> - Replace mirred redirect to block action with mirror to dev
> 
> I think this breaks the TDC runner.
> I'll toss it from patchwork, I can revive it when TDC is fixed (or you
> tell me that I'm wrong).

Oh, I think you caught an issue with the process.
The executor was using the release iproute2 instead of iproute2-next,
which I tested on. I'm wondering if other tests in nipa are using
iproute2-next or release iproute2. The issue only arises if you have
patches in net-next that are not in the release iproute2. We will fix
the executor shortly.
cheers,
Victor

