Return-Path: <netdev+bounces-132614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A89926F8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD95128255B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6F18B462;
	Mon,  7 Oct 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R3fdxtJI"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529F17C20F;
	Mon,  7 Oct 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289684; cv=none; b=oqgpXs7WfB1JsaCqpCHafBE6nVsNzgIqkTUCL3BR7Im9rJOQakG8IZ9VbdRpH8LDqAW7M3KFLhZJjJUteeJbVfucNpXm26zpehzC7vbrQT0BWRV/KJY7aIe7NRVPGDAM8901a0K3fO3K701Tt1whJl/oRl15aNaxJ7vu2GY7BgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289684; c=relaxed/simple;
	bh=kpf8VNlOFh0AUiR7vUtF1GKwXGg++z0c9xqDVp0WfVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsPJ5IjkVnewpbpys3CbGYp+UZJ/6Lb/QlUTMmaVQOD6z0aki6Rq45CQxBqPolhZrvswSJiT0zvTicYyab09+pOHVlEYGk/9hJscSy/pLdO/Z/5ypaLuu8lH07TjJPr+2joT+lN3ShOzytWb0kk2/zX94AoqIDBwBIrn9jTmBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R3fdxtJI; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A9EF1C1FF8;
	Mon,  7 Oct 2024 08:27:24 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D08B81BF204;
	Mon,  7 Oct 2024 08:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728289637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDlA1X7tGs3142aa6D/JEOTJoAWg3dIH40lOQBP02kw=;
	b=R3fdxtJIxcXhhUkm9VQMwfMFsiGqQYjaeiAeB7qGedH07dwtd6wXyG+sTwrnE7YrHqeFLw
	45ZzuDHNCPE5LUmdMoMzvT53VeJiGgav2zbgQvI8W9WVb4kiPHpkrew2SBgT1BXmooyg9N
	Fuq+EjkkcIPcE2DY4kYYkgMUoIbGJ6bvnv7ENLtiV5dzZJbViyOSnTpr0L8OiKse8ER1Le
	FccFecqNRUgKXPGldbmHkEInA2J6Gx6nIXfs4YEX+M25zzxnVMCeJZhrdvi9h9PipP3TTW
	WDb9i9HX2Ec5tpUpos4rpgORi9AUz7cLDVLRg2Cl9Jgj6w91jPtKm0qX7Cm4ew==
Date: Mon, 7 Oct 2024 12:25:13 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 0/9] Allow isolating PHY devices
Message-ID: <20241007122513.4ab8e77b@device-21.home>
In-Reply-To: <ZwAfoeHUGOnDz1Y1@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<ZwAfoeHUGOnDz1Y1@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell

On Fri, 4 Oct 2024 18:02:25 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> I'm going to ask a very basic question concerning this.
> 
> Isolation was present in PHYs early on when speeds were low, and thus
> electrical reflections weren't too much of a problem, and thus star
> topologies didn't have too much of an effect. A star topology is
> multi-drop. Even if the PCB tracks go from MAC to PHY1 and then onto
> PHY2, if PHY2 is isolated, there are two paths that the signal will
> take, one to MAC and the other to PHY2. If there's no impediance match
> at PHY2 (e.g. because it's in high-impedance mode) then that
> transmission line is unterminated, and thus will reflect back towards
> the MAC.
> 
> As speeds get faster, then reflections from unterminated ends become
> more of an issue.
> 
> I suspect the reason why e.g. 88x3310, 88E1111 etc do not support
> isolate mode is because of this - especially when being used in
> serdes mode, the topology is essentially point-to-point and any
> side branches can end up causing data corruption.

I suspect indeed that this won't work on serdes interfaces. I didn't
find any reliable information on that, but so far the few PHYs I've
seen seem to work that way.

The 88e1512 supports that, but I was testing in RGMII.

> 
> So my questions would be, is adding support for isolation mode in
> PHYs given todays network speeds something that is realistic, and
> do we have actual hardware out there where there is more than one
> PHY in the bus. If there is, it may be useful to include details
> of that (such as PHY interface type) in the patch series description.

I do have some hardware with this configuration (I'd like to support
that upstream, the topology work was preliminary work for that, and the
next move would be to send an RFC for these topolopgies exactly).

I am working with 3 different HW platforms with this layout :

      /--- PHY
      |
MAC  -|  phy_interface_mode == MII so, 100Mbps Max.
      |
      \--- PHY

and another that is similar but with RMII. I finally have one last case
with MII interface, same layout, but the PHYs can't isolate so we need
to make sure all but one PHYs are powered-down at any given time.

I will include that in the cover.

Could we consider limiting the isolation to non-serdes interfaces ?
that would be :

 - MII
 - RMII
 - GMII
 - RGMII and its -[TX|RX] ID flavours
 - TBI and RTBI ?? (I'm not sure about these)

Trying to isolate a PHY that doesn't have any of the interfaces above
would result in -EOPNOTSUPP ?

Thanks,

Maxime


