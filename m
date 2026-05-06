Return-Path: <netdev+bounces-284701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC4BFTrF+mkzSgMAu9opvQ
	(envelope-from <netdev+bounces-284701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:36:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A574D622A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7896B3023519
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 04:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF093016F2;
	Wed,  6 May 2026 04:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WaVTkfKo"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391F2E8897
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042150; cv=fail; b=dJ0nHXwTQnw5AmFGOlc5ZrBU0WHLiJTWHLYSM1R6bET4GOKerwd4clMwF9un/S/AC+aKKCwVAGjpM/nxCuZd5F/gAPLUqqaCnIJhviKRNaLFt8PSuvrxJsRuaeD9WTrExNui8951xMI8noa0rh1u+hUU6QAcRk+F3mxS73B/ugI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042150; c=relaxed/simple;
	bh=Gld89w0EXioHsQFx+EoQzLNqqU2OvESYIlcOMopR5YU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfm3eD5RkRMqjlRd6dEM7JZYopVKokanjQTsYbisO8eO9ECYZQKMNjHsztRZl3irWnegMTrbl1WdRbYginxXsXzKmKBnl2v9IJvUiFMN/9dT+Vq9cGrkHp6aef1VUkULWivYDqO1a+tNXwW5UQU9kzL2GvcuwssFnAEQzstZ620=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WaVTkfKo; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quyreIBV2xiv8dj9kPSO5LGNriRthuzr6znX2DfEP5R1TNloMzyb5R1h77a7iK1xmwcMD8yePpp2AYtzKTvMSExOrPvPsdQ+G3DXSd1L3X0+T855cVblcBUtxYQuyUdEh7x5xzOLrY74W7uI+phmW4lmHdAIU8nb7DfDcId0Wy/nX1dpJVa2viQiv7dOV1rjCRM2oo3cC3YGW39YXeMP3Anlz10CBuJhEuXIf8Oxz4cP840yoTzZbcHWhm2XKI/ttIuuUktmcsx8Cx4pVISQSplb5LUNI+no7vbTKmNkOyPQ/lkbb4rVJMpLJrxAM6pjRDbU3/hsejhUqmDZVEnBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH0m5UEZeovyEyEUkv4DaRY1iiaqDDIT0/ml5aYs2Io=;
 b=xh+BgXfuIl2wifngNfJ8AsNRfVwCj6bmT97C+JYTo3NPH1hZUSI3Jh6ARZ3MgxeRhFfaF5INQwBCZVR7+2k1VCT89lscqfAvJ1hD9ocCvkR6xHa7ynkeoQ7aQl0y0KWRbdtIHhM9xePnzSMNPFxJs60qGXFaxZdK8isugffQbciMawR0oCW7X8HER/xsAeOFgQ/BCh1RRSdrSz8bXp0EMP+iFnEjcsDdhYiRGFGqF5h/mammEfRaAGNh3GZ9gP2iL04a21ZD/eEr+zjxfbWu8wKMTu8CYxfrkeiRfzzSeo8Jsi58ikBkcNXUoZthwB0ceCbRCjkebzNXCJbnt4xOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH0m5UEZeovyEyEUkv4DaRY1iiaqDDIT0/ml5aYs2Io=;
 b=WaVTkfKoZIlpHLREyoAskDYqn+6IMh8ytmfOI485OEH7aBMAIxSJ8w4B+AGCOxhITmuJCkHNaV5ZO3uA8CRea0zXyKXHjM4Sw0cvH+ttwF7bvaATPVskeU5OTU7psqcBhmm5SEtTkAk+qdSQ0e3y+lAzi+NlsU6jszhfsEuhBrE=
Received: from SJ0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:33a::33)
 by DS0PR12MB999103.namprd12.prod.outlook.com (2603:10b6:8:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 04:35:44 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::e6) by SJ0PR03CA0028.outlook.office365.com
 (2603:10b6:a03:33a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 04:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:35:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:35:42 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v2 5/5] ionic: Add .get_fec_stats ethtool handler
Date: Tue, 5 May 2026 21:35:25 -0700
Message-ID: <20260506043526.64301-6-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506043526.64301-1-eric.joyner@amd.com>
References: <20260506043526.64301-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS0PR12MB999103:EE_
X-MS-Office365-Filtering-Correlation-Id: de7eb102-8df8-49ba-223a-08deab28ef9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8Jqeh6LvlAo5/Q/cGWL1ujrfMZxp9NYqTqn+TE6a7VRKKx7BAr5jSjGivwi9nnv1S3GjdtQGEPCoIdlGCgyo5gQRfHBLl8gaiQUQth76Qo64aAcPyWnVnRDXsJBd16Rp+SZMTc00a+ncSRNs6muj9L46PqLgJhlt0RFEKeKWnx+zF3Mzyjzj5cL2l9txdE92/RX/SrlDUVs9qIGFsG8RkoJzWiOuE3Ct+GBQlGehdGbcxZmKs7hVs67yqZYz8uIyGe4LnOd5zHxuhS4KufNZcbumNH2wjqntW3Exv1ODj5OCAvNpIV6j5vBMS5AI6eirFt2DDqM0AnjkM667tlIFZ5sjIFLkJrtFzYGHvUIf462vpQCXYzR6QN2x2aFRDA0Y9zA1ZClvXj5XqVTpshkudTh04a3XINApqBiH5lOYwuikmrnrtH4EkK9ZWP7D62Db+Kr+/TyWIHZxcN1Oz3WOU7pka7CDKs7XydEZOPsQ/9Wqfzislr7zl/p490W95ObZFcrRlNQ4xT+PvU6dPvLqtlu+Ha3QOtbAll8uDNhvHryD0G2PS6S6RWUcBvqY1gfWdz4TUQh0gazW/OIVRLAkhsnrOqkJ1LqVO5ssrg8cCdOOFH0re6dEW/BpJRjed+9X5RrBuOeu1MB34W4cdRa2eMS5qVZAnC1DgI2IM05ncZZVLUdT9IxDIQoPln9YZHfR1XGOQJKcSx6WunhT28G8o3f8zjGk1Os4PEy7vWgPXeg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yKFLxUC/M61VJg1mYCgZcmP9NezoIGhEMXr70RpFAC/3b+oWZdCtemORRtRv89HKnz0TZ/tSD/9CaQRQ3T0KZWAE0d8+X5nHShVlNaLgkhuk1owbcyq/PYSCxG/dS1eGcxCSXBRKTUO2Jp90f1Sr2WmjFb2b1jYepVach60qsmlLSknWE6x7pAGv3P2ZFSl8ZjDzmG/+scqpHEtVzYmXFDPOhBWkF5U99KPEBFuHeHUmEAk6nCRu2IqiYdOkRSgXvMxX8eNawGS4gkdUmAlzw35PHnNGg6oRmZf8cgSnuy9zzxTO+QqRHkeYevQKZU4+fLfsIuf7Btz839wXmcTmd8oUoO6Ifc5XvupnmbxbDDquFM+NmtBQgW11Z+SXucW5mJu2NP2kjgBKdn0jUsl7Wjxx0I34xURWpjjVlIuIux97Wqc5MYLy3skNy4X+WBtI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:35:43.9066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7eb102-8df8-49ba-223a-08deab28ef9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999103
X-Rspamd-Queue-Id: 31A574D622A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284701-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Several FEC error statistics being collected can be reported in a
dedicated ethtool callback for FEC errors, so implement the handler that
does so. This includes 802.3ck FEC histogram data that some newer
hardware collects.

Assisted-by: Claude:claude-4.6-sonnet
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index af0c4cc8ad8e..b0d7b5a9d189 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -419,6 +419,57 @@ static int ionic_get_fecparam(struct net_device *netdev,
 	return 0;
 }
 
+static const struct ethtool_fec_hist_range ionic_fec_ranges[] = {
+	{ 0, 0},
+	{ 1, 1},
+	{ 2, 2},
+	{ 3, 3},
+	{ 4, 4},
+	{ 5, 5},
+	{ 6, 6},
+	{ 7, 7},
+	{ 8, 8},
+	{ 9, 9},
+	{ 10, 10},
+	{ 11, 11},
+	{ 12, 12},
+	{ 13, 13},
+	{ 14, 14},
+	{ 15, 15},
+	{ 0, 0},
+};
+
+static void
+ionic_fill_fec_hist(const struct ionic_port_extra_stats *extra_stats,
+		    struct ethtool_fec_hist *hist)
+{
+	int i;
+
+	hist->ranges = ionic_fec_ranges;
+	for (i = 0; i < ETHTOOL_FEC_HIST_MAX - 1; i++)
+		hist->values[i].sum =
+			le64_to_cpu(extra_stats->fec_codeword_error_bin[i]);
+}
+
+static void ionic_get_fec_stats(struct net_device *netdev,
+				struct ethtool_fec_stats *fec_stats,
+				struct ethtool_fec_hist *hist)
+{
+	struct ionic_port_extra_stats *extra_stats;
+	struct ionic_lif *lif = netdev_priv(netdev);
+
+	extra_stats = &lif->ionic->idev.port_info->extra_stats;
+
+	fec_stats->corrected_blocks.total =
+		le64_to_cpu(extra_stats->rsfec_correctable_blocks);
+	fec_stats->uncorrectable_blocks.total =
+		le64_to_cpu(extra_stats->rsfec_uncorrectable_blocks);
+	fec_stats->corrected_bits.total =
+		le64_to_cpu(extra_stats->fec_corrected_bits_total);
+
+	ionic_fill_fec_hist(extra_stats, hist);
+}
+
 static int ionic_set_fecparam(struct net_device *netdev,
 			      struct ethtool_fecparam *fec)
 {
@@ -1155,6 +1206,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
+	.get_fec_stats		= ionic_get_fec_stats,
 	.get_fecparam		= ionic_get_fecparam,
 	.set_fecparam		= ionic_set_fecparam,
 	.get_ts_info		= ionic_get_ts_info,
-- 
2.17.1


