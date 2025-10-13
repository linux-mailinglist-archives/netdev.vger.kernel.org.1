Return-Path: <netdev+bounces-228685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C6BD2345
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 353A14E7D58
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989B82FBDE9;
	Mon, 13 Oct 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZp7N3EF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F242F99A3
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346482; cv=none; b=ZL7NH0k3x7iposEmIarCVFeuLM8U8t71Vrew9BqfnnL8A3iZ5TWl+oRQa/Y3cVpieUqDaENjlAl1uDLrw7bQQRrKz98qjIw92LS6yzru+L+Vw3uO6eGEMvgfA93HWoI3BrHq6NAchLdlSu7yYa5XaIpjlf/7EhcbJag06ms3K4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346482; c=relaxed/simple;
	bh=8//V7stYSb/ZcMHYYxRWyffozcLomDJYC12ClHhkNrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmSOcdyZJ48VCfeu/hh4rp/4ekBNX0v3kS5WiCyUMU9i0av0B2/HwERnO48fkiXtrpEIFdo0t0qINqvtYTOIFHbAmVoM9QINuKZki2xDRxeOlJuABh5Fb6H/gD5vqhg7dMPH00gZ58foGUjTIIwsdmiifSBsoFITOAsQxD7/LIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZp7N3EF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso7410883a12.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760346478; x=1760951278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzlpxZqbyALDR3rt0SQ7Rqb+QihBOTYCYyezgUugnDk=;
        b=kZp7N3EFVMENudkUaIFECU+8PDiM63RJUCjyNRwiyewSAZ9nVjF2+fxlzzSYPi2PDh
         151C0g6MSH3gcEDOVGM2njOIIal9l3YjSf4wHrTlaaI+MTeQIGvVrP3DS0+SSY7k/K6x
         LD7dSVUowlzwFojA+s8utXWY8LbLdCAArIbvv/4iHosMVRYHoeVtaWUH3ohniechyick
         D3Hxbu+dfRyovTY2FocP/Lw2dEVGGRxAdD/wcnL2dcU8DSL1iss8RnJ0X8p3BzYYs5yv
         0u5i1mTxR2zZt34rrJItruif9c66JmAYS+GNap4kXcGF5S6KyT1gaw1dfH6XudDvouGm
         o2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346478; x=1760951278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzlpxZqbyALDR3rt0SQ7Rqb+QihBOTYCYyezgUugnDk=;
        b=aELKOC84+KxSXPJQZZTfQRTsRufwCvL/VV5ZPpVIHaUMq3yDP2Y5+Zk1Qn55D3R1Eh
         I5nfKxMHtgo1caShW5C4LxJ26IL3z+uRFjCXNtglVEx9LWrKQVE1xlKNZXLvwrxqV61U
         HRfNR9C2sgPQck3wPq4KqJXTfXEjMXSHSTW2cEuRrkqyUZIDREiXwfE/MB08Hmbdt9Th
         EZDw2r7QC9uolbpozVKPZxTvv8x+dIS143mqyJjkJ67p7zuVih29RXvHuM0JAuXwb60p
         q3d1fNh/SGD2xEtEougB6/cgCL+zMFJv20aRivrOdKJ8Ngx6TUuMDcIL6wfmfEyJy6l6
         HWfA==
X-Forwarded-Encrypted: i=1; AJvYcCVX+JLeu/RTptjid6CvTC9Ua7e41sCxyeP6iExDKrUkX2Hk+56c6DTbzJfZJQZXZFf481WgENU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+R4XubdwOnebCnnbiFLBg8/3SqkEkbiQVdROjorxeF37oQcji
	Xti6KMaim91ImZpFR4OFQUeemyqxvQjc6rj/0IQwMKRC9eH5pqhaU8RpU9meqVa6
X-Gm-Gg: ASbGncvU4dM1Reqddn3+GK5rTlPTGDTIMmQI8bdP1bueP/QRdFXRKzTgI+8r+K/FIBP
	UG7LjBzVvYJyGUEckifxGYOg+/mfrYBwJiwTZ1VMGMNp/RvjEBIFA0FXqlR2Nzmg+4/MCYHL7vQ
	S2c+OFuJK1TqSRrmbTDSONd4TRu6T7WIAw9qTGa3rg2mvzTCyyjm3b6kP+MpBuC8hQ1NGLxbMQp
	XcCfn/Tx0Jyqct6/s9IIOORvcA9daNLhvKxEVs1VDyZ57ZzFS+yaw+MM49/nzy+jXN+tZ5bVkAb
	UUPzNBVB1xFWP4AWYoviBcl08Pn0kPewZpGrg0XsnCgPJd4Yzkco71XekraStGTuUHozGhwF+9R
	q0FGvPS1uY6iuYYECoA0WCy/HFc7U11chLuz/7+U/HY9mQo10/bz+sRRSF3/cnrOQObg0Zy6an8
	E=
X-Google-Smtp-Source: AGHT+IH3k516/vzVd7/DFQFdOqqnJfS18hrvkJlNFIXpMY4apFTyG3GSuibTdrQEUW2DflK6qfqkcg==
X-Received: by 2002:a17:907:6ea8:b0:b24:7806:b59 with SMTP id a640c23a62f3a-b50ac9f86f9mr2149534166b.55.1760346477858;
        Mon, 13 Oct 2025 02:07:57 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12ccbsm876236366b.46.2025.10.13.02.07.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Oct 2025 02:07:57 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:07:53 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, oliver@neukum.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, Yi Cong
 <yicong@kylinos.cn>
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device
 driver for config selection
Message-ID: <20251013110753.0f640774.michal.pecio@gmail.com>
In-Reply-To: <20251011075314.572741-3-yicongsrfy@163.com>
References: <20251011075314.572741-1-yicongsrfy@163.com>
	<20251011075314.572741-3-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 15:53:13 +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> A similar reason was raised in commit ec51fbd1b8a2 ("r8152: add USB
> device driver for config selection"):
> Linux prioritizes probing non-vendor-specific configurations.
> 
> Referring to the implementation of this patch, cfgselect is also
> used for ax88179 to override the default configuration selection.
> 
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> 
> ---
> v2: fix warning from checkpatch.
> v5: 1. use KBUILD_MODNAME to obtain the module name.
>     2. add error handling when usb_register fail.
>     3. use .choose_configuration instead of .probe.
>     4. reorder deregister logic.
> ---
>  drivers/net/usb/ax88179_178a.c | 68 ++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index b034ef8a73ea..b6432d414a38 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1713,6 +1713,14 @@ static int ax88179_stop(struct usbnet *dev)
>  	return 0;
>  }
>  
> +static int ax88179_probe(struct usb_interface *intf, const struct usb_device_id *i)
> +{
> +	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
> +		return -ENODEV;
> +
> +	return usbnet_probe(intf, i);
> +}

This isn't part of the cfgselector driver being added by this commit
nor is it documented in the changelog, so why is it here?

It doesn't seem to be necessary, because USB_DEVICE_AND_INTERFACE_INFO
matches used by this driver ensure that probe() will only be called on
interfaces of the correct class 0xff.

> +
>  static const struct driver_info ax88179_info = {
>  	.description = "ASIX AX88179 USB 3.0 Gigabit Ethernet",
>  	.bind = ax88179_bind,
> @@ -1941,9 +1949,9 @@ static const struct usb_device_id products[] = {
>  MODULE_DEVICE_TABLE(usb, products);
>  
>  static struct usb_driver ax88179_178a_driver = {
> -	.name =		"ax88179_178a",
> +	.name =		KBUILD_MODNAME,
>  	.id_table =	products,
> -	.probe =	usbnet_probe,
> +	.probe =	ax88179_probe,
>  	.suspend =	ax88179_suspend,
>  	.resume =	ax88179_resume,
>  	.reset_resume =	ax88179_resume,
> @@ -1952,7 +1960,61 @@ static struct usb_driver ax88179_178a_driver = {
>  	.disable_hub_initiated_lpm = 1,
>  };
>  
> -module_usb_driver(ax88179_178a_driver);
> +static int ax88179_cfgselector_choose_configuration(struct usb_device *udev)
> +{
> +	struct usb_host_config *c;
> +	int i, num_configs;
> +
> +	/* The vendor mode is not always config #1, so to find it out. */
> +	c = udev->config;
> +	num_configs = udev->descriptor.bNumConfigurations;
> +	for (i = 0; i < num_configs; (i++, c++)) {
> +		struct usb_interface_descriptor	*desc = NULL;
> +
> +		if (!c->desc.bNumInterfaces)
> +			continue;
> +		desc = &c->intf_cache[0]->altsetting->desc;
> +		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC)
> +			break;
> +	}
> +
> +	if (i == num_configs)
> +		return -ENODEV;
> +
> +	return c->desc.bConfigurationValue;
> +}

I wonder how many copies of this code would justify making it some
sort of library in usbnet or usbcore?

> +static struct usb_device_driver ax88179_cfgselector_driver = {
> +	.name =	KBUILD_MODNAME "-cfgselector",
> +	.choose_configuration =	ax88179_cfgselector_choose_configuration,
> +	.id_table = products,
> +	.generic_subclass = 1,
> +	.supports_autosuspend = 1,
> +};
> +
> +static int __init ax88179_driver_init(void)
> +{
> +	int ret;
> +
> +	ret = usb_register_device_driver(&ax88179_cfgselector_driver, THIS_MODULE);
> +	if (ret)
> +		return ret;
> +
> +	ret = usb_register(&ax88179_178a_driver);
> +	if (ret)
> +		usb_deregister_device_driver(&ax88179_cfgselector_driver);

Any problems if the order of registration is reversed, to ensure that
the interface driver always exists if the device driver exists?

> +
> +	return 0;

return ret perhaps?

> +}
> +
> +static void __exit ax88179_driver_exit(void)
> +{
> +	usb_deregister_device_driver(&ax88179_cfgselector_driver);
> +	usb_deregister(&ax88179_178a_driver);
> +}
> +
> +module_init(ax88179_driver_init);
> +module_exit(ax88179_driver_exit);
>  
>  MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
>  MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

