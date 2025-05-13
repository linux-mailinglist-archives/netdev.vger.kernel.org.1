Return-Path: <netdev+bounces-189992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFDCAB4C8F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBD63ABFFD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7E417A31D;
	Tue, 13 May 2025 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="P3YuhGDh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639152AF1C;
	Tue, 13 May 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120597; cv=none; b=JCM4AwgO+1v0YJBHnHIG0rAdcOOyUXoLdi8xNwDLoSot+qsvgPJbzhBjoluWEnVb4b7jNrgdKKc5M0JElCn6zESvQyAA6NZ817NFQOq2E3Gcx2MtKHCLfU+JQRR/wecA1SD/0diuFvliG09S5TR5Vbv27kXgoshGt+ujcmPOfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120597; c=relaxed/simple;
	bh=HOSCn5OY2vMFi2WBMkO799cdrMEuSpKl02X7FsfwxMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AE6rGBzROJWxx/Fnb+jWGAD13yQgJdm57iQ5estU0WLKxirJw1d4masI1AxO5WGXNHBrPQkR5b8d91Fo2uohIkOvPHQNcuUyMkbcO5TMXKH2PZUQudoRiEslKM0Dve+iTnx8/+Yhj5KuJFpMbg3g4mQPvU2pOpiY0soSZAR5Cqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=P3YuhGDh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CNiMLO028930;
	Tue, 13 May 2025 00:16:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Z1uM+z70uGeKg+gMbp7OUv2
	1zkYo9ZLgDYWqE+zAqQA=; b=P3YuhGDhU6eft6WxQktfIzvhO8MNYMFOZqbfQy+
	XRqLCKE8PkazlSeR+l4PEX/N98BadzB9uB1hadXZQNnxv2GoFswVQgd5ZI0OJGoy
	e5aBfqqL+QJHCi4HfO46U4BNZ3ruQe+3SmYsIsMPhNo9BTCJI+fE1wCQBB3HJfbT
	yyFkFPCsu36fn97ee8hq5fxJqswyrohqmIPlHUrNkVPEV86FrFq5zR9rZ3d7nwhY
	dYHhkmcSxeaZJBL/72wlwRjvatox/U1H9HIBYlwfFZlK6OzBIvF174XjUmP1ZKnJ
	0Zcx1+yFu2SrfK7gBomXhccYCoLzZONmIKAYmYpDRmO3sDg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ktw18ps9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 00:16:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 00:16:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 00:16:11 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 9E0E83F7091;
	Tue, 13 May 2025 00:16:06 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Christina Jacob
	<cjacob@marvell.com>
Subject: [net] octeontx2-af: Fix CGX Receive counters
Date: Tue, 13 May 2025 12:45:54 +0530
Message-ID: <20250513071554.728922-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: g8uFJp49h4XVLW6dktfElSKQmDzstYSG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA2NyBTYWx0ZWRfX3JGZgoXSX5nS suu5qdq+Unn92C+L8ZI181wHS35eRGedqybXDlQBF0uiiIMrk909r8u962HpPadhESkd35oFdzu zRP6PIbLJ4RfvfNp+WrpZZPmi6IiKoMPRcuS2I7or/WmbMauIOCNmRo81ap0FC5D3Yaa72+ySe5
 /iyn3mQAWgiqo0/JKyqtCZ19cbDC7Soo+KlsavxMzFoEJ7+SCzrOOD8mMdSySCyO6R+ts03qRbf QJjGVXVGv+WD+GZMcZGWVc6kbgZ0hJawg2V7KESm4TE5uvR2xRZ6ZxcGVXdPbOH3Y6i9Jx0gzkW ikWj0wn2Li6rzTibYoI0SmnLI1V/tNs4IXrK+UXXTEiR3+szznS+/2eH/GPuy8kwyusxCrrbw6Q
 h60gt8Qihk8bqQ9C5MXR7tGEPkF2lJKz33zZSOAq7VrAA7EK9Va3XgMZS1vEJfgHSu3PO5pO
X-Proofpoint-ORIG-GUID: g8uFJp49h4XVLW6dktfElSKQmDzstYSG
X-Authority-Analysis: v=2.4 cv=WsErMcfv c=1 sm=1 tr=0 ts=6822f1bc cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=RxlNfrxfzKab5IRzU1AA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01

Each CGX block supports 4 logical MACs (LMACS). Receive
counters CGX_CMR_RX_STAT0-8 are per LMAC and CGX_CMR_RX_STAT9-12
are per CGX.

Due a bug in previous patch, stale Per CGX counters values observed.

Fixes: 66208910e57a ("octeontx2-af: Support to retrieve CGX LMAC stats")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 0b27a695008b..971993586fb4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -717,6 +717,11 @@ int cgx_get_rx_stats(void *cgxd, int lmac_id, int idx, u64 *rx_stat)
 
 	if (!is_lmac_valid(cgx, lmac_id))
 		return -ENODEV;
+
+	/* pass lmac as 0 for CGX_CMR_RX_STAT9-12 */
+	if (idx >= CGX_RX_STAT_GLOBAL_INDEX)
+		lmac_id = 0;
+
 	*rx_stat =  cgx_read(cgx, lmac_id, CGXX_CMRX_RX_STAT0 + (idx * 8));
 	return 0;
 }
-- 
2.34.1


