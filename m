Return-Path: <netdev+bounces-150478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02069EA636
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AD3188C1E8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777E13B58C;
	Tue, 10 Dec 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rDNf+FL7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B112AEFE
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733800276; cv=none; b=gA7xa+cD/tqrqtgZpZV0b7MNBZoDngfoik5kBKSFR6PAPRXazEyBp6YE/u/M/WEIuJ1r66M5DImQHpOJS5bUK9LsJe12IsBL1QS9mKb7gY1Uk0dTKaNSI2gQmzl03CTukPwKvYF4YQFNjiLttuKT1SBblmPv4CnVhkmUX1yfc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733800276; c=relaxed/simple;
	bh=VCQZrQ4vJp+zEAdVACTwxZ5FTkarvjAoSzsIY1SELJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1ZjR47LHR9y3FJs0bZE6OJvFhDlV9tTeKBrGAXb+3QqsO85K5lKkujBTyetqZgGrY8t+/124yvUStRh7rqIwUaAz79EPreL6OgIhFXLf+ITH5v3Uab7CE+kWVsb402lU2ZKvIJ8VLvtpQCRm+ZdYRNuMUqKiBs0MOuuC50qtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rDNf+FL7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jMFetFruFka8IIRNhoyfsmF5SWd5uoAOs7rMiPBCrrM=; b=rDNf+FL7eV10CGfd7e9d83HpL6
	ocba9KPDZjVQ6L6v6YhAYzFPw9QbuX2rmKgKcvouN/Bnewh/0SRdFY2MikLWlLEGOL2qp0cBcxeOX
	8aoQbJslQHbQzY3Li/s1mUL50qtoQPgj0/H4u69wi5ZOgKnyWoTg6QR9ctH3870FevCE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqeT-00FkUG-T3; Tue, 10 Dec 2024 04:11:09 +0100
Date: Tue, 10 Dec 2024 04:11:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 03/10] net: phy: add configuration of rx clock
 stop mode
Message-ID: <fdf1b674-8e47-43ab-9608-e25dde9f3f20@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefY-006SMd-Af@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefY-006SMd-Af@rmk-PC.armlinux.org.uk>

> @@ -2073,6 +2073,7 @@ int phy_unregister_fixup_for_id(const char *bus_id);
>  int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
>  
>  int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
> +int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);

Hi Russell

Do you have patches to MAC drivers using phylib, not phylink, using
these two new calls?

We see phylib users get EEE wrong. I'm worried phylib users are going
to try to use these new API methods and make an even bigger mess. If
we think these should only be used by phylink, maybe they should be
put into a header in drivers/net/phy to stop MAC drivers using them?

	Andrew

