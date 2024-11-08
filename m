Return-Path: <netdev+bounces-143199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABA9C15D1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA601F2413D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0381D63C8;
	Fri,  8 Nov 2024 04:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="baBanfWB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2EF1CF287;
	Fri,  8 Nov 2024 04:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041888; cv=none; b=Dz4vUEi2mmFn0/aYJK5eDXOKJAFeH5bTvUAvCHWrkjdGnwdM5wm5hBxDaA+2CKutYlaC48eitNKBBG/Ud1TtBQDikCJZUvb8dlcQWxNBvQX4EMr8BHrV7d3C8AS0oQKJLikH3fbuWnb8Z+9odAoZPjQzchdba6q6HQoLnUdPm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041888; c=relaxed/simple;
	bh=I1jAizqYragDf6W+OUpyqLIgjCzRbECFniVxqbRsrFc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sd3QKuTWb4XrGV3QlWSz8geIKr+AEd4Td07EqnknviF1PLDYdHmB79nLuz2qTjP6ST1wgDop9UGD77e5eBnF3l5M7C36cCDlAYz7sLrncN7euO7z0A7B8BizR/P3WqzLy85J4NRYJciKaiUUjcBD/mO7jFjBuIienBRx/i4G0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=baBanfWB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A84EBWL027930;
	Thu, 7 Nov 2024 20:57:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	xVG5mnA3SI7mUTLyUfbZ60SSzbnal3uSlkV1JpuIeQ=; b=baBanfWB0/AK947gT
	DfZdPUAnNFZgkMhxdSwImp6Qm1NClBOU29nb8weZsN/w2QGPKiuCqGiTFAYcwRX0
	93Lc6Y/qOoyYeqAXQROb4cRaXAmG9E684PGmRttRztq3wnaM4b491qIEPXjMA1K8
	bxRtwbEqp02JQYLJlhf37u35Ebk2ZyB3n1LEKV3IDnzOM5tK9qfLGCmizXa9f6Pr
	reslQDez+BrBRFR8gDmwlSzorLqxRo7M3yfHT6tGlupyrGh6RICbo+Gx8nbeqEXM
	4FpE9Hb2ru2g1ENHpDAZ/4ANW+dQQ7KIhZ/h/SCMY7dxZqE/Ok+v6ttNx5Zg0w4q
	b7QRA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42sbdq021w-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:57:59 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:57:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:57:48 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 59FA73F7044;
	Thu,  7 Nov 2024 20:57:44 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <sd@queasysnail.net>, <bbhushan2@marvell.com>
Subject: [net-next PATCH v9 7/8] cn10k-ipsec: Allow ipsec crypto offload for skb with SA
Date: Fri, 8 Nov 2024 10:27:07 +0530
Message-ID: <20241108045708.1205994-8-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108045708.1205994-1-bbhushan2@marvell.com>
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7OtWnUwL1ussl3HhFAjzIRYfQ-AVHXLJ
X-Proofpoint-GUID: 7OtWnUwL1ussl3HhFAjzIRYfQ-AVHXLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Allow to use hardware offload for outbound ipsec crypto
mode if security association (SA) is set for a given skb.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 3ab0dc7ef66a..a6da7e3ee160 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -747,9 +747,24 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
 		queue_work(pf->ipsec.sa_workq, &pf->ipsec.sa_work);
 }
 
+static bool cn10k_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
+{
+	if (x->props.family == AF_INET) {
+		/* Offload with IPv4 options is not supported yet */
+		if (ip_hdr(skb)->ihl > 5)
+			return false;
+	} else {
+		/* Offload with IPv6 extension headers is not support yet */
+		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
+			return false;
+	}
+	return true;
+}
+
 static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops = {
 	.xdo_dev_state_add	= cn10k_ipsec_add_state,
 	.xdo_dev_state_delete	= cn10k_ipsec_del_state,
+	.xdo_dev_offload_ok	= cn10k_ipsec_offload_ok,
 };
 
 static void cn10k_ipsec_sa_wq_handler(struct work_struct *work)
-- 
2.34.1


