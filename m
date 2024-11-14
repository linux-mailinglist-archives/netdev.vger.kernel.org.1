Return-Path: <netdev+bounces-144627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFFB9C7F6D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D685B22A86
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A6DF5C;
	Thu, 14 Nov 2024 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urMKE+0p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F40A95C;
	Thu, 14 Nov 2024 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731544767; cv=none; b=MakPVUhPT3wGcLedZXotzVUua3mDkj+uVXbendzR+O6CW1rof794TwOix/EA4lEFsfJs8lcykfcPV6Sk78aovE9hRF8rDd6Zh0a7l5TOU5OLgf/toNO5xaRcUBLO8rpvjoDzdi6I/a0CjORTQsXj+dQzGZQZOIfhARKd6HslcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731544767; c=relaxed/simple;
	bh=M6ItR/lDbn7nuwHceUHxG8faR8R5lWBgt5KuTnUDLpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvwYtehO+j+tdOzHLa1V7WGRQzSK6cliMtPRkFckVxlLC8Io1JPJ9mLd3MoJu2aXIu9gPeJR7Vp2F+WBzBfxznmvToyGeEmcZhMEnWOZSbQXf+Y6fwJrfdUCdG0/StiVIwlxbMEu60r5hcspKJcsQPWAAs+47m5D9TTCv7kmYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urMKE+0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFE2C4CECD;
	Thu, 14 Nov 2024 00:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731544767;
	bh=M6ItR/lDbn7nuwHceUHxG8faR8R5lWBgt5KuTnUDLpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=urMKE+0pIJbAqqWBaMVXUQwRD09oPxnn+n8UWVEHTvixXrLHbjrsGZ7KggONqUP87
	 i/P3mc2dlSbl2JaqgFHNUX2NQLx7oOC8uI2Ow5CXdLOg+IvHcYOQuDn/FIb+JhTn6Q
	 QJOtPH1NVqffOVpDZKJmSPjdbW9QB0Dfu6WnPtWLHT+S+MH/QTCjrpJN4B5Imjb21w
	 O0B7ojUKn1Ai+rnyApv/3ZMV8+qPd2h3LmMu9S1zFolKtwkG8T8A8crISe6nEXRmGR
	 j8PNmjbT/IegykTrgpXv1Lu1++9t6fVkUCYuIOaAi0BgdnDHZJvGOOHJ/hGPWBTj/N
	 uaMVPHRgOSypw==
Date: Wed, 13 Nov 2024 16:39:25 -0800
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
Message-ID: <20241113163925.7b3bd3d9@kernel.org>
In-Reply-To: <20241113113808.4f8c5a0b@kmaincent-XPS-13-7390>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
	<20241111150609.2b0425f6@kernel.org>
	<20241112111232.1637f814@kmaincent-XPS-13-7390>
	<20241112182226.2a6c8bab@kernel.org>
	<20241113113808.4f8c5a0b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 11:38:08 +0100 Kory Maincent wrote:
> > IOW I'm struggling to connect the dots how the code you're adding now
> > will be built _upon_ rather than _on the side_ of when socket PHC
> > selection is in place.  
> 
> I see what you mean! It is not something easy to think of as I don't really
> know how it would be implemented.
> Do you think adding simply the PHC source and the phydev pointer or index would
> fit? 

In net_device? Yes, I think so.

> This could be removed from netdev core when we move to socket PHC as it
> won't be necessary to save the current PHC.

