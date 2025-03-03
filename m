Return-Path: <netdev+bounces-171317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7FA4C830
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58CC1763FF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17A264636;
	Mon,  3 Mar 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR47wxvw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6226461D
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019509; cv=none; b=q67jKqR6oPbzXrbaCyua8Gvt0iwtreKjdY+8NIxxovTPrGlVUaDmhhWBDvkgPEutLw002J3wi7jAZ/EqL1roWLVoiveWYJHfD4z708LhJgmq6ApvO/Kj2o0WArrQGbOlpUmOHWVrOgPYZTWTsWhqg5cwugkhko6458INaBNF49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019509; c=relaxed/simple;
	bh=7LxWNqT1fMj8bNfdr42HT/hMBkfO3rmJ9k0l5GEGYmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXgegm5qPiR0DqQYNb8mVnaBhLU4V66K2fLYg5FSEbjPtqwAhuohimB9qy0INQFzMmhnBfG/5feGluEQ3qz+08ov2WjxPk5ZjapMoFk5+3Y4TWiq8lSDpP634iynr9BtrwnkplcO+EOKkDp8Lny5JRu3TRONnpCsCFP/DHRR5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR47wxvw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741019509; x=1772555509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7LxWNqT1fMj8bNfdr42HT/hMBkfO3rmJ9k0l5GEGYmM=;
  b=OR47wxvwDhjz6h7JkTsMK0xtO54uPKUlP4di8G+ILSCfDPrHO3aX/QFb
   LzmGgGaSgxoMU2rJs3jYAd6GEkE8xDx9jFbASh3Kjrl/+0DBBfuw3Cght
   Zuo4doffJLfmw0tNDXu6xQNNBc8y0Uuqqrb6BkEAq0kUNpih43jeoI6r3
   s9nyc6wqMl9IDNZUby4S8tjvrLWLvEZSLG8qwqJiEjBqfuh++7lIE+YnY
   b61KaatEyD9LtKMc04ihYVdn5q7AH9Hvu9YDn5Ah76Oyhc+QUWKNDuzRA
   4cpFlS+0O5NculWxwJny3aJfBDtIiCiY4X20d2RRyCUXqQXXLWv/EgYym
   A==;
X-CSE-ConnectionGUID: QBSM9iE6RiiYwRCPzBBxuA==
X-CSE-MsgGUID: t8MKYX2WQoicAHq3NeLywg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41814869"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41814869"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:31:48 -0800
X-CSE-ConnectionGUID: 3n7syFCqQamalbUmj3rVcg==
X-CSE-MsgGUID: EAz3T0foTqGwyZp4ZkmPEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148981543"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.84.226]) ([10.245.84.226])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:31:46 -0800
Message-ID: <4cf2a594-b45c-4527-8d90-cc574d35747a@linux.intel.com>
Date: Mon, 3 Mar 2025 17:31:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net v2 5/5] ice: fix using untrusted value of pkt_len in
 ice_vc_fdir_parse_raw()
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-8-martyna.szapar-mudlaw@linux.intel.com>
 <20250228170939.GK1615191@kernel.org>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20250228170939.GK1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/2025 6:09 PM, Simon Horman wrote:
> On Tue, Feb 25, 2025 at 10:08:49AM +0100, Martyna Szapar-Mudlaw wrote:
>> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>
>> Fix using the untrusted value of proto->raw.pkt_len in function
>> ice_vc_fdir_parse_raw() by verifying if it does not exceed the
>> VIRTCHNL_MAX_SIZE_RAW_PACKET value.
>>
>> Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
>> ---
>>   .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 25 +++++++++++++------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> index 14e3f0f89c78..6250629ee8f9 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> @@ -835,18 +835,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
>>   	u8 *pkt_buf, *msk_buf __free(kfree);
>>   	struct ice_parser_result rslt;
>>   	struct ice_pf *pf = vf->pf;
>> +	u16 pkt_len, udp_port = 0;
>>   	struct ice_parser *psr;
>>   	int status = -ENOMEM;
>>   	struct ice_hw *hw;
>> -	u16 udp_port = 0;
>>   
>> -	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
>> -	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
>> +	if (!proto->raw.pkt_len)
>> +		return -EINVAL;
>> +
>> +	pkt_len = proto->raw.pkt_len;
> 
> Hi Martyna,
> 
> A check is made for !proto->raw.pkt_len above.
> And a check is made for !pkt_len below.
> 
> This seems redundant.

Right, thank you for spotting it, will fix

> 
>> +
>> +	if (!pkt_len || pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
>> +		return -EINVAL;
> 
> ...


