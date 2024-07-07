Return-Path: <netdev+bounces-109661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A224092970E
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B861F2165A
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B8E101CA;
	Sun,  7 Jul 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0tlN9Rv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A3B67F;
	Sun,  7 Jul 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720340656; cv=none; b=nMqbReTsJyfF5HlF0rBDJr7snc0PmXgsvu/0vw9SoM124cfagCaRQOEsDYyoSDw93cozguQTVeibfpamgnBVBHGWBcn/jzz2aam187WOCpF8+l160DWYeG7KKveARugUxkHCXLzneCFYfMS9qejhUyumfGrUvAzzFeFrK17/Urc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720340656; c=relaxed/simple;
	bh=LXMrQ3C7YtlFtAjJOecI8T+KbonpE2eQ/2SoojEsjro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBpR0ewBFV4CvqtIFA6tfxS76whXjLIsXyIuxsOZWDCsCexKz5s+q6Md8X5cGlk/KyENfSVXPt4ZkAtF+l7urXKzae8GQsDAXYbZIXwER91UU3qlnEkaoeRg0WaN8rHixHQlzMP8uugPaXQoYCT+NUKKBw6QMjk8akhDy4CseVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0tlN9Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD89EC3277B;
	Sun,  7 Jul 2024 08:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720340655;
	bh=LXMrQ3C7YtlFtAjJOecI8T+KbonpE2eQ/2SoojEsjro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0tlN9RvsrAdNKblfVOHB5mvrUOCxtJdjHDmMBc1VUHoUioVpDG+3c5alUV+PoD38
	 Z8/7UP/u9bMSlLgyaeTfLk11h/z7y5riZMCMzSRH1Pn3K2vjhCv17ldAU4Qzd8N5ba
	 IwwBfT0i/pjP9zRJrQ5mSAQawIDoXx7FjOELalKNS51o2gWe0jGZ2ZpGoog/FE4ceU
	 J6Pwc0WFEBLZnygXN0Pn2sqkhnT9cf1DIAZmtYkgBvoHB0VW5XGtX6iWZ7mj7HGIVg
	 gWQqLrlMaP2Sj0j9/RMLzC9AaM53wqRcFlqXxwRh23Uss8dFURUkdoTg++aUopEGXX
	 nIo4sRzbdw0Qg==
Date: Sun, 7 Jul 2024 09:24:08 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v16 13/14] net: ethtool: Add support for
 tsconfig command to get/set hwtstamp config
Message-ID: <20240707082408.GF1481495@kernel.org>
References: <20240705-feature_ptp_netnext-v16-0-5d7153914052@bootlin.com>
 <20240705-feature_ptp_netnext-v16-13-5d7153914052@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705-feature_ptp_netnext-v16-13-5d7153914052@bootlin.com>

On Fri, Jul 05, 2024 at 05:03:14PM +0200, Kory Maincent wrote:
> Introduce support for ETHTOOL_MSG_TSCONFIG_GET/SET ethtool netlink socket
> to read and configure hwtstamp configuration of a PHC provider. Note that
> simultaneous hwtstamp isn't supported; configuring a new one disables the
> previous setting.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v16:
> - Add a new patch to separate tsinfo into a new tsconfig command to get
>   and set the hwtstamp config.
> ---
>  Documentation/networking/timestamping.rst |  33 +--
>  include/uapi/linux/ethtool_netlink.h      |  18 ++
>  net/ethtool/Makefile                      |   3 +-
>  net/ethtool/netlink.c                     |  20 ++
>  net/ethtool/netlink.h                     |   3 +
>  net/ethtool/tsconfig.c                    | 347 ++++++++++++++++++++++++++++++
>  6 files changed, 411 insertions(+), 13 deletions(-)
> 

> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 5e93cd71f99f..8b864ae33297 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -493,8 +493,8 @@ implicitly defined. ts[0] holds a software timestamp if set, ts[1]
>  is again deprecated and ts[2] holds a hardware timestamp if set.
>  
>  
> -3. Hardware Timestamping configuration: SIOCSHWTSTAMP and SIOCGHWTSTAMP
> -=======================================================================
> +3. Hardware Timestamping configuration: ETHTOOL_MSG_TSCONFIG_SET/GET
> +==================================================================

nit: make htmldocs flags that this title underline is too short

...

