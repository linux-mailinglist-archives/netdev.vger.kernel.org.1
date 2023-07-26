Return-Path: <netdev+bounces-21566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E1763E8F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60DD1C213AD
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1965D19886;
	Wed, 26 Jul 2023 18:29:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32819884
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C16FC433C7;
	Wed, 26 Jul 2023 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690396197;
	bh=LUUUjKfGWRRBpd4dO0vezPazE/ZGOV+Rn8udjr9+3lA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uboXJgCJo4k6QorereD3MQUPeJLYv5R1wzhkoEweewkjgJrIaWHUGE28P0//23lrD
	 pdFWqnpuMMrPfzBMmx4CAjY/nwbUOjXrPYW/zJKsEoUaBtFF6as/b+dBQIyWjwvPVe
	 2H1J2SrzPKNpLHC1RukJrD9oGnw9AeJzASEO7rDCV6YUK9nvBFe8J2sRfbLa/rqqNy
	 rdm9gcbc1+Q09gIFvyNIgytsyzcPIbMiv4TBLpxCPAyEnfh2U2gnaobc3apBPlBgBs
	 J0D/iFaHf/l5q0r8U8b6QpoQzZNNH7iJ95aoaY+/f1TIcPQtC6FPFWExL2W7TXiyKc
	 ummWUAowHpI7w==
Date: Wed, 26 Jul 2023 11:29:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, Simon Horman
 <simon.horman@corigine.com>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <20230726112956.147f2492@kernel.org>
In-Reply-To: <ba6f7147-6652-4858-b4bc-19b1e7dfa30c@lunn.ch>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
	<20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
	<ZL+6kMqETdYL7QNF@corigine.com>
	<ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
	<4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
	<21770a39-a0f4-485c-b6d1-3fd250536159@lunn.ch>
	<20230726090812.7ff5af72@kernel.org>
	<ba6f7147-6652-4858-b4bc-19b1e7dfa30c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 18:43:01 +0200 Andrew Lunn wrote:
> On Wed, Jul 26, 2023 at 09:08:12AM -0700, Jakub Kicinski wrote:
> > On Wed, 26 Jul 2023 10:54:25 +0200 Andrew Lunn wrote:  
> > > As far as i understand it, the host MAC is actually a switch, with the
> > > BMC connected to the second port of the switch.  
> > 
> > Not a learning switch (usually, sigh), but yes.
> >   
> > > Does the BMC care about the PHY status?
> > > Does it need to know about link status?   
> > 
> > Yes, NIC sends link state notifications over the NCSI "link?" (which 
> > is a separate RGMII?/RMII from NIC to the BMC). BMC can select which
> > "channel" (NIC port) it uses based on PHY status.  
> 
> How do you define NIC when Linux is driving the hardware, not
> firmware? In this case we have a MAC driver, a PCS driver, a PHY
> driver and phylink gluing it all together. Which part of this is
> sending link state notifications over the NCSI "Link?".

I've never seen a NCSI setup where Linux on the host controls the PHY.
So it's an open question.

The notifications are sent by the control FW on the NIC. There's a
handful of commands that need to be handled there - mostly getting MAC
address and configuring the filter. Commands are carried by
encapsulated Ethernet packets with magic ethertype, over the same RMII
as the data packets.

All of this is usually in FW so we should be able to shape the
implementation in the way we want...

> > > Does the NCSI core on the host need to know about the PHY?  
> > 
> > There is no NCSI core on the host.. Hosts are currently completely
> > oblivious to NCSI. The NCSI we have in tree is for the BMC, Linux
> > running on the BMC (e.g. OpenBMC).  
> 
> But in this case, it is not oblivious to NCSI, since the host is
> controlling the PHY. This patch is about Linux on the host not
> shutting down the PHY because it is also being used by the BMC.

Yup, we're entering a new territory with this device :S

