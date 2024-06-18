Return-Path: <netdev+bounces-104301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628D90C13D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442091C21668
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E7C8814;
	Tue, 18 Jun 2024 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0hUl0hc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE918645;
	Tue, 18 Jun 2024 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674018; cv=none; b=Mwq8iwD2sACt7GSfbLF9QsgHMScFYXDqUVaoz7wXIR/5Fqkez+0GIdKAzwl/AmJTTCt+4PRY9jQiZlt2Kthl005Z5RQDkwXeKWGdEMIjtQbFfx1Ld1U/tvUmfow+RzI/pmyIk0/ZhDurCP5QEdnPSp0biusfoFcGIoWL9UFFl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674018; c=relaxed/simple;
	bh=KXnyeUZKQle1zwKIOOJKrYTMEJiDwef4AK0JakWBWBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeUWLKQIIRIe47nlPEf5O7WQJwDroohn9QDU/NIBTzzD65TUWmAyKguPopWVO6QZblJytZ5d57yD+GUTvTjXe0+yd7Qi+E+kmyoNDli5wvcY0FPFJ/hA2PV1PsdbWihLPFSYrMc3n3TtEE5zUorZG7HzjJMrp3sBqxB4J0qZ7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0hUl0hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF1C3277B;
	Tue, 18 Jun 2024 01:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718674017;
	bh=KXnyeUZKQle1zwKIOOJKrYTMEJiDwef4AK0JakWBWBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a0hUl0hcKNGoURJaFMmNs0XcuTTCBVgQYn6sgxOFv3fmHHqmR8hawultecw7mSHrK
	 0ljqeb4rkQWFq8d77PTfN1i6qxxUUhyahDmogEZL8Rch0Y7D0lpcIwxjS2KHjTGsqD
	 yqAFJWZ3UIxwIvCUxiI2dmB+7HSM7pyDWbbdlpu/vnutGWz38oN9dyg3fa0qj78ZEG
	 6EuxX81snQYnDkcxWK3QRIcsdLiu3uRITNr6nlMPrpOkd7sZVzAHLdP1F01pwOcU5B
	 21SeJ5Wt9Qwo8SKmY+ssW46/Ri1lyz5r5geg2BjEpDHlarjUwT3cLCRphmrLexnE95
	 OI9S3aiabazdQ==
Date: Mon, 17 Jun 2024 18:26:55 -0700
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
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v15 04/14] net: Make net_hwtstamp_validate
 accessible
Message-ID: <20240617182655.6bec8d36@kernel.org>
In-Reply-To: <20240612-feature_ptp_netnext-v15-4-b2a086257b63@bootlin.com>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
	<20240612-feature_ptp_netnext-v15-4-b2a086257b63@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 17:04:04 +0200 Kory Maincent wrote:
> Make the net_hwtstamp_validate function accessible in prevision to use
> it from ethtool to validate the hwtstamp configuration before setting it.

This one can be combined with patch 3

