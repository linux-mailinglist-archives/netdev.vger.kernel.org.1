Return-Path: <netdev+bounces-161428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C2A214EF
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 00:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BB31888B61
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1251AAA10;
	Tue, 28 Jan 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iT11XQ+p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573EF1991B2
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738106401; cv=none; b=uxKpmzKQNPbwLid8pe7MRhvVbbTw8Y1zFJVXxz+KCby48nKqC307w04JDpgb79zQxoCHaRWur5jpikC12AYtqsX8IuHKh1H4aMVDutbXrwt16fZpMJ7NwmErcA8e0PQlIJDQH4t8h54ybL8bcoNe0bFN7TWTcRtXfoDQoJ5o+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738106401; c=relaxed/simple;
	bh=1vkkErPiEcjzClmRbb5a1hJIXCPd6PeTfCEDhvVExNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWEil2giFlf6YrnVOK5gD+A4rCiErRvaqSurM56t20cl7N5PCgXRlWE5xc/Nd3FS7a8utO6U3Dlr945iOV21fZUTIvcR/2mvj6h9mlI1FXmA5paXga/6YBVVrXcC2jCxCEGjTXa6Z/Pdepe4Xwk/sSO1naDDk7GnlDuE5biztn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=iT11XQ+p; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so8371975a91.3
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1738106398; x=1738711198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cNIPcylAvezegBNfsqGMx0UnWUL7NCDs2HldDioUug=;
        b=iT11XQ+piZ7z5KW+Ez/Z/C3c2hUs4S6VGmogWtxuYS33F5ma7VKlMwvXeqjRLS+DiT
         pN0zVOjNLez7y9HhVQ1hjomhdXKnWv2BmzghRyxRTb3k+j/I+XYlf9tWUylZs0o15dG5
         o+MX13kJ707HAim5eqr5mpaQzvnrFFzvelVB5IE/K+0xzi25KHu2bcK2rmYksOGXpvfz
         FgRXhq2sZlIc5H+cRBlsMeZksMcMgM4o0x8KeMIAJBPVk+4siJ8c1ti9hBW1xWIyKUKU
         yFNN1W7hZgBoSOn1adA2sFO3FoHns3WLAvFM4syxae8AgZi0xn/6nCEz/2i5VR7HGFdC
         jOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738106398; x=1738711198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cNIPcylAvezegBNfsqGMx0UnWUL7NCDs2HldDioUug=;
        b=TR9+6gQ5WTSrQZmIcAvtsRfGjR83Ag5aVFWRDZua237YbrSWUyYF1b2Gn7t/7682LZ
         XZEK/lLV3UwBM90S+28S6a+ijW1aRfxkxK98780x0QgiEevNzf1whPEavAshdNwLummw
         NI+34nBlJQ1oIOPRcL4ptyytmY+Hj7EkIOr6ub06bTGobqq+SusiKXDIzW0kIKau0sUF
         4NUhzPza7th6FDurXGQvBHLhHm5usX0XKHmPw2n3V4+K+ZYTXcQWPW67Z3xDT9Ouh72T
         FVpYlvRzlYtM55and7crwuHOmDqqJrLa6VUirN/i6zLBXIPcZMH62bx38aPLr47DpLx/
         O3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXYBBt8qlwV9/GD9G5RlnWPKrojNZGolu3aGx/GtigqLJ7pYq6YZPjG8A3My60m7R7VzNeqOiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgf9PeI673zCeRAv84sbwuiSsV+Qg8zMACKREUofQiSE9uW+j
	Re/+H9z5PN4LoJlXroUb5unq/xOgmhyhaEtFl+dxuu/FqePUuT4gp70gc6YSSg==
X-Gm-Gg: ASbGncvJTG9NpRtlCrE9yyPtdDYP36kQzavMaKSB+DPmL4C3p3p/k9Icp+23bPfgWC8
	O9j49IsEnOnUmwrU2oRNvGOFa1Tlvz3TKSguPERw+kT2u/j3nwRGF5+yyY1H1aZohHfTfUtNqSi
	S8W4ERqBC55+3rVRc3YW6EUppHj/2BnEB00N4uo6CM1mawxCBUsW4+83BTAfPDdPEHVKLnz5edg
	ohHx+mZ8jd5y5ApYXfFt/NIBBuMsMxQVXuS29IPix8iECur6wbr3O917fP+kkk4HBYqd8ExNP3e
	CovEZJ4v1PsP/+YTxe1GuV0T
X-Google-Smtp-Source: AGHT+IHslAZlmDMxWRKHgV7YhvMVfzqe5A6YEVVGTZyC1uI+mg7N/f2sTvpJfGyC60+TdCiHOFSGlw==
X-Received: by 2002:a17:90b:2c84:b0:2ee:b2e6:4275 with SMTP id 98e67ed59e1d1-2f83ac65958mr1102125a91.26.1738106398110;
        Tue, 28 Jan 2025 15:19:58 -0800 (PST)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bccc8bcsm115723a91.13.2025.01.28.15.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 15:19:57 -0800 (PST)
Message-ID: <f49814fb-cd69-4c3b-b8d4-c529a99c10e5@mojatatu.com>
Date: Tue, 28 Jan 2025 20:19:54 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, quanglex97@gmail.com,
 mincho@theori.io, Cong Wang <cong.wang@bytedance.com>
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
 <20250126041224.366350-3-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20250126041224.366350-3-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2025 01:12, Cong Wang wrote:
> From: Quang Le <quanglex97@gmail.com>
> 
> When limit == 0, pfifo_tail_enqueue() must drop new packet and
> increase dropped packets count of the qdisc.
> 
> All test results:
> 
> 1..16
> ok 1 a519 - Add bfifo qdisc with system default parameters on egress
> ok 2 585c - Add pfifo qdisc with system default parameters on egress
> ok 3 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
> ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
> ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
> ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
> ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
> ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
> ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
> ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
> ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid format
> ok 12 1298 - Add duplicate bfifo qdisc on egress
> ok 13 45a0 - Delete nonexistent bfifo qdisc
> ok 14 972b - Add prio qdisc on egress with invalid format for handles
> ok 15 4d39 - Delete bfifo qdisc twice
> ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> 
> Signed-off-by: Quang Le <quanglex97@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>   .../tc-testing/tc-tests/qdiscs/fifo.json      | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
> index ae3d286a32b2..94f6456ab460 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
> @@ -313,6 +313,31 @@
>           "matchPattern": "qdisc bfifo 1: root",
>           "matchCount": "0",
>           "teardown": [
> +	]
> +    },
> +    {
> +        "id": "d774",
> +        "name": "Check pfifo_head_drop qdisc enqueue behaviour when limit == 0",
> +        "category": [
> +            "qdisc",
> +            "pfifo_head_drop"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP link add dev $DUMMY mtu 1279 type dummy || true",

You don't need to manually add or remove a dummy device for tdc anymore.
The nsPlugin is responsible for it.

I ran the suite with both of the tests without the link add/del and it's 
working!

Can you try it?

> +            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
> +            "$TC qdisc add dev $DUMMY root handle 1: pfifo_head_drop limit 0",
> +            "$IP link set dev $DUMMY up || true"
> +        ],
> +        "cmdUnderTest": "ping -c2 -W0.01 -I $DUMMY 10.10.10.1",
> +        "expExitCode": "1",
> +        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
> +        "matchPattern": "dropped 2",
> +        "matchCount": "1",
> +        "teardown": [
> +            "$IP link del dev $DUMMY"
>           ]
>       }
>   ]


