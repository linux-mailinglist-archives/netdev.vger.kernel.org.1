Return-Path: <netdev+bounces-102876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E74E905419
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF841F27017
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717517DE0E;
	Wed, 12 Jun 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ns1LJXid"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6017D355;
	Wed, 12 Jun 2024 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200040; cv=none; b=ANzwBwyNJvtbGeR6F4dDDLQwlK9MT/rjW0VdVbZtJcoFSN+DfjbwkONdEUMK/YaxXHEzt+8iu8R6GNAPsEm66Epa7gKQrQe8Dwe9izTqXnLtS4DB/sadz8zwAdtWDbCLVW1z7MjlJOtSldhZw9oJBaKS/HDPrIeElaiHqdpjCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200040; c=relaxed/simple;
	bh=yQ5hlaVNFiX+2WgPaHU4Z5cv1zCIF1eR4USxISH6q/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFPkIAOBbnaFfHovylwhlzWKurg4+jcK9GqDZEsHAYqGROI6y0quoKItt9Js3Bq4iWJaEfVyo2E65XAyhDd3Kl1mktElrFsrKq7LtSz0UqZW/tUMlBQzej14YHrQz1tIIitS5I05LiKZpK6CTVtrd4KTBOZiiJKZHoRLfPu6+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ns1LJXid; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C953YP027260;
	Wed, 12 Jun 2024 06:47:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
	CT1APQ7p+lJtPVAAHhcslW8nV0urY8UzR6KsdcBO2c=; b=Ns1LJXidziNJH9019
	bo21pxB5cKfndrq9ZQGK9ndiUy4fctXefxby++aon9+npOrKB0Fo+GdYnKm8Da7T
	kvxhjv2zHDu4kCxZiwH8erfr0btNQCzjORYc7uU5jFHBjCwugbEzn63upKlP5nR4
	iXWfndkNVH5UOsLrfwrH9Sm0M4HaAg5JrPT07LrlA9F9ZJly1O9j8HNKLsv6Qlo5
	ZOPkJ5ISPGBcJJUtWHaaQSxl3n6ZacH7qKyYLtfeg+SCEEsFkQyeYN0joUPv86Uh
	YO4/FPUejCQc37SmJIJH1PVWLDsAKXe4Q8W5VxO3d+Nc1PH4B7cvKrNe4yDUmDIq
	H8AMA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8qx0u4c-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:47:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 06:47:08 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 12 Jun 2024 06:47:03 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v4 7/8] cn10k-ipsec: Allow inline ipsec offload for skb with SA
Date: Wed, 12 Jun 2024 19:16:21 +0530
Message-ID: <20240612134622.2157086-8-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612134622.2157086-1-bbhushan2@marvell.com>
References: <20240612134622.2157086-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BqYEPzPpw-yXzha9QQOen1gAlAz2fi6s
X-Proofpoint-ORIG-GUID: BqYEPzPpw-yXzha9QQOen1gAlAz2fi6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_07,2024-06-12_02,2024-05-17_01

Allow to use hardware offload for outbound inline ipsec
if security association (SA) is set for a given skb.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 0dc94a39aef3..2f63d91db9ad 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -788,9 +788,24 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
 	mutex_unlock(&pf->ipsec.lock);
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
 
 int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
-- 
2.34.1


