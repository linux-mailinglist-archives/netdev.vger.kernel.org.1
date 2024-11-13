Return-Path: <netdev+bounces-144290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541049C6739
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C5B1F21A70
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F939139D1B;
	Wed, 13 Nov 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyq7wN6j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1A137772;
	Wed, 13 Nov 2024 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464550; cv=none; b=F6xQxB3ziuwLRtX5dUBDrjfkMfKOqFJUNB558POMq1JItNT2O717BYV0wsEKwdzKO9RPE+aFN2OyDr6Mqikjb2GshH4tnG2qdBd82Li+Ez7hXEyo6q/uZrxEDaIBzQms2z4B09W4L1wYifzEh1rowff2ftIEQMfyycLzfzoTXco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464550; c=relaxed/simple;
	bh=3MOEOz7U56AubjoEEEnIii16Efx7jLN1fpyJTyOxf6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6KcjKHNR7tcR+cktP2nf5IEPxZZ+hVvrrifs/NxYAQwnmONV3n6QNSi/Ty2CrX+4fbGE7Y9o8FXSEk2iOsR+V1+XlSVPPjZQwFeCqIdUH2xRjBfXRbRJSiy2pTVJudPQ6GlciYznh+3yUS8X3mUuz2RGTsgBsXe9UJFdhGdJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyq7wN6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0421C4CECD;
	Wed, 13 Nov 2024 02:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731464549;
	bh=3MOEOz7U56AubjoEEEnIii16Efx7jLN1fpyJTyOxf6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oyq7wN6jYEm6bdGCg78fyW+I/oBKCO25vZBLbF39YhkH0ZUQKsMb1VaZQ1ugTAfjD
	 DfpyzLPrRbSE2vzqG0KEwXOZkC08XO4UuvM2R7LjVmSNr/0i4likNKKubGWTNGxEYy
	 1nOeWk5QZMpMJI2ZeN4FjVhuVJferVuCbD0ZhSREoKoCLQitCr7rplUEruZ4ae/kxW
	 Hh94dK8uveCZy8ybd/Jp0+MywznLmpm0Fl7l+vGlrOtoC2AY3IxCNAQ8vJXW/zdvQ2
	 ioze5B+5SEEVaCdS5Ob/8v0blpduGXKaLSxXG4qlAqsVGHbAHeXJYjbpbMT/sWgu9n
	 6ufL1Cst5xH0A==
Date: Tue, 12 Nov 2024 18:22:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v19 03/10] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20241112182226.2a6c8bab@kernel.org>
In-Reply-To: <20241112111232.1637f814@kmaincent-XPS-13-7390>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
	<20241111150609.2b0425f6@kernel.org>
	<20241112111232.1637f814@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 11:12:32 +0100 Kory Maincent wrote:
> > Storing the info about the "user" (netdev, phydev) in the "provider"
> > (PHC) feels too much like a layering violation. Why do you need this?  
> 
> The things is that, the way to manage the phc depends on the "user".
> ndo_hwtstamp_set for netdev and phy_hwtstamp_set for phydev.
> https://elixir.bootlin.com/linux/v6.11.6/source/net/core/dev_ioctl.c#L323
> 
> Before PHC was managed by the driver "user" so there was no need for this
> information as the core only gives the task to the single "user". This didn't
> really works when there is more than one user possible on the net topology.

I don't understand. I'm complaining storing netdev state in 
struct ptp_clock. It's perfectly fine to add the extra info to netdev
and PHY topology maintained by the core.

> > In general I can't shake the feeling that we're trying to configure 
> > the "default" PHC for a narrow use case, while the goal should be 
> > to let the user pick the PHC per socket.  
> 
> Indeed PHC per socket would be neat but it would need a lot more work and I am
> even not sure how it should be done. Maybe with a new cmsg structure containing
> the information of the PHC provider?
> In any case the new ETHTOOL UAPI is ready to support multiple PHC at the same
> time when it will be supported.
> This patch series is something in the middle, being able to enable all the PHC
> on a net topology but only one at a time.

I understand, I don't want to push you towards implementing all that.
But if we keep that in mind as the north star we should try to align
this default / temporary solution. If the socket API takes a PHC ID
as an input, the configuration we take in should also be maintained
as "int default_phc", not pointers to things.

IOW I'm struggling to connect the dots how the code you're adding now
will be built _upon_ rather than _on the side_ of when socket PHC
selection is in place.

