Return-Path: <netdev+bounces-57717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA8813F9C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E100B1F21076
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA87FC;
	Fri, 15 Dec 2023 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzr7Tp2D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87E7EA
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC35C433C8;
	Fri, 15 Dec 2023 02:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702606290;
	bh=gSlmGvXM7l3usEJEqGEgLaxe+8FR8knxzpms6VTa6JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zzr7Tp2D62n7lK7uX67SV+L29ZquMUZ1OddGbCy1WuAGxQzL9QCSnNgmbGvvIteez
	 4dmf6mfuAQO20ug44VL6IKvqgue4V8GZIlqnf9ip5wr0LODls4WiMX7+6tTRuYgBdp
	 J3DaSkvYzxJcjO2cDFmHlkIDlD0JNV07/RFD72Z18dlrZkVNSqSilhR4saSA1Bfzjw
	 oaJBdZ0KCzTgzweiAyMyuaxTtI9wgMjd+CNQ4SirBrOOBxtQBX254bQ/I/KM7mCp5H
	 dcvIkulWD7tcsttNuZL9/Xe490kP978uKPhy17M2Ex3EEforbfA/jXQ0eLWS+RzoPq
	 9WzR83k5H3mBQ==
Date: Thu, 14 Dec 2023 18:11:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 john.fastabend@gmail.com, daniel@iogearbox.net
Subject: Re: [PATCH v21 04/20] net/tls,core: export get_netdev_for_sock
Message-ID: <20231214181128.63793cdc@kernel.org>
In-Reply-To: <20231214132623.119227-5-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
	<20231214132623.119227-5-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 13:26:07 +0000 Aurelien Aptel wrote:
> -struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
> -					    struct sock *sk)
> +struct net_device *get_netdev_for_sock(struct sock *sk)
>  {
> -	struct net_device *lower;
> +	struct dst_entry *dst = sk_dst_get(sk);
> +	struct net_device *dev, *lower;
>  
> -	lower = netdev_sk_get_lower_dev(dev, sk);
> -	while (lower) {
> +	if (unlikely(!dst))
> +		return NULL;
> +	dev = dst->dev;
> +	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
>  		dev = lower;
> -		lower = netdev_sk_get_lower_dev(dev, sk);
> -	}
> -
> +	dev_hold(dev);
> +	dst_release(dst);
>  	return dev;
>  }
> -EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
> +EXPORT_SYMBOL_GPL(get_netdev_for_sock);

Since the use of this helper is now spreading we should
switch it to netdev_hold and have the caller pass in a
netdevice_tracker.

