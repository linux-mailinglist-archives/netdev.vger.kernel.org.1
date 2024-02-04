Return-Path: <netdev+bounces-68909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC13848CED
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB9A1F21EAC
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ADE1B7FE;
	Sun,  4 Feb 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixhvbhIk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F034210E9
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043236; cv=none; b=JPCtRY4gZHWTZ9nnKsqnMK1utDskMyCGeFSf//M2iQf+lcEhM6O3/VbZHXDdOsRDAfKRapSd528oCVcwE3vvUqNarBBlxI8AKpYA9wEMrY69UbLIIdd33bYRnswbiqkAhe7jmlW6oJ7Qb/Z6cEq4CYFsTS5ukqnN1sScKlWEEEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043236; c=relaxed/simple;
	bh=4d9QESwx22QVYlhgB35XOXUK5cV0Z6Y9I0alC09oJRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbJkWqWh7JjPE6pPPg6wEZuAN629JX8ddM+XtZX9dzaAdpnJZU/01SKm/SXGrWBGuVTLqjLdJZJ+bn7pn+QtOsli3YdU2OUo17//g9/tm/iLfhdAlh7gteDzvKoYDHhVPNggT4gMnEZCEgqZXEc01QoEPfonVTACPS4bFAyqoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixhvbhIk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707043235; x=1738579235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4d9QESwx22QVYlhgB35XOXUK5cV0Z6Y9I0alC09oJRw=;
  b=ixhvbhIkqUl0gSz4tp6UkJB3e65r8usUw1nuTfXgwrthuCl8pc8xPRTs
   Y4gyFGW2RlnCPrDCAdqQBWYmLHaI6LayIeaeYHiLrcPKU4yN+xSFKxWX3
   FDZE3/s0hEYF8bmQKZwfkzROWPIfo351u0tWRJJbJRg+t2szyN5zVbPFS
   qKdf0a7PBVjoqdS6G5Hxy7VPJabZ7xEpNa7MECSZ/H6wcLyzlebnPqxej
   ECJGEm8c4FPr+rNpg8cbHmeuyiFKiJVl70BR107Ek9oKQFdQ+ED3Zq/o3
   lcBFwsjKXIKfmhU8KPum5uZpbuABfjgEUxRMLNa3G7xQ7prlhojnSczTL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="625536"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="625536"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 02:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="932908028"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="932908028"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.124.132.248]) ([10.124.132.248])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 02:40:31 -0800
Message-ID: <4efdd7c2-8824-41e7-a556-1f0e944faa87@linux.intel.com>
Date: Sun, 4 Feb 2024 12:40:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/3] igc: Use reverse xmas
 tree
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-2-kurt@linutronix.de>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240124085532.58841-2-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/2024 10:55, Kurt Kanzenbach wrote:
> Use reverse xmas tree coding style convention in igc_add_flex_filter().
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

