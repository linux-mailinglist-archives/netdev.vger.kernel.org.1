Return-Path: <netdev+bounces-189040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485DDAAFFFA
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343129C48FC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525327B4E2;
	Thu,  8 May 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/UY3Y8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5707221294
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720775; cv=none; b=SxvJsxw7JOuX65NTLiTGTCHrrKJVpRYo/pt/UMZXWdbfJxn5iimWgtfssY170Ek4W9X0Y9w970jORqHThKb6Ygfyi4wSAkuCqeKrcv0Ipp+2GxEclLdfwQF0lEkisQO8rO2AOgYlpX+u46ocsS0i0MeFw7BOGLebXLvqkHan+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720775; c=relaxed/simple;
	bh=8Oggs8PdgpfLcLDN+S/j+k/Ui3sW4XRzeu7Tl9IKj44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnoyFzuZOAbptTM5RzbvJpgIhgFhHYFVFKP0BgUflosD3BlLsqFznRnA29jdSNk9u65PjX3jPgHB7qgEgWr+r975Bu0hw4nhl4OPvAiXr2N2d8lEqyooFfmnXywKO3pNVQ2zhSyovFIlxzRkX4m1kVOlRIJG6TBoQd3ajdcnWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/UY3Y8j; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22e5df32197so13937765ad.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746720773; x=1747325573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xo//ERntUiY4++Xepbawc+oUVWeHukMmfxNVhqyfjLM=;
        b=G/UY3Y8j9kVjgG5HkV3mbuArEbvnLt75Wo08AjiRuW/gUp5HJMQMp3KTmA9L+Ga6EV
         zewUpJM2AiyqUiui/wU3mTaiDqpgO2rndQlbovcf5+u/ZhNhF0Jm+Jis56SEn+m1rgsh
         O7kqzbruxIulfHPweS1PSGue6sSvvp9kmL1ML2tYTR1K8d3TiOULH4o6vKdFG5vhZG8x
         pWJ21XsDcAPZjA1GSpIh3cADh+WzOJD77fRGPwIxu62je135mtDEbUe+K157T93WWRAG
         KEat9ZEQQJZCGmpsDqe4DOGxnaWn2phWmu6Xu3FNGVqg/P/kAm3djkfSUbhJEB/hsy8t
         C57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746720773; x=1747325573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo//ERntUiY4++Xepbawc+oUVWeHukMmfxNVhqyfjLM=;
        b=REiayhK8OY/v7Sp276qDex8QThG7yxZzQvJQ/J9c7gm+dZ8Rv5QPzMwtZRfoocrvUE
         BRWmEc4PlA6xkUcmrQ75H4BRL1rZKZQY0YvtNtM5hebSxg+1IR5OlN9rQ0CU0DUQtWBQ
         9PiLX7A3OlrmdwPDVAzLIIP82yVDxw10TuZIj4iXmgNHnYVOHdHLHh9Q4VeTM7NbK2me
         1cI6fnmK1RDn+LApt7MomUIwlZubnzaZiu4Solm0ddIUUfHWBaoKJI5rHxH3NgNNP7y5
         frM/fGdoM18yDfsM3Wxv+Xdo/qTmvmDXRBquJCnUfYs2Ur7fAfXw9d6K4BxBjBw7aLev
         CivA==
X-Gm-Message-State: AOJu0YzS3jLCul5uuIIBSun2Cgdq1DzjSLb/fDmDp0a3Z++b0hCDGP1Q
	yR7LGpQwnjRL+zqXr15gqyozvjV2WUBZIgg2jx8JNtlUXMpErmx12rjf
X-Gm-Gg: ASbGncu92IPTGVH+DRFZDPGZ31HriDP0RLmQGIDP4N87G7Oxm0CguxiSCi8Es6J5p08
	kooni2FxI49UgNuCbi8v3VjPmzaKVI96OiBzYticwgf6j8+qXOKXZM1AiRSZbeNs8JcMw/6NH/e
	JjgwEiIYy7BDvXbGmVKbAteud8BTiUnVnG96mBgrWggSyxRfxGGlZBliyyYu1Th2ZoW8QUVuY8i
	6ymJmCWGKJVRYCUs+CcYQpVniazDd79qvmYOah6KVZ3ZthLPPOqkQWAR9DhlPOuEkhWBEGdnAEW
	ZUjXU8qmn0oVOpTYniBpmr0mTJZvkpAq+0/X+YWXzNoceclOIU6i6klAw0e7OKFxGF3PzgpgWqH
	JIA==
X-Google-Smtp-Source: AGHT+IGGlNauS8xf0axwiEKc/9oblXu8rgdzaBDklimPVo6kp6TmhpB1152RU7EZnbhttLEgCk2WXw==
X-Received: by 2002:a17:903:2352:b0:224:93e:b5d7 with SMTP id d9443c01a7336-22e5eded337mr137944345ad.34.1746720772778;
        Thu, 08 May 2025 09:12:52 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc82bfadcsm770585ad.248.2025.05.08.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:12:52 -0700 (PDT)
Date: Thu, 8 May 2025 09:12:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v2] net: Lock lower level devices when updating
 features
Message-ID: <aBzYAzPtf_TlhT0n@mini-arch>
References: <20250508145459.1998067-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508145459.1998067-1-cratiu@nvidia.com>

On 05/08, Cosmin Ratiu wrote:
> __netdev_update_features() expects the netdevice to be ops-locked, but
> it gets called recursively on the lower level netdevices to sync their
> features, and nothing locks those.
> 
> This commit fixes that, with the assumption that it shouldn't be possible
> for both higher-level and lover-level netdevices to require the instance
> lock, because that would lead to lock dependency warnings.
> 
> Without this, playing with higher level (e.g. vxlan) netdevices on top
> of netdevices with instance locking enabled can run into issues:
> 
> WARNING: CPU: 59 PID: 206496 at ./include/net/netdev_lock.h:17 netif_napi_add_weight_locked+0x753/0xa60
> [...]
> Call Trace:
>  <TASK>
>  mlx5e_open_channel+0xc09/0x3740 [mlx5_core]
>  mlx5e_open_channels+0x1f0/0x770 [mlx5_core]
>  mlx5e_safe_switch_params+0x1b5/0x2e0 [mlx5_core]
>  set_feature_lro+0x1c2/0x330 [mlx5_core]
>  mlx5e_handle_feature+0xc8/0x140 [mlx5_core]
>  mlx5e_set_features+0x233/0x2e0 [mlx5_core]
>  __netdev_update_features+0x5be/0x1670
>  __netdev_update_features+0x71f/0x1670
>  dev_ethtool+0x21c5/0x4aa0
>  dev_ioctl+0x438/0xae0
>  sock_ioctl+0x2ba/0x690
>  __x64_sys_ioctl+0xa78/0x1700
>  do_syscall_64+0x6d/0x140
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  </TASK>
> 
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  net/core/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1be7cb73a602..4b5df59d6246 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10454,7 +10454,9 @@ static void netdev_sync_lower_features(struct net_device *upper,
>  			netdev_dbg(upper, "Disabling feature %pNF on lower dev %s.\n",
>  				   &feature, lower->name);
>  			lower->wanted_features &= ~feature;
> +			netdev_lock_ops(lower);
>  			__netdev_update_features(lower);
> +			netdev_unlock_ops(lower);
>  
>  			if (unlikely(lower->features & feature))
>  				netdev_WARN(upper, "failed to disable %pNF on %s!\n",

Any reason not to cover the whole section under the if()? For example,
looking at netdev_features_change, most of its invocations are under the
lock, so keeping the lock around it might help with consistency (and
we can clarify it as such in Documentation/networking/netdevices.rst).
Plus, wanted_features is already sort of ops-protected (looking at
netif_disable_lro+dev_disable_lro).

