Return-Path: <netdev+bounces-228200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D569BC47CE
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 13:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E0E3AA2FB
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ECD2F6164;
	Wed,  8 Oct 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hzyk49Pa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1E46BF
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921230; cv=none; b=aN+BDmfo7qnKsp01CCp4xgDnjFF5GwMHrdjoCOEtmbSm/YHj/AEGkiP4QBET9yAiyx+rk/cRm0PfP0V1nro38erAQKyWBOHhSwiPneXrbOJpIucctEROL8zZluI2L6x0nbRBphAgO1UDL3OQGlql0wnwpWuqTuVy0AUKY60Sb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921230; c=relaxed/simple;
	bh=DMDLqAxGvfxYLLXVkUc7oZOxgv5Q4Bp+XqEMyh/04Tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cM56gUPBNfkHxxKRmNbC1KEilR5rErVqp6n92CU0RQ/Mhry7uw8IZGBAi07yReWNHPs7kcW675fhgV7a0eX0jQC3wDJ2tpfwiVX47uUnHNKZU10lxKgUWs2yEZ36JtXxt0HkWN8q9ow9zETL2ahhSuwpMHsXwmN7+t+TtVU6IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hzyk49Pa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5985vFNH030966;
	Wed, 8 Oct 2025 04:00:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	+JfJUBIPlAHGggebfceQZ4CBuFZijcQqS8VfV8TY9c=; b=hzyk49PaVsMw7Q2VE
	5jBJVBpj5TLXa73WImurkZaS2PbJVW8j/DlEE4plyEziixTwyp1DucPLZywAcrf4
	wqoKRyvOY/nvTeBkjdTCTVGHsGGyUxRBlJN58W0hP1u0sVsJg7I7fo7XVKZRHONH
	FyXKoFkBIVNT7HmXScD1oAPomCQpBHZIUc6PJrHrcUylY23oj+6GVCUh49EVWyMj
	aSSME7H+jsQwMpH4oobpwHRURqjO05PVA+lp0MQ9/BU9eeLBx8VfoyfyIzOfhbsZ
	cYRlkn6GfZQ4FjVY/CnTfrN9rLlFyLXiZeX1h2rtR3QFYSMjUbNuotiIHew0QiqE
	MGh8g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49nj8t0fwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 04:00:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Oct 2025 04:00:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Oct 2025 04:00:13 -0700
Received: from 5810.caveonetworks.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id 0DDCC5B6940;
	Wed,  8 Oct 2025 04:00:09 -0700 (PDT)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, <jerinj@marvell.com>,
        <ndabilpuram@marvell.com>, <sburla@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v2 net-next  1/3] net: implement virtio helper to handle outer nw offset
Date: Wed, 8 Oct 2025 16:30:02 +0530
Message-ID: <20251008110004.2933101-2-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008110004.2933101-1-kshankar@marvell.com>
References: <20251008110004.2933101-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDAzNyBTYWx0ZWRfXwh6SXolXpjkX
 Gv2iqn96Fwj1iX5A7+Q+GCbamW8HKbSsadN0ZnZYNLaj+DfBJCVY8HJC/BmPcPF5SiLeeanlx8x
 B7l9MooGG+5GyheDJOStjMX291T2kKbVaQsllzG8QF8SGbFa7dK06A5S+aRW/BgOoCH0Cjm+RGl
 GYxKOxW1Kl+RieGnRF4n2VgpsZTxR5lLOWsE+m07wDSkXENHyesnmHzCvWZ4GieWvXGSrc2/oMh
 2n1Xgoap5OgY+oWOBDMKd6tQgdFjt97F5b89v0TF3eWUEhcri7BKhmfcM+XT8iCjxSkHJWGDQES
 4AZR5nF2og6b2F09pktTxlPbj6igzhmUh3S+1LP6e/W8VrH+ts6xhXqLDd/sDoEyJn2n6i+XK70
 ZBgtip6PfndAbEtrLkjXmek/RqIZjQ==
X-Proofpoint-ORIG-GUID: TfNttCXlxW3kkdb6Yz0tlyrfLAsdcQ1c
X-Proofpoint-GUID: TfNttCXlxW3kkdb6Yz0tlyrfLAsdcQ1c
X-Authority-Analysis: v=2.4 cv=fuHRpV4f c=1 sm=1 tr=0 ts=68e6443f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=rBhPDSTWFrAT6I7GfMQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01

virtio specification introduced support for outer network
header offset broadcast.

This patch implements the needed defines and virtio header
parsing capabilities.

Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
---
 include/linux/virtio_net.h      | 40 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net.h |  8 +++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 20e0584db1dd..7ab872a11a21 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -374,6 +374,46 @@ static inline int virtio_net_handle_csum_offload(struct sk_buff *skb,
 	return 0;
 }
 
+static inline int
+virtio_net_out_net_header_to_skb(struct sk_buff *skb,
+				 struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr *vhdr,
+				 bool out_net_hdr_negotiated,
+				 bool little_endian)
+{
+	unsigned int out_net_hdr_off;
+
+	if (!out_net_hdr_negotiated)
+		return 0;
+
+	if (vhdr->outer_nh_offset) {
+		out_net_hdr_off = le16_to_cpu(vhdr->outer_nh_offset);
+		skb_set_network_header(skb, out_net_hdr_off);
+	}
+
+	return 0;
+}
+
+static inline int
+virtio_net_out_net_header_from_skb(const struct sk_buff *skb,
+				   struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr *vhdr,
+				   bool out_net_hdr_negotiated,
+				   bool little_endian)
+{
+	unsigned int out_net_hdr_off;
+
+	if (!out_net_hdr_negotiated) {
+		vhdr->outer_nh_offset = 0;
+		return 0;
+	}
+
+	out_net_hdr_off = skb_network_offset(skb);
+	if (out_net_hdr_off && (skb->protocol == htons(ETH_P_IP) ||
+				skb->protocol == htons(ETH_P_IPV6)))
+		vhdr->outer_nh_offset = cpu_to_le16(out_net_hdr_off);
+
+	return 0;
+}
+
 /*
  * vlan_hlen always refers to the outermost MAC header. That also
  * means it refers to the only MAC header, if the packet does not carry
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 8bf27ab8bcb4..6032b9e443bb 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -86,6 +86,7 @@
 						  * packets with partial csum
 						  * for the outer header
 						  */
+#define VIRTIO_NET_F_OUT_NET_HEADER 69	/* Outer network header offset */
 
 /* Offloads bits corresponding to VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO{,_CSUM}
  * features
@@ -214,6 +215,13 @@ struct virtio_net_hdr_v1_hash_tunnel {
 	__le16 inner_nh_offset;
 };
 
+/* outer network header */
+struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr {
+	struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
+	__le16 outer_nh_offset;
+	__u8 padding_reserved_2[6];
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.48.1


