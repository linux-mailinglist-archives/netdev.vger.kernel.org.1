Return-Path: <netdev+bounces-147537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820439DA133
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 04:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4848C2849DF
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 03:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375E43ABD;
	Wed, 27 Nov 2024 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hGR8QYvp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C41114
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732679309; cv=none; b=lwlROnj6MjASe3QZRbZkKKjjURinoGrwMp6OnswcKC1LVQsTZGKegp9YsqFAJqCMHM9tk6NI0ahoUtS9PUuxL5O4DXdckbUfFOb1o7NcWb8b/hqsgf6QvEdzUxiOqdfZ09QrpCfekiiSKSfs26iqCZ/R+KqvVR9UEo+ZV8EAJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732679309; c=relaxed/simple;
	bh=3Ew9fISE3aroQEhQTSSwWotpz11SV3BMTM0uQ/WuqcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjx0ugCiLVEC8tD9PsjcOZ075Ygbt8qwr+CTP4PmYYcR4i+cCAwc4imNKFwWUrSzzTFvfIwtqm30UOmSrs0DTz9j8tDrq4pJCOBstYK0SuBZjaqAsS0BO0ybI1TZir7PXztTQ8RPr66G7ANJeEjZioMbRD2nyXwqSsCejpSeFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hGR8QYvp; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732679308; x=1764215308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4z6tmVAPsmDu69hoL3GPukNWuzauFtbzLh3skCDzazQ=;
  b=hGR8QYvpaWPJFsQZOU1/2tpD657+39hjCjcCWyreWDRV/GrtUlgKTR4f
   y3Vm+ElAsd1Qa0O/uj31KaARQGhTCzM3GBmPi2fFeG+zVNZBf6+YOgMEI
   1F3gQSatayXf/wAn5ygWS8+wRhYYi7pFI4fBwge91l1EuuqLO/HobaKMH
   U=;
X-IronPort-AV: E=Sophos;i="6.12,188,1728950400"; 
   d="scan'208";a="44821802"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 03:48:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:36197]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.101:2525] with esmtp (Farcaster)
 id 0d107930-dc54-4443-9c57-0f585ce24c09; Wed, 27 Nov 2024 03:48:20 +0000 (UTC)
X-Farcaster-Flow-ID: 0d107930-dc54-4443-9c57-0f585ce24c09
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 03:48:18 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.13.144) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 27 Nov 2024 03:48:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <ebiederm@xmission.com>, <jmaloy@redhat.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	<tipc-discussion@lists.sourceforge.net>, <ying.xue@windriver.com>
Subject: Re: [PATCH v1 net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
Date: Wed, 27 Nov 2024 12:48:11 +0900
Message-ID: <20241127034811.19682-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iLXk2BRLWuyvEsxOVqRBo2qbuOydv33xfKAe54M9tKPUA@mail.gmail.com>
References: <CANn89iLXk2BRLWuyvEsxOVqRBo2qbuOydv33xfKAe54M9tKPUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 11:53:07 +0100
> I think 'kernel sockets' were not refcounted to allow the netns to be removed.
> 
> Otherwise, what would tipc_bearer_stop() be needed ?
> 
> tipc_exit_net(struct net *net)  // can only be called when all refcnt
> have been released
>  -> tipc_net_stop()
>   -> tipc_bearer_stop()
>     -> bearer_disable()
>      -> tipc_udp_disable()
>        -> INIT_WORK(&ub->work, cleanup_bearer); schedule_work(&ub->work);

I noticed tipc_net_stop() waits for all works to be completed by
checking tipc_net(net)->wq_count, but it was decremented a bit
early in the work, so I'll post the following as v2:

---8<---
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 10986b283ac8..ef3d8f71bde5 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -821,9 +821,9 @@ static void cleanup_bearer(struct work_struct *work)
 		kfree_rcu(rcast, rcu);
 	}
 
-	atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
 	dst_cache_destroy(&ub->rcast.dst_cache);
 	udp_tunnel_sock_release(ub->ubsock);
 	synchronize_net();
+	atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
 	kfree(ub);
 }
---8<---


