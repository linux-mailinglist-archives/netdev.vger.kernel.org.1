Return-Path: <netdev+bounces-114673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A479436D9
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE40A1F27584
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED745005;
	Wed, 31 Jul 2024 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dtL8rXed"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE2381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456482; cv=none; b=ToV0uM9odv7z42HuTnZ9bSpdYHagNu5SaCaX/nKoi/lo/FiLMGimKDyfNUYPZkphoa/cL4jixc0R5RBkBw5ukUP/RP6ptm4YM0npJ067b0ZIxHeB/GS7hB490WUdsz2VMCrTwUNl+k7h9gLwkuoAQlP0B+Eh572PZDHqR9ldJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456482; c=relaxed/simple;
	bh=I5o0+o8KY54oi2PFYWwVrLgeao+FnfVRWbHdV4FV7IU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLeIlRgxPWt+L1/BgvJObuy36aN07W9YdOeTTCCNcBYvwv2kSDVRwpkddBuok9uAx4ywIsjX6OsEUBVEEcWHUrIeTdLtq8WlNnyHuDpbftLjujjIiPu1+r0EhijdiMCYY5OoK6SlfFiN1qHEas1inDMnC9GUlyU6xZ4jk+JXDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dtL8rXed; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722456481; x=1753992481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bv5NstBA2yGtcwzxZY7S6eZgmMVkUc9NsbL33DDAFZs=;
  b=dtL8rXedbYQqrV5DCbOhef5H4qBc1O95pyolP2M0r8qvqgDW5V5x2Nik
   XX7VwpPUb73gyZSU642/yGKqPA81rJG2z1i7FBcCH1yU/uxH3nHEoMKEO
   kVYJl0DSxafZxqepqokKTaqmEx2hMBbxBioZEu8j63iMbkponIo0JNish
   4=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="746777502"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 20:08:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:3367]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.84:2525] with esmtp (Farcaster)
 id 60c77429-386f-4951-914a-fa6f30858ace; Wed, 31 Jul 2024 20:07:59 +0000 (UTC)
X-Farcaster-Flow-ID: 60c77429-386f-4951-914a-fa6f30858ace
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:07:59 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:07:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH v2 net-next 1/6] l2tp: Don't assign net->gen->ptr[] for pppol2tp_net_ops.
Date: Wed, 31 Jul 2024 13:07:16 -0700
Message-ID: <20240731200721.70601-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240731200721.70601-1-kuniyu@amazon.com>
References: <20240731200721.70601-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and
ppp parts") converted net->gen->ptr[pppol2tp_net_id] in l2tp_ppp.c to
net->gen->ptr[l2tp_net_id] in l2tp_core.c.

Now the leftover wastes one entry of net->gen->ptr[] in each netns.

Let's avoid the unwanted allocation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 3596290047b2..246089b17910 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1406,8 +1406,6 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
  * L2TPv2, we dump only L2TPv2 tunnels and sessions here.
  *****************************************************************************/
 
-static unsigned int pppol2tp_net_id;
-
 #ifdef CONFIG_PROC_FS
 
 struct pppol2tp_seq_data {
@@ -1641,7 +1639,6 @@ static __net_exit void pppol2tp_exit_net(struct net *net)
 static struct pernet_operations pppol2tp_net_ops = {
 	.init = pppol2tp_init_net,
 	.exit = pppol2tp_exit_net,
-	.id   = &pppol2tp_net_id,
 };
 
 /*****************************************************************************
-- 
2.30.2


