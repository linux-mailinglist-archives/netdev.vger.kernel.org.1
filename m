Return-Path: <netdev+bounces-154727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F12F9FF993
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494AD3A3361
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD29D197552;
	Thu,  2 Jan 2025 12:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BECE3FE4
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735822658; cv=none; b=INxN41bsC1GhrMFoV/DB3BFmf24wXPB34yUU6t7I3faWpLkm0UI415zF4GTlBjaCQplV6lY9iS8DvYTSQGM1PE+yIa+P8TOzUEj2zQ9Yx8en0KipnSzE0rvkpg1ZuGFAIgBU3aTFYkvNaNTtS3FeMUKKbLFtnLFf02tJ8oJMNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735822658; c=relaxed/simple;
	bh=NtbQD88qQzJH95fvpjFDPwpK0403hmSCJbXoGvokaF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cqru0YLPmTWzE3Vk++f4tD99HgX3kJwxw3UKW9kuqQNFg7wKh3toeoSjlAf16IqeBnqHblsv0f/yfzmIU5qWfE43RTwSdX1M7E0yZRrVYX+bw+MA16Myy4VU2AiwyDjU3Fskmt/82IBiGFJdIlZHefqRQCTwLX/Q72MrQws/BZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 502C79DB006203;
	Thu, 2 Jan 2025 04:07:10 -0800
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, andrew+netdev@lunn.ch,
        pabeni@redhat.com, bharat@chelsio.com,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>
Subject: [PATCH net] cxgb4: Avoid removal of uninserted tid
Date: Thu,  2 Jan 2025 17:40:18 +0530
Message-Id: <20250102121018.868745-1-anumula@chelsio.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During ARP failure, tid is not inserted but _c4iw_free_ep()
attempts to remove tid which results in error.
This patch fixes the issue by avoiding removal of uninserted tid.

Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index bc3af0054406..604dcfd49aa4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1799,7 +1799,10 @@ void cxgb4_remove_tid(struct tid_info *t, unsigned int chan, unsigned int tid,
 	struct adapter *adap = container_of(t, struct adapter, tids);
 	struct sk_buff *skb;
 
-	WARN_ON(tid_out_of_range(&adap->tids, tid));
+	if (tid_out_of_range(&adap->tids, tid)) {
+		dev_err(adap->pdev_dev, "tid %d out of range\n", tid);
+		return;
+	}
 
 	if (t->tid_tab[tid - adap->tids.tid_base]) {
 		t->tid_tab[tid - adap->tids.tid_base] = NULL;
-- 
2.39.3


