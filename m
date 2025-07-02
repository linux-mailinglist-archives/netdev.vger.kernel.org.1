Return-Path: <netdev+bounces-203071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E46BFAF075F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BC17EAAE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2256C53A7;
	Wed,  2 Jul 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIJIPqOo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A481E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417174; cv=none; b=LkypMW2iuNZa7FL1f9au5Zyhgfc6VSpyz9kEn3BX9f96g2tDxxVHTgnIlOqrHno6IKcZRso4kNJfKJliGRsEHxOQJZ3ZxxEJL+I/rQz2ead895J3F56oxTnb8wjD7PUkCoKVSFtKPGlZ8q8nNNlpmgVdZtlZURiTjaIlFK8GbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417174; c=relaxed/simple;
	bh=5pnH88c7TbfiajKC9cYNhgC8LQew/8ON1j9csk5OZm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uanjqJeqvQewhJPkfWhvLYE7odx4YPsHbjNvFJJnlFCWFRxjEKPRV3MEiX9fp4dHEfbinliDJYm9xw1ZNiFbBoXShxpSlY3ZtrmcXj44/XfizLNIruYfji6pBbiw+d+Znrp1JIx9hmjvY4y0H0s6eLrWxeyLl4QnyQMWanSCZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIJIPqOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E64EC4CEEB;
	Wed,  2 Jul 2025 00:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417173;
	bh=5pnH88c7TbfiajKC9cYNhgC8LQew/8ON1j9csk5OZm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sIJIPqOopfaVpGP0eB+Hws0S8Avs39DcK1Frq4uxzm9MUkYtDG7J0tf40bNp5ofa8
	 u0CvXbU5eSwTgu5Oe8DOwLyo5MEpCckwOuJhIg58VrFHTIgHKiG/xSUa9UEJa9l5fq
	 QbSjVu42YTG1x5nTWMIm1hTYPgfli3NUMYShzWJUJZj+XcQEYTrMbkUFjKy20PaD73
	 pa05LpgbKmfwhYMlr7Z+fONH4BkmxzFL4IQHw4cjdhgRGqaH0guyM3Z1ws27xHvTM/
	 dPAqnY8piCgs2jxtCJxkirTcOn2zpNGztJbdBEF5grqTmbRjrMtytwP+NK4bFyaFk7
	 RrrtQMmK4tYVw==
Date: Tue, 1 Jul 2025 17:46:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: remove RTNL use for
 /proc/sys/net/core/rps_default_mask
Message-ID: <20250701174612.55d55715@kernel.org>
In-Reply-To: <20250627130839.4082270-1-edumazet@google.com>
References: <20250627130839.4082270-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 13:08:39 +0000 Eric Dumazet wrote:
> diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
> index 8a5b04c2699aaee13ccc3a5b1543eecd0fc10d29..ff3440d721963b2f90b6a83666a63b3f95e61421 100644
> --- a/net/core/net-sysfs.h
> +++ b/net/core/net-sysfs.h
> @@ -11,4 +11,8 @@ int netdev_queue_update_kobjects(struct net_device *net,
>  int netdev_change_owner(struct net_device *, const struct net *net_old,
>  			const struct net *net_new);
>  
> +#if IS_ENABLED(CONFIG_SYSCTL) && IS_ENABLED(CONFIG_RPS)
> +extern struct mutex rps_default_mask_mutex;
> +#endif

Perhaps subjective but hiding definitions under ifdefs often forces
the ifdef to spread, IOW it prevents us from using:

	if (IS_ENABLED(CONFIG_..))

and relying on compiler to remove the dead code. So I'd skip the ifdef.

>  #endif
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 5dbb2c6f371defbf79d4581f9b6c1c3fb13fa9d9..672520e43fefadf4c8c667ff6c77acf3935bc567 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -96,50 +96,40 @@ static int dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
>  
>  #ifdef CONFIG_RPS
>  
> -static struct cpumask *rps_default_mask_cow_alloc(struct net *net)
> -{
> -	struct cpumask *rps_default_mask;
> -
> -	if (net->core.rps_default_mask)
> -		return net->core.rps_default_mask;
> -
> -	rps_default_mask = kzalloc(cpumask_size(), GFP_KERNEL);
> -	if (!rps_default_mask)
> -		return NULL;
> -
> -	/* pairs with READ_ONCE in rx_queue_default_mask() */
> -	WRITE_ONCE(net->core.rps_default_mask, rps_default_mask);
> -	return rps_default_mask;
> -}
> +DEFINE_MUTEX(rps_default_mask_mutex);

nit: sparse says ../sysfs.h is not included here so it doesn't see the
declaration for the header:

net/core/sysctl_net_core.c:99:1: warning: symbol 'rps_default_mask_mutex' was not declared. Should it be static?
-- 
pw-bot: cr

