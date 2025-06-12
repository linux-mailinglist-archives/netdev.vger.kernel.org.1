Return-Path: <netdev+bounces-197246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65FAD7E69
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7903A33A4
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61BC2D0292;
	Thu, 12 Jun 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Opc8/Mbi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6AD23183A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767557; cv=none; b=i52rSHV8Cik/G6Yd/O4XXVRjQbwY3ZZc9qrlfg66/O3U/PGeyNRKPOaRM5Uo/lJBHXG4XWKngvWw0sgdCyMg3k+pwqX0qIDGT4uFqLddOkFwmWa+1kC46Z3ail+jlKs3s3NQ81q9FaXVCecuPPA9p0GAFRQYx0HRxMvZdjBT6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767557; c=relaxed/simple;
	bh=NoMF26Qtx+Ol3SWwuiLhTH92fSk52vOntbk0h+nN2Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VjTZ73lYFTFvxcNTZtCoSnKXvaCslDVFiqEZOrRm8mGMXoJJfJNCiqs+yNivWaA2BYrH7aYAn8ikgWZVDzlTYA9jyMhnxrap+hiYiG6WTvsBg3wCaYleSFXcMpXnWOpMBgOCK1iD/yjk0AuZ+fz1kU9pifvmyZ+fIg2sNQgKFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Opc8/Mbi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e1d4cba0so15194825ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1749767554; x=1750372354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vRPhg0HkG1O6ULSVfQfedjgRe5EOXh5BcZVp1i80d+M=;
        b=Opc8/MbieQKjjUHX2mzqXDrOCoJ1tJ40JnNm6SfdkMqzQKQHx43NekD7qEH15hYCg7
         74zi/Rns/YMMu9BUrvMsLG7UoRK/41YMHoqQA+vrKEBPSeEOIqGzrdlnay7nlQyDhnZW
         AJHEANMcz35hUqXzfiYjji0tSC/0HsyfyWJmPbAeoWmH8Y/GvadH6XKGOEpkwExEmcmF
         f8RP1teFbaofuY6ADJBkva2aQ9lcwMFO4TubGsJfy7aUmUQ+a3TTel8wuSBskpcr4WMw
         ATICkoqTlPwINQctttfQPNPiWjMSVzRp3aPY69btty4F+BmAP3iGsborXQ0FIQf2NlvA
         yQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749767554; x=1750372354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRPhg0HkG1O6ULSVfQfedjgRe5EOXh5BcZVp1i80d+M=;
        b=tcWSAtxWQSHueTrfhqW6Q1dkpkWSPV1yjOGGM69p13VtqVU5sZG0FMDRqPtOmgzaXs
         nIfvRr8zx6fwgGYKd4Y1j6WC8XAhzPdm1YsXi4pPE/DkrpWzsduJGvPEd3fP3y2EpnKe
         W7CPh+VJ4gyvz1MYERWZfGG0kX9YpHOnuvgWn6q38PsySTxAq/8RG5tp0jk6Fcy1fum/
         4nkJ01eNYfpRIjn0hhHCK/PRIWG9WzIfebEO46Sxnz+nFDj/1iARQMP2jRZQWbggkuYJ
         mGPmb5B/4HYAWmqPfNanh03xK0DkKIERC49IgMDIm5ZH8TdVaAVgZ8U7rDYrjYziSWqa
         5PBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq8MoK6N2txgtNaDZgiH0ujRf/FyEcxkZR0RL5B8jc2HuMukR2UVll0ke5rOfV8MyAdGRbz5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKcZLNIVWd7MIhGtXIw+dHRbVzodr8Vr26NFvRD7QtyGNnr9p
	k0nIPSiUXJnDUiIuTeEF40yb/MHhFKNduKk7YVezVBUVDyS+R34QtTQlwqXiWA1pEw==
X-Gm-Gg: ASbGncsdhfoZBbI/tSvtkbBZhVhY6FiBsO4llpncxdUakppNZ82q7CNtTO/IjPBBCKY
	zc7knFWnQskjuTc68WESotisvrmWlOt3oTCbwDkjcfUAfAD5EIhSZZg/WDkL4+Iqwdb96Sx5wTP
	x7bXgxl2GViadWhyYoh9OwD/vK357x1GdX31XgNcF6sZcw7pW8TH7ewdBR/lnkut8ocvyaNJRsW
	8ZWsRmbLD+i3eL9Yi3nCDMvbwJdW7ysa81EhYfqVvw8BLB/RxYgsK6ao4b1/9XVd9vDrMlL9cwb
	Hwwb7T9fPR5OBzKmZQWomFeRDKdJWtHIgthWJUMNwElAulDYX83c4PMV5+SlkcRhEK0HODUMbTd
	fQD00yw==
X-Google-Smtp-Source: AGHT+IG6qQgmEUm4OthTstznsY9XCuGrzEmV88tftoYmi5fz1dEvZf++qQu5XGeYC0tl8o9OHZgbNQ==
X-Received: by 2002:a17:902:dacf:b0:234:8c52:1f9b with SMTP id d9443c01a7336-2365dc312a4mr10260335ad.43.1749767553661;
        Thu, 12 Jun 2025 15:32:33 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decdb19sm2285715ad.229.2025.06.12.15.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 15:32:33 -0700 (PDT)
Message-ID: <54e56454-80b9-46a9-a4b8-144432e103c9@mojatatu.com>
Date: Thu, 12 Jun 2025 19:32:24 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 RESEND net-next 0/5] DUALPI2 patch
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250611150852.23218-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20250611150852.23218-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/06/2025 12:08, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
>    Please find the DualPI2 patch v17.
> 
>    This patch serise adds DualPI Improved with a Square (DualPI2) with following features:
> * Supports congestion controls that comply with the Prague requirements in RFC9331 (e.g. TCP-Prague)
> * Coupled dual-queue that separates the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
> * Configurable overload strategies
> * Use of sojourn time to reliably estimate queue delay
> * Supports ECN L4S-identifier (IP.ECN==0b*1) to classify traffic into respective queues
> 
> For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).
> 
> Best regards,
> Chia-Yu
> 
> ---
> v17 (25-May-2025, Resent at 11-Jun-2025)
> - Replace 0xffffffff with U32_MAX (Paolo Abeni <pabeni@redhat.com>)
> - Use helper function qdisc_dequeue_internal() and add new helper function skb_apply_step() (Paolo Abeni <pabeni@redhat.com>)
> - Add s64 casting when calculating the delta of the PI controller (Paolo Abeni <pabeni@redhat.com>)
> - Change the drop reason into SKB_DROP_REASON_QDISC_CONGESTED for drop_early (Paolo Abeni <pabeni@redhat.com>)
> - Modify the condition to remove the original skb when enqueuing multiple GSO segments (Paolo Abeni <pabeni@redhat.com>)
> - Add READ_ONCE() in dualpi2_dump_stat() (Paolo Abeni <pabeni@redhat.com>)
> - Add comments, brackets, and brackets for readability (Paolo Abeni <pabeni@redhat.com>)
> 
> v16 (16-MAy-2025)
> - Add qdisc_lock() to dualpi2_timer() in dualpi2_timer (Paolo Abeni <pabeni@redhat.com>)
> - Introduce convert_ns_to_usec() to convert usec to nsec without overflow in #1 (Paolo Abeni <pabeni@redhat.com>)
> - Update convert_us_tonsec() to convert nsec to usec without overflow in #2 (Paolo Abeni <pabeni@redhat.com>)
> - Add more descriptions with respect to DualPI2 in the cover ltter and add changelog in each patch (Paolo Abeni <pabeni@redhat.com>)
> 
> v15 (09-May-2025)
> - Add enum of TCA_DUALPI2_ECN_MASK_CLA_ECT to remove potential leakeage in #1 (Simon Horman <horms@kernel.org>)
> - Fix one typo in comment of #2
> - Update tc.yaml in #5 to aligh with the updated enum of pkt_sched.h
> 
> v14 (05-May-2025)
> - Modify tc.yaml: (1) Replace flags with enum and remove enum-as-flags, (2) Remove credit-queue in xstats, and (3) Change attribute types (Donald Hunter <donald.hun
> - Add enum and fix the ordering of variables in pkt_sched.h to align with the modified tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
> - Add validators for DROP_OVERLOAD, DROP_EARLY, ECN_MASK, and SPLIT_GSO in sch_dualpi2.c (Donald Hunter <donald.hunter@gmail.com>)
> - Update dualpi2.json to align with the updated variable order in pkt_sched.h
> - Reorder patches (Donald Hunter <donald.hunter@gmail.com>)
> 
> v13 (26-Apr-2025)
> - Use dashes in member names to follow YNL conventions in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
> - Define enumerations separately for flags of drop-early, drop-overload, ecn-mask, credit-queue in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
> - Change the types of split-gso and step-packets into flag in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
> - Revert to u32/u8 types for tc-dualpi2-xstats members in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
> - Add new test cases in tc-tests/qdiscs/dualpi2.json to cover all dualpi2 parameters (Donald Hunter <donald.hunter@gmail.com>)
> - Change the type of TCA_DUALPI2_STEP_PACKETS into NLA_FLAG (Donald Hunter <donald.hunter@gmail.com>)
> 
> 
> v12 (22-Apr-2025)
> - Remove anonymous struct in sch_dualpi2.c (Paolo Abeni <pabeni@redhat.com>)
> - Replace u32/u8 with uint and s32 with int in tc spec document (Paolo Abeni <pabeni@redhat.com>)
> - Introduce get_memory_limit function to handle potential overflow when multipling limit with MTU (Paolo Abeni <pabeni@redhat.com>)
> - Double the packet length to further include packet overhead in memory_limit (Paolo Abeni <pabeni@redhat.com>)
> - Remove the check of qdisc_qlen(sch) when calling qdisc_tree_reduce_backlog (Paolo Abeni <pabeni@redhat.com>)
> 
> v11 (15-Apr-2025)
> - Replace hstimer_init with hstimer_setup in sch_dualpi2.c
> 
> v10 (25-Mar-2025)
> - Remove leftover include in include/linux/netdevice.h and anonymous struct in sch_dualpi2.c (Paolo Abeni <pabeni@redhat.com>)
> - Use kfree_skb_reason() and add SKB_DROP_REASON_DUALPI2_STEP_DROP drop reason (Paolo Abeni <pabeni@redhat.com>)
> - Split sch_dualpi2.c into 3 patches (and overall 5 patches): Struct definition & parsing, Dump stats & configuration, Enqueue/Dequeue (Paolo Abeni <pabeni@redhat.com>)
> 
> v9 (16-Mar-2025)
> - Fix mem_usage error in previous version
> - Add min_qlen_step to the dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step threshold marking.
>    In previous versions, this value was fixed to 2, so the step threshold was applied to mark packets in the L queue only when the queue length of the L queue was greater than or equal to 2 packets.
>    This will cause larger queuing delays for L4S traffic at low rates (<20Mbps). So we parameterize it and change the default value to 0.
>    Comparison of tcp_1down run 'HTB 20Mbit + DUALPI2 + 10ms base delay'
>      Old versions:
>                             avg       median          # data pts
>   Ping (ms) ICMP :        11.55        11.70 ms              350
>   TCP upload avg :        18.96          N/A Mbits/s         350
>   TCP upload sum :        18.96          N/A Mbits/s         350
> 
>      New version (v9):
>                             avg       median          # data pts
>   Ping (ms) ICMP :        10.81        10.70 ms              350
>   TCP upload avg :        18.91          N/A Mbits/s         350
>   TCP upload sum :        18.91          N/A Mbits/s         350
> 
> 
>    Comparison of tcp_1down run 'HTB 10Mbit + DUALPI2 + 10ms base delay'
>      Old versions:
>                             avg       median          # data pts
>   Ping (ms) ICMP :        12.61        12.80 ms              350
>   TCP upload avg :         9.48          N/A Mbits/s         350
>   TCP upload sum :         9.48          N/A Mbits/s         350
> 
>      New version (v9):
>                             avg       median          # data pts
>   Ping (ms) ICMP :        11.06        10.80 ms              350
>   TCP upload avg :         9.43          N/A Mbits/s         350
>   TCP upload sum :         9.43          N/A Mbits/s         350
> 
> 
>    Comparison of tcp_1down run 'HTB 10Mbit + DUALPI2 + 10ms base delay'
>      Old versions:
>                             avg       median          # data pts
>   Ping (ms) ICMP :        40.86        37.45 ms              350
>   TCP upload avg :         0.88          N/A Mbits/s         350
>   TCP upload sum :         0.88          N/A Mbits/s         350
>   TCP upload::1  :         0.88         0.97 Mbits/s         350
> 
>      New version (v9):
>                             avg       median          # data pts
>   Ping (ms) ICMP :        11.07        10.40 ms              350
>   TCP upload avg :         0.55          N/A Mbits/s         350
>   TCP upload sum :         0.55          N/A Mbits/s         350
>   TCP upload::1  :         0.55         0.59 Mbits/s         350
> 
> v8 (11-Mar-2025)
> - Fix warning messages in v7
> 
> v7 (07-Mar-2025)
> - Separate into 3 patches to avoid mixing changes of documentation, selftest, and code. (Cong Wang <xiyou.wangcong@gmail.com>)
> 
> v6 (04-Mar-2025)
> - Add modprobe for dulapi2 in tc-testing script tc-testing/tdc.sh (Jakub Kicinski <kuba@kernel.org>)
> - Update test cases in dualpi2.json
> - Update commit message
> 
> v5 (22-Feb-2025)
> - A comparison was done between MQ + DUALPI2, MQ + FQ_PIE, MQ + FQ_CODEL:
>    Unshaped 1gigE with 4 download streams test:
>     - Summary of tcp_4down run 'MQ + FQ_CODEL':
>                               avg       median       # data pts
>        Ping (ms) ICMP :       1.19     1.34 ms          349
>        TCP download avg :   235.42      N/A Mbits/s     349
>        TCP download sum :   941.68      N/A Mbits/s     349
>        TCP download::1  :   235.19   235.39 Mbits/s     349
>        TCP download::2  :   235.03   235.35 Mbits/s     349
>        TCP download::3  :   236.89   235.44 Mbits/s     349
>        TCP download::4  :   234.57   235.19 Mbits/s     349
> 
>     - Summary of tcp_4down run 'MQ + FQ_PIE'
>                               avg       median        # data pts
>        Ping (ms) ICMP :       1.21     1.37 ms          350
>        TCP download avg :   235.42      N/A Mbits/s     350
>        TCP download sum :   941.61     N/A Mbits/s      350
>        TCP download::1  :   232.54  233.13 Mbits/s      350
>        TCP download::2  :   232.52  232.80 Mbits/s      350
>        TCP download::3  :   233.14  233.78 Mbits/s      350
>        TCP download::4  :   243.41  241.48 Mbits/s      350
> 
>     - Summary of tcp_4down run 'MQ + DUALPI2'
>                               avg       median        # data pts
>        Ping (ms) ICMP :       1.19     1.34 ms          349
>        TCP download avg :   235.42      N/A Mbits/s     349
>        TCP download sum :   941.68      N/A Mbits/s     349
>        TCP download::1  :   235.19   235.39 Mbits/s     349
>        TCP download::2  :   235.03   235.35 Mbits/s     349
>        TCP download::3  :   236.89   235.44 Mbits/s     349
>        TCP download::4  :   234.57   235.19 Mbits/s     349
> 
> 
>    Unshaped 1gigE with 128 download streams test:
>     - Summary of tcp_128down run 'MQ + FQ_CODEL':
>                               avg       median       # data pts
>        Ping (ms) ICMP   :     1.88     1.86 ms          350
>        TCP download avg :     7.39      N/A Mbits/s     350
>        TCP download sum :   946.47      N/A Mbits/s     350
> 
>     - Summary of tcp_128down run 'MQ + FQ_PIE':
>                               avg       median       # data pts
>        Ping (ms) ICMP   :     1.88     1.86 ms          350
>        TCP download avg :     7.39      N/A Mbits/s     350
>        TCP download sum :   946.47      N/A Mbits/s     350
> 
>     - Summary of tcp_128down run 'MQ + DUALPI2':
>                               avg       median       # data pts
>        Ping (ms) ICMP   :     1.88     1.86 ms          350
>        TCP download avg :     7.39      N/A Mbits/s     350
>        TCP download sum :   946.47      N/A Mbits/s     350
> 
> 
>    Unshaped 10gigE with 4 download streams test:
>     - Summary of tcp_4down run 'MQ + FQ_CODEL':
>                               avg       median       # data pts
>        Ping (ms) ICMP :       0.22     0.23 ms          350
>        TCP download avg :  2354.08      N/A Mbits/s     350
>        TCP download sum :  9416.31      N/A Mbits/s     350
>        TCP download::1  :  2353.65  2352.81 Mbits/s     350
>        TCP download::2  :  2354.54  2354.21 Mbits/s     350
>        TCP download::3  :  2353.56  2353.78 Mbits/s     350
>        TCP download::4  :  2354.56  2354.45 Mbits/s     350
> 
>    - Summary of tcp_4down run 'MQ + FQ_PIE':
>                               avg       median      # data pts
>        Ping (ms) ICMP :       0.20     0.19 ms          350
>        TCP download avg :  2354.76      N/A Mbits/s     350
>        TCP download sum :  9419.04      N/A Mbits/s     350
>        TCP download::1  :  2354.77  2353.89 Mbits/s     350
>        TCP download::2  :  2353.41  2354.29 Mbits/s     350
>        TCP download::3  :  2356.18  2354.19 Mbits/s     350
>        TCP download::4  :  2354.68  2353.15 Mbits/s     350
> 
>     - Summary of tcp_4down run 'MQ + DUALPI2':
>                               avg       median      # data pts
>        Ping (ms) ICMP :       0.24     0.24 ms          350
>        TCP download avg :  2354.11      N/A Mbits/s     350
>        TCP download sum :  9416.43      N/A Mbits/s     350
>        TCP download::1  :  2354.75  2353.93 Mbits/s     350
>        TCP download::2  :  2353.15  2353.75 Mbits/s     350
>        TCP download::3  :  2353.49  2353.72 Mbits/s     350
>        TCP download::4  :  2355.04  2353.73 Mbits/s     350
> 
> 
>    Unshaped 10gigE with 128 download streams test:
>     - Summary of tcp_128down run 'MQ + FQ_CODEL':
>                               avg       median       # data pts
>        Ping (ms) ICMP   :     7.57     8.69 ms          350
>        TCP download avg :    73.97      N/A Mbits/s     350
>        TCP download sum :  9467.82      N/A Mbits/s     350
> 
>     - Summary of tcp_128down run 'MQ + FQ_PIE':
>                               avg       median       # data pts
>        Ping (ms) ICMP   :     7.82     8.91 ms          350
>        TCP download avg :    73.97      N/A Mbits/s     350
>        TCP download sum :  9468.42      N/A Mbits/s     350
> 
>     - Summary of tcp_128down run 'MQ + DUALPI2':
>                               avg       median       # data pts
>        Ping (ms) ICMP   :     6.87     7.93 ms          350
>        TCP download avg :    73.95      N/A Mbits/s     350
>        TCP download sum :  9465.87      N/A Mbits/s     350
> 
>     From the results shown above, we see small differences between combinations.
> - Update commit message to include results of no_split_gso and split_gso (Dave Taht <dave.taht@gmail.com> and Paolo Abeni <pabeni@redhat.com>)
> - Add memlimit in the dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
> - Update note in sch_dualpi2.c related to BBRv3 status (Dave Taht <dave.taht@gmail.com>)
> - Update license identifier (Dave Taht <dave.taht@gmail.com>)
> - Add selftest in tools/testing/selftests/tc-testing (Cong Wang <xiyou.wangcong@gmail.com>)
> - Use netlink policies for parameter checks (Jamal Hadi Salim <jhs@mojatatu.com>)
> - Modify texts & fix typos in Documentation/netlink/specs/tc.yaml (Dave Taht <dave.taht@gmail.com>)
> - Add descriptions of packet counter statistics and the reset function of sch_dualpi2.c
> - Fix step_thresh in packets
> - Update code comments in sch_dualpi2.c
> 
> v4 (22-Oct-2024)
> - Update statement in Kconfig for DualPI2 (Stephen Hemminger <stephen@networkplumber.org>)
> - Put a blank line after #define in sch_dualpi2.c (Stephen Hemminger <stephen@networkplumber.org>)
> - Fix line length warning.
> 
> v3 (19-Oct-2024)
> - Fix compilaiton error
> - Update Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)
> 
> v2 (18-Oct-2024)
> - Add Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)
> - Use dualpi2 instead of skb prefix (Jamal Hadi Salim <jhs@mojatatu.com>)
> - Replace nla_parse_nested_deprecated with nla_parse_nested (Jamal Hadi Salim <jhs@mojatatu.com>)
> - Fix line length warning
> 
> ---
> 
> Chia-Yu Chang (4):
>    sched: Struct definition and parsing of dualpi2 qdisc
>    sched: Dump configuration and statistics of dualpi2 qdisc
>    selftests/tc-testing: Add selftests for qdisc DualPI2
>    Documentation: netlink: specs: tc: Add DualPI2 specification
> 
> Koen De Schepper (1):
>    sched: Add enqueue/dequeue of dualpi2 qdisc
> 
>   Documentation/netlink/specs/tc.yaml           |  156 +++
>   include/net/dropreason-core.h                 |    6 +
>   include/uapi/linux/pkt_sched.h                |   68 +
>   net/sched/Kconfig                             |   12 +
>   net/sched/Makefile                            |    1 +
>   net/sched/sch_dualpi2.c                       | 1146 +++++++++++++++++
>   tools/testing/selftests/tc-testing/config     |    1 +
>   .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
>   tools/testing/selftests/tc-testing/tdc.sh     |    1 +
>   9 files changed, 1645 insertions(+)
>   create mode 100644 net/sched/sch_dualpi2.c
>   create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> 

Build broke:

net/sched/sch_dualpi2.c: In function ‘dualpi2_timer’:
net/sched/sch_dualpi2.c:711:40: error: implicit declaration of function 
‘from_timer’; did you mean ‘mod_timer’? 
[-Werror=implicit-function-declaration]
   711 |         struct dualpi2_sched_data *q = from_timer(q, timer, 
pi2_timer);
       |                                        ^~~~~~~~~~
       |                                        mod_timer
net/sched/sch_dualpi2.c:711:61: error: ‘pi2_timer’ undeclared (first use 
in this function); did you mean ‘bpf_timer’?
   711 |         struct dualpi2_sched_data *q = from_timer(q, timer, 
pi2_timer);
       | 
^~~~~~~~~
       | 
bpf_timer


