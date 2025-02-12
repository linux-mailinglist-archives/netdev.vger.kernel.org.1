Return-Path: <netdev+bounces-165508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BD5A32670
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044673A27D8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76A20A5F5;
	Wed, 12 Feb 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zsF1He6N"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A220ADE6;
	Wed, 12 Feb 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365208; cv=none; b=ltXGTYxRY0dQhigDFdJSAfFc3cEjDUNLrib3tsy50tDWgcU2+GqwHZ5pGOjzalwQVbbYhjHGftKEriDmmcUsUc5RKXJQd8zVavfgUBdTGXj1xbFxuyzX97ENGGJBzQzj+Q+wsokS1eb9yTZ64lhvuEYcCIacOIEUnS+rAqUu9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365208; c=relaxed/simple;
	bh=KOf2h4PG7xccOMdS6180OiEoRVoj9idC7D2qXxh8pok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvkOTCrJP7+hYXVYDzcTqP2HmHtH1nGMV6QNtJCPDS1WxbSMZvgrGUIl+g3BO7fxzpKskS0/B5MgrWaaf/T6ysV0VhLY6WRGHtNnrO/KHUG6CsQSku+u74NNIwpsHI7CcIYAvfpSZWlR909eNxwjmma751xakOUzAZGZ8cpeUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zsF1He6N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZOYByggKcpTN6/ztpg0amU8ApQ5SP/Q3JUIDdpRxdjo=; b=zsF1He6NKrwKP23AmiTQ9zgIEt
	iYbZg5xwcuLN+76dEdyCFX8IDECKBB+6Q4ygT7mWpUMUNChN8e5ElqMaaGbZjbi5RfpHeGiKS/J6P
	jTnHpbun0PWbMNtJ+PoRS0nL4BtpHqELiTzJaZ24faSB/W4gitTHzphVpnsNvGB+dDuk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiCLP-00DOY5-Bq; Wed, 12 Feb 2025 13:59:59 +0100
Date: Wed, 12 Feb 2025 13:59:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: phy: dp83tg720: Add randomized
 polling intervals for link detection
Message-ID: <425d6237-f7ce-46b5-b77b-72b52e5d92fb@lunn.ch>
References: <20250210082358.200751-1-o.rempel@pengutronix.de>
 <20250210082358.200751-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210082358.200751-3-o.rempel@pengutronix.de>

On Mon, Feb 10, 2025 at 09:23:58AM +0100, Oleksij Rempel wrote:
61;7803;1c> Address the limitations of the DP83TG720 PHY, which cannot reliably
> detect or report a stable link state. To handle this, the PHY must be
> periodically reset when the link is down. However, synchronized reset
> intervals between the PHY and its link partner can result in a deadlock,
> preventing the link from re-establishing.
> 
> This change introduces a randomized polling interval when the link is
> down to desynchronize resets between link partners.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

