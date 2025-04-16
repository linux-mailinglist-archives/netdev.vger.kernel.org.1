Return-Path: <netdev+bounces-183194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C868A8B53C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA491904A8C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA28227E88;
	Wed, 16 Apr 2025 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlSxPNTp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D321D3F4
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795419; cv=none; b=azg15L7/9xF7TshYP8s2kF2sqavq0QY0jAUGz9C4RerR+yVrMEQHkggLQcljdWAH2N2qG+JKketOiO6wzut0JB7zvNSTRI/im5nvggKXLXcClFSnoTs5t3EBFBo8oG2T2VXSMPd3zPDTLbDzRRbUW373bWShvKKafOZc6w9m2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795419; c=relaxed/simple;
	bh=aQARw0r5jwsZxnY/PcJzIvLUU2cVyj4CIAvdit1QmGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8z6BKAogFrWrTb/etqOTxTASOUsWps3P+dfo8k2mwbNzgQ8qZUstFtur+zToNR5fnxk8jU4UbRr9ZQDfSNABpUKgYEmp6cweXSXyjaxeecp3UZDlsRMoUCmx/Hhoe2RWtvddYo64Rb0AfrlLW+UfzGRHzCq64atSVKSwrtKZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlSxPNTp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744795416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAqvI/C2fuFiXzVmzEC2R1KgB3LYPmYKQDzm57373Xc=;
	b=XlSxPNTpsbPFoy8IQLkT/dYlw0cnmTzgzNSRYeykIRBfA59ebFDvRXYkTR/nw9A+U6kPZO
	lPO5ieZJdBkPjuyxaRZsKhKezej3JbpFXn5ERZLxLzfDJXJJUnt0JW6yuYUR28rjQmHrKY
	zq25zYX+QQtS3Q82HJQl8SHS1kWoLJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-L29dVo8COta4PYBF4ZCPpQ-1; Wed, 16 Apr 2025 05:23:35 -0400
X-MC-Unique: L29dVo8COta4PYBF4ZCPpQ-1
X-Mimecast-MFC-AGG-ID: L29dVo8COta4PYBF4ZCPpQ_1744795414
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so51845545e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744795414; x=1745400214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAqvI/C2fuFiXzVmzEC2R1KgB3LYPmYKQDzm57373Xc=;
        b=dzJzpqUU85KK7XtTkKPbdYyg+hG9M1A/a8hu9roKbKfEkfbCF54xCiP7H9RXa/agGY
         2vFEdOYf41LBk0Aqgdq7RUpaXWaMQ9zhljw4tgwUa+HmAxzokrd4SeEVvv3fKmAK5Ls+
         FRU1Baupqq9TFrckD08VtwZWKycGFW8H03rFgYh8WKJk3O8uLo8Rav9KtVYMtt15nFyN
         c96Wq8yOCJwjPjzEeLv90hBoBis6ZDerbbjgrtH6FfuP10qe6mUVDOAYMLnk7C8xntnG
         qR3/gBmjmUkdzwBpd5Vm3uY81P3GddzsDpz+7NtsL3H22qyTJ9W+/IVTCCuHuqcfEVeJ
         2yLw==
X-Forwarded-Encrypted: i=1; AJvYcCVmfKQvP196UjlpGKgQ42CnVKg6zDGPktszg1VeR7p8jgqZSljoBtvMeMpdsh9yIZn+Ti8czQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+FZ4WbJharWcn+2XK/T+bTmGxkNkwKXhXgYdUPgRKCdTYh//
	U+KlvZ803NzAhEXsCsecwenVLDtuxarhtpOdmvpa64daGLVfgZQJYheKNDtYAuq2uXk5P56VZ5q
	rJ+pi7mjB9QSsLJHR6o/Okd6C5YvS/SiJiDg73a4tid699cHEd+kxyQ==
X-Gm-Gg: ASbGnctFYC752x9eAWcN6ixLDQgTfFy3ZLZuxpIBb25rsM0+cI7siZGj8rc5UmEULn+
	HYN7iTUC/UVCVgfBVXnHSg/T6qj4ptfjelDVtCaydYlK6HNDrgc5QIdAk891uiFOo0JY4LW9WVu
	mWSgprSfp/Yngx9LzzM/RwJ2f4YWs8gmLZJ5H1htmr+wDVTU1x4xuuAoZHZ2PNIwtXshU19pbO8
	i5Z1zwD7dlJeWIyV74fdMyYaH41l9qHI+6SZPZBRJJpned7XZsHeCXxKSHo7R0xkpFaFndic5ln
	Bqni7FxTX9mEbm3wtIBiImgk9Ix09H3wwF1v3Q0=
X-Received: by 2002:a05:600c:c07:b0:43d:fa59:be39 with SMTP id 5b1f17b1804b1-4405d6bfd5bmr9354565e9.33.1744795414127;
        Wed, 16 Apr 2025 02:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3HKPRsmzIW7RTPhj1CUzbI3RkTRupJ0Crfwa5nDETw8xZ2UxgXhmInSnalWsyilLxEMw7vw==
X-Received: by 2002:a05:600c:c07:b0:43d:fa59:be39 with SMTP id 5b1f17b1804b1-4405d6bfd5bmr9354315e9.33.1744795413687;
        Wed, 16 Apr 2025 02:23:33 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c123sm17127510f8f.36.2025.04.16.02.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:23:33 -0700 (PDT)
Message-ID: <917877cc-414f-48c5-a9b3-0cda1fca09da@redhat.com>
Date: Wed, 16 Apr 2025 11:23:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 07/14] ipv6: Preallocate
 rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-8-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-8-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> ip6_route_info_create_nh() will be called under RCU.
> 
> Then, fib6_nh_init() is also under RCU, but per-cpu memory allocation
> is very likely to fail with GFP_ATOMIC while bluk-adding IPv6 routes

oops, I forgot a very minor nit:               ^^^^ bulk

/P


