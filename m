Return-Path: <netdev+bounces-142842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36499C0769
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E28281185
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75A9212D26;
	Thu,  7 Nov 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aTl04cuF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06209210192;
	Thu,  7 Nov 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986156; cv=none; b=YSxP3AAUOCtWl+pHkux/bljLao9MfwPAif8Whtf5RfYsEo2FIR7zvy/mkIBO0WTzmcbau1UXkyKBrm4YbrQPtEPmfSBdB3d6jUkbfFzPxNacS3j2P0PLgDzYOL7h651QdHFoXWWSw9ljhrnYPyDoXZgJMUYjDLO3fRWgfFPoCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986156; c=relaxed/simple;
	bh=Nz3q1Dl8Is3GNYuyJDBOCxA1yTbOIEHWdf6ImgBve1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LljNoa+qrk1LLYriXUScVh+i767PDRvT/kMTXhA1wAqf7wbhwMtDAEtLJFpmEDBcCA4Axy6BuvOowXNfw82aNNmNTv3PiyuVj9WQbvo/Qu5Hux0FXVF+dnb6V0CEb76IPrySwqbFkO4KWGarGONUOPKMoP4hCMJOtVVeoosy89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aTl04cuF; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7B6m9w011029;
	Thu, 7 Nov 2024 05:29:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	/RsZBgYNLD0iYFFbnisnco/VJ0cm/QFqaOsb8n33ac=; b=aTl04cuFEkQxkF8U2
	2hnWU6TKZmMUCzLJpJXVMIcwXswCao+fUSd1mw3Rz2VDhiOVSByED3x7RqAJnflV
	ux418GJvBW/bQr+pXkY5bALoLbvCQWibHQSWMEyd9jgRa3YT7HRGGTOEt3Qq5oa9
	HN95YTKu8tQMP+bzU5gO7dlEsR+wV+GwurB/GM8Lz4Hh6y1WqY+4Z6eN1E7aCFPw
	i7YR43F0+Tjf37l/lz8W3IXR6dcKc7rhCfYCcwyTNirGJ3/QtXEbvSfN5gULjwvl
	X+S9My5W0MyFBzBzJfczvcOJuidy0iH++1qUSTeJzoHt089umNxOUyIAU2S6OEJz
	zkO+A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rvcw0966-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 05:29:01 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 05:29:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 05:29:00 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 569DE3F708C;
	Thu,  7 Nov 2024 05:29:00 -0800 (PST)
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
Subject: [PATCH net v2 3/7] octeon_ep: add protective null checks in napi callbacks for cn9k cards
Date: Thu, 7 Nov 2024 05:28:42 -0800
Message-ID: <20241107132846.1118835-4-srasheed@marvell.com>
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
X-Proofpoint-ORIG-GUID: yEXo3sa1CwZPXtw3JBf12vxXs54d5bAL
X-Proofpoint-GUID: yEXo3sa1CwZPXtw3JBf12vxXs54d5bAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cn9k cards.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Split into a separate patch
  - Added more context

V1: https://lore.kernel.org/all/20241101103416.1064930-3-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index b5805969404f..b87336b2e4b9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -617,7 +617,14 @@ static irqreturn_t octep_rsvd_intr_handler_cn93_pf(void *dev)
 static irqreturn_t octep_ioq_intr_handler_cn93_pf(void *data)
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


