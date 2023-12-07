Return-Path: <netdev+bounces-54701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5A807DE2
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 02:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A81F2194E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 01:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BB110D;
	Thu,  7 Dec 2023 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQC5JQAL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41219BB
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 17:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701912367; x=1733448367;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=i4yeWVE6+wrgX9vmL6iqP5eumdCMoGTglZZEcsnM/FM=;
  b=fQC5JQALyc6j7I+CVH4u26wAF/CQm/O/5JsESlCcG/Rb47OwZ+6P/o2R
   RhRZ5rUpkk5s7a8Ev3CyZER1If8mGmwWKDCl7lKOhFpgSruR3aWI3YAp5
   5ToOa1gPV0y6u0525zhkUA5iJqYY1XIztNs7dlbKXoyDzCJdjk/Dgq9XC
   FubDE9x9zrji3dPa61fNKvKi0+dh4ty4s4WvMnVItwNIg/woGuJrKcHue
   vhqXuywlc4W3CqTKQJY+FG5/SoATLvicq6+NRpLvkC7Hm53v6dyz9eGDR
   VivdM8l4UmcLF8+O6qW1LIJFlYF0Xs64SW2OvOQO0HiL0/JH/s31ihmrL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1231754"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1231754"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 17:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19518060"
Received: from alwohlse-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.58.167])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 17:26:06 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>, Suman Ghosh
 <sumang@marvell.com>
Subject: Re: [PATCH iwl-net] igc: Check VLAN EtherType mask
In-Reply-To: <20231206140718.57433-1-kurt@linutronix.de>
References: <20231206140718.57433-1-kurt@linutronix.de>
Date: Wed, 06 Dec 2023 17:26:05 -0800
Message-ID: <87r0jy6bwy.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kurt Kanzenbach <kurt@linutronix.de> writes:

> Currently the driver accepts VLAN EtherType steering rules regardless of
> the configured mask. And things might fail silently or with confusing error
> messages to the user. The VLAN EtherType can only be matched by full
> mask. Therefore, add a check for that.
>
> For instance the following rule is invalid, but the driver accepts it and
> ignores the user specified mask:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
> |             m 0x00ff action 0
> |Added rule with ID 63
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 63
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x8100 mask: 0x0
> |        VLAN: 0x0 mask: 0xffff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 0
>
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
> |             m 0x00ff action 0
> |rmgr: Cannot insert RX class rule: Operation not supported
>
> Fixes: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
> Suggested-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---

I was just wondering if an alternative would be to use flex filters for
matching vlan-etype with a partial mask. But I don't think there's any
real use case for partial masks, better to reject them:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

