Return-Path: <netdev+bounces-132372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C3991704
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2509283600
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3514B94F;
	Sat,  5 Oct 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DUw7tgzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F238FA6
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135496; cv=none; b=hzswco7W7NjpqK/FmMCQZUNZg7dUUtIJ8yHHcmrecEaX9vTv7YxuIYIlQ8WthEbDzlrihoyUDnH2yidk4CQzHSQQ9mBbe/rPaEoyyRWJuxxB2Lk/xKfvSGzjJtE/JiYculNJ/oAnejw8ajbL9UeVPHvrd162ysF1OEmYIJeYnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135496; c=relaxed/simple;
	bh=PBr6/dfIa1Z4Ms8k3qQYTzZ7OeZkeUo6p01mrrCA5YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hx00TjdrUjoTww/Q9mlzwS7xVUqupSYPXU18wIuJecjDTe5VHmuWk7Iyxm4bgm2rVjZhIXYFvqCz4B1dD6BCfem+Wbf1Uv7g6l0on0rnlkV3iUTr3zHodZ3fhJxF11vfg+hK9o2d86u1clNd73oCIY6/Po54eaIp5Thi0xz3FfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DUw7tgzO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so26330045e9.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728135491; x=1728740291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CqnQ70DTr/Y6AcuCA8XH8gKPRqxEzhLJBZL6l8Tp90=;
        b=DUw7tgzO6iY64IzjthMC6ZYuC0WsS5YWDlDa561zEX80rZ1DZXB+DXe1R/lRaRsRSf
         RGJY8Cb9qnn7KXkIuW8lwVT+OoxzfmwxxqUql+gfoUph1goh0KHVXtRxu6YEHB6ZZEVQ
         vT8VNQwD5WNj2dAIYU9Szj5LtxbCaBz4+loxA+AlTg9JMFM0W3AVMUPXHKfEMnxbjS5C
         WrbsXYywOBdphWDc1mxyDdUX0okeL9LWI17daTRJt9pAG6bf2EbzK/TucKuCDnXBv9Of
         aTcC2Sq25dz1qvMGSubYi9OawANHUYt2bKK/xgKH5+V6ClHG9dCMfWOc3FEYml0TtZue
         rQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135491; x=1728740291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CqnQ70DTr/Y6AcuCA8XH8gKPRqxEzhLJBZL6l8Tp90=;
        b=ZAiZmZUnVtL4g4gBtO9nIZTmvTJ2pLo521f9vB3W4pjvTcqsSU+7Mk2viaMmryyTDZ
         vjQWWE1nEoUvIO1UuOPwAo6oyEMvTMgwPvwgcQcnQQgaXbLWYEbgpfCaHG6uBLv/QRQ1
         rkJvR8PviIdPeQMskl9mQ2w1/8XLw4YwstSS9yScWIdaR/f+NK5Kb8G1r6HwaXpuJuFb
         KaO0yIS5Lp5HlDOPB1uyi2x0OeSBtQ7aiNdjVJe/UKJSFfUgLqCV2xC61AefOQ30d/e9
         iveNN0u9C4SsdRc37jpsXQ3HiQI2ApT9JepyOO0RMsugTiYmBdZm8Bko8jywlDNMjY/p
         7VUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdfv9t8GtX7U5xPMVnxlb2NXSdZuVgwl206eK0TcNvAlJDZ1VUt5zhLNl5a5Lk9Au3NO7DGDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9aVpjOhR7gnU9sdpdhyhKB6Nu9EIMFAFgZvC6taTDWkxyLdX
	T+QLZutg/tmowPw0LNWrQM4JJoS0jeZrpMgO90/awtV0/PNit+L5vrtgCA9oR8Q=
X-Google-Smtp-Source: AGHT+IF5gqT7Vy1K1OF2hajNiOdWhdhxVdqq4WISlD8V+79szW62g+Y+lRLjghT3Egbtx0R+WW1c5g==
X-Received: by 2002:a05:600c:6c11:b0:42f:7c9e:1f96 with SMTP id 5b1f17b1804b1-42f85b64a22mr45635515e9.1.1728135491291;
        Sat, 05 Oct 2024 06:38:11 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e8334bsm22894435e9.7.2024.10.05.06.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:38:10 -0700 (PDT)
Message-ID: <8c763b0e-743c-4f10-a497-8ede27eefe26@blackwall.org>
Date: Sat, 5 Oct 2024 16:38:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/5] netkit: Add option for scrubbing skb meta
 data
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: kuba@kernel.org, jrife@google.com, tangchen.1@bytedance.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241004101335.117711-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004101335.117711-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 13:13, Daniel Borkmann wrote:
> Jordan reported that when running Cilium with netkit in per-endpoint-routes
> mode, network policy misclassifies traffic. In this direct routing mode
> of Cilium which is used in case of GKE/EKS/AKS, the Pod's BPF program to
> enforce policy sits on the netkit primary device's egress side.
> 
> The issue here is that in case of netkit's netkit_prep_forward(), it will
> clear meta data such as skb->mark and skb->priority before executing the
> BPF program. Thus, identity data stored in there from earlier BPF programs
> (e.g. from tcx ingress on the physical device) gets cleared instead of
> being made available for the primary's program to process. While for traffic
> egressing the Pod via the peer device this might be desired, this is
> different for the primary one where compared to tcx egress on the host
> veth this information would be available.
> 
> To address this, add a new parameter for the device orchestration to
> allow control of skb->mark and skb->priority scrubbing, to make the two
> accessible from BPF (and eventually leave it up to the program to scrub).
> By default, the current behavior is retained. For netkit peer this also
> enables the use case where applications could cooperate/signal intent to
> the BPF program.
> 
> Note that struct netkit has a 4 byte hole between policy and bundle which
> is used here, in other words, struct netkit's first cacheline content used
> in fast-path does not get moved around.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Reported-by: Jordan Rife <jrife@google.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Link: https://github.com/cilium/cilium/issues/34042
> ---
>  v1 -> v2:
>    - Use NLA_POLICY_MAX (Jakub)
>    - Document scrub behavior in if_link.h uapi header (Jakub)
> 
>  drivers/net/netkit.c         | 68 +++++++++++++++++++++++++++++-------
>  include/uapi/linux/if_link.h | 15 ++++++++
>  2 files changed, 70 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



