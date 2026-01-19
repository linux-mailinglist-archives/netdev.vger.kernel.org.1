Return-Path: <netdev+bounces-251133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685AD3ABE3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7794A301BB74
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBAF37F8AF;
	Mon, 19 Jan 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="e4m3x7u9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DA36B075
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832611; cv=none; b=BvyziI43nhCp4iPpdAbdlwwACPJTobPmGzG4yCMlcqnRqOhv+1HcP9J2V6WH9XkcXiT1MTIkl57Tz7LeCHZhWXxA4Hv3//sOr8MVpcBPn3GDSEeYgHl5+VKyZabwFQkNOtgFs1TUn6njluEKYSVoDV1eqNCIdRke3ly5MltvpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832611; c=relaxed/simple;
	bh=moC0t1S/fBLZmSoywp+QnSHu36Mi1Uh80eIvskYMvto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGNaqBrWY8IowlxVTI+FkL6/0uR2J9snQABW5nGIcPWMCcylVVf1fStZbDRImzicVq7px2t2Eocw0OVNdC6vkeMnbVClhZ+Cd9oGywhWNjxs3JjnxgzQ47QeXvmDvU/NovjQ1Iv3fkWq9imLMgtcOynkcQLxWO9xFVYEvOanz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=e4m3x7u9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb2314f52so2371232f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832609; x=1769437409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sm7Zp/rHDSp3gapjmf+B9iq6Y1vMVLjliOXFPyuyGcY=;
        b=e4m3x7u9VCvMHepUheL8ZjK2IgoFvwRCN1p64rky795F/G1Q7c+S6ie4oYzZVcJPdo
         5ikRb7VQ+LXU4Lsc1Y3ggMbgOHwM/VaxcNTwZ9vbtU1cmChNuHYO+4Zt/Qw0zZcYgqqZ
         MS1Bw9tLQaskiN6XUbq5TT2Ad7+0f7f4E+H224n0o8n1M6/yeSH/97Ea1M4HilJVYLBn
         wvDm6QKscAz4tOTql4l1dh+pUhpLSEFvipx0g+romur8xIBlReE7Y7dq2gbWWEGKjet0
         aGq4LQUXSLW2xPnwxUXQDWr44Rl404w2h1a4Kas6KMbtSNSSnRv8uzMYMIZ6FKdsncCy
         d92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832609; x=1769437409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm7Zp/rHDSp3gapjmf+B9iq6Y1vMVLjliOXFPyuyGcY=;
        b=DrCSLZ+Pefv9Qf5sX1V8rpDGMl62t49yD8I8M90WRlv3qi9OQrNjDLFUCrLocA5SAZ
         hVPyBIIVpP1rmENObdXl37neSH52PpJhMlANqCpFal7my7UPCduSMc9DzVfKgsaodZKM
         PlrWpRlVMO777+7J/9+wVgfiYzEWf8CZnJZU0ni9VuchqI0mimKj8TSod3lUx0q8XI2H
         OSLSBbQ/uXjR4mmJd9NrWxfb695WEh7bzu35XJm8Mj7rCwtQNBWMeJP/DNVj5DNS7jfH
         bY6Jubof7wcpep+7A7hAt2u6OK5oZ/uXj2kGmnq2uzIi9JYl10yx3343gTPBd8s0y6ye
         bkUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+H/Ddt30uH8tLyJoA210D7/tMRD7ySKIYdP9Fh0cCVhLp9+JWGWHuF8xv7UoNU7puMDFJ1U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPoNWjV1AdKA7RFe9qk5FJQLzXKb/S4KavHvgrFmpcYvm8brT
	/7MvT+BZjw1zh6+qUWRBh28jfnVJEb8njQOVIKwjYxC2tHAKVn46q82vxj7DwjgyiI4=
X-Gm-Gg: AZuq6aI73ted12QytcbJqt0VloxoPOuH5FDArp4Pde5X/gieLuZl6nqJGorda6mPAs9
	i/frekjZrtmnDVuN0rd11kZVBRbZBmm94OhtYYXMjddJrByxvqDP/u1R3GXWZAAYuw+mmhDAko0
	CNojP6Hn8I8037jlK5HyOx16RvM+/bvDrHSy0hieQQtd8adkOyWPQ2Hexg5pRWx+IVUFNJYynuP
	JN5uBr2H/8pN4zHlWNWrmKOkbSaLoKg2m0QQRUibDfPM4hYrjjBg82OG76ffu4QEqTyIIHYWVZO
	1td3zcdi3J6Al4hELlm777Q8kMh3+64XHhLx4urI8TMMfFG1y29v3JIiIA00dZHyABVYt+Cyc/H
	H9oSTSooO+4HYPTywchAGWSliNlZQfZLs3bCm0dQgg88nOspMKq2K0f7x/eJbRzJlQGotCNQaBc
	hLr6a7CR+fpNyxh/ecPoKreySMoNYU1T5ZKPks2OySBIv7ZqiNR8c2Z+kOHHcgRFEzwUZG+A==
X-Received: by 2002:a5d:5887:0:b0:432:58f5:fb36 with SMTP id ffacd0b85a97d-43569bc7ce4mr14787035f8f.47.1768832608491;
        Mon, 19 Jan 2026 06:23:28 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm23782579f8f.32.2026.01.19.06.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:23:27 -0800 (PST)
Message-ID: <d512fc03-5c16-4af2-9353-4e97c7982171@blackwall.org>
Date: Mon, 19 Jan 2026 16:23:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 14/16] selftests/net: Add env for container
 based tests
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-15-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-15-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:26, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add an env NetDrvContEnv for container based selftests. This automates
> the setup of a netns, netkit pair with one inside the netns, and a BPF
> program that forwards skbs from the NETIF host inside the container.
> 
> Currently only netkit is used, but other virtual netdevs e.g. veth can
> be used too.
> 
> Expect netkit container datapath selftests to have a publicly routable
> IP prefix to assign to netkit in a container, such that packets will
> land on eth0. The BPF skb forward program will then forward such packets
> from the host netns to the container netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   .../testing/selftests/drivers/net/README.rst  |   7 ++
>   .../drivers/net/hw/lib/py/__init__.py         |   7 +-
>   .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
>   .../selftests/drivers/net/lib/py/env.py       | 112 ++++++++++++++++++
>   4 files changed, 127 insertions(+), 6 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


