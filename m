Return-Path: <netdev+bounces-155545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43760A02EA0
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3515C164B63
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A02155391;
	Mon,  6 Jan 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J3/Z2c2k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3F38F9C
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183305; cv=none; b=c0ygWV4q9uqMIf+IhUE6t3jh0XdYHqSUyyYnVHgGA0n9h9JZbEyS+EliL5JMxdfR39lGOUo3nSD4saO9tYDYTzejK5YqvBoX8DGBB/hbQ3kj5yu5BuQ7Y69RcG1EBsO1kNgM02Ctkczw0Ifhem4n/zg9bm5Oo4awHwzIHzS39mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183305; c=relaxed/simple;
	bh=nDK3vKrfEeL116J6hRIcZ74LCzkICckrTSV8tagKvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGs+yQyRvaHvTrfQApXy6bbSgM38arxto+9sWEkWwhcaNrUxMamvycbce+wiWqdNZTUbRYapO4u2e90fdgROgqcI8C/4XOK3PHChWLDfGnehKBTonlwGGFYdNPqtaSl/RgJ2uZ1yLyooXiL01X7DDxZEO15z+6k+UHY+8DkV2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J3/Z2c2k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uR83ZQY2JorQdRsksaSEreSd1nBld6M8x11g1V8kzYc=; b=J3/Z2c2kzweO/0Ytn4k/MBs3Nw
	HS5oFmINvDhYCKt+644a289nHAVJl5bRdWMVtSqAEjB3xIXWvUnVMaBDRhKFodwziblGQ3gAJ4cCt
	S7LXBRe3ZPJcKyFTV+IYHszk6T2J7VGOOWSW0x/86p6zrqoCagwibNUTtiMNOAtQntdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqaL-001wTU-Fh; Mon, 06 Jan 2025 18:08:13 +0100
Date: Mon, 6 Jan 2025 18:08:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 17/17] net: stmmac: remove
 stmmac_lpi_entry_timer_config()
Message-ID: <60abc93e-35f9-4e99-93bf-177c9545bdcc@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmBO-007VYH-Kj@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmBO-007VYH-Kj@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:26:10PM +0000, Russell King (Oracle) wrote:
> Remove stmmac_lpi_entry_timer_config(), setting priv->eee_sw_timer_en
> at the original call sites, and calling the appropriate
> stmmac_xxx_hw_lpi_timer() function. No functional change.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

