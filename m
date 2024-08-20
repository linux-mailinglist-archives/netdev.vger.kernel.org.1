Return-Path: <netdev+bounces-120088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9399583F9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2721D28456C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADE18CBE9;
	Tue, 20 Aug 2024 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ936ArJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975718C356
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149093; cv=none; b=VWm8c3bTQPPyWKF4ReBiSfYQkEArJFKHvFzhK6VI+6Yg2m3i3pcjlWQ4tztGKMXukDWkEB6J+Sir7QPlRDTrBdbQyNFb5fxKmCRbWh02ZAKaCDBSnWqBORii6fSOfwD2EdvUfAdocDR7vEGiDLXL41poAcpIa8EICtzvjpHRE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149093; c=relaxed/simple;
	bh=XgVONl2BEHKbhJm4+IYUC4BV30j7HIE44ASG1Qz70ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5UujdWb29N+wAsfCdjAH5zvMbm9PvAtmpp+kJv0adQAfHLgAdWFvnh8/vrBo6miTXM4BufVtC2FACVtpdkzmfcKOdmOj8jvGZl8jvzUiVbHafIz+/vEW+ZvNRIbrU5u/UjaiJErUMTM7UNcR1Bzbc7nJo2MLqpFhLvPNOFRYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ936ArJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724149092; x=1755685092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XgVONl2BEHKbhJm4+IYUC4BV30j7HIE44ASG1Qz70ts=;
  b=IJ936ArJEbAFzBgH+JESiG/9vcviUj2LLYGRy8BfYr4tSUIfrB4ui/iV
   UcN0UGubvm/Uh5m7RhY9LbwxM2oT6bEGGIN+adH1nUABxWMA7Mb5R4/sP
   ZVSfqWvqCjV0ZiVRQiPweuEseX43gJfUW6YYdICNpChNValcbDjsEe1Ja
   KWDFYZQBvCplX/Y6qcGAKCPPXfNwEaDjMBT5E3gBcxght4nJVsCDzDvT8
   xm1waQ9C/16K+1prHSr1fVWHCXUIBUiGQCR2xlJ0gC/l7YbkBU3PBSxgM
   yGJ/16ocPlR6NiitA2623/bLVpGDuupE1CWJRalMfGxa4EALzAgr8Qa4B
   g==;
X-CSE-ConnectionGUID: w4aZPXeHQDSif1/Vuu95GA==
X-CSE-MsgGUID: kSz+bQ8wRDWQBsBTdRBM1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22617251"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22617251"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:18:11 -0700
X-CSE-ConnectionGUID: nUMQ5+KATBOPlv9SHaw+Pg==
X-CSE-MsgGUID: F4+GQ3kbTMWee1MSINU4Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60339009"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.245.116.159]) ([10.245.116.159])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:18:09 -0700
Message-ID: <c5e08b9f-9424-4863-b5f5-09d11c8a1dc7@linux.intel.com>
Date: Tue, 20 Aug 2024 12:18:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3] ice: Add netif_device_attach/detach into PF
 reset flow
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, larysa.zaremba@intel.com,
 maciej.fijalkowski@intel.com, kalesh-anakkur.purayil@broadcom.com,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Igor Bagnucki <igor.bagnucki@intel.com>
References: <20240819082146.101755-1-dawid.osuchowski@linux.intel.com>
 <ba76710b-c3e2-442a-b398-2b2a87f3642c@intel.com>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <ba76710b-c3e2-442a-b398-2b2a87f3642c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.08.2024 10:47, Przemek Kitszel wrote:
> On 8/19/24 10:21, Dawid Osuchowski wrote:
>> @@ -7731,6 +7733,10 @@ static void ice_rebuild(struct ice_pf *pf, enum 
>> ice_reset_req reset_type)
>>           ice_rebuild_arfs(pf);
>>       }
>> +    struct ice_vsi *vsi = ice_get_main_vsi(pf);
> 
> you should separate declaration statements from expressions by one blank
> line; we also put declarations at the very front of the scope

Will fix in next revision, thanks.

>> +    if (vsi && vsi->netdev)
>> +        netif_device_attach(vsi->netdev);
>> +
>>       ice_update_pf_netdev_link(pf);
>>       /* tell the firmware we are up */
> 


