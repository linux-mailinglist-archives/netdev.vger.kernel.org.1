Return-Path: <netdev+bounces-68229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488684636A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 23:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843891F24722
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 22:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF5405E8;
	Thu,  1 Feb 2024 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jIWCv5KV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411033FE24
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826356; cv=none; b=HSjgfNVwXBXhd3/LkD9G3l6iDVD09PfGeb2X9xPA/hNfdLXAe6TqNFub2TPfZsfx4dx1Xe29dosdwboTfhZ+HxXd76yfgqvYoHgcH6rcKkvfwwnIFlh5d48CooIFxLfGKXVvt6Wd5+nrc03gHGEwRa5Lj4i23d796jC9fHtomnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826356; c=relaxed/simple;
	bh=eWqkLADtb5bW5/KCLBfbk+adOyumfQDzQziJ/NBFwoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpqEr1d/iULRCdVYLpkuIPZiFWVsLqt1o8LxMpNMlhqDUwySbz2VtLhLUIYyxaJyhslyj6u91zv2H181VJ1lsYIawU1Na451g2Uv0xyQGMZzhhmRUu6i76SWcQZjWkoHR/Cs3pfnsLBFgBwptnMQH4+4oBBJC6ovSeHTyPpAwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=jIWCv5KV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e80046264so12685375e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 14:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706826352; x=1707431152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5OGPe8fMGrZiGY/WsI9iHz2kC7stVcrU+hI6G07cdc=;
        b=jIWCv5KVbes7Dkqg2yfTU5zPEMLJFEt6cIm1V1hUmd+WiFk9qefcSRlucE6mYuQErA
         aq8XZCFz7mxeowi4v+YkYMy6g6chCjQZKG8nTkC/1t3NXhBNcYgvYUrclkGF0gbOGn8W
         HWsQXnIe814CRxw0d8FY9ZLgvQJvQTx5u8tZIVKqg7/Q531Ijpsscy/Ib05lrknm1/n0
         ZmfGAPflejNTBcvOyx5MtiBPknrYJpZew4HnMmvWoetTVRwbLDbdtklVRzPUMFCuErSl
         KYn8JKyebl6zCLIJ5mOh+lE059JBV378ItOAnPXgGrXdPq0E30x6rzUkoFmBQdiNtyT9
         Wckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826352; x=1707431152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5OGPe8fMGrZiGY/WsI9iHz2kC7stVcrU+hI6G07cdc=;
        b=BHC46fEB9OGmsigEdhUhVeHOi0XXvAKUfysOi1NOePsISr3IqexXTER24RnAh2+N7+
         J7p7vyXDihM7hoXemu3Ho0cGVYelJ4kVPaNCCuHhTMH3Y1ZMm3p3lmYcgxmS4ukvIp+U
         Wj5m/X/SdzA40530t6MB6zC9AVjGHc/VLBokJrzuuWh69vorIu+Z6AnSwhQmS8ePzoUq
         TnTYEIXjd8RM1cUoDcHNI0raqgtNhxvIeOi27S7/VQRJOGUidEaCv/w+r5pJ6+3pa7Ls
         yaAtu2hipAEhN8dF1Qg/GpoguDbDeKP0Wxof6plc+4mSCqPDY9b97GGrD62qi+pPFHvr
         PEzQ==
X-Gm-Message-State: AOJu0YxmOegiTmFSrLCC3wc+nZPsRlI/xQ3RvByBjQYj7sxqrqmyOwH6
	OR+mkAxy7te9/9y87EWJZO1sdTc6fW/WK9XUMV0zzS0PoVcKg1XcNWKxdQoXrQ==
X-Google-Smtp-Source: AGHT+IGJlPHNdMAOXCykf/zcT0/0eH3nUS8ULVNPQ62sdg19QXz87bDGpHBBcSQ+FuJR7MoGSHoVtw==
X-Received: by 2002:a05:600c:5013:b0:40e:ce9e:b543 with SMTP id n19-20020a05600c501300b0040ece9eb543mr248751wmr.41.1706826352441;
        Thu, 01 Feb 2024 14:25:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXy2nimmidc/lYZx7u9YKm1nj46/fBI4e61H7l2395qPbs3tuoy2lL4ELsBGA4/o4wY7trYHkfLvvpzO/mAiDj1NDSpihDrusdKXVV5fV16aDBOydVQRlnaBlMpKQZLM8zIH39YheO/P7iCPw2HMZ+BKgWTfsOwUqOxXP1CyySXj8MyOyQsQBOhtOWt4FdtE5U5z7sS5n6bVYfXDZeMC/KoLQz4QtXSOdwk7zr/9GGNrPNAG1jNAyxcil/94qZgD3sJG7R52n7cauQuq10ac6qnLeEaOGcnMTpZWCh0/VKlLeU2wEzORYSlIsVnxqEtlgQfJ3P+Z3sR7N12v6/R1Mf/o7tYh6ZuK9WYz74/
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d4e12000000b0033afcb5b5d2sm456479wrt.80.2024.02.01.14.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 14:25:51 -0800 (PST)
Message-ID: <44d893b4-10b0-4876-bbf7-f6a81940b300@arista.com>
Date: Thu, 1 Feb 2024 22:25:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] selftests/net: A couple of typos fixes in
 key-management/rst tests
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
 <20240131163630.31309ee0@kernel.org>
 <e88d5133-94a9-42e7-af7f-3086a6a3da7c@arista.com>
 <20240201132153.4d68f45e@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240201132153.4d68f45e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 2/1/24 21:21, Jakub Kicinski wrote:
> On Thu, 1 Feb 2024 00:50:46 +0000 Dmitry Safonov wrote:
>> Please, let me know if there will be other issues with tcp-ao tests :)
>>
>> Going to work on tracepoints and some other TCP-AO stuff for net-next.
> 
> Since you're being nice and helpful I figured I'll try testing TCP-AO
> with debug options enabled :) (kernel/configs/debug.config and
> kernel/configs/x86_debug.config included),

Haha :)

> that slows things down 
> and causes a bit of flakiness in unsigned-md5-* tests:
> 
> https://netdev.bots.linux.dev/flakes.html?br-cnt=75&tn-needle=tcp-ao
> 
> This has links to outputs:
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-tcp-ao-dbg&pass=0
> 
> If it's a timing thing - FWIW we started exporting
> KSFT_MACHINE_SLOW=yes on the slow runners.

I think, I know what happens here:

# ok 8 AO server (AO_REQUIRED): AO client: counter TCPAOGood increased 4
=> 6
# ok 9 AO server (AO_REQUIRED): unsigned client
# ok 10 AO server (AO_REQUIRED): unsigned client: counter TCPAORequired
increased 1 => 2
# not ok 11 AO server (AO_REQUIRED): unsigned client: Counter
netns_ao_good was not expected to increase 7 => 8

for each of tests the server listens at a new port, but re-uses the same
namespaces+veth. If the node/machine is quite slow, I guess a segment
might have been retransmitted and the test that initiated it had already
finished.
And as result, the per-namespace counters are incremented, which makes
the test fail (IOW, the test expects all segments in ns being dropped).

So, I should do one of the options:

1. relax per-namespace checks (the per-socket and per-key counters are
   checked)
2. unshare(net) + veth setup for each test
3. split the selftest on smaller ones (as they create new net-ns in
   initialization)

I'd probably prefer (2), albeit it slows down that slow machine even
more, but I don't think creating 2 net-ns + veth pair per each test
would add a lot more overhead even on some rpi board. But let's see,
maybe I'll just go with (1) as that's really easy.

I'll cook a patch this week.

Thanks,
             Dmitry


