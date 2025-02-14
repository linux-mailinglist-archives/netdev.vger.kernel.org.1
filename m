Return-Path: <netdev+bounces-166305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971FA3568D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663113AC878
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6660E16DC12;
	Fri, 14 Feb 2025 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L1zOALvi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2ED127E18;
	Fri, 14 Feb 2025 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739512198; cv=none; b=cjjo1WFvP+4QB9vlgaNQEd3yMUXujr2gjtQSosGUaeNGbV1cehEqs7woXO5cn1UJfEFy6zpEEAzdSrcwZAvB430e2IWzBGpPrspXVYYHnGWXM6R+DfYo94DDg0u0g6hDMmKojFHAB3oFaj32GB1pdEXCrCzTov8ztQNZqJCKcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739512198; c=relaxed/simple;
	bh=3jKyV18LFmgYLxpuucKcetXSHzqgvh9BdkLbMFvsvjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYSl1lmq6exLcUCw4qj6GGKtvB5Dmy8uzlJHJkC2rdTZwqIGoYP2PXA8gyp+bOku65iawEuWpPC/siUizR3CU9N0DTITJsBu5vyb591QzjnpEKLTu4WwcHVUgUpfm2YGpG6FsO5aY+svTSA60U3QYET1QhkYuq2Hbiq6u9fNamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L1zOALvi; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739512197; x=1771048197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwi3SYRz7OJYvCQ//NqHT2FoZqr7nOZd+Nwcc7+rJKI=;
  b=L1zOALviFrS3noxyqfQ2M2Cy0yeHhqzQDtq5spvUa3/gCQj36/tjhPhY
   Nvt2crMjy600hBPl5Zuy52ZrM6HXZsYs2GsSNEvyWSKljVpUjZjp+lTCp
   3w8DXTu7LHpNyQ6eV/SAps6M1uY24VaJzTmWvEvNjfyYyrZB9bCykq/2Y
   o=;
X-IronPort-AV: E=Sophos;i="6.13,284,1732579200"; 
   d="scan'208";a="271092905"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:49:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:19409]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.186:2525] with esmtp (Farcaster)
 id acd706fd-cf7a-4fe2-b1d2-eb82d5063ced; Fri, 14 Feb 2025 05:49:50 +0000 (UTC)
X-Farcaster-Flow-ID: acd706fd-cf7a-4fe2-b1d2-eb82d5063ced
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 05:49:49 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.254.117) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Feb 2025 05:49:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.co.jp>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net v4 1/2] net: Add non-RCU dev_getbyhwaddr() helper
Date: Fri, 14 Feb 2025 14:49:33 +0900
Message-ID: <20250214054933.62409-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213-arm_fix_selftest-v4-1-26714529a6cf@debian.org>
References: <20250213-arm_fix_selftest-v4-1-26714529a6cf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Feb 2025 04:42:37 -0800
> Add dedicated helper for finding devices by hardware address when
> holding rtnl_lock, similar to existing dev_getbyhwaddr_rcu(). This prevents
> PROVE_LOCKING warnings when rtnl_lock is held but RCU read lock is not.
> 
> Extract common address comparison logic into dev_comp_addr().
> 
> The context about this change could be found in the following
> discussion:
> 
> Link: https://lore.kernel.org/all/20250206-scarlet-ermine-of-improvement-1fcac5@leitao/
> 
> Cc: kuniyu@amazon.com
> Cc: ushankar@purestorage.com
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

