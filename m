Return-Path: <netdev+bounces-183411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E999A909AE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DD71795F4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67621578D;
	Wed, 16 Apr 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EC9KDrxR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D45DDC5
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823679; cv=none; b=kVBb4Bz6zRaPkxtFBtXRL5olkTUo/SAzWxujICrmf7ZqzeTOjfPUp6w85PrSQaWhRczUzIdGbBy71ncGP2rCOkLW5wq/871zxxkichUQ5fISYLKWkgh8dyhq4I+Qk1QWfYTKKWdfZw2mIPpWw5+anVgnPIinRTg0hPntvnhxrTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823679; c=relaxed/simple;
	bh=6oLlsCc2lDRrGFOa7lLa4ZWyRM/AFnMjBeMMLShTUog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlCzP9WqU1N01pmfp/4BXvuuITFTvPeBjeg5g8CJO4tLSzAIAlwFj5sliNWDLCgx/THrV+nL5/JWQNESY6768lys3E9fXN6UCbGHYDpjouoZw3ARosBd9pVP/LyRUggQ3REwOyXMx2oYfgP1XfiAKKbJSra8vvcPwgl6jstN1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EC9KDrxR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R7CQNMF+YU4zdGo+64Wu6kDtibqwfiVODTWRMhos8UY=; b=EC9KDrxRC9kCa0AM89XpHE03LP
	3fiO2RJ5Nv0X7Vr9vAP9UL/Rp+X4Q1UcniJ6V6heMhXjaxYG0p03DRACjFx6WV1UkD8GSTUjchsHC
	3hY4mvc5wta+Mbnk4VdzjXVb2WHjqhe123lhv2mGd+bf6BES7Xzdx0bInuoHbHjlruFXLAaXsMLy1
	5V9y4VLEtnzG3XxYbPL6zF6Bi2WOudUsZzFP8MQEdvj60N+72/j+i43UcN219d3dVIXdfsapXbPc2
	K31OIKxgU+BsiLAJQBQ01rIrFM3L6olyBKlg647ACH6ipwjrexAGTjAnTLLA+rUHZ4fuX7/X+HeR+
	3u7j1seg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37942)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u56LF-0001iA-1I;
	Wed, 16 Apr 2025 18:14:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u56LD-0001Zj-38;
	Wed, 16 Apr 2025 18:14:27 +0100
Date: Wed, 16 Apr 2025 18:14:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled
 and link down
Message-ID: <Z__lc39Bnw1kORP7@shell.armlinux.org.uk>
References: <Z__URcfITnra19xy@shell.armlinux.org.uk>
 <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 05:16:01PM +0100, Russell King (Oracle) wrote:
> When WoL is enabled, we update the software state in phylink to
> indicate that the link is down, and disable the resolver from
> bringing the link back up.
> 
> On resume, we attempt to bring the overall state into consistency
> by calling the .mac_link_down() method, but this is wrong if the
> link was already down, as phylink strictly orders the .mac_link_up()
> and .mac_link_down() methods - and this would break that ordering.
> 
> Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> 
> To fix the suspend/resume with link down, this is what I think we
> should do. Untested at the moment.

Tested on NVidia Jetson Xavier NX, this eliminates the incorrect call
to phylink_mac_link_down() when resuming and the link was previously
down.

Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

