Return-Path: <netdev+bounces-67692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD88584498F
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A990285FDA
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1DD39AD5;
	Wed, 31 Jan 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhmhcYGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612E39AC8
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735684; cv=none; b=gctFnW7zBSPtwmV/2fNeSLVH7rfcxjL8L+Og5b9wi3y8E9sC02YbjSygZWd2SZCBnxHYMdZ5CjQol/94JLldaMfny1XMmyl1yCd7peU60Y1++j3WAtwVaLV/UZxej8IVFGKTIHJBtrz15w8pCMU/5dGsu+zM/7/zuUrAb5C1Axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735684; c=relaxed/simple;
	bh=bHZlK4ZbAtXGGbiuxHcXWXDoCb12A+HiGI/nJNi4SH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPwjMiyg9yI70uqIASFrnYUoVnG+Pf96H57ZYyTI1kDRVFhDzXoezMCjroHMzkwIjXYbdZgoo1jxnOw24IL95y8kQcsvtXTfOJmCF7i0UEx2M5LKWA7OlsEhSBaeOGrw8uNNVvJitHGVzqQU2aBzcBvQszN0RFiAiI1oJrTu7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhmhcYGg; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbed0710c74so190918276.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706735682; x=1707340482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fs5ZRGCLb/rUw5d8Uo5i1mF6rGcnwz6S7sK5Kwd3c8c=;
        b=WhmhcYGgpYcZdZFo3JlwEygXnObTz4mDjNUa4Krc2sh3djrwNN5aGU7CUfF88SE7bo
         Rn40RbON9I6kXYPMf/8wiZKI+FF2XnvxExbGY/0XZKWwjUoJvF/XoJ/EZF1wds5BLw/F
         zoqkCz8tCoS7rLjNOxWsvJZ53h2M5sBplRjLrGsUpAwdspDJFzH3oZ2L1lS7BHFeyXPi
         Et8Xjp5Hpb4BdRkxfPI7iWfF/wlGPODXLq+Cdl9TLqC7oymk3/8va6eG5dN5nKSM9WHH
         mO1Y6daZRELsfqdW5Cu3gAV6EAPSGCLXa6Pj4iRYUWTE7vrsduXksKnHLY6CJq7Sxe8K
         QMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735682; x=1707340482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs5ZRGCLb/rUw5d8Uo5i1mF6rGcnwz6S7sK5Kwd3c8c=;
        b=luLZH4Wa/iJfPMJNZq8YlwSCH6YVdcGOPnZe1E6GgPJGBOHUTg84QIdO8doWO43MZJ
         VLBewEh9L24hv7ZPyH6AUvnwdnKpmuCjC28NDrSk7bpK16iL3XgXBF4NsacOZHMnD1Oq
         afwOGzk8Aaehkjpd3bm78SqA+/36vaRTQFUpKC31lQakrMBIxmwkfkyjovPiZSSurzvh
         R2gOTJV+L5559OXOi9Hryf7rakmrRRyK9c/LdGtY+SYuY+hTaYvucMrw9xs75ey4DpXp
         qSlnK6x8723HxFoigMt9pAGGFkcbDeRh1wZQodhbDU2+jGkUz8zyq0gpQmmrySLE14gJ
         qCBg==
X-Gm-Message-State: AOJu0YzBIREVGbo9tRhx7C0MBYeuLQn5X/a8U/jBcyuZsKthebELUQ3I
	Y8Q/8wb4kPehrXsdh6X+V7yNZHuHYP/PEL4tHymc4qHnJqtg8TIY
X-Google-Smtp-Source: AGHT+IEl4I5YxZ8sT/++slD/hnhksKOWr9mRhrXu/dhhwxETkem7jJ9K5XZh80W18ktH2LA2Lfds4w==
X-Received: by 2002:a25:9c08:0:b0:dc6:d6f6:cc13 with SMTP id c8-20020a259c08000000b00dc6d6f6cc13mr140489ybo.20.1706735681986;
        Wed, 31 Jan 2024 13:14:41 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:482:2f58:2caa:67c5? ([2600:1700:6cf8:1240:482:2f58:2caa:67c5])
        by smtp.gmail.com with ESMTPSA id p12-20020a056902014c00b00d677aec54ffsm3702823ybh.60.2024.01.31.13.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:14:41 -0800 (PST)
Message-ID: <d6336f60-f1c1-4d90-ac86-e003d47be7ef@gmail.com>
Date: Wed, 31 Jan 2024 13:14:40 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, liuhangbin@gmail.com,
 kuifeng@meta.com
References: <20240131064041.3445212-1-thinker.li@gmail.com>
 <20240131064041.3445212-6-thinker.li@gmail.com>
 <20240131112049.2402e164@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240131112049.2402e164@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/31/24 11:20, Jakub Kicinski wrote:
> On Tue, 30 Jan 2024 22:40:41 -0800 thinker.li@gmail.com wrote:
>> +	N_PERM=$($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
>> +	if [ $N_PERM -ne 100 ]; then
>> +	    echo "FAIL: expected 100 permanent routes, got $N_PERM"
>> +	    ret=1
>> +	else
>> +	    ret=0
>> +	fi
> 
> This fails on our slow VM:
> 
> #     TEST: expected 100 routes with expires, got 98                      [FAIL]
> 
> on a VM with kernel debug enable the test times out (it doesn't print
> anything for 10min):
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/445222/6-fib-tests-sh/stdout

I will reduce the number of routes to 100 instead of 5000 to see if it
helps.


