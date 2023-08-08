Return-Path: <netdev+bounces-25557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803A774B8B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F4C1C20F9C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105EA14F87;
	Tue,  8 Aug 2023 20:49:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F610FF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83BDC433C7;
	Tue,  8 Aug 2023 20:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691527782;
	bh=JYHRhEx/YWaT7o/axmRTijT6ZjSVmkc8XuhZg3PcQ8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfjUR/oebhUhEd+UQfCAKdc3H9NQbZe1xja3nMcQStE1m++9lgjIRY+eZoEmqcSrX
	 3cka0Z/YKxef3cHOw35HdxFPxPx6kolAGF5PNorYDNVHUwEx7zOl9JDU7IczPsgJDy
	 ir/MR2qVArG/O0eo2cDfzFyHyePKYqo6OyJzP0CVScZ1hoHZhzWuIC9bUEqsXbxHR1
	 r4R3pE8DmVgLffZ3gAL7iENBKUFz6xVdc+sEND0xAEXmDnPYoq1npWIsaBrhg91elY
	 vYDcYuQPlOKSHShwMfAJORMaVSaJdQ5Zv5Seum/SCsJzTm0yr8Ni+0NGh5lO/IdgG4
	 aKyoaSPDtAJvg==
Date: Tue, 8 Aug 2023 22:49:38 +0200
From: Simon Horman <horms@kernel.org>
To: Wenjun Wu <wenjun1.wu@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	xuejun.zhang@intel.com, madhu.chittim@intel.com,
	qi.z.zhang@intel.com, anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v2 4/5] iavf: Add devlink port function rate API
 support
Message-ID: <ZNKqYlC86siUsRzd@vergenet.net>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230808015734.1060525-1-wenjun1.wu@intel.com>
 <20230808015734.1060525-5-wenjun1.wu@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808015734.1060525-5-wenjun1.wu@intel.com>

On Tue, Aug 08, 2023 at 09:57:33AM +0800, Wenjun Wu wrote:
> From: Jun Zhang <xuejun.zhang@intel.com>
> 
> To allow user to configure queue based parameters, devlink port function
> rate api functions are added for setting node tx_max and tx_share
> parameters.
> 
> iavf rate tree with root node and  queue nodes is created and registered
> with devlink rate when iavf adapter is configured.
> 
> Signed-off-by: Jun Zhang <xuejun.zhang@intel.com>

...

> +/**
> + * iavf_update_queue_tx_max - sets tx max parameter
> + * @adapter: iavf adapter struct instance
> + * @node: iavf rate node struct instance
> + * @bw: bandwidth in bytes per second
> + * @extack: extended netdev ack structure
> + *
> + * This function sets max BW limit.
> + */
> +static int iavf_update_queue_tx_max(struct iavf_adapter *adapter,
> +				    struct iavf_dev_rate_node *node,
> +				    u64 bw, struct netlink_ext_ack *extack)
> +{
> +	/* Keep in kbps */
> +	node->tx_max_temp = div_u64(bw, IAVF_RATE_DIV_FACTOR);
> +	if (ADV_LINK_SUPPORT(adapter)) {
> +		if (node->tx_max_temp / 1000 > adapter->link_speed_mbps)
> +			return -EINVAL;
> +	}
> +
> +	node->tx_update_flag |= IAVF_FLAG_TX_MAX_UPDATED;
> +
> +	return iavf_check_update_config(adapter, node);
> +}
> +
> +/**
> + * iavf_devlink_rate_node_tx_max_set - devlink_rate API for setting tx max
> + * @rate_node: devlink rate struct instance

Hi Jun Zhang,

Please describe all the parameters of iavf_devlink_rate_node_tx_max_set
in it's kernel doc.

./scripts/kernel-doc -none is your friend here.

> + *
> + * This function implements rate_node_tx_max_set function of devlink_ops
> + */
> +static int iavf_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node,
> +					     void *priv, u64 tx_max,
> +					     struct netlink_ext_ack *extack)

...

-- 
pw-bot: changes-requested

