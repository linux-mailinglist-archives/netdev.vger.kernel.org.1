Return-Path: <netdev+bounces-138044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD79ABA9D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E0A285162
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F7819BBC;
	Wed, 23 Oct 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma+GZU0t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B15312B73;
	Wed, 23 Oct 2024 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644117; cv=none; b=TWL1fAFNwAyoa1n7WufdhsIARDgfxqB3ETvCQ1kl9HWYtxAh8ebbcDitv8X9df+qvVTrfN4nUSPg8aA0XNK02S3nL8k+RoaIRhnG0qCItyyLMYIBJIleYecAeAy6xf0ZVpolxoTo5blatkWinxRHjELj7HBcvGZMn8dn18ZLKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644117; c=relaxed/simple;
	bh=/t8Ri0bgY0VNCUZqK0akpWyNOljc7saEA/i527fuOi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKq0yRFG7w5eI8juj5Wazzi++9dZczT2bKmcNwm0X4ZX5zzMAMuhfQ96HqKVx5Eq0bAeeZi1UbJYRnr8HJwSgSuuZwVYL5iO2I/BJ/3OezDi7pLi9W2GTbeJwt8XZiYS+e0yvaSoqtRLghpwO4fGOfyn5M5Fz1Urvkf/QMPUAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma+GZU0t; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20bb39d97d1so58250685ad.2;
        Tue, 22 Oct 2024 17:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729644116; x=1730248916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8u3IDrYvAb9YyTBydXzxhlprUyGufXaL260iyoJVT84=;
        b=Ma+GZU0tX6oUiwzyvldqtmo/S899zZJrVybiyT0qeuozn9m22woFkImmDxSzNWDm/D
         Z7s6VM3d4ipm1TzRzwRfL5uLi/vW/dPK75PyoLqEZGLzviFDF6jSWAMR8M7NHf8CtVOF
         D/gNHU6PpdJq2uyw41MnsvNBEoh8yAS/MtrG/+ueY+JaSa1ufKQWi7uA+dq5KzbOEegI
         SjT601VAWdrRc6uIIOucxKsWliIizU7+ep3oAxNJF+it93d1Qev7VrEqeCaEKX4zAgeV
         ubxYeEwD0T4gZSa+Zzo1ZozLyUDRd/kBEosrHC1DX7jZMnKW0WSCWPghdVagVIOTYcSg
         yWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729644116; x=1730248916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u3IDrYvAb9YyTBydXzxhlprUyGufXaL260iyoJVT84=;
        b=gUrkbw5TI1krfvlU5nw10suaA2tYkATdCy1MurBFETVRH1ARx669nV1iblzqN4ZIz7
         GLljZGhDXtAwxfYIhwyclh/LgLqKWZZzlgcCeyJCB4jXFefXIJcvvcAjBBk4Rktx8+tM
         2ZjDSRqxatTu+vYi6ddArRn3liHE/ZT3HerdYoZMRlEnv3xcTTy7aC8g0/cv3gIU1fh7
         M1aaOv8kiMQHLHBWf5gwmJsri5UvSbnOGu/7aITHtaeLlYb0s3rThe7BlSweRuIj+04y
         yo8LKJzs34NbB6r+KYKyzrlD9sKJS8gMbHak4rRHuE8a1z0ip3vtnfMelNBnkEfiaXJO
         o+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCURf/q6r2EqxF4rbZjK7zuCcEt69NVlBRBXJcfdJ0JdDpvD7IiKRaLKAVBkijYh2Zzup8SF6uF8mNq/@vger.kernel.org, AJvYcCXLvYwzvZT3HdOeij1RcOb0Ay2PqFxlOUQpyhcjpde6jAUKjNzAO/yz3wxP3YRF1y2KgijxUGhLeyjuCrqD@vger.kernel.org, AJvYcCXb7Joe02r1zKsU33awW2Q4ciaib4P5hoLkcTqfuE+img6/DkM7zvwGqCHFscLDDf/XR0IqXpio@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDRI8X+MHynQQsJ1MuGJ+2G7EiTRchtlK6s5A9+r5VVbhX8Wr
	HWrskq0vbQXEHV4pS/e2JnKbQbHBK9DWkhKR19ryo5rAbxLCDdsP
X-Google-Smtp-Source: AGHT+IFbhgz4UwAzkmEZqrLZ7CxJnIMNJeELmjeckUQEiAROOsXtNCu++sLO4TJ9d5G/mSS8vtF+Rg==
X-Received: by 2002:a17:903:1c6:b0:20e:95c9:4ed5 with SMTP id d9443c01a7336-20fa9de0cc3mr13205545ad.7.1729644115571;
        Tue, 22 Oct 2024 17:41:55 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f109c4fsm47993125ad.307.2024.10.22.17.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 17:41:55 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:41:36 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <zum7n3656qonk4sdfu76owfs4jk2mkjrzayd57uuoqeb6iiris@635pw3mqymqd>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
 <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
 <gwtiuotmwj2x3d5rhfrploj7o763yjye4jj7vniomv77s7crqx@5jwrpwrlwn4s>
 <65720a16-d165-4379-a01f-54340fb907df@lunn.ch>
 <424erlm55tuorjvs2xgmanzpximvey22ufhzf3fli7trpimxih@st4yz53hpzzr>
 <66f35d1b-fd26-429b-bbf9-d03ed0c1edaf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f35d1b-fd26-429b-bbf9-d03ed0c1edaf@lunn.ch>

On Tue, Oct 22, 2024 at 03:51:08PM +0200, Andrew Lunn wrote:
> On Tue, Oct 22, 2024 at 06:21:49PM +0800, Inochi Amaoto wrote:
> > On Mon, Oct 21, 2024 at 03:27:18PM +0200, Andrew Lunn wrote:
> > > > It is related to the RGMII delay. On sg2044, when the phy 
> > > > sets rx-delay, the interal mac is not set the same delay, 
> > > > so this is needed to be set.
> > > 
> > > This is the wrong way to do it. Please look at how phy-mode should be
> > > used, the four different "rgmii" values. Nearly everybody gets this
> > > wrong, so there are plenty of emails from me in the netdev list about
> > > how it should be done.
> > > 
> > 
> > The phy-mode is alreay set to the "rgmii-id" and a rx delay is already
> > set (a default tx delay is set by the phy driver). In the scenario 
> > the extra bit is used to fix 2ns difference between the sampling clock
> > and data. It is more like an extra setting and the kernel can not handle
> > it by only setting the phy-mode.
> 
> This sounds wrong.
> 
> So in DT you have rgmii-id? You say the PHY is doing TX delay. So you
> pass PHY_INTERFACE_MODE_RGMII_TXID to the PHY? It is not clear from
> this patch, i don't see any code mentioning
> PHY_INTERFACE_MODE_RGMII_TXID. Could you point me at that code.
> 
> 	Andrew

The phy on the board I have is YT8531, The config code is here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/motorcomm.c#n868

As the syscon only has a config on rx delay. I have
already fix the code and only set the bit when the
mac is rgmii-rxid/id.

Regards,
Inochi.

