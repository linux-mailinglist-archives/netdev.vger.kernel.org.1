Return-Path: <netdev+bounces-120453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42AC9596B6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF122283C77
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3424F1B81C9;
	Wed, 21 Aug 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBacKJXY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF41B81B5
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227829; cv=none; b=ZI3LUknNBOzbK0iqWYBK8gMDSKmS19NqOkjNBGV08ab2dAwKDT6pmXdGK1h0X9lfcMQDTLXx+J3Xcllv3zvPoyuwJzCqZWG1iurQqyV+BPazq5Myc37m2MFnjfhr98ZKJ1xhu3LAFrlc+qV7Leuu3bpMEpAlE84DAMqFj7FHZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227829; c=relaxed/simple;
	bh=ivvgB0cUn8JdRpMYm+PJMRBdz3lefpAdaf3PnAKhIUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=matK4QIm8xM/1Cj1xv6mUggx07wiYFGoj7zMo1aQhHknC+Hgm5v/sQG5sm/0fr+e2IRHF5ouJVTr2134ycrbB4jsAPX4ct1HBRHe6VDox0FpammDqFQ0M4YR0Oh1QMXBSROICjUfie7ewilBwxmRwac4U9UE+aOfwoV+FxN0cZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBacKJXY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724227827; x=1755763827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ivvgB0cUn8JdRpMYm+PJMRBdz3lefpAdaf3PnAKhIUs=;
  b=OBacKJXYuNsPWYjo1IYQOsE9vvOCfBbe5eGmfb45NlByfrl14zOWbBLI
   WTxSV+tJgC/7npTvuTRFCeg+nlp6ZS3Eshf64W/nucuTsChIew3Fpo5aY
   QTV+qEZkciXIhutyv9h8zqIHHg/3+FL2aL+r4wuM9R6zar6H5YXx4vxa1
   L2LDNV1CFTw6FeW2E1tWwb600WEbPiIUHFoZnVJ82hhvBIL8kKkgbeeVW
   w6giil8hSFHVtfEZ702GI3LT1eACXaAynYnE1DZmVq7gOThqFH+EJNQnH
   rtXrZKSkEA10zxwLMVV4WBZHCKxdK3jWXaif5EPC6IfCMqDGF7xqgO51+
   w==;
X-CSE-ConnectionGUID: 7VWBbzYvTAupoNxBlpJGIA==
X-CSE-MsgGUID: ZPvxx1LYQYWwi0kLbn8x5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33233751"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33233751"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 01:10:26 -0700
X-CSE-ConnectionGUID: 6cieWzGsQGKcvRqJz0aKWA==
X-CSE-MsgGUID: GxR05bmhT1CNDvyRB5Pb7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61545390"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.246.27.111]) ([10.246.27.111])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 01:10:25 -0700
Message-ID: <25c69f6d-bd04-429e-a1d5-c6985b6555bf@linux.intel.com>
Date: Wed, 21 Aug 2024 10:10:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v4] ice: Add netif_device_attach/detach into PF
 reset flow
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 larysa.zaremba@intel.com, kalesh-anakkur.purayil@broadcom.com,
 Jakub Kicinski <kuba@kernel.org>, Igor Bagnucki <igor.bagnucki@intel.com>
References: <20240820161524.108578-1-dawid.osuchowski@linux.intel.com>
 <ZsWHsaUbYo9Qb6v2@boxer>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <ZsWHsaUbYo9Qb6v2@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.08.2024 08:22, Maciej Fijalkowski wrote:
> On Tue, Aug 20, 2024 at 06:15:24PM +0200, Dawid Osuchowski wrote:
>> @@ -7591,6 +7594,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>>   {
>>   	struct device *dev = ice_pf_to_dev(pf);
>>   	struct ice_hw *hw = &pf->hw;
>> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> 
> we have an unwritten rule that is called 'reverse christmas tree' which
> requires us to have declarations of variables sorted from longest to
> shortest.
> 
> 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> 	struct device *dev = ice_pf_to_dev(pf);
> 	struct ice_hw *hw = &pf->hw;
> 	bool dvm;
> 	int err;
>

My apologies, I was not aware of that unwritten rule. Will fix in next 
revision, thanks. Other than that, does the rest of the changes look 
okay to you?

--Dawid

