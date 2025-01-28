Return-Path: <netdev+bounces-161360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1FA20D41
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B881B1888D6A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E31CEAC3;
	Tue, 28 Jan 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0JJ8H1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1861A2387;
	Tue, 28 Jan 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078992; cv=none; b=VmD9vjz/a4sIF0c0sTzVKoi6qnyW+4v/g6jDzYdQjbj+OAHxr8AReB+Qrn06z9hTWcgYgHVTKY0zsWmBz8Qc01wypTkDoehb/ihe6LaV0RtVKGMPBiCuMN3VOzccXZmixbJmoTHeZGJPFPL4k68vHbRJqJWdZ7MbhELFWWBTqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078992; c=relaxed/simple;
	bh=TlVuGcWye1dOzFa1F+GG5dc/6LXQPuETxcqKjOcLRF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkzrfTrA01bIc4ip+Bx9TI2ARrXBia5fpkAj7oC4sL2st19aD3ODzV6FVvjbv3q/PzRmfQsztv5E8uDPs8uydBMPdsVAAX2rDjGZmfNNRlZRTrEaqAo4HnCK+WhphDQluEgjsWNYK4gxc/LuW/Nb8mcjm1KMNYV3J2jmWTlwnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0JJ8H1/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436284cdbe0so9016805e9.3;
        Tue, 28 Jan 2025 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738078989; x=1738683789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcfMowGtf+B8ZKi13w6qzpkaAJw3ZPqrqTRr7IO7ZNE=;
        b=c0JJ8H1/6H5RQnvcB5EpQ7i9v3C8JAQH9SNlTEtJPCR5Dv4mY5fNOt9IwdX3ihs6eQ
         adVTLvVvKuXtnOzG1gc7Q11pLrvNh9O2/nGhB+N8mGsGDn8AOBQG8ocWJoQAc0zIEbG+
         JSndvX5pUiMigaxp4ucxEZOsRo9BuJ9DbEJ4NedSbjIb5PAoQgOESGZxgp+pTSIyUhWC
         0GJ6UNSkcdsax+1ET9E1GJop6oO3E6hNSm2n282Oz93VypkyTwjUF9Nlc3Waka+PF02C
         UYGVPCyMGBgc9rpo1D8N1ne/iGOMCHFu6js1fg1QixFH5LcKKsRSUqRyIlhyDgisJc7y
         xxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738078989; x=1738683789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcfMowGtf+B8ZKi13w6qzpkaAJw3ZPqrqTRr7IO7ZNE=;
        b=oeYeY6NXuwkGSbc3ogFY1ilou7PkJSb9Sol2QYVCA8HELQCjoTNkoaVZJv+DNy3psj
         3o37MKHBeH/bfX83ZGpHPYLCxudXhFLX5Y72A2vUj3HsF8tXUhbJE4HabmbzLWUgQfJu
         WrXH8HkovIEdKNKr9MELZBFEjaINgMtF/SDIEAkWN8AP2r3EkRTGCcSL6c4ngYxovF9z
         C1iY1ggWTvfE6a7G6pQV4UIIU6w0Duonl1LDo1+7aclRQ+eDYy9xGJYtg/DpML6J4iFd
         BPeeUUmw/L/1bKmNc9xX2ApUmhUHcOcJOlRMgFs8mkC1DHkQ2NHTrmyHxJUeNCN3StHP
         m/lg==
X-Forwarded-Encrypted: i=1; AJvYcCU8GfzsU/FE2NnvT/1s+8oUzWIYTcwkFQb65cCcMBPYwx54R3ShqHLXuxruD18yqZvkZT9PKT26@vger.kernel.org, AJvYcCXWOmx1Vg2Gzo1VQsrt7fybThFiDwHNxNo+3Ke/LHgGEMvfdKwVpacQ7NA+f/6bRj+ln81MUVKVa3hGNlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyd8YG/SOIZKcVF7BFXVdyDLojtIz6LNmJzIvZ0CSTfpl7Wqvf
	t9ZZYZXyUHApXf6C4XaGUZd6WKLx6mHz1CSk1zcTuTjQCV6rmPZm
X-Gm-Gg: ASbGncuXRrIDkyJXmboMJkr520GbA7TDQqwFLRFb62tLqpzK+PyHU3iyvdIgzfSM4rG
	Bml80lySoIRVw5B7fZT4e/kL8d3vYqU6qxzEwpv0VP+UypDsWL272IKov9Iq8989WCyXnkjVA3G
	QJxbFved4bqyVfoSnoCORVJxCymRmPn6G8Rf5kWkh7Cp4IZ1JFbHaGfzgTSFNq8kq7ziQAgD5XF
	ohUA1R1XVra/53U80fekuJuO3c8TGLhuUOo1w7AA43c+jJn6a+4F/z7rjSole7Q2/5tM97/3iOn
	K/s=
X-Google-Smtp-Source: AGHT+IEXQGABpzVKbl+aA2cMSxL2e4lCR+NsL04PWc6yIZCGAkl5+dbdCTzUBIQXOjUn79VmYygIvQ==
X-Received: by 2002:a7b:cd9a:0:b0:438:ad4d:cefa with SMTP id 5b1f17b1804b1-438ad4dcfc8mr117181075e9.4.1738078988953;
        Tue, 28 Jan 2025 07:43:08 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48a94asm173137405e9.23.2025.01.28.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 07:43:08 -0800 (PST)
Date: Tue, 28 Jan 2025 17:43:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <20250128154305.sqp55y5d5lc3d5tj@skbuf>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128033226.70866-2-Tristram.Ha@microchip.com>

On Mon, Jan 27, 2025 at 07:32:25PM -0800, Tristram.Ha@microchip.com wrote:
> However SGMII mode in KSZ9477 has a bug in which the current speed
> needs to be set in MII_BMCR to pass traffic.  The current driver code
> does not do anything when link is up with auto-negotiation enabled, so
> that code needs to be changed for KSZ9477.

Does this claimed SGMII bug have an erratum number like Microchip usually
assign for something this serious? Is it something we can look up?

