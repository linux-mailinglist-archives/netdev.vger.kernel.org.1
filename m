Return-Path: <netdev+bounces-109087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFDB926D75
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFF31C212E3
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80B4DDC3;
	Thu,  4 Jul 2024 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d7hUa7RH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45781DA334
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060358; cv=none; b=rQekE4xgOLRxVx4jqbegoDCIKdL5kbzaSKLNybMfog0O3fukaYOuZBz7gpkQsszUL7QnvwKI4kViJnv9wEzF8np/g31d9K4IZiiz5U2IAzVRKi8tzHE/LxBzUQerbfhNMpfkHj6Jm8QTjWyp/rDcAINeI61V1M3/FC8vss7edoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060358; c=relaxed/simple;
	bh=h7B6K9R0uGyEk3+qOhogtoSbGzl8Tahfh0wH9f2064Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7CViVPN9vMsbD9DUPmv6essaeyrshyatkfID7kRETcIlvKj6guXrHmUWE0eojIwL4DORsm7J2oMy9RA+Xjne8o66BmM/9kivYR2eB8dZRvOo2b8NPv8MJorFSP0DCp8mbcvDsroEBXaUc7KuBQCmWe1he9BtXb+INzx0+IL0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d7hUa7RH; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79c2c05638cso10693785a.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720060355; x=1720665155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9/eJjZzp1NJ1XsjUaOl56PEXMOJfm8wGhiQUXECnAY=;
        b=d7hUa7RHUj2AQhB921fpwaizwfHqCu14WdTQSPU3tX2PVAKWN7y9iHLP29cCD7hCMK
         fFycVl/xgckALiGEzQ9w/rKbZSp+PrgM5v2mW4NFKbH3NxAB3hDPHvhWtMnw6/jPfk8y
         r1UikotX4tWp59sjAB2IhSlyC0xgDfRMLxWpDG9HZBnjZO1TySDrOi366Zvr8Rj8VZpF
         OTq6QmAKfYWhtm9bc91R2YTOuyaTvLJ45Or7DNKbtmF44OpW5/WNsHA+nCcuZZ5VS+z/
         7UqlJ2OF4/MIkzUIKSHy4acU7MT6ayCZL/9rSmvGhM/DI4FpQgA6ukYzL352EKV/2At1
         0neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720060355; x=1720665155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9/eJjZzp1NJ1XsjUaOl56PEXMOJfm8wGhiQUXECnAY=;
        b=LZ8EpnRfvMgceAQOzQWeSvGYqgV3zJYwBQhwtEBsRQCz/fwnQg2Zr7R8Oa0fqaZ389
         e7pnRpL1CO0pIWASrqrOWXhR/rZ+44uhm8mu2fZbqxrs5sxK18wzHqo1cKSUg5i/c43J
         VShaPvZ9+qEO96r25vVM2nAFN461ifQb8OKa/MsvDzo7WZuEkxCoRlhEycZKFA7dnvko
         XGdBSuVNiqiQhEDZuIkID/eXSU/Oz2nXJkpBpX05xMit5QM9m2s7vdqXJuM5aZ8Ngsts
         LWIkg9BM5RFx2ZC1LnQ3nnwRFCL9NX/ypbjIg1ecYxQRD8iokJMa567lwqgiH+uFDv6u
         91ag==
X-Gm-Message-State: AOJu0YyNDDHifrfBe3s1jl54HaRmGeargsBhqlNn/Oa0iOGw4Pm+lyso
	UMeaZqrw3/FuDHKXOU2l871JFuvU9Ob6AnGCHLZVSj7J29SYEra5YwXIhKpsSlQ=
X-Google-Smtp-Source: AGHT+IGmHT3+a7Tv3Dd35w1MmSWZOPkG4dCzO06LBZcPLDqIOWG4rDXpCxmKmYTjAnWi5kCZ0t6AjA==
X-Received: by 2002:a05:620a:4904:b0:795:5f38:7de0 with SMTP id af79cd13be357-79eee194828mr45637185a.21.1720060355657;
        Wed, 03 Jul 2024 19:32:35 -0700 (PDT)
Received: from [10.5.114.89] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69307c42sm627483285a.122.2024.07.03.19.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 19:32:35 -0700 (PDT)
Message-ID: <5eddb78a-ba1a-4568-aeac-0dc296efdd51@bytedance.com>
Date: Wed, 3 Jul 2024 19:32:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] selftests: fix OOM in msg_zerocopy selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
 <20240701225349.3395580-2-zijianzhang@bytedance.com>
 <20240703185003.6f11ff73@kernel.org>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20240703185003.6f11ff73@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 6:50 PM, Jakub Kicinski wrote:
> On Mon,  1 Jul 2024 22:53:48 +0000 zijianzhang@bytedance.com wrote:
>> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
>> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
>> until the socket is not writable. Typically, it will start the receiving
>> process after around 30+ sendmsgs. However, as the introduction of commit
>> dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is
>> always writable and does not get any chance to run recv notifications.
>> The selftest always exits with OUT_OF_MEMORY because the memory used by
>> opt_skb exceeds the net.core.optmem_max. Meanwhile, it could be set to a
>> different value to trigger OOM on older kernels too.
> 
> This test doesn't fail in netdev CI. Is the problem fix in net-next
> somehow? Or the "always exits with OUT_OF_MEMORY" is an exaggerations?
> (TBH I'm not even sure what it means to "exit with OUT_OF_MEMORY" in
> this context.)
>
The reason why this test doesn't fail in CI:

According to the test output,
# ipv4 tcp -z -t 1
# tx=111332 (6947 MB) txc=111332 zc=n
zerocopy is false here.

This is because of some limitation of zerocopy in localhost.
Specifically, the subsection "Notification Latency" in the sendmsg
zerocopy the paper.

In order to make "zc=y", we may need to update skb_orphan_frags_rx to
the same as skb_orphan_frags, recompile the kernel, and run the test.

By OUT_OF_MEMORY I mean:

Each calling of sendmsg with zerocopy will allocate an skb with
sock_omalloc. If users never recv the notifications but keep calling
sendmsg with zerocopy. The send system call will finally return with
-ENOMEM.

I hope this clarifies your confusion :)

> TAP version 13
> 1..1
> # timeout set to 3600
> # selftests: net: msg_zerocopy.sh
> # ipv4 tcp -t 1
> # tx=164425 (10260 MB) txc=0 zc=n
> # rx=59526 (10260 MB)
> # ipv4 tcp -z -t 1
> # tx=111332 (6947 MB) txc=111332 zc=n
> # rx=55245 (6947 MB)
> # ok
> # ipv6 tcp -t 1
> # tx=168140 (10492 MB) txc=0 zc=n
> # rx=64633 (10492 MB)
> # ipv6 tcp -z -t 1
> # tx=108388 (6763 MB) txc=108388 zc=n
> # rx=54146 (6763 MB)
> # ok
> # ipv4 udp -t 1
> # tx=173970 (10856 MB) txc=0 zc=n
> # rx=173936 (10854 MB)
> # ipv4 udp -z -t 1
> # tx=117728 (7346 MB) txc=117728 zc=n
> # rx=117703 (7345 MB)
> # ok
> # ipv6 udp -t 1
> # tx=225502 (14072 MB) txc=0 zc=n
> # rx=225502 (14072 MB)
> # ipv6 udp -z -t 1
> # tx=111215 (6940 MB) txc=111215 zc=n
> # rx=111212 (6940 MB)
> # ok
> # OK. All tests passed
> ok 1 selftests: net: msg_zerocopy.sh

