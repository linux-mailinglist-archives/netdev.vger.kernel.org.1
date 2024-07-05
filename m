Return-Path: <netdev+bounces-109491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF289289C0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC89828667E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C5414AD24;
	Fri,  5 Jul 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="QOWM/B1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085E1487C0
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186455; cv=none; b=ZjIw/UIUK9n69cvsUthYmbyNXDF/73L3XaGJ85V4bZFNpGyPAeTqikhDFVYvdDtc1EAxi9ZjR6wmbKfVCbv9d7L34BKuUZshggsz9cD3mTDcRlE7mexpcZGtdn3FDSaeHKDViYmikmrh2SfsRai2vOYVkLbQbXCNbCuT8e0H50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186455; c=relaxed/simple;
	bh=0E6eFn6pi1G+OMyDwr+91Kg1LtA5/QXD8Psa8Yz3RHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0KyOWFSk1EnSqeh1Q/4PUSHU4ssc26Qj5Wqsk1uG+7mKERsGFKab4GChfiTjnlkBb5Xmhnk8H/ywFfUMfV735xdtxdSMI6x0xoXGQh2sDS/8AociyAz10KC6RSpzQeITdrKoRlHJRHlnsSsR2IeEsWyWFhC9hzG6FJxkTN88E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=QOWM/B1W; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso16255171fa.3
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720186452; x=1720791252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4A60BGrflv30WABncs69EPulmNjteZhoN5pOKXNgMXI=;
        b=QOWM/B1W2+8ZTYMCasu03V8AnrdP6RqgN/wOPjw4CeRz6vdNR39ONGqEw6bcrZcx45
         g/SmvP0MmfOkjeBVSNFR0Lfl4Rx4K09OGOjUMjKN2VvprP4tJLSzWjOs0fx8gW8I2u8T
         1aE1UjRbGq9/nm1xRBs1N9TRlrcXbG43YCpThPHk6IQDkHQ2+94bfbILCBDkIaNTtbMi
         pOcP+6nisWLfdqm6NQF9KmPrhFFirsNPJzTcMavRJj95oAniaspjSqmzWr31shdne2il
         GUxBdgKkJbywuodakNGyfbcMIxz8gGgT8vLGMzflIOLXWJAfyIynYSYEvff35vtWc7Fp
         rhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720186452; x=1720791252;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4A60BGrflv30WABncs69EPulmNjteZhoN5pOKXNgMXI=;
        b=Zm/Zmb9T7lw40B7Aunu9rhxMeW5huTbBIcoVMa9piE1H94jZs+CeFJ6G0OdSSMoYEH
         2K0cjNAd/c4JKULYmshIDtKfR4thwoQy/7tCGmpRGbYh5IX1hnE4vG7gPdMnddKjDnsq
         X+/U5UxPRWG4ugMi+6klq4uTr6Yb+0kTAVVtO0k2psbtJ13kJiQ6MxYspt1j6PNIhrUV
         AxCvJU5r5hkWPUxXDSiKtQGGe/6mTP+6hf++i09l4MEoiw1xJCW8SAqV9JZBSXg49fCO
         e1q0ELf/Om16eobQJeAhV1Ol+ALCNLXtDD83RDW+0rabZWK/iTmKLNlFr2RvXH4EvtOc
         zYWw==
X-Forwarded-Encrypted: i=1; AJvYcCVdrKsjrsDTt4Sa+qJ9VN28K1OUTMVz3zc4u1fcvH043cHNfB9Yqd6zkNTmunADxUHUdYufcgeE5ysaRSj77B/yLZlFgqFH
X-Gm-Message-State: AOJu0YwN7zCmucxJw9GLJQoYNJkqzeVIrJvK2Qx+PAQO50B1c0xe/W+k
	9+QSGP1V/qS72ZCY3x/MpZL1rSePlfHkJGyqHraHkuIIh2+/dOim1Bw5bzPy+e7PVJCm7gbqpcg
	U
X-Google-Smtp-Source: AGHT+IEp2DjdO6Pq0t7v30FXeKl3DPTDEEp8ItzAO2H50rJUL4Pz54NXaLbDlOnGOQgLAphUop79xQ==
X-Received: by 2002:a2e:3514:0:b0:2ee:8777:f87a with SMTP id 38308e7fff4ca-2ee8eda81f3mr29749541fa.29.1720186452154;
        Fri, 05 Jul 2024 06:34:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:a64f:8c21:bf82:ab40? ([2a01:e0a:b41:c160:a64f:8c21:bf82:ab40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1dda61sm63271995e9.19.2024.07.05.06.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 06:34:11 -0700 (PDT)
Message-ID: <83f8423b-3ac6-4e62-a1ab-11fddb385753@6wind.com>
Date: Fri, 5 Jul 2024 15:34:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 4/4] selftests: vrf_route_leaking: add local ping test
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
 <20240624130859.953608-5-nicolas.dichtel@6wind.com>
 <20240627105734.GF3104@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240627105734.GF3104@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 27/06/2024 à 12:57, Simon Horman a écrit :
> On Mon, Jun 24, 2024 at 03:07:56PM +0200, Nicolas Dichtel wrote:
>> The goal is to check that the source address selected by the kernel is
>> routable when a leaking route is used.
>>
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>  .../selftests/net/vrf_route_leaking.sh        | 38 ++++++++++++++++++-
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
>> index 2da32f4c479b..6c59e0bbbde3 100755
>> --- a/tools/testing/selftests/net/vrf_route_leaking.sh
>> +++ b/tools/testing/selftests/net/vrf_route_leaking.sh
>> @@ -533,6 +533,38 @@ ipv6_ping_frag_asym()
>>  	ipv6_ping_frag asym
>>  }
>>  
>> +ipv4_ping_local()
>> +{
>> +	local ttype="$1"
>> +
>> +	[ "x$ttype" = "x" ] && ttype="$DEFAULT_TTYPE"
> 
> Hi Nicolas,
> 
> I see this pattern already elsewhere in this file, but shellecheck flags that:
> 
> 1. No arguments are passed to ipv4_ping_local
Yes, I don't add an asymmetric version of this test, I don't think that's
relevant. I wanted to keep it to be consistent with other tests.

> 2. The condition can be more simply expressed as [ "$ttype" = "" ]
>    (my 2c worth would be [ -z "$ttype" ])
Yeah, I asked myself also, but like for the previous point, I wanted to be
consistent with other tests.

I will remove this test.


Thank you,
Nicolas

