Return-Path: <netdev+bounces-48469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195577EE706
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F35B20A27
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21060328B6;
	Thu, 16 Nov 2023 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Zrv1b1hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF66194
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:51:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b20a48522fso1069261b3a.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700160709; x=1700765509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Feka07otm8gBV3MwxaO93orGOTOlumZJORXdeeFJsck=;
        b=Zrv1b1huE2r4UU1Vim1NldpcQnkGSOle0fjgZzxxn8wuMkaCqS7b0bsQoqwDp7HGVh
         Gx8omXajHzTH3lGVX6NIXgXdm0qDohEcRglfWepM3bmKuESNbXygPlK++SlAYDUxYvTx
         JOenezLbCYewHhsXkuI/5SEBDew5xDTCsM2vZ+cpUGMfeFpqRn3rb87IfuIrxur3GQR4
         /q2fCjA5Ypkws15yMNgMURTn5FyfyeoY9O9e2hiU5BfTMpzSU1XLkroOzyabHeCCT0ZH
         FRYD4XufO512TKMIFjN0QyPedbe8mu8zp2GTmoi2XrqkGvyF3cv35mLIE5lxnNo11Sad
         EmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160709; x=1700765509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Feka07otm8gBV3MwxaO93orGOTOlumZJORXdeeFJsck=;
        b=EwnTaTWaw4SmHMFpOa8ruvrH8KSUlYjrFzcerV/5/ESrmSYDJi5PawN2Mpozxk1fAf
         ZPqOF9HDVQi+5LRZYswNv9uOjmbxyz7HEs1gT5eXpWArmNWEyMnTCzhV0aRQ9EEa7i0M
         J3xiPOU3a0o6KX+Kz1SrJgTYYm2E0Grhov83QFMB/YiCesnqWzcEhMNqfBaUarWp0p4g
         5nE2MuLAV2H0bEMtPGs6lSAYAVAzEsOxZZuYcDpjiC2lVqlhBJunZx6tHXrvRlVQ7Tf7
         30Ofll7WPtg/gI/nBT9lKAuKq2IjB2ZPWLVhHKVD0v8pGIvNh3VIz+nWB3xDibsLpOTl
         Nflw==
X-Gm-Message-State: AOJu0YwC79eeCtS324ycxqQCckkrXeOnv0Mp6kqNCpe7U0ZZtGypSCj7
	qlx7vtqfcaXtcZA2fhp5ahJ6bw==
X-Google-Smtp-Source: AGHT+IFn2mWUf3E7eHswTbmctQUxOICjngvCeGEjuBq9ae55874vAOd2lcSHKxtCXcXKC/19SyOe7A==
X-Received: by 2002:a05:6a21:1a0:b0:187:dadd:7e9d with SMTP id le32-20020a056a2101a000b00187dadd7e9dmr1860981pzb.10.1700160708629;
        Thu, 16 Nov 2023 10:51:48 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a000a8900b006c7c6ae3755sm60516pfl.80.2023.11.16.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:51:48 -0800 (PST)
Date: Thu, 16 Nov 2023 10:51:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: bjorn@mork.no, netdev@vger.kernel.org
Subject: Re: [RFC] usbnet: assign unique random MAC
Message-ID: <20231116105146.50d2ae66@hermes.local>
In-Reply-To: <20231116140616.4848-1-oneukum@suse.com>
References: <20231116140616.4848-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 15:05:52 +0100
Oliver Neukum <oneukum@suse.com> wrote:

> The old method had the bug of issuing the same
> random MAC over and over even to every device.
> This bug is as old as the driver.
> 
> This new method generates each device whose minidriver
> does not provide its own MAC its own unique random
> MAC.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/usbnet.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 2d14b0d78541..37e3bb2170bc 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -61,9 +61,6 @@
>  
>  /*-------------------------------------------------------------------------*/
>  
> -// randomly generated ethernet address
> -static u8	node_id [ETH_ALEN];
> -
>  /* use ethtool to change the level for any given device */
>  static int msg_level = -1;
>  module_param (msg_level, int, 0);
> @@ -1731,7 +1728,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  
>  	dev->net = net;
>  	strscpy(net->name, "usb%d", sizeof(net->name));
> -	eth_hw_addr_set(net, node_id);
>  
>  	/* rx and tx sides can use different message sizes;
>  	 * bind() should set rx_urb_size in that case.
> @@ -1805,9 +1801,13 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  		goto out4;
>  	}
>  
> -	/* let userspace know we have a random address */
> -	if (ether_addr_equal(net->dev_addr, node_id))
> -		net->addr_assign_type = NET_ADDR_RANDOM;
> +	/*
> +	 * if the device does not come with a MAC
> +	 * we ask the network core to generate us one
> +	 * and flag the device accordingly
> +	 */
> +	if (!is_valid_ether_addr(net->dev_addr))
> +			eth_hw_addr_random(net);
>  
>  	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
>  		SET_NETDEV_DEVTYPE(net, &wlan_type);
> @@ -2217,7 +2217,6 @@ static int __init usbnet_init(void)
>  	BUILD_BUG_ON(
>  		sizeof_field(struct sk_buff, cb) < sizeof(struct skb_data));
>  
> -	eth_random_addr(node_id);
>  	return 0;
>  }
>  module_init(usbnet_init);

The code part looks fine. Fix the style issues though.

 $ ./scripts/checkpatch.pl /tmp/mac.mbox 
WARNING: networking block comments don't use an empty /* line, use /* Comment...
#163: FILE: drivers/net/usb/usbnet.c:1805:
+	/*
+	 * if the device does not come with a MAC

WARNING: suspect code indent for conditional statements (8, 24)
#167: FILE: drivers/net/usb/usbnet.c:1809:
+	if (!is_valid_ether_addr(net->dev_addr))
+			eth_hw_addr_random(net);

total: 0 errors, 2 warnings, 0 checks, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/tmp/mac.mbox has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


