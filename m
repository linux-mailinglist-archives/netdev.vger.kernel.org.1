Return-Path: <netdev+bounces-19890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0162F75CADC
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B5F1C216D9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DD27F30;
	Fri, 21 Jul 2023 15:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31F27F0C
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:03:10 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CDB19B6
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:03:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="370648085"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370648085"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="702082394"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="702082394"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2023 08:02:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andy@kernel.org>)
	id 1qMreJ-009UVe-1h;
	Fri, 21 Jul 2023 18:02:31 +0300
Date: Fri, 21 Jul 2023 18:02:31 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
	aleksander.lobakin@intel.com, davem@davemloft.net, kuba@kernel.org,
	jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com,
	simon.horman@corigine.com, idosch@nvidia.com
Subject: Re: [PATCH iwl-next v3 4/6] pfcp: always set pfcp metadata
Message-ID: <ZLqeB/0aoe6GQUVi@smile.fi.intel.com>
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-5-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721071532.613888-5-marcin.szycik@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 09:15:30AM +0200, Marcin Szycik wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> In PFCP receive path set metadata needed by flower code to do correct
> classification based on this metadata.

...

+ bits.h
+ types.h

> +#include <net/udp_tunnel.h>
> +#include <net/dst_metadata.h>
> +
>  #define PFCP_PORT 8805
>  
> +/* PFCP protocol header */
> +struct pfcphdr {
> +	u8	flags;
> +	u8	message_type;
> +	__be16	message_length;
> +};
> +
> +/* PFCP header flags */
> +#define PFCP_SEID_FLAG		BIT(0)
> +#define PFCP_MP_FLAG		BIT(1)
> +
> +#define PFCP_VERSION_SHIFT	5
> +#define PFCP_VERSION_MASK	((1 << PFCP_VERSION_SHIFT) - 1)

GENMASK() since you already use BIT()

> +#define PFCP_HLEN (sizeof(struct udphdr) + sizeof(struct pfcphdr))
> +
> +/* PFCP node related messages */
> +struct pfcphdr_node {
> +	u8	seq_number[3];
> +	u8	reserved;
> +};
> +
> +/* PFCP session related messages */
> +struct pfcphdr_session {
> +	__be64	seid;
> +	u8	seq_number[3];
> +#ifdef __LITTLE_ENDIAN_BITFIELD
> +	u8	message_priority:4,
> +		reserved:4;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +	u8	reserved:4,
> +		message_priprity:4;
> +#else
> +#error "Please fix <asm/byteorder>"
> +#endif
> +};
> +
> +struct pfcp_metadata {
> +	u8 type;
> +	__be64 seid;
> +} __packed;
> +
> +enum {
> +	PFCP_TYPE_NODE		= 0,
> +	PFCP_TYPE_SESSION	= 1,
> +};

...

> +/* IP header + UDP + PFCP + Ethernet header */
> +#define PFCP_HEADROOM (20 + 8 + 4 + 14)

Instead of comment like above, just use defined sizes.

> +/* IPv6 header + UDP + PFCP + Ethernet header */
> +#define PFCP6_HEADROOM (40 + 8 + 4 + 14)

sizeof(ipv6hdr)
sizeof(updhdr)
...

Don't forget to include respective headers.

-- 
With Best Regards,
Andy Shevchenko



