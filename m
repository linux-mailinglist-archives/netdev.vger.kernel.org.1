Return-Path: <netdev+bounces-182833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E61A8A073
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB963B09D7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C91F3B8B;
	Tue, 15 Apr 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4cpko7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD671EA7D3
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725373; cv=none; b=H40WGDISWEiEyK2QYiEi1qswPH1i75beWm+3Hy3OeKmq35NAOIGGJmZDdZQJdpE0EENvq2zNDZNDGNbqaDjbY0MJHLSgYaJXavgPnd15eMrLfn6UvzJq+hCdjwLTB1JIgm9/WpqkoVQSROeanDCFnujFNzGe7uAwSDYI/zuJZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725373; c=relaxed/simple;
	bh=cAwldG+WfTv4qB+i7KsZorXEPkOdDQ+GoiASy+G6LZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyJ/+9mFwc889vZLEa0s1/xIdjLcpDkaqheibSeNBbXzd+8gwK32c2Y6qvbdQzhH4LPp/nsfWQpXiT1REHvctWHjs/OUwSKx+oXZPxWgYjSaxzXjZuKiBLvmqNCRLFBwJ3vjdSwCyiEC5Uy/9Ml9fiX/0u0xT3y37a+cqQkc6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4cpko7r; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso7276387f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744725370; x=1745330170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f7Ug76I8PBqsVyX7451rWvT3DCckR1pFD90rVI4kapk=;
        b=U4cpko7rEKBeJHgTXhWKXssB9VZ7Gno3P93eTphMvAm30BMJvNS+0uxBkgnmJFkj0v
         2dsr33mMW4rXC6mwSpcDWkJffe9C+EOgJCYEgQXNG7dmaqQlo6JbGqEhCiZS1FUezKpj
         kTCSXMBFeyTdzhGZgdLQcvJq9Z8AWk68RJuf64gYgpJb6KTkFv5n0RkvDQ2KD4YuTE3y
         mf39iioDBLB4ckrgBBPPpat7k1Utub6tSiyp0sho9hpANaRQNxuemttZFIHRpqDWxX2t
         1G9Q73pmRhM1Cu1tHa7bCvaeA40LHPMRA6q+vYXRkzaxTIjQ21p73KwKnjM1VT++zAKt
         7fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744725370; x=1745330170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7Ug76I8PBqsVyX7451rWvT3DCckR1pFD90rVI4kapk=;
        b=iBWIHV6JuMYoYx5Ypr2EZwLeOku72pxsabT/dnD1x13co2ab+Dw6g8EapBiczpTPXs
         B+tLuqNxuEcAf9GDHgmiAz7F2cxqo9IGSL1HMkxtxNWzPcYJNR/ANE0zyZgisxbmKbE4
         8QRLp33H7iJkL34OerjkcE3bTG0gxMLx5ctQX1ZUxTfbrg1Vbo/g6iVRBIz5vUOFXxu7
         PN7dcm7cOkU39B5gwl12PGBmsRog0M0PLL+n0YbvMXHfkGs0PtcT+kQw6UPzSuaenija
         G+1rvvQkS2qZL36JTP0UmLilwQUzQ2q4t3hvWiX7//3Krf2fXtuotBoBDXvBe0dVvmpC
         pqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIfouyg7sQO20wyJASH74T9hESE9qhz8ks0Z6O3Qlw+RPjKmcBDI4uwmyswjKJ+/UfHYEemaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SrhG1FckH1+lTRYgORKErzWJIhN+9+C1fS8TLt91kxzYuV6b
	Bx9lFQ+/L7riy1uiMP9cMOC98srdbYzJmDAuUkuMAtSeTog2mhdk
X-Gm-Gg: ASbGncs8EAv1dbQQGQRB+IbhcI4A1m0d0gHEQInOL0QnxYKKyAbCZ7hVFUfR5sr4hf+
	PpKf4sXSP/LWj+m7PwXPG4RLn2HoPCqSNEk8KzbDOwEnnJnM/T6Fpfw8Fo4nSOLqabS8x6KtiFn
	iclGQ4FOi8Tsk1uuM4mBNW5iK7/b0wUGHkkDbaDfqtYi5EUpzPqmwvLOJFznoJ2Q/q0Op441Zlx
	V8L215RH9EvRc/z6tqSNRKduXPiTkbXHQWM3RwuUTIfnBN0o26tDj0H9cX/a3yrsFI48OqvtWTL
	EChtJQeo174wE/K8gDOkBt1E0I9b/pI8djYssNs1Dw==
X-Google-Smtp-Source: AGHT+IEUc51u2H2A2sXDUuHdbW0oUHYeFA2HCqNohoAXTGQXycwn5Mca0dijghzNDofByf9HiAEEYQ==
X-Received: by 2002:a05:6000:381:b0:39a:c80b:8283 with SMTP id ffacd0b85a97d-39ea521206bmr13186409f8f.31.1744725369575;
        Tue, 15 Apr 2025 06:56:09 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39eaf445515sm13993745f8f.89.2025.04.15.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:56:09 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:56:07 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH net-next] net: stmmac: sun8i: use stmmac_pltfr_probe()
Message-ID: <Z_5ld6D1Yyo7Ysur@Red>
References: <E1u4dKb-000dV7-3B@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1u4dKb-000dV7-3B@rmk-PC.armlinux.org.uk>

Le Tue, Apr 15, 2025 at 11:15:53AM +0100, Russell King (Oracle) a écrit :
> Using stmmac_pltfr_probe() simplifies the probe function. This will not
> only call plat_dat->init (sun8i_dwmac_init), but also plat_dat->exit
> (sun8i_dwmac_exit) appropriately if stmmac_dvr_probe() fails. This
> results in an overall simplification of the glue driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun50i-h6-pine-h64
Tested-on: sun8i-a83t-bananapi-m3

Thanks

