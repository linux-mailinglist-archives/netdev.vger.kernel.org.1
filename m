Return-Path: <netdev+bounces-180443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B716DA81540
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A100119E7D6B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC16522D7AF;
	Tue,  8 Apr 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a4KBoK7d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CBA13B284
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138684; cv=none; b=pwU//8lWA/PkF2S96V3BCJQJEVv2zyk7jhYnG4F6QY/0YG0ZNkDZf3Mm/BNK3ZKBBYZGwFASUASokbROdBoU8TK0Hkz5kfuRjzM/lH6pX2MAqRgL+AzrNNu5WM5FiJQAcAxgY89wiZPm4K3ymcT5tl+q+pK3ndaZsmggE0haP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138684; c=relaxed/simple;
	bh=/mpr2R7yhLj9+M5pS18CPMIKOGNzGs7rKsA+Azinumw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMZVi7MrhSIUk6vvuvlmLW4CLsdIRsL7IJRg5Psd0EUdmWKBVFN5KLoahw0wDbMeRMccY1fqzhu5J+wUKG11dOJ7m2FmtQkVHXLtaeIbHsRL0C9Y6JW+5IXRYG3ecSk3+PuGcWQ+IMDtcehuXoWbSZjmk2LwxwiiIdhW58M8qp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a4KBoK7d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0gfwchwxJDdgDcSoZFTokynG6UUosgKT0k4GbNON5KM=; b=a4KBoK7dPs4hT8znWpfHyHI+Bd
	vP+De4SHKeYDGD24EIpO457Yg3dXKvCStm4aST1IgdAai4ChDgfJ1Pvqr+eiwR6RWfT5etV/cKpgW
	74J7FTnWxkGTooY8ReJTdSK6B0Ed3nz4LHq/dFybXcnMDHpMoLkUjqpK9ZOyNp1NCgvo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2E8x-008RIb-6g; Tue, 08 Apr 2025 20:57:55 +0200
Date: Tue, 8 Apr 2025 20:57:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 4/5] net: stmmac: remove eee_usecs_rate
Message-ID: <b1cb1b0d-03a1-4ffe-935a-c179e722e528@lunn.ch>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
 <E1u1rgY-0013gv-CL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u1rgY-0013gv-CL@rmk-PC.armlinux.org.uk>

On Mon, Apr 07, 2025 at 07:59:06PM +0100, Russell King (Oracle) wrote:
> plat_dat->eee_users_rate is now unused, so remove this member.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

