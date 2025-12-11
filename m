Return-Path: <netdev+bounces-244313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E2FCB47AB
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 02:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FB33019B55
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 01:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7B26D4C3;
	Thu, 11 Dec 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZUOU5aqS"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EF1A23AC
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765417783; cv=none; b=EtipcXQK720I57jy8b8aaCnvRKllowwMuHZlG5dP+pEZ8YLVOQaG6vHNXTqhuNWmM64qGfHsmGqc7sWGUpurtjPIvtiY/GRZLJHWMHGhR9YxUqw8Ukw2ef1KgQ3edHRZFKaSaBQSLy7zkMGfptSXdW4C72Xjpk7Ul9Vl4HV2ZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765417783; c=relaxed/simple;
	bh=VqGQEDgjbA0A+QCKfXCIOxxF2hNvwx24HalYTrVhZrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4eW4zkW7B4tBS/9cwwfduSLBpiy0bRpm5LbfH3QLS66lr8UeaG82EcMBtCqvXR2zYBioWt2fOGhFlx0MoG0tDVwcMaG6F4wkySyHXshfjq/Cxwjk/bdFu2S3l2BPdBYgeesH21iKZZiv4z9RjTlppAKDn8+rrB/KTP3OmcejJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZUOU5aqS; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765417779; x=1796953779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4VxzSH0RAxFjh1KUG5Gw6TQgRgK6WCjPPkz2uzUjmP0=;
  b=ZUOU5aqSIW0D9vxwloTGmZbMipafSwEWviSXMwEawO7KmH7wqjrsjLMg
   WVlnE/6/RapwYENV0LglHLfagfldkvMKpAjGOC2ysVs+3CjJ7pQeNRy0+
   ga49dNFlR1l4OH478ZA1zqNcMqHLBSz4OgIyFjOujEXT4OsZAfPWyLkyO
   S5ZR76XUAgK0GlmXVChvTb8x0YtG7AjO2zSBXRWYk0upo1da979xSC32f
   GN7qtTuR2ALL/+RC5WD/oTMDF/IQkRoDBG7WYVKtQqyd63xVy3jtozZi4
   Ewt+xsLyaiSG0NWY9ry7H8Z/c8yf7A2l7CTyledRSLVD4ty30nMhLClFW
   g==;
X-CSE-ConnectionGUID: AlqyqGCvTNGjLzgJ5p1wPQ==
X-CSE-MsgGUID: hQMlOTd2RWWSEp4evTiX0Q==
X-IronPort-AV: E=Sophos;i="6.20,265,1758585600"; 
   d="scan'208";a="8665825"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 01:49:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:19808]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.136:2525] with esmtp (Farcaster)
 id e55c749a-dfbb-454e-9305-146680b85105; Thu, 11 Dec 2025 01:49:35 +0000 (UTC)
X-Farcaster-Flow-ID: e55c749a-dfbb-454e-9305-146680b85105
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 01:49:35 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 01:49:33 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <jacob.e.keller@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<horms@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<jedrzej.jagielski@intel.com>, <kohei.enju@gmail.com>, <kuba@kernel.org>,
	<mateusz.polchlopek@intel.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<stefan.wegrzyn@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: fix memory leaks in ixgbe_recovery_probe()
Date: Thu, 11 Dec 2025 10:49:24 +0900
Message-ID: <20251211014925.64457-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b5787c94-2ad0-4519-9cdb-5e82acfebe05@intel.com>
References: <b5787c94-2ad0-4519-9cdb-5e82acfebe05@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 8 Dec 2025 17:14:28 -0800, Jacob Keller wrote:

> 
> 
>On 12/8/2025 9:06 AM, Simon Horman wrote:
>> On Sun, Dec 07, 2025 at 12:51:27AM +0900, Kohei Enju wrote:
>>> ixgbe_recovery_probe() does not free the following resources in its
>>> error path, unlike ixgbe_probe():
>>> - adapter->io_addr
>>> - adapter->jump_tables[0]
>>> - adapter->mac_table
>>> - adapter->rss_key
>>> - adapter->af_xdp_zc_qps
>>>
>>> The leaked MMIO region can be observed in /proc/vmallocinfo, and the
>>> remaining leaks are reported by kmemleak.
>>>
>>> Free these allocations and unmap the MMIO region on failure to avoid the
>>> leaks.
>>>
>>> Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
>>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
>> 
>> Hi,
>> 
>> It seems that ixgbe_recovery_probe()  is only called from ixgbe_probe().
>> And that ixgbe_probe() already has an unwind ladder for these resources.
>> So I would suggest using that rather than replicating it
>> in ixgbe_recovery_probe. That is, have ixgbe_probe() unwind when
>> ixgbe_recovery_probe returns an error.
>
>Right. If resources are allocated by ixgbe_probe() they should be freed
>in ixgbe_probe() and not in ixgbe_recovery_probe() which is a smaller
>function called by ixgbe_probe() to enter recovery mode where only
>devlink flash update is enabled.
>
>It looks like most of these resources are allocated by probe and then
>ixgbe_recovery_probe() is called, which should instead let regular probe
>do cleanup for stuff it didn't setup itself.

That makes sense. I'll revise the patch and work on v2.

>
>> 
>> Also, maybe I'm wrong, but it seems that hw->aci.lock
>> is initialised more than once if ixgbe_recovery_probe() is called.
>> 
>
>Its initialized in ixgbe_sw_init, which is called before the
>ixgbe_recovery_probe, so yes that does look like a double initialization.

Good catch, I overlooked that. I'll address that as well.

Thank you for taking a look, Simon and Jacob.

