Return-Path: <netdev+bounces-97705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163DE8CCD1A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478C91C210EA
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AA813B59C;
	Thu, 23 May 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VMvJA7Az"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E8339A0;
	Thu, 23 May 2024 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449807; cv=none; b=mguWZbjEKxJYoVyQfDoMRFik1ftngBNydcGUmNTLCA/odoCN2CALrTK2qv0MAZgSsMuHDNucjI+Pb+OiRBSPx2Ns3+GSAK+GXrnnMKQDHj0bCBT3a7NujLVWK7SgLDDGjGJe75vvdz+G4BZJy14GuwKp4RSmKNZR/c2hG9hH6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449807; c=relaxed/simple;
	bh=1dupYVzHMBIKdXDOUWquSr5ptPsMO6bdaJA+3SW+QhU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=POtlYyuc7VrzbP65lbq8ImFLPYS56qEVok68IokJzR7QSzqbGMJ0Js3OEFEHGGErJtI4ND1lYOB4WXWdzfPgHp0OlHf6cS94msniqoc1pOTzW+D0zXB1daVrc52nMuUNR0wyrfYcCi/sVQM+9WIPHoXC+RTW7EbwST6N7h8QMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VMvJA7Az; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N4lN0u003907;
	Thu, 23 May 2024 00:36:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=omQIKGTAw0G43e4lrwbPbbU3X9ktPiGbrIhpY/YNGhc=; b=VMv
	JA7AzJZE+IaJUdNgurzGrAQePD6KUw980a3J0VMgJYm3EswaKkgd24uwtzqErcW5
	T5yjQkxlGNuF7Fmm0/mnXEx7brERpAUpgKgMs4ggwGKvU3eQx8i4zPtTAnSdIor4
	VIE9dvjAkhgsmtw9Oau82L36cah/lym9zp95tgnlMYpl9Pm5oGzxVHBfqdWmjh3f
	sgUAjr+3Zzff3naypVk0xywzOCizmeWjIz8J/OIYjXfk8FRL1eQ6g59bsn8CN3WN
	mNCnDLc8pApAuW+wkx1xaLzYfKNb4w8HPozmi9LHu3EKk1gzMNl1zK3VRaCDGb3p
	CXLdg8odH6an93Jexpg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y9y310eb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 00:36:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 23 May 2024 00:36:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 23 May 2024 00:36:31 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 110C63F7045;
	Thu, 23 May 2024 00:36:27 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <sgoutham@marvell.com>, <naveenm@marvell.com>
Subject: [net] Octeontx2-pf: Free send queue buffers incase of leaf to inner
Date: Thu, 23 May 2024 13:06:26 +0530
Message-ID: <20240523073626.4114-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: EYgap4YHGi4DU8Dsp84L535Q8sqcytRG
X-Proofpoint-ORIG-GUID: EYgap4YHGi4DU8Dsp84L535Q8sqcytRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-22_01,2024-05-17_01

There are two type of classes. "Leaf classes" that are  the
bottom of the class hierarchy. "Inner classes" that are neither
the root class nor leaf classes. QoS rules can only specify leaf
classes as targets for traffic.

			 Root
		        /  \
		       /    \
                      1      2
                             /\
                            /  \
                           4    5
               classes 1,4 and 5 are leaf classes.
               class 2 is a inner class.

When a leaf class made as inner, or vice versa, resources associated
with send queue (send queue buffers and transmit schedulers) are not
getting freed.

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 070711df612e..edac008099c0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -1422,7 +1422,10 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 	otx2_qos_read_txschq_cfg(pfvf, node, old_cfg);
 
 	/* delete the txschq nodes allocated for this node */
+	otx2_qos_disable_sq(pfvf, qid);
+	otx2_qos_free_hw_node_schq(pfvf, node);
 	otx2_qos_free_sw_node_schq(pfvf, node);
+	pfvf->qos.qid_to_sqmap[qid] = OTX2_QOS_INVALID_SQ;
 
 	/* mark this node as htb inner node */
 	WRITE_ONCE(node->qid, OTX2_QOS_QID_INNER);
@@ -1632,6 +1635,7 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 		dwrr_del_node = true;
 
 	/* destroy the leaf node */
+	otx2_qos_disable_sq(pfvf, qid);
 	otx2_qos_destroy_node(pfvf, node);
 	pfvf->qos.qid_to_sqmap[qid] = OTX2_QOS_INVALID_SQ;
 
-- 
2.17.1


