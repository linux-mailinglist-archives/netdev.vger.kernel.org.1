Return-Path: <netdev+bounces-188751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB2AAE78C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E409C1C022A9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C028C5BE;
	Wed,  7 May 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R9U8XFrz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BE28C5B6
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638202; cv=none; b=JJtk9aEdUBYea8MGir4lfHcs66cNlUeS7HFeanS5inawI3iHOg35Y0bSKbf8aAXEgAYtSBVMvf8f8utbbCwK/128BueFMTODCzBMuJkxLSWlckSSk1hHSKLBiM9M9T1wRfpn8b166NyGvd3spLLu3/AZ5u7PWRXefA+F7OsTqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638202; c=relaxed/simple;
	bh=CJn6oSzbe9ccw1YoTIQ+Dg9eM+SbgdEpb9alHvSUxJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=URbCU5pVxO0Hqtfy3Oara/MVODkz+AjPfsZ4uSrfDrSgif6tVYYKxvMPDTcYAqIZpTIH+2gl/C5vvMOJ5FOrXLvxwniJHXUkRTtR9fts4yFyAHiO0AzNrbgLltQ05rlA3THo+QLdcVFVsp7JMrzS8uOgaJ+oUZDfeGDWIwgCuSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R9U8XFrz; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546NTBoh016937;
	Wed, 7 May 2025 10:16:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=s1fhG5docTmshoZVLYhbfFDlJAZkmAzdrd3PkVSobGM=; b=R9U
	8XFrzU+F14j2fxmF9CkvgWvwM55cq/XjSUxLz/smIMdA1cBHJNR6zkmGPZ5mdjc9
	p3x79SGVJ1sYXr144tjwj/VdLv17f7VNFhWmJEb+zjxwdT9hMtxYgdPE9ALxW3ep
	8GMF68rqYYAZ7Xm1S/5xmJcaHOHmHqtsLnwEzyeEhvYWdzqQ83YW3wqWlIGdSq2E
	k7sdWQO7cie0Mp9b1MRds/WWkJygaxTmvR0+jE9d6nYx0RfVznQzsu/Mxf64W3uN
	YBECU/KPaduJHIRyIGuxDvpW6HPTWdOgtBG0rPmmhCvkPNGnXqj9HPWzieAn1u7W
	l7Q8n3frXmeQEe8BWbA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46fv4rt3yq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 10:16:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 May 2025 10:16:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 May 2025 10:16:31 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id A4A2D3F708A;
	Wed,  7 May 2025 10:16:27 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH] octeontx2-af: Send Link events one by one
Date: Wed, 7 May 2025 22:46:23 +0530
Message-ID: <1746638183-10509-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: VT7lIkDPvyn-PvcL9OZU8aXKdbL3122n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE1OSBTYWx0ZWRfXzi43H/C0J/fB n8mNGqT2CDXcAzUg42U7vQk2L3+IQU3Lq+VNMs1zAEWy+8nP21Wqyb2eQhRP5cEPp9ffkRoqOO6 kIgimDQVCIiep90LErWS+VDOLlGtHDkjLTjG3NQjSKheZAJu51myGf4kXv80FLR+j8DZ/ocuqFZ
 PdinqPoUB53Acf3twjR8BqXWvlwQY6glQwE4seBCfcaT73vZXYKmLGTB667/47snXCUns5OKHv8 8zZsIAxHiRwPxIWiwddFBfmhSLE15wU498bXQcvI/4OmeIU1Dhoi7wmZqeHczj0yJNMtKYTeQlj 0sZxFvnEM5NM/UUEU7s3zI5wKxaFex0pSz20jYoIjFQUYMsh/gym78sxAiBsWdSbgxEZ5YXqzX4
 IlIKoJIkdmVJOYXLr6gg/DDd9pHMdisBD3zqsFzbwWigX8ZUsFJ7cxyM8aQV09MUxIhHro1Q
X-Proofpoint-ORIG-GUID: VT7lIkDPvyn-PvcL9OZU8aXKdbL3122n
X-Authority-Analysis: v=2.4 cv=TKdFS0la c=1 sm=1 tr=0 ts=681b9570 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=QHeTzNiMllNnO-1yQAEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01

Send link events one after another otherwise new message
is overwriting the message which is being processed by PF.

Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 992fa0b..ebb56eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -272,6 +272,8 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
 
 		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
 
+		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
+
 		mutex_unlock(&rvu->mbox_lock);
 	} while (pfmap);
 }
-- 
2.7.4


