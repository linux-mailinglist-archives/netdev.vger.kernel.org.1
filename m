Return-Path: <netdev+bounces-211946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C81AB1C93E
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 17:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8501B3AAF3D
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F0298CD7;
	Wed,  6 Aug 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ypEhLyZo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EB2951DD;
	Wed,  6 Aug 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495241; cv=none; b=LBprOm4dspgSO2nDWq13h00VkzwRod8mlHYCfx5ZNtJECfUAaa4RmZNZlc+DV4KRf0wVtDV7UI6YYlm5X7EU+AhzL/m+f95QrvWiSJoVufpPH0sipLKA55A+PayK4Dryq9SpZs+nz9d9JbCwMRFDyelH18mb4SFO2FXGgunqT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495241; c=relaxed/simple;
	bh=Q5l7to1WTT3ahPdgd3phsqx7U1n/Y6gxXB5QPNZ+QPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=concftiXEXI/Tjy2XeVEsu3qe+saq+7FIFRbayE0MKc6ltnTUwfH1EG8V8OCbA32RBz0ZVUY2tqisNEe3HtWs2xZ1yppWK3f3yg6X7+lWe6DjzrhZK/yWDJM1+fW0PT6QdvNAcdME0jKc7XMSYhojQ47iMfyKt8UHhlvsEl+F6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ypEhLyZo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Cv4haX45oKdMVg72ERS/j4e3qPSDopAb5gwwqYP2uvw=; b=ypEhLyZo8r7ycsxnFjMUnnEo+Q
	v1KCxi00qW4ArcZ65sAhjMZXElRq3CFwZMlQCCsiHys6SXS4DkI/aAyTzqd0kLV/GW1mlFaWrN343
	FPpDUvCk4u07yOvaL+AhPNauGecx0mCW18siDTrcT8WaBz1zItd0/fcwfYbpX9pCjOaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujgM6-003tdJ-Ez; Wed, 06 Aug 2025 17:47:06 +0200
Date: Wed, 6 Aug 2025 17:47:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Meghana Malladi <m-malladi@ti.com>,
	Himanshu Mittal <h-mittal1@ti.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix emac link speed
 handling
Message-ID: <65645f94-3a61-47fa-ad13-9daaf89e926c@lunn.ch>
References: <20250805173812.2183161-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805173812.2183161-1-danishanwar@ti.com>

On Tue, Aug 05, 2025 at 11:08:12PM +0530, MD Danish Anwar wrote:
> When link settings are changed emac->speed is populated by
> emac_adjust_link(). The link speed and other settings are then written into
> the DRAM. However if both ports are brought down after this and brought up
> again or if the operating mode is changed and a firmware reload is needed,
> the DRAM is cleared by icssg_config(). As a result the link settings are
> lost.
> 
> Fix this by calling emac_adjust_link() after icssg_config(). This re
> populates the settings in the DRAM after a new firmware load.
> 
> Fixes: 9facce84f406 ("net: ti: icssg-prueth: Fix firmware load sequence.")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

