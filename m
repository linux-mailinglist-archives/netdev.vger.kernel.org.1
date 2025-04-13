Return-Path: <netdev+bounces-181987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EAEA873FC
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 23:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB56E16B80D
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898121F2BA1;
	Sun, 13 Apr 2025 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rjIWPxJe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8512B94
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744578634; cv=none; b=R+t8T7CENsLaeMB/XUp0Taf9shefI9qmRDzHtAg8xHXijGt9xhJfIyF4qrYe+OYlmTvRvEGs/0MIf1bMJctCVCv6YNd5vni+33l5/oP+jB/DDMvaRAcX82uWFsGzFDv/lV3FAEKXEF0EfMcV68JSwjFkbvKx48D4GUtLBKp9YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744578634; c=relaxed/simple;
	bh=Q97+TtzUeXh2Y9j3wcKOKQxiU0ak6LXaoNjg21svgI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJYKLWRJIgDLW0pVWgcUbi/VgJmIYv53zUAn0icpnANmvY3630rdEMV3R3s62KA+IORHBqPr2DKD999i34iYOL8UiM/MZznziQo8OnWwncFld1ZAIl27BE3M8li/TQdv+6jY/pMLZatEW5uPEub3xGYjUyPJdA3VgDPUL3yroXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rjIWPxJe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kYQPdO0zzHv8R4sjKJkwdjp3Oz2SICXW1PKdW6fjF2Q=; b=rjIWPxJeD6xvm78cU1Lgp2JXxs
	vB/Z39UEidtoqwhYJ53+gRx+Nan2R80vtTR5OM+d3VsBJqpbDSbiq6dpN/H2R/6jzYQMQpxjBiN06
	Ihtf2xpZ20Wa6r2cEvo4QgiEhQ6pzs+ohEBgFHMSoaX2+nwS+vKqIV+rncDXFX9w6+EI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u44au-0096Nz-Ho; Sun, 13 Apr 2025 23:10:24 +0200
Date: Sun, 13 Apr 2025 23:10:24 +0200
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
Subject: Re: [PATCH net-next 4/4] net: stmmac: anarion: use
 devm_stmmac_pltfr_probe()
Message-ID: <acd537c9-51f2-4d5c-a07d-032ea628d241@lunn.ch>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
 <E1u3bfU-000Em3-Mh@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u3bfU-000Em3-Mh@rmk-PC.armlinux.org.uk>

On Sat, Apr 12, 2025 at 03:17:12PM +0100, Russell King (Oracle) wrote:
> Convert anarion to use devm_stmmac_pltfr_probe() which allows the
> removal of an explicit call to stmmac_pltfr_remove().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

