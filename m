Return-Path: <netdev+bounces-212806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47286B22132
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F9D1B63F25
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A9B2E2665;
	Tue, 12 Aug 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="LH9YKIbm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8332E2647
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987306; cv=none; b=YR4HMb8Svc3WNC480adS/dkG+en3rXvELO63EkTOWsPHrRgSAMzXMv1BeAMzfI3jZMWTc0jbSDb+nOGSdDjQyt9ozd6/JdruIrQPXy65/4uG41sJYc0Kc8usSVgiGeCveR/x7um0iVh9YZ6osP1B0E7DobnVkstj+YEobzHNnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987306; c=relaxed/simple;
	bh=fgqjykETSbd8OLkEoI2OcORjWOwo4cvMEHo1V4muxXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CK6cpb7G3cVpDAgyUKfj5c5IoNCUmq4b0cJ3F1aeLHRwZNScrYPqjYp17qCfaZ/WhrgQgmxjPvW05grtmrHCEnrdHzDvJnRbYw3kAbBNpVCmT68Mil7yPoGkV+w8m24p21jRfVk/htnacEs4p35PcNtf6JGE0uKXW3Ccj4uGG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=LH9YKIbm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61813e2fc73so4393222a12.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754987303; x=1755592103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5parWk4KRrzk3kF82+RurV5ODsapxZgFSbh/OkX2u5E=;
        b=LH9YKIbmkzMgOmy8hes/GqUyUWRiiquetqSgM2q2AZeIvvPCgf45+PuNZk94FCcdfb
         YKHuCfy8bBvsLPgvJInxpKiUscraxHSW1amXL/DIxOnHGZcFmufowpMryJAx1pR+P6+Z
         8qIR6ju4/P13CH8M6LHe9QPZlIENxKEluDRrFf8PK1rINgAP2+6sHLCXfSlqisZ1DxGN
         6GMY2I69aoN8hN8kiRoVerYy/fAf1mRUWme+ByDC17RINs3IjDQKRNhOogdRz2qqfMkg
         t37XaNCsP/J+50t4U5iVpvGbuxwPa9+6e2ueLCEFvmQlQecRE3XUgfxzrxtRnwuyxnMh
         9ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987303; x=1755592103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5parWk4KRrzk3kF82+RurV5ODsapxZgFSbh/OkX2u5E=;
        b=WrKr9bBvrO53QfzT/VjL8V+ij2V+lzVYGho8r3jjYNq/C6qcU2+verMi75tVsj6tkm
         DTXg9LZ9hsn+TxdDSi2WB2vb8ymty7GDV9cvGWoU1+WDmqWZZpLAibyaNr7jbKqRsy8V
         WIvDKQPkMOs+k0NuG4pvoa0rsZkP8KDTVVpEEEkwgjWwiU5u6KaQsGbFAFtKuJd6hg9z
         a/GKSnbgL4VdZomsVw+G/z/n28zYUvd9HjejNXo9c0CDKLIZuz0vZODO7328xdCgs3OQ
         NFhhHG8jSRcusTcwmPgZHWPnHsCQdxKRRhyciUhpSFU+HqYFCJ028rsYzWTovAMDzyAv
         XN+g==
X-Forwarded-Encrypted: i=1; AJvYcCXBYOMyMgGF26y9bGWPGF/TdlqFzX3XOB2Wl7+LjTNojlCnVctNmrRGlaJ9DcCKBEIxaQ0L12g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCjJGd1vwbX+Io4Yjw+VkoJfocbawuWzyG0UhFQjxzK/UZS/w
	s66D/7m95/q8pKCQ2w5NmdxCfAPke17FPyD8ytl99jWMnpsNv0B4Dg2SZu9ZTsTsG8E=
X-Gm-Gg: ASbGncugk84g6o4qhNZJ0D80pg2+Kmb965ifsQRGypUED3pjHxzUumJ6FHqaZvuFZxg
	Gv1YtTNV+16WW8q4msw0QMVoaqYAABWz9tV6vf4NLGB4Z8IWSANi/lwh1HcnM/Y51XFprufwMHL
	U+C/XvXy/equwnFYr3Fq8OMCUqYw85OvFUZliBr+NG3jzwPPRk1jeGqMRuhf0LLZua8VfX6yUrC
	/iRqvsWWEIoDrUX+bnsrLybz19E+BVgoIplK5ERVcWyTz9LFsS+pIZKmJxASB8OVqEfJmTA13Yv
	m98HcbnkIuMQrzbrLJ1zUlAjGDplbfm4znjDrYYK0p1rNAWLJ5qtYKUPASUIxZpqW8umMzlmsIk
	UopTilfupTwSMuu4kFBR3PsQPy7Hv
X-Google-Smtp-Source: AGHT+IG7gR7TKPP6Kg4VwIrN1R7Fl37VkQK/DmyRFG8R801slqU/0xuHrsdUtyWS1bLhZeJceZ748Q==
X-Received: by 2002:a17:907:7ba4:b0:ae3:5368:be85 with SMTP id a640c23a62f3a-afa1e128eafmr208409866b.47.1754987303139;
        Tue, 12 Aug 2025 01:28:23 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.72.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8332sm2168716066b.75.2025.08.12.01.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:28:22 -0700 (PDT)
Message-ID: <dcc3c884-8b1d-4c80-8b56-a277c7d1d95d@blackwall.org>
Date: Tue, 12 Aug 2025 11:28:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: net: Test bridge backup port when
 port is administratively down
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org
References: <20250812080213.325298-1-idosch@nvidia.com>
 <20250812080213.325298-3-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250812080213.325298-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:02, Ido Schimmel wrote:
> Test that packets are redirected to the backup port when the primary
> port is administratively down.
> 
> With the previous patch:
> 
>   # ./test_bridge_backup_port.sh
>   [...]
>   TEST: swp1 administratively down                                    [ OK ]
>   TEST: No forwarding out of swp1                                     [ OK ]
>   TEST: Forwarding out of vx0                                         [ OK ]
>   TEST: swp1 administratively up                                      [ OK ]
>   TEST: Forwarding out of swp1                                        [ OK ]
>   TEST: No forwarding out of vx0                                      [ OK ]
>   [...]
>   Tests passed:  89
>   Tests failed:   0
> 
> Without the previous patch:
> 
>   # ./test_bridge_backup_port.sh
>   [...]
>   TEST: swp1 administratively down                                    [ OK ]
>   TEST: No forwarding out of swp1                                     [ OK ]
>   TEST: Forwarding out of vx0                                         [FAIL]
>   TEST: swp1 administratively up                                      [ OK ]
>   TEST: Forwarding out of swp1                                        [ OK ]
>   [...]
>   Tests passed:  85
>   Tests failed:   4
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   .../selftests/net/test_bridge_backup_port.sh  | 31 ++++++++++++++++---
>   1 file changed, 27 insertions(+), 4 deletions(-)
> 

Nice!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

