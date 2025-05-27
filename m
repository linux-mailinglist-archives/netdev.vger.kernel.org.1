Return-Path: <netdev+bounces-193765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B59AC5D31
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 00:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCD1BC1080
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8201217701;
	Tue, 27 May 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEW0Muka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F41F03C7;
	Tue, 27 May 2025 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385592; cv=none; b=su5KojykXZh10QmqWNGijtCQfKoYq9HXb/cHEZ6+uwfQvmopl9rtoURZfkeINj6532x/P189nMvhzJpcaILPNkeuyz2T1gZTI+dDsFUavhvS5omEiHnfGPXLF4gR3+8wMdzprOERNeM1QrHTHZxX1M3nAG1UbkHxWON+EPj6Hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385592; c=relaxed/simple;
	bh=ZWUPQWYwOzwCLHEKBB/FWs/qMTaNwaZDoUZrhNBZrs4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZqi9LG0UmWA8FTHQOXR96QUM3IS+cht/Di4FIlMZo0PvoOwDM0qHCDwcz971lgnFWWhTwciUTuk+09wdc25Ok8YogWcEnZu538kZytOhExy15FD1emW6y1Fx0XKpInTS+pQerqyt/2g3BWFUkNZ0G0b7Gy7HoCKf7fNcKkQYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEW0Muka; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-445b11306abso24088405e9.3;
        Tue, 27 May 2025 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748385589; x=1748990389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rXlkOLWu/sGGOm7ZnW+mm1CcZhJX8uCPhkdivdDeQSU=;
        b=WEW0MukatXf/gaLwxJF0fYQxy29YnMQZEGu7bUGH4fMwm+2nzWuYfyabFn/WW9Cnkf
         dQduplC+tX6vE1b5OIVBFie04Rfd66dSnaNdbXy1/lTOvBJsVuYQUiwKBeHCj8QV2OPZ
         0q8sfMsOJsvg7U0f7+Kh0XsJuYYziKv9WXq+sr0ovbF/T3YUa8A0vpsPO6YSMKW6nPfv
         tdbmQhx3SYW8p6+MT+PlhZrUdaa4cQolgRVb0SVricczsgqNYpvq69OXjGLq0f4VaMPV
         6WNGQ6/K4CgsXERNtIjHa+54ZCvXFFa0w6gpZYD16j4/3duHDh9c0Bk/IvFsKKM48gah
         DW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748385589; x=1748990389;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXlkOLWu/sGGOm7ZnW+mm1CcZhJX8uCPhkdivdDeQSU=;
        b=syRDaTnfOwKeTt+6HwQbaiuzxhzmOQaO/joUIeR7NcvIVI54a2YZhj6Xca1CjQsv/U
         6IH+hj3isYC923df0SM8tV/m4d8tq3NS2Y7/4Zf14e2Kc6nhkOOnhZ2S4TdhmdzyOJsl
         tkruLVLay4Gc3YXfVE5zmUmnAkl6IWPVwa4TkJgdlm3Q0gwVZmNKRRgCVsC03L07YhfP
         /ZGPhd/AfmkuN+U9AkFs1wxHnVAEYewvzlIMlEQ7RS0xh2HPsHV4sV/jYq4dvv+zFJtF
         UL9tMGp31XOlx5wSSiT0IbdDDDYWelb3YG0uuVEGZ5JGb+DhvgBrNBMHr6rJM4xmJ4UE
         /Q0A==
X-Forwarded-Encrypted: i=1; AJvYcCUpTNSR+tXu3mSKIDUPAm2RW26L4KAYw7yew3qEd0oqylB8uT2tz62zOLSg6GB7A3+4QVRE4mVkh1Q5xP3P@vger.kernel.org, AJvYcCWj7JzxTYwQTLVIzDq/tocE8xOn/FUTe5nevNzhiW7z2BTZRnHlm9HWf2emfrUszchbyx/VCoXd@vger.kernel.org, AJvYcCWn1vORayYyHGLkeVuhQ5kHU9BYl3Vg1iratKEabgViHidjS2BtIWg/ifW8cN3+8flwAnCZFvEpZ/ku@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVf4ddVXjJknmhRiVvVuKtcgeSqRMgltrd+5S+6+mu22169T2
	ohNN9Mg4ei7FXOx8Bt1dllqSZkpiK6CwzhItSOPbOnydVUlZZ8jSf9/2/rCMig==
X-Gm-Gg: ASbGnctdoKvEEGEWMVdR0lkxqPXAbdtMtbq0TM9nWz6Uf575zndTyea4dsHQ3dqBBFI
	XZK2rTTL/MdsxlZGWmWWP3dN0Sfhe8hxCgkvEgNPHfoWapTEttYAZXrctkApkoVC1z87fZyvTzi
	Y+4ocvPOr9Hrw4emsy+vioFV6LxLnZw3WmvT8xm8MbS7P0a6aAcRdxgMOfUCn/afTPRQdZClvvz
	DMeUelqKU3QcJXUI79UeYMFhLCcjJDCCz9esrzBj2DCORfU5p2CJNWKk8WL8c6risb5jQUAQldz
	iGaue3NCWylcic63jdbFP6VcPO9eWIkm5uMkF4A64NbDMalle04ahh3VEtdmTVGVjQQcFuypYlq
	GsZvUc5M=
X-Google-Smtp-Source: AGHT+IGMU3ZZNmMTsQBRTaisRadDq5tWfFTWYpn4y/0cYXJzWFz+DLuX+iFQKWNj2oCsMtuZDLpImw==
X-Received: by 2002:a05:600c:3caa:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-44c937d1443mr138218135e9.14.1748385589055;
        Tue, 27 May 2025 15:39:49 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4500649ced5sm2154595e9.15.2025.05.27.15.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 15:39:48 -0700 (PDT)
Message-ID: <68363f34.050a0220.351f97.06f7@mx.google.com>
X-Google-Original-Message-ID: <aDY_MbMi84LbQtyD@Ansuel-XPS.>
Date: Wed, 28 May 2025 00:39:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 2/2] net: mdio: Add MDIO bus controller for
 Airoha AN7583
References: <20250527213503.12010-1-ansuelsmth@gmail.com>
 <20250527213503.12010-2-ansuelsmth@gmail.com>
 <e289d26e-9453-45f5-bfa6-f53f9e4647af@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e289d26e-9453-45f5-bfa6-f53f9e4647af@lunn.ch>

On Wed, May 28, 2025 at 12:36:46AM +0200, Andrew Lunn wrote:
> > +#define AN7583_MDIO_PHY				0xd4
> > +#define   AN7583_MDIO1_SPEED_MODE		BIT(11)
> > +#define   AN7583_MDIO0_SPEED_MODE		BIT(10)
> 
> Is there any documentation about what these bits do? The bus should
> default to 2.5Mhz.
>

No but I can ask. In theory tho these MDIO controller are used for 10g
or 2.5g PHY that all require a firmware to load so 2.5MHz makes the boot
time of 2+ minute.

The documentation say...

1: fast mode
0: normal mode

Very useful I guess :D

-- 
	Ansuel

