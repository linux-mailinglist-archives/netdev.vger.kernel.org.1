Return-Path: <netdev+bounces-111146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806469300F2
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 21:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F87928303A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2B2F855;
	Fri, 12 Jul 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zko+DMfK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6E2EAE6
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812275; cv=none; b=tNFThXuiz/BnA/4EsGPj0x9U0umGSL3/WmI9zvOAy/t5j1TZEJBZIDSUHn+3Ji0RH0zFjrqLKfB7LgvLEX84BJMBijM0sFsMHQGoimmxo0OV6LOGh48HJLO5Chx2Yb4wzmkA5kn5LICk1aaZbr6jCvyptz+TIvYc4F0QQ8vVCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812275; c=relaxed/simple;
	bh=HisMQk32mqetWI0mYkCZ1GswldZYydedA82AyBJFKPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX5m2Tihj2/iyJ55gXyPWVego38xHFYS/qgL+OoGKtFeKUhnxzCm5fLZzxh0MtQgQLQejE3dDjbsVCc8KEf+2MjeErdTe7S2Tfs1MlBlb8+LyL8fbabm4y/Tfv4qnr3dQmtSLhRRoKJGOX3idLhrne5zTtebETO2QwhCdnCopDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zko+DMfK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CGTYMN018477
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Ykhv440dsm8zc
	ec/0AYt4Kh1tFKTjpGggvxF4rBTUGU=; b=Zko+DMfK83yUY2p1fkOEQ5ztC1H1w
	3IywzmfxSwiQ0ea4WbK+1OuAcs+z1HW1p4QTjH7aHiFPPH9FS9jcvJMsZm9qJuKM
	8kOq/A6A7YWbc9dBDf5s9hYzTqS3gnZ0y0XKmh5d0ZiEQ3jcO4vfCE/pmwWdaXq+
	CXDEkqzXgiHKLSO4EwaWwndZV/VY1hMVEgVfcvEgufBBqNNpbCjayqhDy9vOEGdk
	eaZq1LP8axEPUJU+xrPPaVRVhwAagLsENZET8+Mwg69KZmmkf8hY9NSLwGjUWCA7
	gyWYgXY7ENEdRZt4v22FviU5IBjXxAO961zfIt3d0iVMy8LYljvRNlmBA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40b81n8bux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46CGulVt013962
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn18c5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:25 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46CJOMLh41156934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 19:24:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6203B5805D;
	Fri, 12 Jul 2024 19:24:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FE4F58054;
	Fri, 12 Jul 2024 19:24:22 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.16.211])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 19:24:22 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Nick Child <nnac123@linux.ibm.com>
Subject: [RFC PATCH net-next 1/1] bonding: Return TX congested if no active slave
Date: Fri, 12 Jul 2024 14:24:05 -0500
Message-ID: <20240712192405.505553-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712192405.505553-1-nnac123@linux.ibm.com>
References: <20240712192405.505553-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nw_SLnhQJRe7OOlwjOU-vgjIhax1Ko1L
X-Proofpoint-ORIG-GUID: nw_SLnhQJRe7OOlwjOU-vgjIhax1Ko1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=909 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120130

When the bonding device cannot find an active slave, it is safe to
assume that monitoring will eventually call carrier_off on the bonding
device.

This means that eventually the bonding devices qdisc will become noop
and return congested. But, there is an indefinite amount of time
between no active slaves and the bonding devices qdisc becoming noop.

Previously, during this period, NET_XMIT_DROP was returned. Upper level
networking functions react differently to a drop vs congested.

Therefore, return NET_XMIT_CN instead of NET_XMIT_DROP because it
accurately predicts the impending noop_enqueue return code and helps
to keep sockets alive until then.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 include/net/bonding.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index b61fb1aa3a56..22da0916d4a6 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -805,8 +805,15 @@ extern const u8 lacpdu_mcast_addr[];
 
 static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *skb)
 {
+	struct bonding *bond = netdev_priv(dev);
+
 	dev_core_stats_tx_dropped_inc(dev);
 	dev_kfree_skb_any(skb);
+
+	/* monitoring will trigger dev_deactivate soon, imitate noop until then */
+	if (bond_has_slaves(bond))
+		return NET_XMIT_CN;
+
 	return NET_XMIT_DROP;
 }
 
-- 
2.43.0


