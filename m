Return-Path: <netdev+bounces-179417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC207A7C813
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 10:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED23F3BD17B
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 08:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1781CDA2D;
	Sat,  5 Apr 2025 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="fNpX/TKA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CF1B4F3D
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743840607; cv=none; b=L1GaylANI8IfgznyaLJ7m8Wbc1gB+Jd1Bzf/iwOTlQSDXCSsKwxPJ60zSw13NMAQYlhqXvn/EI0js3pRw8U60Y5EyEqOWmur7SIyfqwRI8be57u4jgFFNW6PBKGzmQjESR0hdyBSLP8/58idrGPILOiZYnlmf7m0Q1vuevjq4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743840607; c=relaxed/simple;
	bh=p0vGFZ1wdWGbnt9FCH999EQ6UIOtZuI8vUy65LhLMKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgwokavhOK+yo7g/wveJZFEai4kssHEkSx0m6TmWRzYvKS2qh9ECDf0OLRx1D0cNATB/vUX6rfeEWV6IkV/xZsdWP39/uputi580Wlx90OtpOVFl4H3wUIK3CxQBGYga/KGlWtkEJdug0wxrUxwTueW0h3ZIUiC/4Y+Eq/NoswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=fNpX/TKA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394a823036so24937045e9.0
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743840604; x=1744445404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94b9wrxm3hp7XmByM5KKoGfNoSco8/rIY08sCXX4aJY=;
        b=fNpX/TKAHBX3ryHtAKHCaNoHBxknjQmYTtYjO3Sidyhd0JbN/KSvphVl8lHKErpYHF
         E/Jy95GCHHYDFl4lqXEU5CTXvJcWuodxaUSOWRfYPUJ+jC3zx7rODqZC465rhYtan2ot
         dYw6nKazG1MnUtNc+h2Zjl3RkI6oVJznWIVrNb7in98ysmuCAJ/HzwmkecOjXg5i3DI8
         n/eWsTknewjlBSokvcwHfiVumUv1WWyetnS3xQyItfMkFgX1EPepnxXwRPB+NX31rufJ
         Umb63RsNnqSxdryUfY7KbmOzIhN5VzDTrrcAnGRmCWDTY4AXqiZ/ZW04f9FKgv8Uyi7b
         Z2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743840604; x=1744445404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94b9wrxm3hp7XmByM5KKoGfNoSco8/rIY08sCXX4aJY=;
        b=eMiLu2bLqkRG8y69swrASUe5MDrnoJ43CP8gW9bvgdDJuhqsdtpPmiUhY1MUzbhhlj
         VDOpMsSlslZKpIpi9FXj2kTCgJyGdY6oXcBEyNd4yKxYKclqRMwrlmh2YaqTWQL+0nsE
         gaUEkwna9j9UcX9u7o+xcKBZmLld7TA/Gzt2RP1PDdNo+B9is9FViXjJLKvmVxGWZqC7
         pBQUTxqHbx4xkuM9qdx/g4E3hCHWSzX/Dx0p3h5s0unri+yCDLGGRklhIORfqBSISvjL
         lBCpJqv+pUyuCgizxH3mpvd03dKQ3jElR8fLeexq7cYI8TocScYWjkcYv87IVMMy4eaT
         mqaw==
X-Forwarded-Encrypted: i=1; AJvYcCUprfbZwdTEkpdWTwLX8v4Iz9/4Dz45kDtTIA7wPXr3Ms/mkffGD6BuBL5tyYIKeUxElibQXWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7H46Xe7XSdHWmR3Xbte9thjYYF0MDqaCiUFTuaRv+xvavwZU
	BHqLwms801fwt6o+EP93FOysMIO+zdC3eiHxbHLkdOqFBwA+JR2g/262Kv1gDrk=
X-Gm-Gg: ASbGncvEBMPhyC0P8iEjC77f1/BEmtX7/dJmjK4bKXiFnOExbdSodJLr/M23XkZ7842
	uC52frhSgrOP2qIwVOspqEP7dsk+rR/Gpwh6QfFqGTtZCVFuNAYR1q8EXY0LlYRk9PZJEEvDWFg
	+NNOQXWlTdvUn7E9mg6RgzPTg7Djt1aT52oUfhTRDneWQBGsFSKHbUwvpIDv0wilS5GHAX0B2Y3
	Zc3F69M8lgbKtetotXPUAQGH5yRXckxKawAWc9rrtr31TCM06YJ+9eJH80dzNtNSPJrYsmS5PKv
	SKyBkLS+RqOuAq+M1OfgwnALSyUHbV/D8B7Ftqnh5Vsz/DWwBboaKZ64JywkDk0MlDkyvai7F0Y
	f
X-Google-Smtp-Source: AGHT+IGr3yLaTLf/J+4e1A1EPE7Ku7r1udK/W1EmakfMPotykV3/dJ3b4bi31RRCYO2b3h8RKosMWw==
X-Received: by 2002:a05:600c:1d0d:b0:43c:ec28:d310 with SMTP id 5b1f17b1804b1-43ee063da68mr24847095e9.10.1743840603506;
        Sat, 05 Apr 2025 01:10:03 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bf193sm65515795e9.24.2025.04.05.01.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 01:10:03 -0700 (PDT)
Message-ID: <2f0dfdbc-64fc-4371-ba4c-48f306e90599@blackwall.org>
Date: Sat, 5 Apr 2025 11:10:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 net-next 3/3] net: bridge: mcast: Notify on mdb offload
 failure
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
 <20250404212940.1837879-4-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250404212940.1837879-4-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 00:29, Joseph Huang wrote:
> Notify user space on mdb offload failure if
> mdb_offload_fail_notification is enabled.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>  net/bridge/br_private.h   |  9 +++++++++
>  net/bridge/br_switchdev.c |  4 ++++
>  3 files changed, 34 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


