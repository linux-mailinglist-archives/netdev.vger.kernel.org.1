Return-Path: <netdev+bounces-231518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7EBF9DB4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FD819C66AF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDE525B30E;
	Wed, 22 Oct 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="s8DIafBU"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0072D0607;
	Wed, 22 Oct 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104469; cv=none; b=jeeDtLblbM/aSJxFqFOunMDRyqnGFYHj14HaWKPZ97Pqu3Rd12J6jk639kHoq/UmsECUzwuUBkEqnPf/GqHUZI3vvJBVvJoGvn1sWYj7p96aD8We7gyuXLntmRtj7oqysB8qaEL/JW3gMIphkoDQXzivZYR5N9Um2VGIhEKltfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104469; c=relaxed/simple;
	bh=A4BYLRN069n/J1l2nN3miEA/LK2NvhnR3VjqVbVTln8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJkqdjRdXl857rQPx7dCaYO/VOoBHxp16MvmdLZQ8aFi8QkCZaqco7WXZCgF726MqMlzmwYo3W0Wp0Y/MFOHqQBZ1wGmqudG3VBthmClwuTa6eaTUYsnGEUjjSUHL46hUo8iSdLSdHKyexYcGqCRXA8omBDZsjFjU6tbL4BfVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=s8DIafBU; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761104465; x=1792640465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/BEU5aCOpTur4Q/ZQAqGm2S/L4I8jlo2kZlqzDsSpk8=;
  b=s8DIafBUZTRuVuTxkJS3Z8On760tsEqNqakme3d6z1q/2RvGE1+41Yzp
   khNz4m0uofXOKKBonYEmkordNneS8mhYjRTmcW+weT9YDw7NbCcuWMDVk
   m8L81fvBPfwv8fnl0NdzPMhJlNh539eG2ofto6GgcN3c8IJ3hWjMs+XMj
   bHKB3IJVilsSAdXknO8gCZ8ecVXxrHQF4A2Kr3J/RxxQ88DPsZdvAKmek
   2zAWr70hLgFr9secGS3jgko647AOR/yfYdqOoer1363eGDFcfn/jS6/UM
   T6hMrWyOWskJaGuxB7SSs3nuunIy4a7cS5BzItP16Wz5A97PUCmGL8ZZD
   Q==;
X-CSE-ConnectionGUID: 6PbBDKI2SA26RTx/HsoNAw==
X-CSE-MsgGUID: SuArwaCtSfy62j3sCDdYIQ==
X-IronPort-AV: E=Sophos;i="6.19,246,1754956800"; 
   d="scan'208";a="5329617"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 03:41:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:3455]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.150:2525] with esmtp (Farcaster)
 id 9bc5e0ec-1eec-40a5-8377-6626e9985264; Wed, 22 Oct 2025 03:41:03 +0000 (UTC)
X-Farcaster-Flow-ID: 9bc5e0ec-1eec-40a5-8377-6626e9985264
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 22 Oct 2025 03:41:02 +0000
Received: from b0be8375a521.amazon.com (10.37.244.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 22 Oct 2025 03:40:59 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <kuba@kernel.org>
CC: <aleksander.lobakin@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <enjuk@amazon.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next v2 13/14] ixgbe: preserve RSS indirection table across admin down/up
Date: Wed, 22 Oct 2025 12:40:45 +0900
Message-ID: <20251022034051.28052-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251021161006.47e42133@kernel.org>
References: <20251021161006.47e42133@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, 21 Oct 2025 16:10:06 -0700, Jakub Kicinski wrote:

>On Tue, 21 Oct 2025 12:59:34 +0900 Kohei Enju wrote:
>> For example, consider a scenario where the queue count is 8 with user
>> configuration containing values from 0 to 7. When queue count changes
>> from 8 to 4 and we skip the reinitialization in this scenario, entries
>> pointing to queues 4-7 become invalid. The same issue applies when the
>> RETA table size changes.
>
>Core should reject this. See ethtool_check_max_channel()

Indeed, you're right that the situation above will be rejected. I missed
it.

BTW, I think reinitializing the RETA table when queue count changes or
RETA table size changes is reasonable for predictability and safety.
Does this approach make sense to you?

>
>> Furthermore, IIUC, adding netif_is_rxfh_configured() to the current
>> condition wouldn't provide additional benefit. When parameters remain
>> unchanged, regardless of netif_is_rxfh_configured(), we already preserve
>> the RETA entries which might be user-configured or default values, 
>
>User may decide to "isolate" (take out of RSS) a lower queue,
>to configure it for AF_XDP or other form of zero-copy. Install
>explicit rules to direct traffic to that queue. If you reset
>the RSS table random traffic will get stranded in the ZC queue
>(== dropped).
>

You're correct about the ZC queue scenario. The original implementation
(before this patch) would indeed cause this problem by unconditionally
reinitializing.

I believe this patch addresses that issue - it preserves the user
configuration since neither queue count nor RETA table size changes in
that case. If I'm misunderstanding your scenario, please let me know.

I could update the logic to explicitly check netif_is_rxfh_configured()
as in [1], though the actual behavior would be the same as [2] since
the default RETA table is a deterministic function of (rss_indices,
reta_entries):

[1] Check user configuration explicitly:
    if (!netif_is_rxfh_configured(adapter->netdev) ||
        adapter->last_rss_indices != rss_i ||
        adapter->last_reta_entries != reta_entries) {
        // reinitialize
    }

[2] Current patch:
    if (adapter->last_rss_indices != rss_i ||
        adapter->last_reta_entries != reta_entries) {
        // reinitialize
    }

Do you have any preference between these approaches, or would you
recommend a different solution?

