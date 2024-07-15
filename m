Return-Path: <netdev+bounces-111526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C7993173C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF1B1F213A8
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A718EFFB;
	Mon, 15 Jul 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OElLUgnL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BBE4C62;
	Mon, 15 Jul 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055569; cv=none; b=hCwJJ4ZUyWqYkxYQfSw684sH+YSsrFH3+hWvR585S3DqUAs8izVM+dm4Yzc+ugtxzF/bu0G+FATeewiIzq0v8v04tSyfMXl8YDyoZFamJ1MkCZVRj1wRm9uJCaNWRymMyk+uPT4tBcfZ+YuNPcNKwz6+23v/hW+BPOaw1PpFU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055569; c=relaxed/simple;
	bh=Czc/8/j1UJ3uadHtlcCbqCzh/BKvAh+WALaaInDEGXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ec518dhYxFSE4jjUilijYZdhtbFtewqAdFtIaqGmOE7xiCCa2dKl2eegn2otcddwDW2w5ExgRypyxHQaTd83Bu+uF34yUHvch48bYInicAKiFqzr1NBn/GyE+kMMiYVksJsgEN8KFbliJhaHrlsX7AkjD/ELEV9Q2FsSoR8imNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OElLUgnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F5CC32782;
	Mon, 15 Jul 2024 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721055568;
	bh=Czc/8/j1UJ3uadHtlcCbqCzh/BKvAh+WALaaInDEGXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OElLUgnLsRq0inC4mUNDR8o/kzoSy4XbVw14Cl5B7g69gp8OV4U3zpNLSBr46nEQe
	 PaiPFWqZ43OQ/YHPXYUd76MGawWnwFPHfz522XqJoASVZ1HxUZ/3Qf6bGjZC+ESXSi
	 EkTd2ApSD9mNLweuV2Y1pvgPOXUxlW764zizHd6TgDfNNXH9KVWdUghsU5FJ/OeKL3
	 dB2uQ1w8Lwe1DfJ8g4BLoC6GrjhVt6FBhicdhy/YZhlguR4yYFaiBpi08GUZgJqnnu
	 AxCBVi1DTkCtUlwp0QEFAwNkamVFBhSCMyGHrm391x0qBOI2lO4DgyOQaMIS5c3D4y
	 s+2EvuEyiNj9g==
Date: Mon, 15 Jul 2024 07:59:26 -0700
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
 danieller@nvidia.com, ecree.xilinx@gmail.com, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v17 13/14] net: ethtool: Add support for
 tsconfig command to get/set hwtstamp config
Message-ID: <20240715075926.7f3e368c@kernel.org>
In-Reply-To: <20240709-feature_ptp_netnext-v17-13-b5317f50df2a@bootlin.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
	<20240709-feature_ptp_netnext-v17-13-b5317f50df2a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jul 2024 15:53:45 +0200 Kory Maincent wrote:
> +	/* Get the hwtstamp config from netlink */
> +	if (tb[ETHTOOL_A_TSCONFIG_TX_TYPES]) {
> +		ret = ethnl_parse_bitset(&req_tx_type, &mask,
> +					 __HWTSTAMP_TX_CNT,
> +					 tb[ETHTOOL_A_TSCONFIG_TX_TYPES],
> +					 ts_tx_type_names, info->extack);
> +		if (ret < 0)
> +			goto err_clock_put;
> +
> +		/* Select only one tx type at a time */
> +		if (ffs(req_tx_type) != fls(req_tx_type)) {
> +			ret = -EINVAL;
> +			goto err_clock_put;
> +		}
> +
> +		hwtst_config.tx_type = ffs(req_tx_type) - 1;
> +	}
> +	if (tb[ETHTOOL_A_TSCONFIG_RX_FILTERS]) {
> +		ret = ethnl_parse_bitset(&req_rx_filter, &mask,
> +					 __HWTSTAMP_FILTER_CNT,
> +					 tb[ETHTOOL_A_TSCONFIG_RX_FILTERS],
> +					 ts_rx_filter_names, info->extack);
> +		if (ret < 0)
> +			goto err_clock_put;
> +
> +		/* Select only one rx filter at a time */
> +		if (ffs(req_rx_filter) != fls(req_rx_filter)) {
> +			ret = -EINVAL;
> +			goto err_clock_put;
> +		}
> +
> +		hwtst_config.rx_filter = ffs(req_rx_filter) - 1;
> +	}
> +	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS]) {
> +		ret = nla_get_u32(tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS]);
> +		if (ret < 0)
> +			goto err_clock_put;
> +		hwtst_config.flags = ret;
> +	}

We should be tracking mod on these, too. Separately from the provider
mod bit, let's not call the driver and send notification if nothing
changed.

> +	ret = net_hwtstamp_validate(&hwtst_config);
> +	if (ret)
> +		goto err_clock_put;
> +
> +	/* Disable current time stamping if we try to enable another one */
> +	if (mod && (hwtst_config.tx_type || hwtst_config.rx_filter)) {
> +		struct kernel_hwtstamp_config zero_config = {0};
> +
> +		ret = dev_set_hwtstamp_phylib(dev, &zero_config, info->extack);
> +		if (ret < 0)
> +			goto err_clock_put;
> +	}
> +
> +	/* Changed the selected hwtstamp source if needed */
> +	if (mod) {
> +		struct hwtstamp_provider *__hwtstamp;
> +
> +		__hwtstamp = rcu_replace_pointer_rtnl(dev->hwtstamp, hwtstamp);
> +		if (__hwtstamp)
> +			call_rcu(&__hwtstamp->rcu_head,
> +				 remove_hwtstamp_provider);
> +	}
> +
> +	ret = dev_set_hwtstamp_phylib(dev, &hwtst_config, info->extack);
> +	if (ret < 0)
> +		return ret;

We can't unwind to old state here?

> +	return 1;

Driver can change hwtst_config right? "upgrade" the rx_filter 
to a broader one, IIRC. Shouldn't we reply to the set command with 
the resulting configuration, in case it changed? Basically provide 
the same info as the notification would.

