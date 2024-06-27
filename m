Return-Path: <netdev+bounces-107473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11591B22F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D477B1F21A47
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067D1A0B06;
	Thu, 27 Jun 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jacMEarE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6A1EB40;
	Thu, 27 Jun 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527150; cv=none; b=bxfbkXdfzfYyFnlXAUGFDp8F35wHzAF3VTly0ZVKsfgXhTrlH2EgpjBDQFjJTDNdvEUVYDdxbPXhFEOEzNuRy0M7LuyOhENidL4aOuzTX5u8gMyqzwVf86gpz3SPyEEvEbDTLusEL12CWo3km2ecUNmyNBX9uVDUa6XqPApGwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527150; c=relaxed/simple;
	bh=E07NHsQvorUG++7CcSrfPb1y4dV1XhITjTbwgL62ZIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBuSgLxmoRXu5wRTdfTmrSnvV+Mskk7HdtpaT6qvlQXWAWW5gR8zZStzrnGbOw1n1y/WT51xC+oNnGlCbdVA5l8SSy0ya/gD36Li9BuBH0dsn4pMIBiUA4alXW9i7t8Z5MYZiWGT1i0GXf7lIdwqgq9ANU1DOYe/rX+5HMoed3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jacMEarE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424acfff613so29499115e9.0;
        Thu, 27 Jun 2024 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719527147; x=1720131947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2/1uS7iUktm7iLmy9v9zZ0wGLOKnCvAf1TsgFbDdOk=;
        b=jacMEarEXuFzA8WVRr/nqZPCV8XDXS3pqzy/l3O585DiUcLEs9R5aMeDo7enLMgyFP
         cC21LgdNzyFmFq0a/Wb0XuKmXCJP2zVLicfL1t0LGnBkJSXGH/Cy1NHIJyG7rmocpOv8
         2zrQFSRF90FVUrrKtl931xM1v2i0v3+w8EAYcaMzard9zilncQPlmxNHPlsjEPPzBss8
         d1Qt6JjQgKkAKbRz0vBYmTis6oICYVVSYCcp88PkBh2xJ2Y93Ri27AJNTJEEQ/qp0/Bw
         LzyO185ZrxGKjxtW1wdbs1otHCXTQwtkHuJrI6DpJo+7QxftBY3jfAQxgD1ser9EPuk1
         1MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719527147; x=1720131947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2/1uS7iUktm7iLmy9v9zZ0wGLOKnCvAf1TsgFbDdOk=;
        b=jXG1ycQftBw4znyxcPlpBEwZwASa9bn0FNeFYxrJjPlWJ3eyWr7DmDR2Jy2jivlRKh
         VENwOxOX1t7k7h7NRMipYehlYMMIJ2jbjIKiJABs7pE51pH0wiRJdMlbpOyuzTR/sSoa
         q/4GcsQiCDPHZtfvN9QEAPnZ8434cKoBjGziVqr075Z0r04mLj6uu2DT7KNJck2NzTze
         D4zSH09SbMDCwtimOH5sgckbR/8wR868DKby3OC2Yhh2/FK/BW9B0DCGftUz38DNJCBw
         Ki/pJKv2+jkvxTz7wI0X2PevAMhEVVC1dKY3rSXGiGhU826K2OPX4ZDKFIh2r0/LIkV2
         Y8hA==
X-Forwarded-Encrypted: i=1; AJvYcCVfpuimmU+duskbCxmDp2NnnuixJK5pw5uUrNG0HncO+QikTgCbts6YDBPcyN0IQD3KB2H5cvFUuLBdfXb6kApzqqcMepFpRK40HV+Iw/R/rdBJQFqzTYXDNyy7rEfOrbSZdive
X-Gm-Message-State: AOJu0YwgT15fGUUOinp1EXFxmv+nKl1TwfabsQ2jsgCaiI9Dx9BG+GxB
	P5PI5iJw8t0OIPCqW/gwoGtT8eErl3+qEcGauxQWGcXfTxdEKpoE
X-Google-Smtp-Source: AGHT+IHsD97rvP/UmdGAB6mgE8uVSc928wJ9UPvvPUd8NphGX2jM0NK7vpEcGs79/sUGpg/UZP8mpg==
X-Received: by 2002:a05:600c:894:b0:425:63b9:ae2c with SMTP id 5b1f17b1804b1-42563b9b0b3mr34893725e9.27.1719527146949;
        Thu, 27 Jun 2024 15:25:46 -0700 (PDT)
Received: from skbuf ([79.115.210.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb9absm440326f8f.80.2024.06.27.15.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:25:46 -0700 (PDT)
Date: Fri, 28 Jun 2024 01:25:43 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Lucas Stach <l.stach@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: lan937x: force
 RGMII interface into PHY mode
Message-ID: <20240627222543.rcx3i5o43toopwcm@skbuf>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
 <20240627123911.227480-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627123911.227480-3-o.rempel@pengutronix.de>

On Thu, Jun 27, 2024 at 02:39:10PM +0200, Oleksij Rempel wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The register manual and datasheet documentation for the LAN937x series
> disagree about the polarity of the MII mode strap. As a consequence
> there are hardware designs that have the RGMII interface strapped into
> MAC mode, which is a invalid configuration and will prevent the internal
> clock from being fed into the port TX interface.
> 
> Force the MII mode to PHY for RGMII interfaces where this is the only
> valid mode, to override the inproper strapping.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

What's the difference between MAC mode and PHY mode with RGMII for this switch?

