Return-Path: <netdev+bounces-207899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B02B08F76
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AA81C425B2
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB292F85D6;
	Thu, 17 Jul 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJMdgrzd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5172F6F9A
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762593; cv=none; b=itwduFYwM4O7CoxT+cIEZN44w4VvsIMqyY0DZJ/gIFYeYz+nY+Z8XqXTbH4Vo7DpRDxMhoQMI45fIOQGtyoE9X5Ic1Lzy9uGLuHQWm1BDF6bqu4ROD7BH4Mg5ZFwx/mM2AQpfH0zOHjWesO9u0f6P80vP14N+qppNzFtkBfPsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762593; c=relaxed/simple;
	bh=MQ/V5O4gwMWWZiiQWgLcEa/uMk6GSBagVIe6VFDIR+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkL/XQmAh7PKgjdSALr1oeRh+U0lXSAWZDii6tIjXihXyc1L2L/6YCjSNDDfe/aGQHZK0xPtVhRAvzp2QGSTQaRAbZnRFhZ9XepLkGzVtT5gzbVX5iJ0tHnIhachY7rcaeVZpccKqlYgXqzPy0+Spn0ql+U3d38AO2aG1lfrghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJMdgrzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C995EC4CEE3;
	Thu, 17 Jul 2025 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752762593;
	bh=MQ/V5O4gwMWWZiiQWgLcEa/uMk6GSBagVIe6VFDIR+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJMdgrzdPS6k5SSgLA/r1SRqj1i6h5d7PqoiQUFITVAd3zPcn9PJIRhansB5qZM7O
	 XhGSOQmmvOPVBf5+y+ZEzB4jAs8q8mBWeSWxPfTjCB9Vt+1+G0zolH13b8ud0Mpzym
	 ZoV0ogSgcCMfmE/QF0nUDyckbpJeOyZI6HGuyzr0wmy8UaED6TXgi1QuGtvKN6r0gW
	 6/P7Gunt4DRCpp3pZ89PZNX8NR+orine35v7uFeqg4kM4a+Gw6kdHDEXOh01TPc4KB
	 EJMQocNLv7PaKhxPCsRIe+Nh95dItvNJ4rZQvaPS4LohIos9L4XyNaHJByyBZJXrEg
	 4Ce6yRvOPyZPw==
Date: Thu, 17 Jul 2025 07:29:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Anthoine Bourgeois" <anthoine.bourgeois@vates.tech>
Cc: "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini"
 <sstabellini@kernel.org>, "Oleksandr Tyshchenko"
 <oleksandr_tyshchenko@epam.com>, "Wei Liu" <wei.liu@kernel.org>, "Paul
 Durrant" <paul@xen.org>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, "Elliott Mitchell" <ehem+xen@m5p.com>
Subject: Re: [PATCH v2] xen/netfront: Fix TX response spurious interrupts
Message-ID: <20250717072951.3bc2122c@kernel.org>
In-Reply-To: <20250715160902.578844-2-anthoine.bourgeois@vates.tech>
References: <20250715160902.578844-2-anthoine.bourgeois@vates.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 16:11:29 +0000 Anthoine Bourgeois wrote:
> Fixes: b27d47950e48 ("xen/netfront: harden netfront against event channel storms")

Not entirely sure who you expect to apply this patch, but if networking
then I wouldn't classify this is a fix. The "regression" happened 4
years ago. And this patch doesn't seem to be tuning the logic added by
the cited commit. I think this is an optimization, -next material, and
therefore there should be no Fixes tag here. You can refer to the commit
without the tag.

> @@ -849,9 +847,6 @@ static netdev_tx_t xennet_start_xmit(struct sk_buff *skb, struct net_device *dev
>  	tx_stats->packets++;
>  	u64_stats_update_end(&tx_stats->syncp);
>  
> -	/* Note: It is not safe to access skb after xennet_tx_buf_gc()! */
> -	xennet_tx_buf_gc(queue);
> -
>  	if (!netfront_tx_slot_available(queue))
>  		netif_tx_stop_queue(netdev_get_tx_queue(dev, queue->id));

I thought normally reaping completions from the Tx path is done
to prevent the queue from filling up, when the device-generated
completions are slow or the queue is short. I say "normally" but
this is relatively a uncommon thing to do in networking.
Maybe it's my lack of Xen knowledge but it would be good to add to
the commit message why these calls where here in the first place.
-- 
pw-bot: cr

