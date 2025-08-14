Return-Path: <netdev+bounces-213643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB2CB26104
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031CF6266A7
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB73C2EA466;
	Thu, 14 Aug 2025 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mFD1kJHr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CF2EA739;
	Thu, 14 Aug 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163690; cv=none; b=VksjBgzbso1XVrLeKZm5WOzf40UKyJGYfvQLEqPPo6x+ozaGRP3BoUTHSI8U+7BigK1jJmLOcxqvNYf9yFOXBX4lsZFqPj2K3tq7OzvZ/wK/RcALQIfekcuCYHNM/+s+ZLS4rbUtZTjW8DZP+yvfkhABP2XFrlUA8mOiqwI5C7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163690; c=relaxed/simple;
	bh=lVD/y/Z423YcD8a+5lf5IjwNcXkcGmTOuO3ONKwdhAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmtqWib1a4Fj60KTHoO0+bo1vYvAxAmxPL5soV9V1HkywlCovysy1c3BYnw7/yEVia4a4pgN9T8gqmLYIMd3wW6oHSWeGmfNsnrKTO748BuILEV7LC6bRR4+bZoZSmTLsirwN+OgChd7X9QadU6hO+egyG2j3dtkdue+9GkytB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mFD1kJHr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nwemvRAez+XUSopejbooESoxF8Q8BlEs0fKrXkbagT0=; b=mFD1kJHrR6IiqAvaDlQ8H7FVmq
	O0OO6WGDSuBfGZnXI1H4a6G3QinL5lX+P3Xr3CJTBVR+dNGwfT6BmhRIXUQATzy583CB7Tld73bZh
	Ko3hl1DCmYPLHJOf7ZHy0QoOpT3TubhaLKeKC0pl72xqJkeNPmzBMclPcEgV3Gph17WhEPZauHbJG
	4qL/CWmykBcurEcXH3ev6E3IifRbRfpY6NMZnthPObKOEkafNQA4SDAIoGief8KsxRFntQAu8y/oq
	mYv8l1PsvkHl8ullIse7l9lgSKVx6l35mIPCN8bGWwWWxLDnJJJP+FUEjvF80AAZuG7/fqSqX8NhP
	r3DuU2Ww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49222)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umUFa-000848-2z;
	Thu, 14 Aug 2025 10:27:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umUFY-0006hN-1n;
	Thu, 14 Aug 2025 10:27:56 +0100
Date: Thu, 14 Aug 2025 10:27:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	alok.a.tiwari@oracle.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] net: phy: micrel: Start using
 PHY_ID_MATCH_MODEL
Message-ID: <aJ2sHPDAkaQq5jjC@shell.armlinux.org.uk>
References: <20250814082624.696952-1-horatiu.vultur@microchip.com>
 <20250814082624.696952-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814082624.696952-2-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 14, 2025 at 10:26:21AM +0200, Horatiu Vultur wrote:
> Start using PHY_ID_MATCH_MODEL for all the drivers.
> While at this add also PHY_ID_KSZ8041RNLI to micrel_tbl.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

I'm not sure about this patch. You're subsituting a match that uses
the desired ID with a mask of 0x00fffff0 with PHY_ID_MATCH_MODEL(id)
which uses a mask of 0xfffffff0.

The commit description ought to explain why it is safe to match using
bits 31:24, whereas the old code was ignoring these bits.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

