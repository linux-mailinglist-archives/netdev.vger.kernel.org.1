Return-Path: <netdev+bounces-88123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9506F8A5DAD
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B8284CB9
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E349157A45;
	Mon, 15 Apr 2024 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NgHr/1ls"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF7154C11
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219659; cv=none; b=UKHy78G/N1pGmOnXSVi9o+DmYTGoLHF9kqxF63W9WNkU4PscMsjrkjx2Qn3kt2eJ9CeZpwu+MGnw8RZqwBn9HIHUG2viu4ua2q2rF8ECtFa8sMv4qq/sAUms9FYcBAHL81yCWQ7P35BMV7GnU7vMiMUYfl8V5vfYL1mmKdmRsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219659; c=relaxed/simple;
	bh=mhEdwISggCvZfH1ibIka9yzkgLuWqTRLR2LhLmanVMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m65jM2kWvstzCDWUh4V4Sd1KwMwtK1scnNdK1SlrwWh7meH1/+X08c5oeYQ/3t5ofooPx84paj+ZsZ6ggRkGC7vEhExxG9nh+scprWoJ3XGaUvIIh1V2Xv/nFiNwx2gv9Vtw2uatBEq/G9Akenw3CSUgLBcXM7Zlmx5YMA/7QqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NgHr/1ls; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713219658; x=1744755658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Acd3gOnBTSw2gfpr+MttzNOKABecBMk9ELoAZFrs9oM=;
  b=NgHr/1lsmtmmMIjY/rn1rMBAQv1yP8y1hkeqYjSrV3j9xBh7Sj/xuR52
   +hANB3zoZob6impbFy7XqDWgINViidCYJmhtWB9AhOp7zizxWiGk/4DNm
   CXoChsY2Ci69f2sctuTNNFFhQSs4JPZeiRLCDhXdxW99UbfK+04nAFn6W
   o=;
X-IronPort-AV: E=Sophos;i="6.07,204,1708387200"; 
   d="scan'208";a="626569573"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:20:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:23984]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.81:2525] with esmtp (Farcaster)
 id b4047d5d-ae00-4882-b4ea-2ac2cde7d580; Mon, 15 Apr 2024 22:20:54 +0000 (UTC)
X-Farcaster-Flow-ID: b4047d5d-ae00-4882-b4ea-2ac2cde7d580
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:20:53 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:20:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/5] ip: Fix warning in pskb_may_pull_reason() for tunnel devices.
Date: Mon, 15 Apr 2024 15:20:36 -0700
Message-ID: <20240415222041.18537-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported warnings in pskb_may_pull_reason(), which was
triggered by a VLAN packet sent over tunnel devices.

This series fixes the warning for sit, vti, vti6, ipip, and ip6tnl.


Kuniyuki Iwashima (5):
  sit: Pull header after checking skb->protocol in sit_tunnel_xmit().
  vti: Pull header after checking skb->protocol in vti_tunnel_xmit().
  ip6_vti: Pull header after checking skb->protocol in vti6_tnl_xmit().
  ipip: Pull header after checking skb->protocol in ipip_tunnel_xmit().
  ip6_tunnel: Pull header after checking skb->protocol in
    ip6_tnl_start_xmit().

 net/ipv4/ip_vti.c     | 9 ++++++---
 net/ipv4/ipip.c       | 6 +++---
 net/ipv6/ip6_tunnel.c | 9 ++++++---
 net/ipv6/ip6_vti.c    | 9 ++++++---
 net/ipv6/sit.c        | 9 ++++++---
 5 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.30.2


