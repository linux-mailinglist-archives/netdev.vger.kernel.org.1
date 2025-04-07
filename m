Return-Path: <netdev+bounces-179772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE842A7E800
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4875C3A3391
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204792139C4;
	Mon,  7 Apr 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eaR2odb1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187320FA94;
	Mon,  7 Apr 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046385; cv=none; b=PFOdbwAMm2MdgN2imY1XlrZS4ktFAkWW1W8dN94McKZiEyMxlq+dVQvGGjSttfX3yopAX5RVHHL5dY1xJ0Xp3MY/lOtPhqJkyq2Z7vfulDye9PLfgQEqe31MgAngGnf3c4Y4WSEG6h4+A+4M64RRYfd0O8ugyz0ubO+uw15sPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046385; c=relaxed/simple;
	bh=0BkM1zrmMLAP62omqbt45d4s44rgMzHxSwOjgbuHJV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmsmC8P5etCAiliAodbcn1aU3mMfc1OK7iAr0lyM9vrF1kCtmj4JtGJXyiTj9hd1ovouAYmGh6k1vHs7uLskc6Jo2ajUOxrKfjT1aPSQsNS5W7mM0dFl9LvnPa25hNYnk3qbGGyFCaUCGN/o8ysNwqneT7EpyPVKbGCLduAbaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eaR2odb1; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744046383; x=1775582383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4c5PRsn7O6BsPB6gXPg8wPIUVPeFNKSYbt0iMRi41U8=;
  b=eaR2odb138pBvOBR3DWoQYkRxLagAPFmrheJbBPE1ct+jYCCYuv9zeQp
   2SH0G1Z7+tEvh0Wei3JTN6IC/N+4STDTlnraIN+89B0dQmLgTafGWwwnz
   UYt43/jnY3G5+rf2Erlk50yuV0Y4S4HnGZNabm9FGxRRlLJPcpobW+fL4
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="81542275"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:19:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:46951]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 8729d04d-4f18-40af-b169-77f6624111b8; Mon, 7 Apr 2025 17:19:39 +0000 (UTC)
X-Farcaster-Flow-ID: 8729d04d-4f18-40af-b169-77f6624111b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 17:19:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 17:19:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hch@lst.de>
CC: <axboe@kernel.dk>, <gechangzhong@cestc.cn>, <kbusch@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<netdev@vger.kernel.org>, <sagi@grimberg.me>, <shaopeijie@cestc.cn>,
	<zhang.guanghui@cestc.cn>, <kuniyu@amazon.com>
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit 1be52169c348
Date: Mon, 7 Apr 2025 10:18:18 -0700
Message-ID: <20250407171925.28802-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407143121.GA11876@lst.de>
References: <20250407143121.GA11876@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Apr 2025 16:31:21 +0200
> I had another look at this patch, and it feels wrong to me.  I don't
> think we are supposed to create sockets triggered by activity in
> a network namespace in the global namespace even if they are indirectly
> created through the nvme interface.  But maybe I'm misunderstanding
> how network namespaces work, which is entirely possible.
> 
> So to avoid the failure I'd be tempted to instead revert commit
> 1be52169c348 until the problem is fully sorted out.

The followup patch is wrong, and the correct fix is to take a reference
to the netns by sk_net_refcnt_upgrade().

---8<---
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26c459f0198d..72d260201d8c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1803,6 +1803,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		ret = PTR_ERR(sock_file);
 		goto err_destroy_mutex;
 	}
+
+	sk_net_refcnt_upgrade(queue->sock->sk);
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
---8<---

