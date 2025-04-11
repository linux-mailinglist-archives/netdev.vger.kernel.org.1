Return-Path: <netdev+bounces-181686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B87A86227
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45B99C2C0B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2F20E33F;
	Fri, 11 Apr 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Dql7r5rm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A401F584C
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386068; cv=none; b=Xtp0G06tkui2dXSXeStADKMzIlxJupTSWIEjqETDGaHHuk1iJ+NgjXRKkKq3/CeHVc4SmHsp4Fp0xa3rGbv5xz1yeFOki6++jOgyKkPFqfSU56vyXnodd9TkCTf8J7xR3R4ObNmjjU1tmDBLlOos9rGYFbEWZmaIJNAYsSTqeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386068; c=relaxed/simple;
	bh=6xqHOzSEtizESNQeKofm4qGWhQziFiLceka4SYrVITY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BP+a83/kseCjOlLR8ZRCcaS3dy3ogmj/E6BSLtFwDAPMFmi9XgpDQt20vVfUFH5rk7/pceCwkln/t0OuDyrmgpuG55/NwTPwUH4M2UNqLE/OoMqwqDIU6Twe9Q9yt/T9J2ieqZihFO40xjY1fHES8x/f09qoyUAspMuAywu2skQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Dql7r5rm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-391342fc0b5so1583966f8f.3
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744386065; x=1744990865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1ER5xB9Jg+xmJZBLV8A7QxFaT92qRl63hkizFpOJiI=;
        b=Dql7r5rmQzMOlU6VW6yqRnZysUz/nR/j+OfMlApbmo1Cmr4MUs/GB9K+FARMSM4590
         VZxxURd09WiXmPp39CBnYKE2cidBT2ib7hbLBnVGj3DbR0HK1V8reI96Oyw1eWB44fzh
         FvrS5mGEJUlee+nqv6TSiMCjXevbjQsGJr1QA+ixLCYSSoEr2wx7+ZGDMrqbHg6hLeXW
         SxsosR1lTQAHh24uswbK6XQkRalKX3EzP0p3xZlshEA4DdwdD2h8U2rDm9K7s+tJpQgR
         9sXG2LZcoUeB7aTjentuirYFgPNKCl8Pwofw97jlKgq4s0ntjyrauBu9SkGcHgwj8nLj
         iOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386065; x=1744990865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1ER5xB9Jg+xmJZBLV8A7QxFaT92qRl63hkizFpOJiI=;
        b=lPFoc7jKAk/Qt2hdxqgU++kSP1W2oLHvlZhogmgKy1UKMNx5nW2raufLywvS4JH5Hp
         VLJNpSZk06dq7L1RQN2RjUdJvDCqGqg7cETO1KitmYEQK7+xsBxmKndRVpZIUmG+lLOY
         3own+N9uBTGG/JMmwzag+mZ5CvGejspU5gYWAXEChLuiVkeZ88RoLUukchOr0fTD36OI
         TZjcAsuOsUvR+bP8kLpljaGfY+fFwJg+7QJnVDccugW+eQKMNMTXYCA23Xvt8wXYDLM3
         u0fM9ZPcMvUiBZFCpxNzkM7B+8nwGZVQzAOdz6cj1e4hL2LXot304zdBtkVh6LaWCC+1
         DvzA==
X-Forwarded-Encrypted: i=1; AJvYcCXkJJDYYqH29sQ4LVBlQfDQ+KICKAjweF4G7LyCyOvb7lRHSCtExqA6JB5XfPu1Wxr7t3OezBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjh45dktt+69gI7zORYd8nZetVS0lKfyY9/14aNNQnD/rxI6Y2
	9HM/2UlsrBXouowqdkgrjfTCeSqXt78UR8SNHlH2aymctGJexlRDEW3PcaHFi4c=
X-Gm-Gg: ASbGncsDNbrG6YE4Elu0UdgRG0c7hAOVTPN3J3gwBKk31hN/jLS3qBk10zLl5sLxEyh
	uOe5nBEZA2YgfPMtGm/zO8/vgbLIZADy0AXIU8Pu9R/QLQ2COoVolUaN+lUyRMbGO4P20icICzu
	9i5qKdGX0PcHwC/S0QfkElmbigT7KR4mZD8vsiB/118hEGoxZ9DkCQUmPQYJraJRA9OgEtyqO3I
	pRT6vW7BmOEHW35eBtjgGbcHkNmSUNzeKxzBZUFJGe8WvOjpf53qsBWNFd6r+hGlFhEzsrghInc
	ZpU3yZ1KHBmLTvCq2P8nB7Y2BjnCq4w4ZzAHK3PmNgoi1ac79A/HnIPPJAVNw5DFZMpv+7cSQ91
	RYKkC34A=
X-Google-Smtp-Source: AGHT+IEisQGsleHy4Zv5Gzb/47cBIzfdWyFjOgUR75w0kWOWSpMn5SkcGKo3Imt6toqDOuEhLNofAQ==
X-Received: by 2002:a5d:5f94:0:b0:39c:1f02:44ae with SMTP id ffacd0b85a97d-39ea54fd3d6mr3226660f8f.27.1744386064350;
        Fri, 11 Apr 2025 08:41:04 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235b050fsm90397935e9.40.2025.04.11.08.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 08:41:03 -0700 (PDT)
Message-ID: <7e7746f3-3113-4f80-b9e1-71d28048c2d3@blackwall.org>
Date: Fri, 11 Apr 2025 18:41:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 net-next 1/3] net: bridge: mcast: Add offload failed
 mdb flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
 <20250411150323.1117797-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250411150323.1117797-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 18:03, Joseph Huang wrote:
> Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
> that an attempt to offload the MDB entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  net/bridge/br_mdb.c            |  2 ++
>  net/bridge/br_private.h        | 20 +++++++++++++++-----
>  net/bridge/br_switchdev.c      |  9 +++++----
>  4 files changed, 27 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


