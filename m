Return-Path: <netdev+bounces-181809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB5A86816
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366411BA2474
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3247290BD9;
	Fri, 11 Apr 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="no107ab6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFB28EA63;
	Fri, 11 Apr 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406400; cv=none; b=TvEgUXxiQ2rmNlqPePNFqzwJRrChcmrxpTQcaeSmHDe/3RWe28PjIrentNWx9La70eBjE97jLU9xHG0H1kiypu+T1C6poWg2+HP1/WWTCedn2pRRMjkSmqWxNrcwuXYc+MLcsLQBkTS5KiB54pzoA67kP2GaGs3U1B8iVIycw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406400; c=relaxed/simple;
	bh=owHBfoHj2681o4ExRPeNeCnZ5AZ6HnK7rZE38w1goao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e50H2iR2HVs/tMCSfAHMMbeTBsMxPLQhb4KNv5gPUJovBlqwfbP2Zg+X2uJ8cGHF+atnilvDavvaLoM2gRleOwHj01awamqO4FTZSuKaSS2iBWd8lDtTmk/CjKcdEaoW9ThieDTAoNIa68CiwmDiU8G5mSdDZt/w/K/QhQysaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=no107ab6; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744406399; x=1775942399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHcoMfBK8wmAFaZYd0OkQw5glemWFZU/vVnde6R0URc=;
  b=no107ab6gUVUGxDVr7IE+lgdZal8dI1zu+G0kHGBNsFdpodhUTYPqPLb
   CnGLZMBb/S+LGXUS7QvXSlUczHVi9+q/vpZ4c9BN26IPAbpAp3tU6yakl
   gB6kRKmwA2yqvAvQNkjfIrUKdFUKSYU31p8NHL7VXMMr08HHAriaNE+Gh
   g=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="734962792"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 21:19:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:24969]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 48b82784-7a6f-4b7f-aaf0-cd797f1943b9; Fri, 11 Apr 2025 21:19:56 +0000 (UTC)
X-Farcaster-Flow-ID: 48b82784-7a6f-4b7f-aaf0-cd797f1943b9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:19:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:19:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 2/9] neighbour: Use nlmsg_payload in neightbl_valid_dump_info
Date: Fri, 11 Apr 2025 14:19:37 -0700
Message-ID: <20250411211943.67176-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411-nlmsg-v1-2-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-2-ddd4e065cb15@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:49 -0700
> Update neightbl_valid_dump_info function to utilize the new
> nlmsg_payload() helper function.
> 
> This change improves code clarity and safety by ensuring that the
> Netlink message payload is properly validated before accessing its data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

