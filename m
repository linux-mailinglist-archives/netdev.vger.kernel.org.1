Return-Path: <netdev+bounces-55601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDC880BA1B
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6331C2048F
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E807481;
	Sun, 10 Dec 2023 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q31NgcN2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35AF1;
	Sun, 10 Dec 2023 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702203011; x=1733739011;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5FnYIJIbR+wsxAQWvfQ77OzwqLrChyDizMkLcyyll9A=;
  b=Q31NgcN20hkOofpjbnhNl2dC7wPfr432SIuT8GV0SazKaE/DBm+WOqbQ
   7VEtmP3FOjenLbFOlf15iaU4QzyRy9xJ5/v5rQ3gP241CGau8ibhBTiMT
   hnlXQyAf/b40q6CM8klg17me5qTdfYeTK2M7X9fxQxHsoDA1ilpKM1dPU
   jYi70s4yNOMI57JJZ02nPmlfBfGm4mpdt/olcg07Bt0rbTTltWYRRy/WF
   /Z6TL91ROtk8if/vIF6RfqPJm9tS9C2wHT30pSszkycf9FceNXUEfEL2s
   cfsv7eSp/Tu4jsQQI08QunVadKdr+It95+FDEs8zKMdQAoaX1A/+AyEH9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="384957266"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="384957266"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 02:10:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="722391237"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="722391237"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.251.181.21]) ([10.251.181.21])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 02:10:06 -0800
Message-ID: <b75fb89e-2016-49fa-912f-6121976c294b@linux.intel.com>
Date: Sun, 10 Dec 2023 12:10:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v4 2/3] e1000e: Use PCI_EXP_LNKSTA_NLW &
 FIELD_GET() instead of custom defines/code
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 linux-kernel@vger.kernel.org
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/21/2023 14:34, Ilpo Järvinen wrote:
> e1000e has own copy of PCI Negotiated Link Width field defines. Use the
> ones from include/uapi/linux/pci_regs.h instead of the custom ones and
> remove the custom ones and convert to FIELD_GET().
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/net/ethernet/intel/e1000e/defines.h | 2 --
>   drivers/net/ethernet/intel/e1000e/mac.c     | 7 ++++---
>   2 files changed, 4 insertions(+), 5 deletions(-)


Tested-by: Naama Meir <naamax.meir@linux.intel.com>

