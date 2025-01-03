Return-Path: <netdev+bounces-154941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F105A006C3
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C068218844C8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C51B87D2;
	Fri,  3 Jan 2025 09:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249D1119A
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896032; cv=none; b=m8OOpbOTffnJD1lBAqpZPB33TUinwDFAe3+dKd5dWJO7KwktENT7lE7DPTRiOMJ+TE6yL4KwGY/1oTxdmEqmboNYNzwhB0lJ39iyjSO20RUwQ0WKtcr7diQRhQf38iEC3L99OL8Bu1K7c4bGR4Vpa9CO+TY2um2oK65BfFGLckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896032; c=relaxed/simple;
	bh=oczawJ9oUV0r2RKuz1E8Klf02hnwvHA3rjWOveeGI0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thBLUudVqYt5dcOORseeTWOVIoPzHopfa6opC0m3pSmB2T4dpXBfFwQfg3yBQU7+x7fLDtZeHLYIwGErzMI2TD4WNCE1Pnk3xGZOAvF1FVuKPOi5w5007A3tqO/mZnwHtMsK5Hydmd9ly5mDQXrAas9XM/F9IzrHPbu/tX01qEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 5039KFnQ006690;
	Fri, 3 Jan 2025 01:20:16 -0800
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, andrew+netdev@lunn.ch,
        pabeni@redhat.com, bharat@chelsio.com,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>
Subject: [PATCH net v2] cxgb4: Avoid removal of uninserted tid
Date: Fri,  3 Jan 2025 14:53:27 +0530
Message-Id: <20250103092327.1011925-1-anumula@chelsio.com>
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

Fixes: 59437d78f088 ("cxgb4/chtls: fix ULD connection failures due to wrong TID base")
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
Changes since v1:
Addressed previous review comments
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


