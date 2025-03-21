Return-Path: <netdev+bounces-176780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B3A6C1DE
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6806189598B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730E622E3FF;
	Fri, 21 Mar 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8gJeEd+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5422D786
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579463; cv=none; b=AYiitUcZH09tFNbStbOzDSRbi7VjfCmcvzLpQbBFVdBuLfxoTfHUuN7EDwYmjGcJSUa4/81jF2XBeGFaW+6vbffYdTTYH4zadiA9KZf2STJdXibkf+1uSFCeZ66AlyH7WC25DlIM+aQlKdtKfYjGjwIZbmXVdS5Q15BT3mXrzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579463; c=relaxed/simple;
	bh=q4MAD4MZ9jbGWxaVkOS7XD4VN2wfi+JR96aDUZM4Fwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbF+74w3voqWXTEmTY/luqmDzjUNHv2YWCeQj2VfdCrwU3HCO2A4QXeD1nBrm6ndHzLdbuPRUuObnucDzWuivkUts+kqBTLN0TzZx34WOtd9YF/ppX1l+Uc0QFQzqbt5J3nfSd1D74ZD8xTKlXtSGsZ13C6wtQDbZ5BYN2oP0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8gJeEd+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742579460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nizGFjmh47bimoF8P6GlyAgmg9J5VhaJmX5jPftti6g=;
	b=J8gJeEd+FvHSaFxCITuVka/BLgje7oGPFQKhE5/xCt5LmPiW1l2e5gBngiGHu/AA4pUrhq
	zhxTwSu5W/HKHk3Zv1TTLG85bZroF74hAchGoldQN3Xtb2mrmx/7DE+aTumr6tGnUD7eNa
	sHHMUOdheMFTcIfBS+hAIpwdLH/erv8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-iONY2aITPjeRJTyQ3CLNwA-1; Fri, 21 Mar 2025 13:50:58 -0400
X-MC-Unique: iONY2aITPjeRJTyQ3CLNwA-1
X-Mimecast-MFC-AGG-ID: iONY2aITPjeRJTyQ3CLNwA_1742579457
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947a0919aso15879145e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742579457; x=1743184257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nizGFjmh47bimoF8P6GlyAgmg9J5VhaJmX5jPftti6g=;
        b=J0WMP4UPK3h65PMmO8VfOHk/7K/b6qlUR8T9ghC1qcVXBSrOlb7XVShe9XaRZumx7s
         iL5xIGEtxEmZpm2GuZS6EaGCeeEhWFJKGHfZwlWpBMUm+RT+JqiVTHOx8jLj0RnmC/yM
         gup/yBnx18cFO8F1GE6ZTrv9irDrxV+PkwBbjnbbDaeOP0oRb2pvVM9pcWapbhfmPtCk
         um+XEsKoOo7IVsEhsid/T5FxrSknUo8TQfdRglDBHCA++46b4tpiJ5YGpoRyQMsX/TtT
         /P/DKMPRce+3tSy6AZCpmHDygsuIAIFEedaxOi9jf1SvpXZtOddnaGsrX4K2LWKdAqyp
         2iYQ==
X-Gm-Message-State: AOJu0YyVt+WtZN8jR4uWcD4rsHI7fPGfcbk1ELJz5jwBakZHxYi75Ln2
	6lUk8KTDRoBvbiym+qkBtOD3RgER00/NkFngJ876M8BlyiYGEqKrqr7zhcjOqbDBW+I4D9YLR8H
	fPmNqvd470Cn3IuyTezpJn3cxB+41+C8q9GWukJ1yOv14E2sK6ZEVdw==
X-Gm-Gg: ASbGncuQRPFAHIkdqOmfeJOV8d1/Aapi4K7QHgkZTsZDkZEMLrWEkcUuN8145iA/wUp
	7IJeRyzG7stYVrEJy7bxFOlYpUkIWOYl7WjxWfpAWeMJDR6/ytb8cE7X1OSDRlx8d+u67Yr7h1a
	B8nT61wI4PwRHzmmC1wxIL05GDzd3nfXh1WMPhE9teMnHgMdQj7eqd85tgV/iFOgraTH0GVD9Tz
	XbzZMYg6eHHjtX4b3+bwXXJbJD0KBw3hvqh0pj0x4v4rHCUQB2vh5BYgZZ1RZX6iyd92NKFFYax
	0iS1CeHVWMyD/cq61EV2Xm0dHDhoAmgTGFhfWCT8a4jQlQ==
X-Received: by 2002:a05:600c:154a:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d50a37825mr44330995e9.20.1742579457255;
        Fri, 21 Mar 2025 10:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd2ITqU5wiCBrJkHArbjZN5d0Muz1P8NVOYT8aSNBRjQqgeuR+YXgk2SrqCV0UsvFwX6aDlA==
X-Received: by 2002:a05:600c:154a:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d50a37825mr44330645e9.20.1742579456840;
        Fri, 21 Mar 2025 10:50:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957c3sm3038115f8f.18.2025.03.21.10.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 10:50:56 -0700 (PDT)
Message-ID: <53852ebf-bd7d-4f8e-bc7c-8dd3271cb1b0@redhat.com>
Date: Fri, 21 Mar 2025 18:50:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: phy: sfp: Add support for SMBus
 module access
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
 <20250314162319.516163-2-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314162319.516163-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 5:23 PM, Maxime Chevallier wrote:
> @@ -691,14 +692,71 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>  	return ret == ARRAY_SIZE(msgs) ? len : 0;
>  }
>  
> -static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
> +static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
> +			       void *buf, size_t len)
>  {
> -	if (!i2c_check_functionality(i2c, I2C_FUNC_I2C))
> -		return -EINVAL;
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	union i2c_smbus_data smbus_data;

Minor nit: please respect the reverse christmas tree order above.

> +	u8 *data = buf;
> +	int ret;
> +
> +	while (len) {
> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +				     I2C_SMBUS_READ, dev_addr,
> +				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*data = smbus_data.byte;
> +
> +		len--;
> +		data++;
> +		dev_addr++;
> +	}
> +
> +	return data - (u8 *)buf;
> +}
> +
> +static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
> +				void *buf, size_t len)
> +{
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	union i2c_smbus_data smbus_data;

same here.

Thanks,

Paolo


