Return-Path: <netdev+bounces-157246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A78A09A4D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D616A47B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0E22FE13;
	Fri, 10 Jan 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFbVpPkF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273C22FE06;
	Fri, 10 Jan 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534595; cv=none; b=iJHNCOLfJUjp52q/prjgevf9/8DB0zk0uFEmnQcW6iuQG+IndN/BDSKlVzCo0q6mHDi25VqU+62fwRlSmcPCmn4yvel0ikqHQNKuyxUVhEfn/uaXw8yuzVE1TBcA5UWz1b0sJnErGaQuzBcOAVcWt2y3dO8Cz922IxhcXbTHUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534595; c=relaxed/simple;
	bh=6dkhHUN0Su2ogDJBMvEPYalifngBoB9ojGIrbZ5HJSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIOLs+D/20y5L6F3v2csV2cl33xH72GrfvPk8BvPgDoco9vR6t/D0lWsCCmE6dczd4Lh9wVraBwXg4lC0RIZotdQAygPXXSu482trA4fTaUexP6jR82td02wd/Wq9X4z2bTHjCxKQ6426DlZD4j1aZoPJkp9A8zv4zITW2OkZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFbVpPkF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso17749165e9.0;
        Fri, 10 Jan 2025 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736534592; x=1737139392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zh1dI61/VcjM3SgZ/DpQf6kNzaNnQAxLldHj0o3iRZU=;
        b=SFbVpPkFl6O3yfHzarU4snk29ySJS+WY6xNtn70RRskQi4qjppSnPkm4bTu3eduPNm
         c0+oDPO/VZ2pek2dBWT4NJ8uoh1Lejrv86l/MOdakI2iAcGjnzkH2oSwd5vOSXxuyCBi
         DWaYCDuz6hHDisROgjo3mXGMa3aQKk5RtbrmuafHgEvfPi9BO8iXfOQTvc46PV1WQfp9
         +7+su52S/x5kWiPmQx9tOgUlmnQcLLrLdip3jp9qpNoAgA77/n3AsMGxIDjlgdJuWHwO
         9MyMV628R9YkoC3vTNVaNex9gBIYrs1YXcMyLUYBm3N+NtnFZ0GZdjiRfxUu+oB8rjy2
         MzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534592; x=1737139392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh1dI61/VcjM3SgZ/DpQf6kNzaNnQAxLldHj0o3iRZU=;
        b=O1jhALj/hQKcV7BQup+Qt5NrLkEk1890y8FoU7I5GAoYDbBjspgvQChJ232kjE9Mww
         N64FyXCJnY8xYDNeE/AK97Pl+bXMQwcr37xu0hQ33mc4IuF6472jFU1iFrludTk9rQGC
         6/T74qANuel3Aqwbr2EtoDieTbJNTLmqXAVhe4zM/NZa8X2RgjzYwDlHFWFknbb/qn2u
         rf5P3Wl9VYD6/mfwf83WmHgnqIKJji/KuB3npZCy3xqWPEGbeGgzwRCVsN3bMnztshtA
         irTBif9fV7x1e8b1bor5MujoKjxbm6SAcKAVQf/oA8viQ2dkXp049YWFrLyQlzCxKFHm
         5HGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0X5YsKMUfh1HJt+vbBUykndvwguWXk4KYyOL4LWKcWiOQC1RT/F2kuLP9b+68vusgrev+EsnM@vger.kernel.org, AJvYcCWFyHaH9ejR1KXejkmevwNt76tF4GOlsFa425Ms9XvI9a8Qh/slTM8fgwviCPm5e4JrlNwbOyEnfLDm7WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCByk8IEDxHnO3+xCiQdmBtHWZbGCsOK/6DCZ6/PYIPYco+OVH
	aY7WnDqyiUF3cLLgnDzMw6yLX35hQmI8Ltbfpqvt1T/VBXI2QZxz
X-Gm-Gg: ASbGncszygdx6Z1ICaLYfNZhLmf93dNslktE/oK5hMI2wNNXWolZ4BmhgHmMUQlpKZ3
	3BNFJsR107G73v19IqIiWxExuA0uBxvyvivjG5vXnt6ILGWbyV8SU7IsyskqbAs/C2Ozq37/GLy
	jcmMkuFf6XSPkUAJ0xUfQhcGMASPyF/guMvHp0z2XNFgBbpcNwAxaDvNimZCzmX/ZhSmEdf427/
	eDV0WuQRAMPIBiztglAv5yPZOwhmt0Jj75ZH54S820wCriI3YlQ
X-Google-Smtp-Source: AGHT+IGfUP5FCyp8vpZGEyC/D7Hub5IpegrnGye+H4H3WKcsIpkFw6SH1xptdBrjSe4u0lNeDIWxRg==
X-Received: by 2002:a05:600c:511a:b0:434:a239:d2fe with SMTP id 5b1f17b1804b1-436e26ffdd6mr90015585e9.28.1736534592094;
        Fri, 10 Jan 2025 10:43:12 -0800 (PST)
Received: from debian ([2a00:79c0:6a1:e700:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03f62sm59547975e9.22.2025.01.10.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:43:11 -0800 (PST)
Date: Fri, 10 Jan 2025 19:43:08 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Message-ID: <20250110184308.GC208903@debian>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
 <78af361a-8935-47aa-9114-3cf5c1b8f7dc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78af361a-8935-47aa-9114-3cf5c1b8f7dc@lunn.ch>

Am Fri, Jan 10, 2025 at 06:56:24PM +0100 schrieb Andrew Lunn:
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */
> 
> Are 2, 3 and 6 defined? It might be nice to include them just for
> documentation.
> 
Ok, will add them in the next version.

Dimitri

