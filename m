Return-Path: <netdev+bounces-16601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99574DFDD
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A714C280C87
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B5C156D8;
	Mon, 10 Jul 2023 20:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAE14AA0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B837C433C7;
	Mon, 10 Jul 2023 20:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689022586;
	bh=uaet/vS559ZNcPR+W8+s35pAsXcHToUISOZU6WradJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbbbWRsct48tvzKZxyP6Jp261uQd1Du1uC1/6EGLgNj9Mb5eMzRVLF9UatJ8Y98Sx
	 jrl2nUvccYklWxAN5bSiPvOabQ3l/XLW+vqWjBJVrnMUYESZ9XGlT90kocR0TUUVaU
	 N7nsSJhCWp8EfH2/Xu0Qmn/AloHosfRAvZIFiOOz09+k3HuKbIUzfTV3QxvfrGQyBV
	 ovRqm4D0aytKc2NzyLALW8bzHV7YD3wcvvwfg8P091tFsj3v8BtT4VCnT/MKv3tfuR
	 pDr5ON+7BXWfJ40K2T2/PnyOJ+6VGEjE9TlMlY0B77YpHFC4dfE1vDG4lM4/QeLgiK
	 bBx8w/JSzr7FA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions more gracefully
Date: Mon, 10 Jul 2023 13:56:11 -0700
Message-ID: <20230710205611.1198878-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710205611.1198878-1-kuba@kernel.org>
References: <20230710205611.1198878-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalid Tx completions should never happen (tm) but when they do
they crash the host, because driver blindly trusts that there is
a valid skb pointer on the ring.

The completions I've seen appear to be some form of FW / HW
miscalculation or staleness, they have typical (small) values
(<100), but they are most often higher than number of queued
descriptors. They usually happen after boot.

Instead of crashing print a warning and schedule a reset.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 14 +++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b8ddad33b01a..bfa56f35d2e0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -690,6 +690,16 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 		skb = tx_buf->skb;
 		tx_buf->skb = NULL;
 
+		if (unlikely(!skb)) {
+			netdev_err(bp->dev, "Invalid Tx completion (ring:%d tx_pkts:%d cons:%u prod:%u i:%d)",
+				   txr->txq_index, bnapi->tx_pkts,
+				   txr->tx_cons, txr->tx_prod, i);
+			WARN_ON_ONCE(1);
+			bnapi->tx_fault = 1;
+			bnxt_queue_sp_work(bp, BNXT_RESET_TASK_SP_EVENT);
+			return;
+		}
+
 		tx_bytes += skb->len;
 
 		if (tx_buf->is_push) {
@@ -2576,7 +2586,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi)
 {
-	if (bnapi->tx_pkts) {
+	if (bnapi->tx_pkts && !bnapi->tx_fault) {
 		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
 		bnapi->tx_pkts = 0;
 	}
@@ -9429,6 +9439,8 @@ static void bnxt_enable_napi(struct bnxt *bp)
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr;
 
+		bnapi->tx_fault = 0;
+
 		cpr = &bnapi->cp_ring;
 		if (bnapi->in_reset)
 			cpr->sw_stats.rx.rx_resets++;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 080e73496066..08ce9046bfd2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1008,6 +1008,7 @@ struct bnxt_napi {
 					  int);
 	int			tx_pkts;
 	u8			events;
+	u8			tx_fault:1;
 
 	u32			flags;
 #define BNXT_NAPI_FLAG_XDP	0x1
-- 
2.41.0


