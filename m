Return-Path: <netdev+bounces-197856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE037ADA095
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 03:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDB4172FD6
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCF21ABCE;
	Sun, 15 Jun 2025 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvQXn4Rt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C53D76;
	Sun, 15 Jun 2025 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749952482; cv=none; b=Yd5G2qdT2YEJQGWtj+6t4bsQ7zwchvywtUFsAW0xtkwDn3GrQtfWg5qygAJYdrpm3qGwfFHAqTvu6uDGg73nJWkJII+aDPRCxjQIX+kK+YaTEGecSjrrXd1GVoutjy3gJB8eWyR+3AT18dHgFcwool+fzIN1Zw8Tg+UjkXiwXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749952482; c=relaxed/simple;
	bh=6C2RDlJPH4hHsu7KG3FoXJp08o/U2CrlZ7oO+N9gI/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrrdhYYRSl1c4TBIUpzjt5ST2oeZvFUdadvN59uP5Uz3WJ/TjSyBF5id0QucbfuzcdtjShjmWKMpKWnNBaZq+WUg9/JMDSLgUa2/gWP9uhPsY2P4dX5y/sKf/5Nz3qKJm3Ck3MjL+3lKWTY4wH2v2I9QcDAYuZNJm9qDvrSRdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvQXn4Rt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747e41d5469so3623147b3a.3;
        Sat, 14 Jun 2025 18:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749952481; x=1750557281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6qcLpg2zNBg5kLLZmOuaMXSNL8jEGcJ0sEklYczzuM=;
        b=hvQXn4RtMnKgtW/a7MEp7UkaB5o91IOVG/CEAv63mkLWs+8ZEvgWL+Zn076NwxLvhM
         S1rwG7s7t7h+cRHrqXgD1rl2/H9OlI3E7bcyUajVntpV7XSlJ0iBQtu0BSkm9WsyaV/y
         E3syaZNGGlq463KbdHbTeDR9RXzYiqMcWQbzEs7LN08eiXFmVL1CKb7BsBbkzA/I8Mcg
         O9fQy+bs6DFK6q8g54RjfGL7Crwf6idcEcvBO2uGOyKZqJ7ZV/g3KEV6g5GiGeVtpMY6
         vU4jem7u5ZQvJiYhrOmnS42vDIFJOqztLiZ9ETcAq91ZmjSH5tEAmwXJc+FTOiVV9iQq
         lfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749952481; x=1750557281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6qcLpg2zNBg5kLLZmOuaMXSNL8jEGcJ0sEklYczzuM=;
        b=KJpU09tWBqbD+FLGvBl3J+veJElPv4n+p9aLczWvw5YNgUsezOsQ5thRAl4oWxFyc0
         z2Vap+fa2Z27PMBO36jtTFczJ5pUPstII1o/h0Iyezx3pUgXVN/5z4QZiIQLA5jXOPYZ
         0QaJ/kDsqxIU9G4eNhszSHGfQtSgFf51H/qtHjG4tb/irDRtKc6MuBEDIkOl0aAgTIIT
         Be4q7gtsDhHSaOZbBB3rjuJYxKQs5wkhUimhLgK2FTTPJXYueo5o8/uKYzk55SLb0n5W
         xKJ17dZ8SbcwxtBgh44Udeio9frw7+3VpkFIRfPMu3h1gKOoYSP7qNune1PUSQP5FpfP
         7ajw==
X-Forwarded-Encrypted: i=1; AJvYcCU6lIYJCj96I7zadvmKFEWm0BFMFGHAvp5Q64b3D8Sfo0X/K3Ke+E9bWVLdCBuae29pc9lbQ2oj8/Fo@vger.kernel.org, AJvYcCUwIEuAzf0jjyB3fjdTg4t67r4Vk6pTIY+WZNQAaL6ctj03lsIkRjIEC/b4byOcBsZUX9Nzs+va@vger.kernel.org, AJvYcCXPi5oifw9g1oBStYH8Gm3okR82GAnUbM9idsQmCKJO1X2zS3/Uxcu9XCTdzcOlcMm2IkMzEAsweQ7dJD5E@vger.kernel.org
X-Gm-Message-State: AOJu0YzbG7YcFVwbRbmr2Hxfv9rDM+ffJzpamCZysJgwok8W490WoDWu
	CAIQc6Z+KHG1I7hktLbn1A2z08OyMk3ncRJXtwZz3/iSZ6p73D5ZzCQe
X-Gm-Gg: ASbGncvS7I683jdhNuh7WI1izwoO9EWMnJjy9LC2uElFTCmcOzuU6wiT/KyXKvJXjp8
	r/7OxgY75zx7s6T907qfzhnKdO9WfG/qdiIk4BqTynvOA1xJZodGOZeuQY0BU1j1YsnyFjaMbbg
	VFYrj5+BXZ/z9ktJOjYUuzkhXptgydRrwuEgCy5z/c4glgF/Ruj6ewt+dVi2+xVEOnVYegQ+osj
	s/qpWVAfp4Gr3LHvztMVGXISd1VkW+0OUG3MA9/aw8pdUIZ/8AZdrc9u/ZhxKMUEJWm/mtbmI1s
	3z5CCgJhFp2UaU+Mw4Qv2g7uP5fKiFqx8Yy9ayYMm8lyifJhMmN0GKnRPma5Dg==
X-Google-Smtp-Source: AGHT+IEfbkfcZRq4LtMkAB1ieDknj+ZtHn8ASi39Vjkgb0xAmI76H9GASGCBjwsfab0bMI2SVyGiQw==
X-Received: by 2002:a05:6a21:328c:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-21fbd55aeefmr6746644637.11.1749952480676;
        Sat, 14 Jun 2025 18:54:40 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe15bb83asm3467761a12.0.2025.06.14.18.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 18:54:40 -0700 (PDT)
Date: Sun, 15 Jun 2025 09:53:27 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, 
	Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Ze Huang <huangze@whut.edu.cn>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet
 support for cv18xx
Message-ID: <risysfu5twua4won3jajotsg36ua6gpevoqnsawny3m2n5bj3g@srls6h24kmw5>
References: <20250611080709.1182183-1-inochiama@gmail.com>
 <7a4ceb2e0b75848c9400dc5a56007e6c46306cdc.camel@gmail.com>
 <e84c95fa52ead5d6099950400aac9fd38ee1574e.camel@gmail.com>
 <05194937-8db3-4d90-9d03-9836c734fce1@lunn.ch>
 <55df35f66eeb8580b21337e4b2738801117c125a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55df35f66eeb8580b21337e4b2738801117c125a.camel@gmail.com>

On Sun, Jun 15, 2025 at 12:34:24AM +0200, Alexander Sverdlin wrote:
> Sorry for confusion Andrew,
> 
> On Sun, 2025-06-15 at 00:20 +0200, Andrew Lunn wrote:
> > > Also ethtool seems to be incompatible with mdio muxes :(
> > 
> > Please could you expand on that, because i don't know of a problem
> > with mdio muxes and ethtool.
> 
> everything seems to be fine with ethtool and mdio mux!
> (I accidentally mixed up host and target consoles)
> 
> # ethtool eth0
> Settings for eth0:
>         Supported ports: [ TP MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full 
>                                 100baseT/Half 100baseT/Full 
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Half 10baseT/Full 
>                                 100baseT/Half 100baseT/Full 
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Link partner advertised link modes:  10baseT/Half 10baseT/Full 
>                                              100baseT/Half 100baseT/Full 
>         Link partner advertised pause frame use: Symmetric Receive-only
>         Link partner advertised auto-negotiation: Yes
>         Link partner advertised FEC modes: Not reported
>         Speed: 100Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 0
>         Transceiver: external
>         Auto-negotiation: on
>         Supports Wake-on: d
>         Wake-on: d
>         Current message level: 0x0000003f (63)
>                                drv probe link timer ifdown ifup
>         Link detected: yes
> 
> But we do have some troubles with the internal PHY with Inochi's patches
> on SG2000, the above "Link detected: yes" is actually without cable
> inserted.
> 

Interesting, I have tested this on my Huashan Pi. The link detected
switch to "no" after I pull out the cable. I wonder the test step
on your board.

Regards,
Inochi

