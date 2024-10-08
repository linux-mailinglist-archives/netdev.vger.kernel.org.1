Return-Path: <netdev+bounces-133108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C98C994DBD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED0A1C24F7B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957141DEFF7;
	Tue,  8 Oct 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hI2kh+//"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAF1DF24B;
	Tue,  8 Oct 2024 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392922; cv=none; b=JhSM/ATYqXUBB3hmMm2k6Hqd8B3YpQHAN7dq0qOHqJ6ccU/sk0TIl6xkebhOMA6x09AkA8zwDgImedZIHANhGhmUL5tzFwDye2A2gmuee/4ULquEyBGCyn1/L8f+x8T3bkapeGZf3GXxFSdBFrf4xcpZ1hNBlqDUGnX1sF/YD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392922; c=relaxed/simple;
	bh=JgXP1AYIwXhdzdxK4cNJHJCGrxsYLtDEhm7vjrryyy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuGhMA9Bixilakx6zNkAiuosBvd9JcrV+gPCuOfs/RVrJxSlwNYWgslNUNfbuaGBj/hCNz6VfH4S6gjw42kbxHhqaJyDCq5hBndwFdNFWKCivQ0Gh5FuV2br1FZN6prBgrRjGfS4xUviO77jlizbGv1gZwCxx58WzTZIMzRwY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hI2kh+//; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k8HRf5BUMurO5bidlS62jMLhyjLeJVd4qVtNlJc2ON4=; b=hI2kh+//z5eD7c0Q01XX3x/wX+
	UXvriQSsNXT+QzBYEkT7EQwkxXHWMozv/2QSO6BcHxUYfs/pZ+AMb+HlQFK2ZzD4JNR9FT0aDreom
	bdyxdKADYh2LzifJrz6ydTa4YG6b0Q1dW+Y7cCRMU1pNCTZo7z2Cfld5nJTJCjhzrO/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sy9x2-009N8S-Hg; Tue, 08 Oct 2024 15:08:32 +0200
Date: Tue, 8 Oct 2024 15:08:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2] net: phy: Validate PHY LED OPs presence
 before registering
Message-ID: <851ebd20-0f7a-438d-8035-366964d2c4d8@lunn.ch>
References: <20241004183312.14829-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004183312.14829-1-ansuelsmth@gmail.com>

> +	/* Check if the PHY driver have at least an OP to
> +	 * set the LEDs.
> +	 */
> +	if (!phydev->drv->led_brightness_set &&
> +	    !phydev->drv->led_blink_set &&
> +	    !phydev->drv->led_hw_control_set) {

I think this condition is too strong. All that should be required is
led_brightness_set(). The rest can be done in software.


    Andrew

---
pw-bot: cr

