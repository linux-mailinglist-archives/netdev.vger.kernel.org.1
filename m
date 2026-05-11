Return-Path: <netdev+bounces-286496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJakOjmIAWpJcwEAu9opvQ
	(envelope-from <netdev+bounces-286496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A95096AF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62C5304046E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28878386C3C;
	Mon, 11 May 2026 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e+8a9x6d"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7C383C70
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484584; cv=fail; b=pVdBhyV22IdS9JJJ7zjcSim+ST/ArmZxDAJyi60IHLCSygb+KVwXCMkX5Es5M71j+s2wMpfqo4qAubxt96B878yCfgUXCvJPCRccF7pSBLE0BU2V/xMZkO9mNBiRmt7usf+bwC/GRgkXTT7L+MSxFiR2c/2GPOuXZYilOetCNuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484584; c=relaxed/simple;
	bh=DlMQWoGTTlWUHErPa5COkpy2/XWWbcsn9jmdzdFsvj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nt4OSPs/ZhZKKhfMW1Vuekb2oWEpsR1nQ9VciZeckYlEI31977AFYvt8FdSsvfAN81vDEJg/SP5vII/K31ZEvvJBTvrIoFOxsRWUHL5/9pJSJDszqXJsp0xCdrLpqrpJpTJrUAa5Wvspvm4A5d5my44ufaQQh6DnHWPs/XiD6tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e+8a9x6d; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky9VLHGkwGynWg4VUMRBvwJpB6StApmIqyP7M5ptid0y1Bc3C64V3rtrA4eFob+ZGlGjT68OouaVdH+K1BBLuiBWkcPl4XhS2F2Zii7G10hxp/JsZPDgmfM0nylI3y0DNGZcnSROalqAOs5lOd9BCEOohqSyGrSxKMk53Jbe402Pn/mHkCc/jAMCJ/ZrVp7DMTKXAsMX3z8EEkFkimLmz47BKTytYNLR+/Mw+/sd9wmBDD8isZzP2TQlkRLsf8w9RizVCAYsnwBHZAdQy45F5ocq+IiP28AYC5LcRAjJq77vKVb2wnLnQx17J0JGzMAvbPkI9+ZPNY2vyvOnEMKQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKqD51x+BzoCBZIDHtjAbjoFn+H65BXh1XpD5c3wTno=;
 b=lBlMxtjOfHnVVrdf6CgiOCdbQbiYTL680Rn09hzBrDU9HWM9TzmlI2BLZXWP9KNq3Syym19Lcc4ySh2RkVk+o4lp9MRwEa3wu2TtLWhwysfzltqoo/zIc9as0xZ7f6eIuOawnLTiIniI0ojrSGGL3fuzjxSWXT+bTsec6oWQoy4Thx4Dwz+kc0NGMxPfltJb5npkiAxchLMYGaZMBG7T1a54dzJuqlmQDEExptNJdDtJrvUXTaSetJsJV9F8CUefC0j9aiLZ4lRaKX4XCcK0lKNujjniuFxJWYxV0ICeoj78SuFThO3j0FzkOZbZ7opNzBDaxcL6qO72TBgXKVHSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKqD51x+BzoCBZIDHtjAbjoFn+H65BXh1XpD5c3wTno=;
 b=e+8a9x6drHqH+tWC2XVBwvkjGsaRemDB/SzmXoCYnrsS9Ohs5rA4BdWfLLp7mLE0WAvKA+u1ne32+dWWnvFFXAYWpfs31K6pgo44UBgX6rjMcb7WhEi/DQnSfT4H9PwxmdacBuYXfTV/gHs85Q0VFkwziix23Un1D+iBNzRiU7jmbgXSaVWFR9Gpgi80TKV7Ey50VF98R3RmS1zvniy0V2VB5qe+VdonKq34bmTX0m69597pWSYf2krOyE0K/4FbKL4UZXP/3qZbW5n8bW7BBubvc6nWxQP5Thwu6Zd1+EsSqDmlhwamlprGm0hrzv/uLm1mabIwxwv4t4MHHtEa7w==
Received: from DM6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:5:15b::21)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:29:38 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::e4) by DM6PR18CA0008.outlook.office365.com
 (2603:10b6:5:15b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 07:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 07:29:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:29:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:29:23 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 11
 May 2026 00:29:22 -0700
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH ethtool] ethtool: Add --disable-netlink to help output
Date: Mon, 11 May 2026 10:29:16 +0300
Message-ID: <20260511072916.1895384-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c50278-117b-43da-a8b5-08deaf2f0eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cnrSXG7ZAyRKDgj5kyggvBx7DuqQZ+GinA3kN3pL5HkOkrZLsKZBjYQtebmbRjjb2sl5thStDbQ///nZIkahNFKoSyjuEYjRlviRkouqmPhITjdGXWAF4q8vvyKWPTTTJI3cIdjvimVBEKHQAA4eBXu66R+FlYNdzyC08uEx847g/4og2gBEOAzxAVjCBOAPpLzpuvyMmBoPGnL9BWiiWj8v//uaM2qMfxSVQddeZVcz8K88T79quRDpKtiiGHCvv4QWXO8qThGgQaFSVUJ7PGteNflyNRsL7kOy4uUfUdH+dJYDUCRv96njmNPbHjqSZABAWg8/XkKTOHDnTci5vY6xZ8PA8WNX39KGK7aVbiUndCP7AlaIwXq6QR1g2L4kbzfDi2LUjMNEoZrqxcO5jsic+xj5yJvUGmE3yBFmQahaeHlBLdXz+yg6+pQBz4njOq/CuYkFqq1TE/zKDjOXKbab0I0yMuI89XFRskZmy03N/I6Q1da2wQjiJ3UlEC3WFYyu6pj6Zze7j6GCpzp2MNUuctG/p5kWM1o6g9RZWBV/xxPXIN0GE4teq/uyPZZ6PmGF/Zj5L8oqAENs0Bl+5wAmg6ka8hlcYtxyoaazZ9KQqdkWUF2QOhzd1HvsHdqi8sIfL29Krr/MEPDjRvFnl4vr24mKaJdy2AFei39eTsX2FX6dZfNGnA+P6D0SC8iY1lF9Wkd+j20gIkAtQFK3Qf6VMfEktn37vbLmwjX5Q6Q=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(3023799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lxzkt3eisPshWU966hrzr0aOL8nIudGjzqBMMLTofs05Qm4G4UNf0Stbc3eSJwNJOW4o0DSuTlc3OlAVuKZ5q70vPQsFyN8BoNLibIXx0bDAI9i0krx7Dhe4T4VhnPTvi+QFlGc7PO2bh4fbPX7siOcecStg1bKKLNUlHFRJUo81VbzoLj1Iz/DW0wSpg4sdm4nYHohyt3bY+9QTg/MzztbDuob3AT//W4iK/Bv4KIUswRQkMrYa9jp5FwslIsnvIRs0nfcF1r3BNM8Cagu9XePMObKgxRaIt1E7P/SvWXlZ4DaEOJCBkvWGk6Uy2SCxT1wrzi63+OTBGGZ3CZeJxyeQGxwgs6kqOY45rUN+5MfBtUwfP1AMiSNMlYeLgWtadcKdV18pLBYTOf5pk7rdvaar8XwlwZ/3QjQmqciPB8IcT36CkGwjMMdp5Imtda52
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:29:38.0428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c50278-117b-43da-a8b5-08deaf2f0eec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
X-Rspamd-Queue-Id: 589A95096AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286496-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The --disable-netlink flag is documented in the man page but missing
from the usage output shown by ethtool -h.

Add it to the FLAGS section.

Fixes: 6e3ac505bcc7 ("Add runtime support for disabling netlink")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ethtool.c b/ethtool.c
index 2444d858b125..97c06b85bf47 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6416,6 +6416,7 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 	fprintf(stdout, "\n");
 	fprintf(stdout, "FLAGS:\n");
 	fprintf(stdout, "	--debug MASK	turn on debugging messages\n");
+	fprintf(stdout, "	--disable-netlink	do not use netlink, fall back to ioctl interface\n");
 	fprintf(stdout, "	-j|--json	enable JSON output format (not supported by all commands)\n");
 	fprintf(stdout, "	-I|--include-statistics		request device statistics related to the command (not supported by all commands)\n");
 
-- 
2.52.0


