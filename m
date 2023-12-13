Return-Path: <netdev+bounces-57075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF558120B8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBDF282239
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3B67F541;
	Wed, 13 Dec 2023 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rKW0mIk2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03F8CF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 13:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702503022; x=1734039022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vCzLmBMn5tPE89nhIkZ82fzzZyIE/giDw/5nibqI2E4=;
  b=rKW0mIk2Oax4nO5awgDKEJavWrswQ9e5GHI74Hu6yJP9FdRWVF8Sakm2
   yINDinU+YwOHu5gdGhE06BFrortBevQn8QK6PWIJf1iHoYub3iewaApvJ
   mAVVOBuYSWZsdv3ep4WRPG5XjyZleHTROV9fHcAwEKuR/KeAiP9TfrcoB
   E=;
X-IronPort-AV: E=Sophos;i="6.04,273,1695686400"; 
   d="scan'208";a="625082317"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 21:30:20 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com (Postfix) with ESMTPS id 79D6A16005D;
	Wed, 13 Dec 2023 21:30:18 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:31720]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.140:2525] with esmtp (Farcaster)
 id 071e1278-4c59-4958-90e6-4ec6972c00a2; Wed, 13 Dec 2023 21:30:17 +0000 (UTC)
X-Farcaster-Flow-ID: 071e1278-4c59-4958-90e6-4ec6972c00a2
Received: from EX19D038EUA003.ant.amazon.com (10.252.50.199) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 21:30:17 +0000
Received: from c889f3b7ef0b.amazon.com (10.187.170.39) by
 EX19D038EUA003.ant.amazon.com (10.252.50.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 21:30:14 +0000
From: Salvatore Dipietro <dipiets@amazon.com>
To: <edumazet@google.com>
CC: <alisaidi@amazon.com>, <benh@amazon.com>, <blakgeof@amazon.com>,
	<davem@davemloft.net>, <dipietro.salvatore@gmail.com>, <dipiets@amazon.com>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: RE: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set
Date: Wed, 13 Dec 2023 13:30:06 -0800
Message-ID: <20231213213006.89142-1-dipiets@amazon.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
References: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D038EUA003.ant.amazon.com (10.252.50.199)
Precedence: Bulk

> It looks like the above disables autocorking even after the userspace
> sets TCP_CORK. Am I reading it correctly? Is that expected?

I have tested a new version of the patch which can target only TCP_NODELAY.
Results using previous benchmark are identical. I will submit it in a new 
patch version.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -716,7 +716,8 @@

        tcp_mark_urg(tp, flags);

-       if (tcp_should_autocork(sk, skb, size_goal)) {
+       if (!(nonagle & TCP_NAGLE_OFF) &&
+           tcp_should_autocork(sk, skb, size_goal)) {

                /* avoid atomic op if TSQ_THROTTLED bit is already set */
                if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {



> Also I wonder about these 40ms delays, TCP small queue handler should
> kick when the prior skb is TX completed.
>
> It seems the issue is on the driver side ?
>
> Salvatore, which driver are you using ?

I am using ENA driver.

Eric can you please clarify where do you think the problem is?


