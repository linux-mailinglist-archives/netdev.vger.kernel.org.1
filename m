Return-Path: <netdev+bounces-162674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECBA2795C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965581883585
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B1217640;
	Tue,  4 Feb 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Apa9noyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC6216E35
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692489; cv=none; b=Q1lN/UDvXtxMJKRizZjEnYcb5QPhfe1Aym6XGJP+jNn2WL0k99LcoMsfLuln8CCioo0CJhVOPhx50Ff4kDxPUQh+EE0Efe9D/z/0VWuzZGUtB5qcz0OMQrdc8yzyOGJlc7U+uGP11ebHO8YRvxy041Ux13twc2c4/+CPCjZAlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692489; c=relaxed/simple;
	bh=1VGXBkRq/s1jR3x7uGpHUxPLi+TUi+JcOWI8Yiv2CT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSPu0cWcxpRcWLYTfdMqZG7tLkIb447jYVQ42fUdySyY095qYBRZSfYSkVUR0UqfCcJjnc8B/Vi/tXlKZ1TOCtw1BoybW7DkbT/DiJBIC9Y/K1UL25DSjFnRP8xhM4mlqkQm/YRi633yuPg74ykBQ6bD4eZdHXoUA+2EJlo4KUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Apa9noyZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a4f1so1608054a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 10:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738692486; x=1739297286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7QYkGmY4zibo/xAorONcV5cpLaQpnZZHAwx6lprekc=;
        b=Apa9noyZX91HGzgth2/RyAnJO5ydNtVJRSaUIj47u6LzSwgk3YkNXqc3dl1cftQ38z
         2G6hP4vkUsSRKb5Bx4F3IdSS/Hh930vPiThfFShd8IoHe56IOed1N1PQad3adlrN8KMc
         t5LJuhQ1jFv/LL/SrQ9RVknj8eyUsDzkl9nDGf7PoKVfiOLALkwNYbCABtmmCdvYRX6I
         IwINB0YKGqu/K9H5nFDAVztyZUZl6ASIgLQhr1RLZlsL5Fu9F6FdxxZQzh7FsKtX/HtG
         +V2Eru7r1ec1a6cNEtE18KuvsbKmnpaUwTaNHwCf2rR95DLNgrPVVXvBeKrm8Rs8g1tb
         WG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692486; x=1739297286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7QYkGmY4zibo/xAorONcV5cpLaQpnZZHAwx6lprekc=;
        b=JhXiI0OwPtvf/RePkR+3VDVcKpnt6lhyxYHgO8Rw6bu8JIdI3vN3reqDRYxCBTs+9f
         xon/76exDjzenMEOABEmYS4JN3InIKCoq7WNFRwMgCOilT0ys4SgWxNa5G5y2UOt9ZNu
         GdiYVrzlMjxh6BKNcaGmhNrortt4hxFDHMC2fMyX4P8MGYXzRTBNu2ln2teCtcjG19bW
         sygiHkfd2W0dgpWhfZnAPUg0AgO672IHbutFJHDRhpYPiza2uyxoAH5TWm0d73/aynnj
         SiQhntabKwykAqWOT49QvekZRD8iwEpjeO0as4YVeMSRWRwKHXEzN42s33b+ocBUvK03
         unrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzhSgv/NKAQXsrZklNEuDYs6LqbcEIcdUZTT3fa55uU1h8DUJS+g9k0+t3/Nh/RgqTHi++/qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQmuZlTWHpvGiD9T/XcHxnEPaipEsveRuRYXITwf5Nr+oDGNo
	MGhrUqpU+dYNXFuzaT7y/7CuQPx3ZPqhfnMbOquvV+JIn/vUUpm8seWQYIBYb+zmmiqqznoNU4Z
	m
X-Gm-Gg: ASbGncvRzHTnqgwI5QdPLV+83ifrIuXUP/OtaeJ5tPwQI9lQTmrDqIFmBaSMsU5GuHX
	/p4/MMifzbNzn+PTQ5JbEPSInxtINIKxhmQgOZ5v8Gxd1ZBd/58CtK7fS6TibstUewY/UEZt2V5
	7kHK2Rhsi4WxIw8LwhuPxkvIOhFRQnMaJwmjmngkWBlLUvXbUDCexm0hqg99KRmuuMUPANrfxfl
	btIlILmFoWuAaoeB3sA+Y2xnXrqLqQGVcTTbac8mgaECFqT3HT2osTF+6rIPiy9Z0d1gmoox+ns
	s56i6RcRsX33VgUS7gHBlxgh4raNbZXVzkZchfaUFF02HiY=
X-Google-Smtp-Source: AGHT+IFmsnIFrcNvRs6vHTZJHc5B0fjL09YjTCpSYEodCVf4XR/gUoTqvRyswP6nP/tmC8wWftUZVQ==
X-Received: by 2002:a17:907:86a7:b0:ab6:dace:e763 with SMTP id a640c23a62f3a-ab6dacf0140mr3151797066b.38.1738692485897;
        Tue, 04 Feb 2025 10:08:05 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7b1asm959410466b.31.2025.02.04.10.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:08:05 -0800 (PST)
Message-ID: <f50c11c3-8619-4491-8607-c58867d01deb@blackwall.org>
Date: Tue, 4 Feb 2025 20:08:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bridge: mdb: Allow replace of a host-joined
 group
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com
References: <e5c5188b9787ae806609e7ca3aa2a0a501b9b5c4.1738685648.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e5c5188b9787ae806609e7ca3aa2a0a501b9b5c4.1738685648.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 19:37, Petr Machata wrote:
> Attempts to replace an MDB group membership of the host itself are
> currently bounced:
> 
>  # ip link add name br up type bridge vlan_filtering 1
>  # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
>  # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
>  Error: bridge: Group is already joined by host.
> 
> A similar operation done on a member port would succeed. Ignore the check
> for replacement of host group memberships as well.
> 
> The bit of code that this enables is br_multicast_host_join(), which, for
> already-joined groups only refreshes the MC group expiration timer, which
> is desirable; and a userspace notification, also desirable.
> 
> Change a selftest that exercises this code path from expecting a rejection
> to expecting a pass. The rest of MDB selftests pass without modification.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c                                  | 2 +-
>  tools/testing/selftests/net/forwarding/bridge_mdb.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

