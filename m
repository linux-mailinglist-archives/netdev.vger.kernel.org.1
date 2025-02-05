Return-Path: <netdev+bounces-162832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF568A281BA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A33A1842
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4321127D;
	Wed,  5 Feb 2025 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="26BpcaDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2D206F13
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722074; cv=none; b=QmsUMsIilyYpMJ5avfk+g+XolsKbeiNdb+ao03/ynEMwXQvj/09FEkUS0mQ6m6EGYn9nG5IJxwJvDXKcQ4BHXdHsY5Ri+YpnqAUhCEPpYj7BECGxz1O4AwJMl8Q3XzwtoxULlSgw3f3VcpswOhYi7Ny4ZfcwO81WxxtWsAmXaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722074; c=relaxed/simple;
	bh=lMP+BjmzKI8tn+Sg+dgqbNoX3BaluCT/qw11erjSyJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL8D2gYXCUuRQPxMU7YQRYn3ggdW353w/vSht37drZulHZ9th/bqxxy/Au2xxmZ5Wq03P/+OQQeB0LARuk26sDBtWpsJfTc3DmoOCzAD88xiorfNGNHUpLArRrYV2Rd5wti5WrkPK/UD4+aiX8MHKF8NlzSIBK0HCZnttCrXHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=26BpcaDm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9e415fa42so129474a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 18:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1738722072; x=1739326872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxWbDJF8Jj71f8RRxAWNFhcfPa68PXV4TmsHsvmAv+o=;
        b=26BpcaDmQHHjmfcB6EIu5Q5c4o5mkI1LQj5T+f+E2tcN1aVA1xO3zwnNe4RA3+ohmt
         82McwUAJFmsWd6Pmjc4GQg7aSw6Q8k1k3ZoSwjUuUGiC374d+EuA6EGKRqISx3FPb9oi
         v3Q/Ti4+nyfX2yToBqD0T/X0O/ILxDcg08SGXJRo0iauFVuRlalWfDpInOCB8KFZyH7c
         xlgRMs3QTXWejHMOoTvCb4R/9V8Af45BRwCfbzYxFqkJ6Tp/snlEAjcSXyUMzDP/saq7
         ygdYbDfaDVnKTIl6hfNFxg0I6h2ZkH8oFSwqrnyUGgeQp9hyIVNnvxTD2vX27STHTe45
         LYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738722072; x=1739326872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxWbDJF8Jj71f8RRxAWNFhcfPa68PXV4TmsHsvmAv+o=;
        b=eByJ0rGgedzlbSfBxeuKVLOYjLGpK22pfmgmsOh/zvCKRcjXQIhanj5M1HwVZoF3IT
         ql25OWnK/GCrUUceoUlRdc9DZ+FRpWRpeqvjFnWLTLluTGSTZ6bjqcEMF3HHkjW7FK1s
         SXVXPDXlR4XCZBqtqguQSw7gjNlXJjdNQ/IHf6N05QjXzfm7gMY9ordWO8TeXfcrLSVS
         LbBuNsgd0qwyKSxmYyxjEy5H5X20Z5OnZAW0sr46/UnwMJgMeGOuqGyjNh9SwHDxEqSK
         F6nepU0l04Ueei2TYKe8ulTmU26+IHtz+dyiul36DoXJ5PN1UVNG/s/jNiNbOEVCC3XP
         RZFg==
X-Forwarded-Encrypted: i=1; AJvYcCVST8ay/bGvlUefYZKbKe0Pip2H2jfaAidYXasnwQSPhmEv4O2rrYNftjxbdY6xEX0WOu7pEYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs93MoS/BmpjBHP/nROPztkx1vQNqGwlE31flcKM3GXrUYdxYq
	HfmOuUNqhuy7EKeVnwtliNuKjQPLPzhe+A6GOS5+6KMcB0Wnj4WYmDdUKz/o1w==
X-Gm-Gg: ASbGncshcHQxVXWXyRZC73F5rh5flP3BXQp4OAwgReitqrm2oFH3dEivNRMXaVnKKfD
	wSs/tUa7Rhp4R6AYQ/P6MlKLTRkBJnxXkKl5mCcFKFv963Ugup+Ai5yHezSzO/AgUVBzfqpPoDK
	fj2FifxheAXaKQg8ZhluXFH1k/rXRhRhdhgAQ9fvoVu5LrE0LYf4j3W3z4pOk9VvZ5LJgqGMwaG
	/A0LSlBhMp7UepuT76qBhhFb8FNSJv0qrUb4c2yZnrsqjTajpiMwk+U8jVtAZdT2Y6LYa+svKXs
	iUa+tKUJjBSLXWQsy+Va8OdE
X-Google-Smtp-Source: AGHT+IHfD/qQrTfUqdRI8zMjuBVIs+PcQIeWyoNJ2aHBvVJqMxa+1rlzGUzhZ45wxJg4A3wtt0tvbw==
X-Received: by 2002:a17:90b:48cc:b0:2ee:c9dd:b7ea with SMTP id 98e67ed59e1d1-2f9e0816177mr1720218a91.24.1738722071825;
        Tue, 04 Feb 2025 18:21:11 -0800 (PST)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1dbe5f3sm278925a91.43.2025.02.04.18.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 18:21:11 -0800 (PST)
Message-ID: <b06cc0bb-167d-4cac-b5df-83884b274613@mojatatu.com>
Date: Tue, 4 Feb 2025 23:21:07 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v3 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>,
 netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 mincho@theori.io, quanglex97@gmail.com, Cong Wang <cong.wang@bytedance.com>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
 <20250204005841.223511-3-xiyou.wangcong@gmail.com>
 <20250204113703.GV234677@kernel.org> <20250204084646.59b5fdb6@kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20250204084646.59b5fdb6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/02/2025 13:46, Jakub Kicinski wrote:
> On Tue, 4 Feb 2025 11:37:03 +0000 Simon Horman wrote:
>> On Mon, Feb 03, 2025 at 04:58:39PM -0800, Cong Wang wrote:
>>> From: Quang Le <quanglex97@gmail.com>
>>>
>>> When limit == 0, pfifo_tail_enqueue() must drop new packet and
>>> increase dropped packets count of the qdisc.
>>>
>>> All test results:
>>>
>>> 1..16
>>> ok 1 a519 - Add bfifo qdisc with system default parameters on egress
>>> ok 2 585c - Add pfifo qdisc with system default parameters on egress
>>> ok 3 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
>>> ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
>>> ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
>>> ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
>>> ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
>>> ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
>>> ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
>>> ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
>>> ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid format
>>> ok 12 1298 - Add duplicate bfifo qdisc on egress
>>> ok 13 45a0 - Delete nonexistent bfifo qdisc
>>> ok 14 972b - Add prio qdisc on egress with invalid format for handles
>>> ok 15 4d39 - Delete bfifo qdisc twice
>>> ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
>>>
>>> Signed-off-by: Quang Le <quanglex97@gmail.com>
>>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>>
>> Hi Cong,
>>
>> Unfortunately this test still seems to be failing in the CI.
>>
>> # not ok 577 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
>> # Could not match regex pattern. Verify command output:
>> # qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
>> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>> #  backlog 0b 0p requeues 0
>>
>> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/977485/1-tdc-sh/stdout
> 
> This is starting to feel too much like a setup issue.
> Pedro, would you be able to take this series and investigate
> why it fails on the TDC runner?

It should be OK now

