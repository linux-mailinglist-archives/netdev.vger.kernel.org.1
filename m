Return-Path: <netdev+bounces-54696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE90807D07
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 01:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7311C20BCD
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631E367;
	Thu,  7 Dec 2023 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6JPcthY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98C137
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 16:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701908778; x=1733444778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xZ1OH9wKIvhPVgH5ur8bjSVDHHxW6WDPg5JRMWIHXSY=;
  b=h6JPcthYDGP/BvIDDAnbhAj7nC/RTenaU24i0ULq4rpev/UZiFZSKVQo
   VodzKP2xduBjI/eCZy+ECUlKPl54pMd20ni8w4zy6XjROaWE7ptnNOJJM
   j/cxu3bb6oJVfLsUWGJB4jzxAow9EEm+h/tbiiaN+TNq9x2FO4E2rFdIT
   EZt7nBmxPencOHGjKuR3jlGEzejzZk11Q3uwmDuu9sniQq3dxjhzOVCA0
   DcyQ6KFUJQgoqsFstl1FzHude8w8S8iqqZ9UCrx35HX9O/tz+VNvTWVLe
   hVELGKIoZDcxFD3dwzhXPXo/PcMd7k4a2Tn41pASNZwFe6qTcPf4nWcof
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="425302678"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="425302678"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 16:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="764912669"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="764912669"
Received: from pkaminsk-mobl1.amr.corp.intel.com (HELO [10.124.112.216]) ([10.124.112.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 16:26:17 -0800
Message-ID: <340900d4-b30a-4387-9ce2-1971e8d8024c@intel.com>
Date: Wed, 6 Dec 2023 18:26:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v1] ice: Add support for devlink loopback param.
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: intel-wired-lan@osuosl.org, netdev@vger.kernel.org,
 Michal Wilczynski <michal.wilczynski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231201235949.62728-1-pawel.kaminski@intel.com>
 <20231201183704.382f5964@kernel.org>
From: "Kaminski, Pawel" <pawel.kaminski@intel.com>
In-Reply-To: <20231201183704.382f5964@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-01 20:37, Jakub Kicinski wrote:
> On Fri,  1 Dec 2023 15:59:49 -0800 Pawel Kaminski wrote:
>> Add support for devlink loopback param. Supported values are "enabled",
>> "disabled" and "prioritized". Default configuration is set to "enabled.
>>
>> By default loopback traffic BW is locked to PF configured BW.
> 
> First off - hairpin-bandwidth or some such would be a much better name.
> Second - you must explain every devlink param in Documentation/
> 
> Also admission ctrl vs prioritizing sounds like different knobs.

While at certain abstraction level I agree, in my opinion it is not 
worth here to divide this to separate knobs, since underlying logic (FW) 
doesn't follow that anyways. It is driver specific and extremely 
unlikely to change in the future. Hopefully next gen card will not need 
this knob at all.

>> HW is
>> capable of higher speeds on loopback traffic. Loopback param set to
>> "prioritized" enables HW BW prioritization for VF to VF traffic,
>> effectively increasing BW between VFs. Applicable to 8x10G and 4x25G
>> cards.
> 
> Not very clear what this means...
> So the VFs are Tx bandwidth limited to link speed.
> How does the device know it can admit extra traffic?
> Presumably this doesn't affect rates set by devlink rate?

I will rewrite the description and explanation in v2 and include 
documentation change.

Thank you,
PK

