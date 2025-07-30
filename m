Return-Path: <netdev+bounces-211017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3960EB16317
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3347B3B52
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA222A817;
	Wed, 30 Jul 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sci8BLZg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A621A5B92
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886849; cv=none; b=D8JwPwuQ5OsmVAhmZfldm2CtztQ8Y7a8hISH1okTy0JL6Jomd2TUfxpHj/wUWj9OP30umnWX6PFKvmmSMZ+tF33w0SI2hPhWb92q0edTAW8K968z9/s4GwPrmlT+qgQOou+/D++sCPkn/AStJrT+lStYzTHD9JbU1LhZY1MdP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886849; c=relaxed/simple;
	bh=7UK1+zK91ka9f0i3srDuyuCiiFu2GWtnRX1d7UoWC7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igCjvQpqG+twtOXowfHTEB6TQlXRfOjV4ahCk+BzXUV3+VQtN+s6rt8EeCubPWbo40IGzd6rDMxEoeTU+rNnr7LdEKXjLZwKULE3vawa0Fkj6Ynho093LlVxA12U4c5a07Sm/PnTXyftzELm3Jaw+uShML8VviiSrGT/GS319cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sci8BLZg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753886848; x=1785422848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7UK1+zK91ka9f0i3srDuyuCiiFu2GWtnRX1d7UoWC7o=;
  b=Sci8BLZg2/9b24wbFnfjWGDx9jj60lz0uNDqUPD33OGYhmCi3gTZeFWP
   Ntgfx50aizfks1EdeTdzBLC6vcG+5yAWOAdShdqHd8FqOMP3RUs3tYw6s
   3ML8C4zz/nV3VhsYKyE0p8z4zJVnk6AK1/dLqzCYs8rzvGwY+PzK3iKsi
   RzfxncxLhRG7GQu69RHUhrDnjtUGYdlSg+cM6aocFqTMJW2YpuyZ4Z3xv
   /Ut0ODyYHnQogP8Cs/g1UJRHU7QFYLVvSMeAsYdWD58fb1HPbhoHrdnEt
   H9yWOzPb6oX+PU+1VoiDWGZ4DX8VbdeGWP1AVfEdaaV4b1M9EUPbs3Ydf
   A==;
X-CSE-ConnectionGUID: 1P7c1Pd6QjinimU7xqnD3Q==
X-CSE-MsgGUID: QlbWhgpMT5qdz1j8m85QAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56060061"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56060061"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:47:28 -0700
X-CSE-ConnectionGUID: 2gBVGce4SqWvzTy7pfdD8w==
X-CSE-MsgGUID: rKWObpRlTNi5/etn9gqScQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163347283"
Received: from egraban-mobl1.ger.corp.intel.com (HELO [10.245.83.192]) ([10.245.83.192])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:47:24 -0700
Message-ID: <09408ed4-8713-4290-9c5e-baee106a1da3@linux.intel.com>
Date: Wed, 30 Jul 2025 16:47:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: reject malicious packets in ipv6_gso_segment()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com
References: <20250730131738.3385939-1-edumazet@google.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250730131738.3385939-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-30 3:17 PM, Eric Dumazet wrote:
> syzbot was able to craft a packet with very long IPv6 extension headers
> leading to an overflow of skb->transport_header.
> 
> This 16bit field has a limited range.
> 
> Add skb_reset_transport_header_careful() helper and use it
> from ipv6_gso_segment()
> 
> WARNING: CPU: 0 PID: 5871 at ./include/linux/skbuff.h:3032 skb_reset_transport_header include/linux/skbuff.h:3032 [inline]
> WARNING: CPU: 0 PID: 5871 at ./include/linux/skbuff.h:3032 ipv6_gso_segment+0x15e2/0x21e0 net/ipv6/ip6_offload.c:151
> Modules linked in:
> CPU: 0 UID: 0 PID: 5871 Comm: syz-executor211 Not tainted 6.16.0-rc6-syzkaller-g7abc678e3084 #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>   RIP: 0010:skb_reset_transport_header include/linux/skbuff.h:3032 [inline]
>   RIP: 0010:ipv6_gso_segment+0x15e2/0x21e0 net/ipv6/ip6_offload.c:151
> Call Trace:
>   <TASK>
>    skb_mac_gso_segment+0x31c/0x640 net/core/gso.c:53
>    nsh_gso_segment+0x54a/0xe10 net/nsh/nsh.c:110
>    skb_mac_gso_segment+0x31c/0x640 net/core/gso.c:53
>    __skb_gso_segment+0x342/0x510 net/core/gso.c:124
>    skb_gso_segment include/net/gso.h:83 [inline]
>    validate_xmit_skb+0x857/0x11b0 net/core/dev.c:3950
>    validate_xmit_skb_list+0x84/0x120 net/core/dev.c:4000
>    sch_direct_xmit+0xd3/0x4b0 net/sched/sch_generic.c:329
>    __dev_xmit_skb net/core/dev.c:4102 [inline]
>    __dev_queue_xmit+0x17b6/0x3a70 net/core/dev.c:4679
> 
> Fixes: d1da932ed4ec ("ipv6: Separate ipv6 offload support")
> Reported-by: syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/688a1a05.050a0220.5d226.0008.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

