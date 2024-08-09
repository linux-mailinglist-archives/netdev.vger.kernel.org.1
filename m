Return-Path: <netdev+bounces-117249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6962794D4D7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 18:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E965EB21543
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243551C6A5;
	Fri,  9 Aug 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq5P3Oxa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41C1CA94;
	Fri,  9 Aug 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221545; cv=none; b=R0kr3GPHuk2orYg7+OTwVDlqkG2ohHROSnpb6lEBryRYSsVRREBSKnwQTgK6CwZWKlZzoytRx82aLluTvWwsAWxQ2r66iy1dzTYRcaPzuETWROcJzmtjlLxYP1u86h2FZniKpmH86/zueTsNDSqWNE0A5mvlzT2ZnzQ7z9t6sI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221545; c=relaxed/simple;
	bh=DYzuCPdoyOkh7yU5ZV53ubQ5DiZzTv7NNppITDFVMSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PHFThJRYJx3nyokM1K2FZTxiHZvrRl6h0EZSwftzLpF2+bBSOKf8eTkP5eTsLRxsrCaurL7UJknVh9TmCfdQd0wuNcpXb4TFPBocl0+J4QrkOLvxDTCa21K+G1YYo/NeYpSZGxT9WXXE8kyT0RF3Hq/GSrDQcK3k3HeErJJn3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq5P3Oxa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723221540; x=1754757540;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DYzuCPdoyOkh7yU5ZV53ubQ5DiZzTv7NNppITDFVMSQ=;
  b=Uq5P3OxaPTUQOHVTpH27MsAOUwF8E72Rya26VOsWBH3fWlhPzpqFzB+c
   tLqTock8a0RAYTeJxKoha/0AIsiO5/49aB8NzsCtRJ4CQ4MJ+GooM8CIn
   dOR29CWjdW5PRDj1su0UMbX8pH2eS7gGVK4XKZyIZ/20w2YnGLltLJIiz
   su+Pd7J14l/OY7PQMXOOfgtyHaBoVirExa6tCs54aNrXSGWGRzVSuzxlS
   NbIx++UxsgejTxXOZk1pkNFLuJBQNHKKvM9G2AlP6wQlUWZ+VW1tWCfap
   NrN1pw4aub0FsRY2idTmUkhyCAm5xznLxz0RysGi7LVRM3/v1iZPsGZcU
   Q==;
X-CSE-ConnectionGUID: jxvaxB2AR2ClQ8yr4i2UwA==
X-CSE-MsgGUID: vm1U2BpNR1OaVgCb4IlBOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="24305303"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24305303"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 09:39:00 -0700
X-CSE-ConnectionGUID: tLOrSCFdRauODjLbCnpZfg==
X-CSE-MsgGUID: wuAx09PISS6NT9TXeaW3qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57696321"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.140])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 09:38:59 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Daiwei Li <daiweili@gmail.com>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, jeffrey.t.kirsher@intel.com,
 jesse.brandeburg@intel.com, kuba@kernel.org, kurt@linutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, sasha.neftin@intel.com
Subject: Re: [Intel-wired-lan] [iwl-net v2 2/2] igb: Fix missing time sync
 events
In-Reply-To: <CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com>
References: <CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com>
Date: Fri, 09 Aug 2024 09:38:58 -0700
Message-ID: <87y155wt0d.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daiwei Li <daiweili@gmail.com> writes:

> Hi,
>
> It appears this change breaks PTP on the 82580 controller, as ptp4l reports:
>
>> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
>> increasing kworker priority may correct this issue, but a driver bug likely
>> causes it
>
> The 82580 controller has a hardware bug in which reading TSICR doesn't clear
> it. See this thread
> https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/ where the
> bug was confirmed by an Intel employee. Any chance we could add back the ack
> for 82580 specifically? Thanks!

Of course, I'll prepare a patch for that. 

Thanks for digging that one up.


Cheers,
-- 
Vinicius

