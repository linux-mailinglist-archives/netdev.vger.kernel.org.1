Return-Path: <netdev+bounces-53159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869E8017DE
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3942B20C2B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB93F8F5;
	Fri,  1 Dec 2023 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0TLtUKc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2998C1A6
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701474023; x=1733010023;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=N2QHQeCVetATgr97eJV3h1koAVFwko3Va4CAa0o1GgA=;
  b=n0TLtUKc5t37m92U40H9mVghtMu1DxqKpdQMSaaICKLwQ8/Q03hmQ43X
   SKdJTyOnl7DOVJqK9SeMdAVT984/WzYQQYLE0mDTmnoB14pf09gxbFCB0
   G2g07hndSMQmSLHj3qBb5B6wT8OAKQEGcj7Fwa1d3NvkJIGofj2wBZ7Zl
   ViGRRqI71XREnCf2D0BHowkksXftFCL3w7NsG53xRpEdK8qWvaNjNewd1
   kJVhYMQPn0O0L5YzfwO6wNRHl85wbUTGsrU8n8YxGao+OxGDBmQ5OeViG
   BUoA1T2XLqqIV2xKmdzB69MhyLKdOR7nMeuVv0pmyNuztQNo5+y2HJoUG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="415685"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="415685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 15:40:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="913732977"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="913732977"
Received: from ticela-or-229.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.44.160])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 15:40:22 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Ferenc Fejes <fejes@inf.elte.hu>, netdev <netdev@vger.kernel.org>
Cc: "anthony.l.nguyen" <anthony.l.nguyen@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, "Neftin, Sasha" <sasha.neftin@intel.com>
Subject: Re: BUG: igc: Unable to select 100 Mbps speed mode
In-Reply-To: <c40ebbf9c285b87fc64d6f10d2cdc8e07d29b8c6.camel@inf.elte.hu>
References: <c40ebbf9c285b87fc64d6f10d2cdc8e07d29b8c6.camel@inf.elte.hu>
Date: Fri, 01 Dec 2023 15:40:21 -0800
Message-ID: <87zfytv6e2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Ferenc Fejes <fejes@inf.elte.hu> writes:

> Hi!
>
> I upgraded from Ubuntu 23.04 to 23.10, the default Linux version
> changed from 6.2 to 6.5.
>
> We immediately noticed that we cannot set 100 Mbps mode on i225 with
> the new kernel.
>
> E.g.:
> sudo ethtool -s enp4s0 speed 100 duplex full
> dmesg:
> [   60.304330] igc 0000:03:00.0 enp3s0: NIC Link is Down
> [   62.582764] igc 0000:03:00.0 enp3s0: NIC Link is Up 2500 Mbps Full
> Duplex, Flow Control: RX/TX
>

I wonder if this patch fixes it, and it is still not available in your
distro:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e7684d29efdf37304c62bb337ea55b3428ca118e

> I just switched back to 6.2 and with that it works correctly.
>
> Sorry if this has already been addressed, after a quick search in the
> lore I cannot find anything related.
>

I think it was discussed here:

https://lore.kernel.org/all/20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com/

> Best,
> Ferenc
>


Cheers,
-- 
Vinicius

