Return-Path: <netdev+bounces-21523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B162F763CB8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651CA2819E0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287721AA76;
	Wed, 26 Jul 2023 16:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1891802C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:43:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17D26AE
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xmIyfPnDArWfzWAoPJJMuxu5k+1HCUBA0+YqMDldAOw=; b=Gfoi1OXJjYJO2oICI9vQKdfiEL
	MU8dWfExQsyeZkh3L0R/C1aSYI6JeaG8qvUYWGT6rskXva7fqNHdT2p3rlbGS8GHgqJnMZw6416EA
	gm1JD5485WuYhAjzg0iQML1hjya3Wfjb9ZkIk/KOpat8rB5qYNcvLxh8NegGvqe3frP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOhbJ-002NPs-QX; Wed, 26 Jul 2023 18:43:01 +0200
Date: Wed, 26 Jul 2023 18:43:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <ba6f7147-6652-4858-b4bc-19b1e7dfa30c@lunn.ch>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
 <ZL+6kMqETdYL7QNF@corigine.com>
 <ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
 <4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
 <21770a39-a0f4-485c-b6d1-3fd250536159@lunn.ch>
 <20230726090812.7ff5af72@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726090812.7ff5af72@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 09:08:12AM -0700, Jakub Kicinski wrote:
> Sorry for chiming in, hopefully the comments are helpful..

Thanks for commenting. This is a somewhat unusual setup, a server
style Ethernet interface which Linux is driving, not firmware. So its
more like an embedded SoC setup, but has NCSI which embedded systems
don't.

> On Wed, 26 Jul 2023 10:54:25 +0200 Andrew Lunn wrote:
> > As far as i understand it, the host MAC is actually a switch, with the
> > BMC connected to the second port of the switch.
> 
> Not a learning switch (usually, sigh), but yes.
> 
> > Does the BMC care about the PHY status?
> > Does it need to know about link status? 
> 
> Yes, NIC sends link state notifications over the NCSI "link?" (which 
> is a separate RGMII?/RMII from NIC to the BMC). BMC can select which
> "channel" (NIC port) it uses based on PHY status.

How do you define NIC when Linux is driving the hardware, not
firmware? In this case we have a MAC driver, a PCS driver, a PHY
driver and phylink gluing it all together. Which part of this is
sending link state notifications over the NCSI "Link?".
 
> > Does the NCSI core on the host need to know about the PHY?
> 
> There is no NCSI core on the host.. Hosts are currently completely
> oblivious to NCSI. The NCSI we have in tree is for the BMC, Linux
> running on the BMC (e.g. OpenBMC).

But in this case, it is not oblivious to NCSI, since the host is
controlling the PHY. This patch is about Linux on the host not
shutting down the PHY because it is also being used by the BMC.

	 Andrew

