Return-Path: <netdev+bounces-103105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019D49064D5
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD78284EB7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475580607;
	Thu, 13 Jun 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gYNuCkMX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3676E615;
	Thu, 13 Jun 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263256; cv=none; b=NPIvvLqvwD9P8CPInyNAq9NnIHdN+NqCKEz5JDEvWtZwAyb4OkiJ/M9blQPA9FvTfGxCoktCvZd93p6y9Q3bdDm+pMU7UFXh+fUCRS00SBl5sDybVLqmD/GTc2jLnNQL4w8vkgYS7sbferTiFjoEJkli7ATF38SUu4Eii6TqV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263256; c=relaxed/simple;
	bh=AEHVBswlkjQBOvUjd20Cyr9UjPWKvxnbwT7zBkVfTfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDWhfjPC7tz/uN5ugnAQKt5bXCV//Q1iDVBxDcS6gr0X+XsjoLwBV9zLNIHGEFja+tAXNBtJM0iTgDqvWUx5EL6UgL9sauOZWQ3lKSu0PcoIZS2YIVuWHBHFoEQbXZKbbaDjuIhWtMq2Z0jEbtRlkaF9HBbM9kHgwrPcKwJFxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gYNuCkMX; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D0BB5t019757;
	Thu, 13 Jun 2024 00:20:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
	botVT4IbYF7Qvxq7K2HKG/36vcerHahhwop0w9ilC0=; b=gYNuCkMXWdhwFSGut
	RpsvLG/nFE75YZ3WBJEyYFOtoQDM3IKgOP4CjoRr5KetmV7iZN1yOcgeh2x0nInE
	Lhgdn4TLSlnaqExgicbbfEJmSqiO7bHgylJu3Jo9TnlXXZdSy7g41u4DNcFaOzp+
	qDxqaEXTm8kzQl9sHHVTEndszkaaDiZ2syfdoDlCPeVXH6IZvtjbSnlkB91qpTsU
	fA5wywlNCbsxSPYi6TZ8sFdrNj+hAvuX+ngwjISxL0+YN+4C5AXilk2PWj28jPTp
	TkrFd37qfBG8/tNXpQYHol6CrEYDH5REqs/CLPQ+ZIcTc9KG0PK6qH42WHjB8cNo
	5zFIw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8syw4m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 00:20:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Jun 2024 00:20:34 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 13 Jun 2024 00:20:30 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v5 7/8] cn10k-ipsec: Allow inline ipsec offload for skb with SA
Date: Thu, 13 Jun 2024 12:49:54 +0530
Message-ID: <20240613071955.2280099-8-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613071955.2280099-1-bbhushan2@marvell.com>
References: <20240613071955.2280099-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fFky_80nxxZCPjupbsiPnpdgMGKCQ9eN
X-Proofpoint-ORIG-GUID: fFky_80nxxZCPjupbsiPnpdgMGKCQ9eN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01

Allow to use hardware offload for outbound inline ipsec
if security association (SA) is set for a given skb.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index d31ab17d7ad1..0db769199303 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -780,9 +780,24 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
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


