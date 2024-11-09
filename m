Return-Path: <netdev+bounces-143477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BE9C294B
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F921B23FB3
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F41E505;
	Sat,  9 Nov 2024 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+TufE6w"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2E17C7C
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731116622; cv=none; b=BYGSBJc+z0Zn5vDmNYiaPelbMAY0fmDoQwVGH74HfWXs5hmZ4xuYhHYUAqdDBQ9rA1vc8Yd7+hkuQdkuU2yi0hklPQUIhshiF1IWKq6JG96C8m+uVaTcbEFxktAwch8PFlrOKkDHvKlIbH5TUb9qXCfiXUaqafJf+HNMNwwpvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731116622; c=relaxed/simple;
	bh=mepBhE3QmCYYwE8gAVm0Jk8Zx28/5Z4vGXsLLl7XKnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBk+woLtEdu6EF/jm+2FfDf03/+w0E8bA6htRGPUpcIAWNfryLKTN6KxioG2/TMdC0+eR5c3rDFrhrHEY6hTbrcZpgSM/xomucbyP6Ge1GYrDGcp3ErJ63Zya5nma8lLGwiNcRir06iK2qvfOOR5Xu5vtVCfm1Z9eaRQ/5vwnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+TufE6w; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <955dde4b-b4ba-439f-b7d4-f64d90c58d55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731116617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4FAc6Pkq+6FU2hrV3MhybCMa3MxiYPHACi+H+viGfc=;
	b=A+TufE6wrdG/LbPUcsCkbV9Ak152iUtqi5gOoPEgJbLbRhJ61vGQFsp/2aBwneQwGzrmlU
	Bx7xjU8q1EF9lUk3aicKMhYiy2r+KGji1N5lpa1iPPOUj3K8P33ftMvHqH7lNqfJc97EC3
	KusIBxM/n5NQ/gvK8aeSLcuOmuKgNiQ=
Date: Sat, 9 Nov 2024 01:43:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v19 09/10] net: ethtool: Add support for tsconfig
 command to get/set hwtstamp config
To: Kory Maincent <kory.maincent@bootlin.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Alexandra Winter <wintera@linux.ibm.com>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
 <20241030-feature_ptp_netnext-v19-9-94f8aadc9d5c@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241030-feature_ptp_netnext-v19-9-94f8aadc9d5c@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/10/2024 13:54, Kory Maincent wrote:
> Introduce support for ETHTOOL_MSG_TSCONFIG_GET/SET ethtool netlink socket
> to read and configure hwtstamp configuration of a PHC provider. Note that
> simultaneous hwtstamp isn't supported; configuring a new one disables the
> previous setting.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

[ ... ]

> +static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
> +			      struct genl_info *info)
> +{
> +	struct kernel_hwtstamp_config hwtst_config = {0}, _hwtst_config = {0};
> +	unsigned long mask = 0, req_rx_filter, req_tx_type;
> +	struct hwtstamp_provider *hwtstamp = NULL;
> +	struct net_device *dev = req_base->dev;
> +	struct nlattr **tb = info->attrs;
> +	bool mod = false;
> +	int ret;
> +
> +	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
> +	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
> +
> +	if (!netif_device_present(dev))
> +		return -ENODEV;
> +
> +	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER]) {
> +		struct hwtst_provider __hwtst = {.index = -1};
> +		struct hwtstamp_provider *__hwtstamp;
> +
> +		__hwtstamp = rtnl_dereference(dev->hwtstamp);
> +		if (__hwtstamp) {
> +			__hwtst.index = ptp_clock_index(__hwtstamp->ptp);
> +			__hwtst.qualifier = __hwtstamp->qualifier;
> +		}
> +
> +		ret = ts_parse_hwtst_provider(tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER],
> +					      &__hwtst, info->extack,
> +					      &mod);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (mod) {
> +			hwtstamp = kzalloc(sizeof(*hwtstamp), GFP_KERNEL);
> +			if (!hwtstamp)
> +				return -ENOMEM;
> +
> +			hwtstamp->ptp = ptp_clock_get_by_index(&dev->dev,
> +							       __hwtst.index);
> +			if (!hwtstamp->ptp) {
> +				NL_SET_ERR_MSG_ATTR(info->extack,
> +						    tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER],
> +						    "no phc at such index");
> +				ret = -ENODEV;
> +				goto err_free_hwtstamp;
> +			}
> +			hwtstamp->qualifier = __hwtst.qualifier;
> +			hwtstamp->dev = &dev->dev;
> +
> +			/* Does the hwtstamp supported in the netdev topology */
> +			if (!netdev_support_hwtstamp(dev, hwtstamp)) {
> +				NL_SET_ERR_MSG_ATTR(info->extack,
> +						    tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER],
> +						    "phc not in this net device topology");
> +				ret = -ENODEV;
> +				goto err_clock_put;
> +			}
> +		}
> +	}
> +
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
> +
> +	ret = net_hwtstamp_validate(&hwtst_config);
> +	if (ret)
> +		goto err_clock_put;
> +
> +	if (mod) {
> +		struct kernel_hwtstamp_config zero_config = {0};
> +		struct hwtstamp_provider *__hwtstamp;
> +
> +		/* Disable current time stamping if we try to enable
> +		 * another one
> +		 */
> +		ret = dev_set_hwtstamp_phylib(dev, &zero_config, info->extack);
		
_hwtst_config is still inited to 0 here, maybe it can be used to avoid
another stack allocation?

> +		if (ret < 0)
> +			goto err_clock_put;
> +
> +		/* Change the selected hwtstamp source */
> +		__hwtstamp = rcu_replace_pointer_rtnl(dev->hwtstamp, hwtstamp);
> +		if (__hwtstamp)
> +			call_rcu(&__hwtstamp->rcu_head,
> +				 remove_hwtstamp_provider);
> +	} else {
> +		/* Get current hwtstamp config if we are not changing the
> +		 * hwtstamp source
> +		 */
> +		ret = dev_get_hwtstamp_phylib(dev, &_hwtst_config);

This may be tricky whithout ifr set properly. But it should force
drivers to be converted.

> +		if (ret < 0 && ret != -EOPNOTSUPP)
> +			goto err_clock_put;
> +	}
> +
> +	if (memcmp(&hwtst_config, &_hwtst_config, sizeof(hwtst_config))) {

better to use kernel_hwtstamp_config_changed() helper here

> +		ret = dev_set_hwtstamp_phylib(dev, &hwtst_config,
> +					      info->extack);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = tsconfig_send_reply(dev, info);
> +		if (ret && ret != -EOPNOTSUPP) {
> +			NL_SET_ERR_MSG(info->extack,
> +				       "error while reading the new configuration set");
> +			return ret;
> +		}
> +
> +		return 1;
> +	}
> +
> +	if (mod)
> +		return 1;
> +
> +	return 0;
> +
> +err_clock_put:
> +	if (hwtstamp)
> +		ptp_clock_put(&dev->dev, hwtstamp->ptp);
> +err_free_hwtstamp:
> +	kfree(hwtstamp);
> +
> +	return ret;
> +}
> +
> +const struct ethnl_request_ops ethnl_tsconfig_request_ops = {
> +	.request_cmd		= ETHTOOL_MSG_TSCONFIG_GET,
> +	.reply_cmd		= ETHTOOL_MSG_TSCONFIG_GET_REPLY,
> +	.hdr_attr		= ETHTOOL_A_TSCONFIG_HEADER,
> +	.req_info_size		= sizeof(struct tsconfig_req_info),
> +	.reply_data_size	= sizeof(struct tsconfig_reply_data),
> +
> +	.prepare_data		= tsconfig_prepare_data,
> +	.reply_size		= tsconfig_reply_size,
> +	.fill_reply		= tsconfig_fill_reply,
> +
> +	.set_validate		= ethnl_set_tsconfig_validate,
> +	.set			= ethnl_set_tsconfig,
> +	.set_ntf_cmd		= ETHTOOL_MSG_TSCONFIG_NTF,
> +};
> 


