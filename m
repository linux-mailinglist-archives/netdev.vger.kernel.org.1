Return-Path: <netdev+bounces-235529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D7C3212D
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 17:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C95F3B67AB
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782A23321C6;
	Tue,  4 Nov 2025 16:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FA330B24
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273675; cv=none; b=V4+fUIZF6ZyEHRvW3PzQXmS1dlx76brH8OEOn2L2HO6ru+SocitYzAweSE5P9oRA1fjcgM+Ni8Pu5FDPdRmAn+sYYmY3UoRlTHv5vyCBPoNaS5Cg7zG0eoBK3vDW2Fphcoq7JQp07wQ1yUj54XtapNvsMeFBeLwT2kUthkgQBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273675; c=relaxed/simple;
	bh=rh2lWV34KDk8L2xt7JXyJ/rO5Inbz9JZ2V92xmmCRb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=TIya+D3jTb9nlOGcbq6fqoLGeGRtLtO5s0RcLVjhrTz35VjOOq9kfJ2jJuTNqTdtYX9mTy9S8Pnv8IrmX6F72tKxThhMzNx1n2Ww+CdOmAyn8mQ14qq7RlwT6h0dYyt/fcBppx9gN8ZjIiIZk0pfX+TRPKet58kf1x7baD44t6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4330ead8432so40737445ab.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 08:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273673; x=1762878473;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsofqJmUaMgTct6YpLJp1MyERIRZzBUMW6tsSHt2Ig4=;
        b=wJWusMwemJJMLjrk1l2hspf8D8NMBWTewQGrJ5W2fHvTN3oU2s3tHU4jSmFuEM9uVF
         9WZSJT/x1Fel9/IhMNs+3CVFJeNxwuYx12GLAQLV80HECAB6pOmoQJXMFR3fFrHk/PSm
         2ZHbC51HXnOXkTnYp7/go/cdvv5VcG/7EJEr3pcwazi8TVCM1oJnK8iAepAtWX/N60OZ
         q+Gf9xOJB/3ScXLioWsdE8ki8SNLaZx/B5t1eNpcAczwyJPMmVmSJRZQYPbB9YEyVBxC
         ob74528Ptk1abiwP0I4lcLn3ICJrUS0JR/7z5AdQMrPQZT2cnyY5FdIQAfr9bidu2T/M
         Ivhg==
X-Forwarded-Encrypted: i=1; AJvYcCUcokM45KXjYRLDvicgdH6xsDAraysc9NYQph5Rt9MBL5dXvNdFb17qjs9zfv/UJveSY0WI3S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKs82tiSZZEHvjzdPsEuuaqUwQH5EbgzMiAfj9jzEiO0+QBTI
	0H4CHujuXIP+QZVW203k70tCR4xQI5qqB+cRRSV5LmxTAqxEjRpaenMSGPyvRKv1sf1+bQNMHnF
	lNF/EZy22NqdKPW1BQVt6bhgWR/TryOk0m6TyFvZVDv5xjvI3+TfI5SCDSwo=
X-Google-Smtp-Source: AGHT+IHgcClEyHA1apIzVM9TvkX++hlv+rXbXCdNgm+5HRZbckiVCpbwGOItsL4/yxVl3p7QGhO35jfuk3h2EydWBieT7JMcTf8O
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:433:2fcd:e6ec with SMTP id
 e9e14a558f8ab-4332fcde930mr94696055ab.8.1762273672907; Tue, 04 Nov 2025
 08:27:52 -0800 (PST)
Date: Tue, 04 Nov 2025 08:27:52 -0800
In-Reply-To: <20251104162717.17785-1-dharanitharan725@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a2988.050a0220.98a6.00b3.GAE@google.com>
Subject: Re: [PATCH] [PATCH] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: dharanitharan725@gmail.com
Cc: davem@davemloft.net, dharanitharan725@gmail.com, edumazet@google.com, 
	gregkh@linuxfoundation.org, kuba@kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

> KMSAN reported an uninitialized value use in rtl8150_open().
> Initialize rx_skb->data and intr_buff before submitting URBs to
> ensure memory is in a defined state.
>
> Reported-by: syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
> ---
>  drivers/net/usb/rtl8150.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 278e6cb6f4d9..f1a868f0032e 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -719,14 +719,15 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
>  
>  static void set_carrier(struct net_device *netdev)
>  {
> -	rtl8150_t *dev = netdev_priv(netdev);
> -	short tmp;
> +    rtl8150_t *dev = netdev_priv(netdev);
> +    short tmp;
>  
> -	get_registers(dev, CSCR, 2, &tmp);
> -	if (tmp & CSCR_LINK_STATUS)
> -		netif_carrier_on(netdev);
> -	else
> -		netif_carrier_off(netdev);
> +    /* Only use tmp if get_registers() succeeds */
> +    if (!get_registers(dev, CSCR, 2, &tmp) &&
> +        (tmp & CSCR_LINK_STATUS))
> +        netif_carrier_on(netdev);
> +    else
> +        netif_carrier_off(netdev);
>  }
>  
>  static int rtl8150_open(struct net_device *netdev)
> @@ -741,6 +742,10 @@ static int rtl8150_open(struct net_device *netdev)
>  
>  	set_registers(dev, IDR, 6, netdev->dev_addr);
>  
> +	/* Fix: initialize memory before using it (KMSAN uninit-value) */
> +	memset(dev->rx_skb->data, 0, RTL8150_MTU);
> +	memset(dev->intr_buff, 0, INTBUFSIZE);
> +
>  	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
>  		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);
>  	if ((res = usb_submit_urb(dev->rx_urb, GFP_KERNEL))) {
> @@ -749,6 +754,7 @@ static int rtl8150_open(struct net_device *netdev)
>  		dev_warn(&netdev->dev, "rx_urb submit failed: %d\n", res);
>  		return res;
>  	}
> +
>  	usb_fill_int_urb(dev->intr_urb, dev->udev, usb_rcvintpipe(dev->udev, 3),
>  		     dev->intr_buff, INTBUFSIZE, intr_callback,
>  		     dev, dev->intr_interval);
> @@ -759,6 +765,7 @@ static int rtl8150_open(struct net_device *netdev)
>  		usb_kill_urb(dev->rx_urb);
>  		return res;
>  	}
> +
>  	enable_net_traffic(dev);
>  	set_carrier(netdev);
>  	netif_start_queue(netdev);
> -- 
> 2.43.0
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


