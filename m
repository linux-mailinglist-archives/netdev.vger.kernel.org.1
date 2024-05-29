Return-Path: <netdev+bounces-99085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94CD8D3AA6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076F3B24FBF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9317F390;
	Wed, 29 May 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgWn1b0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992501591EC;
	Wed, 29 May 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996074; cv=none; b=eFTbk5cHBLy0K/zEnuAE/c0Rlx4cdwybOfUxdWBnjX+q2HwIt/1Q6Kwpdn+v5gqVntl7ppN6kWclWeF/IRtY0zZDQVgkroezuwjk0JCVpzJ58l7Jmz7OafkWg3SEbBVzIaCab4yeDcSxYcbxPcWIL++5H4bmZTcPnLjtcW9IPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996074; c=relaxed/simple;
	bh=WpYxKn4ArpMJZTD0XwCdmzZa63Jvde8nqvmjOxxn5hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPdhUOrxX1TGlPh3gutahRR5pBOrmaZWaTrc7MhsfSb7ESmgV+0TC1xj/O6ZTOsxjYm+SRwa/aHd7QTSlmZWHCCb+9CRZmgsOu4544m1AWchmsMMCkCpDDFNdJwB8NM5r+dCR96QVyNKKGnyoU2fVLnfIeSnvfJttsekVi1euTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgWn1b0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9DEC113CC;
	Wed, 29 May 2024 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716996074;
	bh=WpYxKn4ArpMJZTD0XwCdmzZa63Jvde8nqvmjOxxn5hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VgWn1b0Zidz4DDUDL6Yfj3Ly6sL4CKF0qaOXVxxBlYoq5LMcRYbpTUj663VejdRGJ
	 mclwnr9J6Z2r9649dCYYBkXhSUjsLQ13Gls9SDfGVGHyswOqiMBHij2hwcLKvSvSiN
	 mqFTIEGGtsgr1bpA5rn5hC6hZClVbTaKvQS15vzGUFFgfmW8lFI5FXsHqv1MqFjlKO
	 HgqBGgwkGq29LAHTUhyp1aZYjFEcSk+DUTrkqTNFoD/N6q/oG9Imy4gwc+9b0V6INz
	 JUgJ6AyBZH33CBPveo9/ZcuQC56hS6LMTjj9AekNlQoPrJ4yWAjCLJLYoIM3BE6+l8
	 FB8Hr4xJvj+lA==
Date: Wed, 29 May 2024 08:21:11 -0700
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
Subject: Re: [PATCH net-next v13 09/14] net: Add the possibility to support
 a selected hwtstamp in netdevice
Message-ID: <20240529082111.1a1cbf1e@kernel.org>
In-Reply-To: <20240529-feature_ptp_netnext-v13-9-6eda4d40fa4f@bootlin.com>
References: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
	<20240529-feature_ptp_netnext-v13-9-6eda4d40fa4f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 11:39:41 +0200 Kory Maincent wrote:
> Introduce the description of a hwtstamp provider which is define with a
> ptp_clock pointer and a qualifier value.
> 
> Add a hwtstamp provider description within the netdev structure to be able
> to select the hwtstamp we want too use. By default we use the old API that
> does not support hwtstamp selectability which mean the hwtstamp ptp_clock
> pointer is unset.

ERROR: modpost: "ptp_clock_phydev" [drivers/net/phy/libphy.ko] undefined!
-- 
pw-bot: cr

