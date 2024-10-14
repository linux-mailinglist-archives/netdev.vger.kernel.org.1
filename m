Return-Path: <netdev+bounces-135194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07099CB72
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676001F2332D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10A4A3E;
	Mon, 14 Oct 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qmmk98yG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D564419343D
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911926; cv=none; b=Pl5XlKv3gYcKU9bC/S2gWGOtyHb3okgxjknwPlyqMLG1waqYzjlRSTG1RH7S8N2aj0Nm6Nm+jiHDxJhI2+yQKH3Ca8ySvwXPiIwytNEXK3k2toYYw2aDba7LujRWwW8Llcky/G0iGutb1gqHqMrWpdNi1673lHblbCPp+MnDsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911926; c=relaxed/simple;
	bh=LiTtVWP3C88IdbJGIQb4+oBfg7CSEMLfymMJHSWSyQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aubZhCVTrvFFxAk2xeIGPQFJpQbetlUr7fBFIULJTZv+U8S7j61gDc9unTAEmQw0EOEJhFScq2ONfRa9+4g7TZzKZ6iKxC3ai7q1cFLbXsjl9QMIHF9oht2CPP0tfaB6t7fVRbo7I43+PXt057y5i6c9FtFzaSvO2S9FlrG1qbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qmmk98yG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mwg33pBMDHP8i3xlarxnWfSKYkHoIq7Oqt/5A2iykno=; b=qmmk98yGCyX88MyoMe5zmnOMXO
	CsIDCWnzMDiFZ+TAQsZXeeJFXHJ12SSQu8GD9G1FCS9cHntxxAmnTcZHGjxuO/otqHvfUu7ma8zoA
	80LHtuAb8DhWEVusBe3Cdav1C16pv4Qm00pLaxDW0VwIHQrF4ROjTt3Z4hXhFTRVmS2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0Kxy-009vUF-0N; Mon, 14 Oct 2024 15:18:30 +0200
Date: Mon, 14 Oct 2024 15:18:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: micrel: Improve loopback support
 if autoneg is enabled
Message-ID: <63352ee3-f056-4e28-bc10-b6e971e2c775@lunn.ch>
References: <20241013202430.93851-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013202430.93851-1-gerhard@engleder-embedded.com>

On Sun, Oct 13, 2024 at 10:24:30PM +0200, Gerhard Engleder wrote:
> Prior to commit 6ff3cddc365b it was possible to enable loopback with
> a defined speed. First a fixed speed was set with ETHTOOL_SLINKSETTINGS
> and afterwards the loopback was enabled. This worked, because
> genphy_loopback() uses the current speed and duplex. I used this
> mechanism to test tsnep in loopback with different speeds. A KSZ9031 PHY
> is used.
> 
> With commit 6ff3cddc365b for 1000 Mbit/s auto negotiation was enabled.
> Setting a fixed speed with ETHTOOL_SLINKSETTINGS does not work anymore
> for 1000 Mbit/s as speed and duplex of the PHY now depend on the result
> of the auto negotiation. As a result, genphy_loopback() also depends on
> the result of the auto negotiation. But enabling loopback shall be
> independent of any auto negotiation process.
> 
> Make loopback of KSZ9031 PHY work even if current speed and/or duplex of
> PHY are unkown because of autoneg.

We probably should think about the big picture, not one particular
PHY.

Russell's reading of 802.3 is that 1G requires autoneg. Hence the
change. Loopback is however special. Either the PHY needs to do
autoneg with itself, which is pretty unlikely, or it needs to ignore
autoneg and loopback packets independent of the autoneg status.

What does 802.3 say about loopback? At least the bit in BMCR must be
defined. Is there more? Any mention of how it should work in
combination with autoneg?

	Andrew

