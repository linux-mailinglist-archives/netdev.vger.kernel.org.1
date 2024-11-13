Return-Path: <netdev+bounces-144374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EC59C6D85
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFEC1F262FE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9E200127;
	Wed, 13 Nov 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AnE93TzW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B11FEFDE;
	Wed, 13 Nov 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496424; cv=none; b=lgENysUphWtBwtAjTvteBkXn2byrhtgNJufRT82YMX21KC/yd9mixGmhAFdXrYfSttCdsBoEfhP2a8cXDGdZnQc11rkmVDXudxNC3rW9vMFmVY7QsI/9ch4Nm+J0KKHw9DaJ8pqZDYsqExwWr/6aTsakjH1PNEfsTsZcsHjjaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496424; c=relaxed/simple;
	bh=A22PI+ae8ZVpaPRQ6udLcLq/Yyb1U1TYd8V4q0ZaOss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbNduyk+rg9af0uyd1U2c3xVfANLXw+DQwskK+XaJhk16wC4TtGfVIKNoVrJsqa5DLPe5pEhysw36mRDPeTVBVO3A5PRDtq+yYeSRRVLbiOH58aXesUDJ3mlUcOeq554cOAuvG7916JWCHwY49XQNJUPVm+lJHlyfUbpfkb+Xus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AnE93TzW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD8WPYD001685;
	Wed, 13 Nov 2024 03:13:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
	R+O8JlKd4NixP/9Jc5T8cC2dkX1tP9ZWb1hKV6/kSQ=; b=AnE93TzWBghSZMHpt
	JjjKg9+YoOcTeloK+W3yYieg0DhCKcquhTGemT/uHvUxRFMpgHiA4Xj5ugK5G495
	hXec0+Ve/snJosXWxB0DaB69F9kJdLOREh6Wv1Wv0fFZBbQs9ehsmKCSbeA63rr3
	FbIJ9ijuYz8QtIouUEFKpNrfSRyvDWfF3jQSrOdYy8fcsbGCLiDjk2U/ufXFNEkZ
	rEAoo6kwsDOyt6JDixIXMb6SKUnvYDOqTBr0SIisyRSNGDthJfvB+WcCrUGg10AB
	YaoayWUjnId8GvzNtMR5PJ60dPdpgYUqGtYfGhdlk8KhwwxDLw8YIrLulf5/FYt9
	hIjEg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42v5s2tqfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:13:34 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 03:13:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 03:13:32 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 5E9DF3F7040;
	Wed, 13 Nov 2024 03:13:32 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v4 6/7] octeon_ep_vf: add protective null checks in napi callbacks for cn9k cards
Date: Wed, 13 Nov 2024 03:13:18 -0800
Message-ID: <20241113111319.1156507-7-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113111319.1156507-1-srasheed@marvell.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ow5mM_CZBPQ62nHHw6rKGSkcdE_xTGFa
X-Proofpoint-ORIG-GUID: Ow5mM_CZBPQ62nHHw6rKGSkcdE_xTGFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cn9k cards.

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - No changes

V3: https://lore.kernel.org/all/20241108074543.1123036-7-srasheed@marvell.com/
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-7-srasheed@marvell.com/
  - Split into a separate patch
  - Added more context

V1: https://lore.kernel.org/all/20241101103416.1064930-4-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
index 88937fce75f1..f1b7eda3fa42 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
@@ -273,8 +273,14 @@ static irqreturn_t octep_vf_ioq_intr_handler_cn93(void *data)
 	struct octep_vf_oq *oq;
 	u64 reg_val;
 
-	oct = vector->octep_vf_dev;
+	if (!vector)
+		return IRQ_HANDLED;
+
 	oq = vector->oq;
+	if (!oq)
+		return IRQ_HANDLED;
+
+	oct = vector->octep_vf_dev;
 	/* Mailbox interrupt arrives along with interrupt of tx/rx ring pair 0 */
 	if (oq->q_no == 0) {
 		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0));
-- 
2.25.1


