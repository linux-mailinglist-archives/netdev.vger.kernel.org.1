Return-Path: <netdev+bounces-150152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA179E92FF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD390286E0E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B75122069F;
	Mon,  9 Dec 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R8KPCw60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE3216E29
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745340; cv=none; b=IMZLndwstQAOh0RvDBN60MI8s8Vhh3A7r5hiEYs9wdvrLSwmgTBrLuazc6AgLXA2u7jOfYxgzFNPxnmjO80MurRgSqCT/ZblSpfrIzDEW/2ow571yJ4Mzf0sJMtAT4+NJoamKIoRLOKp6WrE8xl1cterAE2KldpcKYRln8mcKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745340; c=relaxed/simple;
	bh=sjuo6os0+wYDx3r4euu97sz0/9uEAVk/5zimK0sfg0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHYAWRhdmRDUKJZvC9WLta+eHdE3OVaD+ywNMWKke6TRXHLaEfXNhNo4jziZQI/yuI0gFBBoWwxkmRKzoAQbZ4WIM8S55NBUPSLJst0lHF66TOWGlOY91cCBQ+upvMNd8tatwbYgmEave8H8dH+rzW6l9JlvWqDLnlLbRpX4WEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R8KPCw60; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733745338; x=1765281338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5X9xLuB6kTPsHbnoT9X4/8jxxci3UyNajVfjkL/v7s=;
  b=R8KPCw60c9inBx7+UEywC4G5hHcY4DQs06yTmOAnlgvrGf+gVuFR3kAJ
   g50JjULEFugl/BId1sgj+JWWxLQc02X47nj7359ELwcs5Lx+fn+PaTKxo
   A2DLQZjbl7dK7YqCkZRZ1HchC5kiDaAtmTYGTTb+Gn2HSWZP2tg8GQ7Y8
   E=;
X-IronPort-AV: E=Sophos;i="6.12,219,1728950400"; 
   d="scan'208";a="151432989"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:55:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:4691]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.26:2525] with esmtp (Farcaster)
 id 5ec23313-d2c7-48a3-afda-4f94a5175b07; Mon, 9 Dec 2024 11:55:36 +0000 (UTC)
X-Farcaster-Flow-ID: 5ec23313-d2c7-48a3-afda-4f94a5175b07
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Dec 2024 11:55:36 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.2.114) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 9 Dec 2024 11:55:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <wenjia@linux.ibm.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 03/15] smc: Pass kern to smc_sock_alloc().
Date: Mon, 9 Dec 2024 20:55:28 +0900
Message-ID: <20241209115528.54880-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <385f7646-7f87-43ca-9585-5ecdd59a4379@linux.ibm.com>
References: <385f7646-7f87-43ca-9585-5ecdd59a4379@linux.ibm.com>
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

From: Wenjia Zhang <wenjia@linux.ibm.com>
Date: Mon, 9 Dec 2024 12:05:03 +0100
> On 06.12.24 08:54, Kuniyuki Iwashima wrote:
> > Since commit d7cd421da9da ("net/smc: Introduce TCP ULP support"),
> > smc_ulp_init() calls __smc_create() with kern=1.
> > 
> > However, __smc_create() does not pass it to smc_sock_alloc(),
> > which finally calls sk_alloc() with kern=0.
> > 
> > Let's pass kern down to smc_sock_alloc() and sk_alloc().
> > 
> > Note that we change kern from 1 to 0 in smc_ulp_init() not to
> > introduce any functional change.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >   net/smc/af_smc.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> Sorry, I didn't see the need to add the **kern** parameter in 
> smc_sock_alloc(). Because the **kern** parameter in sk_alloc is not used 
> others than to decide the value of sk->sk_net_refcnt, which in SMC code 
> is already set in smc_create_clcsk(). Thus, IMO removing the **kern** 
> parameter from __smc_create() makes more sense, since this parameter is 
> not used in the function.

It would introduce another consufing situation when someone calls
sock_create_kern(PF_SMC) (sock_create_net() or sock_create_net_noref()),
which alaways create a userspace socket.

As long as it's part of the kernel socket API, we shouldn't use such a
hard-coded parameter.

