Return-Path: <netdev+bounces-234776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C65C272CB
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 00:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F66407910
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49C328B78;
	Fri, 31 Oct 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WOQY1G3W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82E1E5213
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761952860; cv=none; b=aEp7FSaQilTym1IwXS7DOFSGs3U478jeq5RZyA2/ctVnFffoTujmb0u86OIkVR1fgCV4vtTp7RACmxnB8jobom8eDy83uhan0TYxjZfPmjJNO1WLPlygYIOVxq6Z28uYk0LETZRmMlCZSTy6WP+ECtaWuWj0loFFlA1Cjsyux58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761952860; c=relaxed/simple;
	bh=X57SloBbS5HEIclQokjZ7tccc5nNq4s5EtIGu2o+bwY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lks20xgzifC3uMU59ct6BaPaQPYm69kk3RUPYZMXIVg2OG5nv+p4j56vPYnaoVYzlg26jcsW+CSdn2Xfp9APyFeurf2Ud8JdJ9bMQ9rJG9/YMyaNk7G4phCHXZlzzCIPkEYX08xIRWt5Zi1J3q/mTkBrSjpfYn/jPA4LNBa+qL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WOQY1G3W; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-88f239686f2so298144385a.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761952856; x=1762557656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eAsUxm2d25GYbC2+Trw0UwZ8gI/X61kspxXAwZPx50c=;
        b=WOQY1G3WSZEiY57SUPYr5XsvWFJ/Qzm6gEQ+5R3A5GCzenYeFFncZ87Xe80XmqPCvM
         ByLLnqJmQYGepxPlpKEPUIDUXt7lE43UUvm8HkcbyIlw4T2pwaMHkTU1whgSLrFl+1PQ
         0OYURjbMMfnk6xt5XIYfNP3hgcGxilii2iMWE1iuRJyE6SvuZOAmFEPWNmM3lsEBPj30
         wRBEXywQI9BAF9mbu1bDbTcwD/ydJx9Ah7vR2fMoxz8/DM6H2I4QSgKYNwmGqtCnOLeO
         cQmjifp6AnjgDRHmp9XodpKXE3/wxmUh1VP9oii9T0i6IW9GQ3gvtgc+rz1UDERqcarm
         U0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761952856; x=1762557656;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAsUxm2d25GYbC2+Trw0UwZ8gI/X61kspxXAwZPx50c=;
        b=kXMIecR6K6Sf8/exBDMIevZGbKR8d/mbraX5tOc6XrWDc/6GmY4ho4pX0xH4+kcXMw
         5kAfD4AWgKLFXpyIsNxjF4rJ6ZF3fG3FnaClFmcYtn0O/NtXPWIJjzu8uYCDP5GMeP8G
         HyiCDalhLHzTjP+OcXWAq5bleCOZIUjb1cLqs3okOl1nktR+IBNWRo7zv5iJM+o1Kr/a
         sJkY0WQgkJ5eVb42rA90faYQRXHr7qvM6hNAuFPmwIWLtelT5bRnOmhfkJ5xT/WFdoMt
         KkcEXEkUeRSuBxH4ufWCpif4QEKYcmmHtOnk2cL7Afc86GCdGXXy0zqRb2+8yIzRmR5g
         uqSA==
X-Gm-Message-State: AOJu0YzOms2hdztduWCAC+mq27ZIQCR449qjCZAQwKzjOau2w6rjWuSg
	Gq0l0bZQysq/DidhQZzk8aBJxyClvVuN66m+FZ5iYNUAlw2lZrmPfzK+QexloyJa/m4qg6+nTIw
	D5Ije
X-Gm-Gg: ASbGncvGF9FXL2cMF6Pg4cWfulkkZQAQ5XCc7O2SoNeDHzGdRU9M+a6DOvdMqUcRa0c
	wQg7iTNSN0aGQ+JJ3JAIc9tZTOWlAWkEEzGz5dvwXXhFV+SSCH3uNMfQ+sg8lVjwJ9KIUEnm0YL
	5XPKTt3p4kQ42ogx492cghOTNZPqV/8n7Je8yh44tg5Xp4jD+Y+hd7ZtpV+DGbUmNAIkiy0BCq4
	/p1EXlxmdoIKsMLFDer1TsxbFuR7BX3/i3QQjw5xQpk3URKyT66e5JdateGdSXuCewq0nvaQHXt
	t+MkXd6uquVNKpoVUKgqK5d3GFWoWsDhQA6RkQXcwZU1+gE0f6C6BErpEDdatGUt3ELPm9J/GGf
	0cmjovjbth+pI1K7l7iucYoI2l0ICRx90S4ux1PZy9XInE1YYEPEtf0JQD0t/xf+6VsHr6jtA3V
	Ta/t+XfKURz1K1v77rbl69U5k=
X-Google-Smtp-Source: AGHT+IHtpEQuN+7a9sFmcVX6y9c8aW/Rmrgf2Ep3YUAzxxFUm95to2hy0rlM1eVYiv+nO0XxUuFraQ==
X-Received: by 2002:a05:620a:4005:b0:863:ef74:1e80 with SMTP id af79cd13be357-8ab99687732mr692981985a.26.1761952856191;
        Fri, 31 Oct 2025 16:20:56 -0700 (PDT)
Received: from [10.200.176.43] ([130.44.212.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed3538ae0esm17809121cf.37.2025.10.31.16.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 16:20:55 -0700 (PDT)
Message-ID: <e25ad472-7815-41a2-83b1-93cc364e894b@bytedance.com>
Date: Fri, 31 Oct 2025 16:20:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
From: Zijian Zhang <zijianzhang@bytedance.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, witu@nvidia.com, parav@nvidia.com,
 tariqt@nvidia.com, hkelam@marvell.com
References: <3bb18dc2-a61f-4ecc-b1a6-c45e5c12fa51@bytedance.com>
Content-Language: en-US
In-Reply-To: <3bb18dc2-a61f-4ecc-b1a6-c45e5c12fa51@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Patch does not apply, please ignore this patch, a new one has been sent.

On 10/31/25 3:27 PM, Zijian Zhang wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> When performing XDP_REDIRECT from one mlnx device to another, using
> smp_processor_id() to select the queue may go out-of-range.
> 
> Assume eth0 is redirecting a packet to eth1, eth1 is configured
> with only 8 channels, while eth0 has its RX queues pinned to
> higher-numbered CPUs (e.g. CPU 12). When a packet is received on
> such a CPU and redirected to eth1, the driver uses smp_processor_id()
> as the SQ index. Since the CPU ID is larger than the number of queues
> on eth1, the lookup (priv->channels.c[sq_num]) goes out of range and
> the redirect fails.
> 
> This patch fixes the issue by mapping the CPU ID to a valid channel
> index using modulo arithmetic.
> 
>      sq_num = smp_processor_id() % priv->channels.num;
> 
> With this change, XDP_REDIRECT works correctly even when the source
> device uses high CPU affinities and the target device has fewer TX
> queues.
> 
> v2:
> Suggested by Jakub Kicinski, I add a lock to synchronize TX when
> xdp redirects packets on the same queue.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h      | 3 +++
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c  | 8 +++-----
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
>   3 files changed, 8 insertions(+), 5 deletions(-)

...


