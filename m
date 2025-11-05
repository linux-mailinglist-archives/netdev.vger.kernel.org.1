Return-Path: <netdev+bounces-235970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C056C3788E
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7DCA343D21
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB18343D7C;
	Wed,  5 Nov 2025 19:47:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0B30F811
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372057; cv=none; b=c5RgjjuikU8AOGaSDn6GM+SYHmj0ts1ALuIrCZGkFvkRIWwWi3cuKKmu5UBYOXxm3OoxsjF/QibrR/LfoYZP1Y/UvDNSyM499RyVLtFXqh81yrho4RvgqOi7hJUhrpezfaNpmdjzMK38CCEysnKegfBlWf1jTawtFiJw8IleGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372057; c=relaxed/simple;
	bh=SJQO4hIxsRCYiVDcoVyAbR8KyR2iixH5QaHzpc66s2c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=DKIXA6at3oJz4TJWgOMbfwh44JVpiP+S8q34Q0zeNTKdMEDvxwwbmolLBpkEZgUV9yiPFuqylpBbRa7LCTW29FXLupM78Ms1weG9jmQtCoqdkTlLuo5ZBG0hTXFQgTaCMoZrKPQJselXltzM8y+ph8soIB7lfQWsoqIbDoIzGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9486920a552so40922239f.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 11:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372055; x=1762976855;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZREwB+uSgNfDdjL7IMLbs9MbKHhqaZxa3nTlkJ4e/1c=;
        b=StPjTQ1FwPF4sdnbGXLJXbW9Y5H8tzdBl5chZpDjUAbmDyogG/gYN0bjJQ0T7AP1ad
         3dNG1Mkhtbp3+o/QfK8QCkfxYcLdqfjJwhys+jZ0PifgYgsAVDKO4SNVihESVy6sX62O
         TeZ1wrzaYwa3JVmBbDVPHNiCnSm59EjBGRvJQ6nzjrfqmrQZWOu4XU9aQTiUOpC2CtKE
         SBnR/kX6djSVZ0xlOA6UQM1eG/jX0O0Xh9se1Ex9qVU4UuRVrR9Lw1uKwBwLbQCFr/6Q
         KYonYNs0SDmtjKijStSkHrxmOqxpI4CMxSqVXZoiVHPfy+V92HU370c6aEsfL2hd8m8A
         1wOA==
X-Forwarded-Encrypted: i=1; AJvYcCW4D8sU8sLfDSr7Ha1u9W6m0WoAB3YJ7HeXVxjYX5MCQZNLbKmuYUIiFZki03+jBtcWG52WM0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42Uhs0jWKJniBZ4BU0yvvoMv51RR2YvzalYtsSeKuhbASYDAg
	TdX6rJcwYwO70HgRPjh62TGbP6m/OqdczxjQeGbCyAAd4Pn6ElgYEFWq5Yw+v/Y1ZX/2UyTBp8y
	702Jd4jPWfiJdXiFysffj/OJDG6GLuuWLXkgXH8QPXrtYcygzILy7bvvRsq4=
X-Google-Smtp-Source: AGHT+IFWg9xCIhWhh/UffqZFvsTK8HvYAuVYNf/CzDs8Ehals4ZHS8FEROYlIGAsw5au1Wi7rSGH35k4i0NI8t7PaS+LpbUS/zEQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:433:217a:a25c with SMTP id
 e9e14a558f8ab-433407ccc86mr59934055ab.28.1762372055487; Wed, 05 Nov 2025
 11:47:35 -0800 (PST)
Date: Wed, 05 Nov 2025 11:47:35 -0800
In-Reply-To: <20251105194705.2123-1-dharanitharan725@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ba9d7.050a0220.baf87.0063.GAE@google.com>
Subject: Re: [PATCH v2] usb: rtl8150: Initialize buffers to fix KMSAN
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
> Changes in v2:
>  - Fixed whitespace and indentation (checkpatch clean)
>  - Corrected syzbot tag
>
> Reported-by: syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
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
>  		dev_warn(&netdev->dev, "rx_urb submit failed: %d\n", res);
>  		return res;
>  	}
>  
> -	usb_fill_int_urb(dev->intr_urb, dev->udev, usb_rcvintpipe(dev->udev, 3),
> -		     dev->intr_buff, INTBUFSIZE, intr_callback,
> -		     dev, dev->intr_interval);
> -	if ((res = usb_submit_urb(dev->intr_urb, GFP_KERNEL))) {
> -		if (res == -ENODEV)
> -			netif_device_detach(dev->netdev);
> -		dev_warn(&netdev->dev, "intr_urb submit failed: %d\n", res);
> +	usb_fill_int_urb(dev->intr_urb, dev->udev,
> +			 usb_rcvintpipe(dev->udev, 3),
> +			 dev->intr_buff, INTBUFSIZE,
> +			 intr_callback, dev, dev->intr_interval);
> +
> +	res = usb_submit_urb(dev->intr_urb, GFP_KERNEL);
> +	if (res) {
>  		usb_kill_urb(dev->rx_urb);
>  		return res;
>  	}
> @@ -769,8 +766,7 @@ static int rtl8150_open(struct net_device *netdev)
>  	enable_net_traffic(dev);
>  	set_carrier(netdev);
>  	netif_start_queue(netdev);
> -
> -	return res;
> +	return 0;
>  }
>  
>  static int rtl8150_close(struct net_device *netdev)
> -- 
> 2.43.0
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


