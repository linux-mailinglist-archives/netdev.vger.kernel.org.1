Return-Path: <netdev+bounces-82150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0088C776
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379DD32072C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5BE13C8F7;
	Tue, 26 Mar 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TFylbGKS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527B13D283
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467414; cv=none; b=EeCSKaC6lookKstIREmDKOM/fhuoWL2L+6B7NNyOHZQTeilkz99LXNHSsSyCnIf3A3/2OGthRrNu0HdcfctffMHmVinqWRLdvA1At4dxEzeMruLFUFuCRVgYBMqIfPayeOuGWGyHz1CCufDMgho1JSGQPY6lQ4CDZBNxDqOLXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467414; c=relaxed/simple;
	bh=k/Nfa6keGlx1uCeZFlUUdTlVb+tz2p+BCPHTGTQCIo0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGkRdK8TreYmx0MmjeyY6qdCvQj9c2uU3deGu2vFNtwsI3or4LTrz3zBXf2dpRmefLVIBeJn73eaz9kson0wcnlBIFcz1kNG3+EH9+SGKjf1cs9g19A1KVFGonenbWGi/zyX0OBzEkcQmGt1KECI+2qTcDgdIoAfZQAmcEpE4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TFylbGKS; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711467412; x=1743003412;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3lUUAFiM9BVbpcGtxrcG7SMbJw5cZGaonMKtpaU2+Ck=;
  b=TFylbGKSp3c8WFPUmIHw6TdI+KKy8VxZKAWiIWYbCTszlWbCWJZd2E8i
   QzlNe4P/5qcMqFIEh4OpEqBp5+NJxolWfIgV9nVHEY/BUqwhWMNsr/6xM
   pzT9Ew/ZoWnwnrSuk5xDmIv2fbJMms/KfNrwGHyE4sY9WCwVqHMCCJKNN
   I=;
X-IronPort-AV: E=Sophos;i="6.07,156,1708387200"; 
   d="scan'208";a="76320782"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 15:36:48 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.44.209:64599]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.1.228:2525] with esmtp (Farcaster)
 id aa02ffe3-9d13-4362-a944-2b9aadd44760; Tue, 26 Mar 2024 15:36:47 +0000 (UTC)
X-Farcaster-Flow-ID: aa02ffe3-9d13-4362-a944-2b9aadd44760
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 15:36:35 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 26 Mar 2024 15:36:35 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 4ECB83239; Tue, 26 Mar 2024 16:36:35 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <eadavis@qq.com>, <netdev@vger.kernel.org>
Subject: [PATCH] net/rds: fix possible cp null dereference
Date: Tue, 26 Mar 2024 16:31:33 +0100
Message-ID: <20240326153132.55580-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

cp might be null, calling cp->cp_conn would produce null dereference

Fixes: c055fc00c07b ("net/rds: fix WARNING in rds_conn_connect_if_down")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
This was found by our coverity bot, and only tested by building the kernel.
also was reported here: https://lore.kernel.org/all/202403071132.37BBF46E@keescook/

 net/rds/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index a4e3c5de998b..00dbcd4d28e6 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -302,7 +302,7 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 		}
 		ret = PTR_ERR(trans_private);
 		/* Trigger connection so that its ready for the next retry */
-		if (ret == -ENODEV)
+		if (ret == -ENODEV && cp)
 			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
--
2.40.1

