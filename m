Return-Path: <netdev+bounces-104300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB890C13B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01491B20E9C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C6BC8E9;
	Tue, 18 Jun 2024 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IntJtiEN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF64C84;
	Tue, 18 Jun 2024 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674003; cv=none; b=iVmTStQoe7xR/g983HI+TQaIRFVW3h9ZMmaezNdEfeX0wk5upOdZUVOwKSMW52oukaai7q82kYh5xwfwHFgcQ3PM28nAV44Q2w7HWQs/iYJ0InQDrHt1k+O3YYkF0PPVPLvAhJVo5zTTEdytpC/PiO71Nbu6RDY+wEP6UYXOytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674003; c=relaxed/simple;
	bh=BJqVxxnHVxK+/oMC8JfWJbM+VLvzhUJqNYWBsEwgjCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiVxg+/FGwHBFJZcSPu8V3sR6EOOVWYBrUWHuRE4bftKFA6iidh/KItrDO+PG8ffJBV+Skmsi6Kfgkq8SlNOZVBt3cs2yWkozBN6ZVGdNOajyUJeuuKt/behhNq4PGb1g+EB1rJ3+DVtw5GoApi/Hyx4otk7HZplVRpIFiHMZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IntJtiEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDEBC2BD10;
	Tue, 18 Jun 2024 01:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718674003;
	bh=BJqVxxnHVxK+/oMC8JfWJbM+VLvzhUJqNYWBsEwgjCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IntJtiENPriYBtIdDQv6UvX4nqG2tVk5KNzdUiRK1aCW03GeoLjcCgGlKHE2YYJkc
	 nq4wmzTC2tmBqoSQO6Tr/oUTGYtNOSVhz1tkOUVDtI2m4PKhoaEhixq4A89SENnbbC
	 FB7WkxGHhAJ76LuDPABFy8ElPqVdZCOmpIbF1zTEwNs961KUzyoaukWWBt5OP+Vjpk
	 x86IthG6SjU/VQIWR/tw95hlA7oS80wuj4vjMa6+L9sFqArMHr8LyZx3fpNoGOzsRG
	 zwCEgks18U0sEhmswiZ7XFGZv2r50W62jDwY+d4NyevPSIdtf5Qhw6yCcw1Jgn+7Nh
	 hh5ERPS+ISbYg==
Date: Mon, 17 Jun 2024 18:26:41 -0700
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
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v15 02/14] net: Move dev_set_hwtstamp_phylib to
 net/core/dev.h
Message-ID: <20240617182641.7fa3921e@kernel.org>
In-Reply-To: <20240612-feature_ptp_netnext-v15-2-b2a086257b63@bootlin.com>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
	<20240612-feature_ptp_netnext-v15-2-b2a086257b63@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 17:04:02 +0200 Kory Maincent wrote:
> This declaration was added to the header to be called from ethtool.
> ethtool is separated from core for code organization but it is not really
> a separate entity, it controls very core things.
> As ethtool is an internal stuff it is not wise to have it in netdevice.h.
> Move the declaration to net/core/dev.h instead.
> 
> Remove the EXPORT_SYMBOL_GPL call as ethtool can not be built as a module.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

I'll take this one, it stands on its own.

