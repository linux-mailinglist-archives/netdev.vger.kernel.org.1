Return-Path: <netdev+bounces-238117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB32C5438D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B38154F08ED
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580A352FAE;
	Wed, 12 Nov 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eOWiwf8h"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D55350D54
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976137; cv=fail; b=ApFTozId64yztMhNI2lhuEYhjBhNu7+aNC1r1wz3E4yglspCDGy9pmzNUEsn79RRvRYid048Vzz1INx4f1NrSdFN7SVvNg68U0OdafbUS6uYU1edsTb8AmdLuGo6tItVH6UMrRi2pXQ3h9lyPxSGL1+7+HV3JGJKVvz8xNDUCFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976137; c=relaxed/simple;
	bh=MuEV8KSh9Aib6mTzk39q/IggNYVoBy/weZXDIwHTSmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=an6OLMXSkn9X0TmE9LE6ChHbXLUDzre9KkqnraTVJEZBuKOOeaiKFX5z4AxIaobxf9EYHUHtnaMrSPDv8yPyL+PW3xMIoeh6pejkehzyljRN3oQpVbZ65+g9NhSdjCtikf5N6hz3OYRSeLzh5954No6naPwKYp4A9XqUmpnILrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eOWiwf8h; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh+ZqdRRjKqaXy+067L0glO6aRe/3cDiSHyANu4GHDFhm71RUjHgwEtixfURmFycJjwpigMfLaG6s6ZfF9K6hl+f4zsSh6uDm0fpbGDSC2aeIka6ZFiKwXLt5xPnmj3pWwnP7JqjZvrgMHqCQhXucvghCjnxelnehcUcWFxcbToRpR2l+j8AM7e0XNfIYlT2rUGaSzQ3TFOKGP7ILttb+s2QM+uhcD9MXS+nwXD+oxph4aTQ/auRlBFT09c0bQdsKALdEh4QMZcvvmITlonHnLZHrsqp7Los8vLko1pRhRbF5utTpdj6cjv9qstxsX4rBanFJXZhRPE9edWUIknaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVRUW6ke9WH+MvZgNXbbKrZ3qj4DS26OCoM9NmhLTt4=;
 b=wJaw9/qd/x/f51dBJZx3ZHNcW31Fsm8PyfidtLDY8p9stcrV5CJe19OC2VP97sEx7vTpcTnsKnUyw71LorPWKFcyXhNk6kr2t2j4chhswpwXRQyeVbLux3gglBsZwe12WeqwIybq70OlCIO8M8nqunQ9U2eBWut5hpSr0AT+PYzb8xgZf+BWZerMm6Ae5R1EtOThEz1YIXnoCfcPg+EZKTeaHfX0V81qVsP+/T9jyslwHgqAj3qgHbUX2EEMsYMNeibZdB5yaqSe/pmplMujlZO+Fkr5d3K7qNVr8CoP2uRZJhfzVbVE6pL8VcOQU7DLd8VmXoSna0GYyQ5Zec3saQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVRUW6ke9WH+MvZgNXbbKrZ3qj4DS26OCoM9NmhLTt4=;
 b=eOWiwf8h0PwSMav0YVPrzU3gxCoGCTQMugn1fCK5guZ/IEf+wiI2v1i5iPqUIkL2g2RdSzDtoTNCHPSMe8mrvnWlpE5xs836c1Y+GJhcOEG+K5H2h17nSEnUqOvZR5tPhG4lI39X/GNVlkoK7cc0nz0HnnxQSdXJ+8S8cBgZKZizpnoAHYvgAT+JfHzRiBStoY64U03JlmRBASvUwCvG/Y/8eDpdMT+50JgDe4p4cfz+lB2BqwIsYrmPGgJoHsQQRBx2uWEXb4866QB2BfmtQIigAvueZ3Qyk6Akt9JG8oT4WtxNm6zYVAvq/ZwqivHbVR1CBWadMRCV3zchJGvibA==
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 19:35:31 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::41) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:35:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:35:08 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:35:07 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Wed, 12 Nov 2025 13:34:34 -0600
Message-ID: <20251112193435.2096-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112193435.2096-2-danielj@nvidia.com>
References: <20251112193435.2096-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: abbc23d9-0d9d-4f2a-4882-08de2222a437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VG1F1Iv/7hmvxpox6cXuY2CraPRU3Zh7IsF2yxMG4Ah24Gz3GcSXa93f08cL?=
 =?us-ascii?Q?7ppAAr1yDbKmGfpZCm7by4zr6tdZzP9RxDm/s7XHIfcfnO0p/ZDM3gsRmAAA?=
 =?us-ascii?Q?Vx9elQx0LcVmB9/3+cIKzt595kRyMnlqTYWb/2lJ9YPjZ+rAPgcNL2bE/acG?=
 =?us-ascii?Q?iLql4Ewu47gqWgQE9koLpNn7+umUhXbcZU2Pd+d7IS4J3ch1ZLORDmJlE3x0?=
 =?us-ascii?Q?SqKkDHhQWnCf3PDFT7FlCuIMnqWErZvEh9NrGSgVCuwh4iCJoCYfdDIEv8EI?=
 =?us-ascii?Q?Hp1AARHCSaPBC1/Em5KAY9pWDdRNo73odoneFKI4Sma4J8XD6MC4kK6XOxe4?=
 =?us-ascii?Q?tBoOwjD0p236jjACMukaNhh4mRzAbGp6d6lDYFTQD09nZ1LG2Ejiy+nuqJ++?=
 =?us-ascii?Q?jSLhxJE/tZwn5luppcsHWJCD4ZJr+DyVOU/SKAG6kqUCqaYBRMBtdN7vKV5J?=
 =?us-ascii?Q?eb3TPqc4iDaYjG9Q8R6/MiFCZthe/9pgqdLgEZYJVFMIBM6chk+ieEz4pMFr?=
 =?us-ascii?Q?SGevr1kaObjlW7qdktKgiG2ogNiktK6wUMyPQBwwsDPiubaUOhlzKXJ4owDV?=
 =?us-ascii?Q?soKz2wSDcTqxOq9CHeepaBotIhqxh+KGbpAuNhyacgpThZ9G4F3bIMDjDgEI?=
 =?us-ascii?Q?bbcA+CBYCsxaxWDJGiRgysPqGMmtDglaREK4/QbsnFa2UaZ2+6vEiwoctNI7?=
 =?us-ascii?Q?oALZOBOL+cK4fPxH0vvjjkseoDs6QFmfqW0I4ZOSJtXpblM6wnzDmdgfU9yW?=
 =?us-ascii?Q?zHJZbwtaSEhvWJk4Sk4rEepcGk8T24vf/dxGNKp9n7oQNFSe3aTZ3j4XEKUM?=
 =?us-ascii?Q?eX9aKfDocEkfatfZNKx2XjnhscJhuYbHXZg2fqbDBEbfahybOkqng5GTCyhN?=
 =?us-ascii?Q?ZCSHpWEQMafXfFzBGysz3cs9koeM8Jj0TOqMCFjpjoy1P1KHOO+Piz1RA52y?=
 =?us-ascii?Q?LnEw6KCd/xNu9W+MHQojuKVmIGTOkCcgFNeeUF8JPNIQpc2mMegCFmKNCtDG?=
 =?us-ascii?Q?hfrKQpp6787yNfJlBrHeO1L3Dp2ccDyGwDUTZHxVlnVpc16HBfmyiKxIMwYS?=
 =?us-ascii?Q?uytmCQTWjDCKAedVbvapZep43xwxJSY7OP/QABqLvB78N2UhZraSrXgQCIua?=
 =?us-ascii?Q?UdJ/P5GXk8Y/uSOx7jwg+BYZGaLhOoRd2xjEdjJD6hAQBY5l5Q/Kkg881DKY?=
 =?us-ascii?Q?6dUFLU7EDDglvmKQMAWQ48a+y8rRGLMd4YHN/qz0wLzQuthBvJ3mPEsNAjdF?=
 =?us-ascii?Q?IcGIrguUCR3QrX+u1FQDEwjhB9TYF+hSgcDr2KI9NmVw3UMis6/RJwxqXRxN?=
 =?us-ascii?Q?kt/KyfdcsKVKTxLKdRPp7OTp6VJ8XCW97XWPFd7eEH8Jx3XgMfJ/sSEgNOIE?=
 =?us-ascii?Q?J6Ou5MOd+nVu1b+hChcVU+wgB0kgixoM5RlUntAaLwg2zPNCuNr1xuKd85M2?=
 =?us-ascii?Q?RgR/HewhTdAcXsGRh9Z88tGfmBy6/lk7rFTwBfnCNofvkQ434oh0yxga7HPn?=
 =?us-ascii?Q?PIYMqQw6Xsq5e+0XVUSmq+PzFFTGARY9zeiKQpZVZ65TJaiIjBGuPZdg9Vq1?=
 =?us-ascii?Q?R6unD7GQBvkTZMdnGFU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:31.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abbc23d9-0d9d-4f2a-4882-08de2222a437
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541

Implement TCP and UDP V4/V6 ethtool flow types.

Examples:
$ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
4321 action 20
Added rule with ID 4

This example directs IPv4 UDP traffic with the specified address and
port to queue 20.

$ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
2001:db8::2 dst-port 4321 action 12
Added rule with ID 5

This example directs IPv6 TCP traffic with the specified address and
port to queue 12.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: (*num_hdrs)++ to ++(*num_hdrs)
---
 drivers/net/virtio_net.c | 207 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 73756334a040..852ccff52a72 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6954,6 +6954,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_tcp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct tcphdr *cap, *mask;
+
+	cap = (struct tcphdr *)&sel_cap->mask;
+	mask = (struct tcphdr *)&sel->mask;
+
+	if (mask->source &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+	    sizeof(cap->source), partial_mask))
+		return false;
+
+	if (mask->dest &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+	    sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_udp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct udphdr *cap, *mask;
+
+	cap = (struct udphdr *)&sel_cap->mask;
+	mask = (struct udphdr *)&sel->mask;
+
+	if (mask->source &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+	    sizeof(cap->source), partial_mask))
+		return false;
+
+	if (mask->dest &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+	    sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -6971,11 +7017,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
 		return validate_ip6_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return validate_tcp_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return validate_udp_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	if (psrc_m) {
+		mask->source = psrc_m;
+		key->source = psrc_k;
+	}
+	if (pdst_m) {
+		mask->dest = pdst_m;
+		key->dest = pdst_k;
+	}
+}
+
+static void set_udp(struct udphdr *mask, struct udphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	if (psrc_m) {
+		mask->source = psrc_m;
+		key->source = psrc_k;
+	}
+	if (pdst_m) {
+		mask->dest = pdst_m;
+		key->dest = pdst_k;
+	}
+}
+
 static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 		      const struct ethtool_rx_flow_spec *fs)
 {
@@ -7017,12 +7097,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
 static bool has_ipv4(u32 flow_type)
 {
-	return flow_type == IP_USER_FLOW;
+	return flow_type == TCP_V4_FLOW ||
+	       flow_type == UDP_V4_FLOW ||
+	       flow_type == IP_USER_FLOW;
 }
 
 static bool has_ipv6(u32 flow_type)
 {
-	return flow_type == IPV6_USER_FLOW;
+	return flow_type == TCP_V6_FLOW ||
+	       flow_type == UDP_V6_FLOW ||
+	       flow_type == IPV6_USER_FLOW;
+}
+
+static bool has_tcp(u32 flow_type)
+{
+	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
+}
+
+static bool has_udp(u32 flow_type)
+{
+	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
 }
 
 static int setup_classifier(struct virtnet_ff *ff,
@@ -7161,6 +7255,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -7205,6 +7303,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		size += sizeof(struct iphdr);
 	else if (has_ipv6(fs->flow_type))
 		size += sizeof(struct ipv6hdr);
+
+	if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
+		++(*num_hdrs);
+		size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
+						 sizeof(struct udphdr);
+	}
 done:
 	*key_size = size;
 	/*
@@ -7239,7 +7343,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -7250,21 +7355,93 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
 		selector->length = sizeof(struct ipv6hdr);
 
-		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip6_spec.tclass)
+		if (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->h_u.usr_ip6_spec.tclass))
 			return -EOPNOTSUPP;
 
 		parse_ip6(v6_m, v6_k, fs);
+
+		if (num_hdrs > 2) {
+			v6_m->nexthdr = 0xff;
+			if (has_tcp(fs->flow_type))
+				v6_k->nexthdr = IPPROTO_TCP;
+			else
+				v6_k->nexthdr = IPPROTO_UDP;
+		}
 	} else {
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
 		selector->length = sizeof(struct iphdr);
 
-		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip4_spec.tos ||
-		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
+		if (num_hdrs == 2 &&
+		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->h_u.usr_ip4_spec.tos ||
+		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4))
 			return -EOPNOTSUPP;
 
 		parse_ip4(v4_m, v4_k, fs);
+
+		if (num_hdrs > 2) {
+			v4_m->protocol = 0xff;
+			if (has_tcp(fs->flow_type))
+				v4_k->protocol = IPPROTO_TCP;
+			else
+				v4_k->protocol = IPPROTO_UDP;
+		}
+	}
+
+	return 0;
+}
+
+static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
+				    u8 *key,
+				    struct ethtool_rx_flow_spec *fs)
+{
+	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
+	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
+	const struct ethtool_tcpip6_spec *v6_l4_mask;
+	const struct ethtool_tcpip4_spec *v4_l4_mask;
+	const struct ethtool_tcpip6_spec *v6_l4_key;
+	const struct ethtool_tcpip4_spec *v4_l4_key;
+	struct tcphdr *tcp_k = (struct tcphdr *)key;
+	struct udphdr *udp_k = (struct udphdr *)key;
+
+	if (has_tcp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
+		selector->length = sizeof(struct tcphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
+			v6_l4_key = &fs->h_u.tcp_ip6_spec;
+
+			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
+			v4_l4_key = &fs->h_u.tcp_ip4_spec;
+
+			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+
+	} else if (has_udp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
+		selector->length = sizeof(struct udphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.udp_ip6_spec;
+			v6_l4_key = &fs->h_u.udp_ip6_spec;
+
+			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.udp_ip4_spec;
+			v4_l4_key = &fs->h_u.udp_ip4_spec;
+
+			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+	} else {
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -7304,6 +7481,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	size_t key_size;
 	int num_hdrs;
 	u8 *key;
@@ -7337,9 +7515,20 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (num_hdrs == 1)
 		goto validate;
 
+	key_offset = selector->length;
+	selector = next_selector(selector);
+
+	err = setup_ip_key_mask(selector, key + key_offset, fs, num_hdrs);
+	if (err)
+		goto err_classifier;
+
+	if (num_hdrs == 2)
+		goto validate;
+
+	key_offset += selector->length;
 	selector = next_selector(selector);
 
-	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+	err = setup_transport_key_mask(selector, key + key_offset, fs);
 	if (err)
 		goto err_classifier;
 
-- 
2.50.1


