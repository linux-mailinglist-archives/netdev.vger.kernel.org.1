Return-Path: <netdev+bounces-183084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A1CA8AD4C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FB3160A7B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29E81DDC08;
	Wed, 16 Apr 2025 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G4aYUmGD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232552C859;
	Wed, 16 Apr 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765400; cv=none; b=oWo+dNLV2yxS2p2uWcHNZGU1zfjjqkf7iDfE7GwySdq/MbUQ1CGcUegNhFT6sTp3GrbkHRY2sykzKtMJ1Us9V2qX/08K6r2VyIy/W3iCVntD0m8VilHqtIIFb+p6blWuaU6e8MKYl5h9AvEhERy/1olBjBSmeqrKlOaAN0frSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765400; c=relaxed/simple;
	bh=RvIvw1baOtKFUbdj/r8jXJMMMvL9X954wdybrDaTzm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/u8q9cYj+1BSeGPN9eduV25jsn8EdZf+kXeZ2QJrhyoZL4ulz6V3wYMkfqfJYqK4Jz9HkeLbIcKofRxKLHDZVzAnTBPo5VhuvChz3YHY/4F0yDXcu/VQzT+Ua5sljAcUIsOSrsn6tPeBAFgjLXJADPmwRKimsuV3MTb20mp1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G4aYUmGD; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744765399; x=1776301399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GGnNNXM1Px+CfW0IznRviikPq3m3ytR6/Sbfff9L1uQ=;
  b=G4aYUmGDXbZyu4CcO+TqI3i84kjzskL81xySzl0e55flXAzFm0h95xVl
   UJ+UW2WPt9N7nLbmMn/Mpw8TfDW4pkBFrawq/aauJN9MhRUbFogloI/Cz
   0XhBSD+QL7TRKhE5598m3GFe0MAfgYGtusr3zo+lM0ZHmx/nZXYPPpzTQ
   I=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="480740641"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:03:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:45153]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 1401027b-4679-4367-833c-9f46bb5bcbbe; Wed, 16 Apr 2025 01:03:15 +0000 (UTC)
X-Farcaster-Flow-ID: 1401027b-4679-4367-833c-9f46bb5bcbbe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 01:03:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 01:03:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/8] ipv4: Use nlmsg_payload in fib_frontend file
Date: Tue, 15 Apr 2025 18:03:01 -0700
Message-ID: <20250416010302.23388-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415-nlmsg_v2-v1-5-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-5-a1c75d493fd7@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:56 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

