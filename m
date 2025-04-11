Return-Path: <netdev+bounces-181820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B7A86843
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB1B176E4D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357529AB00;
	Fri, 11 Apr 2025 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tvSNcXdi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475FC28FFE2;
	Fri, 11 Apr 2025 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406912; cv=none; b=DPUBCD+A+81+aBeR7JxCZacENTQQH2q9DFB7dnqfHvfhF41M+u6n5ecHMbQOWxlam4FxX93ecUKeJjjUQV4wswJCLtMQZR8JCRF1NPLaw61O2303ZEFzqNpTEHEugRy6Y5+ffZCaBHmTZ0/yIqTRoJCkCXmWEvSAVOPKS3JHwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406912; c=relaxed/simple;
	bh=cFW2yYAA0FN67SvLMeGgVbeaB0vRsVUAJB7MDE131T8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hj45KJnGt5faUikkNMtnrSaImQiFPvNMMDkiFR7I4GxzFTkbwQiWLCnGPvBAqOpHT4pkldNygQN7pQMBvWDv6vC4Ii4I7a52P50fQOWKE965mLQ0ZVKJtALmkf4sGVNlXy5trwb4epCrlQ0TeDNXGCEJ9zZV2zwexxryKRVYY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tvSNcXdi; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744406911; x=1775942911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4a7L8Ao6vOpZW7f2KqbrIzNDiT6LjYYirpPpRyNT5Ko=;
  b=tvSNcXdihZ97gC50waWZkXDOY7nmcEhOIDBOR0kK79htReZykXi5RyPK
   QwyDthHyZIPaR4EiIgNbst3tvSQXu/xDkzvEHcSM9x253TCFU+U/CD5Ma
   yQQbzE0uPMxFztF6VH6aBRQtk9rPa2DZzUhUfe8IiqmmyKh96hCy5aWKI
   I=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="186724816"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 21:28:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:62036]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 19469ef6-c0a2-4afe-ba64-67e450d6ccd4; Fri, 11 Apr 2025 21:28:28 +0000 (UTC)
X-Farcaster-Flow-ID: 19469ef6-c0a2-4afe-ba64-67e450d6ccd4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:28:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:28:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 5/9] mpls: Use nlmsg_payload in mpls_valid_fib_dump_req
Date: Fri, 11 Apr 2025 14:28:12 -0700
Message-ID: <20250411212813.68342-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411-nlmsg-v1-5-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-5-ddd4e065cb15@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:52 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

