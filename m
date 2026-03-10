Return-Path: <netdev+bounces-265833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOKWI3dur2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:05:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C32434A0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB10D3021960
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3454B2DCF46;
	Tue, 10 Mar 2026 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BlRiaOTW"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF82DF156;
	Tue, 10 Mar 2026 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104720; cv=none; b=KsbzrCu56cqIq2ak3N5kZQepH7ylYNB/50c0+0X5/GFDUt9afi59FgmVR5x+S/AGAxpFPuM46PBZ02WqMj1r7ANWWB2EGR+uQB/293yUu5NeBwaTN61fEc9at8ffHjn6CXp1wLVTz6Pdc15yiDVA31MnScQWRlkzTetO7caZu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104720; c=relaxed/simple;
	bh=t5A1ZYVRo1ibd6Jui54nqriIzyGimwQzrN1hpFd3A9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atCdCr8+aevQdpbdmiYXAC0YWHJlVniqcIuqpapT0/0GcxQL6ceMW3e2DsboU+Jf7DMr4bcnLhQAXOYLSh3ufyT0QUTzch79rTkp+Ug9U0T2CsLbNrHZB3OTdly7437BbnHUG2KfkwsE1QSBdxv90rIu2TzKRe8UrHdIYib0zbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BlRiaOTW; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a1aNGSXdmBTHdkhrjeSVicxR6DHeNbVnsDvWs42CYxQ=;
	b=BlRiaOTWzzEfNtbmD/PQHNZ2dwxkcax+nPsZwjOcFDC5ZW2tTFCweZyVDTxxLZoSndsxgANnq
	nqt8fHCL1nnR4Ck+x0hGWbzVwmwJjxmlFPZ/+C4RIuBE17i8FEOlkKQoCEn2xrsrLnYuhUG6PI3
	hQNim0l1FyUu01+hy0i/85M=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fVFsq3syfz1prKR;
	Tue, 10 Mar 2026 09:00:15 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A41A20104;
	Tue, 10 Mar 2026 09:05:12 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Mar 2026 09:05:11 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
Subject: [PATCH net-next v03 4/9] hinic3: Add RX VLAN offload support
Date: Tue, 10 Mar 2026 09:04:52 +0800
Message-ID: <22cf02a014c2beb7b5f92ab5e6de38c4dd928125.1773062356.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1773062356.git.zhuyikai1@h-partners.com>
References: <cover.1773062356.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Queue-Id: 511C32434A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265833-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

  Add vlan offload processing in RX process.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 15 +++++++++++++++
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 1236ec233b7f..309ab5901379 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -328,6 +328,7 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
 	u32 ip_type = RQ_CQE_OFFOLAD_TYPE_GET(offload_type, IP_TYPE);
 	u32 csum_err = RQ_CQE_STATUS_GET(status, CSUM_ERR);
 	struct net_device *netdev = rxq->netdev;
+	bool l2_tunnel;
 
 	if (!(netdev->features & NETIF_F_RXCSUM))
 		return;
@@ -350,6 +351,12 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
 	case HINIC3_RX_UDP_PKT:
 	case HINIC3_RX_SCTP_PKT:
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		l2_tunnel = HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type) ==
+			    HINIC3_RX_PKT_FORMAT_VXLAN ? 1 : 0;
+		if (l2_tunnel) {
+			/* If we checked the outer header let the stack know */
+			skb->csum_level = 1;
+		}
 		break;
 	default:
 		skb->ip_summed = CHECKSUM_NONE;
@@ -390,6 +397,14 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	offload_type = le32_to_cpu(rx_cqe->offload_type);
 	hinic3_rx_csum(rxq, offload_type, status, skb);
 
+	if ((netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+	    RQ_CQE_OFFOLAD_TYPE_GET(offload_type, VLAN_EN)) {
+		u16 vid = RQ_CQE_SGE_GET(vlan_len, VLAN);
+
+		/* if the packet is a vlan pkt, the vid may be 0 */
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+
 	num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
 	if (num_lro)
 		hinic3_lro_set_gso_params(skb, num_lro);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 31622e0a63d0..06d1b3299e7c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -15,6 +15,9 @@
 #define RQ_CQE_OFFOLAD_TYPE_GET(val, member) \
 	FIELD_GET(RQ_CQE_OFFOLAD_TYPE_##member##_MASK, val)
 
+#define HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, TUNNEL_PKT_FORMAT)
+
 #define RQ_CQE_SGE_VLAN_MASK  GENMASK(15, 0)
 #define RQ_CQE_SGE_LEN_MASK   GENMASK(31, 16)
 #define RQ_CQE_SGE_GET(val, member) \
-- 
2.43.0


