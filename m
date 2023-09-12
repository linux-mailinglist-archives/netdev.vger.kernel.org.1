Return-Path: <netdev+bounces-33293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570A079D550
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0758A281702
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11A18C19;
	Tue, 12 Sep 2023 15:51:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056B1803C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:51:43 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DF10DE;
	Tue, 12 Sep 2023 08:51:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D2B51BF20A;
	Tue, 12 Sep 2023 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694533900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VOjAOePJcDHCndNePvN61Fv7OvE6NmezJq/v8uWj44=;
	b=jDlbsliqcYyLoi38muqLaHMIZVBfjXad48Y80sWmD5rJB3EOIy4nANTXOyrDJch05/Zy5T
	c29Cu3EoTcNkAkPUhT3M0+xjhh0Rnljd7Pf6xW52OVYSHmFhayofrMed1xdICQJQ1MkCPS
	XvjvNLns6S/2y7RJhcL2PVWa8/AZ0c0I7HlKG231LArVMuQv5qW1dIKg2HTTamEer9q9Oa
	7WrymJafif/zGeWGfY5KJPd05IzM783IuH4iHVoOVEfhTgnHPaXw1hZrKP4YJr2ecE3/ae
	ov4NGoxA95XaP8QFnRdKm6AdOudDi4BZou+FX4MjRGtPkPCp0V5qSax6ZhdonQ==
Date: Tue, 12 Sep 2023 17:51:38 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <linux@rempel-privat.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <20230912175138.729ce011@fedora>
In-Reply-To: <e1de6afe-346f-42bf-8f7a-8621c2e26749@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<e1de6afe-346f-42bf-8f7a-8621c2e26749@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Tue, 12 Sep 2023 17:36:56 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > The PHY namespace is for now contained within struct net_device, meaning
> > that PHYs that aren't related at all to any net_device wouldn't be
> > numbered as of right now. The only case I identified is when a PHY sits
> > between 2 DSA switches, but I don't know how relevant this is.  
> 
> It might be relevant for the CPU port of the switch. The SoC ethernet
> with a PHY has its PHY associated to a netdev, and so it can be
> managed. However, the CPU port does not have a netdev, so the PHY is a
> bit homeless. Phylink gained the ability to manage PHYs which are not
> associated to a netdev, so i think it can manage such a PHY. If not,
> we assume the PHY is strapped to perform link up and autoneg on power
> on, and otherwise leave it alone.

I agree and my plan, although still a bit hazy, is to share the phy_ns
between the netdev associated to the Ethernet MAC and the CPU dsa_port
of the switch, as they are on the same link. We could grab infos on the
PHYs connected to the port that way. Although the PHY isn't connected
to the same MAC, it's part of the same link, so I think it would be OK
to share the phy_ns.

We already do something in that direction, which is the stats gathering
on the CPU dsa port, which are reported alongside stats from the
ethernet MAC.

Would that be OK ? I haven't started the DSA part, I was waiting for
review on the overall idea, but I tried to keep this into consideration
hence the phy_ns notion :)

Thanks,

Maxime

