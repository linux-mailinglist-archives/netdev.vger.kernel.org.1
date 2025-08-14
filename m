Return-Path: <netdev+bounces-213642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478ADB260DB
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBABC3BAF48
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D422EA15E;
	Thu, 14 Aug 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pe/z9zQd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966862D46D4;
	Thu, 14 Aug 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163421; cv=none; b=oA1DCvlQ6MiSqVw88Hrv/TeEKqd4J11M2zB8bXhFLVP/203s17oqF5thQJbV6j8xUy4mmeCje/9hQoQ6KV0shyjcZEwgSUb0OTT4fgikP18zzN2llbG2UxFxHJ+kozDyfONYM/SA6Q9xuJrioJkT2t/DnI7yUXReNe3Kes/eyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163421; c=relaxed/simple;
	bh=2WDja3Xm58FNfC9FIMddv3gF5tE6jqzgi3yHc/39j18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ao/B0ewBgHYuxMNiti1ZJ5bWQW2AkVqL7ou/7M12gZ3twwBouYkwdxzSANvzIevItFoi3W/QhDlV3X2/zvNFnsO6M47KxIcF5MW3i9kGXMuzPX313swvSqnDm76zYR/ywSsyQORboMAckOIj5gldK7ku0voVxlzVGfEGyIvTcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pe/z9zQd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TXNnGNU4HZErrTRJ2fJqyiAOQXXe4JUJrwrT0g3iBec=; b=pe/z9zQd93ARu6/ecfEdcV7CMc
	7wJH7n4LoI0wiJ1H5qORX5L2YOcHB5zSUIBqKZl535FnsiuA7RMwloOuEldEy/IU0SK7v4hP/bSRv
	MkC2wVyWat5ypLgk5960lIFDY0yZRd4iDiqcOHzvrzHBTnQY1nJOj/cA4Z2YXFa8cPbQmXNvtMfYU
	25EIw6HNWgeaQL5aZN8FmxUj7bXkxdFdcV9m4wiXa/K57W3pgZv9uFeN2KOtuepejKbA6Us1qppUJ
	boH6p1AaoTgWjAikXD17q2eF/ZYSLEBlyrRgmboCIdRuyOBMSmN6mEQe7f1Ktb30XCXysHWvFoqRs
	ZuE5/ZQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59264)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umUBF-00083b-1m;
	Thu, 14 Aug 2025 10:23:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umUBD-0006hF-1A;
	Thu, 14 Aug 2025 10:23:27 +0100
Date: Thu, 14 Aug 2025 10:23:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	alok.a.tiwari@oracle.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/4] net: phy: micrel: Replace hardcoded
 pages with defines
Message-ID: <aJ2rD8v_ztwwV4Mp@shell.armlinux.org.uk>
References: <20250814082624.696952-1-horatiu.vultur@microchip.com>
 <20250814082624.696952-4-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814082624.696952-4-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 14, 2025 at 10:26:23AM +0200, Horatiu Vultur wrote:
> The functions lan_*_page_reg gets as a second parameter the page
> where the register is. In all the functions the page was hardcoded.
> Replace the hardcoded values with defines to make it more clear
> what are those parameters.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

LGTM.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

