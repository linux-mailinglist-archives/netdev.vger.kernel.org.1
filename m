Return-Path: <netdev+bounces-178189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8FA75754
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEAD16C411
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB51D5AA0;
	Sat, 29 Mar 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HVmRHwqa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0517A2E8
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743270113; cv=none; b=dYOuvzcnBJ7FeI0byeHzI9quPeGp7d7zGRKxjtLy7CxLlr4TJq+nIJJxR2P1tFtZG//0aLAWD13Gc5gLmwN64qwkXlGIfjltJmoZA3QfyQ6VG/BaSh5qdDJu842olzZjXqR2eFSzl0bqaurt3B4xO9iJumj0EOjrvAovS4lfG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743270113; c=relaxed/simple;
	bh=wNRh5+ESAb6txZ5pV1AHhW9VdxbjEO5oucY1Im1CLn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IchMH7a/9rk6LDxGSN68Au/IfufAPyP5u6ovhRzZt1LG9lNUmkqpNmcQJ+vunN1kwz0BXvNBfQrfB1vmv6fiRc5d9pRMgUVxuN3ykVSpqBcUXewXHsKpoCi9MLRD37e4tyM8JHzrPrRjUBqhB9K8YZhTQYGVdRIA+lVWYf3z3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HVmRHwqa; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743270112; x=1774806112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W5lq/1vj0rfWbacMs7oEqhe7aDD3EDalfAaycjTkrtw=;
  b=HVmRHwqa+wN3E1TED2DvHSvJ4I/4eoZK+AKyMsSCe4eJAhJu7BXk8iZt
   66NMDoKrhb6/02NMJLYuzi4v4WiNlwXvcVVS4QIhfmhr+sH3Q/csJzhLd
   6qScmHSV7+2TtDRlyOsoOjL4kocJPvmeRSyrBZMmyq6QVMd2uMpnFzBZo
   I=;
X-IronPort-AV: E=Sophos;i="6.14,286,1736812800"; 
   d="scan'208";a="391068265"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 17:41:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:29487]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.18:2525] with esmtp (Farcaster)
 id c4143538-2853-49cc-a9b0-e56341c5e63d; Sat, 29 Mar 2025 17:41:49 +0000 (UTC)
X-Farcaster-Flow-ID: c4143538-2853-49cc-a9b0-e56341c5e63d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 29 Mar 2025 17:41:49 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.57) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 29 Mar 2025 17:41:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Sat, 29 Mar 2025 10:41:32 -0700
Message-ID: <20250329174137.31877-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329075315.0ec21bdd@kernel.org>
References: <20250329075315.0ec21bdd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 29 Mar 2025 07:53:15 -0700
> On Thu, 27 Mar 2025 13:26:52 -0700 Kuniyuki Iwashima wrote:
> > I got a report that UDP mem usage in /proc/net/sockstat did not
> > drop even after an application was terminated.
> > 
> > The issue could happen if sk->sk_rmem_alloc wraps around due
> > to a large sk->sk_rcvbuf, which was INT_MAX in our case.
> > 
> > The patch 2 fixes the issue, and the patch 1 fixes yet another
> > overflow I found while investigating the issue.
> 
> Test fails in the CI, unfortunately:
> 
> # 0.00 [+0.00] TAP version 13
> # 0.00 [+0.00] 1..2
> # 0.00 [+0.00] # Starting 2 tests from 2 test cases.
> # 0.00 [+0.00] #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
> # 0.00 [+0.00] # so_rcvbuf.c:150:rmem_max:Expected get_prot_pages(_metadata, variant) (49) == 0 (0)

Almost..!

I'll use sleep with a loop.

Thanks!

