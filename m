Return-Path: <netdev+bounces-143222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C499C1734
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DD11C2235B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E371DE4D9;
	Fri,  8 Nov 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XzQesEUO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44211D8A14;
	Fri,  8 Nov 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051966; cv=none; b=JOQqIlw9c0jjo0WS8GlVezE49tyT7ht3dvcNd+ylfV5CauE0F66dRaBMAcqUfxpqNWe5oaId5woo3q82o7ZcTUZxlGEB+zMFXkthNLtm713IjAyZ1izJRrqWnRwg9GQI8alkxU/YkKfEKNzikYwVOy9E/jrMZeDDWzgQLGtkPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051966; c=relaxed/simple;
	bh=lVgRJkTudVJcmdbS+x21u9mgJKISN8B89B7L8QPYRg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUDXAWt2RFKdTmU7bs9e9zumEibHyj6azrf6SSNjSVz6TBxxh5hmaUSNRtReJ4NYEgBG1IMaTYiYYUjGRZv3GWb7gkdjsKpR36N+A4GzRaNVf/LlowQ57mP3w0sSIcaAgCOCu+uMat9aq23nVNqTMvEs94cWqd7lvHsCIBQpi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XzQesEUO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A84hSiT012266;
	Thu, 7 Nov 2024 23:45:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	fHYLDmgkFn6leQQOMqPeMPmCv0gBhR1b70rHi/lzto=; b=XzQesEUOEevlXwpkJ
	qgiL7pYqs8F9MrQJJachEpo7QfckxQr0vj/16mUZbXpPkCgCxYlLQc/KWkXtT3NL
	XKGZJJa8sZx+wbjxZ5qz/bpGeKtOwrLuMjL7SVtmybqak5Z0r9wTZ7kgMxty+GtI
	Vtw8tUKPFaZIYsHUKyG7h9rnTu7QgUYcJnXGYuweauQVNLGTg1SYxJ2q23apo/98
	sBx4sz798WsXyW/7IRzgFlEixZ1LKi3o85QujxC3Z050hWEPz1quQFauLVz6a3C6
	cANJGX0LjnJCxWDsRCaHw6ojZnYk0zEz6QeQCd+MhTMC3XvhjhhOTtnndSBn9OFU
	MTQNA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42sbv68a4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:45:53 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 23:45:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 23:45:52 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 1D3063F7082;
	Thu,  7 Nov 2024 23:45:52 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <frank.feng@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net v3 4/7] octeon_ep: add protective null checks in napi callbacks for cnxk cards
Date: Thu, 7 Nov 2024 23:45:40 -0800
Message-ID: <20241108074543.1123036-5-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108074543.1123036-1-srasheed@marvell.com>
References: <20241108074543.1123036-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: y8Ufng22z5mKSe7LkNWXUvD0OTUfL3QB
X-Proofpoint-ORIG-GUID: y8Ufng22z5mKSe7LkNWXUvD0OTUfL3QB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cnxk cards.

Fixes: 0807dc76f3bf ("octeon_ep: support Octeon CN10K devices")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-5-srasheed@marvell.com/
  - Split into a separate patch
  - Added more context

V1: https://lore.kernel.org/all/20241101103416.1064930-3-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5f..65a8dc1d492b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -638,7 +638,14 @@ static irqreturn_t octep_rsvd_intr_handler_cnxk_pf(void *dev)
 static irqreturn_t octep_ioq_intr_handler_cnxk_pf(void *data)
 {
 	struct octep_ioq_vector *vector = (struct octep_ioq_vector *)data;
-	struct octep_oq *oq = vector->oq;
+	struct octep_oq *oq;
+
+	if (!vector)
+		return IRQ_HANDLED;
+	oq = vector->oq;
+
+	if (!oq || !(oq->napi))
+		return IRQ_HANDLED;
 
 	napi_schedule_irqoff(oq->napi);
 	return IRQ_HANDLED;
-- 
2.25.1


