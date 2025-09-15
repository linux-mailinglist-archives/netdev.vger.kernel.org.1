Return-Path: <netdev+bounces-223228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE40B58720
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCBB2A3BA6
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212632877D3;
	Mon, 15 Sep 2025 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q9eAu4HS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF536D;
	Mon, 15 Sep 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973654; cv=none; b=oMiNeg3H57WM6ilmz7xCQP4Xm3piar926qEmX5f32aRAON5Dp+0ABVcYpVy7Xk0d/NZ5REtYC2tahg1cNjWuW9OZyhvR8z6d/1txBw3/P51+jiLBH7++iGjSDzQKysqiLc9yUBfwhkoqa+bEezEZvwnw6e3BbKV1uFXLcAAtXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973654; c=relaxed/simple;
	bh=VLQGS3cgTtk104a64eK65T5b3tVm3LffcJx+YoRZ5iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZcheGDmhCcfFPsQrJ9suZPOGTBCZ0BkALpefXFalk7srMzezDxmNh0g3ckiHK/ifzjtPYaYu09UOaqOkCd/MEFIOv5PZzUFRAknl623skCPZOMlLKKNfeWqr2IBZuThy3vti0JYG1jtnFw30TwkdMlMRmOvX/QuAs59et1hWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q9eAu4HS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NS7S5a2VcyEH5jQf3fwVpWmwNIV9OR74n9P7vCPbVqQ=; b=q9eAu4HSX9Q8nYaGN+fgSTf/+B
	rNsNEJacv9FXek+K6lWVcX+VaIW+cpipAPIRoC7IO10pYOpbjrhZaqEUpW+kM9HWc/bTmXI7WofZX
	wDYBBRuUuJDtrsxwocMVx7kdiGa7RsenqMLCaQnVXOraPp0tODn9NDzRELJl6ywTk/uo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyHFZ-008U9c-Lk; Tue, 16 Sep 2025 00:00:41 +0200
Date: Tue, 16 Sep 2025 00:00:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: phy: clear EEE runtime state in
 PHY_HALTED/PHY_ERROR
Message-ID: <dd53bd18-32b5-404c-92cf-2bca8a510718@lunn.ch>
References: <20250912132000.1598234-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912132000.1598234-1-o.rempel@pengutronix.de>

On Fri, Sep 12, 2025 at 03:20:00PM +0200, Oleksij Rempel wrote:
> Clear EEE runtime flags when the PHY transitions to HALTED or ERROR
> and the state machine drops the link. This avoids stale EEE state being
> reported via ethtool after the PHY is stopped or hits an error.
> 
> This change intentionally only clears software runtime flags and avoids
> MDIO accesses in HALTED/ERROR. A follow-up patch will address other
> link state variables.
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

