Return-Path: <netdev+bounces-19860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004E75C9B4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72B92814B0
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644F1EA98;
	Fri, 21 Jul 2023 14:22:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B417AB7
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:22:01 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE12D77
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:21:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="346632486"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346632486"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 07:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="718837285"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718837285"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 07:21:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andy@kernel.org>)
	id 1qMr0x-0085eg-2U;
	Fri, 21 Jul 2023 17:21:51 +0300
Date: Fri, 21 Jul 2023 17:21:51 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
	aleksander.lobakin@intel.com, davem@davemloft.net, kuba@kernel.org,
	jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com,
	simon.horman@corigine.com, idosch@nvidia.com
Subject: Re: [PATCH iwl-next v3 1/6] ip_tunnel: use a separate struct to
 store tunnel params in the kernel
Message-ID: <ZLqUfwKkRH85uPlT@smile.fi.intel.com>
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-2-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721071532.613888-2-marcin.szycik@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 09:15:27AM +0200, Marcin Szycik wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Unlike IPv6 tunnels which use purely-kernel __ip6_tnl_parm structure
> to store params inside the kernel, IPv4 tunnel code uses the same
> ip_tunnel_parm which is being used to talk with the userspace.
> This makes it difficult to alter or add any fields or use a
> different format for whatever data.
> Define struct ip_tunnel_parm_kern, a 1:1 copy of ip_tunnel_parm for
> now, and use it throughout the code. The two places where the latter
> is used to interact with the userspace, now do a conversion from one
> type to another, with manual field-by-field assignments.
> Must be done at once, since ip_tunnel::parms is being used in most
> of those places.

...

> +	strscpy(kp.name, p.name, sizeof(kp.name));
> +	kp.link = p.link;
> +	kp.i_flags = p.i_flags;
> +	kp.o_flags = p.o_flags;
> +	kp.i_key = p.i_key;
> +	kp.o_key = p.o_key;
> +	memcpy(&kp.iph, &p.iph, min(sizeof(kp.iph), sizeof(p.iph)));
> +
> +	err = dev->netdev_ops->ndo_tunnel_ctl(dev, &kp, cmd);
> +	if (err)
> +		return err;
> +
> +	strscpy(p.name, kp.name, sizeof(p.name));
> +	p.link = kp.link;
> +	p.i_flags = kp.i_flags;
> +	p.o_flags = kp.o_flags;
> +	p.i_key = kp.i_key;
> +	p.o_key = kp.o_key;
> +	memcpy(&p.iph, &kp.iph, min(sizeof(p.iph), sizeof(kp.iph)));

> +		strscpy(kp.name, p.name, sizeof(kp.name));
> +		kp.link = p.link;
> +		kp.i_flags = p.i_flags;
> +		kp.o_flags = p.o_flags;
> +		kp.i_key = p.i_key;
> +		kp.o_key = p.o_key;
> +		memcpy(&kp.iph, &p.iph, min(sizeof(p.iph), sizeof(kp.iph)));

Seems to me these two deserves separate helpers to avoid such a duplication(s).

-- 
With Best Regards,
Andy Shevchenko



