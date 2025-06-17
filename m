Return-Path: <netdev+bounces-198833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6675ADDF92
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D5189C96B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F72980A5;
	Tue, 17 Jun 2025 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwq6pGBS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDE296153;
	Tue, 17 Jun 2025 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202536; cv=none; b=EoQ7tyNGwLdNp05diqdJyduf7e1ivbO4V6F3oEwtD8ISzqEZyucrtiHLHDS7EECPbTNZXw3m5NS3IPOZZ+SRq8IN6pgoCGMBtCMqAXGZnvQ3ZsDuKyYFUlCNqQJDy7+8zr1tW0OZQ6CyHWNFrq0VS9QLm63q1NwNiNPIvUOFbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202536; c=relaxed/simple;
	bh=NjwTBIJNWdaAO3rdV1mrracyLIkoRvYZKQnvZdhwQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oERTF/ip8Z1R/os/RX1oZM5FdIe22qKV+FxbLGpyvNUuGu6NfsDscIokzSm3gH4rUONnoUpwA3nR0CiTrmswj9K5zJnwsSR6klzUZOIEzcbaJozVGtnOMO6w8oylC08Ow4C5nCFukaoI7L/+TvGDGWa6TLX0Ck6W0DMzBbSK0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwq6pGBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656DEC4CEE3;
	Tue, 17 Jun 2025 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202534;
	bh=NjwTBIJNWdaAO3rdV1mrracyLIkoRvYZKQnvZdhwQTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dwq6pGBSN1yObu0KYQzgsgOSuGP99/j84eB92CGU8NKTBtoHy8R4fnd7/UFQaKMK0
	 iZJZ7wG/vnybEtrPUxVe+SE9zHcvZhUSzyCb2nY/HaT5Mdz5Y80P2guNMlMA4vme3T
	 xjwuRGtIb30VkONf3UYfs/bm3wJECAka37fzJXOv23Km6Q9+bPiWRwSBtdP3p8zqBp
	 KizUaXr3Rveb0xN9IEZ6usmD67/VyP7h/mzEzaz7WM0YHpmRw1x113Pc2tdUcDysMU
	 AwojGV92r6uoQnZYEoMOiWbDkC6U7CIy04i6I0qJ3tcXU/vQxocAH0mRu5zzs6TwZa
	 4tlPfe9Vv6KVg==
Date: Tue, 17 Jun 2025 16:22:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jun Miao <jun.miao@intel.com>
Cc: sbhatta@marvell.com, oneukum@suse.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 qiang.zhang@linux.dev
Subject: Re: [PATCH v4] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Message-ID: <20250617162213.45d693a8@kernel.org>
In-Reply-To: <20250615015315.2535159-1-jun.miao@intel.com>
References: <20250615015315.2535159-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Jun 2025 09:53:15 +0800 Jun Miao wrote:
> -static void usbnet_bh_tasklet(struct tasklet_struct *t)
> +static void usbnet_bh_workqueue(struct work_struct *work)
>  {
> -	struct usbnet *dev = from_tasklet(dev, t, bh);
> +	struct usbnet *dev = from_work(dev, work, bh_work);
> 
>  	usbnet_bh(&dev->delay);
>  }
> @@ -1742,7 +1742,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  	skb_queue_head_init (&dev->txq);
>  	skb_queue_head_init (&dev->done);
>  	skb_queue_head_init(&dev->rxq_pause);
> -	tasklet_setup(&dev->bh, usbnet_bh_tasklet);
> +	INIT_WORK(&dev->bh_work, usbnet_bh_workqueue);

workqueue is the queue, here we're talking about the work entry.
And we use the system workqueue to schedule on (system_bh_wq)
Please replace the workqueue with work here and in the comments

