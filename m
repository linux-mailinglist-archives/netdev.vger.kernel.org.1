Return-Path: <netdev+bounces-224050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94959B8001D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B005B2A23C2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3E2D7818;
	Wed, 17 Sep 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vr0eQWPg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29A1CDFD5;
	Wed, 17 Sep 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119188; cv=none; b=gMYFzFtKXAgSw7q7qACbrZMsKGiJZMv0QLx4ofqsCFzEUViIo1A3lrjQac8HqcDGcxwlxy6n/D6WcIeMUHYWvidmjkHkVfG1JV967bAQNcZUASgdXXf8fu+0sTbhKE3xXINDkTj8nJ2bCd5HOi0k6V/jq9FzM915eoxAGGjxIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119188; c=relaxed/simple;
	bh=CEMDjEZ/mnQiP0gOxvoYTIsm9kEz18K1AgKACsQi870=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfmOuI+owKsRixh+BNTCgpoOqDQLV8KbcClgwtXfg2h3DR6/7Q8coImfdAUiKvEO7NFuPvlqoe8m1NWdQbk3l/pe7rbY2K5slF/lV94tLUF9c3CCV7abDqhICoIe/X0zS49j8VQBqxGMJdfuHHEaEJfu1A20/Euc0TV8DPvzEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vr0eQWPg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/ZxtDJ8NDcYS0cSetpXt7raMXbyInlYYiFA0w5yReZ0=; b=vr0eQWPgmDBkic8/GVQiu43zFP
	uc/rYJqtnhoAciwrfHu+jkE3Ox8j2JAlJfTbQ//7gO9xX2bnoIFPZYxUgxHeulz+hKj56q+1r29E3
	7Lk5XS9KE3VP41UrUye2FWA5ucMVt6cF/H8fkRLCseZYqDZNlkZSkz43uCc3DwmJB10uN9LEffXGD
	vGYXokojPtUciD2QFQ4ZfTUAxF6BihQsZjLSG+TMWEji9mdGYre38hjcPP5xyGLMV/fwkix62hy7j
	YyrFUnU92vsZK12eC4FE8kEhqUv1mwAn6cN9K1zvhn7ySvBjKs+wbjEOo1A5HdsSpoRpm3cCCbriP
	sGt/buQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44676)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyt6l-000000004Ti-01AJ;
	Wed, 17 Sep 2025 15:26:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyt6h-000000000Fo-2Qq3;
	Wed, 17 Sep 2025 15:26:03 +0100
Date: Wed, 17 Sep 2025 15:26:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, jacob.e.keller@intel.com,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sparx5/lan969x: Add support for ethtool
 pause parameters
Message-ID: <aMrE-9rtW20A9Xnj@shell.armlinux.org.uk>
References: <20250917-802-3x-pause-v1-1-3d1565a68a96@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-802-3x-pause-v1-1-3d1565a68a96@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 17, 2025 at 01:49:43PM +0200, Daniel Machon wrote:
> Implement get_pauseparam() and set_pauseparam() ethtool operations for
> Sparx5 ports.  This allows users to query and configure IEEE 802.3x
> pause frame settings via:
> 
> ethtool -a ethX
> ethtool -A ethX rx on|off tx on|off autoneg on|off
> 
> The driver delegates pause parameter handling to phylink through
> phylink_ethtool_get_pauseparam() and phylink_ethtool_set_pauseparam().
> 
> The underlying configuration of pause frame generation and reception is
> already implemented in the driver; this patch only wires it up to the
> standard ethtool interface, making the feature accessible to userspace.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

It is nice to see drivers not having to implement complicated code
to add support for pause configuration!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

