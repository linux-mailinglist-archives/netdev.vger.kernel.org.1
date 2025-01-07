Return-Path: <netdev+bounces-155858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78580A04102
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2177A07EC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E53BBD8;
	Tue,  7 Jan 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ACMXZD8X"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F536259492
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257261; cv=none; b=CK7/yfTUMXfmEAPP7DosI+SL7TdMaprDYkhWtHMryo8L/Vfuh+N9+f//cb7/bNpiebjS8JUqRTeoq3fBjOiONMLW/3Gr/gtn1qqvsI8mEMTCur8fpzkn7o1oYXUw1v6/+LX3zWMLsBUD+M+gdUv1iAmMDyRiG6DxIxbTYdMnwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257261; c=relaxed/simple;
	bh=t5sUJ/b2mRTY0lV9HjBrEIu6xrrsBoKnGdX/bsiNVNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcnkXT8XMu0hsfziQg/976Z+8bYa6VdQ4HPULA4F018FkuUMuHAAlRa8sDBOf+pvaQ+IbmF7YQ4QPjmbZJx+gN6ZWwiodvKFhVxS46JJjf+7tvyUd7y+7y06WCO8WL8sPpZ4Udwap2VjKAWA9yK8jBU0kthv2RSRujTHNS5zj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ACMXZD8X; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67EFFFF80D;
	Tue,  7 Jan 2025 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736257250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1M70WKN/HCJz6VewvYf20E0nteDogomKQuUIQMOhQ0=;
	b=ACMXZD8XSPTBlhUw5T8iwrKeMJ++FXJ9/pkE3YOzLRrJzQJtoEGE6nQwAJ4FRfjr80h0kU
	V/UbrBHPx0Gch9l7AUAXIMH6w7fWlbV7u4cNLQYM204zTOrtaLAKoMfjNkbXteM+sU1/dt
	jN4gIvl7t7h07n0LXH+u4FLT4RK0vMSu9arxJ31MkhWYWRfIOMbGOkQm27AjvEXzlvpSVe
	NEXgmGEHN+piuqlS3kb3jed0wrQ54tkRqHUvejQQ0FFVDkcFB2upMhHj4KvuRoYeTmko34
	dAPeLxt2gzZKvyf5Co2cUq3fUvjaJjOxRk7holnDywmTh7bAuKW2UMkAd/Mhkg==
Date: Tue, 7 Jan 2025 14:40:48 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 netdev@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net] net: phy: fix phylib's dual eee_enabled
Message-ID: <20250107144048.1c747bf1@bootlin.com>
In-Reply-To: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
References: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Thu, 14 Nov 2024 10:33:27 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> phylib has two eee_enabled members. Some parts of the code are using
> phydev->eee_enabled, other parts are using phydev->eee_cfg.eee_enabled.
> This leads to incorrect behaviour as their state goes out of sync.
> ethtool --show-eee shows incorrect information, and --set-eee sometimes
> doesn't take effect.
> 
> Fix this by only having one eee_enabled member - that in eee_cfg.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phy-c45.c    | 4 +---
>  drivers/net/phy/phy_device.c | 4 ++--
>  include/linux/phy.h          | 2 --
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 

I observed a regression with this patch applied.

My system is based on a i.MX8MP soc with a TI DP83867 ethernet PHY and was
working with the kernel v6.12 release.

Using the v6.13-rc6 kernel leads to a low ethernet bandwidth.

I used to perform SCP transfers at around 6MB/s on my setup and after moving
to the last v6.13-rc6 kernel, the bandwidth dropped to 70KB/s.

A git bisect identified the commit 41ffcd95015f ("net: phy: fix phylib's dual
eee_enabled").

With this patch applied, the issue is present. Without the patch, the issue
is not present. Also if I add the 'eee-broken-100tx' device-tree property in
the PHY node, the issue is not present anymore.

Didn't investigated more the issue but the patch introduced a regression on
my system.

Best regards,
Hervé

