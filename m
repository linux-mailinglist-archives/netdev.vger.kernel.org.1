Return-Path: <netdev+bounces-251119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29636D3ABB9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EDBC301B59A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD69C37BE75;
	Mon, 19 Jan 2026 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="INqVW/1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6437E304
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832532; cv=none; b=jhykcsTEmwgB7O3GrU2qerF2j4tl221n4vUv2YgAx7frhdburyfI8dTNameEgf7kHSGuZ/3E4czhJMsuUSjctjf9toVZlaACDlw6ieQ0gVDSRecVoa5QBz+yhfaeDO1tJR5xPEazRdX5OI3kirUp1AyEM//TpjF8WTN3nblCOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832532; c=relaxed/simple;
	bh=pp2YgprgG/WSqBXJ2ivYP7aamdUT+AVMwz+Q7S0Y0DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAIlzsOzDSjE6Ky+lJ9cAJFGmciftsMz03AfSe7ZfHk/w/1DPKUfNarNeWCs+iWDQP2oI+WoHvKDDS05Yv9sDncj3nh2BdC0P65d5qwTDXaFGWXeDIi4dxwF2TT8KLdAKAFCyBOm4vilrYYIh6L4qPxuSllJkMK8jj/cq/vtfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=INqVW/1E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so23441235e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832523; x=1769437323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9gL1h1UwdbQcveMkgUlm8H1IjO3dxcQ0TLfIUh7Pdo=;
        b=INqVW/1EqSTvrw00vx57s/60NO7Y6e+GbXyWm+qPoH/OO0ZNlh+mh/4XguwSKeMdyd
         2Ybo8th2Crw3EMPVWZDXbRMiGR0o13jIf+p7JG+X8gMRPe0xymIobHqTalljXRk4hy++
         4gb+8pdkq7FLUowxjuyrRT4E7tt5WKBV2uABysWbEkKT9Y42SNXM2eLFjE4TXb2AGPd2
         pWv+6iePiUZ+OcpllAYxWaH6s3AzoY2c14UyKsKQjp0i/l+U0ZhRvdfFeplbaCHEiTYD
         ONLax+rAzSuAlQJSG9iNO786XO0zvjykkknSjEC0ZX9W0dM9uKM2fDtcRl7LeNIhAqZh
         R92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832523; x=1769437323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9gL1h1UwdbQcveMkgUlm8H1IjO3dxcQ0TLfIUh7Pdo=;
        b=wYHwEpGIkRNYPklVUv9VTdTiKNlrT4dsaSgGJZdFQ2F7m+QsIzFeUOzTqlv3DtWKSt
         Uh/Znqti7gptKRe1pzNQBVSddKGhTclive5Nf86ad1ZD8HCeVLB3xf+9sMDb8a7XN7t7
         iH29IJAE+apA0ehrU4AWnFSkyai8wdR/CAqf2IL3s3kroREwSf9YS3yJR1xsG96G1K+p
         bhcJyzLy+stkTwW1iDDY8aAc4HtD88pOQY18Fk1mswQ4JwdpdhG/x2jf4TsF45Y1E3ac
         k5cFPPvzL9nrCdga2XFTdf4skb/sGMZylidkDKphO3/KdEMXDcdsVn5wSNjSxnO9lQHq
         752Q==
X-Forwarded-Encrypted: i=1; AJvYcCW87o7sExe1ReUc3MEuTkkZom6RLuCHsunNaL8Tc0Bs7Y2UNkpc6/dMWMZYQXIVl2V8Nby7bR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEUFLxSYaxMhFkt7KiFOmoJHo5qEUSkVRYXihVPfJq+QWzog7
	F/tTpBcHQAgNQ36DxPtw/4nfTJCKKywcA3fVwAK5htsyJ+rybPbaZwmQMROP3d30MMI=
X-Gm-Gg: AY/fxX6/8j14Mtk2Wbf97L8Q8iiRrRduBmCRswWgZq7IgzD+6Jfsc+U4nGjG+sU+Cfy
	q/SEjDqApgmaKWZFQt0xwioZCDe8EWv4Dhtqx8a6HGaEH8lQwMkzRZfm0jRmtirhNCZ6OYptvh3
	zghdmnNnZ8br4SKpyHbtrUcVWBnXu5M0MmFIgyD4XAFdUxkWW2E0YbUxRymxougwAUrs8+9OigQ
	1MxdEAXPncB3LVhwP4GMoFNpr6zVZVByU/tBB5IUXpVUoVYyp69iGThMfV+8XUDAOO0e2DoDC9B
	xFQIWZYYwQoabzdv8HygehAOAU2lPipFkCr4/KLCY+AMgdx433bEecoArbI/fdAv6Mq37oHBJeq
	fs7GZB6RDu7xyDjOxAFebM/YpKeIxWhfpvXZmsjPt7q1G4B8J4uNHvoTSf3l77upDtqpiFSMW7t
	zntE0O5ASVgeEuIESihereOMxIlLSC2IsTGRYK5pg7NKjpoqXth71HtocCKX0FIc0ErICt0Q==
X-Received: by 2002:a05:600c:8b81:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-4801e2a2176mr148437155e9.0.1768832522873;
        Mon, 19 Jan 2026 06:22:02 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe6e703sm82695375e9.18.2026.01.19.06.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:22:02 -0800 (PST)
Message-ID: <540ec9dd-0941-4967-84d7-5f5991c1aa53@blackwall.org>
Date: Mon, 19 Jan 2026 16:22:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 08/16] xsk: Proxy pool management for leased
 queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-9-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-9-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> Similarly to the net_mp_{open,close}_rxq handling for leased queues, proxy
> the xsk_{reg,clear}_pool_at_qid via netif_get_rx_queue_lease_locked such
> that in case a virtual netdev picked a leased rxq, the request gets through
> to the real rxq in the physical netdev. The proxying is only relevant for
> queue_id < dev->real_num_rx_queues since right now its only supported for
> rxqs.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   net/xdp/xsk.c | 48 +++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 35 insertions(+), 13 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


