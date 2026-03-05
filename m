Return-Path: <netdev+bounces-264214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPK0GSQ6qWka3QAAu9opvQ
	(envelope-from <netdev+bounces-264214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:09:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C18E20D35B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 027583042978
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73D36655E;
	Thu,  5 Mar 2026 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g/kTzkqs"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA78366569;
	Thu,  5 Mar 2026 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698144; cv=fail; b=TL1E9YJ68GRC64afBLRW/pXWJFfa20w+3ICPu/LmhBAqc0MjdF1qxPWUrKn+SUnhPIPF8+d6R1A/mIHe+1NKWtCqKL8VlqmwcVT+qlsC73p1WsYfzCrybAPQhoydIlWDmp0VgmJV4J8eQNRHhsmq1Z750RPzTNbXWZ7U60EbIsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698144; c=relaxed/simple;
	bh=cvfWvRS3tumnYFJD48+4ytxn5vvQJPTfRWkNWp9jUcQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YhLo+izYNhjBSquZ1OQWANGR1JhBgbBHk4ZN1xDVxZnIRMpUxbfBwB43Dml+aqmypCaz7nPpRpIvZUlJ5ybwPxMbmCpe7MDW4mO0Wy8AxgUMiQhEGCgd55i/52SMMg2+6uxdUUEhIJMHl8Y7C/REFL0w9QlPx+4IK0TQ61zx8Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g/kTzkqs; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxFenznsTVCiETpFT8rp85s4sEE7HIKk4ZwPPXMbYygbHoNU24RPS2XLqP4QNqpof2jgjB/bgX9izMoEcsMB5hHmDrdwAlJVkpkLr1zn1P1Fws5kNtqfsYaLBMqY/f6I0T3pTFDlc4mdgpLYg7Kk2XmNyhwPjMclP1TxY+3zkLKN60irsscXcdstRm8P7av3CMx7yTmiWe2r8R7IY5eiNt0jbU4gmx97KrU8TWJlaJ4s+b+Mhw5qIQXlQii1SpVSdCo3ltictfuUSSDnOmKLfrhFSyM5x3INUErSln/mrXarGV21bOXxaxvn8QoDaVDZ6u8AFlWVoYHpZ+D4a+5jmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NrXnKHUVhBRcpdS5bGSUnNrvpOd7HEhSKGO1GX4ciQ=;
 b=WQQbVzBGODeog8nzvcL0WNpoW/py3g0FMzKB6t13/vQ7F9iXMjuWmhoPo1lwhgftoi5UK6Kbb1kT+gKmko7eC3ghX/H+k9q6lrQWHQslVtyd62bO4DcX996KWs3N70awHu/iBK6P3jLiAKJtE0LHMAFMXxvQ4w/NZbQHoci8OBiY98YsEbIHJZ9G+fWunuvTohnMw1XRKNNFs0sTX1wkxTABmUp+OSMD9UU6ffwtLcXBacVBimMcQczF5EKF+5ou5ZChYFXj0haaehCET0pWazDFXsRtbbD/7ooz6irlhN+anqs7etfsHfjb18TdnLyEtooaCx1iah96/Pg1XICOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NrXnKHUVhBRcpdS5bGSUnNrvpOd7HEhSKGO1GX4ciQ=;
 b=g/kTzkqseRTVsjTN7pRKO/q0N69lHQx60hRCFTt7SDUWd+oOnROXEkZEndOKDb1xFCaHbMicvXYsHh5Geyp6R+ymz40u55nFMLuV75SVZZxnJDkXF4aKJNXfLtB2IXzXpQMeRpS5F+O3F7OgxrxVsMbq8AsgXOHTq3NER88bsnyZbHohzLPWO5NxlNH8CtUu56xtQXTtNZlsjQcp7w4d8CY33cAnWbU+rQru1jb3/km9IUXr834JfrEAWXrFD+2r0LUxOXCuOESSOf5yhdCIC59L8utNIbYyGQRGjxmiXh7pUV5XoOPYDr5saRH0bfmvnXd8po8GMpx+yyzmjHT6uA==
Received: from PH7PR17CA0064.namprd17.prod.outlook.com (2603:10b6:510:325::21)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 08:08:58 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::1) by PH7PR17CA0064.outlook.office365.com
 (2603:10b6:510:325::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 08:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 08:08:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 00:08:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 00:08:41 -0800
Received: from f43.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 5 Mar
 2026 00:08:38 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] selftests: drv-net: iou-zcrx: wait for memory cleanup of probe run
Date: Thu, 5 Mar 2026 10:04:45 +0200
Message-ID: <20260305080446.897628-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e7f1cb-7f1e-4284-3f70-08de7a8e73f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	O3tzjdgQD1mK1PVVcJSHN8mZq4fG0C0pMT1AZYKIojGStMrV9SU94NwihsCIeNuIWLKDCjF7PdbKtmqPx9yS4cU5Dop8uEnnFVToswwvtnsnqhIcW2CSB8iYhDYMyh2vUtyPHkD3AnoKb0mUnNT2UGrmYhWEwlg8aJIbhLKmi5Hz2JhOnf6TrVS2UWWbKa/HDw2U2wGhYq+GUUSiJ/9B4NNBzYFmhnxvojBjKA4vTrx39O8dH+QFcWwZzpr/Dya3LC62q7q9VMw/1JZhWWRKTYyRWkn+C1U5vhzldPFmZfW0g9gxBOAyvIpSfsLnauw5JicbfdAwqojX8Jcaepx5ds2aKGajU4Amrq/ojN46EkhWJpedaOLJrjBH6aWhEzzOzx2zmDOpY83bV8kmKVlEB1nCZjhY+TH+bf5qOMSPwIelzX4VA2CuG2bzTHPuoSEiuQyizvXaug+XoZuCVOYYhEHRCyy7F8GRkKKnTAUFJoksSJgU3j65tC6SIU1cxO4cYrcKCl4CQk4b1jcXTII6b/6BH41jgf3VXjFCunm0QUoqb+9X/JeimGAEpkB29u8kSMj/M1UUHg+c3830OhOx3VH6CWS8vlu6JEDhfE40vOsMW2j10HqCJhXxUkNR2q/TZebaS30PTv+gqstMZSuOsNzg2N+Gt49YoqtUrkEpz4ijkDDwHa3WgtZ27cnDF88IUoJfwYGYuy4RFLqghqc5FPgx2vwgRWA+tDnf7tQWGWSLNHXtTsgud47y9G27O1dxortPlBTNZtOI1duEIlUKCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5wyEEdyz1VDLDag9L+lTblDEvjqCo/KRk/Nd9wLYflcghrgVPA06G17bK7sA+SY1sBGyj7GrH3k2MBtlFTYRZh3HD7ebEla2C30be8LCmJiKGjm1ohDUVZvg3x28xE9WZZo1V7eOCHBM/gIFvp05reh2Bc/s2LMxsc/XH2jfsowjHhMCGBjrNJ2EnhMB2NKyNK5CPOLx/msinsivqcEHmazipmpi23PxNFqx+2IBOn0IlbaAoq7zmvdiowLLo0sXl8exl77RsD+JOlofMitgvcZRiNz4ipUYwkcDPoWy5B6A7Czlbn5e/IIxg5dP9/lpR/xfHt1IjgTrLP9QbnqcokyU4Fm83Tq6B32PAuGOK8r5NlvOgK/4URdbsmH5ZwpOgDbA5Gps9aDmn7GI1BFlodyCqjld8JE03DjHOObfVnTs+tSyK7DowamRVGZk05SS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 08:08:58.1398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e7f1cb-7f1e-4284-3f70-08de7a8e73f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141
X-Rspamd-Queue-Id: 1C18E20D35B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264214-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The large chunks test does a probe run of iou-zcrx before it runs the
actual test. After the probe run finishes, the context will still exist
until the deferred io_uring teardown. When running iou-zcrx the second
time, io_uring_register_ifq() can return -EEXIST due to the existence of
the old context.

The fix is simple: wait for the context teardown using the new
mp_clear_wait() utility before running the second instance of iou-zcrx.

Fixes: 27c4ab943882 ("selftests: drv-net: iou-zcrx: wait for memory provider cleanup")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 66dd496ec5cf..e81724cb5542 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -151,6 +151,7 @@ def test_zcrx_large_chunks(cfg) -> None:
     if probe.ret == SKIP_CODE:
         raise KsftSkipEx(probe.stdout.strip())
 
+    mp_clear_wait(cfg)
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(cfg.port, proto="tcp")
         cmd(tx_cmd, host=cfg.remote)
-- 
2.52.0


