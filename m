Return-Path: <netdev+bounces-174303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B9A5E392
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE9A189AA93
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97522E402;
	Wed, 12 Mar 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B17v0o5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F044D599
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803678; cv=none; b=Fx26EhsJd5SOO/L34p9+g0MQsE28qabMdcBU2BPxPmCOxzcgEljQP5yDBgbBUfU09vOmj4hWbGm4TOJskJBlMUG4Z/03shgiftjSTihFPaSXBn6KaPIzsbAf+y8FwEovhfnHtt9ndCWCwfRojWH0tvf9XW/nSGzxU/CAxyCi+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803678; c=relaxed/simple;
	bh=P5BQVlGmLWmtC1A2cg5skQZt5+uAetF0oU2CFb1g8cI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZ7qPBjIGfMfJrcQoskhqAxsm0sS/6nu4/8p2CDReKPekB6A6/M7Mv98VbPvQ3Vi85jdO63pR1LyjiT+hLQ8xEofOYukq2AOGMt42048jbG4iJtZjFF1+lJ8fadhCWM2jnp+MDVy0Ty9d/KeDXxflp5qiEb/5wuZoqJIKg9n1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B17v0o5/; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741803677; x=1773339677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vdCwRhtiTvZZRfWEFq2pyiUSM/YOkNeQ/O2v+7YfXt8=;
  b=B17v0o5/T1Zl0EcS8Hby4MIZBNcthUNQLKuL6BmWeJG1Mpy+XB0k7yhM
   V7DRbVKd2k+npjz3PwnkmChYWJ77BxxQthQdozz2FUPBQ7I3y0on1q00G
   2FeoQG9CONrzITsGNwQtOUi0lYxCjObwyNvh5iuGEvg/rdAWGBNMV3ksX
   E=;
X-IronPort-AV: E=Sophos;i="6.14,242,1736812800"; 
   d="scan'208";a="178080516"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 18:21:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:37964]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id cd4112c6-2059-4396-92d2-3ecc54a0857a; Wed, 12 Mar 2025 18:21:14 +0000 (UTC)
X-Farcaster-Flow-ID: cd4112c6-2059-4396-92d2-3ecc54a0857a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 18:21:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.160.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 18:21:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.morey@suse.com>
CC: <edumazet@google.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH] net: enable SO_REUSEPORT for AF_TIPC sockets
Date: Wed, 12 Mar 2025 11:20:02 -0700
Message-ID: <20250312182048.96800-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <318ad96d-99ba-4c53-a08d-7f257dbc3d6a@suse.com>
References: <318ad96d-99ba-4c53-a08d-7f257dbc3d6a@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Morey <nicolas.morey@suse.com>
Date: Wed, 12 Mar 2025 18:44:10 +0100
> On 2025-03-12 17:35, Kuniyuki Iwashima wrote:
> > From: Nicolas Morey <nicolas.morey@suse.com>
> > Date: Wed, 12 Mar 2025 14:48:01 +0100
> >> Commit 5b0af621c3f6 ("net: restrict SO_REUSEPORT to inet sockets") disabled
> >> SO_REUSEPORT for all non inet sockets, including AF_TIPC sockets which broke
> >> one of our customer applications.
> >> Re-enable SO_REUSEPORT for AF_TIPC to restore the original behaviour.
> > 
> > AFAIU, AF_TIPC does not actually implement SO_REUSEPORT logic, no ?
> > If so, please tell your customer not to set it on AF_TIPC sockets.
> > 
> > There were similar reports about AF_VSOCK and AF_UNIX, and we told
> > that the userspace should not set SO_REUSEPORT for such sockets
> > that do not support the option.
> > 
> > https://lore.kernel.org/stable/CAGxU2F57EgVGbPifRuCvrUVjx06mrOXNdLcPdqhV9bdM0VqGvg@mail.gmail.com/
> > https://github.com/amazonlinux/amazon-linux-2023/issues/901
> > 
> > 
> Isn't the sk_reuseport inherited/used by the underlying UDP socket ?

tipc_udp_enable() calls udp_sock_create() and udp_sock_create[46]()
creates a new UDP socket and bind()s without setting SO_REUSEPORT.

