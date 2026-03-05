Return-Path: <netdev+bounces-264233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAaWMyZJqWlZ3wAAu9opvQ
	(envelope-from <netdev+bounces-264233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:13:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E920E12E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3283153EE4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCD376BCC;
	Thu,  5 Mar 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMYy5MEc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0E30FC26
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701578; cv=none; b=imt8/TjYaV9NaXPRgrcG/0b3xonbDO9Vdqm/gMOqbhebLT3iPRhwOFsp+3Q8RqB7F8qf38hrM+gBvRb6CobcuymVPVoRi85t2Yp0lNCfLP1rdAUlQ+lSFI1wX/Of4doAoL5eEpD8nEVbEC4B+zokTBc4x27GOSlKgYCj1iwxk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701578; c=relaxed/simple;
	bh=TPAo2N+ZE9bD65+PlCU4V9OBA/W1OYT3t5+awZA8BH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWyGKXExBREx7wp5iQU2nosW5yGUwBMU6l9mhfMU1tb/XN+xKmbB9T7Jo8wITRv6I7uNTI89Huiq8o1HA4JOpgWQOZHcMTjg4pAdajZmZjXRcMdgYn4u9pfNXRQ+EyARb4Wms2I7ekzGA+eWSRxwAtJ7/87EZAgSHg6mF/v/hEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMYy5MEc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772701578; x=1804237578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TPAo2N+ZE9bD65+PlCU4V9OBA/W1OYT3t5+awZA8BH4=;
  b=TMYy5MEcgCOISYEqZITzAkdE9100STbI3DhiFaE0nqrU6Mdkrf+kTVuT
   poCOZR+VJWeR8ZEV8gq+4+ppkZcSe6JU9EKVd27pTwoMnCzLB1PaWd2Gc
   C0hUgMdSVWOgIv24RLp5n51UZCa2MUzaFQEhdp5oRT0UE45BJGv52+rsq
   07UPc9W7k7RAM+GFnDVZxNBO3ytXx02cKHMgqpd+86weR7RG8JoyaFktK
   OkDnJIM5b/JyPPRL23PPl7+SWJTkj9UrG/L286ft+qCCXcF+6VOEus8Z+
   +e9yo9XcWWrdfmlXkVCZpL6K3fjqVMmG0DqZPHLToZ7x4HY6mlYnMThZG
   g==;
X-CSE-ConnectionGUID: 6oApGk8ZRGC6FmkHaKZXTg==
X-CSE-MsgGUID: AWm3KxQhTdG3EFV6vebaNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="91171129"
X-IronPort-AV: E=Sophos;i="6.23,325,1770624000"; 
   d="scan'208";a="91171129"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 01:06:17 -0800
X-CSE-ConnectionGUID: MBQ+cH/KT62XBVZD0W0Zxg==
X-CSE-MsgGUID: 0D1ncnbzQ9+WE6oMGFBtLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,325,1770624000"; 
   d="scan'208";a="245122572"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 05 Mar 2026 01:06:16 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9053895; Thu, 05 Mar 2026 10:06:14 +0100 (CET)
Date: Thu, 5 Mar 2026 10:06:14 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: =?utf-8?B?T2RkYmrDuHJu?= Kvalsund <oddbjorn.kvalsund@gmail.com>
Cc: netdev@vger.kernel.org, Mika Westerberg <westeri@kernel.org>
Subject: Re: thunderbolt_net performance and receive-side-scaling (RSS)
Message-ID: <20260305090614.GZ2275908@black.igk.intel.com>
References: <CAOhm4wpO9gB03qt0kPdEiZtKLD_UOuYx=VbQVWwyXmqS_0_ySA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOhm4wpO9gB03qt0kPdEiZtKLD_UOuYx=VbQVWwyXmqS_0_ySA@mail.gmail.com>
X-Rspamd-Queue-Id: 442E920E12E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264233-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

On Thu, Mar 05, 2026 at 09:56:26AM +0100, Oddbjørn Kvalsund wrote:
> Hi,
> 
> I am seeing fairly good network performance between a 2018 Dell XPS15 laptop
> and a 2021 MacBook using Thunderbolt and the thunderbolt_net driver, with jumbo
> frames enabled on both machines (iperf3 results below). However, while iperf3
> is running, one core on the XPS15 is at 100% utilization due to the ksoftirqd
> process. This makes me wonder whether additional performance could be achieved
> if the load were distributed across multiple cores.
> 
> From what I can tell, this might relate to receive-side scaling (RSS), which
> does not appear to be implemented in the thunderbolt_net driver. Would adding
> RSS support be worthwhile, or are there architectural limitations that would
> make such an optimization ineffective?

I'm not familiar with that but feel free to experiment and if you find that
it provides better throughput please provide patches :)

USB4NET spec can be downloaded from USB-IF, it's part of USB4 spec.

