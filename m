Return-Path: <netdev+bounces-144235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F999C6336
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09499283C32
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79648219E34;
	Tue, 12 Nov 2024 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZK+on4Qv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7314C59C
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446336; cv=none; b=N8r9Noch23f4UBkYSSh0VJpByjqW7L5FfuQhs2PDGguT1pjSzicC5q30jgGNqGl++HE6c6LMsnq7Qj0j5Z07/vzS59aIVWxUZIOl1QMza7ycDG5FGAMwMjQ/fUOAp5mixx/F7UNmWwmFWLISyWifPA3fDf3vFyRf7co4KA81r+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446336; c=relaxed/simple;
	bh=d0QreS7zNTdD7rXjBnVZNqPD1TOlFiGO+Ulrj1K4eUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkvCiw0zG/hs8c+CKIP9GqHDw/R1JVSyRoTMEoAiuPKD0avkivmu4GQfoqtsGdR8PYZQgoYfikokVww5+VmEpVDw5zSxPcEp5YmHg+6oJeP6B/2rzk9jSHyp5lYDr1l31GZFFQtGbolwiSKKvng1/fbr5mlGhhWIslAXLz2851A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZK+on4Qv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=178xI/u5fYqhsBWCGnyt0T46V8UwrKmkjMYYPPlWYOY=; b=ZK+on4QvmLPVTbnzh3SI6al9hX
	rSX2Xk+cxxnME0mZKOujeV5FgIOGFTboXvPiWNi0GQPu1Fr5mkfaNFXYnPegwZBopusaD0O0wRwJ2
	cQpKRUxGRcn4on0eoozl6sq6NSFy4sUexHtxvbwoQgy+YjVSJuM+sg4VSmaw0EOOOBRi+08spJfq1
	6SzqAKPZiB8QLg0ekarV+1ufEx1zCG1Gwv+9B+L7jUIEk3mqzn/LAT+IR8+NCmJICh1b5q9ZmYNRE
	8hvJEQzavnS/cIzjnJgKJTOQTJXvrxUGDugSsUZQWm/4OmFHVRttsl5W4rFHZyJaKIo69QTL+Z2kZ
	8naCBVcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tAyHe-00051O-1C;
	Tue, 12 Nov 2024 21:18:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tAyHc-0007mT-18;
	Tue, 12 Nov 2024 21:18:44 +0000
Date: Tue, 12 Nov 2024 21:18:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: c45: don't use temporary linkmode
 bitmaps in genphy_c45_ethtool_get_eee
Message-ID: <ZzPGNDr8jnjg2WS5@shell.armlinux.org.uk>
References: <b0832102-28ab-4223-b879-91fb1fc11278@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0832102-28ab-4223-b879-91fb1fc11278@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 12, 2024 at 09:33:11PM +0100, Heiner Kallweit wrote:
> genphy_c45_eee_is_active() populates both bitmaps only if it returns
> successfully. So we can avoid the overhead of the temporary bitmaps.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

