Return-Path: <netdev+bounces-196515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8832AD5170
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA9517922E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574F25F78F;
	Wed, 11 Jun 2025 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxfldX1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6162405E1;
	Wed, 11 Jun 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637207; cv=none; b=XrwOzit/pUDqxd91+Lc5PuG28e6zPvwD9MpsLXxKP+6W1eG+QsRP229EdNt2WU45gMuuBmur8/WeK3aaKwuWoGsYSyxnTVJBIM3jqskHE5jgTpeA/R9orhjX98gyx4AekRixxnrOfPboSbUOvEgprdCiPy7EP0j+N04h+LegLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637207; c=relaxed/simple;
	bh=nJF7CuwWBB1gORKLW/+1mTNYW7d4oFxecsfF9IbnXEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag3J5HFMmFYo8CcGWefCtlRaUkAfGkx4BdhRvGsisRvGChkCmi3cCyOZr2U1O+yURqvR1PceOoWeu3jmD9LSOaWVtNgEhmGNrkbbKGWi2zlXDEQJNLIdSSjV55ylkaCqQk7hGV0oush8yS0ewkqgcuqRSivf7LCUnP0J+dRvSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxfldX1H; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d219896edeso633461585a.1;
        Wed, 11 Jun 2025 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637205; x=1750242005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMngYw0p0kJljlRaE+vGqGJX3Zi/z2Oh3oWxYgFvc0E=;
        b=jxfldX1H1gJe+Z4MYHwaTRre1V93x4EzYHRbDep62yPjIb6Zen+/pE/di9t0tGatuk
         3Cvtc0rQZaZV6xornzewR1uOFcKRAWmc26IQB9sb0u9umL8uRX5JllCJ16tTlH4kelZf
         8wW8GpwhlX7A2pQYBfx3Nhb2FOmMbzr5dWURmd7iPOSNE1CooMvK0U6tS8bGBSpT3gcn
         4giWLky8S+xRQUaoRbk+TQywsXr6utmeMf0M6tfZol7yQ3x9P9KyAXtcoKnmmqcto0ql
         sRyCY9eCdW0l5ADpxMjhz59xcrz6FLTT8XI1DI9q5H+Z/KHxpdYUzhDQPRtEAKjM2EHy
         8AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637205; x=1750242005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMngYw0p0kJljlRaE+vGqGJX3Zi/z2Oh3oWxYgFvc0E=;
        b=lUrdzoxpn6bNFnoe7bRHEyqsSvjdKawq9Rx2d1CzCWRsvOC3zvCLjmvMKaIvQLA2d5
         hb50uIzZoGvmhxXqtVh3kbR4hufXD4MgZ2bUx1pt/i3SDjnu9zAd7cFmCqqfea50r/KW
         oidqy0QUdfLl2K4RHT4TQL0ajp3wSijYf3sSNkdY2iDkSpL7oXLz06tVPx3pi3l3R7wm
         JxyANF6Fr+zHfM5U7pwtFWA2Lr2VUwCfhI5ijhOlgyPA/Pr9Ax6opVzOntjBoO1VvBPw
         m6ShKQxIXeHhHpUD8zFfA7lOOluYooCflgJb5pvxtYAEjSE7i6MMWv8vCaOw65qGWS7j
         5ayA==
X-Forwarded-Encrypted: i=1; AJvYcCUDPOnWzIS7JEYu6G7UAYoXMzZXXgGEhEvOFJwGxu/8zFxUcVnSyHygNpxYg5YYfeePsSmiW4BV5T0M8LFg@vger.kernel.org, AJvYcCWpjMaengXGEjHTV4AqAIxQ2cxpbWrkW1ix41u0eTtP6Mja5obwmkXoQyjR9eprEBSNasIdXioUNBON@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAWZORgid54Xd0OqhWASWL6JUi/lzu1Ua0Kld2DanTJsBkxeW
	rUDpoJGXPokWmZAX7SlgDJp3FlH7k/piRQN3XeBKpnlLVP6XeXJqPtu2
X-Gm-Gg: ASbGncvVkK5ztB4argoZuYsegNzYTZnBL03G+Tg0LjErpAHJYk37bcE1tsjpCEslWdX
	K+Itx6hW2ZprFSfQ5jKL87vvEpUn2mSb3vFv6k9P0FfHLqeZo6iprt+sMUB3l495hBasyqtFSAR
	x/oLVg9tcO0Y2qvEVbK9pbHC6tnA7exvSTKcv/WuoYGaNc9kfqR0cXcgBnspC4QNayghOflgv6D
	KWUgvNXkvyVLs+LBtaybmXBTKxUKH59CqQcfhkDXxX6Vjy0hjT5FyAdzUpALc1QJ4bVONeS5VQU
	bSKwKEv5HnSekjIWAg4hkQxAN2Ytkssh/+Iisg==
X-Google-Smtp-Source: AGHT+IGwWvOgxGgwWmHI6DFqSfjr/uyZDHPorlij65HU+xBh5KwHFJsTWak5AN3OsIOGWsf82thA1Q==
X-Received: by 2002:a05:620a:2482:b0:7c5:49b7:237c with SMTP id af79cd13be357-7d3a88e40a4mr411224185a.27.1749637204812;
        Wed, 11 Jun 2025 03:20:04 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d25a536b57sm837492185a.44.2025.06.11.03.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:20:04 -0700 (PDT)
Date: Wed, 11 Jun 2025 18:18:55 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Richard Cochran <richardcochran@gmail.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet
 support for cv18xx
Message-ID: <jhw5maxfyowusq4ik24zrvlpjpj6vk5wqpfj6rhgb6b3muftec@5pumwwambikx>
References: <20250611080709.1182183-1-inochiama@gmail.com>
 <PN0P287MB225839D83F1A65D65D3EA6B9FE75A@PN0P287MB2258.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0P287MB225839D83F1A65D65D3EA6B9FE75A@PN0P287MB2258.INDP287.PROD.OUTLOOK.COM>

On Wed, Jun 11, 2025 at 06:12:54PM +0800, Chen Wang wrote:
> Is it should be v2? I see an old one https://lore.kernel.org/linux-riscv/20241028011312.274938-1-inochiama@gmail.com/.
> 

I think it is OK to treat as v1, as this is originally designed to 
be submit with the mdio driver. I split it due to the dependency.

Regards,
Inochi

