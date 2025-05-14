Return-Path: <netdev+bounces-190482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C3AB6EAB
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173131BA007D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703BE1A4F2F;
	Wed, 14 May 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bg9c+DTA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141819D8BC
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234754; cv=none; b=sFKf2qZ0Rv81otSXmyQ1wCRy4GwHv28y3gQ326SQcSTuzayopZ9ZvTlwJqPY/1JsPb/d7Kov6u0bdTiDcFiE2njOMbsf3taiyLuE+whJhzwMC2OVuagzTSS7S5CujrmRP6UhYVwPXyzRKu5Bu1hteYTurPz6AzEl/tlYZ6m9wXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234754; c=relaxed/simple;
	bh=kbziLFqjvomaxCMK7L5MaRFAB9qQAYvjsqLOw928AQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCSv/OLP+PcIsG0ZQlVhgU5/We9wMeWWSYlbrgS4Fz/DrwVzltjTxAOBMz5//bMlm9okFTPjUCbZiKpjFImnnOTF7xkldiI8Nh12wuRDCTsqdeAzQkcaImmieerDeqJMDCYPcsRDBa0aG07P2+kE5LdUNMvlGNqRaHWVH0+0PfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bg9c+DTA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747234753; x=1778770753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kbziLFqjvomaxCMK7L5MaRFAB9qQAYvjsqLOw928AQI=;
  b=bg9c+DTA8jsfG8lZFDV7UNkxsvW57li01EQvSKxQbXw0M1mlme1f7QLc
   BMjE+B8JPZZNtYUUU1PvNVx8lsSkQ0aKjehmXaXtJ7OQD1n8P7UjOsDkz
   GHbOmfewwxO2to1iopJAoLd+MFHKMJVFl796BjVGsUGCKw5bghic6jffQ
   r3/eLTpz9WiqJIgy8kcin6GXx973DBv13DXvwv3wRA3Z4hwGSAXzmN8qe
   R3ySf5ZkI9lFOxCwk+jievgTfzyfEayc0EOhQexVWPzkMl3A0Pe+JgAOy
   EMVQO0QS4vEJn3/RGYk6bfy9uHu+R4IfmYiFgU5FhpeCs3LbcDxGpZRqR
   Q==;
X-CSE-ConnectionGUID: Jr1cD3yySTCTS8haRBRzQw==
X-CSE-MsgGUID: S9mWP6B0Tkm2SjIBuTqhpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="71640145"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="71640145"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 07:59:13 -0700
X-CSE-ConnectionGUID: qtP4kUF7ScKkIuveXevfkw==
X-CSE-MsgGUID: MSpGtGrNRsiJztXAvqXctQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="137776202"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.96.13]) ([10.245.96.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 07:59:11 -0700
Message-ID: <8314acf3-642b-4e39-8cbc-e6e15d7a3741@linux.intel.com>
Date: Wed, 14 May 2025 16:59:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 0/2] Add link_down_events counters to ixgbe
 and ice drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250512090515.1244601-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250512172146.2f06e09f@kernel.org>
 <3b333c97-4bdd-4238-bfab-b0f137e5b869@linux.intel.com>
 <20250514074203.31b07788@kernel.org>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20250514074203.31b07788@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/14/2025 4:42 PM, Jakub Kicinski wrote:
> On Wed, 14 May 2025 15:44:49 +0200 Szapar-Mudlaw, Martyna wrote:
>> The link-down events counter increments upon actual physical link-down
>> events, doesn't increment when user performs a simple down/up of the
>> interface.
>>
>> However there is indeed link down event from firmware - as
>> part of interface reinitialization eg. when attaching XDP program,
>> reconfiguring channels and setting interface priv-flags.
> 
> Maybe I'm misunderstanding, but are you saying that the link-down
> counter doesn't increment on ifdown+ifup but it does increment
> when attaching an XDP prog?
> 
> The definition of link_down_events is pretty simple - (plus minus
> the quantum world of signals) the link_down_events is physical link
> downs which the switch / remote end will also see. Unlike software
> carrier off which may just configure the MAC or the NIC pipeline to
> drop but the PHY stays connected / trained / synchronized.
> 

Agree. I said that it increments when physical link gets down and not 
eg. when user performs ip link set dev eth down.
So this implementation of link_down_events counter is consistent with 
the definition you provided.

Regards,
Martyna

