Return-Path: <netdev+bounces-165980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA4A33D5A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96A9188DE89
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4593C212B39;
	Thu, 13 Feb 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwWHbilg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6C1FFC55
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444640; cv=none; b=Gb4EE7G8LSprfbPuvDhHyYP9jd7/m02OPk9UuKv3Rbd9oJe8j0y6VPnBH5fqSHdaiHuTKmRiMfBuXd3cm3dbMFaWYrh2cHH+fieFUyplu8a6yJBjcuPl2oy7OOlBEYXhKWf8d7CujQHinhdxHFQjZmHtfBbtFUia1D3efCdhKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444640; c=relaxed/simple;
	bh=1hrPY/4YoEsHy94pYeKpFdUs796aCksepRMZHrKfHS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpSoN/YYrMgc8FS3d1+wgdHv+TWxoT2ilGDJGAoXe6mWpkZpbwybBI90dxM+t6LCnKy/JbjxCXBVZb1Iuk503cuVS91Lcpu+RMVEMsej+tINqi32j2hiXOitYU21SrnIZZ05bPsziC8Zv2Fxoqs5UzmiPHVDVuHOH/omYuMVB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwWHbilg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739444636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWAXxLoKyVI1hes0SHfIpG0ueCdsTq3SmbqjIdLSAiw=;
	b=KwWHbilgj7+BLnbuu/KDMHz0nqqNur95ZDRurSoeAPIkg98EutdJoKpIi07Tw3TIVk3nra
	sAaAc+JrC+vGGkCIBIGo7Xz+GGYTtre24TJdxoLIcfiWic4wD6zh+YGmDXgQEneF2Pfpej
	V5N+yGsozBu0mXl4ch6IVsMqZvzvR9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-M29h-_uwN4iJwjf6PHFE6A-1; Thu, 13 Feb 2025 06:03:55 -0500
X-MC-Unique: M29h-_uwN4iJwjf6PHFE6A-1
X-Mimecast-MFC-AGG-ID: M29h-_uwN4iJwjf6PHFE6A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dcb65c717so433785f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444634; x=1740049434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWAXxLoKyVI1hes0SHfIpG0ueCdsTq3SmbqjIdLSAiw=;
        b=BnjwZdIAhe5wL53EAf0BRnBR651PxmbX/zM/FHb2lbm4ly77qCVg9q2h3ZNkeScXki
         s7RNO6PoEQMmd4ldf+2dUuhMmiGvHSSwtOtSnhPMWvU9KMvraSZWLyLiG/9+ISiMPIt/
         6J6aNvHoVfa9naxl2rsjmdyqrYO9cEGQZFfmIKmtoV8Cj29xACqAW5dS1Sl1LkOIYmDH
         NftrcTMokzUfGfv+/G3/zDRARtrC+UzABhiphAtR0W+oO3S37qwsH3Bl5RAe7UvmW9gD
         FCcoCbaDqgRFQDaA7GmJP8t5u9AOD/W7plk6z2+VnduxrlHwJdr7WD2fBLqzu3+Wvfle
         +15A==
X-Forwarded-Encrypted: i=1; AJvYcCWavzNZqTi5cLo67xea//A69vnMHZ20nDdlwpJ+Z+xZWMYOOXuoSCq8mn5lWp1d6QzD07kchE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQEjCviDmmtKXtS3XJxiZfNn5D3+WCxJnAfe6uT7f3U+a+yPG
	TuAzpq8WoYBxsXS2XlKp2awlMZKaQ+dHvrxgx8G3A1EPp3pd89gayKp5KbQ0UWnMY53X9AT6UQK
	OgB4/lVT1ZURFz5YZfTMwvGdF50Z0vdRNPl/kua4ka83LpEw9KH6TsQ==
X-Gm-Gg: ASbGncujyig7CvkgXbTC+Kwb+btjfiiRus/DRqoE7HFhPAknNzMLN6kUn06/WezoB4C
	i34k/CVKkmKm5HNEDIexjeBSgDz2EdTATcfoU72zCqDbpphy7+dRpVFu0snH+DcjL4BDGPHkbwZ
	mbsdlNTFqjXTj54yHQeL0zm61suM9bdXPo9/Lw7Kkw5+ZmMyNeeCjhmt8M+NMaXlWeaRb++9uR0
	stz5INMyHK0Bl2xoWvD4fmgY0MZ2zxJ8MM3FpIWCZuuTGj8T8VC52R2b1o8QIcry/CqtOfsOyVR
	aYY6bLmPKr/UyiKcYOVX5ZjOdKbtjs7/ZB8=
X-Received: by 2002:a5d:6484:0:b0:38d:e48b:1766 with SMTP id ffacd0b85a97d-38f244d5466mr2878133f8f.6.1739444633752;
        Thu, 13 Feb 2025 03:03:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSruyvfaJRN7UbSvVX+UFz2mFuOAbeHW4PfR0qhiwI8zRuafkuh0NZHFcaoI+JEQxdSUgAuw==
X-Received: by 2002:a5d:6484:0:b0:38d:e48b:1766 with SMTP id ffacd0b85a97d-38f244d5466mr2878083f8f.6.1739444633326;
        Thu, 13 Feb 2025 03:03:53 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d94acsm1559365f8f.75.2025.02.13.03.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:03:52 -0800 (PST)
Message-ID: <410f016d-2ea6-45ae-895c-96fc34fdd1a3@redhat.com>
Date: Thu, 13 Feb 2025 12:03:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] checkpatch: Discourage a new use of
 rtnl_lock() variants.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250211070447.25001-1-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250211070447.25001-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 8:04 AM, Kuniyuki Iwashima wrote:
> rtnl_lock() is a "Big Kernel Lock" in the networking slow path
> and still serialises most of RTM_(NEW|DEL|SET)* rtnetlink requests.
> 
> Commit 76aed95319da ("rtnetlink: Add per-netns RTNL.") started a
> very large, in-progress, effort to make the RTNL lock scope per
> network namespace.
> 
> However, there are still some patches that newly use rtnl_lock(),
> which is now discouraged, and we need to revisit it later.
> 
> Let's warn about the case by checkpatch.
> 
> The target functions are as follows:
> 
>   * rtnl_lock()
>   * rtnl_trylock()
>   * rtnl_lock_interruptible()
>   * rtnl_lock_killable()
> 
> and the warning will be like:
> 
>   WARNING: A new use of rtnl_lock() variants is discouraged, try to use rtnl_net_lock(net) variants
>   #18: FILE: net/core/rtnetlink.c:79:
>   +	rtnl_lock();
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> It would be nice if this patch goes through net-next.git to catch
> new rtnl_lock() users by netdev CI.
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b28ad331742..09d5420436cc 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6995,6 +6995,12 @@ sub process {
>  #			}
>  #		}
>  
> +# A new use of rtnl_lock() is discouraged as it's being converted to rtnl_net_lock(net).
> +		if ($line =~ /^\+.*\brtnl_(try)?lock(_interruptible|_killable)?\(\)/) {

I think you need to add '\s*' just before  '\(' to avoid the test being
fooled by some bad formatting.
Also I'm unsure if the '^\+.*' header is strictly required - it should
but some/most existing tests don't use it, do you know why?

Thanks,

Paolo


