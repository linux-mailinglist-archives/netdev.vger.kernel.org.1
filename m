Return-Path: <netdev+bounces-268292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBzyAFeBuGltfAEAu9opvQ
	(envelope-from <netdev+bounces-268292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:16:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B02A15F3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B40301F31B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4936AB56;
	Mon, 16 Mar 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUTUhdf9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A6139D;
	Mon, 16 Mar 2026 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699210; cv=none; b=sv57D0q8aCBdQuwhwUhRYv+NEmJXICCJuUoNaXA+gTC4KgJBOboqtTiTGSVQdcPgzdupFTMt+uCxF4KlwFsQG/kDQGkRXq0BYFpXmYu28mRIniJ3Um6OL7QWyBXYRgaeZK9E0rKRi73uxMR1/kWD2DKAnxxUIYpHXKic92jrzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699210; c=relaxed/simple;
	bh=3vlqpWno/eQmsuuMKFA1qpRJxUYYvbSYRUx+QTJkW0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFjQPwdwINDZSvMV6HIkSvqRQg/chw3ybqIbzvCr+gyN7oXJ6NKnQ0p+EeYd77ycAcQNWSnV8WXRNXusRuG2iOm38Lh5zXXL8EeGzFzaCLisxGi4SIwlpcZX7FlyVYbFv3Mg7+IWz5OEgJVkXI2vAZpLUTxU09AXGTLm5cyrj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUTUhdf9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773699209; x=1805235209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3vlqpWno/eQmsuuMKFA1qpRJxUYYvbSYRUx+QTJkW0E=;
  b=bUTUhdf9ghAsRIQBo4A2DEP0bzUHuM8hjTdmo09gReaMRx+6COWjjk3k
   jxtlYi2rwoTHghs7n/QP82X1GIVhMEUNVv+GBBkqhzAmE05ePIkzM+ERD
   Ibq0WULDeTM626XYJbWiVTuCI6Rxdb/4bYvPNeYL/tnhh5//CwDP4ufHc
   K4ZRsrDQVdUUcYsXN8t+HFvro5HFM0p9Ofq2cstSTns43+mqJWadPAkzs
   b6491FA4PurBixKXTnchejxVCmW2SpVE4yIQHUR+d+XkesHQtNCY0gH0G
   /51m6QRquA7f4w7dzWKFlmBQI4Ehq/D3WnA4JxgEcflyqaWTg0lLxaZuG
   w==;
X-CSE-ConnectionGUID: n+K227XeQYCUjgCopXtXTw==
X-CSE-MsgGUID: qk2ILIQITgG3cX+oBk7OgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78580347"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="78580347"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 15:13:28 -0700
X-CSE-ConnectionGUID: 1Vo84QsoRCSEOYYrTIZO+Q==
X-CSE-MsgGUID: MqkrOn5fRFmoELgAaDLh0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252565589"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.111]) ([10.125.108.111])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 15:13:28 -0700
Message-ID: <331f166a-11e4-46c5-9b68-01c14755be52@intel.com>
Date: Mon, 16 Mar 2026 15:13:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: ntb_netdev: add SPDX tag and remove boilerplate
 license text
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>, jdmason@kudzu.us
Cc: allenbh@gmail.com, davem@davemloft.net, kuba@kernel.org,
 stephen@networkplumber.org, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260316192248.518-1-rayfraytech@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260316192248.518-1-rayfraytech@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kudzu.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,networkplumber.org,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268292-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 523B02A15F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/26 12:22 PM, Oskar Ray-Frayssinet wrote:
> Add SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license, remove the redundant
> boilerplate license text, and keep the driver description
> and contact information.
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3: Keep driver description and contact information as
>     suggested by Dave Jiang
> v2: Also remove redundant boilerplate license text as
>     suggested by Stephen Hemminger
> v1: Add SPDX-License-Identifier tag only
> 
>  drivers/net/ntb_netdev.c | 44 +---------------------------------------
>  1 file changed, 1 insertion(+), 43 deletions(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index fbeae05817e9..48482b18c73e 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -1,47 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
>  /*
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - *   redistributing this file, you may do so under either license.
> - *
> - *   GPL LICENSE SUMMARY
> - *
> - *   Copyright(c) 2012 Intel Corporation. All rights reserved.
> - *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> - *
> - *   This program is free software; you can redistribute it and/or modify
> - *   it under the terms of version 2 of the GNU General Public License as
> - *   published by the Free Software Foundation.
> - *
> - *   BSD LICENSE
> - *
> - *   Copyright(c) 2012 Intel Corporation. All rights reserved.
> - *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> - *
> - *   Redistribution and use in source and binary forms, with or without
> - *   modification, are permitted provided that the following conditions
> - *   are met:
> - *
> - *     * Redistributions of source code must retain the above copyright
> - *       notice, this list of conditions and the following disclaimer.
> - *     * Redistributions in binary form must reproduce the above copy
> - *       notice, this list of conditions and the following disclaimer in
> - *       the documentation and/or other materials provided with the
> - *       distribution.
> - *     * Neither the name of Intel Corporation nor the names of its
> - *       contributors may be used to endorse or promote products derived
> - *       from this software without specific prior written permission.
> - *
> - *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> - *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> - *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> - *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> - *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> - *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> - *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> - *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> - *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> - *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
>   * PCIe NTB Network Linux driver
>   *
>   * Contact Information:

Sorry being a pain. May as well drop Jon's intel email address as that is no longer valid since we are cleaning up. Just keep the driver description. Thanks.


