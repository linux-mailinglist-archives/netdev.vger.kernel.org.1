Return-Path: <netdev+bounces-235486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD95C315D7
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3809E4FA77E
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929D32C929;
	Tue,  4 Nov 2025 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Mk08fj/g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02332BF25
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264743; cv=none; b=VOZPutIWCl7N1FQcD5nmeTfETCyAVtlVL3OtcW7pOVbV7/wE2LYlo0lk8eBEYCFIf1e7Uti/uhrAXQNnw/poouT2CAkRc1+qY3t+mPcGt9n+7Me2pNm9gNPq3dAvP7dI3nQKX8hWKHkQONMSh0Lft/z1MVbZcTDM3m6YNWc23MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264743; c=relaxed/simple;
	bh=gDQAEq0aqIqm792dh7j65fknWz98mAbMJ4Q0te0KDXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6hTpuTjUnF8UWmkD/44SUmPQHGspmhmeOq4fgigc35xpd/alaqRCg8osUh6kEF3r7V3UoJxhGc6FuqPbDYiOmzYlebxsevH80GyQ2G5CeWA27uSGOo+2sTFqInYyZojJ2kk+ow7SNRsVXfyCmb8ylSfhLV8x5p/J3QdOgoTLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Mk08fj/g; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4769bb77eb9so5747065e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1762264738; x=1762869538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KmxJ5G5P+273emX0t2zZMtLOkTrWXY4nFi3xqJqonC8=;
        b=Mk08fj/gro/Vtsd9asZL91UD3D897XQb1mcUGJqBrwBiNGWtIup3WmDpzB4LNjWAGB
         Er4ttPRxB82h4apOFXV1Ek0V1vSeDFQ7PYMAr5zoR5IjO7DhOqX4PVRU/Ov8bYZqIMf3
         TaWJGt0mucQdpL9FohrfGDrU2rU03eJA6iGHdkVSDQGb8j7/s4Lbsl/5tdbX8C/BaLjH
         YyI/bmGy4y21Ej6kQshfHZVcoSIEgRRFvhlJv0bVLwEnkIyKryNrevygi8k1ooqE/Zrf
         +IMjjjXk27HbWMdwfq2yH7imDuZS98dpcV3KZQA9CVcp11u/JP3rpTEkEEe8oiA9puUA
         59oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762264738; x=1762869538;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmxJ5G5P+273emX0t2zZMtLOkTrWXY4nFi3xqJqonC8=;
        b=uMwHHrObAQMDre4aCssCwF1PLdgBUt0jtsEvDjkaLv//i2kTZA04vcodduQYZDIbXh
         hN6xEBwmr3xcg2M/b5yhc/NxzhADtQj2fmshkdvLLcP1jb062GG3qumjabJDBpkiuQgH
         clk3T6gSPfv0/oNk0R4J2tFZk26eXmdLmTNitXJtN97Rqz8HKyW1It8Qd4XLaPoGcEH+
         gyQogkfayzZL+pb73AUc/82nQYKov4Qqf+GRxocfqRGMs58ypZF9uL22M1S1hbLbrO42
         v2W8u2eKsrZhP3Qu81QDqHWFpqsIxIMaHokGC35DDQbhnHQ52jLcIjkVNlLOvcc82nP+
         SlPg==
X-Forwarded-Encrypted: i=1; AJvYcCWstopudhmRqDN9mXrNnwI7WVA7Dz2uEop4AjXscZ6tLxe0zGFt3wy1dRo9RnGG10aLtcV2wik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTzO/Qm/lioCsmv2eN5Sw27oZD+kMDmjMVZy5fshlC40yNuWT
	gXUbp15DqkfEvOSmVQNdQ7l13rfVRN2N7HAfRA5lgfFgQ03u6591YU4QRr+4VSHzDQA=
X-Gm-Gg: ASbGncuKNWLLbDWpTrK3yRx4+S4l5Hi380SfJSnu7YucL4NWa/t6MuIpy2Jgc5vmd5w
	zaRD86TKD4Rt/hgw0bZxxuGDdo7BnNwvSVYQpX3sqwQGGzfr/kinBLn5HzcQ2yP2Uh9q67os57R
	TJjbVWl6DhZ9nWxiLtAbXLdEsOiOUSenXoGC/J0BHULDT9PUn+oxykJIuVvBaFLQ8MuRj57lK1v
	7iMRxmYaHDMPaj0WPxHxy8jFTlXaw29OzjxDKhdUJ+I1jZRRKquvgjFGYt7Hh5NpSVBxePg7M6s
	epPvNOpmo2q9Ia5p4UE0sGdb21MSnW7rD3Ki8cmQOC1UTXXWV4LNJ1S5nX66zj/s7r4KNlFUfxj
	P8Ax/n+s01udZ1MKoP1OPErx3V1Wwem7Rc2c2rfIm6ivU5yXFLvjhbGYbiY7RvEmU0WmgmUzuYz
	8hsx5Yj5z8YgMUya6UQVIO8s02LPzfvL15YaDeoUazHAcu6fvWjebl
X-Google-Smtp-Source: AGHT+IEMAEFOhmF/iejZZHhzu3oDjZhXz5PgqOizEIFkk0hnK98vc072al/Skn/kZpde0jEgXdkWgw==
X-Received: by 2002:a05:600c:4eca:b0:471:1387:377e with SMTP id 5b1f17b1804b1-477308ef9f2mr90453245e9.6.1762264738365;
        Tue, 04 Nov 2025 05:58:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558b2e59sm19868145e9.1.2025.11.04.05.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:58:57 -0800 (PST)
Message-ID: <00c18ba0-be86-41f6-89a6-62fa3051bf69@6wind.com>
Date: Tue, 4 Nov 2025 14:58:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, toke@redhat.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>, Cong Wang <cong.wang@bytedance.com>,
 linux-kernel@vger.kernel.org
References: <20251103154006.1189707-1-amorenoz@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20251103154006.1189707-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/11/2025 à 16:40, Adrian Moreno a écrit :
> Gathering interface statistics can be a relatively expensive operation
> on certain systems as it requires iterating over all the cpus.
> 
> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> statistics from interface dumps and it was then extended [2] to
> also exclude IFLA_VF_INFO.
> 
> The semantics of the flag does not seem to be limited to AF_INET
> or VF statistics and having a way to query the interface status
> (e.g: carrier, address) without retrieving its statistics seems
> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> to also affect IFLA_STATS.
> 
> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

