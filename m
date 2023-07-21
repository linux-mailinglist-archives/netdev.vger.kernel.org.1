Return-Path: <netdev+bounces-19884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312875CAB4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB31C216D1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD427F22;
	Fri, 21 Jul 2023 14:54:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521A27F1A
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:54:14 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31C1719
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:54:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357029367"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="357029367"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 07:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="728139227"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="728139227"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2023 07:54:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andy@kernel.org>)
	id 1qMrW9-009CRT-1A;
	Fri, 21 Jul 2023 17:54:05 +0300
Date: Fri, 21 Jul 2023 17:54:05 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
	aleksander.lobakin@intel.com, davem@davemloft.net, kuba@kernel.org,
	jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com,
	simon.horman@corigine.com, idosch@nvidia.com
Subject: Re: [PATCH iwl-next v3 3/6] pfcp: add PFCP module
Message-ID: <ZLqcDf68HgB6Knnk@smile.fi.intel.com>
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-4-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721071532.613888-4-marcin.szycik@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 09:15:29AM +0200, Marcin Szycik wrote:
> From: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> Packet Forwarding Control Protocol (PFCP) is a 3GPP Protocol
> used between the control plane and the user plane function.
> It is specified in TS 29.244[1].
> 
> Note that this module is not designed to support this Protocol
> in the kernel space. There is no support for parsing any PFCP messages.
> There is no API that could be used by any userspace daemon.
> Basically it does not support PFCP. This protocol is sophisticated
> and there is no need for implementing it in the kernel. The purpose
> of this module is to allow users to setup software and hardware offload
> of PFCP packets using tc tool.
> 
> When user requests to create a PFCP device, a new socket is created.
> The socket is set up with port number 8805 which is specific for
> PFCP [29.244 4.2.2]. This allow to receive PFCP request messages,
> response messages use other ports.
> 
> Note that only one PFCP netdev can be created.
> 
> Only IPv4 is supported at this time.
> 
> [1] https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3111

> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Co-developed-by: Marcin...?

> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

...

> +/* PFCP according to 3GPP TS 29.244
> + *
> + * Copyright (C) 2022, Intel Corporation.

> + * (C) 2022 by Wojciech Drewek <wojciech.drewek@intel.com>

Is it approved by our Legal? First time I see such (c) together with Intel's
and correct authorship.

> + * Author: Wojciech Drewek <wojciech.drewek@intel.com>
> + */

...

> +struct pfcp_dev {
> +	struct list_head	list;

This is defined in types.h which is missing.

> +	struct socket		*sock;
> +	struct net_device	*dev;
> +	struct net		*net;
> +};

...

> +	dev->needs_free_netdev	= true;

Single space is enough.

...

> +static int pfcp_newlink(struct net *net, struct net_device *dev,
> +			struct nlattr *tb[], struct nlattr *data[],
> +			struct netlink_ext_ack *extack)
> +{
> +	struct pfcp_dev *pfcp = netdev_priv(dev);
> +	struct pfcp_net *pn;
> +	int err;
> +
> +	pfcp->net = net;
> +
> +	err = pfcp_add_sock(pfcp);
> +	if (err) {
> +		netdev_dbg(dev, "failed to add pfcp socket %d\n", err);
> +		goto exit;
> +	}
> +
> +	err = register_netdevice(dev);
> +	if (err) {
> +		netdev_dbg(dev, "failed to register pfcp netdev %d\n", err);
> +		goto exit_reg_netdev;
> +	}
> +
> +	pn = net_generic(dev_net(dev), pfcp_net_id);
> +	list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
> +
> +	netdev_dbg(dev, "registered new PFCP interface\n");
> +
> +	return 0;
> +
> +exit_reg_netdev:

The label naming should tell what _will_ happen if goto $LABEL.
Something like

exit_del_pfcp_sock:

Ditto for all labels in your code.

> +	pfcp_del_sock(pfcp);
> +exit:

Shouldn't here be

	->net = NULL;

?

> +	return err;
> +}

...

> +#ifndef _PFCP_H_
> +#define _PFCP_H_

Missing headers:
For net_device internals, bool type, and strcpm() call.

> +#define PFCP_PORT 8805
> +
> +static inline bool netif_is_pfcp(const struct net_device *dev)
> +{
> +	return dev->rtnl_link_ops &&
> +	       !strcmp(dev->rtnl_link_ops->kind, "pfcp");
> +}
> +
> +#endif

-- 
With Best Regards,
Andy Shevchenko



