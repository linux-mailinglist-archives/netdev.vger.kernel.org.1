Return-Path: <netdev+bounces-287453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJrBCW0nBGqDEwIAu9opvQ
	(envelope-from <netdev+bounces-287453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:25:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE852E99D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 047D13058D9C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0413D646B;
	Wed, 13 May 2026 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W+qEYULj"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012F39A063;
	Wed, 13 May 2026 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657051; cv=fail; b=tSLhUhIJebbMgYbOIMbUCUzRzkBDAxnoR5xr+rGkCfz+SWZCfgwNbr5QBi+MnAP1RndUXADW/gYRe3HSpOU3uJi8wrF93BMiTWPXANmh/Grb9Bw6+BI+QYZA8C8BasHyOKKsEu5+SQTOackahDstarMzqrTgSm5qwXMVQOqXJNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657051; c=relaxed/simple;
	bh=Bpa0qyMi0x+wGb9sUV+c89i0DVx5Cx9P2OoAXbwc6j8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SY0Av4pVDlOYGWKonoyGJqKPpQgVpEJSKhkF2osNR+pkMdUPOIPqagwLif4jBwUcMjQz8H2499p01k9ac+DOS5cbxbSMs1CIpmBudF9Eiy3Gd1a4ROWkiLS39TGTrxbz+XHh+rAdks4IFtNgP1UeZMIYszL+D3TX3ULXWrgqyhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W+qEYULj; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIc5hxYnHV20oPCNxGXfSF9d98RaBWP2GTf/Q3Huq9jBZtxZxBgLvgjwyBQtsP+qpLUBAfEvWUm4TJGWB+wJQiRaMWLHrc9Pp7i8kQ0B1K+1CnDzeJgUejUxspMWA/8+yDlrvqI4pcy7W7sALjwwU234YKsf+6BjrF/bb9k1CQGIyHXI+6fmH2Oq8MPX33Olq7Oa0G1hhP3glhjAzCt8ziI/LzCx1FuL7a3mhbgx+vB+elKFizvxKGTV7qlV+A8+HcYxkl5/YEVw65v/zG7yopCofWcHSv6HeToAYm+yx78S/ojL8fj47c7bG9hPAgv3aolmeYe9VxBkPR/RrazjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKqbeFM/fxn82sZeoKMSZKrjEBvo+DbAc7+95doLiQw=;
 b=Lj/2R0o+/JgHJ6lHB/vemYkbA3/Vl7dYxuu+cbsYsrhIwWY/6JksDWfAjCZ1/ENGA2xEXRnwezF2CnG+E6Wknh/wNmMnDM9WggQrZomzII2vPRQaQnQzHGykIBustGb7TNWKozPaznL+JswOYOwt0QrLAn0mAB82ja8ROqniUHnRkB/EER7aDnyt63GSKk61M1ez3N1kW3gdB1dsNtywcd/32+hp65Ca5BCHxeY8m6kd/TfdspDzi/WqszsKUsFBxv9VTYW2a5s8e+5ffMdjT6XeFJb34bgVw+Qmtc1vxvVIgQFRU0rdUqRFitQgH02U277QLzP93xtI/xk+rwtGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKqbeFM/fxn82sZeoKMSZKrjEBvo+DbAc7+95doLiQw=;
 b=W+qEYULjBZepKaQxEzVjqtElyZd+TZC7C0tZyx9XIX7GWLwdFC5fELSWW00i0FI7EdBJw7412FO1rPd7NjNzR94V9G+H7elPC9OJ3e2sZRrUuAxDJA63cxcERO0XO7UBsE7d1OzG1inE8b7omSvOL2JgISj7yk7NrsogZUlWN2j1SE1CpqonchFei34fyPyVdjqNLUL2+nORrAv5ctilExpLiRdAUorYdHjTGGxN0gUus86eZ3DyltiypMAkT7KNcV1kEeV9jaseNTxtbA9Lt0jvumvlp2U/XqPiY4BPGqLubo2QHqGp/y0U52tSO6DUiay4LdUBTMw7mGw+aAdpAA==
Received: from BY3PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:39a::35)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:24:05 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::c3) by BY3PR03CA0030.outlook.office365.com
 (2603:10b6:a03:39a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 07:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:24:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 13 May
 2026 00:23:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 13 May
 2026 00:23:45 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 13
 May 2026 00:23:39 -0700
From: Nimrod Oren <noren@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>
CC: Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, Amery Hung <ameryhung@gmail.com>, Martin KaFai Lau
	<martin.lau@kernel.org>, Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Nimrod Oren <noren@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net] selftests: net: Fix checksums in xdp_native
Date: Wed, 13 May 2026 10:23:55 +0300
Message-ID: <20260513072355.1083381-1-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 743389ea-446e-43c0-677e-08deb0c09cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|56012099003|18002099003|921020|11063799003;
X-Microsoft-Antispam-Message-Info:
	50MjZ8BoJsIa4wTDfKYkTr8i6SUGq/IIaYEDnjZHzqFFha3RwRA6tTTZixxcXV++gUhiE0irZZnUeonFK9KtCkJo0TBo/yaFd7QMIYpBhFHBcoYIyt7v9xyt1OgzTwW2BMDC0lmHIOPivA2dKZyE0+/ohXLQw5h99ooP/0xosDFdlPv6o2Z5am0r4FKByyZuaEb/+aOPWBEnmHSSikYiqxKoaeBZGcqRhr5/9R9ThFsS2UbRWOXq5deup1pD1zzRJYkCmJ1eqRTMjbX/ucJSLQtVKPEQ+wFwSAdZR1tgPoFVqkV+LTHrDU1zrnXx3mzNeD3vCwILFZdRrSTyp1T0qdAx/a23Uc36ZoyRFElHtsQ/GjnSzhMRZJ+k0KuQlB0XfUJ9lUU2VjvL9CcKx1kQAvPEwK0ki3YruY/NZos6RYI4MyD+nC4iP9VYT6MtRdF3Lwqg/g8zyogUGuQtG24A5PGtPKNCcjgpW85Z1+DCQPtQ36FQ2c4gY9gf1FofA/PFrW/Hr9EbCR/PwCXsPbeTaHuk82uKGpK93IpH0Enm8jc/l9VOEqrYnDdL8LKYV4Rci4PITUIpf52sUeTDRbXjNRRta61tonLz6ULnU99QHsXvzSQNYJevBOlxblbsXfShLWfg3nKEqSRsn+DeRfQHSXAe705IU0o1zHfksmfQkWBqhTfqZFroR+42g3VMV663O+BrnrLcxCn7d8TGkQyHoFNaiPxrW516umBeTUKXGCQlfqOMZLaTiCvCgnVrgGUMAak384HUAnNkNQ5HiULxKA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(921020)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xHhvUJ9fq6gdFJtFDjsemsHf43E52Y8u1WQKJU5eVy35RBH1aRpk13DuKCQWJFUiy7rUtwcnzFdDpKfBqNSmMxr4soXvgCojgjjicsrP5zG4HFCqhDvpWdhW2UoTxosgLTNbhpaPZzTEBxla4hkp5bMnNTr3kSd49o34YLUVpuFk8agtKqMrE/gDoG7C00ifHpd9URFwPyjMici+IdzKCtsD9MqCQnWp4RSyH8bK1HLQlCPIxRQWOuVbEJe99bxA19Kz6jUgtejulcxyPRhnK0S1u8lXzcwiF+RJx37cXuQm2FwxdEGeqtI81aNxLHCS5gDSv1kFCB2nxuCnsdl80naCRMw/iUSXpHuhCzrSBtRAm0bKoy6tUOgQlO0udKUXvuKk0yfYc8TqWa5UXW65xAW/duJP2Go5jnSkkJtN6tYodr5xJmlZa4OjSKrka1IN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:24:04.1916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743389ea-446e-43c0-677e-08deb0c09cb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
X-Rspamd-Queue-Id: EADE852E99D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com];
	FREEMAIL_CC(0.00)[fomichev.me,gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Data adjustment cases failed with "Data exchange failed" when using IPv4
because the program did not update the IP and UDP checksums in the IPv4
branch. The issue was masked when both IPv4 and IPv6 were configured,
since the test harness prefers IPv6.

Fixes: 0b65cfcef9c5 ("selftests: drv-net: Test tail-adjustment support")
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---
 .../selftests/net/lib/xdp_native.bpf.c        | 54 ++++++++++---------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 64f05229ab24..eaecfa58b967 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -268,6 +268,16 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 	return XDP_PASS;
 }
 
+static __always_inline __u16 csum_fold_helper(__u32 csum)
+{
+	return ~((csum & 0xffff) + (csum >> 16));
+}
+
+static __always_inline __u16 csum_fold_udp_helper(__u32 csum)
+{
+	return csum_fold_helper(csum) ? : 0xffff;
+}
+
 static void *update_pkt(struct xdp_md *ctx, __s16 offset, __u32 *udp_csum)
 {
 	void *data_end = (void *)(long)ctx->data_end;
@@ -281,21 +291,22 @@ static void *update_pkt(struct xdp_md *ctx, __s16 offset, __u32 *udp_csum)
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
 		struct iphdr *iph = data + sizeof(*eth);
-		__u16 total_len;
 
 		if (iph + 1 > (struct iphdr *)data_end)
 			return NULL;
 
-		iph->tot_len = bpf_htons(bpf_ntohs(iph->tot_len) + offset);
-
 		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
 		if (!udph || udph + 1 > (struct udphdr *)data_end)
 			return NULL;
 
-		len_new = bpf_htons(bpf_ntohs(udph->len) + offset);
+		len = iph->tot_len;
+		len_new = bpf_htons(bpf_ntohs(len) + offset);
+		iph->tot_len = len_new;
+		iph->check = csum_fold_helper(
+			bpf_csum_diff(&len, sizeof(len), &len_new,
+				      sizeof(len_new), ~((__u32)iph->check)));
 	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
 		struct ipv6hdr *ipv6h = data + sizeof(*eth);
-		__u16 payload_len;
 
 		if (ipv6h + 1 > (struct ipv6hdr *)data_end)
 			return NULL;
@@ -304,33 +315,27 @@ static void *update_pkt(struct xdp_md *ctx, __s16 offset, __u32 *udp_csum)
 		if (!udph || udph + 1 > (struct udphdr *)data_end)
 			return NULL;
 
-		*udp_csum = ~((__u32)udph->check);
-
 		len = ipv6h->payload_len;
 		len_new = bpf_htons(bpf_ntohs(len) + offset);
 		ipv6h->payload_len = len_new;
-
-		*udp_csum = bpf_csum_diff(&len, sizeof(len), &len_new,
-					  sizeof(len_new), *udp_csum);
-
-		len = udph->len;
-		len_new = bpf_htons(bpf_ntohs(udph->len) + offset);
-		*udp_csum = bpf_csum_diff(&len, sizeof(len), &len_new,
-					  sizeof(len_new), *udp_csum);
 	} else {
 		return NULL;
 	}
 
+	len = udph->len;
+	len_new = bpf_htons(bpf_ntohs(len) + offset);
+
+	*udp_csum = ~((__u32)udph->check);
+	*udp_csum = bpf_csum_diff(&len, sizeof(len), &len_new,
+				  sizeof(len_new), *udp_csum);
+	*udp_csum = bpf_csum_diff(&len, sizeof(len), &len_new,
+				  sizeof(len_new), *udp_csum);
+
 	udph->len = len_new;
 
 	return udph;
 }
 
-static __u16 csum_fold_helper(__u32 csum)
-{
-	return ~((csum & 0xffff) + (csum >> 16)) ? : 0xffff;
-}
-
 static int xdp_adjst_tail_shrnk_data(struct xdp_md *ctx, __u16 offset,
 				     unsigned long hdr_len)
 {
@@ -359,7 +364,7 @@ static int xdp_adjst_tail_shrnk_data(struct xdp_md *ctx, __u16 offset,
 		return -1;
 
 	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
-	udph->check = (__u16)csum_fold_helper(udp_csum);
+	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
 
 	if (bpf_xdp_adjust_tail(ctx, 0 - offset) < 0)
 		return -1;
@@ -403,7 +408,7 @@ static int xdp_adjst_tail_grow_data(struct xdp_md *ctx, __u16 offset)
 		return -1;
 
 	udp_csum = bpf_csum_diff(0, 0, (__be32 *)tmp_buff, offset, udp_csum);
-	udph->check = (__u16)csum_fold_helper(udp_csum);
+	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
 
 	buff_len = bpf_xdp_get_buff_len(ctx);
 
@@ -484,8 +489,7 @@ static int xdp_adjst_head_shrnk_data(struct xdp_md *ctx, __u64 hdr_len,
 		return -1;
 
 	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
-
-	udph->check = (__u16)csum_fold_helper(udp_csum);
+	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
 
 	if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, MAX_ADJST_OFFSET) < 0)
 		return -1;
@@ -542,7 +546,7 @@ static int xdp_adjst_head_grow_data(struct xdp_md *ctx, __u64 hdr_len,
 		return -1;
 
 	udp_csum = bpf_csum_diff(0, 0, (__be32 *)data_buff, offset, udp_csum);
-	udph->check = (__u16)csum_fold_helper(udp_csum);
+	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
 
 	if (hdr_len > MAX_ADJST_OFFSET || hdr_len == 0)
 		return -1;
-- 
2.45.0


