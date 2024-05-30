Return-Path: <netdev+bounces-99327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0287A8D482B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B8A1C21EDD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9DE183989;
	Thu, 30 May 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRx3fq5G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79807183974
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060390; cv=none; b=OPrZjlUY8ELnU+jv1eueOe+IgwYaR5kU/FDxxkuMUC+lZIJy5xzVIlJKKw4r/BcaxJQlx67WyXf27oYP1w4OZowuCtHwjCUz8OPBFkTfzgvnZeeMnQLTjCiJImo5yWFCgJqVvU2HTnlHAmjiPyoPanRRkroxo8FEjvRQZemdsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060390; c=relaxed/simple;
	bh=xCpzaDdKWW9AW8tDLtRBP9eTGLx1aULWHWwVDHvvqeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keE/MAPRtVWx/Tq5Fm/TtWQD7nHmonOycAxM3BjIvMl1h1zY5bZWcWsJl42eWv517vout8jyEESpHx6qzhu+n5u9HV5sqKYqCS6EPmpp6gFJ+HOs3gdnWy/QKQNdXVj41btAvTlnCBxiDKKhV5UICAjX47nhrTwJrtwUEewtFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRx3fq5G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717060387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fa4RT2lgTkaA5/fy0D+M4ZVApJB7iK4FR//N3+opHgw=;
	b=DRx3fq5GWUPFS/Icyak+9Xc/CmEwAcc6fY/SLPK9xAhIPFkUsD2G2ksfdsBRKPkqBsXx+p
	z6yt7AW0ZGeACsqvWvJ/5HBimEOKwHIJ/Q4uIFGLMo8aSncGTQGxpwN6eXmG8hCJh38b7a
	lv66uDcTyuTdgP7pRCOWlYBNq2PUYTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-9ZYVc_oHMduIZfJC97rhdg-1; Thu, 30 May 2024 05:13:04 -0400
X-MC-Unique: 9ZYVc_oHMduIZfJC97rhdg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4211239ed3dso1040735e9.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060383; x=1717665183;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fa4RT2lgTkaA5/fy0D+M4ZVApJB7iK4FR//N3+opHgw=;
        b=D/WlHGGB54nDX/iUhZd1qNLPsVn9v2vR63asMsbet0QN0QRRVk7xelyO/6UiyMJKe0
         kKWkg5ssPqIQdGG8w0ULbK5flMjpg5WxMMOL74YuElDHOd5dEuLfz2wTgmz82Yr3Jgyy
         jMjENS4L1xWp8M+X3rH4VI7bdLUSLxDfANMUw9ljs6uNJapLYd7dfUf47NrcCCWFrsOo
         Me2y9Ea0ejRD6oqvBMc9VKjym9tFk/LXGoutuZ3CTevpcBAU76UBbXbzslCiaeKBmsIk
         vpTIbWznkPLfJiAQ+AkTIczkaHyKqlNI3rbh4Za6jCPDOcUhAiKYgSrmgsFqTJrVUZCq
         M3RA==
X-Forwarded-Encrypted: i=1; AJvYcCWS55pimWpdJYdEYgy/Fz2uB0KePNuVgabpEGpF+REH8IGnXmHqdGfI4Ps9ivPxq63BYVeCHXGLN6DZYvlkeb8zl1z/lF1M
X-Gm-Message-State: AOJu0Yy2DaLeABTXiqQgznH72zjiwMBJpg4/5/J+O+rBiVj4HHmUTbp/
	Thih3gdHI7YP+txz1lEE4gTWRhxCS72dyfwcRaSYJkpcsSOFqDA0SyWa0gRsakny/SKOnWojF/y
	a+y5OyUwSmP3VEmNnRwFW2nRSneIlUkq2w3FMgh4xKCeS9g+2+lr0Cg==
X-Received: by 2002:a05:600c:1d16:b0:41f:cfe6:3646 with SMTP id 5b1f17b1804b1-421279376c9mr12905235e9.4.1717060383016;
        Thu, 30 May 2024 02:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfYVzLKlj78bINf6vRV8yJ9G7297bx2gQYidRL3metYHgNu3hI4g/8Mu8cXbkVwHZEGzKB8g==
X-Received: by 2002:a05:600c:1d16:b0:41f:cfe6:3646 with SMTP id 5b1f17b1804b1-421279376c9mr12905025e9.4.1717060382620;
        Thu, 30 May 2024 02:13:02 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42123458a5bsm23676725e9.1.2024.05.30.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:13:02 -0700 (PDT)
Message-ID: <4a467adcdb3ca8e272bd3ae1be54272610aabc9b.camel@redhat.com>
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ9477 set_ageing_time
 function
From: Paolo Abeni <pabeni@redhat.com>
To: Tristram.Ha@microchip.com, Arun Ramadoss <arun.ramadoss@microchip.com>, 
 Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>,  Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 30 May 2024 11:13:00 +0200
In-Reply-To: <1716932192-3555-1-git-send-email-Tristram.Ha@microchip.com>
References: <1716932192-3555-1-git-send-email-Tristram.Ha@microchip.com>
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

On Tue, 2024-05-28 at 14:36 -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
>=20
> The aging count is not a simple 11-bit value but comprises a 3-bit
> multiplier and an 8-bit second count.  The code tries to find a set of
> values with result close to the specifying value.
>=20
> Note LAN937X has similar operation but provides an option to use
> millisecond instead of second so there will be a separate fix in the
> future.
>=20
> Fixes: 2c119d9982b1 ("net: dsa: microchip: add the support for set_ageing=
_time")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz9477.c     | 64 +++++++++++++++++++++----
>  drivers/net/dsa/microchip/ksz9477_reg.h |  1 -
>  2 files changed, 54 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
> index f8ad7833f5d9..1af11aee3119 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1099,26 +1099,70 @@ void ksz9477_get_caps(struct ksz_device *dev, int=
 port,
>  int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
>  {
>  	u32 secs =3D msecs / 1000;
> +	u8 first, last, mult, i;
> +	int min, ret;
> +	int diff[8];
>  	u8 value;
>  	u8 data;
> -	int ret;
> =20
> -	value =3D FIELD_GET(SW_AGE_PERIOD_7_0_M, secs);
> +	/* The aging timer comprises a 3-bit multiplier and an 8-bit second
> +	 * value.  Either of them cannot be zero.  The maximum timer is then
> +	 * 7 * 255 =3D 1785.
> +	 */
> +	if (!secs)
> +		secs =3D 1;
> =20
> -	ret =3D ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
> +	ret =3D ksz_read8(dev, REG_SW_LUE_CTRL_0, &value);
>  	if (ret < 0)
>  		return ret;
> =20
> -	data =3D FIELD_GET(SW_AGE_PERIOD_10_8_M, secs);
> +	/* Check whether there is need to update the multiplier. */
> +	mult =3D FIELD_GET(SW_AGE_CNT_M, value);
> +	if (mult > 0) {
> +		/* Try to use the same multiplier already in the register. */
> +		min =3D secs / mult;
> +		if (min <=3D 0xff && min * mult =3D=3D secs)
> +			return ksz_write8(dev, REG_SW_LUE_CTRL_3, min);
> +	}
> =20
> -	ret =3D ksz_read8(dev, REG_SW_LUE_CTRL_0, &value);
> -	if (ret < 0)
> -		return ret;
> +	/* Return error if too large. */
> +	if (secs > 7 * 0xff)
> +		return -EINVAL;
> +
> +	/* Find out which combination of multiplier * value results in a timer
> +	 * value close to the specified timer value.
> +	 */
> +	first =3D (secs + 0xfe) / 0xff;
> +	for (i =3D first; i <=3D 7; i++) {
> +		min =3D secs / i;
> +		diff[i] =3D secs - i * min;
> +		if (!diff[i]) {
> +			i++;
> +			break;
> +		}
> +	}
> +
> +	last =3D i;
> +	min =3D 0xff;
> +	for (i =3D last - 1; i >=3D first; i--) {
> +		if (diff[i] < min) {
> +			data =3D i;
> +			min =3D diff[i];
> +		}
> +		if (!min)
> +			break;
> +	}

Is the additional accuracy worthy the added complexity WRT:

	mult =3D DIV_ROUND_UP(secs, 0xff);

?

Paolo


