Return-Path: <netdev+bounces-238501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2C5C59E9F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9D344B4C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A782DA77D;
	Thu, 13 Nov 2025 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfAJmNrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A03218AD4
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064692; cv=none; b=Dxous77HjIsoemYoaKb+Xf1nfy7XZ5s6fyQ6/coHOSveC3dQojocphs9WlMy/ZQeEqaleGxbgBGP3ZYF3WKkUdkwcaGXeJHEEbCeRG5j3MtbSLttVJHeGOJnEWuFb8Wcw8tHQpHxZMJv5LXGJTF3wnKSbrzGU01DQUcjxGmCf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064692; c=relaxed/simple;
	bh=SDyjdDfdgapcNn9RxwuXEc33H2X/7CakgoMhX8qYlYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh/9CaGO/orJ5LnR1WkhnBgmnvVVC4tX6G3Li06qGbc82tez6XCV64/q/75fPKplmBXzCwPCyRoqud14pLSdAxjHr3Szq0HXoWnruBZ0OE1icGPj3wzSuORy5xb+FnmdljjkqmWhbwIhdCpEift+xdMZ3Tg7ZqQ9EKIEVL1SeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfAJmNrW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so9298385e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763064689; x=1763669489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEGQI3RIdwso1vTokuFkTWMWXMmT7HFgWD7RMVDgsD8=;
        b=KfAJmNrWH/9yOYiJzh40fDLLtGE87OFrOtOnPiiMezHdjmzB0soIWCLVguR7YeU/uC
         1J3oYgs3wH0M2xUbpJukYqay7HGgLutPXY9kk0h20TH9yBxcMpoDNYiZVIa5vGZg2DsB
         m9Z4w+MRXf1zdovRjs0zx4AxzHXXbFUmMB79YmnZC6wgbzkEt+clm9xoFzweBdfobT4Y
         BQ14HGcfPN2DAoqUjM6dXLYuDKboCFnC41SJZf9u7arr7Tx2CrSxfY8u7wtrfQx5wzLY
         SRQFdNMgLLicnpfUws2qO1gQYXBqoLTQnsmwvyzqNu0UoTIKk8WbLZMwvrjcXRT+yQac
         1lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064689; x=1763669489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEGQI3RIdwso1vTokuFkTWMWXMmT7HFgWD7RMVDgsD8=;
        b=N2DdkGtC8Kep4UJjpF8x4CoeWg4HDVSy7q6gUwAnLPlGOnJB3cIqf64nAiIwdcVl0T
         76EMFJLCbmUUJJJj1UOJ26I4angwbjPK2HqrELdhtBuMdwIL65/CfPGVe/ski5RjqJSW
         lpcmKvt7Llr9XfuzWtbGA4wmRYwM+Mai9+IISDkcST4jFDdavyGd++Vb/k8n46LehDN2
         +4y4fgTqbqpGkaSiZEOWoU6ipAA7TkRdDKku49RAifdlvfD7Mvj94AWB1gzKlF+3B883
         jF+m93+O9PshIcu0wdfuvRa7YKxmMN0H23Gsu6MZmAbcjXnCU8QAxh/zPbXkKjSWtDld
         w3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCW33nVIpFOVdfJBtv2n5+cTKVtGVFRAKnnElBBEB2xtgoCxseWeCRBH8nAcymwv8aeL0hCAj40=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg65VoKrG1IjwAz0tU4KhYb/wwp2tIqpyyE/Mu2ceeHYR2CrZz
	j8Dr/dRvp2XMpMhCMiWLAzlHD8+3NW/7x9xi/C20OyPrRMP9E4I91XVP
X-Gm-Gg: ASbGncv9fGf+0PHP0fKYhKWQzGtOdvySO/kcJQWLH83MqUJrt+8FE9Ib4Vfty9MYDy7
	dDVXGo5N2/xNlAovlqICZVC0gL4yUiy64IjmmIzwn25krObxdHbwCLfAsGNRjWz4koJkA9G6BMF
	iovZnnJXHgolQf9/j2qAenkIdQQhIAa1f3zgVKjSldzSlT3IeUaGH5mEmd+z4Q9Eo01p9iss2Yp
	QSGexNXV6cRd64WPZoAbse0oLc/umWVUahwn+6p7jRRedEx/ptXhPpAV/vLnwbi5izTaTKM4knT
	4G/L1Q3zopnH8ft8w1pxYYQqNt+boGtozEMQDzSBflQFgt1EIkTd5ClErzEdjKlqvdHsCkQRnCI
	Im0gnCB7lpOfcePJ33JO5DEuv0Fdnr1CM9gsR6Ibg54acE55akgx8cp2jOh43rbmeFZ0b9RJYL+
	t1O9Xme6nZxgkHu/8l2FBCefj7X9A7VxsguXbfdwlt6MH8mK0tr1xcb6P7lIq9b1hwU+IjwYob0
	N+rEglCTkFOPY3bGr0eSmaDzhFedxP8GIVDdQ0D
X-Google-Smtp-Source: AGHT+IHk3LnZn/Axp3LgBgZT12t8l1SpTOlpnv+mITPSZMXV+zAxiXcA+5wnvklirnifBUxs6NC8AA==
X-Received: by 2002:a05:600c:8b38:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4778fea2de7mr5663575e9.24.1763064688713;
        Thu, 13 Nov 2025 12:11:28 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4e:1a00:f17f:a689:d65:e2b2? (p200300ea8f4e1a00f17fa6890d65e2b2.dip0.t-ipconnect.de. [2003:ea:8f4e:1a00:f17f:a689:d65:e2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm84440835e9.13.2025.11.13.12.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 12:11:28 -0800 (PST)
Message-ID: <4ed5da1d-1d2f-49ea-918e-2455573066ee@gmail.com>
Date: Thu, 13 Nov 2025 21:11:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: phy: disable EEE on TI PHYs
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Paolo Abeni <pabeni@redhat.com>
References: <aRXAnpzsvmHQu7wc@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aRXAnpzsvmHQu7wc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/2025 12:27 PM, Russell King (Oracle) wrote:
> Hi,
> 
> Towards the end of October, we discussed EEE on TI PHYs which seems to
> cause problems with the stmmac hardware. This problem was never fully
> diagnosed, but it was identified that TI PHYs do not support LPI
> signalling, but report that EEE is supported, and they implement the
> advertisement registers and that functionality.
> 
> This series allows PHY drivers to disable EEE support.
> 
> v2:
> - integrate Oleksij Rempel's review comments, and merge update
>   into patch 2 to allow EEE on non-1G variants.
> 
>  drivers/net/phy/dp83867.c    |  1 +
>  drivers/net/phy/dp83869.c    |  1 +
>  drivers/net/phy/phy-core.c   |  2 --
>  drivers/net/phy/phy_device.c | 32 +++++++++++++++++++++++++++++---
>  include/linux/phy.h          |  1 +
>  5 files changed, 32 insertions(+), 5 deletions(-)
> 

Alternatively the PHY driver could call phy_disable_eee()
in its config_init. Then we wouldn't have to touch core code.

