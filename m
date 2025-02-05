Return-Path: <netdev+bounces-163227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB7A29A1C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9CA18847F3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237161FF7BB;
	Wed,  5 Feb 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LKBvOqkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856541FDA7C
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783935; cv=none; b=i4Qc4Oa8v36Hc5h6RGpJF4mKro1I++GkSeqZdPH8BF49/1ORstZSWjVIOYKSez8xRAdi2msNpSKhkTZ3LggjzeTBDODT3gdfeTUM2qas3u1EvF4+722i72FlcJnX3Vhgg7sfe2134CKYpOO0DYXYbtAzsUkCDVG8qHrfCatLmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783935; c=relaxed/simple;
	bh=zFY53rhWZjDovUO3pMADVV+87cxtjfPB8PzweU29wXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT7ukKnVm+MadWT/+SdebYvSpEhTKB8iCrfJ/uTd49gonuBRyBc9aR19zQ+XS/HVCPtVE/1tHCZSMJAA0k8ETbbC3iJxJmYzN8OqoBOI1b9h/6dEGKuO3IpGbua5tneY+SjdtBLeHdnFlCsZ/3JwSfkqMPWnICvksAQtttHIVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LKBvOqkL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165cb60719so3634105ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738783933; x=1739388733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGvh9VMlqnQHm4Qfuuo1H2FVlRFz8yiqu6n4EsMzRTE=;
        b=LKBvOqkL9AjHOeYKVWF8CA9sxGkJPThdoBcG8krV8cQBDT2PbnTI1IS2humnozIURZ
         V1yLN624mHRe5OOV6ATti0/zD1efHDLFxUNt3wHKo1OmXdnZnnrpH/53HyzXj2HwOT56
         2XHMEc1OYvAEHGg0XOALJrMmQ/FUTgfmGiuGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738783933; x=1739388733;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGvh9VMlqnQHm4Qfuuo1H2FVlRFz8yiqu6n4EsMzRTE=;
        b=WgWiqWKKvoqeN2gekVNwvvbpzpaCPjVcAJjCtc6Ur9WCZAQeCsSuTORrkAdP02LveW
         iAdQozkT+9yqdIFtH+Ik7FxRfAIgTQq6qjg/WquIo9UOMYZ17sEOUNuSO1S4mcwywLmq
         4btvZGdc1JH+NzF/5kip40Y3X6az8ZE6XBtwMjFcp0iP4SYz7xnqN1F7UPzblW7QiOTc
         +QaXLfzUjVqCCV1Yj+FXR9AFEknbLmu1zMToZURys46x5uNhbMAkyPvtkDYTe/d07TsH
         pAmIw9IIR2epwoyrURnfeew9QfKq+zh79VV6nOjNzFY4ZZOIfWfTXSn7gqwX1wOgO2dx
         rn6Q==
X-Gm-Message-State: AOJu0YzG/KsYHQA07zrWCW8ZddtA79bNSL/1Ow1GGBAaaICvBMnIZ4Ij
	T2Lx1dMk1t8E9F4l6V7ddS+DJ0hLKuHAtVGVp7qLVyIKcF5hq8QLrqQqD1NJmrc=
X-Gm-Gg: ASbGncscOZLmXGDhy9j5FUga5jKFtCPPdbLyKCi8O/2nRV2U64l8oL9g7weZgTDB3cK
	lK2PB3r3LhA8GedS2mfyuB94Zn8un2RtS49yR/spFw6mAig+O0TZVrFO8jccckvrrshdPSsaFWW
	aMX1iIotZdFf1DWW/5KBhl169cHmM3ag7/IvR1sncoJzZLCoIFuneixGJOxT95y1br1c5f1yjIB
	Z4s8/E5UcfLv9Bq0O18pJRb7YFglywnuWD1+yNwTP3nGw55QcbAGgMfv36qU/btMIWDIpfzBufw
	dnG7w4NNuUCUWXN3BKhr6ubbLblTZdN3nXG9tlaghU3OoeaXg6GzOvDq2A==
X-Google-Smtp-Source: AGHT+IGcmQrJcOpjvdMfdRZKIHScDqRse2+Ikyvq6exdHvc4gODpeQjCTEVW4+fXOIvprlWcuuDFXg==
X-Received: by 2002:a05:6a00:3002:b0:725:b201:2362 with SMTP id d2e1a72fcca58-7303511e562mr5790315b3a.11.1738783932772;
        Wed, 05 Feb 2025 11:32:12 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a89csm12777869b3a.158.2025.02.05.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:32:12 -0800 (PST)
Date: Wed, 5 Feb 2025 11:32:10 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [RFC net-next 1/4] net: Hold netdev instance lock during
 ndo_open/ndo_stop
Message-ID: <Z6O8ujq-gYVG4sjw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
References: <20250204230057.1270362-1-sdf@fomichev.me>
 <20250204230057.1270362-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204230057.1270362-2-sdf@fomichev.me>

On Tue, Feb 04, 2025 at 03:00:54PM -0800, Stanislav Fomichev wrote:
> For the drivers that use shaper API, switch to the mode where
> core stack holds the netdev lock. This affects two drivers:
> 
> * iavf - already grabs netdev lock in ndo_open/ndo_stop, so mostly
>          remove these
> * netdevsim - switch to _locked APIs to avoid deadlock
> 
> Cc: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  Documentation/networking/netdevices.rst     |  6 ++++--
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++++-------
>  drivers/net/netdevsim/netdev.c              | 14 ++++++++-----
>  include/linux/netdevice.h                   | 23 +++++++++++++++++++++
>  net/core/dev.c                              | 12 +++++++++++
>  net/core/dev.h                              |  6 ++++--
>  6 files changed, 58 insertions(+), 17 deletions(-)

[...]

> @@ -4474,12 +4471,12 @@ static int iavf_close(struct net_device *netdev)
>  	u64 aq_to_restore;
>  	int status;
>  
> -	netdev_lock(netdev);
> +	netdev_assert_locked(netdev);
> +
>  	mutex_lock(&adapter->crit_lock);
>  
>  	if (adapter->state <= __IAVF_DOWN_PENDING) {
>  		mutex_unlock(&adapter->crit_lock);
> -		netdev_unlock(netdev);
>  		return 0;
>  	}
>  
> @@ -4532,6 +4529,7 @@ static int iavf_close(struct net_device *netdev)
>  	if (!status)
>  		netdev_warn(netdev, "Device resources not yet released\n");
>  
> +	netdev_lock(netdev);

I'm probably just misreading the rest of the patch, but I was just
wondering: is this netdev_lock call here intentional? I am asking
because I thought the lock was taken in ndo_stop before this is
called?

