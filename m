Return-Path: <netdev+bounces-117664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25894EB74
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF521F222FC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12CE170828;
	Mon, 12 Aug 2024 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxDwqN5i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764016E89B
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459731; cv=none; b=uJ+3LmZleI/Ja953YHVrbPjXYfpk2Uy2vy7fMp8gsPdgd2SsuYn4KkNz2TDF+3K0xZR929rBA+u64QThLDGj3zYuRkgeRSyUpivtbuTAY3xKmM45S3eACUddfy78NiYdG2gqzZ6XcyT1fGeLdhhsfSwuvoYhe9UFgiFTpbBnCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459731; c=relaxed/simple;
	bh=eV7lAGb1MJFY+mLPUB4VhgIv6+y05aN3SubrltMv1N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVJvHi/1UEs5A9E5SkThj3xhAZNWoyLqRAw7M7IxqLtpeEMTePCLfRVnJv7Tz8N8PkMfg4kVMEN/s4Uyw7NUjCxofb9jgno0r8xLVlyWn9d9MivAHG/VuIBepFpC7Gabz0aVSk6qaHbAb2TQPfH/93VjTtvop4ihbMtxvubLg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxDwqN5i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723459730; x=1754995730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eV7lAGb1MJFY+mLPUB4VhgIv6+y05aN3SubrltMv1N8=;
  b=NxDwqN5ijr6C44d7DDesPvO0uVexFhdYTuVFeCuIpvNyDiO2rAptgV11
   FMbjgN7ufy8NjVEs3wei1I/wBuHfaR2qgRuuDGAsgzzhH0A3ShUn4XWHl
   0Mzv8NBA01cWPzYkKVQzCFMFDcqSo0xwjJmhMwXlQ+CmRq3RKNCnGj1S2
   bkjisvoxJkFSPzXsvxd0b183Lkegr+CXaAWwB07A0SkawSZZmTSoHvYmX
   Q6Ksjd+mcEITKrWSdItw3Toj/B0R9ajIKFnqmlMmrBsiB3P2JG5UAUDVx
   0EYkhle58NKqKYztXJG9lVGsf2Ew2nEQ+KAoq+jXzmoWFj2fqGEXM552h
   A==;
X-CSE-ConnectionGUID: HROYXJRIQOK0Vtu3Bf0K0A==
X-CSE-MsgGUID: sXQbDWc6Q/yNUG1pZBPsjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32139992"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32139992"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:48:49 -0700
X-CSE-ConnectionGUID: ojUYh2FvR8GuB4xGEcEyNQ==
X-CSE-MsgGUID: gTU7XxZ7T/aTr3+DzBSdzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58789297"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.245.130.66]) ([10.245.130.66])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:48:48 -0700
Message-ID: <d7df5610-5e8d-45d9-a17f-52463ca3ba3e@linux.intel.com>
Date: Mon, 12 Aug 2024 12:48:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: Add netif_device_attach/detach into PF reset
 flow
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Igor Bagnucki <igor.bagnucki@intel.com>
References: <20240812102210.61548-1-dawid.osuchowski@linux.intel.com>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20240812102210.61548-1-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.2024 12:22, Dawid Osuchowski wrote:
> Ethtool callbacks can be executed while reset is in progress and try to
> access deleted resources, e.g. getting coalesce settings can result in a
> NULL pointer dereference seen below.

Please disregard this submission, I have been made aware of additional 
issues in internal review and will send new version with the changes.

--Dawid


