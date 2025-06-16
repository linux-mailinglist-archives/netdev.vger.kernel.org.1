Return-Path: <netdev+bounces-197924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E7ADA548
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 02:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AAF16BC36
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 00:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4A139D1B;
	Mon, 16 Jun 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM2OdW+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AB7081E;
	Mon, 16 Jun 2025 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750035424; cv=none; b=lxO/+n/DX3krV1HNo7RaX5QTG7jo2s/18zOQ/uatmHlFxz/1zD9EjGV8hGigPJ+gxLp0CloSuZ6jHuEIPqu3QgfKLl/sJkidMBFleI4gNEZxrFuxPEx3Jz9XMSZWD7qzPQmyk+h0YGMR61c7ZvpW1h/Kc3W+TLSJp1KPXesRoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750035424; c=relaxed/simple;
	bh=+E84oN7ceFHfRJbWHpZhLPyDdbHv3VBZ8qaE/QVREiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfQv5Ec5HqGDm47Tsloa30G0T2zUfwN1/ShEtVz9A2zTp0TF4CqD3uJO8I6n+//E71R1uBNTypTwVFwjwSXD5jWRnGkFpOJnXP/nk9Y21a7aPIFEYvWZCJn4ndy1oKeFi01CLf6FM+b6z8xggAQclmv5Rg/OEJEvT47n8EuFKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IM2OdW+7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3138d31e40aso3931296a91.1;
        Sun, 15 Jun 2025 17:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750035422; x=1750640222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oT/gl9ntzgnLVv3Iy2roEt0j1rQ3Tf60S9oriE2bToo=;
        b=IM2OdW+7T/tqeVPrzKxkP25IlkrYUDcdRlRAV1OzdphMWTRbIiVTbYgc36mQsMeW1O
         l2JVccU6O9zb2wKLpdpbhhYTiQPU3+DwLrqf0PJmERfTcu2On7fHL2wBy8LSsuPrWLoA
         Ww43Yn29toVh5cKX4a3LgmcYwXMqCKVbhxrOYUnH/NsLnPE9yNFHw+TolPFQYRd0D0J/
         XUr/7TFWAiyNXRQy4IpaDf2QPcdF5T1lc6bUSXUqK92RVq4+q+7r/MOjAeBYpqUy3k4f
         /p33PzC5Jx1FmNp5sUp9Cu7t97x47OxL7xTqqU50P1cnsllO2o8QNVVgrbGguOtujcGx
         ssVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750035422; x=1750640222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT/gl9ntzgnLVv3Iy2roEt0j1rQ3Tf60S9oriE2bToo=;
        b=maT3bLxB4iBy9imJt2tW/c7Q+mNllgoSgrNeOd0NTxYxYcSkO/lCbHdtSUzhsiEoJu
         8VuwuJZLIHrxWYuatb4Yy1NOb0LIOLaU0l8NMRcPymQXGePkQT/D8sd4KtUxCQj3J4u2
         Ydko0kM84tKDjHh2eJ9e2JmUFDvEUUte5ZQCerZr40DnuZo01VG0/hClZnyIU9EDBH6u
         ngRpDS4HDqXQg2xm9uvNbxV09TIFLSUC6mjqYiVuwFTWFyU3GYw5XAkJxuSCU6pFN4ZB
         Ii9Ajz1F6ifhjCx630QZzEeFU1icZII/qSfqpmrbklqumab3T8EHg9OCmrKv0te6jSj2
         NJjA==
X-Forwarded-Encrypted: i=1; AJvYcCUvO5lRBGz3syAmLUC5GqYY3w0I+1uGjjkITUxyZN5EroAKQKDSS+SGR8NwOHBg/bUJV+ntWd4q7gavtBrN@vger.kernel.org, AJvYcCVqsaPqGR3D5LTyrU+ENy5oV9RLSHFTB79g1CI04Zqk96WQ3z203VkbTdy+KuHhb5cGV7p6jVUxqGYY@vger.kernel.org
X-Gm-Message-State: AOJu0YwAK4sGx+ZN3hZwin+wpjVcSlvXXmrLbqdyOcUzTKRQAk0QDS3h
	DQm1/D3HKb3DTiBxopmmj/RB+reh5jRBb0Izxt2oDPHkue+2R3XTWR9k
X-Gm-Gg: ASbGncvK/3UuPjWyPg02rVAM6psvD35WXcwwJPm3jw/bf0GKX0qzpq5nc9jXhjPLAng
	mlejTGzUEUersG9Pz6LYogzRb0AChfjeCPufvcWUbvpCoXEY3GguaXUsz4pZ0kbywcG+Rk9BB4b
	hUW7VlyEuN35vj1zk5lbi0hdFSXoZlntLa+bOyUoEdmHgnGyRHbvuTouSjXQC75WLM4CZk8Mpa/
	eMsbdUJrzCZ2YcDQh1bihcUN6wVHBB7bjg1aipIR8i/MO5RvayW8wjQ5p28yo62fPKm8gRc7euA
	jVGMXmCL6N/LZ11Sb7stXqmXzxXcxYVmWtnJpU0CQ0U4mONbTUpMFDZhot2CWw==
X-Google-Smtp-Source: AGHT+IEJZx+RvcW/dbXwya7QUE7sY7JBiNDXSGJnioj+9AXE7S+LvtvlFoRF1iJqrMM91idUaTWYJw==
X-Received: by 2002:a17:90b:3805:b0:311:ea13:2e70 with SMTP id 98e67ed59e1d1-313f1cfa1afmr13643569a91.14.1750035421829;
        Sun, 15 Jun 2025 17:57:01 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365d8a17e4sm49582235ad.56.2025.06.15.17.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:57:01 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:55:47 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, 
	Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet
 support for cv18xx
Message-ID: <dex2g5mafop6vtc5qdkdlunk5te53u7xxntcz6sjhwldhah6hl@gs6inqeuzlo2>
References: <20250611080709.1182183-1-inochiama@gmail.com>
 <d3b20a9ce58fa296034fe3aa8b60ecde4c4192f4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3b20a9ce58fa296034fe3aa8b60ecde4c4192f4.camel@gmail.com>

On Sat, Jun 14, 2025 at 11:19:34PM +0200, Alexander Sverdlin wrote:
> Hi Inochi!
> 
> On Wed, 2025-06-11 at 16:07 +0800, Inochi Amaoto wrote:
> > Add device binding and dts for CV18XX series SoC, this dts change series
> > require both the mdio patch [1] and the reset patch [2].
> > 
> > [1] https://lore.kernel.org/all/20250611080228.1166090-1-inochiama@gmail.com
> > [2] https://lore.kernel.org/all/20250611075321.1160973-1-inochiama@gmail.com
> > 
> > Inochi Amaoto (3):
> >   dt-bindings: net: Add support for Sophgo CV1800 dwmac
> >   riscv: dts: sophgo: Add ethernet device for cv18xx
> >   riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
> 
> Have you noticed any problems on the board you are testing on?
> I've added the patchset + pre-requisited + the following into my board DT
> for Milk-V Duo Module 01 EVB:
> 
> &mdio {
>        status = "okay";
> };
> 
> &gmac0 {
>        phy-mode = "internal";
>        phy-handle = <&internal_ephy>;
>        status = "okay";
> };
> 
> And the PHY is being detected and the Ethernet controller is being instantiated,
> but the PHY behaves really strange: LEDs blinking wildly, link status is bogus
> 100FULL UP even without cable insterted and the real traffic starts to travel
> only roughly a minute after the cable has been plugged in.
> 

This is true and may be related to a wrong pinctrl setting or the
phy setting. But I am not sure the right configuration is at now.
IIRC the phy is inited in the uboot and the kernel does not touch
its custom part.

Regards,
Inochi


