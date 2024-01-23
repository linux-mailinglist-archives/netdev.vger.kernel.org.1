Return-Path: <netdev+bounces-65136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF783956E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A121C21633
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA382D6B;
	Tue, 23 Jan 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zQkjTFIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2212A143
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028463; cv=none; b=AKJLfavLAdsOHX2dDzPZrrXkQNNg3MdsqEIVKy5LacvUr82ymULDlL6bJ1GF+SttwMvVfmlaux2E5jEd8g5REwDMPUcOWmLZJxEemvqES69VXVRS0teobm+oup/jXqc06pqy66wJYI6EOLGv6mFyNDgNlI9u1ofB8LXQpyd6OWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028463; c=relaxed/simple;
	bh=o/fpwOrvUmMpfoEfJ01gixL0n+MsEw9v/AFHbrUrQkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Muqx4AzjzOWGRUsFCz/bxBxwOrcX8wHgcXQWo0c51LWG/TnTGacIsMuYda862z9G1h0+/84u8fZ5UfG+fKAcqHrTljCcGyR5O+kCyGWrHQuAihP3raS2v/c18EY6Z1dlrclL3YYdasZeOKIlCAgKkfcUaYYvmK1UhWBClIcSXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zQkjTFIp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso3417229a91.3
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706028460; x=1706633260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVC/il6Bt/B2ECz6aNJHxALEzqI1pMVORnEgxnRNq04=;
        b=zQkjTFIpJentxTUlFrOAwtXFnGpCweN8BGpnaXK7m1owMNUmYrWIxCiLKS2zvBRiiG
         //r7ymMdBTpzkw+VJM0KXc2j09GAy4lIZP8xJTtXeHjHskm4inLeESj7+m0RrD3PHFzW
         NZSVGfpESG+AiepYleH3n8oSivXQFwXWicgJuLQTKtf6DJzu/KodYCEY4wUoBEANIMWL
         wRRTrs2/HGdWH2htXcEVZSKCctxkHOZrBzDKelpVGpm2BcA0XK8PDKviRGnmYwlTeFSM
         /RsJxquej0n8da4a5bg+ivyqkMy8cg9B0S4Yfvkq9CA2IkqXdL4dFLEUgUayyoPcLmnh
         yTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028460; x=1706633260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVC/il6Bt/B2ECz6aNJHxALEzqI1pMVORnEgxnRNq04=;
        b=nWphP9rqZclOoK+/s+xB+bsho26VkSB9bvn4+WNCgQE4wb2Q15UX0u+grGl2OBsuuL
         6dPmpZmkZ4s7k3/0MHn0KJehjcTfvo3PPH0waDDuRtcyy+t4Id3TyKAJC4YVPQI3bcq8
         gOfkSON8EBKRrpZDsMf0/paxznweWkc2rotSgqC3DWv1jk5JF4Hrysd8NAZLpnHijKoA
         H2JRRZT/zGnHhN38eZU8gt6tlnw3hUkDV6n7Rc3hl5/cpzi9G171l/AUgIu5FM76dFzS
         mnZG/CRiGtunh8v8vH8JmMUS6RmkH8FmccqJ3WCYuX0InhaTjhXYe95BMrsXQyN6F/Zk
         ZlGQ==
X-Gm-Message-State: AOJu0YwEuPxCVmP/YqaJJuQO7PNfa4tZWUCPFvz4QYh2/G1o8GTZwtxi
	Ov2mXbTbufK59YmuWrPUWQElN2qg3APqT//Soeo/51x9q3SKLDLrZl9w90PM+A==
X-Google-Smtp-Source: AGHT+IFTK7r6UAIBDqaijs92x62JEETMUk882++zk2+xfngtvS5T7Nz3d700SJ8BQcLVrY8Jdf6mXA==
X-Received: by 2002:a17:90b:1e02:b0:28b:2f4f:75e7 with SMTP id pg2-20020a17090b1e0200b0028b2f4f75e7mr3266190pjb.13.1706028460319;
        Tue, 23 Jan 2024 08:47:40 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id rs7-20020a17090b2b8700b0028d70a8d854sm11935412pjb.54.2024.01.23.08.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:47:40 -0800 (PST)
Message-ID: <7d92788b-13c5-4f53-8b58-9b6ece26310d@mojatatu.com>
Date: Tue, 23 Jan 2024 13:47:35 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] selftests: tc-testing: check if 'jq' is
 available in taprio script
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org,
 vladimir.oltean@nxp.com, edumazet@google.com, pabeni@redhat.com,
 linux-kselftest@vger.kernel.org
References: <20240123122736.9915-1-pctammela@mojatatu.com>
 <20240123122736.9915-3-pctammela@mojatatu.com>
 <CAKa-r6s_DO1tfcZdsQNBCwjbE0ytJKnZWnvcKqTR+5epdNq4YQ@mail.gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CAKa-r6s_DO1tfcZdsQNBCwjbE0ytJKnZWnvcKqTR+5epdNq4YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/01/2024 10:17, Davide Caratti wrote:
> hi Pedro,
> 
> On Tue, Jan 23, 2024 at 1:28 PM Pedro Tammela <pctammela@mojatatu.com> wrote:
>>
>> If 'jq' is not available the taprio tests that use this script will
>> run forever. Check if it exists before entering the while loop.
>>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> ---
>>   .../selftests/tc-testing/scripts/taprio_wait_for_admin.sh    | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
>> index f5335e8ad6b4..68f2c6eaa802 100755
>> --- a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
>> +++ b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
>> @@ -3,6 +3,11 @@
>>   TC="$1"; shift
>>   ETH="$1"; shift
>>
>> +if ! command -v jq &> /dev/null; then
>> +    echo "Please install jq"
>> +    exit 1
>> +fi
>> +
> 
> nit: what about returning $KSFT_SKIP (that is 4) if jq is not there?
> so the test does not fail.
> thanks!

Since these scripts are run in the setup phase, it has a special treatment.

Take for example this run:
ok 1 ba39 - Add taprio Qdisc to multi-queue device (8 queues)
ok 2 9462 - Add taprio Qdisc with multiple sched-entry
ok 3 8d92 - Add taprio Qdisc with txtime-delay
ok 4 d092 - Delete taprio Qdisc with valid handle
ok 5 8471 - Show taprio class
ok 6 0a85 - Add taprio Qdisc to single-queue device
ok 7 3e1e - Add taprio Qdisc with an invalid cycle-time
ok 8 39b4 - Reject grafting taprio as child qdisc of software taprio # 
skipped - "-----> prepare stage" did not complete successfully

ok 9 e8a1 - Reject grafting taprio as child qdisc of offloaded taprio # 
skipped - skipped - previous setup failed 9 39b4

ok 10 a7bf - Graft cbs as child of software taprio # skipped - skipped - 
previous setup failed 9 39b4

ok 11 6a83 - Graft cbs as child of offloaded taprio # skipped - skipped 
- previous setup failed 9 39b4

As of today it returns 0, success in ksft, even though it clearly 
wasn't. Looking at the code any failures in the setup/teardown phase 
will stop the run, skip all the remaining tests but still return success.

About returning skip from the script, aside from marking it as skip and 
continuing the suite, we would need to run a silent teardown, one that 
executes all commands in the specified teardown but
ignores errors. In this case we are assuming all setup steps follow KSFT 
return codes. Not sure if it it's reasonable or not...

As your suggestion is not a blocker, I would rather address the above 
problems in a follow up series since they will require some refactoring.
WDYT?





