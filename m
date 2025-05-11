Return-Path: <netdev+bounces-189508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6237AB26B0
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 06:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BAD3BAF0A
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 04:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB718DB3D;
	Sun, 11 May 2025 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B3OCIzJN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E311898F8
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746938452; cv=none; b=g2mAsDDdovV1yg8zSncclTOVybE+loxjlEcAiof2Lrys3uqcPOTO8sno28yGaBZW3INsvf/ic+yIUCcx2zH6x74KSbd8VQLyK7ePNxes+dCH5PdoLAnoszDaPOP2c+/ked/TmVbuiUPte1lWm6jYBEed0/lNGAYJ9wt3HJUzxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746938452; c=relaxed/simple;
	bh=g0/IjMzj5MWgjOwQc/7uEkFwkoE6qUHXa5kut1j/wkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCb38RE/1wZTZCRuFy18CBNiKOxF4QwQKrITbjoBmSHxwIZdhy8lxXKLNVLWW7NPC/acYxTWLihSZrEJ0CI2Kg6p7snOKtujVlsFdURoufqWbOpN/uI1cC7t0MzWxc4wwsNF/pS7AciWySGF0T5U4y5Umwc0LwXI6kc7a/SQ548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=B3OCIzJN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54B4djSo025453;
	Sat, 10 May 2025 21:40:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=JfFOxL2e7UAAEdh45LKgqglVa
	3kZtYMa0KqAmPxjsSY=; b=B3OCIzJN1VcTt6s2nDU9+s2akmIH2MMqPP7bOBjIY
	mI1FggXHg4g+XqVV7AwUzfiaO2QE2AsgqlECqEG01WLpq+oLd+2oSLwvcpB29KQh
	Lf307nVaRAK802qqnFG/ZUsDAyEe/FZAHam32cF6WOrowtQG8DfHZaK4QbupPAdQ
	bKBCdzP7eAVpO2qcS1rTYQNI8She4GJ5LHwllB8JffZ7GOHhGE6P51A/EVzM8NXs
	CTLu5EkuMhBDRDxBrUdBlVeQkaboJGt0vr8iH77j4Ff9M5cIXwXsTfA3OO4FQ1bh
	i8szo9ZG4q1kPTPGcfI5wQdK9Rec4a3pyPw+XXMWZNpvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46jgpc8809-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 May 2025 21:40:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 10 May 2025 21:40:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 10 May 2025 21:40:29 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id D260B3F7045;
	Sat, 10 May 2025 21:40:24 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH 1/2] octeontx2-af: Add MACSEC capability flag
Date: Sun, 11 May 2025 10:10:02 +0530
Message-ID: <1746938403-6667-2-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1746938403-6667-1-git-send-email-sbhatta@marvell.com>
References: <1746938403-6667-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ZqLJZs9EHyTjc6m0XJwJlZG8ETLGFK8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDA0NCBTYWx0ZWRfX/d5ZnWLtEAg8 Vnk9hQw1qAadH56Utm55r5EZgIQzJMRLtm4kcstrhe5Vfh7cOTGBUA44wEdY8wKUWrC/yQ6MA6N 79+ud5rEwqxoXHj8YdcID4Sava8FtT3FOXgrjbboFNO7BR8PC1tGdReYIabIo+lSvovKTHw7wpM
 wPLSq1+sjvYK7kRqnK9qBx1D7rP664dTqmYd3tRlhmxV7Uxg8E3/kFFXlLBawOgSrQ5a/i+9v6c tR0ihtJpl80ovLxBytKohhuVPB//bCE8KRxQnVinVUVkKd/wGTzn7fBAJ69pcAdRV3RiLwr923X +AYAW3lHcBK88L80+AtJo6j2Jdu1P+Cdn9PHCFG1k0v6inOgvsDzsNxATjnZQ7MhLWweigv8506
 SIW58ksnvNZmMZkvSibtquYcN7JSNrVOicJUF9jpJFhADlvzhuHMR7uJl5ch/vcdrzQktt2q
X-Authority-Analysis: v=2.4 cv=bL8WIO+Z c=1 sm=1 tr=0 ts=68202a3e cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=P7ETNM-qh4qR_gsSVD8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ZqLJZs9EHyTjc6m0XJwJlZG8ETLGFK8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_01,2025-05-09_01,2025-02-21_01

MACSEC block may be fused out on some silicons hence modify
get_hw_cap mailbox message to set a capability flag in its
response message based on MACSEC block availability.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 005ca8a..a213b26 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -524,6 +524,8 @@ struct get_hw_cap_rsp {
 	u8 nix_fixed_txschq_mapping; /* Schq mapping fixed or flexible */
 	u8 nix_shaping;		     /* Is shaping and coloring supported */
 	u8 npc_hash_extract;	/* Is hash extract supported */
+#define HW_CAP_MACSEC		BIT_ULL(1)
+	u64 hw_caps;
 };
 
 /* CGX mbox message formats */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 6575c42..6e13ab2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2031,6 +2031,9 @@ int rvu_mbox_handler_get_hw_cap(struct rvu *rvu, struct msg_req *req,
 	rsp->nix_shaping = hw->cap.nix_shaping;
 	rsp->npc_hash_extract = hw->cap.npc_hash_extract;
 
+	if (rvu->mcs_blk_cnt)
+		rsp->hw_caps = HW_CAP_MACSEC;
+
 	return 0;
 }
 
-- 
2.7.4


