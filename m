Return-Path: <netdev+bounces-227142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D6BA8FEB
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE141C19CF
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7102FFFB3;
	Mon, 29 Sep 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JUknS+c7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016A2FF679
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144828; cv=none; b=pPoHnpi3e73nQiooS4FxWRuSeNvSgjBuOxNm8ONYKLNR3CbBNuWqdMI3pniUw/K70icVEVr4T4qW7A8Dadyh2LVg81TTV9ZVIx3okcp2LTp5W7AEjdJfFF3v5DnDBBvmeXPovOVRYKc9wHeTHXQdG089e9LmIeUTqwBKx4XJVWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144828; c=relaxed/simple;
	bh=w3zzf49no1nO5E5KGJbfTtd6wmAu5fXUn/LEF1LCQs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HK4wtnTAzQj3Tm2g1d1S3foUKziTNnYEEDIhyzLOk9nKIhFtuqOykGtq/txXcgdTWst1rExpP8krebbTj9UvMSK7GlRg9daN/4hydD/m0nYj6w2EF0Ahy0EsZEYF6kXJM3QyfFg5bzG95GKe+R/bT5bKjzETrzNYebW6IcBiyqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JUknS+c7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso6303479a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759144823; x=1759749623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAKeiTCNObaqwVjMhqAXn7CuM0UhDBd0AumYPlZL34M=;
        b=JUknS+c7tS0x2sV9WMaSn2mXRZsvY57wkNMOlynEqpB4noM0i/R6AdQvw4u5n65TLp
         BhrM246w5xwPCAdBP7NsWM5t9MvpaER3Pz8Akv+U7OBWBRtTWyB+C4V9+nxoYtKK7xJZ
         zS5xVi5kx+FeLVVpeU/snnMoyWIcjAWPzNihQzf52GuUMBlRDvZKEJb+DrkuguJxPCj1
         pemivqFVYrVuGVJKv9Uftpk6Ajl1OPtp/QUz7HjAamtUpFsmJUw9/fV/gDKsh51ZE+rB
         E+lSDTySXtEV9PD23eig4pVCwk/7YRpZAicPjNROBd0N5fjXj4hI86S6f4Hp/EsheyAR
         84pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144823; x=1759749623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAKeiTCNObaqwVjMhqAXn7CuM0UhDBd0AumYPlZL34M=;
        b=eN1B5/PH2Nu0oz8ffjwR55zVXBKkC6xZa/KVata2irRKi0ULIDoUDTFLGBwB6UQYre
         Kforswoy/rL9JG2Lfurk5W0J9MZjPjCwf+NR7py0pKIX1OrvEjLoeDUiLkbN++RjTr7h
         ybbcv9Y5UDK1K4KtPt4f7Z6iSN7SooMccYMDVhNSiiafXbwaya4umrpeGyAoCgZACYM3
         48VWkbO8T7BMQbOM9h3anttceTEIocQfuU79oLDbgQ8Yfaacp3PAFpS0lM3q60x6uPrR
         nXkSb+e7o/H+T+vV01Aw8v9AlxxHW7XcptKL4QP9GBGXU8BNW6uHr1cobvewLkALbR9l
         PljA==
X-Forwarded-Encrypted: i=1; AJvYcCVlQ/twwVYcKQaGlZtM7nFtrWYxSO9IBy9swO87nxzhVs6uIPekkfgJ1RNiL0ClwE36Ru+vGr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyeNBoTEqPu/17o3HDljK1JYYicFYWAMbyc2pMe0PA9bC+L83V
	aiYNvQL8F9lmWiqET+TKysVT/6xL7YYOMe7CMC1epVHGPqpRAdKeWkCz8CsJa4tQhSo=
X-Gm-Gg: ASbGncvYOP8X2HzqdhCHvqNObBcKW4Gbmjjxe1xlTrI0paufeDdKbhsa2WLiBFxRN64
	xz75CQYxLdsP8Mwj//QQesyBOllJG/JcAkrB7qt5xGbGGqY/IyUo5JmkBQz97InFMv6X+H7EW1k
	7txPVXDlGeUpzZutE3PuKrJwKSLZVao5//Dr4THCa92rlXRxDPKyAJCJOhzqJQQU+nYsorE1+O4
	NOG9Es1UuLG+lam4qDevFy3H5z5gsamaVfhnYYhdDwJEQajqOnTUUfGd3YZQyvXnKkuilUClQ5+
	t6g+dmtrf19hzM2dAKO3X4VJF4Mr1qQROiG979FDQ/UBm8k9ls9kqgqVR0T1cgTOdt/ETFXtcsS
	1vPFrf30DFwPEsA7aokgM221zdlb32Z9JnxViMirYQJqzmIqZkiwj4DbvxwhoT9WeVQs=
X-Google-Smtp-Source: AGHT+IHQsAqwiD8d9Way6kv1MNaXMXYe8iXnjaMNDorxtGQiDdSd+FTBTd4k3oCMBDrEKY7uYBZryQ==
X-Received: by 2002:a05:6402:1d50:b0:62f:464a:58d8 with SMTP id 4fb4d7f45d1cf-6363516fc68mr5342213a12.3.1759144823568;
        Mon, 29 Sep 2025 04:20:23 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a1:1:4136:3ce:cdaa:75d2? ([2001:a61:13a1:1:4136:3ce:cdaa:75d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3650969sm7513792a12.19.2025.09.29.04.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:20:23 -0700 (PDT)
Message-ID: <cbd0fb96-f721-42a5-92e5-98324546e9ae@suse.com>
Date: Mon, 29 Sep 2025 13:20:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: usb: ax88179_178a: add USB device driver for
 config selection
To: yicongsrfy@163.com, michal.pecio@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: marcan@marcan.st, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, yicong@kylinos.cn
References: <20250929054246.3118527-1-yicongsrfy@163.com>
 <20250929075401.3143438-1-yicongsrfy@163.com>
 <20250929075401.3143438-3-yicongsrfy@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250929075401.3143438-3-yicongsrfy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29.09.25 09:54, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> A similar reason was raised in commit ec51fbd1b8a2 ("r8152: add USB
> device driver for config selection"):
> Linux prioritizes probing non-vendor-specific configurations.
> 
> Referring to the implementation of this patch, cfgselect is also
> used for ax88179 to override the default configuration selection.
> 
> v2: fix warning from checkpatch
> 
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> ---
>   drivers/net/usb/ax88179_178a.c | 70 ++++++++++++++++++++++++++++++++--
>   1 file changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 29cbe9ddd610..f2e86b9256dc 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -14,6 +14,7 @@
>   #include <uapi/linux/mdio.h>
>   #include <linux/mdio.h>
>   
> +#define MODULENAME "ax88179_178a"
>   #define AX88179_PHY_ID				0x03
>   #define AX_EEPROM_LEN				0x100
>   #define AX88179_EEPROM_MAGIC			0x17900b95
> @@ -1713,6 +1714,14 @@ static int ax88179_stop(struct usbnet *dev)
>   	return 0;
>   }
>   
> +static int ax88179_probe(struct usb_interface *intf, const struct usb_device_id *i)
> +{
> +	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
> +		return -ENODEV;

And here you need to work around the problem the
first patch in the series creates. The solution
in this case is to drop it.

> +
> +	return usbnet_probe(intf, i);
> +}
> +
>   static const struct driver_info ax88179_info = {
>   	.description = "ASIX AX88179 USB 3.0 Gigabit Ethernet",
>   	.bind = ax88179_bind,
> @@ -1941,9 +1950,9 @@ static const struct usb_device_id products[] = {
>   MODULE_DEVICE_TABLE(usb, products);
>   
>   static struct usb_driver ax88179_178a_driver = {
> -	.name =		"ax88179_178a",
> +	.name =		MODULENAME,
>   	.id_table =	products,
> -	.probe =	usbnet_probe,
> +	.probe =	ax88179_probe,
>   	.suspend =	ax88179_suspend,
>   	.resume =	ax88179_resume,
>   	.reset_resume =	ax88179_resume,
> @@ -1952,7 +1961,62 @@ static struct usb_driver ax88179_178a_driver = {
>   	.disable_hub_initiated_lpm = 1,
>   };
>   
> -module_usb_driver(ax88179_178a_driver);
> +static int ax88179_cfgselector_probe(struct usb_device *udev)

And this should run only if you match the device ID and the generic
class.

That is, if you want this approach at all. If this should o into
kernel space at all, it blongs into usbcore.

	Regards
		Oliver


