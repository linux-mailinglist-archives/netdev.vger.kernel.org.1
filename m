Return-Path: <netdev+bounces-199047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF2ADEB62
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8323717072A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789712BEC21;
	Wed, 18 Jun 2025 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="JJ93Vs09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51C27FD58
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248399; cv=none; b=FZuk7rr4B6maRTtdo7autW3jVeEpGBTTcxbLEO/XgQ/VDUOv3L1PBjeIZcTRkQsOnrlyTA85tcnqN+ANU/+wb7FYoetkH7NQGqlD3syGziAjDHFrRaoNtxXWX2X7Zlf5jWrC/fwNgm0JogxrufqHw/POo1nXYmnKwa4/FcCNOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248399; c=relaxed/simple;
	bh=uHxdHDEOTugKk9J9OjXhzGtnevhg6NmN+nEaYePZyBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AgUByNdtsqLgPyBjFo6LojGsH1RNQHtG9iqJ+EAs65bpatSVEchmiVOCTVImTFDZOQqjo293iC/1s5osKhBFp5TmyWuxAzucKjzievIKVB+AR4M5D0AaNY2oR3VAvosiJXyznCooSymthgecAWOZvgPqYqn09GQHK5yFMq7II/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=JJ93Vs09; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4e62619afso600325f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750248395; x=1750853195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JtO+1zIjYRJs86fkY6zRnbrPpWElMpbcIKEvz5ZokbE=;
        b=JJ93Vs09UqhWNKfOla6mVm0IhZe801JCzrtmvhxNqOz/gJZRs4hFVDOHyp9rpQTQ82
         3NfJ1NBqW70yLaMGN/jyZvWkT7y9MMa2Wo83I0tsr3ya4KibsolV8zVlX8+LA9+M1QWR
         rUXoNopGgy/gMgeBiOvCLasWIPYgCrDeOYs67SUJuyAXfDDlv1HaR931T7f8+HHIgvMc
         qNf1y+MsZMt6LibMCllUm6iwM/CPFUJhSl8SiRPMTFuLR/S6iMDQzQQR6ayU+HxiDZlS
         oSeQQ8VmCVKopHXul5/3zf2qFxq3tArRJEqb6djQYYmCYxkWaeYyc/zF0z/VTvdv6o4H
         S2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750248395; x=1750853195;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtO+1zIjYRJs86fkY6zRnbrPpWElMpbcIKEvz5ZokbE=;
        b=ccXwGo8Agwbx7gtZJiG3IKGmMl3ht048XfKJJq9V/e6Z/hwcSDGiDHYazopfSkAbSZ
         tSx73FN7Pu3rBWZfE37x0YM8sJDVOtagepexPADLh3lS3G25Ghol7A7VhN3tOpL8oIu0
         L2wXavr+cSZCw3aEFUhlx82x0Kq7g9Kk0mYzy6Mmg2Wgc/2a0GO6pvWhrpeNYIg+QQm5
         +VuupYNxpckzQf2E+i76ScSn+XQ5QXIew4A/L1u0HB7pj2YASaqRhXEDAf+/woN4HCTF
         s81kgx57MhzOezy1mV1duJb8Zd53S6MJBhJ15BEm8ZCbUAe1POPOHFjbxMF/rzU6Macf
         xUSA==
X-Forwarded-Encrypted: i=1; AJvYcCV2uu1isag3f3XNbumrjRRv1pSaMbLLZS/Yf/vdf9h8laRaFCgbYoJDfxbR+YeDXzcVGHJhVOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8ghOV0uLcpYIukPfL0qgaEjh5G0Tkx6Y3i3++dVyvmSuit9u
	Ctm6AOTx8/URNjgDxrVrdq3wMy8HHtvGWbLG0ZmRMxqPpl4hOAlAU5pnGAeqEI0m7PI=
X-Gm-Gg: ASbGnctkHDwhPk9UvtZ7fgBnwUtgxJtkd+CfP8fPLwglIN61+Z3oi9zBq+B5HY3QUwG
	Erkc1ITdWGkM/Y3lv9vIRsQf2Shaayhy7PqWsBJDY55/TWnOJ79POS7qG2dTGu4X9esSzS5kU9m
	gwEhmzBoHhX5q4h9MAslrRD9722xISkcGoyuTI7rtWAomK5B8LcIRolTFJ3Q1Nwz/d1Xs+mJf7P
	hJjKyEzC24bSVpXDR/nlchs6C2/d0kkZc3gvk3h+vsmUtk0rh57pyw0nJkYQ20/IxIL+COw8QaM
	iyjH54Eqe9YQ0nm0uZuQk8tyWGdPIPutet+u+Rcg14y0q0JisVWG84pX4Kn3nJAJLFZWwzPCKX+
	GyfletQ==
X-Google-Smtp-Source: AGHT+IHw8NEafcpaIypnwCtdzWnvZDL+f6HF2yLjNIyemROAVUnq+qOCCQ7uNSAQajDmZhfC1cJ+LQ==
X-Received: by 2002:a05:6000:4203:b0:3a4:dbdf:7152 with SMTP id ffacd0b85a97d-3a585f7d67fmr2085596f8f.14.1750248391929;
        Wed, 18 Jun 2025 05:06:31 -0700 (PDT)
Received: from [172.31.99.185] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm207704175e9.4.2025.06.18.05.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 05:06:30 -0700 (PDT)
Message-ID: <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com>
Date: Wed, 18 Jun 2025 14:06:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v12 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 michael.christie@oracle.com, sgarzare@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
References: <20250616062922.682558-1-lulu@redhat.com>
 <20250616062922.682558-2-lulu@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250616062922.682558-2-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 16/06/2025 à 08:28, Cindy Lu a écrit :
> This patch reintroduces kthread mode for vhost workers and provides
> configuration to select between kthread and task worker.
> 
> - Add 'fork_owner' parameter to vhost_dev to let users select kthread
>   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
> 
> - Reintroduce kthread mode support:
>   * Bring back the original vhost_worker() implementation,
>     and renamed to vhost_run_work_kthread_list().
>   * Add cgroup support for the kthread
>   * Introduce struct vhost_worker_ops:
>     - Encapsulates create / stop / wake‑up callbacks.
>     - vhost_worker_create() selects the proper ops according to
>       inherit_owner.
> 
> - Userspace configuration interface:
>   * New IOCTLs:
>       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
>         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTHREAD)
>       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
>   * Expose module parameter 'fork_from_owner_default' to allow system
>     administrators to configure the default mode for vhost workers
>   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls whether
>     these IOCTLs and the parameter are available (for distros that may
>     want to disable them)
> 
> - The VHOST_NEW_WORKER functionality requires fork_owner to be set
>   to true, with validation added to ensure proper configuration
> 
> This partially reverts or improves upon:
>   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/Kconfig      |  17 +++
>  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  29 +++++
>  4 files changed, 294 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 020d4fbb947c..1b3602b1f8e2 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -95,4 +95,21 @@ config VHOST_CROSS_ENDIAN_LEGACY
>  
>  	  If unsure, say "N".
>  
> +config VHOST_ENABLE_FORK_OWNER_CONTROL
> +	bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
> +	default n
Why disabling this option by default?

Regards,
Nicolas

