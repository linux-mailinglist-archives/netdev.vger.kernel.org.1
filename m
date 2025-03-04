Return-Path: <netdev+bounces-171791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C29A4EAF7
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF067188E446
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609328D048;
	Tue,  4 Mar 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wzucAke2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264825290A
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110690; cv=none; b=rKcsQZDW5aL93jf4NmjuGS1Mhc5nCxhyPpNHtKen/FJtDG9BWUATgKjRrfolUjAOZ5kyhZ2QX/vCJHrL8q6h6ftTxbp+lGjLsfGcrQGol63Y8ImBkT8MZloFqrHCD+qFgwACaKTY4q0926bkNJDegvBRhk243LB8+ndBKBjHzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110690; c=relaxed/simple;
	bh=PqlTslWWpCWKIz/4Bp2G+SYdKiDPoXcGI48hgMaFbsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+31nzsuzGeXLI/6FpyFFWBF5GkkwJlLvUmtSH8PyuP3vXFAPUVmw/DH7lzxH3vZRyNRUUm3V1+uq/NL7DQioLlsS64BNZQNIC+2rk6wo1s1M6Ye+ru5SPsYsSC0eAd4rMq/5FUByUKiGr0xWVlQlyt5uyDPkCmk/3B78BcbiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wzucAke2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so7129176a91.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1741110687; x=1741715487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gd7PLncXz2Amqmb8Q7Qi5DDX9X05lR0ABTOIvps5ME=;
        b=wzucAke2mgkHYa/pUlbCoXBfKNYpOHk1HumeWpG0rYPCrsAR1a+q/uBkx0R8nwcXrB
         LpJvH2B/ozzHiBbIQjQqQobNSeNAtGQiy06J5pwmAdmfAZ1cDdE/EMcU64+YGlkrn+oS
         7STSSoQ1BQZkirzCid1U2BiFyJfNJEIQOIm/hraPB9ab0HQHZfeXsDOmMvrIJVTbZ9lI
         ODuRgDlDSgml80qUZ4vIhEtwXayzBX6J5Azq/FiNpaYcKDAffisBCFgGO7sN+Mp52WnR
         r7NLdjE8GIsQ1pqth14OubYXYhJgNS+pJXAivvmuXwyNCefwzNt6WWDcGSpuGPUg8Ari
         5eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110687; x=1741715487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gd7PLncXz2Amqmb8Q7Qi5DDX9X05lR0ABTOIvps5ME=;
        b=Pvqw2BVzQ4KzcQShH/H/zjjyM5hioVL96L4+F3wkj8spajUfp3yROAEE+mFrpgBxcb
         JhEX41RiWYA9Hj8u6HpzBGCRXqdhlv1sIjQpmZPbcinTDpH6ID2CmkHR/KN+KD/JoYND
         PVwrm6blp7huPWnlJ6kxQdqEkRMz8GDbSvlMwliblGXLwGCTN5+vmlG6KRqh4bs4iYEm
         b+4QbLBD4Vr/C9DeuZ19ESqBgBLBKpKdIfgTMmtCUbmgoXOat4Zq5WCNPV2qtDUY0xju
         +6fMda93A18Zvl3fehvxR7BkjV/7eAyUXrqyxfzHK3pz+PU+1gPm0f+FpIsKfNMZd0Oe
         6vVA==
X-Forwarded-Encrypted: i=1; AJvYcCUPZJyUzuO3PcUO910N8PONddyKrf0d/ARyQL79mNA+TcLvW7mzSt5YTe3vXBSunu1xQaO/OwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKtqP2DtNuHfo2oap+F6saPXC8FYcq3zMWNfUBvQ+Jb1Zj3nl
	ZL5i3jIApO7RkL/PZQi7+KeerwONNczNpLMa6bq4zmulXdH2kAQ9ELsXeblRiL8DpAaeTaLuuGm
	RMw==
X-Gm-Gg: ASbGncuNcbs0GWDWQ61RmTadHFcl1Iul+dNmLt3ZsDQ1yjDMZ+2QxvBf+L9inxDfU1s
	9wZ95w4zxu64mdH0KBpIF8vcBLMV2jaATE3qlwl/17pr37S6fhOVlEO5PUYldcN2ZilHKw7eyjk
	dbuJQSZMzzeTyWzXcOpt3VLqUgvc6H8/MnL99S3ILYzQ1d7rN/E1rf/QghTPur8rwEnQFHo6DhP
	9bAuNEym7f0pKwmasPAOQvlgbb58wYqe29FCB9jQOeh9CEbXoQMYNTAodiswS0dxYf1rdVIf7j0
	ugKDr8nAPViGeNYWXpD9ZFd1pQaHIZyMaMUSTnCOUW6XAQJK8wwLbQ==
X-Google-Smtp-Source: AGHT+IHCBoYCV9UAFNwJGVmIBRUhwjw5kHlmo6X2VNzW74OpO/1C1LwPuutpomcL33M4I7eTq6mDhg==
X-Received: by 2002:a17:90b:1d48:b0:2f6:d266:f462 with SMTP id 98e67ed59e1d1-2ff497c2ffdmr248186a91.35.1741110685625;
        Tue, 04 Mar 2025 09:51:25 -0800 (PST)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825bb461sm13550688a91.16.2025.03.04.09.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:51:25 -0800 (PST)
Message-ID: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
Date: Tue, 4 Mar 2025 14:51:21 -0300
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
 <baa346ae-fa3f-4164-9ca9-61c840f4cad6@mojatatu.com>
 <8B352E1E-7720-4A80-ACE8-90D6519EE9DF@8x8.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <8B352E1E-7720-4A80-ACE8-90D6519EE9DF@8x8.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/03/2025 19:13, Jonathan Lennox wrote:
>> On Mar 3, 2025, at 3:35 PM, Pedro Tammela <pctammela@mojatatu.com> wrote:
>>
>> On 03/03/2025 16:43, Jonathan Lennox wrote:
>>>> On Mar 3, 2025, at 1:39 PM, Pedro Tammela <pctammela@mojatatu.com> wrote:
>>>>
>>>> On 28/02/2025 12:50, patchwork-bot+netdevbpf@kernel.org wrote:
>>>>> Hello:
>>>>> This patch was applied to iproute2/iproute2-next.git (main)
>>>>> by David Ahern <dsahern@kernel.org>:
>>>>> On Wed, 26 Feb 2025 18:53:21 +0000 you wrote:
>>>>>> Currently, tc_calc_xmittime and tc_calc_xmitsize round from double to
>>>>>> int three times — once when they call tc_core_time2tick /
>>>>>> tc_core_tick2time (whose argument is int), once when those functions
>>>>>> return (their return value is int), and then finally when the tc_calc_*
>>>>>> functions return.  This leads to extremely granular and inaccurate
>>>>>> conversions.
>>>>>>
>>>>>> [...]
>>>>> Here is the summary with links:
>>>>>    - [iproute2,v3] tc: Fix rounding in tc_calc_xmittime and tc_calc_xmitsize.
>>>>>      https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d947f365602b
>>>>> You are awesome, thank you!
>>>>
>>>> Hi,
>>>>
>>>> This patch broke tdc:
>>>> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/17084/1-tdc-sh/stdout#L2323
>>>>
>>> I’m afraid I’m not familiar with this test suite — can you point me at where it lives, what it’s doing,
>>> and what the expected output is?
>>
>> tdc lives here:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/tc-testing
>>
>> The broken tests are here:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
>>
>> Unrelated but useful is to use tools like vng to test your changes to tdc very quickly:
>> https://github.com/arighi/virtme-ng
> 
> What’s happening is that when the tests are verifying the test result, with
> "$TC actions get action police index 1”
> 
> and the like after the command
> "$TC actions add action police rate 7mbit burst 1m pipe index 1”
> 
> and the like, the burst size is now being printed as “1Mb” rather than as
> “1024Kb”.  (And the same for the subsequent tests.)
> 
> This is because, due to the rounding errors the patch fixed, the precise
> value being printed for the burst was previously 1048574 (2b less than
> 1Mb) which sprint_size prints as “1024Kb”.  The value being printed is now
> 1048576 (exactly 1Mb).
> 
> I would argue that the new output is more correct, given the input “1m”, and
> the test cases should be updated.

Makes sense

> 
> What is the proper procedure for submitting a patch for the tests?  Does it
> also go to this mailing list?

Yes: https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
net-next is the tree you should submit to.



