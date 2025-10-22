Return-Path: <netdev+bounces-231654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 987E9BFC125
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D89C5613F8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4A34DB79;
	Wed, 22 Oct 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PTn+OJr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8A34DB52
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138035; cv=none; b=Vh5fF25AHNZmMpCtLRvCcjXxiIirfTrLlBnwwzfFUhgwGbK8NjJT9sudf1B1rG/Y3kXORGCn5dvrNwZKqOooW1X6ZHhhCETNPLLwd9rcsnPtiC74JjN+GXhalJwDHyFkPWm564hf7WhqMPvGeG5sS8IKv+hZyvSBaRemrKkmCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138035; c=relaxed/simple;
	bh=lj3+/9vLftsCBjCzdN+X3Nq0wpevMM5aO27bK9qqcGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/rGADhNyXpLV87+f8kFj+hqPAJ9kULSDfRzcFN0zAlTscyjEnYvjo9CuX/L+HbTkDiy1nhMuXO0hYs/2o8Ut5vL2Kvquoak8r4fzt6z86+Hepgr6QOEKSsC9q8SL2vy/aKk9XR5/ENU+MHo5yFmIn59cCDN2AfhSpzxk0d168g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PTn+OJr7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso11584597a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761138032; x=1761742832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5ksIpXLgI3yn70biwBJxvXCxdN+NZ47Ntk3kQ1cJ0=;
        b=PTn+OJr7MF2zFiPuTLFVHExDALR/jSjRUkBvljF1Hru5pJzzEd8FEXZ1PUb8vGMpRF
         YOnx3Bux518QljD/PQ0sE3I2oRg8f46jpZf5W+mnAahf+T8QtpyuSqsZHcYZ2OR1NN8g
         brloWwuY0s3w4Uiosfu+MubOjKCxjXCmnICSH9qPBVY4iIjwkO7esXHJQaCk8FIzLMia
         RY+yFmucdT+r80/thguCJ/1pR4T1YAoRbf4cPjIU0RzA/aWLiGo78HesRgJ+Rh7aTquW
         ++1AFaOl/EYnFjx6Wik/PcLAdKFUH2fXtJgYr/YNtA8KJwBvfDDcPIX5pfoXJfpIZrPV
         pnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138032; x=1761742832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5ksIpXLgI3yn70biwBJxvXCxdN+NZ47Ntk3kQ1cJ0=;
        b=IFv+f2Yvcyg7Av1bU5EW9V1EhiOJYCOlWU7SeJN5nGYF+lqxQ5IVwRIxvjLKDVVJvS
         sij2yPRXF1B/vp4GSuE5RA4XK4mbVLDd8sTrHuQ6KzsWrjiwd2fbRrxwcaiQVV3iJaul
         HOA2khhzD4Hqoo6vz8wNChwCUOz2w63iga3WEwxjZYH0XC3WN80vhiBaR3b25EibWlB7
         gxVcx02mqQb0gcVT914MXg4fh4/CGtxsdBzJlMU0ojwOAU4VdyLzFWGghLsMP5KQX639
         Z8ue74U1FAj6+kijjmR4k7kz1PkAeHfQgzo+FrtRuLOcKkCPCxiiIjZ6jcVwSAorYKVa
         koow==
X-Forwarded-Encrypted: i=1; AJvYcCXgX2Y2clVPOjbK/IGZ303zHXN9UD4n+Xan04IqODLH5sSyMdaRTiB2X2ZC9G8fk/9yF+LVFA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0iKfY0nT7MjnbcuSLX7Skpm+lFnnGJarigbtak+W9bTv0DGt
	+KfA5WCYwRYEoB1Lxg7LW3xFJkX1khNwuXt6MRwhNgqVE3NO8tNFgtlmkaot8LUNrmGkkGbg8TW
	d6zsC9Isaaw==
X-Gm-Gg: ASbGncuzVI1NuyXQ8jUvRzbCcFo5THaxahJlqAtu3nNDIzjX/L8/h05ST+huc0nsn7G
	c3DMu/mxYQdTLIABMV0QSpQbvwiBG8cVEng/FNCG32DHb1Z+2bUHF4ge/sjQ4rYCwCzfeHFVDot
	XdXRJsGtCO1wUg3XP7Fnx/kCle0y1/0v0u4bOG3Yjcrzf1M7wyGHPUY4lIN6kniVZuSHiCtmSRT
	FrlsBG6vInqW4JPpbI+5BhB3iyyK7FOHi+QArQs/KwNzPBpdpHpWjT2//bTkH56qEiP4WORQVHA
	SqWoL91AeqA5qHQ/m+Bk9odS3qGvcIZ+1fpxWlf/tEANlFEwBbIo+UAjRcg5Knvm7vcKsrMHqyl
	/0DQWsfuifKVxqWMmm2XXZVuCECC8gVigbsUdL/YF6RvUfadWWhhhVD5BPPNBj8HGbgQqBtibUt
	/hwlH5UxY65VpHASFn1enYKrriXSc00hcLW5wT5zwg2hc=
X-Google-Smtp-Source: AGHT+IFEjQbW6rQ6MVYPA9PtdiwaaNzRaYiTiaZSKasSAGkhUbT61kH4OnM5E1/HHnZyIvoOzcB/6g==
X-Received: by 2002:a05:6402:5248:b0:63b:f76f:c87e with SMTP id 4fb4d7f45d1cf-63c1f64e87dmr20911347a12.1.1761138031552;
        Wed, 22 Oct 2025 06:00:31 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48acf60dsm11891136a12.18.2025.10.22.06.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:00:31 -0700 (PDT)
Message-ID: <8994bee9-d384-4c95-b4f9-1f322c240242@blackwall.org>
Date: Wed, 22 Oct 2025 16:00:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/15] netkit: Implement rtnl_link_ops->alloc
 and ndo_queue_create
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-14-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-14-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Implement rtnl_link_ops->alloc that allows the number of rx queues to be
> set when netkit is created. By default, netkit has only a single rxq (and
> single txq). The number of queues is deliberately not allowed to be changed
> via ethtool -L and is fixed for the lifetime of a netkit instance.
> 
> For netkit device creation, numrxqueues with larger than one rxq can be
> specified. These rxqs are then mappable to real rxqs in physical netdevs:
> 
>   ip link add type netkit peer numrxqueues 64      # for device pair
>   ip link add numrxqueues 64 type netkit single    # for single device
> 
> The limit of numrxqueues for netkit is currently set to 256, which allows
> binding multiple real rxqs from physical netdevs.
> 
> The implementation of ndo_queue_create() adds a new rxq during the bind
> queue operation. We allow to create queues either in single device mode or
> for the case of dual device mode for the netkit peer device which gets
> placed into the target network namespace. For dual device mode the bind
> against the primary device does not make sense for the targeted use cases,
> and therefore gets rejected.
> 
> We also need to add a lockdep class for netkit, such that lockdep does
> not trip over us, similarly done as in commit 0bef512012b1 ("net: add
> netdev_lockdep_set_classes() to virtual drivers").
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c | 129 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 117 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


