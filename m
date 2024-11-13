Return-Path: <netdev+bounces-144375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0379C6D8C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCDB281E84
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD13200B95;
	Wed, 13 Nov 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SE36dAjP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAAA200130;
	Wed, 13 Nov 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496426; cv=none; b=Tv4DFNMr3vECGkZuN+ZD6PetjAEz3maiX9Pazn6p7Oznu0Cm9yO+7JcivbfD2UQ+uPUUjRvTlshD0VXAmHqGgu897KIQy48eCSBR/XBSSPEgmn3oe/3tHGp98pdv9xpgVjtIZexUA3x/geJ30LpufCe0TwRATuKCLORccsk4wp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496426; c=relaxed/simple;
	bh=0NKxQZ2eJIO94As+SZU5UQtSG1PepPeFOGfQrt2dgVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQ9AezGKbGVHeMyEGu+QQrtQYZfvaQZd8/OorB1kAEiCgAVrzspmAB1RPWqjSuq4XUDqY/W/hyeeKFBeekHCgBo933FYPhWb0XuCA9A0wg9727LdQUEUHlir3Zsv3jhzAAqnvjSz3hbTmXXKJ5WOZjLDcnFKA4VPIuLbJ2eAVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SE36dAjP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFpGYn025821;
	Wed, 13 Nov 2024 03:13:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	YHP6zG5isnC7ZyUgogxd68rMkjJZJLPn6DZH60CfeI=; b=SE36dAjPMX76sOPRL
	XTiwvXUp4+L2lRJebOqZaf+B98Zrc94syjQP4NROvTpvKvfadMwCn1dQeFrXnBkb
	QvtRTk7dHAuUx1ylOQUEMoY9aOpvLRZT19AwNZfdlzZzI/3JSQELOYHGy3fPpi3k
	zq6dtUwtu0nnNPRW9wJEJa1Qc+Ckyn9v3rRnL4tAforrgkCW5gLXE/DHT9WMDkML
	p9NkzLPvIlONbDtT91AIMJJ83IwFAEXZkWrvi0k3ltDuku2LPppttW2iRDUolgTD
	KelCB/QVE1vHkGkMjn91yJpIvKdOiVcTiZ66e4HTWmKNYjbPLy4NXmSv86X7GER/
	wlZPA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42va1625t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:13:30 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 03:13:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 03:13:29 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id D10713F7040;
	Wed, 13 Nov 2024 03:13:28 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>
Subject: [PATCH net v4 4/7] octeon_ep: add protective null checks in napi callbacks for cnxk cards
Date: Wed, 13 Nov 2024 03:13:16 -0800
Message-ID: <20241113111319.1156507-5-srasheed@marvell.com>
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
X-Proofpoint-GUID: aYUyXPW9LrQJwvFJ08AOKbKKvZpqgI-G
X-Proofpoint-ORIG-GUID: aYUyXPW9LrQJwvFJ08AOKbKKvZpqgI-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cnxk cards.

Fixes: 0807dc76f3bf ("octeon_ep: support Octeon CN10K devices")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - No Changes

V3: https://lore.kernel.org/all/20241108074543.1123036-5-srasheed@marvell.com/
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


