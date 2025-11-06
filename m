Return-Path: <netdev+bounces-236175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BFC39594
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 08:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC7BD4EFD1D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 07:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE62DC79A;
	Thu,  6 Nov 2025 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iocn27If"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8D2D9499;
	Thu,  6 Nov 2025 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413001; cv=none; b=akgE7QcixQ9/aZJ4H/e73IH9r0zDcrcLmv6U5jG1KfOhmtkbm8H0tmEs6qswkAuTTu8zX0E6x9SmST+3LIrhilknD1A6aYttnYU9s6jaOJ3WBuLEKV7l684Z75zgUJxnZ87pdhLv90mLRmW0uxJh3Moc+FWwroK6JkqN5lT00NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413001; c=relaxed/simple;
	bh=rBIfJSngJ9orsQEH1xVdvfU+nrQU5UVtACGdQta/G6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAuM35gztCghZaEpmwMgq4udg2aRuW4YbcfkCAtUwiqkSpVJ73qQ/IOSJReb5EC6+FRRLDkEAiXZkBExMXsGe5VFL+/iyu+ukJvPdrfTpsXQI2iIM3FNyWbJZQq4JmSkYcTdcpUrFdfQvzX8L2fe0bn+31tzn+1rXP6sDBDi8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iocn27If; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40B8C4CEFB;
	Thu,  6 Nov 2025 07:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762413000;
	bh=rBIfJSngJ9orsQEH1xVdvfU+nrQU5UVtACGdQta/G6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iocn27IfFqJslFhkl8X2y1upkHakpaPhQ1ybg8FwE+CHZxvz4liIVf/SrrAZtQbJN
	 5Vt2jPTVn2o1LaGOnzRPxjidXU81Uty8KU8Qg69bfJBqDolkkL+3p/7pUSMInKkJfF
	 Z+N7EHKwqqgLt3uBNITitMkMWqQLtSn4IG7JhZ9s=
Date: Thu, 6 Nov 2025 16:09:58 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
Message-ID: <2025110612-lint-eggnog-590b@gregkh>
References: <20251105195626.4285-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105195626.4285-1-dharanitharan725@gmail.com>

On Wed, Nov 05, 2025 at 07:56:26PM +0000, Dharanitharan R wrote:
> KMSAN reported an uninitialized value use in rtl8150_open().
> Initialize rx_skb->data and intr_buff before submitting URBs to
> ensure memory is in a defined state.
> 
> Changes in v3:
>  - Fixed whitespace and indentation (checkpatch clean)
>  - Corrected syzbot tag
>  - Corrected syzbot hash and tag

Please follow the documentation for where to put this version
information.

> Reported-by: syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
> ---
>  drivers/net/usb/rtl8150.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index f1a868f0032e..a7116d03c3d3 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -735,33 +735,30 @@ static int rtl8150_open(struct net_device *netdev)
>  	rtl8150_t *dev = netdev_priv(netdev);
>  	int res;
>  
> -	if (dev->rx_skb == NULL)
> -		dev->rx_skb = pull_skb(dev);
> -	if (!dev->rx_skb)
> -		return -ENOMEM;

It looks like you are attempting to break existing situations?


> -
>  	set_registers(dev, IDR, 6, netdev->dev_addr);
>  
>  	/* Fix: initialize memory before using it (KMSAN uninit-value) */
>  	memset(dev->rx_skb->data, 0, RTL8150_MTU);
>  	memset(dev->intr_buff, 0, INTBUFSIZE);
>  
> -	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
> -		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);
> -	if ((res = usb_submit_urb(dev->rx_urb, GFP_KERNEL))) {
> -		if (res == -ENODEV)
> -			netif_device_detach(dev->netdev);
> +	usb_fill_bulk_urb(dev->rx_urb, dev->udev,
> +			  usb_rcvbulkpipe(dev->udev, 1),
> +			  dev->rx_skb->data, RTL8150_MTU,
> +			  read_bulk_callback, dev);
> +
> +	res = usb_submit_urb(dev->rx_urb, GFP_KERNEL);
> +	if (res) {

Why did you break the -ENODEV situation?

How was this tested?

greg k-h

