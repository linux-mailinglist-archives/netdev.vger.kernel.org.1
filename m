Return-Path: <netdev+bounces-164539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6A3A2E1EE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD243A2087
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93AEAC7;
	Mon, 10 Feb 2025 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A+mgk3Gl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651920330
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150294; cv=none; b=TmvEdJrAZpN+S3UhvnDBfyfPMpcIm+qILoDNv/6b/gRde4Jh8ca2XUIY9oJi+Leqm/JqKacmp3oSAtqk4daySoy1kyOofJlJbBDXzYghVeyOg4HiaZvM0R4WcpFbyIA4sb9F7rU7jfs23CZF2Jog8g2gc4ItbNvXV2vpRhmXZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150294; c=relaxed/simple;
	bh=uFuCAfIND3zpRSt7B3aPUozoeLtYA7ml0/ZpTAnUSbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umgoTicp5pOfZ0jwzBdRm6bAlm8W7n/K1i2Wra6SFO3z6/H5GTNsRw45zZn63ix/MLTtJUUQjO4CiXZ474zA/ZHXh70OKSuIH4D41GBq06KdOwFmn3kqx4BVGrQ9Ih4o8BV6nUd7KaQlWkJbcGczt+kOb3e8RVDw/TkAzECxw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A+mgk3Gl; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739150294; x=1770686294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yGE9/AGPy0waE6nSWVvEH29/cuHtMntq3u2XuHtP9hc=;
  b=A+mgk3GlIykVBKNcaqj5SIQUCRvBWNmsu6iGwcy1Q6xlLGGMMXvmGHkq
   3jum6beHQj7O/MjH/85alNOoG6lazMpPLIs+lsKRgkSoxZIKjx3B0s3ja
   X9qAZ/c0NLOEU13ofz8jheyMt8B6XSfgAlz4nUCmRT67gkhxcYdfuwkcv
   E=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="375881792"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:18:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:6108]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.41:2525] with esmtp (Farcaster)
 id 1ddf712b-987d-4c93-b4e1-6eeec048301a; Mon, 10 Feb 2025 01:18:10 +0000 (UTC)
X-Farcaster-Flow-ID: 1ddf712b-987d-4c93-b4e1-6eeec048301a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 01:18:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 01:18:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 4/8] arp: use RCU protection in arp_xmit()
Date: Mon, 10 Feb 2025 10:17:55 +0900
Message-ID: <20250210011755.55018-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207135841.1948589-5-edumazet@google.com>
References: <20250207135841.1948589-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 13:58:36 +0000
> arp_xmit() can be called without RTNL or RCU protection.
> 
> Use RCU protection to avoid potential UAF.
> 
> Fixes: 29a26a568038 ("netfilter: Pass struct net into the netfilter hooks")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

