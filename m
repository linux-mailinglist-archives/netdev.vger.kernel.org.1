Return-Path: <netdev+bounces-39534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7ED7BFA51
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DD61C20925
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A1D19442;
	Tue, 10 Oct 2023 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LYzNk3z7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4115AE8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:50:42 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737599;
	Tue, 10 Oct 2023 04:50:39 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A38Dv8024201;
	Tue, 10 Oct 2023 04:50:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=869kURQHxyEbzuTjcLLmcIJexFWY1u6w+li4VH7jiQw=;
 b=LYzNk3z7FZM4lt5zuQmPRaIpRY6WQ2a/5Zn2Mfxqm6LkSuEq1Hd2Qha9PuvQQEMxgSOR
 rT5CFGsOJAGo4MQpAC87M1YvV1CrKc0GZdczZwjH1aCTBIO6+bB/70599jFv8g9CWzNy
 /bqnOYf/QiujB7j0/WH8p3e21bA+JzCwz537ljB02CBeECsxoCQ6FmOozfc4mCreWHPh
 rEOWLCV9bX4CICuPPAK8nKpKn7AgC51ge+j9fMmvhapHLZ0V6V675xhk0vbIaEwegEij
 PYVE3EhE9MfzRgb+Il0ylEXWBDDncCe3dCH9sVdw+AsEG8W/RoPfiOYuZGNU3snZL7Pn FA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tmxense1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 04:50:23 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 10 Oct
 2023 04:50:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 10 Oct 2023 04:50:22 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 8ED163F70A9;
	Tue, 10 Oct 2023 04:50:21 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>
CC: <vimleshk@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Satananda Burla
	<sburla@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>
Subject: [net PATCH] octeon_ep: update BQL sent bytes before ringing doorbell
Date: Tue, 10 Oct 2023 04:50:15 -0700
Message-ID: <20231010115015.2279977-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uKQmclyPkdhj3WW5UyDKA5GEMu7tg2Xy
X-Proofpoint-ORIG-GUID: uKQmclyPkdhj3WW5UyDKA5GEMu7tg2Xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_07,2023-10-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sometimes Tx is completed immediately after doorbell is updated, which
causes Tx completion routing to update completion bytes before the
same packet bytes are updated in sent bytes in transmit function, hence
hitting BUG_ON() in dql_completed(). To avoid this, update BQL
sent bytes before ringing doorbell.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index dbc518ff8276..314f9c661f93 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -718,6 +718,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	/* Flush the hw descriptor before writing to doorbell */
 	wmb();
 
+	netdev_tx_sent_queue(iq->netdev_q, skb->len);
 	/* Ring Doorbell to notify the NIC there is a new packet */
 	writel(1, iq->doorbell_reg);
 	atomic_inc(&iq->instr_pending);
@@ -726,7 +727,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		wi = 0;
 	iq->host_write_index = wi;
 
-	netdev_tx_sent_queue(iq->netdev_q, skb->len);
 	iq->stats.instr_posted++;
 	skb_tx_timestamp(skb);
 	return NETDEV_TX_OK;
-- 
2.25.1


