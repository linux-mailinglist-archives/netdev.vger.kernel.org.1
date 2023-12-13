Return-Path: <netdev+bounces-56918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6780E81157B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A3C28116A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C1C2F849;
	Wed, 13 Dec 2023 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S1KJdxEy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F19A0;
	Wed, 13 Dec 2023 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kIJRGB7mIa7tpVmwJASBbdkeVUIyBOjlKcbZ7uMeRys=; b=S1KJdxEy3S2wKw5HhAOIvi4LZD
	3ZfMhG1j55QLofJe0a1KlTx/ytZ0QoqhEiCPDZKrMbFXuhy5LLAsyuVosSCkr37rNcJtciMxCYmdU
	2ZjhuNRlXkCZ88l4XatA0AGMZHLi1QiD3/EIFZA0O/U7lYOH7mi1uRX2p5Hf2b1nbDo3E/MZ15o50
	emD/ARxdip9ud/rVF3K4AB1pizPDNk2g1kLr/8wyrkeobVlLfKIbFM2ELQERUb3SsoDjphFv8Wik7
	VVcJFtdsBgI8PBB/aEQEQwNPC1Qubz+pniOZBspd+XbG5VLwkApUD3xnGkcZ9qEydEZHK2ZBaw5pM
	8fM+Cjvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58630)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDQjV-00005J-0l;
	Wed, 13 Dec 2023 15:01:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDQjV-0001Zs-U5; Wed, 13 Dec 2023 15:01:09 +0000
Date: Wed, 13 Dec 2023 15:01:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mdio: mdio-bcm-unimac: Delay before first poll
Message-ID: <ZXnHNTreKY/F2Aqm@shell.armlinux.org.uk>
References: <20231213000249.2020835-1-justin.chen@broadcom.com>
 <c3cc7a9d-d464-48e7-beb7-b90b1abbcfc7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3cc7a9d-d464-48e7-beb7-b90b1abbcfc7@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 13, 2023 at 11:57:52AM +0100, Andrew Lunn wrote:
> On Tue, Dec 12, 2023 at 04:02:49PM -0800, Justin Chen wrote:
> > With a clock interval of 400 nsec and a 64 bit transactions (32 bit
> > preamble & 16 bit control & 16 bit data), it is reasonable to assume
> > the mdio transaction will take 25.6 usec. Add a 30 usec delay before
> > the first poll to reduce the chance of a 1000-2000 usec sleep.
> 
> #define  MDIO_C45               0
> 
> suggests the hardware can do C45? The timing works out different then.
> Maybe add a comment by the udelay() that is assumes C22, to give a
> clue to somebody who is adding C45 support the delay needs to be
> re-evaluated.

Note, however, that the driver only supports C22 operations (it only
populates the read|write functions, not the c45 variants).

However, it doesn't explicitly set the MDIO_C22 bit in the configuration
register, so what ends up being spat out on the bus would be dependent
on the boot loader configuration.

However, I'm wondering why unimac_mdio_poll() isn't written as
(based on current code):

	return read_poll_timeout(unimac_mdio_readl(priv, MDIO_CMD), val,
				 !(val & MDIO_START_BUSY), 2000,
				 2000000);

rather than open-coding the io polling.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

