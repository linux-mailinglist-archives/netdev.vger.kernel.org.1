Return-Path: <netdev+bounces-268894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPNfO8VMumkyUAIAu9opvQ
	(envelope-from <netdev+bounces-268894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:57:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D022B6962
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A75B3025C55
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AED6368946;
	Wed, 18 Mar 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBVem5NL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CBE17A2E8
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817025; cv=none; b=EB07Q84OQb5fg6fcCjjywzcuekkei6o0rn9NMQnBNrLC/bn1EAkAzLeLHlB565E55VTJbmY5T4qGd6HLrqxBQECsKGaeF8RezuVq5dkBC0+iehBPL40zjx82B1b/vYAFbKNg5KthHp50gE+fpYOg/5BL9dV3y29YWVMo2vK1JR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817025; c=relaxed/simple;
	bh=7r4rREtYzS7RIetKkZulZVWY3SE/VEUInHC+Z2dAQvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0wHo4Vy+BxcwjNtJCyvXtXaPdMd2YtDwqaAYo9k7G3HLv4+TkwM6XDHX6DA34mCa61E/RQu8n9E1XY1CobAsFNJDGMcB+kQ+d5bN3DxHhG87XRkLQTGk58vDcKrVFAhvV4DO8FxBh9K3ijFHagdbaERomEK5t77xN+jgv3QU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBVem5NL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso40753525e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773817022; x=1774421822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qa/Moz62O8GLwDrNRnV6Ehz/SbUCQeDPfbe/JKDh9Kk=;
        b=OBVem5NLU+wZfXPDmkuM9wk/8hMQoKCfCNmHITK1vm/P838MWtbeAqdN/1TQWbeigL
         jI1/0ojicAr77i4relxMd3kHMQ634Q6XmDjLLVvBZiXphx8qngHpaqYMB5IlVT31nXjH
         UftlylWb9Vlr1GXQsGrGtK9MxdOsAMn2mbA6F5BvXISOZJpDcOuxrjAp0iqBcZljRPg3
         6jGaEad4YI6e8saxlrzMpMd/EozqHz86gkFcOd+0FTmHlZyhpil+1dxXSMsfE33l7Xdy
         Ydk7LgxyS9xaZRbYE7RAi9U8VCD2z8NUpsGKOOIU9kN5YjAWWPJjMGbxkgkchqg9cBm7
         g8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773817022; x=1774421822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qa/Moz62O8GLwDrNRnV6Ehz/SbUCQeDPfbe/JKDh9Kk=;
        b=T8uqgqhgMxw80TBCNNGyQYIkofcayBsDBJdCYJ7JCYkwBDGHdRT/mjFLIyAEIPYFyS
         aoeeRdOMI0hBYEcmBJ02HIea9IgA7P5ts7gdxLRSrUtvpaM7CN1ZwyElwHzxhpBRI71J
         ArHLmNsxjmL0ppjXB3p7INVZND81JNJdZX2GwV6rBT9FhOtygLHKABXraTr/AyXjpM9F
         6hXxgiLwOJ9m9k/eX8meKYRjuowHhJg0cAEp0X+E/74JECGn+yAW9J/vkxZx36mqG83K
         0YD1wEt0CSd5KEIEgtVOMoDMJcUr9PMaH5yUD0qU7Kptn+d+2pryWyor5YJrVfds7/Gu
         UVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqQRH6cZ1qZZUnAapfz9DY8hnqPayNgvTe+K1bBigKUIK9zZrp/jJeH/w+/3dGgrzw0nLnkzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Qdd/xVLzN+cqr16gOzSZ6Tu+qggkNlOE1Wl+R39mKgBwHJfI
	DDb9tlcoLEPpz078kE6TkU0WPrm9OUU2j42MlOcyBz3pU57dLWEephZF
X-Gm-Gg: ATEYQzyCp1wOvsryTXwSiyk357oe+WmD0b6RgXZ9FLbttzR1INVfNGlKq80GbwO6Uj3
	D70qBxx9EsFl0k6drhZBJiArFg8Tium/weZ3PHNMHBvxGzIvLg/TKr+y3236ng9YPjFWfEWWXil
	P9vnv9HDqxvv52SYHs3XGSSczXYR5N3atgeTpHkx10sQDAs4fh5O+fTGl0C9kY9R7HtTpoaXKI0
	Q+pdYbYNGkwLJaQSzsiINc9wnyzrPt/uDcSG3QTJPrjEk/IIxHPFaRNZpgFypXBKa0V9toqRQur
	fiC1X3fHLj7xhG2sqGI5R3bR5GUUs/SKWvSPz0/Ezt70lU59h+JSCv7i6vME4x+iWmKtMQNXGmF
	d9xBL8EyEt8p/ntn6VQ+0oET5LscSvXfdo4VgEJlVPCzMbcqJAIcbvkQQ2esThoKfd/WkBOZ5gJ
	6RtjlaY6O5MbvvsmVhy0KedTP5tXx8ND2ZpHDedEMeSpIHSw==
X-Received: by 2002:a05:600c:1d10:b0:485:3d3e:167b with SMTP id 5b1f17b1804b1-486f441fc5bmr36391095e9.5.1773817021929;
        Tue, 17 Mar 2026 23:57:01 -0700 (PDT)
Received: from [10.125.203.73] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f442d5d0sm39444455e9.9.2026.03.17.23.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 23:57:01 -0700 (PDT)
Message-ID: <fe0ed720-f246-427d-8b47-3a273fb53eca@gmail.com>
Date: Wed, 18 Mar 2026 08:57:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][net-next v2] net/mlx5: Expedite notifier unregistration
 during device teardown
To: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: liyongkang <liyongkang01@baidu.com>
References: <20260317003544.2583-1-lirongqing@baidu.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260317003544.2583-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268894-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86D022B6962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 17/03/2026 2:35, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> During device hot-unplug, the mlx5 driver expects quickly unregister
> notification chains. The standard atomic_notifier_chain_unregister()
> calls synchronize_rcu(), which introduces significant latency and
> can become a bottleneck during mass resource cleanup.
> 
> Introduce atomic_notifier_chain_unregister_expedited() to leverage
> synchronize_rcu_expedited(), and use it significantly reducing wait
> times in the following paths:
>   - Event Queue (EQ) notifier chain
>   - Firmware event notifier chain
>   - IRQ notifier chain
> 
> On x86-64 with HZ=1000, 64 networking channels:
> - Average teardown time: 3.59s -> 1.9s (47% reduction)
> On x86-64 with HZ=250, 64 networking channels:
> - Average teardown time: 5.5s -> 1.9s (65% reduction)
> 
> Co-developed-by: liyongkang <liyongkang01@baidu.com>
> Signed-off-by: liyongkang <liyongkang01@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: fix doc warning and add detailed example
> 

Hi, thanks for your patch.

Direction looks okay overall, nice improvement.
I'd split into 2 patches in a series, though.

This is the kind of patches that should go through our regression tests. 
I'm taking it for testing and will update.

Regards,
Tariq


