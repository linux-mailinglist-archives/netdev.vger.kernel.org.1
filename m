Return-Path: <netdev+bounces-171395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C1A4CCCA
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9472D3A8DA7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58177230BCA;
	Mon,  3 Mar 2025 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sD837WQB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D01DFD83
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034119; cv=none; b=L7F+/bsYsMNevhOdJbEQto0eruwqym6UxVBIdFonfCXARE2Ugt04t02rot8+pU3FBKaVMjgLn6Pe/gZBc9xa+4tZZhj5m/LFYBdfHyKP1JKqFcNmsydPjVHyZMlbBD2jHUhxLo6Q/mz7yrDkEKl8NYKkmcIRN1ELmexMH2P5CZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034119; c=relaxed/simple;
	bh=Pno1MUpPrX0QztMJofRQEUQO+NCM0j5Fn2BZ3d5pj8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bco4RzyXrcCYLANAEldvnoE3Xzm9nl4k2onbnnTO3BcwUcEqMWpzb3oOIL5aFys0l782QWsau1Ve9kTQwDSOvMOuwk1TrYQR+eM5xGpih7ILXULsriu3ko9JXCtsUULYv6zlmKkftJ5Oed+vme6iWysArKXSUVGlOGhroXknud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=sD837WQB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2234bec7192so74782035ad.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 12:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1741034115; x=1741638915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRbfa8xIYXa4NAzZMjdeXhuUTQA3fOfclHQfhuYlSvw=;
        b=sD837WQBu6AyX5rpl/khkHjiqESpDDnbk4z63leJsVoOLD05KE9JftIln3A5KH7owN
         31cUW8WCzubMBGDmtA2xeZIFOpgbzBWFKEzksjdJzQThNbLNC1VyMfHoEWdaYQl+ZywG
         d8iMsyKYe/K8naGNYVk5ipehvFFtbPxZSYARVOYMc1WKj3O3/uPxVgAMcSKbkP0hQG7r
         Om7aiE7F2cc6sGVMTK2RALkGXssNbTYkG2O5VQxrtJBKnrJiMaC2hGtzj52S9nm1W90p
         MVVX0yI5ChcIFl5jCTFkIOSiwhIoton7e3L2Ds5XU6cSzag4wG4BYT3esltpqDeVjtPu
         TJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741034115; x=1741638915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRbfa8xIYXa4NAzZMjdeXhuUTQA3fOfclHQfhuYlSvw=;
        b=DBjBz1ZjgqlBTgN0PqY2gijLKTSbw2n7np0cajLOQ5Ifvve38y46KaMGjZRvUFa0qz
         m3dqgev3HgWSNkcfOC3qW6AzQ3OjQtcs03wT/JAy40UQN1hvy2BSUMKMiaeytGMbgGVf
         76ASP1YZFRhCZiD3eOOFxqAQD+XQ7TYj47aF49aZvMJ+nGR9x9x72nVAkPt3YvyqawO+
         eGwhsgX/QWWWVKTc5efGv/9CKBBIwZmQrUgBbIOZTBIQUKkdhM+JgF6moFTyPQ8evhH5
         3BiJukNMiOEo2mVrPpCYVUBmw7wHFRUAh12cRfJBF/XkEryfV5cpH2o0yBzml+/FR9Mq
         C10w==
X-Forwarded-Encrypted: i=1; AJvYcCXprCpCu4U/orFWOuHvYVXwXHbVfVl3PuJCVHjXzRwl1qmwLbEuPxG1DaRkQWlkfF2Snzm5p6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//ogdLq0VSqMMq8i4x4vKRcSEnMXKJGftRzcUpwBrnBJeehLn
	x5UD0G7vcr3sC9wPU0WHne9A1nFiC+6tMBvav0FyQtg3+CxyEgf7NY5RRpY1Mpu9KbTnJUjq9BK
	1Cw==
X-Gm-Gg: ASbGncsD6awC4KGdJHaVd2jDJg95X4VpT3OgN7DYdY+OwDSJwKWX5SaqMedheiPmDqt
	UK2LMbWDUfDm7/sIi/4qQNXGjAkSY5sao04zMADtCa3rG6j/XN8TKe+vHcKZxITBdaEcc0z+qxF
	8SfaVETAYgQqW63C/Kl9BxbxVXcBiVgubrqqWWOzIyqQ60mlsb9s/YXJZ2WZrLJWA/jxkVcuce1
	YfsbXqlvwluKmpAI1l4P0yVcu7Y4Gm5mBIYBekdMvl2No+Mz8wmM2CETZT3NnK8BNMevn0fztft
	donoAxmIgwA8MK8S5rkl142dUB8vRIkptPsAk56xzd521uy/wUh/ww==
X-Google-Smtp-Source: AGHT+IFWG/57T8Qrr6TeOX25dpP4+5/4mFPWyl60IOIN0EKCbgQ8FEmXvW+IPk9wczKQBMdGI6hOmg==
X-Received: by 2002:a05:6a00:194b:b0:736:562b:9a9c with SMTP id d2e1a72fcca58-736562ba117mr7619426b3a.18.1741034114836;
        Mon, 03 Mar 2025 12:35:14 -0800 (PST)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363919860esm5105152b3a.12.2025.03.03.12.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 12:35:14 -0800 (PST)
Message-ID: <baa346ae-fa3f-4164-9ca9-61c840f4cad6@mojatatu.com>
Date: Mon, 3 Mar 2025 17:35:10 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v3] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
To: Jonathan Lennox <jonathan.lennox@8x8.com>
Cc: Jonathan Lennox <jonathan.lennox42@gmail.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20250226185321.3243593-1-jonathan.lennox@8x8.com>
 <174075783051.2186059.10891118669888852628.git-patchwork-notify@kernel.org>
 <a377cac9-7b86-4e13-95ff-eab470c07c8d@mojatatu.com>
 <DA44CD64-A3CA-4442-BB14-FBFEA9FD6332@8x8.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <DA44CD64-A3CA-4442-BB14-FBFEA9FD6332@8x8.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/03/2025 16:43, Jonathan Lennox wrote:
> 
> 
>> On Mar 3, 2025, at 1:39 PM, Pedro Tammela <pctammela@mojatatu.com> wrote:
>>
>> On 28/02/2025 12:50, patchwork-bot+netdevbpf@kernel.org wrote:
>>> Hello:
>>> This patch was applied to iproute2/iproute2-next.git (main)
>>> by David Ahern <dsahern@kernel.org>:
>>> On Wed, 26 Feb 2025 18:53:21 +0000 you wrote:
>>>> Currently, tc_calc_xmittime and tc_calc_xmitsize round from double to
>>>> int three times — once when they call tc_core_time2tick /
>>>> tc_core_tick2time (whose argument is int), once when those functions
>>>> return (their return value is int), and then finally when the tc_calc_*
>>>> functions return.  This leads to extremely granular and inaccurate
>>>> conversions.
>>>>
>>>> [...]
>>> Here is the summary with links:
>>>    - [iproute2,v3] tc: Fix rounding in tc_calc_xmittime and tc_calc_xmitsize.
>>>      https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d947f365602b
>>> You are awesome, thank you!
>>
>> Hi,
>>
>> This patch broke tdc:
>> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/17084/1-tdc-sh/stdout#L2323
>>
> 
> I’m afraid I’m not familiar with this test suite — can you point me at where it lives, what it’s doing,
> and what the expected output is?

tdc lives here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/tc-testing

The broken tests are here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/tc-testing/tc-tests/actions/police.json

Unrelated but useful is to use tools like vng to test your changes to 
tdc very quickly:
https://github.com/arighi/virtme-ng


