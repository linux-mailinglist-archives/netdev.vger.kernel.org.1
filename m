Return-Path: <netdev+bounces-250751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DED391B1
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584DF301672B
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 23:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FDA2DA75B;
	Sat, 17 Jan 2026 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1bvz8OR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55290296BA5;
	Sat, 17 Jan 2026 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768692885; cv=none; b=VYiwN/TE0mckl7iXaxn6f6TaHGzuW6T1wacuqk2RT7KM73DhypAC+E3GfQ+skMzJBpDt/qbIaGWYMP82yxDkttJo8L3kGKU7yXyZnfikRXg4CzCsGKcwn8EinV0incW/nmIs/Zr8dOvQoBXc4iIZNtz4EjB5wUStbDdhOBJXD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768692885; c=relaxed/simple;
	bh=L3qGLyR9SwRXy+ntZI7bmJgcUvoZEy9ebV7TH9Lw11g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXw+/k1U8+84+RoKRGAc3WHDqbFeORWvaBS9gL4wsieThyY6dVGAVYD7yZigdVpx055nyVGMA0+ZX9FZgoyR2OuqknFHoU2eV3YoZ3/R5wjL6e5/L1Im0iju8JEVd0gorsKwYpM5JZgiATokXKgLdRDoggVbgbflnAlcGJ6TSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1bvz8OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87FDC4CEF7;
	Sat, 17 Jan 2026 23:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768692885;
	bh=L3qGLyR9SwRXy+ntZI7bmJgcUvoZEy9ebV7TH9Lw11g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1bvz8ORYARRRgHCgHZDp3ZJ4iDul4pNQsfi3A3Wi3F3ckP+KtoK+fDQPdQPYe8pD
	 7Nr+onPw8XqhGhEWW3Cnqd90WOcqlzXSbRa1t4DCKYo1epHqcwJurze5Uur8jeWQth
	 pD7z+s5gxivAuM6AjdidIzqx24nBm82OOH4zjao1XQdhEKobPRRJGQ+jh641huoP/V
	 1T0oP3q11HzwV5vnPmWJTpXWYvXsz8/i19zq6EqBT/xHuXF4VEyUhoN7LIFa/0ESJc
	 vmYiXacPKNTRdGgmOlSbrYo9NFxLtgP9FA+ahLISOJNpPIW6+yyDDRR1CpTpFyWL+k
	 vlS9NYnZ2zlMQ==
Date: Sat, 17 Jan 2026 15:34:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Oliver Neukum
 <oneukum@suse.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usbnet: limit max_mtu based on device's hard_mtu
Message-ID: <20260117153443.6997a8f0@kernel.org>
In-Reply-To: <20260114090317.3214026-1-lvivier@redhat.com>
References: <20260114090317.3214026-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 10:03:17 +0100 Laurent Vivier wrote:
> The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before calling
> the device's bind() callback. When the bind() callback sets
> dev->hard_mtu based the device's actual capability (from CDC Ethernet's
> wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
> hardware limitation).
> 
> This allows userspace (DHCP or IPv6 RA) to configure MTU larger than the
> device can handle, leading to silent packet drops when the backend sends
> packet exceeding the device's buffer size.
> 
> Fix this by limiting net->max_mtu to the device's hard_mtu after the
> bind callback returns.

Change looks good, please add Stefano's tags, a Fixes tag pointing at
the oldest commit in the git history where this user-visible issue can
be reproduced (use the first tag in git history if necessary), and
resend. Please mark the commit as [PATCH net v2] when resending.
Start a new thread (don't reply to this one). And one more thing..

> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 36742e64cff7..8dbbeb8ce3f8 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1821,9 +1821,14 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
>  		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
>  			net->flags |= IFF_NOARP;
>  
> -		/* maybe the remote can't receive an Ethernet MTU */
> -		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
> -			net->mtu = dev->hard_mtu - net->hard_header_len;
> +		/* limit max_mtu to the device's hard_mtu */

please remove these comments, we can read the code

> +		if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
> +			net->max_mtu = dev->hard_mtu - net->hard_header_len;
> +
> +		/* limit mtu to max_mtu */

and this one

> +		if (net->mtu > net->max_mtu)
> +			net->mtu = net->max_mtu;
-- 
pw-bot: cr

