Return-Path: <netdev+bounces-162867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD7FA28376
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 05:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6163E18865E0
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C04215178;
	Wed,  5 Feb 2025 04:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b285+VjE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2BA25A647;
	Wed,  5 Feb 2025 04:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738731119; cv=none; b=S7FqhjnvikP/iJjaY0ubxR4LHSxps/PQDOJDGcufytnalfH88enpkRcCPZfxtXXiKE2/IUPI1T8/yLmw2/x+Aj22eSWQ9/ZCf1j0ZQxmdXPH+slnQQjuEzNFUl4Gd+FmX/m7L1KPbcSz51ziu+ZU/lT5T1xScDQ6yswuOHg6l7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738731119; c=relaxed/simple;
	bh=ybGdNS7Y8l7pGUYL2bJBbTcs7iGTw/euiMwMI47xFtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzatuPTg9JwlstFLgftvdiLWUPC6YHCQmJtJmB3Sd3HJ/IzBM1aI6X+e/pUnqvj+O+r1/TjriJ1WZn228ejgKLxSvPda4my6VVM1DaT1X+yJzIfSfNht/L/Ne0VY8jWnJZ6tBYJ1HE0hvzXdUydmP/tDwtLCOvjGfwcBISk6JRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b285+VjE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso43846855e9.3;
        Tue, 04 Feb 2025 20:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738731116; x=1739335916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfOfy7nuYPrPw4/oQ9CZSZg1uMT6cOxvBtvO/o96Zv4=;
        b=b285+VjExzzq4Acph6D2uyhQqEHF4SFVw80IjGTUL/h/5Szpw4HSwVKGW/rAZ6UBle
         KXs2VqjH4VpLGdizYW09aUlA4G89QfrIL53lky93elJMbMKDwJ04ra/fh+eYJeVnx6m1
         uCoQBwGjIV9BU1z1oWWxS4H7TklnymQeLBoSg1tlQrWYduCJEHwe8C02wiuRDGMLGrel
         Rp7HoiEVWtt/IzZAN+Qc7gH8wx61L5VyjO0xideD+0tkDNLAcq/y65nrfl3rSL339Tg6
         +DwcNNWtkIsoOUuvUL5SF4ddxSXnj2+68PMrG8m6BHA96OnWZVdX8kOaJqzscC+XsMqN
         V0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738731116; x=1739335916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfOfy7nuYPrPw4/oQ9CZSZg1uMT6cOxvBtvO/o96Zv4=;
        b=CRmlwhJ4jsDX5yu18Om6Qn+XknwboQR8a5xMZQCQcvQbrmbPq+v4nsWJbE6Hslu5v7
         JbC6uLzJ+Uvsg10Em2Tjxhc5LuVBmHVugbfIAaoN4wAJDOHFzpSegyEn5cUj+5Tf5WNZ
         xEcWt7sJVDFL8cY9P15w/YOUbSHraPuWvXFd6S6xZIEtQzkcsiQ0P+Ms/iBZobxiqfZE
         8/RCAvUsgSBsxPO6HzXzJkAZ2nYxJyPwMzLz9cGsVSHOvpUPt9X7OFDXltcS2JrlMxFy
         wnXTqp5daTdbrm4CCShn1X1Ex59PXSdSwERZRsc/sA4bIKR8xZeAZGw3hLwWOUsTNsvJ
         ZqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1JHmcYQHHAdKu1GNNV4adIQhWrqkLv/RMv1QK9rp5X3nSAF21NEAkbCpM30alAb2gOtH4tLwCzbGJ@vger.kernel.org, AJvYcCUBJVGUN+FEwlJ0xMNMb8QCs8kDZAZshcur/N+fo/uEfatA12oCsTCajCnv2VnWJNC5mYVcdEyvfBFaQ5be@vger.kernel.org, AJvYcCUHYVXCWgcw+nFuBNpWFPbEmrYROgxUjsFh9YFQWq98dyTx0E7NwVtXOYEVAHNqgzKCksUPq46L@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJcQSzgDXwGv8zveR8KagmCQSo/FpJw7mAThSmYii38KHqJQE
	8lEt2mFgc9GQYxeg+0dy+S8LigAiHMS7BaJBjVrCQurlAQbJJh/643sk6Q==
X-Gm-Gg: ASbGncvJgm1azRk0dLA0jTqhvINhU7z7B7LXPldqcwFpZaCz3oyVaVYQT5w+3YXdlom
	pYEoEKWtPmBzgbfFlaVEp+0NF1Row2DDktb1qfrM+VkWiVD04bHGHmDi10ACo/BdiqSrs23McQP
	OBug3x5Li+a3Njz6CJfiK+9uTs78ZJr3GgUkzmO+Z3MlrPsVQtyfC19gnnjPbLSIPvbOiZWpRA8
	D5tiC7ubvS8/WBzpJ3vCwS2c2SI3GbgD1OaVXE/eTj8nt5Ce8vsP0R54jXPYVTcOhsQCxTMlQNK
	b/rlzPAqHTaQ
X-Google-Smtp-Source: AGHT+IH7OjSXcBztKA3M+F9dW2Yvv6x77njhpIJzy1ygqnkDtdJ/IOfQs+r6CPrs07u1hzSKjJTc7A==
X-Received: by 2002:a05:600c:5127:b0:438:da66:fdf9 with SMTP id 5b1f17b1804b1-4390d43f779mr7311655e9.18.1738731115808;
        Tue, 04 Feb 2025 20:51:55 -0800 (PST)
Received: from debian ([2a00:79c0:661:ad00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43907f16ffasm26910505e9.1.2025.02.04.20.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 20:51:55 -0800 (PST)
Date: Wed, 5 Feb 2025 05:51:52 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <20250205045152.GB3831@debian>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
 <20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com>
 <20250204153409.GA2771999-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204153409.GA2771999-robh@kernel.org>

Am Tue, Feb 04, 2025 at 09:34:09AM -0600 schrieb Rob Herring:
> On Tue, Feb 04, 2025 at 02:09:15PM +0100, Dimitri Fedrau wrote:
> > Add property tx-amplitude-100base-tx-percent in the device tree bindings
> > for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> > necessary to compensate losses on the PCB and connector, so the voltages
> > measured on the RJ45 pins are conforming.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index 2c71454ae8e362e7032e44712949e12da6826070..04f42961035f273990fdf4368ad1352397fc3774 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -232,6 +232,13 @@ properties:
> >        PHY's that have configurable TX internal delays. If this property is
> >        present then the PHY applies the TX delay.
> >  
> > +  tx-amplitude-100base-tx-percent:
> > +    description: |
> 
> Don't need '|' if no formatting to preserve.
>
Wasn't sure about the '|', because some properties use
it(rx-internal-delay-ps or tx-internal-delay-ps) others not. Is it wrong
there ? I don't see any reason to preserve formatting there. Anyway will remove
the '|' as you proposed. Thanks for explaining, didn't know.

Best regards,
Dimitri Fedrau

[...]

