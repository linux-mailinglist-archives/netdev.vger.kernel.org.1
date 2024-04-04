Return-Path: <netdev+bounces-84774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB998984C3
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5CB1C22C1D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC376025;
	Thu,  4 Apr 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc1OPlNI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8074BF0
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225375; cv=none; b=GViVLteCxtNWq6ROTl0Vj0a6t/8FWZXSLN2qCBCRjGkLQ0El43cAqEEStFM5X4OjNwazbG1HZxnZHEXP1i5/uJ+LnZruOzUH1UVDbeLvoty4gtybuFl6uZM2uqEsbUxWMVoX45yf7aBKCzj70GEqw1y7AU1LgLVidyMRu0qxYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225375; c=relaxed/simple;
	bh=i4UyHRhUIgVUm8aI5UClxeiZPkTAgm2ua1/J4uexnUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ds0duhf1qpzQWHt0aKqERKGt8dJwvDSq9kVlBYopIjqQAGRq6hFuy+gEQUAN3VvoYiRbOcgquAatuLPIhBPEGfaxDn7Hc1cKVTFSib9+6a0e5tQiyNyoH+SsHpvwrP3fjFfKMdvVkkMxoYE+HgKP0jIqAjJgSmA44/LoHhNaOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc1OPlNI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712225372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Iuo4izTAeLFUv/fg2MTMv0DzzOH4FgcCPD10G72CA3U=;
	b=Cc1OPlNIAk6ijxTBioxgWTard9qqwIuB1cc2Bbn3BI45UFx/eBFrU/DCUSFkjZpQwmgtoG
	tvNKUUNBY7QKtcydWwU5LxqarturqICc3llBceNu/vwO6mjFQ7vnRN38sIlgyVHNALIrWm
	9zg+RJp/xCO8Nx7Rd6vJvB9ipSelVDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-MlKrg-CGOMCqXZqjIBPz4A-1; Thu, 04 Apr 2024 06:09:31 -0400
X-MC-Unique: MlKrg-CGOMCqXZqjIBPz4A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4156135f4d2so278535e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 03:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225370; x=1712830170;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuo4izTAeLFUv/fg2MTMv0DzzOH4FgcCPD10G72CA3U=;
        b=Vs0QxbmGQsBx9fYTVhtLMfE4rgQkUWvxfUzXBZO/0gkDEmBmx56yHvSrWlh4Ct5KD5
         26EyvVx4sx3WO1GfUAetuGeVPoh8INbq8k2kNV4hohj6vXNh5kbZBFfCb6X7iIA3aTr4
         UMnNV9IwQmVmgtS/g/1hyItLTuz5GKh+cJwQgG6RH66FzXal2N88W5ZV3RlgtOzXy7Mc
         Q5iBXBm8U5bEmz8a71EOWvbNTMkjSZfpEVVYBII0fvEt9W7aU42poUJhOX0poejRjx7e
         UoZlNvNI20E3dIoIYNm0WT3BklzzGJAmdarXpKX8SCvGKXXTtxN9jpDJ6g41RCLmd+bN
         SKZA==
X-Forwarded-Encrypted: i=1; AJvYcCVXeaOWNnuqjnRUnLjeAAayu08uXBKuI2+nWK0vmsyLsoB/4o3TOjQ2VnaF+ff8CpJKpzaE2TnqtN35cX706wCBDj0ElRKv
X-Gm-Message-State: AOJu0YwO5L1uhFFmigUBF1nI1HF3kCcpsBWJaG4zYXE7mAUe1+l+TMNc
	dU48Sl0LXRoUq3bnDMuzhCv9U+/cgb84J+u4UG547vYpkWQbvfQ8C6TAx2MPkZmsAjTNM5ZVHYa
	SaAzunxvs8y7UPlPxpoMM4PTUvdwGT/y1QFF9OLkldzEpx65nqxMbOg==
X-Received: by 2002:adf:f402:0:b0:343:823c:6d54 with SMTP id g2-20020adff402000000b00343823c6d54mr1487482wro.3.1712225369842;
        Thu, 04 Apr 2024 03:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuv/JbXlCCZHGuq3zAuz6uA0bzeIobcAyb3QLYo/FRML4xeZV3TksRGfu2303jAYu50YXSMg==
X-Received: by 2002:adf:f402:0:b0:343:823c:6d54 with SMTP id g2-20020adff402000000b00343823c6d54mr1487467wro.3.1712225369445;
        Thu, 04 Apr 2024 03:09:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe892000000b00343ac425497sm2458842wrm.46.2024.04.04.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:09:29 -0700 (PDT)
Message-ID: <d3bbd99be9893cfa385d330b4bcecb4fae7b1e45.camel@redhat.com>
Subject: Re: [PATCH -next] net: usb: asix: Add check for usbnet_get_endpoints
From: Paolo Abeni <pabeni@redhat.com>
To: Yi Yang <yiyang13@huawei.com>, davem@davemloft.net, edumazet@google.com,
  kuba@kernel.org
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 wangweiyang2@huawei.com
Date: Thu, 04 Apr 2024 12:09:27 +0200
In-Reply-To: <20240402113048.873130-1-yiyang13@huawei.com>
References: <20240402113048.873130-1-yiyang13@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-02 at 11:30 +0000, Yi Yang wrote:
> Add check for usbnet_get_endpoints() and return the error if it fails
> in order to transfer the error.
>=20
> Signed-off-by: Yi Yang <yiyang13@huawei.com>

I agree with Simon, this should be a net patch, with a suitable 'fixes'
tag.

> ---
>  drivers/net/usb/asix_devices.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_device=
s.c
> index f7cff58fe044..11417ed86d9e 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct us=
b_interface *intf)
>  	int i;
>  	unsigned long gpio_bits =3D dev->driver_info->data;
> =20
> -	usbnet_get_endpoints(dev,intf);
> +	ret =3D usbnet_get_endpoints(dev, intf);
> +	if (ret)
> +		goto out;
> =20
>  	/* Toggle the GPIOs in a manufacturer/model specific way */
>  	for (i =3D 2; i >=3D 0; i--) {
> @@ -834,7 +836,9 @@ static int ax88772_bind(struct usbnet *dev, struct us=
b_interface *intf)
> =20
>  	dev->driver_priv =3D priv;
> =20
> -	usbnet_get_endpoints(dev, intf);
> +	ret =3D usbnet_get_endpoints(dev, intf);
> +	if (ret)
> +		goto mdio_err;

You can simply do
		return ret;

here

> =20
>  	/* Maybe the boot loader passed the MAC address via device tree */
>  	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
> @@ -858,7 +862,7 @@ static int ax88772_bind(struct usbnet *dev, struct us=
b_interface *intf)
>  		if (ret < 0) {
>  			netdev_dbg(dev->net, "Failed to read MAC address: %d\n",
>  				   ret);
> -			return ret;
> +			goto mdio_err;

This chunk is not needed and does not change the driver behavior, as
the only statement after the 'mdio_err' label is:

	return ret;

Please, drop this chunk and the similar 3 below.

Cheers,

Paolo


