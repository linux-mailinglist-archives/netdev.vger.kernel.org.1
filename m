Return-Path: <netdev+bounces-111283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879919307AA
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962601C20C50
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48514430C;
	Sat, 13 Jul 2024 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGhAojZq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804EE41C62;
	Sat, 13 Jul 2024 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720908793; cv=none; b=XMs8zvKgjgry/wiGLqM1UFiSXLbhvL9+V9S27pMailMPJB3B2ZPGUuHD6hovWgtBEkngGMJ8GtTDJoSvsr/T7gk3e470xPvimA0eehs0yGaWFlW0iRzsaY1NTIZTbH+Y7crdZW3TiFiTM4FOsNulLkIWSxrHcles4GZcyzj0NZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720908793; c=relaxed/simple;
	bh=RzzzeZ9670X46ICrCZCoG/+sdAPBDw1wD2mj/Xu5k/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQONf88a7BvLBwOZEYNgRbMsCsTP1UV5hi3PHjMKJqiXS/4tfw4nDZflRRv1MrT7UoG/d/seTAhYTQnh9sx4++e3bh96aJhyEpCk53JEC2eVBgRxJYsaSq1lvlOaUgdM5zXyPXgx/QeeJO84ebRWo9nAv2nCXADn3xgNbY+Djls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGhAojZq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367b0cc6c65so1941800f8f.3;
        Sat, 13 Jul 2024 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720908790; x=1721513590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8d5YV2OUyfSwpL4IWr0WT98oZRhxyb+oSRihmgq0Rhc=;
        b=XGhAojZqXq1icZ/d7MPb1L2OUOIdgIhYaC0xcpDojSnq0T1Cs75DH7g8kUKecbTpZP
         mNrM197UUlOnSYK8I1TTvdhggT55KuL9GNh6Mm+RO70UbSZe877Rg3HYKbOXxtPn3WQ3
         2OqpaTqpmz7wRa0xlhvCjyKFFf8buTwu6G4yPgfwrne9ytUDYhbQy87ahxCyyUAoNygU
         i1om71Y3BqmTJaumwEvLtjW8lAcAainY3TZtcbx1WzpGsLt71b5jj+NePpZFi10VL6lT
         VaQldXdWzLWeCJL0VBkuz6Xp0mnw6jbiHbaxCDvWXRPIBXfvBPshDUuD5Wi9YfhpLw7k
         9sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720908790; x=1721513590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d5YV2OUyfSwpL4IWr0WT98oZRhxyb+oSRihmgq0Rhc=;
        b=N2TTYEH2KB84OTug4ApblMXFiEMqrwWnaRhlvBigX38v3PCoTODHiZlK9S3LbaPYeQ
         UJtW21YLqegcalYn1z8UZSYFHN4oFNLVFbWhKPkzjIqNI0nmfyEMI2Hngr9wubZQX4jp
         k91XLmzTyQjfM/7aQoLsdnMD9zZsmyYBGbz3EyKNRAeOdMZRvBtkyIk9iPNYho2//Hsd
         JWSZO/42fEKyJfdtS/2Cjo3TJAoqW6eLmtSoLZAfbf6rbYht/G73iBYLXUFux3sRqEzc
         /Yd5IqXQK1Bzg2yIROe92Sbrp3K51b8hdsm7uPK3bWoSdAfjqBAKMgxyyhmbExUeEhP5
         E0XA==
X-Forwarded-Encrypted: i=1; AJvYcCUZbUdvf18bm3T17J0fgfsHTOg3QdtannKHC7JQPaNXRyogMDPF6K7mlarY+eYAtPyvpGC5K3Mdieh0ONYOOQk7FZvFuqqq8QBWbTZK
X-Gm-Message-State: AOJu0YzP6Vl2tTK2YxE5dfu7ACVP8BHA8RNdH4Z1xBhMIb4NN//HCs6S
	xsrlqjKqXq+HwdEgui0DwlxElZTFfqUz8JccWkXtZRDgFIpsknGR
X-Google-Smtp-Source: AGHT+IGsNsQNu6oHN8senlnqvGCPOB2knWRGise4XFniunmXwV+rgpd17ub8qiAFpYEPkN5pDdNxtQ==
X-Received: by 2002:a5d:66c8:0:b0:367:8a2e:b550 with SMTP id ffacd0b85a97d-367cead8806mr10103978f8f.60.1720908789560;
        Sat, 13 Jul 2024 15:13:09 -0700 (PDT)
Received: from skbuf ([188.25.49.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf0d7sm2464188f8f.27.2024.07.13.15.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 15:13:08 -0700 (PDT)
Date: Sun, 14 Jul 2024 01:13:06 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/12] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240713221306.rjpw64l5wfvone4a@skbuf>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
 <20240713211620.1125910-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713211620.1125910-3-paweldembicki@gmail.com>

On Sat, Jul 13, 2024 at 11:16:08PM +0200, Pawel Dembicki wrote:
> This patch implements VLAN filtering for the vsc73xx driver.
> 
> After starting VLAN filtering, the switch is reconfigured from QinQ to
> a simple VLAN aware mode. This is required because VSC73XX chips do not
> support inner VLAN tag filtering.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

