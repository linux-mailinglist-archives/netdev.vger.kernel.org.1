Return-Path: <netdev+bounces-19891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B4775CAED
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839BF1C2170C
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66627F33;
	Fri, 21 Jul 2023 15:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C727F30
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:07:25 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEA3272E
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:07:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357033817"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357033817"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="724898633"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="724898633"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2023 08:07:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andy@kernel.org>)
	id 1qMriw-009eWR-0W;
	Fri, 21 Jul 2023 18:07:18 +0300
Date: Fri, 21 Jul 2023 18:07:17 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
	aleksander.lobakin@intel.com, davem@davemloft.net, kuba@kernel.org,
	jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com,
	simon.horman@corigine.com, idosch@nvidia.com
Subject: Re: [PATCH iwl-next v3 6/6] ice: Add support for PFCP hardware
 offload in switchdev
Message-ID: <ZLqfJZi/14dyEzhH@smile.fi.intel.com>
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-7-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721071532.613888-7-marcin.szycik@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 09:15:32AM +0200, Marcin Szycik wrote:
> Add support for creating PFCP filters in switchdev mode. Add support
> for parsing PFCP-specific tc options: S flag and SEID.
> 
> To create a PFCP filter, a special netdev must be created and passed
> to tc command:
> 
> ip link add pfcp0 type pfcp
> tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
> 1:123/ff:fffffffffffffff0 skip_hw action mirred egress redirect dev pfcp0

Can you indent this (by 2 spaces?) to differentiate with the commit message
itself?

> Changes in iproute2 [1] are required to be able to use pfcp_opts in tc.
> 
> ICE COMMS package is required to create a filter as it contains PFCP
> profiles.

> [1] https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com

We have Link: tag for such kind of stuff.

...

> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_OPTS) &&
> +	    fltr->tunnel_type == TNL_PFCP) {
> +		struct flow_match_enc_opts match;
> +
> +		flow_rule_match_enc_opts(rule, &match);
> +
> +		memcpy(&fltr->pfcp_meta_keys, &match.key->data[0],
> +		       sizeof(struct pfcp_metadata));

Why not simply

		match.key->data

?

> +		memcpy(&fltr->pfcp_meta_masks, &match.mask->data[0],
> +		       sizeof(struct pfcp_metadata));

Ditto.

> +		fltr->flags |= ICE_TC_FLWR_FIELD_PFCP_OPTS;
> +	}

...

>  #ifndef _ICE_TC_LIB_H_
>  #define _ICE_TC_LIB_H_

Seems bits.h is missing...

> +#include <net/pfcp.h>
> +
>  #define ICE_TC_FLWR_FIELD_DST_MAC		BIT(0)
>  #define ICE_TC_FLWR_FIELD_SRC_MAC		BIT(1)
>  #define ICE_TC_FLWR_FIELD_VLAN			BIT(2)

...

>  #define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT(27)
>  #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
>  #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
> +#define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT(30)
>  
>  #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF

...and (at least) this can utilize GENMASK().

-- 
With Best Regards,
Andy Shevchenko



