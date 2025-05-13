Return-Path: <netdev+bounces-190125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F6AB5402
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278AC17C3F1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4580628DB7B;
	Tue, 13 May 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EN8wpIZU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384128DB70
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136444; cv=none; b=CnH4Z5C34sC1fS8K9HYheTG/qeKFYD3TNMixT8qa7yY9xlIpuVygqTWtHSMnAiG4KdwUGVk1VPaShOscsq8PfZlrPDGnZ9e2WVUaolIgZqEOIBIQXh7ZDyVAZ9buyapLuUUTznltCwmcRxA1M1tDm94j4XevvZ7MUbvJGH1Vjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136444; c=relaxed/simple;
	bh=YU9UnGndmCz0YXofEFz6I+80yJBcfOaaL3DD2BTaWZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkScpbcS6lRykNBOxWvUxoK9rzfxUcMREtqdcwiiiPrZypbpa01HzdfxALFkDbXgVXt4E2Wz3/yLU3JOi6l/VXz3vlTvJ7SF7FZWQNCaJhMwmUhH2Qta4HHWOFsU/0tLU9hvi1w/EDvuVXZTX7rDbE2vAZ7q/gcPG94fp4/eWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EN8wpIZU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DAFiqo011140;
	Tue, 13 May 2025 04:40:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=c3VR9eREJWkHXFj9r+75/496J
	6LUjlFC+75HrXYY9Jc=; b=EN8wpIZUKS+BW1LEjApnHvlGBVBRqcKjHBRF0rQzn
	WbdBYEl4e4Ww70wXGPEbXiQdCGktU85DoycIMFnHGTbBCi/FBJHbEyC/7PnbmDsb
	1n3W8pEwbYqDuXQHmD3epGaeQaAcJ2D3aXr1RCuw4UDAe11L18Noa93TbZtmxhPB
	XcBcqMTovl8yK6C3PrRDnZyNUozhK/WQlcjZosL1wZP1ZJ8wQNS2poRPgN39nup7
	A80DhV2Tp86Wx8N98oUU5xQiXi4dGtmW9HeVmUNyfQa82PGOjW8YFqxeT5JM4jft
	SJ2r3PqVJNsy+M3USzviybzgHVpyLoE4fDYI5Cq3+Yv5g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46m46104pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 04:40:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 04:40:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 04:40:31 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 77CEB3F7060;
	Tue, 13 May 2025 04:40:26 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next v2 2/4] octeontx2-af: Display names for CPT and UP messages
Date: Tue, 13 May 2025 17:10:06 +0530
Message-ID: <1747136408-30685-3-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1747136408-30685-1-git-send-email-sbhatta@marvell.com>
References: <1747136408-30685-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMSBTYWx0ZWRfXzfU8HXc/t17A gjMbn7EkSWCIrSEwfe+6L9uz2QdNC2xUKTKVrUNTYKcWlU1c53v2J5r4nw6ePYatomduTSe+Nt6 gYI44wsl8v354S8IK8zbRJqruVvt7kguK5OpaD9lUbUsnZGMu11wBfe1xiBB1rM1H/44R52MPZA
 qKrWoC/8SyVAZxp5fu23IlEWvz1rm85wkjYl2yfbQw62XH1xF68uX5eUHsOWWE95EXrg6Q//UJf pQsz7x6UUUuQju8FvHgHNsxYX+aILvyCXhQIsyX2nWWsuOukLo9oeIMN1xWHeVxj/YUFIvF6FdM 0qsvbKvVteLIxnzK2TKWPjx1iQpDAL6FJGBiu5YkRFaKG0JYZ+K08+My1oq43KLjo/QyuR1FEin
 j3Z9xTjOeP7nK5bMakFrxU8AtGUGVoNRUoRkuN0EcM1FWJi4QMnqxR0KKHIx4o6LwekpxpKO
X-Authority-Analysis: v=2.4 cv=f+dIBPyM c=1 sm=1 tr=0 ts=68232faf cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=TUI-8gK_6JqeD_B3SqwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: NKPeQjgtfhQihetQuJL6M5Fk8RQNjHGQ
X-Proofpoint-GUID: NKPeQjgtfhQihetQuJL6M5Fk8RQNjHGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01

Mailbox UP messages and CPT messages names are not being
displayed with their names in trace log files. Add those
messages too in otx2_mbox_id2name.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 5547d20..5c457e4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -444,6 +444,14 @@ const char *otx2_mbox_id2name(u16 id)
 #define M(_name, _id, _1, _2, _3) case _id: return # _name;
 	MBOX_MESSAGES
 #undef M
+
+#define M(_name, _id, _1, _2, _3) case _id: return # _name;
+	MBOX_UP_CGX_MESSAGES
+#undef M
+
+#define M(_name, _id, _1, _2, _3) case _id: return # _name;
+	MBOX_UP_CPT_MESSAGES
+#undef M
 	default:
 		return "INVALID ID";
 	}
-- 
2.7.4


