Return-Path: <netdev+bounces-68872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA82848916
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D021C283FA6
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF912E49;
	Sat,  3 Feb 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RjSGMDNN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C41134D2
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706997564; cv=none; b=k9ovYN8VJyfRqqVZXMznJOOtDEwXI8beBaxfXBJcGgNSy+DwQktekqgQ8LWsa//1eV31mfxJTeEJxVkiZAn6TOdL6kcuztJMKvmxd0aBRsT54JvzWkaT/X5xxbwT+IK3TMVMhEoYx5C3FQJvCwEbtuhqhMPi+YuTE7UWSN7l5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706997564; c=relaxed/simple;
	bh=dGud80hs1SZIgx+NtXG35FgvoSm95JjUAWc5ti+8/bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcfPu3/SIXrNk6/WIxx+h2NIwncpjugoYiikhynEuc9Hh10r6WdwlVAA/fGARfOHC5dTseutgRAq5B/G+pGUuUNSvDAlxi8zmkA2sVvIYQ3xwl1spZf3/x8QdUaoEsU+v0jUEvHVj/erkG6fsK50Oo1CmLlAxUIMnHBG17oiuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RjSGMDNN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WRiq4fUSC3Uac2XksDj6GjInoQYvurIHUmfcb/QgqRA=; b=RjSGMDNNCMPnsBS0PDBWD4QGov
	IRKaRAxaKobYs5SsV4p5zUEx94K+Nh62jfYuN8HdJtgg1s8W/m2IAYfsdPfM5ldi8IjAQXrPQ+DDc
	48gwK+J6ouV2m/SITW8l6iWdf6euvwOSE1k3/K+/9S/qJjJgns4XGynylNWNT9F4nzZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWO2c-006vdR-33; Sat, 03 Feb 2024 22:59:14 +0100
Date: Sat, 3 Feb 2024 22:59:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Michael Chan <michael.chan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bnxt: convert EEE handling to use linkmode
 bitmaps
Message-ID: <e65b8525-eae0-4143-aa57-009b47f09005@lunn.ch>
References: <10510abd-ac26-42d0-8222-8b01fe9b8059@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10510abd-ac26-42d0-8222-8b01fe9b8059@gmail.com>

> -	if (!edata->advertised_u32) {
> -		edata->advertised_u32 = advertising & eee->supported_u32;
> -	} else if (edata->advertised_u32 & ~advertising) {
> -		netdev_warn(dev, "EEE advertised %x must be a subset of autoneg advertised speeds %x\n",
> -			    edata->advertised_u32, advertising);

That warning text looks wrong. I think it should be

EEE advertised %x must be a subset of autoneg supported speeds %x

and it should print eee->supported, not advertising.

Lets leave that to Broadcom to fix.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

