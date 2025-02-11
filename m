Return-Path: <netdev+bounces-165007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D14A2FFED
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CBA18836D4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A22BD11;
	Tue, 11 Feb 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TXOta40J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E531805E;
	Tue, 11 Feb 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236188; cv=none; b=Uxh088xA9V3wxXdNeTNTDZ2GB1VfM17tgr4bTxSC7n971k5Zu+T+39cVOCbuA8B2Rrs9g29diDGegNBrKGhUnyjioZTFlTwy06Ncv6F0TEhXaVyv3YJnOmcXTGW9GKWB+OjShgZVLRVOVInxhgyaHdPbQxfMjx3rO2JKnwXitU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236188; c=relaxed/simple;
	bh=6Idg8uJ9iPDpsfQccDDDicevNwmyMCS8+ONKoz3yRB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gk6g1PXEjzF5ptGVjkk86Z46xpnoo0Oj7sxFNbIQLp3/Jl51WyY7KL/7rWgezvE0of2aovYx9o9lOeu/KJNju23rB05Dua0hn44Qgd760SIfXr4BzuoiWYZzfJ9CZMvMqI8hoXvndupUr+76Ll5SvoMPTjvAsszQBOOWpGKk19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TXOta40J; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739236187; x=1770772187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlwViKvkK8zcGDuf7UucAahjqpx6kwc7K2f51BR+Ko8=;
  b=TXOta40JgDChxQFyF+JT8MkbeAj0R1FItBk9GijzgWyBxKLxgPtp8CGy
   mUOZSQqoBhWGJ85PpFuneh2xvoozhhjyKiwltLCwH9vsSEjNjYk2L8JI7
   wn+W4iQj+khTO+gZ9xdXL5QESmWm1WWdf/BZK8K9oT28LnoLRWDt1cyl0
   k=;
X-IronPort-AV: E=Sophos;i="6.13,276,1732579200"; 
   d="scan'208";a="717705807"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:09:42 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:57671]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525] with esmtp (Farcaster)
 id dfd31b59-b323-4be3-91e5-ad497774b6bf; Tue, 11 Feb 2025 01:09:41 +0000 (UTC)
X-Farcaster-Flow-ID: dfd31b59-b323-4be3-91e5-ad497774b6bf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 01:09:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 01:09:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kernel-team@meta.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net-next v2 0/2] net: core: improvements to device lookup by hardware address.
Date: Tue, 11 Feb 2025 10:09:27 +0900
Message-ID: <20250211010927.86214-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
References: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Mon, 10 Feb 2025 03:56:12 -0800
> The first patch adds a new dev_getbyhwaddr() helper function for

nit: second

> finding devices by hardware address when the RTNL lock is held. This
> prevents PROVE_LOCKING warnings that occurred when RTNL was held but the

Same comment for patch 2, this itself doens't fix the warning.
Also, patch 2 & 3 should be net.git materials ?  Maybe squash
the two and add a Fixes tag then.


> RCU read lock wasn't. The common address comparison logic is extracted
> into dev_comp_addr() to avoid code duplication.
> 
> The second patch adds missing documentation for the return value of

nit: first


> dev_getbyhwaddr_rcu(), fixing a warning reported by NIPA. The kdoc
> comment now properly specifies that the function returns either a
> pointer to net_device or NULL when no matching device is found.

