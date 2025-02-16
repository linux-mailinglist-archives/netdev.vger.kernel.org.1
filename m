Return-Path: <netdev+bounces-166765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D14A373D0
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 11:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CE01888F37
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473917E45B;
	Sun, 16 Feb 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VjJneWTj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CD3D6F;
	Sun, 16 Feb 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739702060; cv=none; b=TafHHVy4rzX2zbpYclCa+4V4iKXoVGToFnMMsRpmTDoCTAwIQNnqNJTXJVnvVTJTT4L7xwK8bZ8/3FaUVd4qvnIr64W9tsGhez1zXPe5qFVPX/j06gJBxl4b7/kttB2O68yBRIheXlQCSNosHk9YaKmVkw7CMqsPle1Pitq2HIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739702060; c=relaxed/simple;
	bh=Vrf7G8irWAo6PEXPpzbAIqV1n/6wm/915ST2QvoIDYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRJP+GEaPgCyXIXtaRXdxKjnDXzesAVbwdkhjbBAE9BsYcr3oI/jv9re5dO9hxTtHTnT7tSndfr2SUYchxMujyGEvh+aLtswuJegzmA3ShMlpmJ7afXsD9X2iKbxqFE4PhEcaiZam/sJAmLXxJ2LdVgZNAl1i1Swfgrk1RoUYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VjJneWTj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YGarZozGAl6CKN/wi5UFirJktubp5acuW0QTwj6NYIU=; b=VjJneWTjzD9tIJJu9OCdzjp5c1
	DTEVY9e58W1HB8t9izvBS7heYLqPPXPMYwcd3eoGnSEuCMEgP27GI2LwTL5r19f44QOE151IfsBI/
	KgjCrAzPhLx/4qlklsURPRVW1PhYfPAfrFrDq5zuR+RUm2G1oM6TJufALXEUDZ4wLiilHT1o9I8FH
	aZmS2LrSl64QtyEBjBQ6bP+/292Ez+hcAUknA38hhGZIsNXSMvHqMJQ2I0rTHuY/bMcIG1xodWGaa
	D1u6FNM3B1XdeMPnRKSz3nzwNJv9Aou5u+E/JMRpKmcVfL6+S8mTi2dPW4avcHZIV2fTT2N1A6DMT
	YLZlwSyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53324)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjbyS-0002w6-31;
	Sun, 16 Feb 2025 10:34:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjbyE-00058N-0u;
	Sun, 16 Feb 2025 10:33:54 +0000
Date: Sun, 16 Feb 2025 10:33:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, visitorckw@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] net: stmmac: Use str_enabled_disabled() helper
Message-ID: <Z7G_EpgKRdaCRKfy@shell.armlinux.org.uk>
References: <20250215164412.2040338-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215164412.2040338-1-eleanor15x@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 16, 2025 at 12:44:12AM +0800, Yu-Chun Lin wrote:
> As kernel test robot reported, the following warning occurs:
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:582:6-8: opportunity for str_enabled_disabled(on)
> 
> Replace ternary (condition ? "enabled" : "disabled") with
> str_enabled_disabled() from string_choices.h to improve readability,
> maintain uniform string usage, and reduce binary size through linker
> deduplication.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502111616.xnebdSv1-lkp@intel.com/
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>

Patch looks fine to me, but netdev requires that the tree for which the
patch is destined to be specified in the subject line - either:

	[PATCH net] - strictly for fixes only
	[PATCH net-next] - for development/new features

Given that this isn't a user visible bug, net-next would be appropriate.
Please resend with the appropriate tag only after 24 hours have elapsed
after the last interaction with this email thread.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

