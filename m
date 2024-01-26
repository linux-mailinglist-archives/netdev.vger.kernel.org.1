Return-Path: <netdev+bounces-66249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B048483E215
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E7F1C22D8D
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DB722324;
	Fri, 26 Jan 2024 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gv3V37Wb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B3224C6
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295549; cv=fail; b=AsVeL1opROMlbcqIrXqX/UseMKPWWWVQJnJw+QRqnZfyHN+MUjbIn8a8OaA00G6T0/Oxx6LMbKzIaZ4HIGWnZQ9le9JG0I7tjR6t2d6g7mDJcrduchSQ49WCHQRaiORLrzLKWibWStyC1M2Qg0+9bqK4c2I0pm3uKeOgmhwt3+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295549; c=relaxed/simple;
	bh=hzjE49PiSIKmI2V2sLIaQP1j1IMPW5HD8WGm3pFpQTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+9fB1cA5ujb8rzHwpeYvU06N4V2Rdy1o0mW83IpnU650PDuJ4M2gqFS8oOKwXYeOmChtSbhPrjkuRyQPp4KlJIGPjUKjhxdVLg2vbUc4tADtpNQPz7xpSoJJewv3OdWjvObkjNJdV+rkkoUUCdPOOqbZWxSmvzsrLulZNOTdQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gv3V37Wb; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5V6Cz5yWhyMDC76ZDDk/Kuorw3nTWf9dcUiEZhPxm6uH7Yi0WoV3qAmWZWca8hxUV2a6uzjuVQPOkpzOjRFCMOOZTyemyFNUGG5HWO0cBL1eJmyKemlV/+dItBln+8yMN1JT2bkQHMziprqgisfJJ3crsaX7Jr0e9QCfc91tm0pFp4Hyzz1ViDpGwPeM3sg5iGeGlJbJTxWDv8sgo4N3CcmdphwIH85iJLEcU94evl2zym0yE4ZXhsaiG7LwLAextReAGyXce7bUeULVnIA+ZGj0bvQJaj8k+RjCDK4J7s4S1xrIOVecLawm/2jGqOHtgnDWbkK407/IJLY9/WtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7YVh+uJpSwJxKGH4tM2vc7DTX+Tl8CyzgivVYBOgaY=;
 b=C5TmDIGuxX8pElaoxIPhyTh4Qt+sRiy1hhafy/MrGFuIZ+9rZZGB24uTTRjOCLoiob9ZKZ11LT3/rr9dfcPX2Gj/RJVlBQUzZbFlJ+5CPnBkf08SDQi2++NBC3WKTV5lkha3VkMEyVhEbWw6EwHyCidyspq23G0gzlmG9a3QWRMxjV7Hs9efWMa4WhmrghWucwBqRm+PWw3aGpYNyh40MWRfMG1yFD4zlJsuSmGzWVAHPjNGU/IZ071lZtzsHMwsSBwwEklVXYrJkuEp1i7YC7G1TsnywHJ60b4Ki80mXYSqlQW5N9XJifEt1devub4xwY3ud9XmMWitHRqdT0Xjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7YVh+uJpSwJxKGH4tM2vc7DTX+Tl8CyzgivVYBOgaY=;
 b=gv3V37WbsIOJK1I78EO8JC1JURSSI1riSSzlL8JyrzZOEraFskXzNghPE068Bf2n/SNFG35kUbZ5bGNrHdJUdCJUOz2PbxCCLt7aNYSlM+R1ovEtswHZ2droUDm0URXLh3Vih/M4sBKIz1bvfm347j3IeAqtVk2bp+LcReYg0oLzylGvYnTa8MfugT5UDt3bbkHEZPX2N8VlMpxwq5U/XHLSALc6gkj0cJIGPt9tLAxHmGnLPlGk/V8GVFQcB+yQ9lcpidV2P2O04z60tdSa29klRZdlpDDDZbbIqh9jLSz69S146XnZS8Y+rApSjjPf2RC2wPCoemKcQrSCBfWP7Q==
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 26 Jan
 2024 18:59:02 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::55) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 18:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Fri, 26 Jan 2024 18:59:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:52 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:50 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/6] mlxsw: spectrum: Remove mlxsw_sp_lag_get()
Date: Fri, 26 Jan 2024 19:58:27 +0100
Message-ID: <60abbc61e47cce691121e761340d6cc5d7f06f4e.1706293430.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706293430.git.petrm@nvidia.com>
References: <cover.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c4a64b-8e1e-4171-e6f6-08dc1ea0dc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z9qdIFt1heF9B8GTccSJE1BZrH4khA6NLUM5ARq9aK4i2gWVpRWowzLTWWpLPxl/p8aTJshCICSYexu/CtmDiObxszsxcCNNCDkxE18H0dZLRV19VaBt6T4IZz4dAZskn8RdMfMACFxvN0GTsza53uS1tK5BdW8s6gC3qvYLBbZF3bPlP545Ej6jJMD1pKHGiQBFmir//IE5o5tXV55FFnhSziuil4xBaoocvyd2nO2rfP2zBZr4t06dfqf8kUM+WHBrc8CSHEW7OPVhq5y31BvaCJgTib70z1yqsqkcMJ745VdO301E6biKt67dVeCTSMdzZHGFIidjhtruI1J7nJk7MLNWIi9oCGhXJrYxMuOMWcTY6clPw9liqMPRVJuV9ZF1AR0KqRDqgxnkQdo7gnbgfTVfCAg2IkckXZO+6AUW2HTe4c5JAlpCDgxSq8BSNsDkQT/CEgRyHmHOw4mRKXkwRhgKXqJMkbfI8r4S3VD7ZexNQMXhki1jFQK7Ym2JMmGzCFWhmNevxrrx5+KehpEbUOD9dZGFUGFYy5gLtZPB6VuLb9J6MZLjSe866MMryz/66G/xhHqT2g3Oxaapkou/1u6ug6Bx21fupe14XMtZYwXgc/WPM+Nt8/pElLXVdtW/suZpc0oQCds+ZQZUTtSDhu7fPiNbf17nfFKrY5KGJjTbrZIRqePBtBjui1fHztO58BZBskcGV+CjVXyN9zAfeD0HBoIomRQywNWR9WZiG/HQgQzt4vjZm+fHhgCh
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(110136005)(8936002)(316002)(26005)(36860700001)(2906002)(2616005)(82740400003)(336012)(478600001)(16526019)(70206006)(41300700001)(6666004)(4326008)(70586007)(54906003)(47076005)(107886003)(5660300002)(426003)(356005)(7636003)(36756003)(86362001)(8676002)(83380400001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:59:01.8488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c4a64b-8e1e-4171-e6f6-08dc1ea0dc56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

From: Amit Cohen <amcohen@nvidia.com>

A next patch will add mlxsw_sp_lag_{get,put}() functions to handle LAG
reference counting and create/destroy it only for first user/last user.
Remove mlxsw_sp_lag_get() function and access LAG array directly.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 38428d2ef0e2..ff52028a957b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4334,12 +4334,6 @@ static int mlxsw_sp_lag_col_port_disable(struct mlxsw_sp_port *mlxsw_sp_port,
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(slcor), slcor_pl);
 }
 
-static struct mlxsw_sp_lag *
-mlxsw_sp_lag_get(struct mlxsw_sp *mlxsw_sp, u16 lag_id)
-{
-	return &mlxsw_sp->lags[lag_id];
-}
-
 static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 				  struct net_device *lag_dev,
 				  u16 *p_lag_id)
@@ -4354,7 +4348,7 @@ static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 		return err;
 
 	for (i = 0; i < max_lag; i++) {
-		lag = mlxsw_sp_lag_get(mlxsw_sp, i);
+		lag = &mlxsw_sp->lags[i];
 		if (lag->ref_count) {
 			if (lag->dev == lag_dev) {
 				*p_lag_id = i;
@@ -4501,7 +4495,7 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	err = mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id);
 	if (err)
 		return err;
-	lag = mlxsw_sp_lag_get(mlxsw_sp, lag_id);
+	lag = &mlxsw_sp->lags[lag_id];
 	if (!lag->ref_count) {
 		err = mlxsw_sp_lag_create(mlxsw_sp, lag_id);
 		if (err)
@@ -4575,7 +4569,7 @@ static void mlxsw_sp_port_lag_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	if (!mlxsw_sp_port->lagged)
 		return;
-	lag = mlxsw_sp_lag_get(mlxsw_sp, lag_id);
+	lag = &mlxsw_sp->lags[lag_id];
 	WARN_ON(lag->ref_count == 0);
 
 	mlxsw_sp_lag_col_port_remove(mlxsw_sp_port, lag_id);
-- 
2.43.0


