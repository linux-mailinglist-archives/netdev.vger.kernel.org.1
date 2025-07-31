Return-Path: <netdev+bounces-211224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98839B1739C
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249697B04B6
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF591DD529;
	Thu, 31 Jul 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nvj3uKfc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DB2A8C1;
	Thu, 31 Jul 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974022; cv=none; b=c58idmFBkTCqg78imGCH+YRgZGbjm0n2KseSUKoPi8Zx9OPv3EPzixl+0deZ4iuMQQzFQUcokAJWlBeo1cC+R6Tr6PLuwx+NInK76cbZeRlbQIfFzJ1kWXBKcfUbY6CNFJu+rFmiASoNHtjAAqAUIHplOj0GyroDIOru1N0lJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974022; c=relaxed/simple;
	bh=eCTn1VeRML+5mh2D5tkVcMytlldvLgIzq8h2lGxp500=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uurfp1quNuCFsGA6zCB8EN9QGGWD7V8in5C4OLZyD+5JHOPh7zK1DXm5FV190w4uELajePKQLys29umEZiOYRcJQVHV8OVXXTTbF/hmV8Z3lFdSKNQ0PMWZjVdDRn0zgI2evrZgMWACUBQCbsRIfbUCw+lwp+7hFJ/lnQfb6Qys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Nvj3uKfc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2BsDj+OD3jmm2d0vUWYrsDBY27j7hSBdc7EYok2mERc=; b=Nvj3uKfcgNT4vQpK0q6CpPxUSo
	6cnf9DJvy5RE0nKp2DUu2vCr8H0Q/QaqHQrBng7OYduawjQrfL+Tv15KieEdEjrAuS78PzWuNp8ZQ
	xgpok0OiGR8dd25lkOaSSex2FPAqKAdF0VcmBlg2eDFLbJMLKyWmZDq29jOZzlp/Mmy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uhUlQ-003NgA-99; Thu, 31 Jul 2025 17:00:12 +0200
Date: Thu, 31 Jul 2025 17:00:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Meghana Malladi <m-malladi@ti.com>,
	Himanshu Mittal <h-mittal1@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix emac link speed handling
Message-ID: <e9a886f2-527b-4375-bb2c-15f38b56675f@lunn.ch>
References: <20250731120812.1606839-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731120812.1606839-1-danishanwar@ti.com>

On Thu, Jul 31, 2025 at 05:38:12PM +0530, MD Danish Anwar wrote:
> When link settings are changed emac->speed is populated by
> emac_adjust_link(). The link speed and other settings are then written into
> the DRAM. However if both ports are brought down after this and brought up
> again or if the operating mode is changed and a firmware reload is needed,
> the DRAM is cleared by icssg_config(). As a result the link settings are
> lost.
> 
> Fix this by calling emac_adjust_link() after icssg_config(). This re
> populates the settings in the DRAM after a new firmware load.

It is only safe to access phydev members when the phydev lock is
held. When phylib calls emac_adjust_link() it is holding this lock, so
MAC drivers don't need to worry about it. However, if you call it
directly, without the lock, bad things will happen.

    Andrew

---
pw-bot: cr

