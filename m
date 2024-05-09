Return-Path: <netdev+bounces-94871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE08C0EA9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A02D1F218E5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E613049B;
	Thu,  9 May 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm7IaPNE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2B12FB0A;
	Thu,  9 May 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252736; cv=none; b=VbUvh4v916DMS1NHIMgj2ymovHLwU7RT6hSnopoliNwktPcFXzMrpyjSvlgf7T3VurWVVZ0iQNsUtkLqdqZLhXdsLQkrfhQEOwsqLn4QQJoD5H+rmlMXkCjgV7sqakmTiOB8xMqGZuhWaqu5RgiedlcGY9eGbjZMpLIJ0pAEzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252736; c=relaxed/simple;
	bh=8yZ5G/9SKrfBR+Zy97Nerwaq32t4U8fT298esodEx/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gUlgVualpD141UbFKE/CFhfYsRGd1tM5oT3bYq7rkG9NRsYgQMvO4OmZT4dbD75pJNGCCIHF7pCzbvXSUbOhyc8A2wv8BaiYgvy85mCJ9BHqfFRCXNQorL4NdVVmmET84lbJpQeMwo34MruybgG+qJIGHAPHwAe2ei5ZRj9s1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm7IaPNE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715252735; x=1746788735;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8yZ5G/9SKrfBR+Zy97Nerwaq32t4U8fT298esodEx/w=;
  b=Lm7IaPNEmj5rusRZ3dQ47sbz3qRnArFALMvUDLXhjLSWg3jsZK9aDuWB
   o/IbAH9DFffqB9F5hmxYgyhuGJCy1Cn3n/ehMgX3kE3P6kPWTaVObl0ER
   iy8bEXCpU9AalzH9AJo+5DiZ5JJh5KwKc6HrlXMpg202CtbdjdkvYlKML
   e/EL5uCGypIYvsT6aZyCQaQ20ef27wTFuu+tbAqz37RL9muiU/SyLuKAi
   gTSjxCQCIh/zsnT4rk5xll4yivGszCcOyQKLYvXTk8I9av9x2zd2hT6j6
   s9BpdauWQzDJieujJ/gdAz73s5L5YjaYEiYKtVBK6MzgdFen9K/KHpF8k
   A==;
X-CSE-ConnectionGUID: 5xyFTrGWTz+GJ6+s5zXjvg==
X-CSE-MsgGUID: S1tGx6wzQzaLC6izQfp7Lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21734846"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="21734846"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 04:05:35 -0700
X-CSE-ConnectionGUID: p23PnoRtTJimDnIwNKL7DQ==
X-CSE-MsgGUID: 3BwFLlMLTkywxR016Ypzmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="34004994"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.136.172]) ([10.245.136.172])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 04:05:31 -0700
Message-ID: <8ae42170-060d-4f35-a79b-18110e9477ff@linux.intel.com>
Date: Thu, 9 May 2024 14:05:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/1] net: e1000e & ixgbe: Remove
 PCI_HEADER_TYPE_MFD duplicates
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423144100.76522-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240423144100.76522-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/23/2024 17:40, Ilpo Järvinen wrote:
> PCI_HEADER_TYPE_MULTIFUNC is define by e1000e and ixgbe and both are
> unused. There is already PCI_HEADER_TYPE_MFD in pci_regs.h anyway which
> should be used instead so remove the duplicated defines of it.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/defines.h   | 2 --
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 -
>   2 files changed, 3 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

