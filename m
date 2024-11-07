Return-Path: <netdev+bounces-142845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5579C0770
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5FC1F22872
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656B0214403;
	Thu,  7 Nov 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bw+7nugT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DF2139B0;
	Thu,  7 Nov 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986161; cv=none; b=R+NmT2an8Lt/f3OOnSXBLYm7w4uLL+IHGfRm2UI7SXQ1qvYdPBK8z0Ai3LYwX0xZC3mPYakUWyafTqYpe4lt32wdsJYpR3JLAq8e54Z6z+TG7o4KMyZ3+YsF9QmeI8ZF/kIhLpVsh31wMNItI/BPUpz4tLZ7L04AtSrG+hCcN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986161; c=relaxed/simple;
	bh=UteYyRqBVzx41RyXLNG7R8RzkZ55eV9MbHRlmgYYDNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfpzYVB5oRyzbyZbbaQvZIYGgRjXEejJ7ayQvHlQZS067ry5gxsY86iNyasHbKIZ5r6lFEHOO4BmBcthzniuybdX08A5dwuIgdC/1hfQRYeKFeuAmIMyEsuoQYy4W7oTQ+40jfzmXSLMqh8aeHbsPi7gJ7v5qtS7bCK7mwOH6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bw+7nugT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7B7P6T012398;
	Thu, 7 Nov 2024 05:29:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
	2SJ3lNwk8rdWi5O5a5QPSu0QRkK5EV7/gAESWkOe8A=; b=bw+7nugTtVZ5exyBI
	M3hkB8fbHeryL6/0eAXs+nARnrkr3UdYUlH7d2v5XKzyMVrM/qciLHeOc2PHFzKP
	FpcCi0ZMNUutfnl8cGOsbw4lAwajv1oSwAHrA7Ox/4qbQLuj/6sePKYCeCWS1ucj
	i9jTjaXpwRDza2IXbS1ijId9tPAVHk0ukK97lmHc589c37iK6l20H+LWElCmISUq
	QESdrEgafWwnU9ZF1IfqJFuqSmjv2C3p3nmYhkuFXOCsq8rBLMMELELsPdnEIHF3
	1+xJQ1cAlVW04fB1Aj/l7stTBwCK2iLwiQJ8NXuEsZKfMDSYZDKH0DzgS8/tpFfV
	y/CcA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rvcw096a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 05:29:07 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 05:29:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 05:29:06 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 8928A3F708C;
	Thu,  7 Nov 2024 05:29:06 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <frank.feng@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2 7/7] octeon_ep_vf: add protective null checks in napi callbacks for cnxk cards
Date: Thu, 7 Nov 2024 05:28:46 -0800
Message-ID: <20241107132846.1118835-8-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107132846.1118835-1-srasheed@marvell.com>
References: <20241107132846.1118835-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eokCgqP0r7EuTpftq0Dbm8HBogVUr_Tc
X-Proofpoint-GUID: eokCgqP0r7EuTpftq0Dbm8HBogVUr_Tc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cnxk cards.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Split into a separate patch
  - Added more context

V1: https://lore.kernel.org/all/20241101103416.1064930-4-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
index 1f79dfad42c6..31c0d7c0492a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
@@ -284,8 +284,14 @@ static irqreturn_t octep_vf_ioq_intr_handler_cnxk(void *data)
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
 		reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0));
@@ -294,6 +300,10 @@ static irqreturn_t octep_vf_ioq_intr_handler_cnxk(void *data)
 			octep_vf_write_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0), reg_val);
 		}
 	}
+
+	if (!(oq->napi))
+		return IRQ_HANDLED;
+
 	napi_schedule_irqoff(oq->napi);
 	return IRQ_HANDLED;
 }
-- 
2.25.1


