Return-Path: <netdev+bounces-197080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398CCAD7753
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB0A188A937
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370229A9E4;
	Thu, 12 Jun 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fk3lYuGt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E102989B2
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743574; cv=none; b=HGAZ9U7Ck3D06ocw7fWEwgk//kDP6gks5Z3KtGBGpsIpSOkzDuj/XR7mosamhsgDAgZWOFjG8Ac3sAyZI5f4BkIDf3fkYhTaM6ejTn3hKbvrx0sNVsTmZKXVYMC21QdWeTLxSMrANflPAB+N6kLXG87pYNKXTPl1LpHZdl9S3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743574; c=relaxed/simple;
	bh=6LtQ7+VJYaP3gJlJLCQFpD43hL5ZdSn/z93XGsrG9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIfwtOiwNSJD9TRBIDYxU82BLiUoZ0hQ8InNtSmgWcFyQL934zWO73ZSziDWGkrIRjvxW4ubMPB8Uvh7tQqAlXGxfs0xthehP50/fOCnl0yD9E2qZfw3pB4xGYeWUdKnJOMenC82Nux2Khyz2c+DM+gGPRWTj4OYfnSeLq7IFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fk3lYuGt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tl6gf3BsudiugB8GNn23Uxwzfaj/4i/zGk6I30c4b/E=; b=Fk3lYuGtlmH5rLsYlbgkNpVrBI
	EnrJbMZWXIDp5p8h6JEomCE63NxH71/TGJj8V150uRPfRUl0VhRVJGR+yfVOxHa5PuI99Iuzta8wD
	Zl9ONfRifL6tbj6a3X3SHOvOBDcAm/95YFMwq3K5AlRkM7GLABBYrNb+YHkT/RZEcPfs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPkEO-00FZGh-8h; Thu, 12 Jun 2025 17:52:44 +0200
Date: Thu, 12 Jun 2025 17:52:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 8/9] net: stmmac: rk: convert
 px30_set_rmii_speed() to .set_speed()
Message-ID: <377ee4ec-5fe5-4bf8-abe7-5eb5c0076b1e@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk3J-004CFr-FE@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk3J-004CFr-FE@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:41:17PM +0100, Russell King (Oracle) wrote:
> Convert px30_set_rmii_speed() to use the common .set_speed() method,
> which eliminates another user of the older .set_*_speed() methods.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

