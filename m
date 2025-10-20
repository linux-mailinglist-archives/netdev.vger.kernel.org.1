Return-Path: <netdev+bounces-230917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63581BF1B39
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9E154F4F79
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD322F658A;
	Mon, 20 Oct 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3wa/g/l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0C20296E;
	Mon, 20 Oct 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968751; cv=none; b=dWfSvGKnoeFKkhqJt8rT++4yOQAhlF3lG8txdtk/Y/vNP5nTjhEANOgvYebaycCdZZZZCsb8nS+/Tw1Snqj2NXjpYiPteAR85FpCLG8ufUcyoTJuYTUTSl9giT/wPMFNjTC9iuMsebF/1FSP0iPJISex992bJCEhF1WpUi2leHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968751; c=relaxed/simple;
	bh=OP560MHIDGhVvdUKaAUiNOOBd7Yk5elbMlYmmScimsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJU3vwOJBTmRFtQLhvhbosxs1xZuj+cucJtqN4rf0Qb/O5Dknf57xiB8uNy8HC1l+3bX9BmFGGFpPDWo0JndKrwHDUF4POV5UfptIONQPj18YC4MBuHw4pN1eJ68Nq6464kyKOVUMOfsoAWbtmLv9ijyW8zgTQ9+VwhJsOXKPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3wa/g/l; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760968750; x=1792504750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OP560MHIDGhVvdUKaAUiNOOBd7Yk5elbMlYmmScimsQ=;
  b=D3wa/g/lJvOF6SRzyNg8jlqsWcMH9Cuood2ybN6Va71Gik27uY2eu+D1
   2PTReVzjpO7e28xeH3mhlW4dniuWiOZjATm2JRYlihBVtmgQEUegtf/zS
   63M3epAcYPr+6SJO4Brpnf69NCaHwCmm2/LXzo2M4DfxbhN7qxg7qtZ/X
   UfkP4tXwzCiumfSRO0VcjNTb+bbCjiThu7Bf3QMHQ2XknxFahBCgeILEM
   sdlbnQ72vtC0NdD2/CLJ9i793FLGx3sLqoA0NbLsoSHt+hGYtWEvd3GJD
   uZcTz4edleEhCMu5Ic1iE+DjoCOvMo9ZBU0McZFhvAWwuVzOiIeV4AnIn
   Q==;
X-CSE-ConnectionGUID: 0z+r0Qy8T0eHIWD38ak0SA==
X-CSE-MsgGUID: fBvq6aYNQlCXgIaDVZtsVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62988298"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62988298"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 06:59:09 -0700
X-CSE-ConnectionGUID: duw/PCR8RQS0AvtznKjUtQ==
X-CSE-MsgGUID: Uj/zb9i6SL+d1NSrS6kX3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183350748"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.103]) ([10.125.108.103])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 06:59:09 -0700
Message-ID: <a5b85488-2d68-4b78-8f9c-277e169b3571@intel.com>
Date: Mon, 20 Oct 2025 06:59:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
To: Alejandro Lucero Palau <alucerop@amd.com>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
 <c42081c1-09e6-45be-8f9e-e4eea0eb1296@amd.com>
 <aa942655-d740-4052-8ddc-13540b06ef14@intel.com>
 <127311bc-d3cd-48e9-9fc3-f19853bb766b@amd.com>
 <616d2aa4-96a7-4ed1-afd8-9fce85b45438@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <616d2aa4-96a7-4ed1-afd8-9fce85b45438@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/20/25 6:24 AM, Alejandro Lucero Palau wrote:
> 
> On 10/16/25 14:23, Cheatham, Benjamin wrote:
>> On 10/15/2025 4:42 PM, Dave Jiang wrote:
>>>
>>> On 10/9/25 1:56 PM, Cheatham, Benjamin wrote:
>>>> On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> Creating a CXL region requires userspace intervention through the cxl
>>>>> sysfs files. Type2 support should allow accelerator drivers to create
>>>>> such cxl region from kernel code.
>>>>>
>>>>> Adding that functionality and integrating it with current support for
>>>>> memory expanders.
>>>>>
>>>>> Support an action by the type2 driver to be linked to the created region
>>>>> for unwinding the resources allocated properly.
>>>>>
>>>>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>>>
>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> ---
>>>> Fix for this one should be split between 13/22 and this patch, but the majority of it is in this one. The idea is
>>>> if we don't find a free decoder we check for pre-programmed decoders and use that instead. Unfortunately, this
>>>> invalidates some of the assumptions made by __construct_new_region().
>>> Wouldn't you look for a pre-programmed decoder first and construct the auto region before you try to manually create one? Also for a type 2 device, would the driver know what it wants and what the region configuration should look like? Would it be a single region either it's auto or manual, or would there be a configuration of multiple regions possible? To me a type 2 region is more intentional where the driver would know exactly what it needs and thus trying to get that from the cxl core.
>>>
>> Since this is a fix I didn't want to supersede the current behavior. A better solution would've been to add a flag to allow the type 2 driver
>> to set up an expected region type.
>>
>> As for multiple regions, I have no clue. I haven't heard of any reason why a type 2 device would need multiple regions, but it's still very
>> early days. I don't think there's anything in this set that keeps you from using multiple regions though.
> 
> 
> What Dave says is correct, so Type2 should  support these two possibilities, an HDM decoder already programmed by the BIOS and the BIOS doing nothing, at least with the Type2 HDM decoders. This patchset supports the latter, but the former is more than possible, even if the logic and what we have discussed since the RFC points to type2 driver having the full control.
> 
> 
> However, I would prefer to do that other support as a follow-up as the functionality added is enough for the initial client, the sfc driver, requiring this new Type2 support. The reason is clear: I do not want to delay this "basic Type2 support" more than necessary, and as I stated in another comment, I bet we will see other things to support soon, so better to increasingly add those after a first work set the base. Of course, the base needs to be right.

I'm fine with the follow on approach. We probably should make a note somewhere in a commit log somewhere that only manual assemble mode is currently supported. And need to reject the BIOS created region and exit type2 CXL setup if present?

DJ

> 
> 
> Thanks,
> 
> Alejandro
> 
> 
>> Thanks,
>> Ben
>>
>>> DJ
>>>


