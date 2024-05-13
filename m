Return-Path: <netdev+bounces-96001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9E88C3F64
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780242888C6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9291509B2;
	Mon, 13 May 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FtziRJAo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130B14F9F9;
	Mon, 13 May 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597743; cv=none; b=jjLwuHRR3wkhjzLWTYonzZHVJMvN7pPtBDppWT1CbsGo2R9CKVV/mSi16XVm1OzGW5tLXU8DbkjidYlGaCXzS4PkmebhnTOhH41dkyhsalg5iw4IRwQwzx8IpZ5rbOjAuuFLAcQd9+rxaTzrtsonQdf4bGJZIX86FuHP24pkCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597743; c=relaxed/simple;
	bh=KUR9/e+ceU01mO+FO6bSJMXZEpZj9wIlC7zhuGBJzAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANum/5nvvx1PH/2H7y6267bNwUnN2k/Fq1K1MBltuoFAYfWerl+rUvs3vZdem5AANQluc0ClmUYypCcoaUxFLtVp4CH/kfLMPE9lcHm5IKaxM/HvfHUsA+2Du/gf/RE41XoAk8jetnxKbDLkCyPjrW9u7fWQuqoD0oxobXDzNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FtziRJAo; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D9g5tT015038;
	Mon, 13 May 2024 03:55:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=Z8CJgyx2WPWwQzkT/A7MPbfhsgCpodtu13WZW1iBDbw=; b=Ftz
	iRJAo0F1K2LowniIpwv0QMAApK1TVMUeGGYoz9rXTeK3cav4aysxIXU0A6kTGbbP
	PwlxnSuQIwBSUM0pSE1t+8CeCrheQ7k2osVeDV2lMxNOW+bfcYv26tgLMyWZLFx3
	NIrTeUZx9RdJVBy0S1sWYOgxLWnvFqiCi/mXckdvM5Z1+ASKOI75TwsGAWk/1lQ7
	ZvOE0peo5u/nvU1wCNHaNXszrIsaKeJKhGBcvzLQUZ+Hcl1RF+/b9RCHXVvL/rmU
	HUbni9bMLqvzLf+yc+ZQc0y7XJte1lgehB0TPshuS/QBHVKlI3/k5Ia5m3VagxIQ
	UadqgkPGDncbhaDoELQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4g5jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:55:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 13 May 2024 03:55:33 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 13 May 2024 03:55:28 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [net-next,v2 7/8] cn10k-ipsec: Allow inline ipsec offload for skb with SA
Date: Mon, 13 May 2024 16:24:45 +0530
Message-ID: <20240513105446.297451-8-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513105446.297451-1-bbhushan2@marvell.com>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3JBEnWo25IQxpleC3DVQ-xR_8knIZGh5
X-Proofpoint-GUID: 3JBEnWo25IQxpleC3DVQ-xR_8knIZGh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02

Allow to use hardware offload for outbound inline ipsec
if security association (SA) is set for a given skb.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 91c83a2ba6b1..5375bffe8a90 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -768,9 +768,24 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
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


