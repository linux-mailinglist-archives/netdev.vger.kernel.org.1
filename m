Return-Path: <netdev+bounces-21508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C211C763BF9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CDB1C212EB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8484637990;
	Wed, 26 Jul 2023 16:08:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B3E57F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0ABC433C8;
	Wed, 26 Jul 2023 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690387694;
	bh=bqpi2yisVpft8RVYJS4GnXOEF4ZISCBiQTTjOYYt6iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bz8ytEM3Ku/GqEICHRxOPvkR13tKR3iRgyknpuqXY+NU9ztetkFCRRgyfgCHdv7Tv
	 FcZi8WTj9fOQxyVT7UsYXqMZ404SGESO9xp2SHFQdqt/H/NspFQHwhZuFBwfFt533R
	 gwim+rcuainbJAQDvNMe4NqUoY/WJcDt4545FuanyVpzOeosEq1gnfvuDDcpPpukms
	 3Kmx56Pl/bD0WMMnG/0GCvhmgEDztc8a+qZ2BDqJGQNSveOrFe/njuXVQM3+TDVgZF
	 J8dDHqrDy6SN4f3kSErlGTrYxwyIInOmsvgBjl1ylXze2wMbua9lL6gyLCRYMQyLNg
	 V/nI9KhWkbMZA==
Date: Wed, 26 Jul 2023 09:08:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, Simon Horman
 <simon.horman@corigine.com>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <20230726090812.7ff5af72@kernel.org>
In-Reply-To: <21770a39-a0f4-485c-b6d1-3fd250536159@lunn.ch>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
	<20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
	<ZL+6kMqETdYL7QNF@corigine.com>
	<ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
	<4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
	<21770a39-a0f4-485c-b6d1-3fd250536159@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry for chiming in, hopefully the comments are helpful..

On Wed, 26 Jul 2023 10:54:25 +0200 Andrew Lunn wrote:
> As far as i understand it, the host MAC is actually a switch, with the
> BMC connected to the second port of the switch.

Not a learning switch (usually, sigh), but yes.

> Does the BMC care about the PHY status?
> Does it need to know about link status? 

Yes, NIC sends link state notifications over the NCSI "link?" (which 
is a separate RGMII?/RMII from NIC to the BMC). BMC can select which
"channel" (NIC port) it uses based on PHY status.

> Does the NCSI core on the host need to know about the PHY?

There is no NCSI core on the host.. Hosts are currently completely
oblivious to NCSI. The NCSI we have in tree is for the BMC, Linux
running on the BMC (e.g. OpenBMC).

> You might want to take a step back and think about this in general. Do
> we need to extend the phylink core to support NCSI? Do we need an API
> for NCSI?

Today it's mostly configured via "BIOS". But I think letting user know
that the link is shared with NCSI would be useful.

Last week someone was asking me why a certain NIC is "weird and shuts
down its PHY when ifdown'ed". I'm guessing some sysadmins may be so used
to NCSI keeping links up they come to expect it, without understanding
why it happens :(

