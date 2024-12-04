Return-Path: <netdev+bounces-148826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700939E3360
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355E0283985
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FB518FDCE;
	Wed,  4 Dec 2024 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c2pDv7qA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E3190058;
	Wed,  4 Dec 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291870; cv=none; b=gKzVel4unS16Y9HlpTaU6z4h/vYfO/cP46GFh1kjjqn0hmg/SsLN7XqhCGR29cyrVuucQCDULSFKvy8SsqN0T/aUE+HkT5i6VkFwiuaWnhXLEKixuzenxUgwdtHI2VCGZIJJ9RLu/KhrDqTF/hJBfTGI6myaPaE9PvlPCZbN7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291870; c=relaxed/simple;
	bh=r2xSv/bIyCbYXwU7TwHb6Z7wj50VNUkv091+IDFzgLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmwbFO0CG9rqYvszEFe85MS4z4urgOGzJFN/S89Myw1419X13FxhRZtP3ADlt6H6ravof9c0uZ+BVNciFChT29Ql1LKg9/2UKL1Xsves54Th9QP7omb1phxJYVECDANvFZqQLSiELuTHSp0N2HTDkzMkAK2aSfkRPhVO8ZgbVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=c2pDv7qA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B458qX5008983;
	Tue, 3 Dec 2024 21:57:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	Xwxq7ACZ13H2CEJwcwr15IemMq5bVZgqKnzkKElXJY=; b=c2pDv7qAzVtM870aJ
	tIOjOQUSCqXlWSozjQJJuF+C4TyhkgPUbw+8uXJYt0x6DLCtfY9viThe96I4xFIf
	Ph9lLRD+uKhkxr7GMcYPC/k/1ylc43RNn1Oq4gzznTF4SoWg8SD3el/06I8+5FYn
	k7b591GAdgv1m7peCqYaKwkblzvZ/oivzCzMx59ytmCJu2x6PHayUt3VbmDogiPn
	BdcK15Of6dmx49EoMxw0gNWD2CghkhUD8WgOw8JPQtnkfjGODboHqASFEf73I8xt
	UwQvA8EUNrC2SO6huNK6hesom3fr2rk6SUvT3sEhFM+bR5JdWOqM+ee9j0NMLXS1
	3fDVw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43agp682f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 21:57:41 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 21:57:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 21:57:40 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id C3E7A5B6923;
	Tue,  3 Dec 2024 21:57:35 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <andrew+netdev@lunn.ch>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>
Subject: [net-next PATCH v10 7/8] cn10k-ipsec: Allow ipsec crypto offload for skb with SA
Date: Wed, 4 Dec 2024 11:26:58 +0530
Message-ID: <20241204055659.1700459-8-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204055659.1700459-1-bbhushan2@marvell.com>
References: <20241204055659.1700459-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IqVTGmon1KeMW4FN1dl4yUWItEWOkVvm
X-Proofpoint-GUID: IqVTGmon1KeMW4FN1dl4yUWItEWOkVvm
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
index 9a9b06f4c2cc..e9bf4632695e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -746,9 +746,24 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
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


