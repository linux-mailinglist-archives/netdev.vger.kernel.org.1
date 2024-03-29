Return-Path: <netdev+bounces-83266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B108917F5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989101C21BC2
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660AB48CC6;
	Fri, 29 Mar 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgQEXk5g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8E2E3E5
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712371; cv=none; b=qWl6MSG49VCkErPJIX83FJu10MpWNMvNVXvGfnGVhQJ2d4eY3kJR8lWFTxJ4qV6HfXNdD8aEs2zFArH5NsBSOXyjwGqyi8B4U4voD5qQ/zwTjfDcY+b04ZhKZP3GzRdEUN0/osmT8KqN6I/daFolr/jrcfuIIgp/os4oBIOW2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712371; c=relaxed/simple;
	bh=hKYtQkSeZ5ltpeJ0N8ysOEzYzpezyP4+EXMnh1ySvx0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pjgOfbntHkrnVvFPJ2qmUgdQjZO54/BhGPPGoyuxNJPSOLRqRN7NLlsx44/sIVb5xnBXtsqMecmRSI4uMs5GcZ5DITUf1RBlweITixGLBESTyk7MzMOM0g1lTTFJcla6e0woyI4XkI+XRv5SfyBiAyI790vcGcMjIthWyg5p/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgQEXk5g; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711712369; x=1743248369;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hKYtQkSeZ5ltpeJ0N8ysOEzYzpezyP4+EXMnh1ySvx0=;
  b=FgQEXk5gz0cYo7AqcQj4mGOpNVX82dSUxJv3nZcXqaFb5bwEJWb5PLvI
   lCepgkFndkI9jVVujhdhNHiC45mWtS8/raJAVaEOlBQwdV8oGko7Ofr/k
   uLIAG0O7/HekOQ03RH4ZktflS/e5hBHBwArhaoKehZZCUUjVBUSnBkXkb
   wtCy0I69NbwMUxUPSfHp54URPG4ZWIcVbzOccMTbRnYZg80Tomt77XDvS
   I8kxyZrsRm20jO1NGics8Pk8eGyqEaQFL7op6Jj9X92P9CQC6oGNbe2uO
   iooGTKm3RgZegszh+pPqAFElYDE0XEdOk9P2X25timNv0qOB7ibqssg5R
   w==;
X-CSE-ConnectionGUID: 5CQzrPrySRCA+T0pWwALyA==
X-CSE-MsgGUID: aw91iNjTSzqkqt9bm+tceQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="9855562"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="9855562"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16988890"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.35.198]) ([10.246.35.198])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:39:27 -0700
Message-ID: <7ded72b3-4c22-43d4-a5b5-191ef643c6c1@linux.intel.com>
Date: Fri, 29 Mar 2024 12:39:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ice: Reset VF on Tx MDD
 event
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 pawel.chmielewski@intel.com, anthony.l.nguyen@intel.com,
 Liang-Min Wang <liang-min.wang@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20240326164455.735739-1-marcin.szycik@linux.intel.com>
 <20240328173450.GH651713@kernel.org>
 <fbf9dae9-c023-4b15-b3d8-6b19240f59b0@linux.intel.com>
Content-Language: en-US
In-Reply-To: <fbf9dae9-c023-4b15-b3d8-6b19240f59b0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.03.2024 12:31, Marcin Szycik wrote:
> 
> 
> On 28.03.2024 18:34, Simon Horman wrote:
>> On Tue, Mar 26, 2024 at 05:44:55PM +0100, Marcin Szycik wrote:
>>> In cases when VF sends malformed packets that are classified as malicious,
>>> sometimes it causes Tx queue to freeze. This frozen queue can be stuck
>>> for several minutes being unusable. This behavior can be reproduced with
>>> a faulty userspace app running on VF.
>>>
>>> When Malicious Driver Detection event occurs and the mdd-auto-reset-vf
>>> private flag is set, perform a graceful VF reset to quickly bring VF back
>>> to operational state. Add a log message to notify about the cause of
>>> the reset. Add a helper for this to be reused for both TX and RX events.
>>>
>>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>>> Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
>>> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>
>> Hi Marcin,
>>
>> If I read this correctly then a reset may be performed for several
>> different conditions - values of different registers - for a VF
>> as checked in a for loop.
>>
>> I am wondering if multiple resets could occur for the same VF within
>> an iteration of the for loop - because more than one of the conditions is
>> met. And, if so, is this ok?
> 
> Hi Simon,
> 
> Good point. Nothing too bad should happen, as ice_reset_vf() acquires mutex lock

Sorry, that mutex doesn't matter much here, as we'd call another ice_reset_vf()
after previous one is done anyway.

> (in fact two locks), so several resets would just happen in sequence. However,
> it doesn't make much sense to reset VF multiple times, so maybe instead of issuing
> reset on each condition, I'll set some flag, and after checking all registers I'll
> trigger reset if that flag is set. What do you think?
> 
> Thanks,
> Marcin

