Return-Path: <netdev+bounces-245435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D9CCD4DC
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 20:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B01233060F0F
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCBC32A3C0;
	Thu, 18 Dec 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzOjmPrn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F08322A30
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084334; cv=none; b=sN58I1TV3jZjWkwi5ObdKTVVIYbRj5NwMQkg94bNhkzzndoZrinWV5bsjdKikLjBRquO0GTsPc5NpT01oQ65dF/Qp6VrDQn4wQuabIayySwNXGfFuWEF2U1p2eYd3TtCj4d/3N41KsT8EWHjWbUJpYFDuTB7BUctFJEnCLlLPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084334; c=relaxed/simple;
	bh=Jku28IM/c1IYSHnKsavbvy9aaLBIgMj3F4YQHgrupho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBQSMPSdsHoCLxGBDFHJCGIV0Xmajibj2jD5XSRzWLVVoQuPrc6uSJvYMDlVlgl/2kivIuIwhBXlC48KdTuThOi4eBlAUCEEIkARxNm+Dmo7q7FmkKo7IM6lvAt1vPzlLsDJ4OyQDPqgFk+9+8IqXcrc4DSn4yfAAorFEuZ3k/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzOjmPrn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so914509b3a.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 10:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766084317; x=1766689117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQfRVSe9fO1PObUKRZHse1cNpjrf0uUXBusNVMTFfiA=;
        b=NzOjmPrn46f7eL94kTiu7+0zvL7EqcBFTL/HGLf3Rc6h3rBZjvJM5i3qCCD2fYrXy7
         eJklrOOWGmpDdYURm2bD9+/3PlBRsY8WKHCZ2GLGzwLcw74QlWuQ3QwUrvnoh8XgWay8
         gOij/Oftk04H9HcDeMjrum7Gp/tJMDS9TcpBQwDo75WutLi+yiY8j3WBiG0hbm0He5W7
         e9CpO9bAAOVDpz+N+io0xTJRBjOcs9kNkjAd+Z+kY0znjtSG4hOPaCJlbg1PV1xakEpj
         cFYP81lVX+QhyL2f1NFGqqWTbtem9suiHwzZLYFwy//KO+NJmpEmbUADkYq65Km/0XcM
         myZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766084317; x=1766689117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQfRVSe9fO1PObUKRZHse1cNpjrf0uUXBusNVMTFfiA=;
        b=lJayuBh8zrBUut+wYlZ9i1QYXeVZ2N9omARGqQP+LoPezAEB7CKf57Xe/vncrQ59u/
         BkKBjXHJYZp90vT/W35INgtYDsnH9BJN36lpOKsR3Z0ZycgeUY0DHxk4ryUIN5AeW1R+
         j1UAwGSzXJX1i01AoUEFCexfsCfRuggD/cmfLO8qUrExGqUKE/ibvhi800pmZi3CJ+b9
         5vS8qAN7YFr1fdgMaJM1CEUrARGrUBATAs7i90Nn1d/hlZM5PSq7DDcVUwcmxJgwjijy
         Wkv11+NTf6ld044T+99IRjsdk6lA2cahSXgh/2l7QAb63cppqmnA7JlOqOmGOBq2UBsL
         y23Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvdmSS9PlPk7niJeAu2x5T9rIxmAzUL6yKOXPoBIonW4dfISXzAQ0RuTSA6cf6w8i2EtiVJLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2eWeG5V+sJAOGSvQCOvNCmKU8gmPZXXf5PilbnSO+Cb0OpY4s
	jk/ZffJ5rU0GDHP7fzI+NoWnGunuU5QUWjEVWpuB+Kp/FcEkpjULSCLo
X-Gm-Gg: AY/fxX65w5hnCLhyquw7XT1j8N4EkK5/c8hMiqX9Cqd35w5y7nWgplTQ7fzhmAqP8cm
	24P2OdSGvG4iI74KfzF3GyoitpIBnqX4jexSemb9EGPXQJvpI3CCSDG9RBtvtrJRn3dLhnifhyH
	5AhnL4P2Cr4Op/mhDxkdJTIrt2yN/Ad92kmYBoCLJo5B/wn4eym0D5+3s2l+1FFdHr3OrmupifP
	4gCP/IBN3vSzV9rrS5IQVXn43O9A6vRoEJI4u5u65YWbPHe0Y0lP47F2YcGcNmqDUncxCu9ebH3
	wDGzHaji5c8piP4J643U5nascXx6AdnmYhdKEGNxw+4pHE2HFI3iyoOYAmXVfsLJpgE5JBto9dL
	Mnl9Jyq2LMEJKhp/s7Y49iFwUZUczKu4ji+5yGpmiOtvQhaM5XCQLXl10YdiZ81SH09AHJhMfxt
	D0YPviCUHRjXoDZ5gbJQ+OJ+p7
X-Google-Smtp-Source: AGHT+IFf3D0xeHaQPPXEeazhorZHgIgTwRHiyRuussKNgJjGtFBYIJhQUMgRhb/IHzjPiFdB5lKzgg==
X-Received: by 2002:a05:7022:3705:b0:119:e56b:91e9 with SMTP id a92af1059eb24-121722dff1cmr177764c88.26.1766084317443;
        Thu, 18 Dec 2025 10:58:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm299016c88.12.2025.12.18.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 10:58:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Dec 2025 10:58:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Robert Marko <robert.marko@sartura.hr>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linusw@kernel.org, olivia@selenic.com, radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	richardcochran@gmail.com, wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com, kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org, mwalle@kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH v2 15/19] dt-bindings: hwmon: sparx5: add
 microchip,lan9691-temp
Message-ID: <8462a516-4e8f-413c-813d-e7ff0e6eaa1d@roeck-us.net>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-15-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215163820.1584926-15-robert.marko@sartura.hr>

On Mon, Dec 15, 2025 at 05:35:32PM +0100, Robert Marko wrote:
> Document LAN969x hwmon temperature sensor compatible.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

