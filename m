Return-Path: <netdev+bounces-226757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96648BA4C49
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571F52A3D7F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478230C0E0;
	Fri, 26 Sep 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKzX1zOO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B42AD35
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907479; cv=none; b=KJmxjHfgagt7zcnz40t3YHyGcDSrOokNa5VEYpWq8qAc/Fb4btj+If5wm5+2Dv2lClpJYv4ea7T3mdOQbwQiondUNHsaSCOSIfOtTmBdgr2yS3YqjhfKf68XjzXJWwyiediRGFKoMr27kZ7ZQknsAQ7rOBKp3A+YrRVSsNwb5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907479; c=relaxed/simple;
	bh=IXjM460G+pQoC9dt3t9ch3nvitDQe6KKfQT28W+y630=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpiOwjw82QZSBQ1Nm0QpuVyxYBd2QKXeA/conPAoreJ6WxXaoggPsFfJQIiHzRHex1Hnl59E0MBajIeKEexsiQ9ob8IVlS4ttyM++GacJIXmdAdkmQUPmsvi5blmHEF38lD7tnZL5nsuJyuHwvRJymYZD9EuqocYPAEinkJnEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKzX1zOO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758907477; x=1790443477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IXjM460G+pQoC9dt3t9ch3nvitDQe6KKfQT28W+y630=;
  b=iKzX1zOOI0vDna84+6xp2WCDlAphmlPQZcxr8QT54+rtUynf0VR1hKzJ
   3VKBiVGHI1r8YlMFR6k7z3wgkN3TJ1RtjPzG8JXh4XhvVqfveKmZN67QT
   ZhxmnE/LOpEtdME+qCzsiXJIX85paYnV8DJiCrGS2QVr5rdmMRwRx1Z7m
   bEz51xx8kogN26yavCUp4+DjqkhMRAOGfK8qQ5yuty29xozFmMhO86zcL
   /tYwqGDehzzDqnbteg4DqVHBurzujDpe6K4wFZuZPsv5L7vCZcFYGsf4i
   5YwEnAjGKTFj6zIE8TPfNCvypxGzDQpIO8vuH7SFvNH164p0LOVnZeQFO
   w==;
X-CSE-ConnectionGUID: A1fokC6ST7eHYMrAJU7TKA==
X-CSE-MsgGUID: 62bPMdbfRgmwbTAV0G1Fqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="78675956"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="78675956"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 10:24:36 -0700
X-CSE-ConnectionGUID: thk8yZZkR2u5yZ/4WUWa2A==
X-CSE-MsgGUID: O9Y3vAXjQI6ZKiBRRatpgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="182852319"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 10:24:35 -0700
Message-ID: <c4b907aa-726b-4d44-b485-d24c7790c73c@intel.com>
Date: Fri, 26 Sep 2025 10:24:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/5] bnxt_fwctl: Add bnxt fwctl device
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, saeedm@nvidia.com,
 Jonathan.Cameron@huawei.com, davem@davemloft.net, corbet@lwn.net,
 edumazet@google.com, gospo@broadcom.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
References: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
 <20250926085911.354947-5-pavan.chebbi@broadcom.com>
 <5f581053-b231-4f37-91dc-4f2fd8c571a4@intel.com>
 <CALs4sv3P_W=ipS5MWKQrThDkPXmdFnfxRroDiZXbdrQXXqetsQ@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CALs4sv3P_W=ipS5MWKQrThDkPXmdFnfxRroDiZXbdrQXXqetsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/26/25 10:11 AM, Pavan Chebbi wrote:
> On Fri, Sep 26, 2025 at 9:31 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
> 
>>> +     if (msg->num_dma) {
>>> +             if (msg->num_dma > MAX_NUM_DMA_INDICATIONS) {
>>> +                     dev_err(dev, "DMA buffers exceed the number supported\n");
>>> +                     err = -EINVAL;
>>> +                     goto free_msg_out;
>>
>> Shouldn't rpc_in.resp get freed with an error returned? It's leaking rpc_in.resp on all the error paths from this point onward.
>>
>> DJ
> 
> Isn't the caller taking care of it? The fw_rpc is called as:
> void *outbuf __free(kvfree) = fwctl->ops->fw_rpc()
> I was expecting that outbuf will be freed once it goes out of scope,
> regardless of success or error?

Not exactly. Because when the function errors, it is returning ERR_PTR(rc) rather than rpc_in.resp. So the caller can't really free it because it doesn't have the pointer to the buffer. And even for the sake of argument lets say it works that way, it's best practice to clean up in the function on error paths rather than expecting the caller to do it for you. 

