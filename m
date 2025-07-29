Return-Path: <netdev+bounces-210743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D966B14A37
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955E117E907
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E6284B42;
	Tue, 29 Jul 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SgzbsFIO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B446257444;
	Tue, 29 Jul 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778272; cv=none; b=BSZ8+xCRTLdo6RfOopOzOEb+1VuUvj+NM7vsRkOmL3Vu8umUNM8/nLlDG2ZrHuPJDsbpwD06UXGC8EbvZbBSknSbkN1vqmWZS1LiSb/GJpmKajffpnD5DOUHQ71k2sLb5zRfF4nsoUADROVTZglTW5xMDAdMXTQcr57jl9lZM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778272; c=relaxed/simple;
	bh=y/Y5P0CroU7rC8cmm95jgO2l2qmNjaJJzsY9D8+nsIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEEfbel0IljoCFnx6p4RIZGHT1+xlWzAD4FAcFXl21oXA/kRTK1UdKK+jreLYdlDJicmf0HzQkqV4uVbbURrN0feTuW1/C4lROfxyu+HLhWa9gcVaRlE3RlfL34beZIFdLoaLI5hBQZ/Paz0MiMBWvlVvpFvQkMwacJM7bVXFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SgzbsFIO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tZ00Hjq0cuPOuG6PFQ6g7fs+gf4AGbwqsb/B90LUVb8=; b=SgzbsFIObH7edu8MVUwwjZksCD
	IKy0+ailYqETjkusyuO1+A+LD4jq8i739OmqohgmgEA580cv2xH+w6VnyXq+aInH6arHdpvuasfOi
	6E/DgYOH0ufeqYtER2qnhhJytL4bFWazHJkf2G+z+0aAoz24HgIlvR588Y+wqCRV5u+v1zDMykM5b
	toxjuM6r4Se2efghVUMERX76JnjNkCLUeW1srE3lBcGg5Ky9MQmXmf9xc391pUg3LxWwQSHH2DDM2
	YIwFWlYiihKPA7sRhDq1FfUtury00VHL67ULCjJZ+y1qxvz2NQJayn24No3jhTn1321AQJlCP5TaM
	zBdzv5Ww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44212)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ugfq5-0001aV-1N;
	Tue, 29 Jul 2025 09:37:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ugfq2-0007F0-20;
	Tue, 29 Jul 2025 09:37:34 +0100
Date: Tue, 29 Jul 2025 09:37:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH] net: phylink: add .pcs_link_down PCS OP
Message-ID: <aIiITk-7WPYMzcEl@shell.armlinux.org.uk>
References: <20250729082126.2261-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729082126.2261-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 29, 2025 at 10:21:23AM +0200, Christian Marangi wrote:
> Permit for PCS driver to define specific operation to torn down the link
> between the MAC and the PCS.
> 
> This might be needed for some PCS that reset counter or require special
> reset to correctly work if the link needs to be restored later.
> 
> On phylink_link_down() call, the additional phylink_pcs_link_down() will
> be called before .mac_link_down to torn down the link.
> 
> PCS driver will need to define .pcs_link_down to make use of this.

I don't accept new stuff without a user. Please provide the user as
well. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

