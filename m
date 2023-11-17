Return-Path: <netdev+bounces-48740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2817EF641
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A291C20A6E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659E30640;
	Fri, 17 Nov 2023 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vp+mbtyy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96935194
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JEIhwEZuA/EO5C5JK29s8qNEnP4zzyp4aUEl26D2TUQ=; b=Vp+mbtyyC1mmOfUn6Ew43wFpx1
	m83kTh09Se3RYc5DhWP/qlPeygFI6efy5UuSiUdQaJ9XfvI6xwLVVPn8/xB+babZSSzvi1yY4Lfsh
	GNetwoKQShg32SuvfZ+kXGjCyJ9zUTDfPEzbHqvuSBFcTIojaBHf6SWv9TLLj8fB1u6mXbeyf6c5s
	ar8Aq+s621uBIHY4suu7F6EGKZrJv0NWHbxvq9ukvWhMlgcfx67GLVRUPwFNMeztGv0qafbIrL/QU
	MqkPHWUjnBC7hcSHws1pT1U6aH3olW8OB8CmU3YTKZIoXKYpzYYV7CEoZWK/WYMVCT0ZB7kT0fHo/
	kr5DhuiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33444)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r41lt-000329-13;
	Fri, 17 Nov 2023 16:32:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r41lu-0000HA-Vc; Fri, 17 Nov 2023 16:32:46 +0000
Date: Fri, 17 Nov 2023 16:32:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: use for_each_set_bit()
Message-ID: <ZVeVrmhZ3GNuE9Yx@shell.armlinux.org.uk>
References: <E1r3yPo-00CnKQ-JG@rmk-PC.armlinux.org.uk>
 <84b4b1b4-83e7-477b-9316-21c7a76689aa@lunn.ch>
 <ZVeSEv2nN1xioYz5@shell.armlinux.org.uk>
 <07171a9c-ef9c-4dcd-a977-61a7a068dfc6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07171a9c-ef9c-4dcd-a977-61a7a068dfc6@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 17, 2023 at 05:30:41PM +0100, Andrew Lunn wrote:
> > Hmm, indeed, thanks for spotting. I always forget whether I'll need to
> > send a v2 for something this trivial or whether netdev folk will fix
> > it up when committing it. I'm happy to resend.
> 
> You should resend. netdev patch acceptance is pretty bot driven, with
> the normal 'fast path' not allowing the patch to be edited by the
> merger.

I think it does happen sometimes? Or maybe I'm misremembering with other
subsystems...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

