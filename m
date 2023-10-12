Return-Path: <netdev+bounces-40358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6262B7C6E68
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CA81C20C94
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5225107;
	Thu, 12 Oct 2023 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o9GcXIAS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD1208D5
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:45:48 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD669BA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q5CgV1ItkLayLdnkEq41KCTvrOkCEeNEb8NVimejVY8=; b=o9GcXIASuyR0i3KtJEFM4dVURh
	wxOK/RDsEGMDt4Nju+x6alG1v2thTKfuAZcW4d4Ex2DnxlB5e6riDhVVIsZYh3SddAcEn7hofcczq
	fGm0QKz7Z8tM66BKBZl+inbqzmO6EYGNZpu6deDVcnmlPuF1GDCx2+chx6LJc+vr2c8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qqv4Q-001v4Z-Bm; Thu, 12 Oct 2023 14:45:42 +0200
Date: Thu, 12 Oct 2023 14:45:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, opendmb@gmail.com,
	justin.chen@broadcom.com
Subject: Re: [PATCH net-next 1/2] ethtool: Introduce WAKE_MDA
Message-ID: <78aaaa09-1b35-4ddb-8be8-b8f40cf280bc@lunn.ch>
References: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
 <20231011221242.4180589-2-florian.fainelli@broadcom.com>
 <20231011230821.75axavcrjuy5islt@lion.mk-sys.cz>
 <3229ff0a-5ce5-4ee2-a79d-15007f2b6030@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3229ff0a-5ce5-4ee2-a79d-15007f2b6030@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> I am having some second thoughts about this proposed interface as I can see
> a few limitations:
> 
> - we can only specify an exact destination MAC address to match, but the HW
> filter underneath is typically implemented using a match + mask so you can
> actually be selective about which bits you want to match on. In the use case
> that I have in mind we would actually want to match both multicast MAC
> destination addresses corresponding to mDNS over IPv4 or IPv6
> 
> - in case a MAC/PHY/switch supports multiple filters/slots we would not be
> able to address a specific slot in the matching logic
> 
> This sort of brings me back to the original proposal which allowed this:
> 
> https://lore.kernel.org/all/20230516231713.2882879-1-florian.fainelli@broadcom.com/

The Marvell PHY i just looked at supports upto 8 slots, and can match
up to the first 128 bytes of frame data. So it does seem like a more
generic and flexible interface would fit the hardware.

My previous concern was discoverability of the feature. Its not part
of ethtool -s eth0 wol. At minimum, i would suggest something in the
--help text in the wol section and man page pointing to the
alternative way to configure wol. And maybe report via the standard
wol flags that the hardware has the capability to use flow-type WoL?

The example you gave matched on Flow Type: Raw Ethernet. Is it
possible to combine flow types? If i can match on the first 128 bytes
of the frame i might want to go deeper into the frame, so want both
Ethernet and IP matching?

    Andrew

