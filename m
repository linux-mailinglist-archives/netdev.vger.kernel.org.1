Return-Path: <netdev+bounces-58739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0126D817EF6
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC7A1F215FA
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8915B1;
	Tue, 19 Dec 2023 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hjpyFY5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7831381
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702946787; x=1734482787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RyyCn35duNjzcFkQjiTlLR2jcSJuUyc1e0PIfM6JdIk=;
  b=hjpyFY5/5jD2a2j5yQhgXwR1xlKDOu8mc4mIHhyy4ddKIza4kX9O5IeL
   /fw2Vjg4PNsfJh5TA7wPKIOU/fqbquVBsHPWZxtkqrlu9X+3eW1/3RmXd
   orcaIGbUO9T4Ki5Qr1wkfOvfGLA/r7vMKH/9F+rNBKDJ9KYCbUlDpu/Ku
   I=;
X-IronPort-AV: E=Sophos;i="6.04,287,1695686400"; 
   d="scan'208";a="52106202"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:46:25 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 593B249AE3;
	Tue, 19 Dec 2023 00:46:23 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:44164]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.165:2525] with esmtp (Farcaster)
 id 420226b0-4f4a-41e3-8a64-dee1ba6d386b; Tue, 19 Dec 2023 00:46:22 +0000 (UTC)
X-Farcaster-Flow-ID: 420226b0-4f4a-41e3-8a64-dee1ba6d386b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:46:21 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 19 Dec 2023 00:46:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <ivan@cloudflare.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH v3 net-next 0/4] af_unix: Random improvements for GC.
Date: Tue, 19 Dec 2023 09:46:09 +0900
Message-ID: <20231219004609.12656-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231218075020.60826-1-kuniyu@amazon.com>
References: <20231218075020.60826-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 18 Dec 2023 16:50:16 +0900
> If more than 16000 inflight AF_UNIX sockets exist on a host, each
> sendmsg() will be forced to wait for unix_gc() even if a process
> is not sending any FD.
> 
> This series tries not to impose such a penalty on sane users who
> do not send AF_UNIX FDs or do not have inflight sockets more than
> SCM_MAX_FD * 8.
> 
> 
> Changes:
>   v3:

Just noticed the patch 4 needs --3way to apply, probably due to
the recent io_uring commit.

I'll rebase on the latest and repost v4 to make patchwork happy.
Sorry for the noise.

---
pw-bot: cr

