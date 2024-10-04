Return-Path: <netdev+bounces-132282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B199127A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725351C20BA0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0184E14;
	Fri,  4 Oct 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ugqbpPV1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C9231C9E
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081927; cv=none; b=f6O9Ck0m20pnWRF363FYQXcNmk/iWxhucyU3j22aSZMAVPO4DQ7NrIkgR9GQSRznppdTRwvR0uBX2msykVD2NRV7Sk8VQ/axYT1UAiM9Ve2QSyiUAsNCxE+goHBlxa5oa4Kg/zFeuCJuKLBR49v2f9muDI69RUQJpMG3UEpxqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081927; c=relaxed/simple;
	bh=pW8gBa9oI7MmD7ILKpUa0Y7KgLlphB42IT+aTwAKVqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IR7EV6yHP2Tu1R+u7KFBcPiaXZ0eaKuhRtMSyFIO+LciVLQeEw450Yt+sSryXnsmMZLS418NbgInf1nFZ4a0oGklzNRDL4p6S7ooVDpq2uVlVSI4YBNd72/Dvu3dRQkx+JZ7sh+484aK4YhlSeDKX17Lqm39LyjYAFjoBhEmNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ugqbpPV1; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728081927; x=1759617927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DpQb4auSS6xtOHVn+fDvaB7DaAQjkfGDIIMOwpQjfhI=;
  b=ugqbpPV1V+f1KxvVa45Akbgx4llnxVAFJ1sy1PhZE689/ItD0+5iUk1g
   5PINZ3pqDJFrWfLTylpjEL89CVtztWNnk/bEDoR4ovCK+ybZqqIKAA6zO
   z8ofH1Qi9XwdbKTrzvMZFzWrL49a68msOaCxu7JLHX/engzPW8yfFCmTI
   U=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="438420791"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:45:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:34757]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id 12dbd05e-c4c0-4640-84c3-8f50fca1716f; Fri, 4 Oct 2024 22:45:22 +0000 (UTC)
X-Farcaster-Flow-ID: 12dbd05e-c4c0-4640-84c3-8f50fca1716f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:45:21 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:45:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <alexandre.ferrieux@orange.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/4] ipv4: remove fib_info_devhash[]
Date: Fri, 4 Oct 2024 15:45:10 -0700
Message-ID: <20241004224510.82362-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004134720.579244-5-edumazet@google.com>
References: <20241004134720.579244-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  4 Oct 2024 13:47:20 +0000
> Upcoming per-netns RTNL conversion needs to get rid
> of shared hash tables.
> 
> fib_info_devhash[] is one of them.
> 
> It is unclear why we used a hash table, because
> a single hlist_head per net device was cheaper and scalable.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

