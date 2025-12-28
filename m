Return-Path: <netdev+bounces-246173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B85CE4A79
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 10:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A82D43001BF3
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345632C08D5;
	Sun, 28 Dec 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8GSAMfS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUc8fVtr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD42110
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766914184; cv=none; b=VF4PHUyfiFisSfPFk7QFoEo5XKIGvU6ZBNOzmwrSQ6BiUkJf84fayJgnJmzfS5GB4cQdIPJYHS1HyWJfazq3aD6Flrf0e9nd8neB5DkLamYRH6oEZxYH/MiKDUem9UGTUWKyHVIuQ4jKC2y4eGQnCzcT6AKXHvhcafLHsVWgUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766914184; c=relaxed/simple;
	bh=JRXqGZPyd6i1rX1lh7EgJmfY6a8sWMWIElBByilQDj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHxm3y711QvHrfO7qi7RPaSmWjFzCJ9z9gOsQbOGFiFj2jV6t1vD5cgzfYtj6B738idWHMyI1WHNJPXgqFIMzTY1khPWg8H9qiEVPu8eRs9XNaD/eMNdhuldcB42+xQ8mzj+T/lV2hGpV7SKLc+zFRJFGppCixMfNoi9zzzsE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8GSAMfS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUc8fVtr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766914180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMvarooEHJPlsgaGe0SzgPzLYC8cB81Q+YWhxNcV3Ag=;
	b=A8GSAMfSPVUgrc5gQRAZddRlrC0wOqI3gFeQuE4G/ILnCcK0p4lpg6coOLzTZjf+rpOgI4
	c1DJpmVfsXjqg1CVJLqDR7qI3sunUaI6cuw7fjEHZoZRcHFfmaGWOzeI/EhRc9ApEW1HzT
	E91I/A43HuOgQaz6A6OCtvZqMGHJ7Ss=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-WdFecjWGNVCY-mubsVqxIw-1; Sun, 28 Dec 2025 04:29:39 -0500
X-MC-Unique: WdFecjWGNVCY-mubsVqxIw-1
X-Mimecast-MFC-AGG-ID: WdFecjWGNVCY-mubsVqxIw_1766914178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so61307615e9.3
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 01:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766914178; x=1767518978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMvarooEHJPlsgaGe0SzgPzLYC8cB81Q+YWhxNcV3Ag=;
        b=MUc8fVtr+/nJk9qIL1SpzwEpA3IFO5O1+P50fYnyr0hpDqOtiL1KLO70uZZWg4Pmuc
         lFol/wwEDmmDSY/rwZ7jnyZtIXSulcozaWUxAyGRIz7gu1Rp6XXRfLesv1kr9d8FJGFW
         7i/i1UTIcmhBMakQGqpddRGmnH3+vb5RypRB8zFify2XFtuh/QUflzBzOaRpEqEEEQOo
         vD9D2V3eC152gVqgDwkHKVTMfB1pVzfftQeS1LPGJW3xGfWNyAW8GGPDsy+mSaoDkB02
         sEcuythIU/LiFXVCnN/m0WpuFf5LVAX5SyGXDlPaq+64MLbKO6d7iEFCyQA+uHIMD3yD
         sr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766914178; x=1767518978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMvarooEHJPlsgaGe0SzgPzLYC8cB81Q+YWhxNcV3Ag=;
        b=DzT4U/BwxIJDWOA7OS+JNyc5hFZKB9V2hJdU+lZCkXiptjbToGhdFMAm1D7t0EVZ1o
         rNhT6rf2q6YyVK3nAEzgI+CKRIsgW1KsVV3DS41aQvHy9RsR6uc9CXhy/ZOwQ+AbPAxL
         9m5X64wAqez3VM2cpF4iF3XD2XEaphqg3ZD49LqbvPqTAba1vWVhhREjCNDZedXs1bBg
         LS/+XQbAb/pK8bNbtVuUk6USkkcT55JXgcxp22OA/xqxrQJx9YkPJ6bjTaGKiEzVEVrQ
         5rCfq5tcaHcqkIqbzruqgyuH8raDSn8MDzQUFwYaWoaxFz9Fa8/6CS5VPgiaPjSxttZr
         WSNg==
X-Forwarded-Encrypted: i=1; AJvYcCVt++q64wP3FUg63vFKU2TXB/fntGAE/YNJe6jxmqLIFMyyS+I5SXUraSjt4LXw2J/nmNP0zYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzqo+C0bniTyOjUv7r/y5PgRDMF5FmzrLCMpKZH5CCP7XIJKM2
	Z37RveXgu5M2zmws3AxC0RYXIUEGsmh6B3GyymIZ/AHSuReIx5P3oRYgbfJuPhNQWG5y+DEHmY4
	7oKuHg1vdQa6BiSHwvL+a0Xi1ibCu+HIj+9ABw7y9RQf5lhBVksNlXNWi0Q==
X-Gm-Gg: AY/fxX6FKfZsL+gE6wwBjo8/s84xypHETyVDLfVSHAL3T//AdOesEy1Jh2IZMnp15PK
	QLWX/TaMIJ/2mT1Agukq9CWVA0ZlEEWxmWfl1RObmiQf9EmdjhwgnzRY+Q3z++pvfJgKdgcSCTN
	EEjgnHWFoUn6E5mqkWkIv8wjKuBvFHvbiX/ejwX0FIZRBp6nY6Ac17OTZCTr+sgRZaEyYQQPH/9
	RQR94n5/uwZQTncDNwJ2EFLBhNFKIV7fVasbYkyTXhmXIhIBFdpTqOc850Tv2juE+p4ouvfkn16
	3cEt+9WzzngBovzbvfApZzv8g0hKpgzX7JaVKPjMTxx6pQNJ5o7CtbHuq7UZkAFrbNchlSXULJq
	8G1C/et8ZppkCYQ==
X-Received: by 2002:a05:600c:8b11:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-47d2d273515mr253628435e9.19.1766914177929;
        Sun, 28 Dec 2025 01:29:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJLxJINs3vOxy7Gs94Dw5AAaz2WurO64wNw2ut3F6n8+Lat3hQorddJJCfdMfVW0b2BSTlpA==
X-Received: by 2002:a05:600c:8b11:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-47d2d273515mr253628105e9.19.1766914177160;
        Sun, 28 Dec 2025 01:29:37 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm511219775e9.9.2025.12.28.01.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 01:29:36 -0800 (PST)
Message-ID: <e8aa1cf8-f42e-4329-8bd8-0f2c3fedde55@redhat.com>
Date: Sun, 28 Dec 2025 10:29:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] i40e: drop
 udp_tunnel_get_rx_info() call from i40e_open()
To: mheib@redhat.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com, davem@davemloft.net, aduyck@mirantis.com,
 kuba@kernel.org, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251218121322.154014-1-mheib@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218121322.154014-1-mheib@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 1:13 PM, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> The i40e driver calls udp_tunnel_get_rx_info() during i40e_open().
> This is redundant because UDP tunnel RX offload state is preserved
> across device down/up cycles. The udp_tunnel core handles
> synchronization automatically when required.
> 
> Furthermore, recent changes in the udp_tunnel infrastructure require
> querying RX info while holding the udp_tunnel lock. Calling it
> directly from the ndo_open path violates this requirement,
> triggering the following lockdep warning:
> 
>   Call Trace:
>    <TASK>
>    ? __udp_tunnel_nic_assert_locked+0x39/0x40 [udp_tunnel]
>    i40e_open+0x135/0x14f [i40e]
>    __dev_open+0x121/0x2e0
>    __dev_change_flags+0x227/0x270
>    dev_change_flags+0x3d/0xb0
>    devinet_ioctl+0x56f/0x860
>    sock_do_ioctl+0x7b/0x130
>    __x64_sys_ioctl+0x91/0xd0
>    do_syscall_64+0x90/0x170
>    ...
>    </TASK>
> 
> Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
> i40e_open() resolve the locking violation.
> 
> Fixes: 06a5f7f167c5 ("i40e: Move all UDP port notifiers to single function")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

@Tony: I assume you prefer to take this series into your tree first.

@Mohammad: I think we don't need to packport this path in old kernels; I
guess a better fixes tag should point to the recent udp_tunnel
infrastructure changes.

Thanks,

Paolo


