Return-Path: <netdev+bounces-95863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABEE8C3B12
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBD7281608
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A0A147C6E;
	Mon, 13 May 2024 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Fq8hGNnf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1F1465B5;
	Mon, 13 May 2024 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579228; cv=none; b=oJd2zqiPAI7qw2pO2koeuk1Zav/3RpkygBGBsCNL2dJ52ejH1YTABBBCc6uJ8WSWTo/tMnQeie0jKjQu56lW66Alca7KzI01vmLiO+K/4pZqCqR+Qv+DbrGk8bpf+mMvIDpFow5wPT9u50P0U3RGVh1bA8JN36vyTXE78MbyKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579228; c=relaxed/simple;
	bh=guVd29ZqGYtK1XsQ55gSS+//1SW6fgJwX72cm4L6Ej8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiifEtdXNEKM5itqsVETxy8j1PpuA63QlzO7dSUAgnGjq4bQyNQ3OEOqctGb22gp/wVeEYsYcKuBIzgqPwgduVtqqGj5BFb+ClDGf/P2igRUiiqhdWCncV/GlUBDkKN4zss8PoM8bkYi/wTQAkZmQxgjySZmCKnINd3gPCmurvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Fq8hGNnf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44CMhlWc005185;
	Sun, 12 May 2024 22:46:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=p+/gdlGfDKH/5/E5NftrHXp9fUeRUy+AaPfiQbo+csA=; b=Fq8
	hGNnf/gUz/ImYjFoOR7ibK62R5bK4msMgaHUdS4A7nXYfNaezmN4WlZhlHi5ON6w
	RuCPUvdDbsuYidX2A6GMON6etC1tkfYemtEDK++SOiiK5mRGyYmUMZ+fD48HAivl
	c3QEQgSO3XBzVJl0kx0LayUnGn0Q9suLbPTNl+tJTMuN4GLhGIC71xajoOwDC/UB
	JyGyZtnRpVrz2qO3iPkWYqTs9o87cM0eI4XZsEDmX44ehxt/TngiTRDnV+4zbagw
	81q2nleqY+wi2vdUPfHZPou2j766eGI7eUXolidfQJtlMPRRh8ffzgwx9wtqgfdu
	wPez3RSA0MQeTjB/PMg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y261jucwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 22:46:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 22:46:57 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Sun, 12 May 2024 22:46:54 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 7/8] cn10k-ipsec: Allow inline ipsec offload for skb with SA
Date: Mon, 13 May 2024 11:16:22 +0530
Message-ID: <20240513054623.270366-8-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513054623.270366-1-bbhushan2@marvell.com>
References: <20240513054623.270366-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BG83G_tCGF6bLa2d0rnuzxd4KyvFfz0W
X-Proofpoint-ORIG-GUID: BG83G_tCGF6bLa2d0rnuzxd4KyvFfz0W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_04,2024-05-10_02,2023-05-22_02

Allow to use hardware offload for outbound inline ipsec
if security association (SA) is set for a given skb.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 98a200879b3b..8fbe39458e22 100644
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


