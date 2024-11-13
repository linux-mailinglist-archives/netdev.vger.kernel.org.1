Return-Path: <netdev+bounces-144378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D69AA9C6D98
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AF0B2416F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F132010EE;
	Wed, 13 Nov 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I1Li2e/F"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85638201018;
	Wed, 13 Nov 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496430; cv=none; b=c9OwaiysulsmpAE5npXKYScsUtpHyf+N3PPmKRmeBWak77borzDCitNs5wCv6CA294Jzh1VRYDffP+g++wFWH4J+tWoWhCmsg5w4S1aEXRIYkCRhU1RK6Kj5HLtg/dqeur0ShoJjA7o12LmjnINCV3mMHUolmoo0L9xBYxj4wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496430; c=relaxed/simple;
	bh=nzv+y2yiu2Jrwr3CG+NaBctuNIWu3AdOb/rrEmRnA2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3fARauS0uU9pkPfEH6nnxGrzFU3KaSFI+KIZ6N+TZ0Gq7q1PzYut2+pkeiyKo4CHHOSKDHhCzXtfvI5IN65X3NlxJADkTYzDR+pbPQdW2uRUOkS79t1r7Av1tP5QVQH2wV8aSjsWKFo63H53mascKnwj7PyPNqYbNVEeTOxBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I1Li2e/F; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9B2Al004423;
	Wed, 13 Nov 2024 03:13:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	dDHPDl2Sti0NQvKVT75wfU6XVb6GbzwngwOqMiRso4=; b=I1Li2e/FhYZbhEA/6
	GZHD53sG3ZF4SOmNzu97CeupEFJ9PTF+upFAz9t958eNx5VT6pNO4alZQQw3FMnH
	2m6TYSbMH6oeIjV5U922EoR8sN8nVxATmtzfk0wgh1u7TiRANieSc34rCGjVHJG1
	os9qwcTA3Y7FGTbDjCmHIBzer/MLduxVXAxpzq8hv30PIUz2EbJMkOdAPOpM7UD6
	91ojN/9x15eDQs9JCD+5j8xVfhzlJA+zWlz63qFeGGhfgmdfW21Tgy/ABCC7kppT
	4VaZEuMudREGgI/2j6ZwneXwgE8jvoKIQlC0EikArGOXD1lez5xbulv5SL7xohyO
	7Wpag==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42vs8g06dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:13:35 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 03:13:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 03:13:34 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 108333F7040;
	Wed, 13 Nov 2024 03:13:34 -0800 (PST)
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
Subject: [PATCH net v4 7/7] octeon_ep_vf: add protective null checks in napi callbacks for cnxk cards
Date: Wed, 13 Nov 2024 03:13:19 -0800
Message-ID: <20241113111319.1156507-8-srasheed@marvell.com>
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
X-Proofpoint-GUID: oYsrxAmyJNl8A6s8uSTOgi9vOKbMVMLX
X-Proofpoint-ORIG-GUID: oYsrxAmyJNl8A6s8uSTOgi9vOKbMVMLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cnxk cards.

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - No Changes

V3: https://lore.kernel.org/all/20241108074543.1123036-8-srasheed@marvell.com/
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-8-srasheed@marvell.com/
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


