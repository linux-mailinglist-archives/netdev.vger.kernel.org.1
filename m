Return-Path: <netdev+bounces-54483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27598073E2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA21281E87
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771464596B;
	Wed,  6 Dec 2023 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kXj86yBr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693E9D4F;
	Wed,  6 Dec 2023 07:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W8om7MlfeXGuyaEqx9q949RWwCO+0suYJB77IGmK5z4=; b=kXj86yBrrEihSOaunTY1GwV2IK
	dv/yVOaN8d3IWEMghAy0wuyWYpSe2AGZki4s6XuxKDmGt0gaTx/KFjuE/mMHfqJgWGx4ypUA1Xl4i
	3y5XeUDLVbOmOEj34R94jSYks+nCa/GZkAn3BO5RySjC1+1P8ReFCeN68cbQWKBbYA1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAu32-002DnU-5Z; Wed, 06 Dec 2023 16:42:52 +0100
Date: Wed, 6 Dec 2023 16:42:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: properly support
 platform_data probing
Message-ID: <9d2bc0a2-1ef9-4e42-82ac-e5c1b2af90c9@lunn.ch>
References: <20231205164231.1863020-1-dd@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205164231.1863020-1-dd@embedd.com>

On Tue, Dec 05, 2023 at 05:42:30PM +0100, Daniel Danzberger wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The ksz driver has bits and pieces of platform_data probing support, but
> it doesn't work.
> 
> The conventional thing to do is to have an encapsulating structure for
> struct dsa_chip_data that gets put into dev->platform_data. This driver
> expects a struct ksz_platform_data, but that doesn't contain a struct
> dsa_chip_data as first element, which will obviously not work with
> dsa_switch_probe() -> dsa_switch_parse().
> 
> Pointing dev->platform_data to a struct dsa_chip_data directly is in
> principle possible, but that doesn't work either. The driver has
> ksz_switch_detect() to read the device ID from hardware, followed by
> ksz_check_device_id() to compare it against a predetermined expected
> value. This protects against early errors in the SPI/I2C communication.
> With platform_data, the mechanism in ksz_check_device_id() doesn't work
> and even leads to NULL pointer dereferences, since of_device_get_match_data()
> doesn't work in that probe path.
> 
> So obviously, the platform_data support is actually missing, and the
> existing handling of struct ksz_platform_data is bogus. Complete the
> support by adding a struct dsa_chip_data as first element, and fixing up
> ksz_check_device_id() to pick up the platform_data instead of the
> unavailable of_device_get_match_data().
> 
> The early dev->chip_id assignment from ksz_switch_register() is also
> bogus, because ksz_switch_detect() sets it to an initial value. So
> remove it.
> 
> Also, ksz_platform_data :: enabled_ports isn't used anywhere, delete it.
> 
> Link: https://lore.kernel.org/netdev/20231204154315.3906267-1-dd@embedd.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Daniel Danzberger <dd@embedd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

