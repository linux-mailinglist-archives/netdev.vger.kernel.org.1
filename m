Return-Path: <netdev+bounces-191519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A8EABBC15
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA307AD13D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DEF27466A;
	Mon, 19 May 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7UIph1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83D274650
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653068; cv=none; b=XovdeFCyveROZkTqdKaL6M0hsh27f+h1mR7jMz7qTL/l19+ieSwba/YNw7pN9PFBuE1aNTm9Uzxf6oZWWKmf8HvwcT+8bL8NndQggAtNlqtZ5tF7Q1JkN4h7UpH/eosJbI0ETTVXmZ3JMZqXxrBnRzl37weD/6IWp8ida99IGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653068; c=relaxed/simple;
	bh=wDy9U9xfDCcQpqqxYgT4nsDbQCpuav+UsE+22IXvpTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6NxSVNsIMccSZcAxWTIC5Fm+X3lWVksiuE2x7tk6nJw2kqbXs4xJpQ+ohbjlMyK0hfmOU9d05uYcAAGzF+L7LSykAdCzmydn4l744E83MGewxPsD+72iA8fxJ0uqtEMG1m00KLoU3lBl+lahiGwDWtll0PNpl3H05pwXZZESqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7UIph1Y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747653067; x=1779189067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wDy9U9xfDCcQpqqxYgT4nsDbQCpuav+UsE+22IXvpTI=;
  b=n7UIph1Yqibl23a7yMNKliLDdHt+ywf9ai54+VWvQPmdsWnGaURuyHhN
   IQIw7lQysntTX7B+GRs1zURdFNF5p4DIbQWQD2toBgAnHhS0t5qqf15Gy
   2zkawXn0fAl/ygjlKcYW1LQlgFvzTGwRSaPUHXkY+wIriXxLruL2M6OIH
   O1mmbDf3RjKCr+HjKMl1OpQp2CD5K8VNetZUu+eRqEprwXllEEyF8nH8C
   u0kyJ+zdWBo+EtbiBm1ojm4Hi/7/tB6JQlaD2r7gzQLfy3saprPhTP1Cp
   tLWl1u9RCX+Sd4KTx86lEztxO2BRaddCjaJb+Mc4mJJ/+wzrz519GvDlx
   g==;
X-CSE-ConnectionGUID: JIFmy0wdQb2AcL/mEzpyGA==
X-CSE-MsgGUID: 0EpGkMl5R0OzMvt5MSzHWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53221111"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="53221111"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:11:07 -0700
X-CSE-ConnectionGUID: lUC/xHwRRDuxiTu+YoKz+g==
X-CSE-MsgGUID: 0VcRx902RNS5Z3vukCq1tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139855703"
Received: from cwachsma-mobl.ger.corp.intel.com (HELO [10.245.252.240]) ([10.245.252.240])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:11:05 -0700
Message-ID: <46e45673-66fa-4942-a733-fdcbc95b5ee1@linux.intel.com>
Date: Mon, 19 May 2025 13:11:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: add E835 device IDs
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Konrad Knitter <konrad.knitter@intel.com>
References: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>
 <8c8999a7-d586-4bc6-9912-b088d9c3049f@molgen.mpg.de>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <8c8999a7-d586-4bc6-9912-b088d9c3049f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-16 10:57 PM, Paul Menzel wrote:
> Am 14.05.25 um 12:46 schrieb Dawid Osuchowski:
>> E835 is an enhanced version of the E830.
>> It continues to use the same set of commands, registers and interfaces
>> as other devices in the 800 Series.
>>
>> Following device IDs are added:
>> - 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
>> - 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
>> - 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
>> - 0x1261: Intel(R) Ethernet Controller E835-C for backplane
>> - 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
>> - 0x1263: Intel(R) Ethernet Controller E835-C for SFP
>> - 0x1265: Intel(R) Ethernet Controller E835-L for backplane
>> - 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
>> - 0x1267: Intel(R) Ethernet Controller E835-L for SFP
> 
> Should you resend, it’d be great, if you added the datasheet name, where 
> these id’s are present.

Sorry it isn't publicly available yet.

Best regards,
Dawid
> Kind regards,
> 
> Paul

