Return-Path: <netdev+bounces-54845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6DB808877
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390D8B20E65
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A213D0C7;
	Thu,  7 Dec 2023 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Psq70qvT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E70D5C;
	Thu,  7 Dec 2023 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701953610; x=1733489610;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ZiHl9FrPeon9v+0HakeSLaCOj/bdmgwLi2bMYXzJSUE=;
  b=Psq70qvTGlqNW6T+BxEFHN05WTFW1NQ/NtJ68Vy6SRlDfSNn+jIDVsLE
   agjqMEoqbqmfpxr/t59LNql3c2Y9eTYK9F1DoYQTFqx5sztUwgGwLz8Hu
   iDT9NQnuBDfycbAR6n7PjHC1EHJlAxfJmASC0Y5yiS4cicN0P099WSWJT
   SS+wVg+9bMD3jQ64/VbdbPIGa1aOudVp+Jv5mrudN1Jb/gfWk1i4wGeEA
   Gtaf6CFX+RphhW6QWqVVMEj9D6F2XLl9idrkHoZ57AM1Vv/W0eREDOVgT
   ekuHkJFfDxl6LDT0AvhxY/bvwj640DHCAx/QeKnth3af4S1oyGhP1gbbe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1092309"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1092309"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="945022813"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="945022813"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.214.195.94]) ([10.214.195.94])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:53:26 -0800
Message-ID: <04cbd377-8b3f-4013-9d6b-71dbfd7adaef@linux.intel.com>
Date: Thu, 7 Dec 2023 14:53:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v4 3/3] e1000e: Use
 pcie_capability_read_word() for reading LNKSTA
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 linux-kernel@vger.kernel.org
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/21/2023 14:34, Ilpo Järvinen wrote:
> Use pcie_capability_read_word() for reading LNKSTA and remove the
> custom define that matches to PCI_EXP_LNKSTA.
> 
> As only single user for cap_offset remains, replace it with a call to
> pci_pcie_cap(). Instead of e1000_adapter, make local variable out of
> pci_dev because both users are interested in it.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/net/ethernet/intel/e1000e/defines.h |  1 -
>   drivers/net/ethernet/intel/e1000e/mac.c     | 11 ++++-------
>   2 files changed, 4 insertions(+), 8 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

