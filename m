Return-Path: <netdev+bounces-137468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A399A68D2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFCDB259FF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE811EF956;
	Mon, 21 Oct 2024 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVFuWCre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBD1D1F6F;
	Mon, 21 Oct 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514312; cv=none; b=mP87zVe2hmhbL3iFNzZ0i+h/E26R+RgVfEtBd6EZ8phInryWUFnSRHIIpvwnG5aozRh6mFhfaxXYMMq8ID4XXYHWEBxhUoHeeY8RPOubSMmfE+LP9G6uZ15P/AR1k1inH8xUeo3FRi+rN0Z8qwfswal1iDSL/5ny8fStruWuy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514312; c=relaxed/simple;
	bh=yNL8qYUq9HguxJnTEcF9WvrB/HYXaTpAV9wVobmZLSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4oex0cUl4ZIJ4biw/IY1tHuttQ14a5apF7AQ2+FeZu1v5UBFlx4o57RnCtza3g1FO+A0AbAXAOsnbfXoh8kAPHvkIqMmaKvYdTjX2aBjxIqShqULzifN8JQ87Rk+Z4PPtr7uRbxcG57gPZUmmji+Nt9K7lm81UUzaKO1Gp9ya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVFuWCre; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso2919783a12.0;
        Mon, 21 Oct 2024 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514310; x=1730119110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VdkMJahzYM4ARizPLfC5JGwlmy+1HUcx/YnyM/NNsU=;
        b=VVFuWCreAby1Qcr98pBiRo5k2LuHZWYOnYUnZtd8KGeakFNOHI4mcpCuqt+IN9k2BC
         SClE5DkM/Yn7PcKqDvI4VYabLqzawbMZ6QFhfLSBZTJ0tfqI+bpG1Omh2WDwe0ILGnEj
         cY88If3IbGlWl+3EL3nhRKZ7tugcJGYBblIQALdKFeVxn5W5xmuLIsFdLGIoOyoS1BYW
         O2/G4HU7djYDo/Hdr7vgc62IxgsQZb2yeAER8TKH9Oss8HPxSUbSGYfY6pONrFKi05zT
         TV4o7JA2zUouKv/iyx4y9nsVXPDgJT8ysQJkQ5exPxQ6MNpcNWhFaQ3g2nMetZ5rBerm
         NfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514310; x=1730119110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VdkMJahzYM4ARizPLfC5JGwlmy+1HUcx/YnyM/NNsU=;
        b=Xs+OnCnN2UC2t/y7PEXUe3nFnH1Jhh8ttvIOc5r5OTxPD+Hgl4E52IUQDSZGkMNF91
         165Sbi+gGxMae+/yVt5yBfSJVLap9D1b+FC2lqsTb3kFQSLlns10HrGKNlZhlzaDwvAD
         ygCSYAViEOogOdjYJR3VFZhmwvv6FurvBQzmfg4A34MtDQyBIorIt//vTx6o/ggLmLiS
         OYXEYPvG6S216ZXn1QMFBDtTo5HSgGejEs+SbEoq+AM3ZTK4VDYtZMRHHPd1H14ptmZ2
         ADXCaFJc4VlQm9AE8Xn5Px6CP80fQqsK25+fTdJjLdVO7NPzWfdrhRAX8dOrLGLMPKO6
         ZCJw==
X-Forwarded-Encrypted: i=1; AJvYcCVjinp7HQ/NVCRc9YPZSm/kbRKToOtKAZ0YDu8ajGMi0BLB8Lt/HlUdSmm7YhFVzh/fQOEfnshBD9kUKRpY@vger.kernel.org, AJvYcCWqMTtUKvG7aq+EVF9slZBzXm13qS8RSO+P3C1GDDjxamPegSmBWSzxM3FV3hB2L/o8PK3kQXT/aGLK@vger.kernel.org, AJvYcCXblrOgrNy4L2FwbJPdtCrervU0yvzINgJI9G57FMPSDJP1a2nbR/RFuZaVOQ6aczgmwmJX/Bhi@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGoEeK7R8CdRU3m2cYlAgpqBG6X8vAM/7uQm5rAKiB2eIEjFm
	xJrIlQ/gMNQYE8wYqWPySoVQGwsCjncCAOwe5gAkB2YSNWp7vbVu
X-Google-Smtp-Source: AGHT+IELTG5U+pOWjQan4mOzNnHckdPe5BPOOI3wlomTskXwd3e2mPKfcYsxX04oUIZTOqrQqVQjwQ==
X-Received: by 2002:a05:6a20:ac43:b0:1d7:109f:cac4 with SMTP id adf61e73a8af0-1d92c9f873amr17387168637.3.1729514310059;
        Mon, 21 Oct 2024 05:38:30 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d6bsm2750800b3a.29.2024.10.21.05.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:38:29 -0700 (PDT)
Date: Mon, 21 Oct 2024 20:38:11 +0800
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
Message-ID: <gwtiuotmwj2x3d5rhfrploj7o763yjye4jj7vniomv77s7crqx@5jwrpwrlwn4s>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
 <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>

On Mon, Oct 21, 2024 at 02:22:47PM +0200, Andrew Lunn wrote:
> > +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
> > +{
> > +	struct sophgo_dwmac *dwmac = priv;
> > +	unsigned long rate;
> > +	int ret;
> > +
> > +	switch (speed) {
> > +	case SPEED_1000:
> > +		rate = 125000000;
> > +		break;
> > +	case SPEED_100:
> > +		rate = 25000000;
> > +		break;
> > +	case SPEED_10:
> > +		rate = 2500000;
> > +		break;
> > +	default:
> > +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > +		break;
> > +	}
> 
> There was a helper added recently for this, since it appears
> repeatedly in drivers.
> 

OK, I will change it.

> > +	ret = regmap_set_bits(regmap, args[0], DWMAC_SG2044_FLAG_USE_RX_DELAY);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to set the phy rx delay\n");
> 
> Please could you explain what this delay is for. Is it the 2ns RGMII
> delay?
> 
> 	Andrew

It is related to the RGMII delay. On sg2044, when the phy 
sets rx-delay, the interal mac is not set the same delay, 
so this is needed to be set.

Regards,
Inochi

