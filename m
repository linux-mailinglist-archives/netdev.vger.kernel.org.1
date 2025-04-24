Return-Path: <netdev+bounces-185774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7806DA9BB28
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052185A8630
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E819F471;
	Thu, 24 Apr 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U7eUBaAl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CBA93D
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536689; cv=none; b=BDifn3euojmms3AtTSvD5uup5eusBdTDwe4rs/j6D1kI+GsrjHOMKA7ZVc7I0osJyg4Oxa5doffaE3PXXjoDxAJspBE2bX2HFEpii6GzyT76wuIIzc5x6D1j0QVLUGoB3UHs+DEC9f2qaVxWAN/PE6EJFjeqoQYEbO7lyeS3lcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536689; c=relaxed/simple;
	bh=tmcda9vC81UtQRnQA5lfd+X5HHflviesw2IqNzYnfTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9R6ty1AaC9oS+zL6fIp2g3sNLHoBfbh3fqT01tUC0BqCgRBrsgg8PTBNzOxEE5IAAcVb8T+tVsUlWd8vhgNDgUSITwmLeEyJS4J8GTdP1GCqjZ3UXsCjTpsS/J67suB8sxJ0e9LzRNnA2RGvFwgUlLZQafzMDD/nzBaKby2/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U7eUBaAl; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745536688; x=1777072688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y7ta/nXFDp9UXPR6M/JInf5lbTNvGS6f3CMoq7qIsIw=;
  b=U7eUBaAlmSlM7MfSDctnJuB22uaCTEDlYoMomxi1dajxPUj1Pn0hivUu
   y3w7Fvv2gm3Fn4bQvJlbQFXr3GUNsD7iMfpWL8Ub9I6IbHIai2xpoOQYS
   0ACFlPQVWhQ9XlASciArvkPYxoAvCmyLiScLam5sFanSZVgUlN4ULt6SX
   k=;
X-IronPort-AV: E=Sophos;i="6.15,237,1739836800"; 
   d="scan'208";a="818889871"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 23:18:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:39192]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.20:2525] with esmtp (Farcaster)
 id b5e0478f-98c1-40c8-b8dd-5f817d1ad260; Thu, 24 Apr 2025 23:18:01 +0000 (UTC)
X-Farcaster-Flow-ID: b5e0478f-98c1-40c8-b8dd-5f817d1ad260
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Apr 2025 23:18:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Apr 2025 23:17:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 5/7] neighbour: Convert RTM_GETNEIGH to RCU.
Date: Thu, 24 Apr 2025 16:17:09 -0700
Message-ID: <20250424231750.71572-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c06f9032-4b9f-483b-8d72-0c70f39a398c@redhat.com>
References: <c06f9032-4b9f-483b-8d72-0c70f39a398c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 24 Apr 2025 10:31:44 +0200
> On 4/18/25 3:26 AM, Kuniyuki Iwashima wrote:
> > Only __dev_get_by_index() is the RTNL dependant in neigh_get().
> 
> Very minor nit catched by checkpatch and only noted because I think the
> series needs a new revision for other reasons. Typo above: 'dependent'

Rather I thought dependant was the correct spell, and after noticing
the checkpatch warning and googling, it turned out to be one of
flavo"u"r, so I'll post a patch for checkpatch :)

