Return-Path: <netdev+bounces-183325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3854A9059A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862A97ADA10
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BDD1DC04A;
	Wed, 16 Apr 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="w1gCc6/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F771B042E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812051; cv=none; b=lgTalcTZlnWsK0k2MDuVAnPZv/cdlSjXr+R2L7cSD8bw07y/WU6LNxhaps2ooLDbnYQm1s3vYY34hN/3HPLSU/MP4x9INljcqGu/AE8hNF5/Uk8dn7Yn5rs6aHJANfhEj+6eTKNYBlKb7fGkwVve9GDXh2gMEREksrfF502oKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812051; c=relaxed/simple;
	bh=oraib7zOH3boZOyNP2NfBNntBUxMqQyjHvBjd3k1yD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW63iyPfBtYGPVnL6jnEi64YiUSjIn25oqmwG3ted3ivKUPZbySAc9LiK+/f6ROZeVg9+3wgFWr20iS1oF7kQNfrJnkBra59IF3pzrAjwnCdtv1Z+Ip9K7wv88TrK/kODpuDXgPhdec83ktUeowrajiNxBPrGNElfJc8aMJ2SK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=w1gCc6/U; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60208b7a6d6so1803400eaf.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744812048; x=1745416848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Q+VK6lwMdiK2HjCiZaR6gJ7FPBmf+K3pu4U+CKGrnE=;
        b=w1gCc6/U2h/yrWWJRHTJ6Z2ks8qcNTTcblhULrxT7c5wizXcgLpSt9Tdb2PqrZ6RQd
         cHVc9VBDkiFF61iRYlUIcOhIaHL5vrFmxiENNiDHZOtNUbix9kSI0uBuhBcPnPSMBdNj
         6Ois+PEvSPyjCf1JCpou+jwGgD5C9CKEk6ecbmJBGsiGCFQaiMVkQmXzLu01hJ2ImGN7
         49gDtHOCnNy4ANo+fuWBFoKad9HFv+gYsPOTK2ERabEiRIyeiICidml6RjpEMzlgx9hH
         vx5myo8GOwvi/wIO6a2yBIuQ/cywYZiVeG9gRWghgbLGpUAV0+GkEdrfhVYY6E8Ik5/+
         ZR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744812048; x=1745416848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q+VK6lwMdiK2HjCiZaR6gJ7FPBmf+K3pu4U+CKGrnE=;
        b=TrTyvt85dMSjDaebyQSqJVknCP/sVdVnB32Klw7E0F2wFboOYGG9u0I9jKMsNrJ0uX
         xblk79Ea9fQ5oQCAEXNHoLmBtJXJCK3O55pcJmx031Vc0USUM1yFKzsEZ4CEVCqh/QpF
         J/gku5IKCfY90faryqSe7mOhH1QcUcpCTaQkpCAgty6imw9rVkcE7Wra1s8txcJtfJeD
         akEJyGo/4t3pBZS7hNZzQpQ34EotC0ShLZmj1k1MFV0CwNQnzWWa0fhHFJ4jXbzUH2TX
         9GGQATwvUdnEQ3k6DbX6u1PfOWJg4DkvwE9FulFEWntqGkudi9Iwmk2VQg6uFtLKYPtY
         xbrw==
X-Forwarded-Encrypted: i=1; AJvYcCXsl6VueikOYqjxfZO7cXecOQhEnd5q4odCAqqUNSZnx4nozlY3K1RKOA87+wgqgbRJcvHLMdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBD9POEK0TCULUcod+sRyspOicpvBJzPmwEL3PRt7LlfIslmfW
	g6NRLUgzTfpYyTR7FldaIYRXHmAlRT5Co0yyg4gxL8fFHhfUC7ZTz4rCNejMiEkLcBmZr8e60U4
	6qw==
X-Gm-Gg: ASbGncuCTKJx7QIUXR7BF9EndJl2Sj55rwFE5eirvyAJkz2VtSVXQlkH2cddtf8vQj2
	qgrxrqNcY2sVhcZtxeU5bLPJyuyhd8eJM28ju6edkIcSOtpkX9yI/n5VbEb1mrHvCEswWbWQJU1
	VD/rVtEd4sVY8EHrqzycdqfzzjHlnr0krDIkzOtOlsLE2umlB1qTcbcRTRJBJCutDolNzQrLLAu
	ki8DoL9Pss84i1b++R0Qemc1AtzZvd9tNbN4BYETv4AdosKoCQ8LZe/uy1/xcEA+2i8BOApCqDZ
	E3hPtGyklWEn8E5VbUqfYfizi84U2VtOOPUIIwPowcOS5obvh7ck0iYp1uCWAVQuOYX/wrqkC0D
	IT18eMp+RnLM=
X-Google-Smtp-Source: AGHT+IFQ3LNuBEeENP6A6Anhn9u1qTz/q6X7tw3M5Uh4kB5k5N0rlo6OPU1WKAj+SEWvfKT946CJJw==
X-Received: by 2002:a05:6820:c90:b0:603:f1b5:ca02 with SMTP id 006d021491bc7-604a92b004cmr1088895eaf.6.1744812046420;
        Wed, 16 Apr 2025 07:00:46 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-604a5b6379dsm347281eaf.2.2025.04.16.07.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 07:00:45 -0700 (PDT)
Message-ID: <8272f999-fe55-4afb-894a-57a7cc161473@mojatatu.com>
Date: Wed, 16 Apr 2025 11:00:35 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 2/5] selftests/tc-testing: Add selftests for
 qdisc DualPI2
To: Jakub Kicinski <kuba@kernel.org>, chia-yu.chang@nokia-bell-labs.com
Cc: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 pabeni@redhat.com, jhs@mojatatu.com, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
 <20250416065223.4e4c4379@kernel.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250416065223.4e4c4379@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/25 10:52, Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 14:43:14 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> Update configuration of tc-tests and preload DualPI2 module for self-tests,
>> and add folloiwng self-test cases for DualPI2:
>>
>>    Test a4c7: Create DualPI2 with default setting
>>    Test 2130: Create DualPI2 with typical_rtt and max_rtt
>>    Test 90c1: Create DualPI2 with max_rtt
>>    Test 7b3c: Create DualPI2 with any_ect option
>>    Test 49a3: Create DualPI2 with overflow option
>>    Test d0a1: Create DualPI2 with drop_enqueue option
>>    Test f051: Create DualPI2 with no_split_gso option
> 
> it appears applying this causes the tdc test runner to break,
> could you take a look?
> 
> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/79725/1-tdc-sh/stdout

It seems like the breakage happens because the iproute2 patch
is not in yet. I applied the iproute2 patch locally and the
tests succeeded. The next iteration should run with it applied
so the breakage should stop.

cheers,
Victor

