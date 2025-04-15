Return-Path: <netdev+bounces-182552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92669A89109
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC6B1778F7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180291990AF;
	Tue, 15 Apr 2025 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeSNrsbA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84525E552
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679479; cv=none; b=LcZ3l4oJnfm6BFlP+06Fx+R86otz/8zTD86dvyo51Hczf0sjY2KtogyPbQWSyGZ3PqHPb4LW4H6aNGxL9NcD4/ZAUmwZPSCiYs6nq8e5RQrbogVVR2WJWFk3PXI1Khr5uCc66gqKDyAqBZtNaTHoJmJj9vTtcdsICJUQyoapxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679479; c=relaxed/simple;
	bh=Hym2Pk7ayMSydqqHOdn8KF9tp8cNLwB8GgLb5VP3Abw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJZtL8TNjLXW2idvGC9RbjPnqOYdEscjmKlR71WXkZ5IFvx2Tr12rByKShot4CgC7xb3K+yYrvlDH7iAsQAEfgTAlpPtf4hcExVe7TBpV7qbBKBIv+PYLETUwYApHA+2NEw9WVtcSKYuQZTMJvJDb2iik/wSL8E6LlRIHQ8peF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeSNrsbA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2279915e06eso52671865ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744679476; x=1745284276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs95jORlHfrTMaOf63UykYdQScyocsdoZuF+g2o8qWU=;
        b=NeSNrsbA3R/4vCJL5c67ia6k5NA90xmR01RaLNLancPZ9ftFIlSoE814wjpzqs9v7v
         OJ3vdGrBm27wX69diwkRwAY+tO/gOMQlDEBhFBX5bppoDQE7MJW+hN6d90HD+cvn1cpm
         PggQLM0f55Ns3nnLQIIRx8bdFu15KuLpTbNDYxlmeiWpJi1T4c3e7eb403StaniSaxPb
         bByE+w6ratGm8djpLoPQPWqfJY+dETNEXlhg8p9bu2ahH80I9zR0QvDWq+IQxoTkydhS
         CVo+tfk7g0mAPrYzQSqXatL6mqWlVjjG+kUhr0Dw6EJutpOHF8M7Qm023gWFSkLob29k
         l7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744679476; x=1745284276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs95jORlHfrTMaOf63UykYdQScyocsdoZuF+g2o8qWU=;
        b=I6CNsnCnOlRAB1KYcdhFx/0B3w8cthpRewzxnsMxdCIsPhbV/ZJD4BA1HaVV9mqtdp
         6JYLLNYQe2a6vWtDGWf5+2bj6xzEuQ02JAZkW1+AZZNuPOFvTPe4S72k/SnAOre+D8P/
         uzQ3v7E80AxPqgafE9nPEbrNUtCawoobIQNnpe/nIRsYUbBwDi63EdEhFuPtVXMCo5IT
         RGGU1Ni6odGgl25yZ90C3627o1R45nOIfDxQk4FvFO6MoMkmBlwO1DdiwpwTt0jNpygj
         gpSNuUmPqaDpfocShCi5RXjkof8CKZagsA5AcNGDYSCc5Nrk4yJciFwCYq/HjmCgiRSX
         mabQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEnG80S6HXgSrFJEP7PA5alJa9V8sH55eJ+CTLfdAg3UYVTWOyfVs1txOA1CN2+Ry9y0QScK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1YzONVABn3Y6HhwG6kHP4lMib9wHa1b7BATweEJv7fyXShAa
	N2JUz+G7haJs6XTWtzffFpPAIu8O9xngQEWkwxyZd4CP/WtsIuQ=
X-Gm-Gg: ASbGncti6PLU0Ys9V/Jzwq3Df3yfvQHMQo3vAL4D0l91uQH7p48zKz37tvO5SeuyfWn
	hTKjde045lBbEMrYuwzh69Sne7H6KCj7YNVNMB1z29qzGjwt0WlJaH8VtcfXoRZbatcV/aNpQUV
	JX6XZ8vwuKMT9bmEBt/Dis3Rvbiy33N2877IQ9Jt7pvcu6Ri/srk4fxmK64rUZj9TW6hklZLddg
	x64g5FkYzrBzW3Km2phxpchFH9F3k89SeGmpBqKCTgv4lzxPy+a/+5m6vDpA0kU2tWfSHuhPu/J
	W6hl06G0mOgNgyEdpkrTK5ZAtPjOwDzgfG+tgdOz
X-Google-Smtp-Source: AGHT+IE4Q1yxZA/WFhaPKfq+1j9vMr76WhZyQw85fSfS9mxAZEoT0hWmlN4kfwqsRaMYiRmuDTD/sA==
X-Received: by 2002:a17:902:e545:b0:224:1157:6d26 with SMTP id d9443c01a7336-22bea49616dmr228500865ad.4.1744679475621;
        Mon, 14 Apr 2025 18:11:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7ccb58asm105987825ad.231.2025.04.14.18.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 18:11:15 -0700 (PDT)
Date: Mon, 14 Apr 2025 18:11:14 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, sdf@fomichev.me,
	jdamato@fastly.com, almasrymina@google.com
Subject: Re: [PATCH net-next v2] netdev: fix the locking for netdev
 notifications
Message-ID: <Z_2yMjGtbQ0ehtDN@mini-arch>
References: <20250414195903.574489-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414195903.574489-1-kuba@kernel.org>

On 04/14, Jakub Kicinski wrote:
> Kuniyuki reports that the assert for netdev lock fires when
> there are netdev event listeners (otherwise we skip the netlink
> event generation).
> 
> Correct the locking when coming from the notifier.
> 
> The NETDEV_XDP_FEAT_CHANGE notifier is already fully locked,
> it's the documentation that's incorrect.
> 
> Fixes: 99e44f39a8f7 ("netdev: depend on netdev->lock for xdp features")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Link: https://lore.kernel.org/20250410171019.62128-1-kuniyu@amazon.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

> ---
> v2:
>  - rebase vs net merge which brought in
>    commit 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> v1: https://lore.kernel.org/20250411204629.128669-1-kuba@kernel.org
> 
> CC: kuniyu@amazon.com
> CC: sdf@fomichev.me
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> ---
>  Documentation/networking/netdevices.rst |  4 +++-
>  include/linux/netdevice.h               |  2 +-
>  include/net/netdev_lock.h               | 12 ++++++++++++
>  net/core/lock_debug.c                   |  4 +++-
>  net/core/netdev-genl.c                  |  4 ++++
>  5 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index f87bb55b4afe..a73a39b206e3 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -387,12 +387,14 @@ For device drivers that implement shaping or queue management APIs,
>  some of the notifiers (``enum netdev_cmd``) are running under the netdev
>  instance lock.
>  
> +The following netdev notifiers are always run under the instance lock:
> +* ``NETDEV_XDP_FEAT_CHANGE``
> +
>  For devices with locked ops, currently only the following notifiers are
>  running under the lock:
>  * ``NETDEV_CHANGE``
>  * ``NETDEV_REGISTER``
>  * ``NETDEV_UP``
> -* ``NETDEV_XDP_FEAT_CHANGE``
>  
>  The following notifiers are running without the lock:
>  * ``NETDEV_UNREGISTER``
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e6036b82ef4c..0321fd952f70 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2520,7 +2520,7 @@ struct net_device {
>  	 *	@net_shaper_hierarchy, @reg_state, @threaded
>  	 *
>  	 * Double protects:
> -	 *	@up, @moving_ns, @nd_net, @xdp_flags
> +	 *	@up, @moving_ns, @nd_net, @xdp_features
>  	 *
>  	 * Double ops protects:
>  	 *	@real_num_rx_queues, @real_num_tx_queues
> diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> index 5706835a660c..c63448b17f9e 100644
> --- a/include/net/netdev_lock.h
> +++ b/include/net/netdev_lock.h
> @@ -48,6 +48,18 @@ static inline void netdev_unlock_ops(struct net_device *dev)
>  		netdev_unlock(dev);
>  }
>  
> +static inline void netdev_lock_ops_to_full(struct net_device *dev)
> +{
> +	if (!netdev_need_ops_lock(dev))
> +		netdev_lock(dev);

Optional nit: I'm getting lost in all the helpers, I'd add the following here:

else
	netdev_ops_assert_locked(dev);

Or maybe even:

if (netdev_need_ops_lock)
	netdev_ops_assert_locked
else
	netdev_lock

To express the constraints better.

