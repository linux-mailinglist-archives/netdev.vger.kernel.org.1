Return-Path: <netdev+bounces-42927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A6F7D0AF9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DE42810FC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A41097D;
	Fri, 20 Oct 2023 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rk32iT0n"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAFF847D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 08:56:13 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6309D55
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=13FmDgPkHeyxWxJMIsERjS2lExyYSL+OJ21qJ4ZHaLo=; b=rk32iT0nTCmktFeRsm7YhLLsXC
	AexhEtCPvMsL8Q4NPUYDlMUdRY6tSXQvcgMISwshlCws3zCW0nd7SxOeZEwgO4OjfJusru+E+leGR
	e1qOf64u29GDET9TBfWp9ep17hWwOrKltOJiyp6cBnk6nyMvoQFfLpkOzCJ7FjPPULOlKt9+Jb3fa
	a4t+D2QWtdN+ZnKeDwPSCVcStceszqMfAs639LnL8gjTCEJQ72fvZlqvIwGrDIuwjULS9UaMNCGJi
	hwgAdXUx71LlrsvLxQ7eNKgYE+XTGn/YZryV5sN9/e8nJ8sHNkuyHVx8W39YobLalp/GFrlOdnLZQ
	M+oLYnrQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42586)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qtlIY-00007g-0k;
	Fri, 20 Oct 2023 09:56:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qtlIW-0001OY-LC; Fri, 20 Oct 2023 09:56:00 +0100
Date: Fri, 20 Oct 2023 09:56:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew@lunn.ch, paul.greenwalt@intel.com,
	hkallweit1@gmail.com, vladimir.oltean@nxp.com, gal@nvidia.com
Subject: Re: [PATCH net-next] ethtool: untangle the linkmode and ethtool
 headers
Message-ID: <ZTJAoLhIPuRza4VH@shell.armlinux.org.uk>
References: <20231019152815.2840783-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019152815.2840783-1-kuba@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 19, 2023 at 08:28:15AM -0700, Jakub Kicinski wrote:
> Commit 26c5334d344d ("ethtool: Add forced speed to supported link
> modes maps") added a dependency between ethtool.h and linkmode.h.
> The dependency in the opposite direction already exists so the
> new code was inserted in an awkward place.
> 
> The reason for ethtool.h to include linkmode.h, is that
> ethtool_forced_speed_maps_init() is a static inline helper.
> That's not really necessary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

