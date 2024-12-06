Return-Path: <netdev+bounces-149738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64D9E7003
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DA61685CF
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD53206F35;
	Fri,  6 Dec 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGrqhCHS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A12066F0;
	Fri,  6 Dec 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495245; cv=none; b=XxRncnbbvAOwQSBg7ciugRV8M1TiD5ysf6wGTCc3lXJR+7X04LnZUl5O5OK3f20w9IPNpr2zNh/OeaWtbQpUbYXdEM3NCQTl1qgp8/Rc4LugFFiMAJ8XzqjNBj7PqdkNVLz8HZXonK07LYIYyyNrHftCMELovWGpyALKCD7Ns+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495245; c=relaxed/simple;
	bh=V9jBRql9nrtm/oGsjAtucAT0brHiYGmeR8yXzKJ4CuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnRsQ9rcdO/PAaiql/+Y0FDqt8I5aYoSp8VLaBYBR/DTD56zY1vKGM9zzRtSDwcH/59UHNji35GA6I1/ACm+Zd3RKAKbNcQRXQhcnarNzo4M8zv3Q8SD5cFRHoluhNgYNflCySLpRbud7NSNT+zYDIOvc0Q8iBG/YQQQ4AYJ+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGrqhCHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0292C4CED1;
	Fri,  6 Dec 2024 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733495244;
	bh=V9jBRql9nrtm/oGsjAtucAT0brHiYGmeR8yXzKJ4CuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGrqhCHS+XBZk7M544LDe2Ms/vF4aeW2i4Dy0/OJrLtu/Ql1setuBKa7eLwNPwM3F
	 Iws52ZbtzFnwfngm7Fnu67upBRkrar/JvvHSlwSSoFF6X6j3/UO5UOQ4a7Ic9bjDn3
	 G8sGJDgY85o+C9k6ZwQXKHPS6FoimWDO0XCXpktb/XTAHBw8Z7ul0l16+LJeRAdIal
	 yUBSpoWYagHKbEG/zoRE+tDdbvs+5Or77eu630BybfJYWB6PDTEfBsdDH4W6TzRgKD
	 UwTUD2tBr95i4w0Z16ihe813iC1YOL9tqoxdv2KZlfLZBL2+SlSDrwCP9c8n3PmA1n
	 PU6dmAGZML9sw==
Date: Fri, 6 Dec 2024 14:27:16 +0000
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
	Vladimir Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
	danieller@nvidia.com, ecree.xilinx@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v20 4/6] net: ethtool: tsinfo: Enhance tsinfo to
 support several hwtstamp by net topology
Message-ID: <20241206142716.GT2581@kernel.org>
References: <20241204-feature_ptp_netnext-v20-0-9bd99dc8a867@bootlin.com>
 <20241204-feature_ptp_netnext-v20-4-9bd99dc8a867@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-feature_ptp_netnext-v20-4-9bd99dc8a867@bootlin.com>

On Wed, Dec 04, 2024 at 03:44:45PM +0100, Kory Maincent wrote:
> Either the MAC or the PHY can provide hwtstamp, so we should be able to
> read the tsinfo for any hwtstamp provider.
> 
> Enhance 'get' command to retrieve tsinfo of hwtstamp providers within a
> network topology.
> 
> Add support for a specific dump command to retrieve all hwtstamp
> providers within the network topology, with added functionality for
> filtered dump to target a single interface.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

...

> diff --git a/net/ethtool/ts.h b/net/ethtool/ts.h
> new file mode 100644
> index 000000000000..b7665dd4330d
> --- /dev/null
> +++ b/net/ethtool/ts.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _NET_ETHTOOL_TS_H
> +#define _NET_ETHTOOL_TS_H
> +
> +#include "netlink.h"
> +
> +static const struct nla_policy
> +ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {
> +	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
> +		NLA_POLICY_MIN(NLA_S32, 0),
> +	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER] =
> +		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
> +};

Hi Kory,

It looks like ethnl_ts_hwtst_prov_policy is only used in tsinfo.c and could
be moved into that file. That would avoid a separate copy for each file
that includes ts.h and the following warning flagged by gcc-14 W=1 builds
with patch 5/6 applied.

  CC      net/ethtool/tsconfig.o
In file included from net/ethtool/tsconfig.c:10:
net/ethtool/ts.h:9:1: warning: 'ethnl_ts_hwtst_prov_policy' defined but not used [-Wunused-const-variable=]
    9 | ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~

> +
> +int ts_parse_hwtst_provider(const struct nlattr *nest,
> +			    struct hwtstamp_provider_desc *hwprov_desc,
> +			    struct netlink_ext_ack *extack,
> +			    bool *mod);
> +
> +#endif /* _NET_ETHTOOL_TS_H */

...

