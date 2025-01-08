Return-Path: <netdev+bounces-156323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD0A060FF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D183A181B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3DD13D52E;
	Wed,  8 Jan 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="o/0QM3Ry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEF14A82
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352111; cv=none; b=bXgQlT4+HgMNXaWCqepjde6utNRKThol49EXoAGWzfLcFDnruozJ5e7Mkx8CWlmBXM6KXSN+8jZ5SqQs1tElutDC6igm5PIvSsiU8UCAY0pKPnH385xxVfVRCVZa6TOYVCGXYm43q3yaC/+mQ1covDiV0eDsiT0svubiN6Hves0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352111; c=relaxed/simple;
	bh=nX5+2pjU8kjS203W3+1w5SoF31vjfLmooe5zbDIUsvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cT2ZcVsvYTG42ZcelVCluSvmfKlgLQnpehoz5mfgJEE0qgAUTZeiwYGPdyu0N+9rlomQBDX32WTDrTBZERDwRANx4PhqvPQ4eMy0isDgidol7dEd0xfb9yQ+klumlNdnZ3ffLNOxasB+7UMvv9e8AVSUVOUNPFVyH4XZiPqLxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=o/0QM3Ry; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso48415e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1736352108; x=1736956908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aeIBYpWzl050ps1iRK54L6880RATOL8lfV9i+to2Ks=;
        b=o/0QM3RyQFa2gfjtow8WpLncqEEwbMGK+5fljsrKoDH/fV0kke4UunLPh+4wCY8PRZ
         VAyZz7lX7AHFUnM1TF07sPOIvLNZtPXqqDJvQeDAHVziiCTB8UioA5yMzLPfUTjXy7nh
         A3pqcEXzlCyN4W3AJQFWvRKs5i9Ca16K3dRpC2AC6RUlv/MrIvXCkIUXp74iBJuREmFX
         UH5BkLalxTZtnzpUgEXrq4Z+3wHsixvoAaRvGcTB/2GsOy4PmycItibhqM0L9/I796rX
         NxoTXGJP7YtxVhYBMNNRcOtXDqUj7Dz0jlufR/BzI9A008m7r3pLxZIBHAeIvgAMyK0/
         d3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736352108; x=1736956908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aeIBYpWzl050ps1iRK54L6880RATOL8lfV9i+to2Ks=;
        b=EuWi7m0F1BFdNo+6LhMIpOcjo8PBtB5E2fqwJB19F8ZF7g3wbAUbipFivxKYjrEhLC
         7gNuvJWpLsf1oxLtSEYZQ6WAMvaCXLtl97JZszt6ZGxMGdDPHZpNkfMQWos+RWnsd1m/
         dRqa0Vc6l/o2p1quwltYABh6Q+2naZUIKoWUIH77+JiSI/b7OQpSM0AAMTVU8Y2SxtY9
         G2BQrs+I9v+gTYkvjcnM9zxihQ7caOLP5LyeZec2asMrKGwXsNTAFBZVBNFxqHkkXIOd
         rUcvr0KrI+EzHo/Vn51ZhTXlJSB5teNEaYFmrKJnTRfxr/KHIh/I25KATaT0bVNmk44y
         nH3w==
X-Gm-Message-State: AOJu0YxhfyTJod7HmvyqIywl8ue27CAGxPUaEKJuqDwjVH5PbPUgIPoA
	hKyPR+Oe6RobsXF2F3Vo2e9LY+rmAVRNU6/CKPahc50Aym4Q/gJOmwiFPv7VUDE=
X-Gm-Gg: ASbGncsuOzPU0hbtzAE1J7AGPcZ6XyPwxLki9eQjr3gWBMywfCUq4HWXXBeH/U0BFf4
	GJyJX0K+YidcqYfgycH66ukKreC49JdPeqrNwnr0zvLD9W05SyAvIAQnwJglRBPqRG5u1fmq5VT
	pgo7QVAl3k17/DYq/X+HhX9W1rWqOla9mIbsb8g9inihVRBVNH0A1PLk4gyQCj5Ps6YhB0iMSfE
	uxkFV7ME56ft6Us2TKKpNfMLP8XfyWq49ZISxkp/CSfNXQwD02y57EmDGG1G1lEslEA22krcr4b
	XynYy9O0v1aA
X-Google-Smtp-Source: AGHT+IG/ATRBe//aM2KCQjPotH7HATI6O+dvwO8IBdrzbeXpzvjvqu3bpYRUZ1tgPTBTB8lvKJuzkA==
X-Received: by 2002:a05:600c:45c3:b0:434:a90b:94fe with SMTP id 5b1f17b1804b1-436e26c3c3fmr33156665e9.10.1736352107875;
        Wed, 08 Jan 2025 08:01:47 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dea5e6sm25460295e9.25.2025.01.08.08.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:01:47 -0800 (PST)
Message-ID: <3cf95524-9c89-4a83-9a5d-7244bfb8bcaa@blackwall.org>
Date: Wed, 8 Jan 2025 18:01:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/8] MAINTAINERS: remove Andy Gospodarek from
 bonding
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jv@jvosburgh.net, andy@greyhouse.net
References: <20250108155242.2575530-1-kuba@kernel.org>
 <20250108155242.2575530-4-kuba@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250108155242.2575530-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 17:52, Jakub Kicinski wrote:
> Andy does not participate much in bonding reviews, unfortunately.
> Move him to CREDITS.
> 
> gitdm missingmaint says:
> 
> Subsystem BONDING DRIVER
>   Changes 149 / 336 (44%)
>   Last activity: 2024-09-05
>   Jay Vosburgh <jv@jvosburgh.net>:
>     Tags 68db604e16d5 2024-09-05 00:00:00 8
>   Andy Gospodarek <andy@greyhouse.net>:
>   Top reviewers:
>     [65]: jay.vosburgh@canonical.com
>     [23]: liuhangbin@gmail.com
>     [16]: razor@blackwall.org
>   INACTIVE MAINTAINER Andy Gospodarek <andy@greyhouse.net>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - move to credits
> 
> CC: jv@jvosburgh.net
> CC: andy@greyhouse.net
> CC: razor@blackwall.org
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

