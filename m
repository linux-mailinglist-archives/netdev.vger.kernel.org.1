Return-Path: <netdev+bounces-272386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFb3EJUqxmnQGwUAu9opvQ
	(envelope-from <netdev+bounces-272386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:58:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D818C3401CF
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DD7031118EE
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7463C0608;
	Fri, 27 Mar 2026 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SR6FD+wu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300733C061A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593726; cv=none; b=BrdUtDRpINWveR2RP4qc3EwUKyLDrVPqmYfOl2neWE0MBbvnES1Wk1jyllCct1a0y0a1kPAXeFEDCjlXXKMao/n62XlCuFBqyFBitGpgwn7+CTYBshvRccBllmsB1ky+ap4/iYfKtf10fTJR0wecUEs/OKwXgCYTMBpPPY5q0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593726; c=relaxed/simple;
	bh=1DVvOQT5/+mxb45EgxQ4bZpWpNiDNjMj+xSlK6Mjv9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WB3hPGqrx9e9B7AUJbqKRx6ATeto5N6qeTpviu6kSpUQiusP2/4kRRi4WQt9ErbEpVLTY6nWVS7Ga55fGhQDMDCMVOJT6lPmFFt6R3cNVEr/i+GPAY+77uGQsFEQHMXsf9Gq59tse6qPCmHAf4DLlvQxoRAMi/+0JgYv/fgT+Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SR6FD+wu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso25839955e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774593711; x=1775198511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1sYbnxelvK9CSuY2huaIB6H/ZT6wbmHM2ZeRybED1c=;
        b=SR6FD+wuqPzTfyRQC6bbpZHIf8uftPjGtLmJUY1lt1oIut/utxYsVoqxY4bBmAWD+E
         dZB/rEWv6jzrmeWUylt8H0z6tFjkWzQX7NZvaAA2ju3pCQmtJA24nH64YnjJrojmEtiu
         jwbTUnzQ3ZeHn2Q4w9SptYJdq2u4R8HByaQ8qAB756HUGaxqtd46WgaTidjha7KqA1Hm
         AcApR2AaTzOozJsS/FTvkT6MpwkfJnKL+ISj0F6ShS1JSskmVR4jgNNFiaNyCus2CMMb
         4uBoG/nrj5zRX2IOzkxI6cMdcy0CdQHs8fgVF5lNROGcZPJe2p6rVtRAr/hMO2ghEAE6
         7ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593711; x=1775198511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1sYbnxelvK9CSuY2huaIB6H/ZT6wbmHM2ZeRybED1c=;
        b=NEs0gzYriQ7wmbOpMJgs85HYQ9iZxPyIlvkRelcOw7BPFwleEPbqI+uSolVqG+APmV
         luu7EoNMmFWbZS3GJk3vPTOIoqpebqAti4YIbee3yY31aTgh0l4CW+X5xGFwpaCChI/8
         dkpjn1YK3BLcBhTcDIYywZ8sqNA/IuxVwGfLYp2CHv76Pqs3cbldHf7khnx5q4KJYebk
         ksFV3XuL5lCXnQZdTP3lgHUl/j8J2m9vR9USIVru9P0hIubuILUuMTSxowb5kOXIVb99
         pTOEjutrP04GBHLf+17QqFNu0TfqbpoZnGWhBbnLf8jTZkA0mqYKcyPuw/xDdLYptn4R
         0t+w==
X-Forwarded-Encrypted: i=1; AJvYcCVK2NmnzWrHNKuoHOsXcmtjAgtk7wiZV4QVpc6G6eO8K0Sla+juorr+f2On/xraegwGideL4QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7rdiIXBUjUKVs8+rlJqXy/7DpfZyuVbKnFBM0EWV8c5rGgR6
	IBsEaxfM0ggidJw+XMBreCy45TE16I2tgF1X5bt0Gb2OD804agsigpN9Rn7084yGFt0=
X-Gm-Gg: ATEYQzzZvs6ANmJxw6vLJ3AX8NhUbDeS1tltVNnmxPm8QP8Gma7YhOZCJ6Q9tTKd6pp
	8/KHzCDAwYDMkQLASubhraLIS8MZH/HEEhV+IDSibSZcDgdZO3sZ0vE4dGdyRqiAFrYNN5SSpqC
	MVhtOZ2yW2+Hz1N6n1WMvXi7UmUnt5MnytHck0TMb+2BeTSAjXIaAFiz+0fXsFrLP3jwvJVcAh/
	+BzvqSkPTMP4+Dp2zEuWLJYHssJlPZeTufN0MAZ3BtTYA6rIFVStaZBHbYXqQWCf0p+2hO7CV3I
	9gRIgQMM7JIhAuhHY4HmrXxpxBjy9lX6WkejtPoFp/v5GjXNMhOjMeU+N+JVWCjajvAr9qyz0bB
	UdQKyw7npRRhGyDoeMiICg5TMkruEZ9iw0Z7a9yTo+1xUYqEmIEMeB1SGJ336bLBfxqAr8p1hUi
	LZ6KqIboYdtutdJ4drrNo7FktUgLj2nPZsGZi723v+btIp4KQKZiODDmdXOnDiM2av
X-Received: by 2002:a05:600c:45cd:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4872912dd2bmr13078015e9.15.1774593711374;
        Thu, 26 Mar 2026 23:41:51 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm121225245e9.11.2026.03.26.23.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 23:41:50 -0700 (PDT)
Message-ID: <0e8a01b0-9b83-405f-a0ad-7b335135962f@blackwall.org>
Date: Fri, 27 Mar 2026 08:41:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: bridge: mcast: add multicast exponential field
 encoding
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326150742.50289-1-royujjal@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326150742.50289-1-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272386-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,blackwall.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D818C3401CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/03/2026 17:07, Ujjal Roy wrote:
> Description:
> This series addresses a mismatch in how multicast query
> intervals and response codes are handled across IPv4 (IGMPv3)
> and IPv6 (MLDv2). While decoding logic currently exists,
> the corresponding encoding logic is missing during query
> packet generation. This leads to incorrect intervals being
> transmitted when values exceed their linear thresholds.
> 
> The patches introduce a unified floating-point encoding
> approach based on RFC3376 and RFC3810, ensuring that large
> intervals are correctly represented in QQIC and MRC fields
> using the exponent-mantissa format.
> 
> Key Changes:
> * ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
>    Removes legacy macros in favor of a cleaner, unified
>    calculation for retrieving intervals from encoded fields,
>    improving code maintainability.
> 
> * ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
>    Standardizes MLDv2 terminology by renaming mldv2_mrc()
>    to mldv2_mrd() (Maximum Response Delay) and introducing
>    a new API mldv2_qqi for QQI calculation, improving code
>    readability.
> 
> * ipv4: igmp: encode multicast exponential fields
>    Introduces the logic to dynamically calculate the exponent
>    and mantissa using bit-scan (fls). This ensures QQIC and
>    MRC fields (8-bit) are properly encoded when transmitting
>    query packets with intervals that exceed their respective
>    linear threshold value of 128 (for QQI/MRT).
> 
> * ipv6: mld: encode multicast exponential fields
>    Applies similar encoding logic for MLDv2. This ensures
>    QQIC (8-bit) and MRC (16-bit) fields are properly encoded
>    when transmitting query packets with intervals that exceed
>    their respective linear thresholds (128 for QQI; 32768
>    for MRD).
> 
> Impact:
> These changes ensure that multicast queriers and listeners
> stay synchronized on timing intervals, preventing protocol
> timeouts or premature group membership expiration caused
> by incorrectly formatted packet headers.
> 

Can you add selftests which cover these cases?



