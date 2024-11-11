Return-Path: <netdev+bounces-143861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9035D9C498B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54568288989
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 23:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE01B4F07;
	Mon, 11 Nov 2024 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+Gg9nRi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE5B16F0CA;
	Mon, 11 Nov 2024 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731366372; cv=none; b=H3YjDkcO8ohtrIHXjLkAx49rmjfOSbDWbKNkp40uhSyIMS+N8Z072Q1pnTyb70Ut9atorEm7iG/k2Kz7RcMIihHfX/uIbgbGhA4cCv0VI5h0Rv5ptAxJ59S2Fr0R0gQbPE8nVYZ1EWYrdJZg6ZOoKnSgbSEKI+z69qy0TZ6ArFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731366372; c=relaxed/simple;
	bh=5cQ0zZajVpfP0QpuAM0B+3kFcgW+YfPO7ZhjFNsXkNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsGM0DadK1B1wJfU/C93TOodQYKj/bX0FNiN+Gfd9Q7afhHcWq2CUHpBMOmGCkuei7WPKqxgCvP+d0vnKYkRNCrCAzhD4nIUmiE6Uqlp3VvjNAnW5uL8I0MnISahoyMG7sJ0NuWwcK8zbwg82re9dHJuIXTbyru25YBeo2tT9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+Gg9nRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B25CC4CECF;
	Mon, 11 Nov 2024 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731366372;
	bh=5cQ0zZajVpfP0QpuAM0B+3kFcgW+YfPO7ZhjFNsXkNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S+Gg9nRivyOHyZripGCNnKCa1o8L3XYcZA5Zrum3/rqRrjztDRo3fPkVSMfcuBDU8
	 4lH1rH/Jlxk5mtst2T1xiWmFeLPTdpOodh6xJObbGFxFcgi7V2vPX0/0+HUK3mO2ep
	 McajZR4QGpy+nMDTTp1r5S2dDGsJeODW6JlgVmWtDbPCEpzf8/lAHj0I3tpnha966Q
	 zDw1Wzh78DRKJ7aWZs0wNi2sFGfFpV3Ri7c50H2cGfWZ58QDkhsObjAi9ow9yE1wsn
	 A7oe5ai8ZCZHxq2Lcod0G2HqK/v5uV+0dCyYTI7oO9nvsGGypNGz6t+2+BWqoYvePi
	 o82cYopzw5H8g==
Date: Mon, 11 Nov 2024 15:06:09 -0800
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
Message-ID: <20241111150609.2b0425f6@kernel.org>
In-Reply-To: <20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 14:54:45 +0100 Kory Maincent wrote:
> @@ -41,6 +43,11 @@ struct ptp_clock {
>  	struct ptp_clock_info *info;
>  	dev_t devid;
>  	int index; /* index into clocks.map */
> +	enum hwtstamp_source phc_source;
> +	union { /* Pointer of the phc_source device */
> +		struct net_device *netdev;
> +		struct phy_device *phydev;
> +	};

Storing the info about the "user" (netdev, phydev) in the "provider"
(PHC) feels too much like a layering violation. Why do you need this?

In general I can't shake the feeling that we're trying to configure 
the "default" PHC for a narrow use case, while the goal should be 
to let the user pick the PHC per socket.

> +/**
> + * netdev_ptp_clock_register() - Register a PTP hardware clock driver for
> + *				 a net device
> + *
> + * @info: Structure describing the new clock.
> + * @dev:  Pointer of the net device.

> +/**
> + * ptp_clock_from_netdev() - Does the PTP clock comes from netdev
> + *
> + * @ptp:  The clock obtained from net/phy_ptp_clock_register().
> + *
> + * Return: True if the PTP clock comes from netdev, false otherwise.

> +/**
> + * ptp_clock_netdev() - Obtain the net_device reference of PTP clock

nit: pick one way to spell netdev ?

> +	ret = ptp_clock_get(dev, ptp);
> +	if (ret)
> +		return ERR_PTR(ret);

why do you take references on the ptp device?

