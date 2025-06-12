Return-Path: <netdev+bounces-196893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F63AD6DB1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985961BC58AD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD3238C1D;
	Thu, 12 Jun 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="p7V5SeNY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2A22DF84
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724004; cv=none; b=uXQuf5HRTqPr9ho1LI8MDI+Wyl0cbRPJmGbIdpuAFKBWxGzQqrVUKrb0VGZ6bQHa8KsbV7E8S+F/l4u2GcATLz+D0hheRfVgVJrb8ZMI+dCqZ7E4zZt+85ZueIj40/aXmwdYkhFJ0rG6LfFj4ywb8uPc7nuiHbdLHdLf7NUZGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724004; c=relaxed/simple;
	bh=YyL/4hTpoTkSlenM97Vf9/4GwWZLKQyMjaPVATyQ104=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a607KgqV/aurVKe6A0UBQqDy5b4/LWzybsPHgKqF5UzI43aZXBpTPHSz8pAX2WMT2ldWAq8qm6tyPlXv5vT8HtXzCBJwUO1D1s+py5zCEUvrHhSz4lA2aga8dcEV3/AfFuEhUMkyUPDBm1pl2OqMhHtXwQvFnQ+u2clDKmbfLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=p7V5SeNY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso763052e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724000; x=1750328800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdJDAjJnOGg9m+f2BO12DY9iSOByKl7mj3nYhv8dMh8=;
        b=p7V5SeNYl6Cxxz0HwHl5fKqP3BtsxlVGmUDP8bXXiKDVGgSENdxjIfQ2DcEGYxw6fH
         xP8lkVUn4L/nF9dvlNaK3x6MaaWzkwwXDoSXWYJeuWosqcRrvvewye6sld5VuUje41gY
         KPKRRc04OvJChtvOHQkGUrwF+zin0fh8Jooh/mVmlzqht7mNk2NZZvPWXqQJNWv5rbDc
         vVEax6KBFwWnrtniXnWR/3tMS54r2cgF3K6adFfUGxTTQ0wjzycCqpKYg0Kg/flJVstd
         FOn46q2htbb9zcuQs0+c0uaWDDES/I3CRYaHo7k39bmmiy5tnODqjsMo5IFWpBBQZ66z
         cMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724000; x=1750328800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdJDAjJnOGg9m+f2BO12DY9iSOByKl7mj3nYhv8dMh8=;
        b=Ksu+K7sZ0zC8MGGRl02Olosg5XWmoFCWVN0YYAFzdhzYAjCQG7IBpJfSIuRz4ry/0p
         OqbN/IGcYGoin5hUfRq1vs4KklIH2VT89pgBcs+72yoB/K66Jm4vBODgcCeRaqOSjZbv
         Bm+0Q8oFfsIpuHx/tj94qppJLSzL+ZV+a9v9obajLCdicNB1MYwSz/2c2CcNfHAKoiKj
         maS1A4MRbFNnD3u52qDAxqP57KbmTAGCTvY3o8pYazvG6vE7wyUkZ6A00cGwuKzvPyz7
         cQYtpufwd8h111ZGneU1sIbQ/3WLdOqQRxs6Flnd+7aWFz2/ZtJt+EbCB/pzZxU7TBCE
         WIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF6SNTgwFncvsaR4OTyDfj5TH2DmZ+Lp0Loo6cnWSKNjQCc8P2A8RTNc+DcMfCD0VMfNI3GYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHWLcDLJJmgyhRSozB44G9+VcOhv+NLBeRqjkLeKKDMhgjeOq
	BZAa0KLIavMys/ogFJoKkQzeRzFzi/cks4Y6Ybkp80oNU+Tq+VsOM9N2hyY9WpMMPaA=
X-Gm-Gg: ASbGncu3rQFwRu1+DXDVyUT08iiEGPtKvmz+EdFyCaSZ3fjYn9UHsL3XpGrKDSFwB+w
	MzheN32qc3HM3AWacOeQpNXwH75gUt42kTZDAK5tsVaxhUxl0twRNN0HZAE6loVpJ2lIDAJkl3r
	GV2D9qHVwBu9nA28729vCLLwxtlLBBIzrSmitXlm15XvO0Ju3KIMHIxNGRGQWnFG4zckzVLO5hA
	SHQ+fU3alFsAuleEbsdv3655Kw4Q1W9eJddyD1vAJLpOkpVoBUQikyFkzQ7OcNesQ9ghAdylblr
	IQeiua1g7gWaRXdoMuvP5pxVDtWCliQaZIOrdIsU5ULAu0nxdeGVDtXzvMyeC+7cGKDdR7jaTgI
	pS1iWCyQyf7jNswTZ2eyjjimhJMOM614=
X-Google-Smtp-Source: AGHT+IHHqJ44Ct1FoYfnZLyIQMx7/aVtR1UCzN0V7itmwjRYgTqX7/tWU5uzWOsByUY8NL7s39OB9w==
X-Received: by 2002:a05:6512:12ca:b0:549:8a44:493e with SMTP id 2adb3069b0e04-5539c0a32a6mr2136961e87.5.1749723999835;
        Thu, 12 Jun 2025 03:26:39 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac116968sm66714e87.32.2025.06.12.03.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:26:39 -0700 (PDT)
Message-ID: <985001ce-7610-4653-b13b-8d3976309e44@blackwall.org>
Date: Thu, 12 Jun 2025 13:26:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: net: Add a selftest for
 externally validated neighbor entries
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, donald.hunter@gmail.com,
 petrm@nvidia.com, daniel@iogearbox.net
References: <20250611141551.462569-1-idosch@nvidia.com>
 <20250611141551.462569-3-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250611141551.462569-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 17:15, Ido Schimmel wrote:
> Add test cases for externally validated neighbor entries, testing both
> IPv4 and IPv6. Name the file "test_neigh.sh" so that it could be
> possibly extended in the future with more neighbor test cases.
> 
> Example output:
> 
>   # ./test_neigh.sh
>   TEST: IPv4 "extern_valid" flag: Add entry                           [ OK ]
>   TEST: IPv4 "extern_valid" flag: Add with an invalid state           [ OK ]
>   TEST: IPv4 "extern_valid" flag: Add with "use" flag                 [ OK ]
>   TEST: IPv4 "extern_valid" flag: Replace entry                       [ OK ]
>   TEST: IPv4 "extern_valid" flag: Replace entry with "managed" flag   [ OK ]
>   TEST: IPv4 "extern_valid" flag: Replace with an invalid state       [ OK ]
>   TEST: IPv4 "extern_valid" flag: Transition to "reachable" state     [ OK ]
>   TEST: IPv4 "extern_valid" flag: Transition back to "stale" state    [ OK ]
>   TEST: IPv4 "extern_valid" flag: Forced garbage collection           [ OK ]
>   TEST: IPv4 "extern_valid" flag: Periodic garbage collection         [ OK ]
>   TEST: IPv6 "extern_valid" flag: Add entry                           [ OK ]
>   TEST: IPv6 "extern_valid" flag: Add with an invalid state           [ OK ]
>   TEST: IPv6 "extern_valid" flag: Add with "use" flag                 [ OK ]
>   TEST: IPv6 "extern_valid" flag: Replace entry                       [ OK ]
>   TEST: IPv6 "extern_valid" flag: Replace entry with "managed" flag   [ OK ]
>   TEST: IPv6 "extern_valid" flag: Replace with an invalid state       [ OK ]
>   TEST: IPv6 "extern_valid" flag: Transition to "reachable" state     [ OK ]
>   TEST: IPv6 "extern_valid" flag: Transition back to "stale" state    [ OK ]
>   TEST: IPv6 "extern_valid" flag: Forced garbage collection           [ OK ]
>   TEST: IPv6 "extern_valid" flag: Periodic garbage collection         [ OK ]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   tools/testing/selftests/net/Makefile      |   1 +
>   tools/testing/selftests/net/test_neigh.sh | 337 ++++++++++++++++++++++
>   2 files changed, 338 insertions(+)
>   create mode 100755 tools/testing/selftests/net/test_neigh.sh
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


