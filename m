Return-Path: <netdev+bounces-289999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF/QKs7iDWpF4gUAu9opvQ
	(envelope-from <netdev+bounces-289999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:35:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0215921BF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6ED332E4D31
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0333EFFB8;
	Wed, 20 May 2026 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sSztpdf/"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AC3EEACD;
	Wed, 20 May 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291608; cv=fail; b=Qd+SS2884i9BmBMYDJ7FgisXy6RAOy3jBEQ5lhHd9NM/KJxvbwk0+gDAJrNSEhSMB6XamxgcSV6fZMQqSjZmtTW6cyFDpwh2871VD9tv9qZ2rm7yQqZnv/TSFpz7K128LI0ikk5uQcc/weA8HDNE+H4y6wYXBjnW5iUs2FHQwX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291608; c=relaxed/simple;
	bh=GXHdUEvy3rr545quD4uLFsRyqEZ9fWWYoBK2LTJTzZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHcgA8ygQurYFAVFNrMp79bTzWnOBHT+NHw28Ha7aKf7Ih2dnyt24IdK9lckLJLs1kFwC49Z7gUdqgrJkzOGZ3OcWaZZSuVaiu1gDb+tkUV2zxC0E18w3R2hzkak+phkGrTJT8xkrjdUBdGeBBRfb/bUoKI6EzfVpFhijijUZdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sSztpdf/; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHULhf1U6OqerJzGsy6tZb15rKOzhBQ4kp0yCvWjjY6Sn77zSNUBt6yPYtTpEamigC3oP2BWhN2i+B1PJxxBKSzOS5PCS7vk7bHPlOm/x+bEN7NJWqsO8lBEtCRSmA/qfvUH30s4dcOJpDOKNXYDwKYLK3Vw8DYOGa07DSma8RQIY7vLyQARPkVCZL+zydDwhq3jNeRotqwIRNdZ4lg4lmQacP0DwkL4mo13YJDG529XbMjk0YbB2f4h7qnZSq25y/ix9pq3DZSiflP5fusmavholLEDSW3YJzP5amkcbKlYoXy++ogcQi+JZq66f0LMQtCY9+vel3givAx7eaHlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hl6g9RtIVt9le9IWnvRegPX4lhndQLh5sP8w5QCfIs=;
 b=INEB6FQUDmSyJAkDzxniVWEcWcV7XD+4vyKgYo8iUgIru7eojkO6TuH4pvkRNPyzBBAONBoWU4k+2hqI3YroegNWa3K1CuXHXHKaWyoD85L+/+BInTritkC0bN21ybHdoSMtpnbLzW3KaaqXn8S0ZVS8yK1D41hBWf2xNL5637/B1j7Bh6MaP532o2hBfomYoykG9cd1DI/JWgWLxwJkB+5SvgBGYCXdUn8ctxR/CTwJCUHRD698JUolmYJmqWlM7jJv4d1/9103uxJCFY5iXq1/zjysFlIS2iMkDER+ikVupgaNZDHgB1znrB7jBOEhjvtTqTGWopjn4sTgm+T8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hl6g9RtIVt9le9IWnvRegPX4lhndQLh5sP8w5QCfIs=;
 b=sSztpdf/yOSpEWdGyM8vBhZtvS3EZEld+amjaE/iDUVp3K/dIKiN6v5teJp4m2XiI7jneo7Do4wGnNFYMAbWTJPRDpESsrcO2Qp7780uN8ErmPxv49zlF9IWtay+XMBfWlXHbJKS4OaVAo3xhk1XPigOHftVyV8hRxDjZkCfYbM/66f9VASiIVYchzeMBGzFws5UEXCHXssl8essulEVEWjYEXw4qSMK8ak+g7S5srqJYM0yVTkcxcgsyc0VwNMlIqrZaTbiH8a6SSf/+UA8kqOcIf/3Xe65h2oNndXP3mV5DEuUoDgf+O6KmjU0X+a+c9axXFmkyD4p0lDKdP1bnA==
Received: from CY5P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::12) by
 CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Wed, 20 May 2026 15:39:44 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:930:4:cafe::64) by CY5P221CA0060.outlook.office365.com
 (2603:10b6:930:4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 15:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 15:39:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 08:39:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 08:39:23 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 20
 May 2026 08:39:17 -0700
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
Subject: [PATCH net v2] selftests: net: Fix checksums in xdp_native
Date: Wed, 20 May 2026 18:39:28 +0300
Message-ID: <20260520153928.3371765-1-noren@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 157f1beb-20aa-4612-2799-08deb686027b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|13003099007|921020|11063799006|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NnHArd6CswQguIiOetF+eAPExgL6LPTW0pElCWnqigmDNmb3oPPTsWA73JZw2XIypTQQcdgIvTJYfZ+fMme7XE7L20YwEtxwVYKtkBaZTK/vwi+ppHSYzAQAw9cw57HxUqKnBTlN2xpEvMCIlznH21el1MAMfs9Mfe6Ye8nI8x2WB4B47/hVLaBMhoNWqmVErK6FqcM+TvLdD9L3aMsaWOTPdbwzFr3gtuIt8TDI+7ok4nN4JlwdCWMUmV8CChnfic54lz9HIdfyWf4LatvkHvBJmEJIr8e5dbZQWmhhKHu2biEZGtLEpAv8VFtnXdzCZVSLW9ES6QKlujub52y2FHMYQZAykKiDh/NnjV+r+WQ9eLLJkUtWwOxIctGLvsC+q0MmNYgLtOMmNecBfFXylwuc/wUXrXI3Ep0/yP6ABAv/Kf5ZATsWFIoWT/jwAwShPG51MvT1ZxAVoXEqFLcPFwZ5/IIOENjpSdxLr90ywkpaxg80YH4zWYA2Y7bWnWHJxzObGQci/uZm542kr2tHuBGyNfJvw7dNmkU4aVtiq/FyfcNYJjzmrUOBuuXCbEH/yBql/JvOlZ3omgMUtl7FWZ3gMKsB+IsFSaqeCLPu7HkFam6XJglGf/pkTCrQix5WkCaASu1HZXdS0JkNVz3bhq0+6ZSo73z1CzaQqEi7FrVX/SS5yAGYndyjQMVBDavEqafSq1I3bhkPOGEUzmlQ/owy72mz1vOEj7mjcAcb2B8MhWx3H1DZgf5KIS0tImg4H2bEL/OfC0VB2k3bfL3r9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(13003099007)(921020)(11063799006)(56012099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e6yfZnxtxHIhdzA0KCa5kq4FFPAtuOY7ak9GKioXNVUOaj/l9nmMKwMIjMtgkmL+T1yAsaxyBkiTfcCvWO8xDTImuNANdO0+DwTJtg6uQGIvtTVtGeEZl7MDytxQFqUnPNRpgifo2lfTVBWtixXxJqqLVNxhPCy8Fa2MmPaA/MBECY4KASm75OrYXsKsEfR3dkVZDEC5IaKuA61f2k4F/n8ENLMd1gR1MaAmttkQfH3oqDaW8SjXAALRADDWw8YVAY6ac7KOu7WrJ8f6t6KgNmPzYgEmSH0wxt9COt557g7qsEuX15azlbKWGqMem0Wep8EoNRcI5u9YLtIMtV+9uvfV41oBj+4EdS7JQGl6OkYOS/4PW7GB83ZB0EpcNpfmTzGZ29JG0P1X4ZbY8R6r7vGIUplDI+Q3nPl6ojAjhcn25/M1DAIkvrY7sO2Vftpl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:39:41.5055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 157f1beb-20aa-4612-2799-08deb686027b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289999-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com];
	FREEMAIL_CC(0.00)[fomichev.me,gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0C0215921BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Data adjustment cases failed with "Data exchange failed" when using IPv4
because the program did not update the IP and UDP checksums in the IPv4
branch. The issue was masked when both IPv4 and IPv6 were configured,
since the test harness prefers IPv6.

While here, generalize csum_fold_helper() to fold twice so it works for
any 32-bit input.

Fixes: 0b65cfcef9c5 ("selftests: drv-net: Test tail-adjustment support")
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---
v2:
 - generalize csum_fold_helper() to fold twice.
v1: https://lore.kernel.org/20260513072355.1083381-1-noren@nvidia.com
---
 .../selftests/net/lib/xdp_native.bpf.c        | 55 ++++++++++---------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 64f05229ab24..ded3f896e622 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -268,6 +268,17 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 	return XDP_PASS;
 }
 
+static __always_inline __u16 csum_fold_helper(__u32 csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
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
@@ -281,21 +292,22 @@ static void *update_pkt(struct xdp_md *ctx, __s16 offset, __u32 *udp_csum)
 
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
@@ -304,33 +316,27 @@ static void *update_pkt(struct xdp_md *ctx, __s16 offset, __u32 *udp_csum)
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
@@ -359,7 +365,7 @@ static int xdp_adjst_tail_shrnk_data(struct xdp_md *ctx, __u16 offset,
 		return -1;
 
 	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
-	udph->check = (__u16)csum_fold_helper(udp_csum);
+	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
 
 	if (bpf_xdp_adjust_tail(ctx, 0 - offset) < 0)
 		return -1;
@@ -403,7 +409,7 @@ static int xdp_adjst_tail_grow_data(struct xdp_md *ctx, __u16 offset)
 		return -1;
 
 	udp_csum = bpf_csum_diff(0, 0, (__be32 *)tmp_buff, offset, udp_csum);
-	udph->check = (__u16)csum_fold_helper(udp_csum);
+	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
 
 	buff_len = bpf_xdp_get_buff_len(ctx);
 
@@ -484,8 +490,7 @@ static int xdp_adjst_head_shrnk_data(struct xdp_md *ctx, __u64 hdr_len,
 		return -1;
 
 	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
-
-	udph->check = (__u16)csum_fold_helper(udp_csum);
+	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
 
 	if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, MAX_ADJST_OFFSET) < 0)
 		return -1;
@@ -542,7 +547,7 @@ static int xdp_adjst_head_grow_data(struct xdp_md *ctx, __u64 hdr_len,
 		return -1;
 
 	udp_csum = bpf_csum_diff(0, 0, (__be32 *)data_buff, offset, udp_csum);
-	udph->check = (__u16)csum_fold_helper(udp_csum);
+	udph->check = (__u16)csum_fold_udp_helper(udp_csum);
 
 	if (hdr_len > MAX_ADJST_OFFSET || hdr_len == 0)
 		return -1;
-- 
2.45.0


