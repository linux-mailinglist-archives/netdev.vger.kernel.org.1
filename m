Return-Path: <netdev+bounces-134740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09799AF66
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF06D1C20F7C
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB71D14F0;
	Fri, 11 Oct 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kVqHbEVU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2419F110
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689371; cv=none; b=IxBnqW2PPioup2wTwgj86IJFsqPGQh5mJJo8pudHA09wc/9j/t+zEzYpwpu6XirxK3Q8ULpu6yrwLaKbeWTo9KqJJDb0HDwCaMjHRqdTdcCVHusv5ApTta9mqKnHC1iCCvL9IhNQGtOYcrdKVWRLjeTAMJoDy7TQlZ+Ph9q4qMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689371; c=relaxed/simple;
	bh=Tqs89zAyW0Gv5hQD+2v3lQX93HKMy9nEe46lnZb4c6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exub1/wa/QH2ZbuCHEqzqnaVDNOQ65PecraVVDgRjcLZcw4hTkVJfVqLH+s6GYtSNvO9DhMn1UJRF0fIGJ7b0NSTe1V5pWAO/8MQbOKEQzzCjQuROWhixtBmeMNNr2LB88fNULbdhAdrrgDbVI2oB8Y2OKqz2Q5NVLE4/eIHg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kVqHbEVU; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728689370; x=1760225370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wtThMvcslXGPVBVr4OgXtbBHd6zxSYt8ctq23jgpu/I=;
  b=kVqHbEVUQldQgkTCS6R5FtIo4TDZqBU8rNUG7Y37MzROkAHixRAvNUC7
   WP5I1Y6IPMFmzS8JnUzcgRHtG2lT7mXrT79B/4tXmOjAoOGbac0bUXQMx
   aoaZk14w1lJdGKcl2qBEZZ9jng3n1Js04Qw8tOtT3xUpbvCbUc/NXbsn3
   I=;
X-IronPort-AV: E=Sophos;i="6.11,197,1725321600"; 
   d="scan'208";a="342395673"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 23:29:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:64594]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id e25f301c-ddf6-49d5-a350-f4b123cf19cd; Fri, 11 Oct 2024 23:29:25 +0000 (UTC)
X-Farcaster-Flow-ID: e25f301c-ddf6-49d5-a350-f4b123cf19cd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 23:29:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 23:29:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <brianvv@google.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <martin.lau@kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 3/5] net: add skb_set_owner_edemux() helper
Date: Fri, 11 Oct 2024 16:29:17 -0700
Message-ID: <20241011232917.53163-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241010174817.1543642-4-edumazet@google.com>
References: <20241010174817.1543642-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 17:48:15 +0000
> This can be used to attach a socket to an skb,
> taking a reference on sk->sk_refcnt.
> 
> This helper might be a NOP if sk->sk_refcnt is zero.
> 
> Use it from tcp_make_synack().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


