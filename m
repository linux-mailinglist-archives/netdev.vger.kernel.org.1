Return-Path: <netdev+bounces-189297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4BDAB17EA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769AD3B1E1A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096F225A2D;
	Fri,  9 May 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmdjvRiK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F99224882
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803088; cv=none; b=XI5dwMq5vVrTxB0RMbPPN6y1j3aj5VGGqGerzKlUCiHP2NwpC3hbIgD+djbefL3A60H05HIFDufnrLS9SAMLPho89Xm/htEsKvWzuVHkKYx6jbOU7EDC5Qg3s8bNFww4ckHMOs98PCgnYCqlB22TCJBGwg4kEoUvUJlvQ1v9g+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803088; c=relaxed/simple;
	bh=JapJUkZewJxb/XlJDWLv3OldsyH98W6r12b9DueXIaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDFssTZLPUmb/pcBMlSBa5uWdsduFnRvzj7reQyFQvekixYZK7FNUP0MR6LyXhdqQ52DlgP6hLXZHSjoQSTphak88Vi20ArwtCd8GQk2//1v+POvKCR7cMyOCkUbxHt2rhPSe6LS8fTRWmvwQTelfke0P+ejT/SYcMdxEP7h4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmdjvRiK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2261450b3a.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746803085; x=1747407885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdI9qhgjSr9fdQD7p5VoyB9K5jN+qP2nfZQB+6GQGyo=;
        b=MmdjvRiKTSSycczIPf0usLPQK5RPVRJizH34VRZEO8nqKGwhE7CsAAiNkJkK2FFIdF
         q26FPO5EnS4A0nA3yJhqi9mKyyFUln6l+xhQhJXb2XfttrID6vrqvvFI3dwqxFKkjL45
         gDxNxfiM2VtVa0v7UlCra058uUxnSb46aa0JTzlcHn3DLItFHOeFviSrD5xK0vGTfWVB
         B+QM9xe4MFu/KzOr21Zo7yXTHr5sZc1ReHv5rEbG+zxQuEhG4V9Igudak4mBV/d24Tqg
         YUS1tMtpUd0HquPuePsZPPRKjSQq1XGFtOghB/7fD2XEaMoT2M7RPigQFLvHwBVR3sjU
         Ed9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746803085; x=1747407885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdI9qhgjSr9fdQD7p5VoyB9K5jN+qP2nfZQB+6GQGyo=;
        b=FcJY6PC3UpXsX75ZEm1wAF7l1o50HiK7FubscDqxxblGmz7XFln2GIUk8KLodaf8KO
         Y3EslIhzOHWv32Y076DzVQPoXmKKzuY0QrfH6JkKE50MkIzzxdAbhNSh5h2WLP4aBGHy
         oDpvGWlCXqNE15U10qOAHW2ll6QpxhB+5Tb9mZQhomzF1IMU/f5HqIBYg/25/Po1BADs
         /e/18cyLsp0mKsfO9sw32/1ChxXVx+zj7eUsHHogm3DEGaV6M8ljXut7DjPNWzcUeJV5
         CmedeRwhdUn+FbrbWIBhwul+fTyO/1RE67pvJol4fHcprrbgcCAwi3RnaC2t60IAUvB7
         CGzQ==
X-Gm-Message-State: AOJu0Yw3DDrvbzf3VuDVn8g6qT7dAx1L8LoAO4WZ80PeyZCNL4eqzmiK
	6kMn9/l5O5rosqmYxj3DT+gt51UiA8jnK6fKhU3IYndJN45tYwQ=
X-Gm-Gg: ASbGncuFvKCDQp1uYtRRjm1qdORdGJVBJTkq95a5DwuJ8Cu/1rlPaR67m3dDRKPwOMk
	x5DNy3K/nZJmcv4AUGxunmAyI8qPq7QIKkq0ZRh6GUkO4u49Qu0QgMVigu5imUr0kctlZVUoEAj
	AfRqaZMcuFaxLlmTBUE1nKqS4gbbsbn9+1DTgFmPPB+RRkLnGtYE0lITrvdwHjiIZT/qmL4b1Kw
	AoyhxdvjLi9meosAB73jzH0fAaLgp5oKhjcOSMnxssbYQEHS8FHVjfJXiQfyvmfdf+8jbC9hpwY
	ol4CmWbi+je0+aGbAYotc1LflPEB7LVRvLYgExfgbnqueXg6bHWMhLgJSs9+QTY8+/PbxVt7Ta+
	0mA==
X-Google-Smtp-Source: AGHT+IEXRUMpZALr2HVUQpjlIexlq3/pNRm/9Nx2vgNac3dWEOAeL7Dfv02a4uGBIOSrbRmjrlqn3g==
X-Received: by 2002:a05:6a20:cfa3:b0:1f5:80a3:afe8 with SMTP id adf61e73a8af0-215abd4f275mr5391329637.39.1746803085410;
        Fri, 09 May 2025 08:04:45 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a104e7sm1874178b3a.104.2025.05.09.08.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:04:45 -0700 (PDT)
Date: Fri, 9 May 2025 08:04:44 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v3] net: Lock lower level devices when updating
 features
Message-ID: <aB4ZjJDLYEJnqGGH@mini-arch>
References: <20250509072850.2002821-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509072850.2002821-1-cratiu@nvidia.com>

On 05/09, Cosmin Ratiu wrote:
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

