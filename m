Return-Path: <netdev+bounces-48077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD327EC758
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8301F27A25
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BD39FE2;
	Wed, 15 Nov 2023 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LwoRpmkB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A539FE9
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:32:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4F6C2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq8d+DPbg8gPMAPR6hO90jJ1Y49QVew5EZ91QAvvCmeQGp3zPcToU9OuEbUFLDfNF9ekJFSYnA0RGpU4/xzc1+wC0xxc8rVHWOpW2naOW05rKY7iKaTeBCMdYIYnAKy7xiEvZ7ftRZa9mxKos7j2sctMhvCDgD2vxrRm3QUURx+Rzb06FdZCuhb04k2JYwug4w+UJcHLrha2jMmg5i901l6HGBe1FfK86+FPazdHMLOULUiCVA1MTmTnYcOdvRscB/sVJw3XPpgEWxltF8xykIeAH1V+SB0xqEyrjl0VwgFg5E3pZhXgGLYaufZ5JLAqB4gipN6q6KI1Z66L+yuljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzF1BtbpxPwLqP3p2QsFwJCwutJy6nYYfpiDRGkEZqQ=;
 b=JCQMeNj2X9ez4ae2lJv0Nr5F70lPRGiHfFXVjS9urYvwRq61m1R8u0Xkjdljzckw+TGVU+NQl4G9CyCGd+T3lnoJI1ONgLP02kX0rwWccfZ0L46hmQrPCdD2JsKahDKtZ5Ri6aUFPzVNXIz3HdbnnXDWXAzYztyz0TSISE+MPDw4uxtdIsBROcDg36qZUxTJ80822vJVwyblK0GfRZvtecOUVPRwXwMdxXdzEmHAIke1wkLndVT0wd6L/9jDNUAFCobki/QFGgrTqfDBsoAbrnQecQy+PqkEyASBTxDtJNuCSARqFFm8WojFirzlJOvVpl3Au7MeSsS5bk3MqAD3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzF1BtbpxPwLqP3p2QsFwJCwutJy6nYYfpiDRGkEZqQ=;
 b=LwoRpmkBoZgZl+1xghPy3AxHbnYmXgzz5hrMt0t1PZWyQr9euXmjcoie77REuzP81TbeIl2X3sj8Wj3EDXK2W2TB5hE3yA8mOhoSDOboxoNsLLkCQIuN/dsXkSjgWZDpS07bgiHo9pfo286jo10+qzCU4XooqPnnk2nasQicndkbE1aFLVpnL/twkPT16H1jiKRwpwucz2DYKZSAEFWcQCkW8Jw0SBuL/YrfwB4yGIwNJQ5DQUqrnBR1iZkJ/yapWu0GI0l6exW+J5mR9pAMNAnChoEzG38LUZbgqK1X5D5epM57gyj1/jUqCFJc0smZN9NyLMBVTJ3k9oND9lTZxQ==
Received: from BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 15:32:52 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::fd) by BL1P221CA0029.outlook.office365.com
 (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 15:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 15:32:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 07:32:30 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 07:32:28 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next 2/3] lib: utils: Generalize code of parse_one_of(), parse_on_off()
Date: Wed, 15 Nov 2023 16:31:58 +0100
Message-ID: <0090c2dd421a51856d33ba62fdcc740624753464.1700061513.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700061513.git.petrm@nvidia.com>
References: <cover.1700061513.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: dad8cfeb-949e-4283-5d47-08dbe5f0215a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tDp0GE2rUTWGVDLY1kZy2XyjDmnriQvdVJZ4aT1DZzUFYaEV++9bK1CMwz8qrhRhoxTKLLGdjs1PjfG/N6gu119g9gQ/FwMtCts8gRuKwawJREX2kDStoLz1sREYdN/IdnXNCy/GC2A2WgqsILfT8IrfkY91urQEtHMDeH64I0qYUohqR6mVQhhu/06inBt2n0yX2uLE7gL3z8iMBedY5rvOp+2CvWKr4yhuvMxA7ai0LScSvnE9KPTAMPz+vNBgrEJXUnE1BY7aTBZ70CZoA2x81XGpTBHQJ+4aoADragF1bgq4UJk4pgIXzjSXVQeM8k3QwEw2su4lrwwvBH8VIcsTqjT+SjaVSQdEVlfrDQfUv3llNlG5oBHbLnkYMu9ashvf4t1sbKQKcUhZbw6Mmwogz185TCILCX5/0PRsqtSvtOsPqY5xZs7g2xT+rMTR3wcJSwuwhPMyGRvhJJCxAPuJq018YZTflB24UQW3uO1nhZq79sXcgnpKGpzs1cbEC+HZfxViuw3Jtk/3EPKwzEx2/ABlWXNQiAwzQnbqHkP0AXOh544Nyj27finLaz6vwe5zRjDIHhcM/BHGzjIKPpzWck5JdrcPsJJ8/1zxY3e7c+WwQaM4dV2DEmvWEMj+DW/LKLUyqYreUUYGb7AMw9u6r4Emi9kjsjP/hNN1MmoN5y2mIs27wJvX6aMtG4qGm2OnJ+RXWymnR96RtHSbVEgPw9x3Cmrucj2tmTlVRek=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(36756003)(110136005)(70586007)(316002)(54906003)(86362001)(40480700001)(70206006)(7636003)(82740400003)(356005)(40460700003)(26005)(426003)(336012)(47076005)(83380400001)(16526019)(36860700001)(478600001)(8936002)(8676002)(4326008)(107886003)(2616005)(6666004)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:32:51.5195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad8cfeb-949e-4283-5d47-08dbe5f0215a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

The following patch will split these two functions into their deprecated
and vanilla versions. Their behavior should be identical, except the
deprecated version will keep using matches() under the hood, wherease the
vanilla will use strcmp().

To prepare for this change, extract from each function a core, which
express in terms of a configurable matcher. Then rewrite parse_one_of() and
parse_on_off() as wrappers that pass matches() as the matcher to keep the
current behavior.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 lib/utils.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index 1fc42a9a..7aa3409f 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1729,13 +1729,15 @@ int do_batch(const char *name, bool force,
 	return ret;
 }
 
-int parse_one_of(const char *msg, const char *realval, const char * const *list,
-		 size_t len, int *p_err)
+static int
+__parse_one_of(const char *msg, const char *realval,
+	       const char * const *list, size_t len, int *p_err,
+	       int (*matcher)(const char *, const char *))
 {
 	int i;
 
 	for (i = 0; i < len; i++) {
-		if (list[i] && matches(realval, list[i]) == 0) {
+		if (list[i] && matcher(realval, list[i]) == 0) {
 			*p_err = 0;
 			return i;
 		}
@@ -1750,11 +1752,24 @@ int parse_one_of(const char *msg, const char *realval, const char * const *list,
 	return 0;
 }
 
-bool parse_on_off(const char *msg, const char *realval, int *p_err)
+int parse_one_of(const char *msg, const char *realval, const char * const *list,
+		 size_t len, int *p_err)
+{
+	return __parse_one_of(msg, realval, list, len, p_err, matches);
+}
+
+static bool __parse_on_off(const char *msg, const char *realval, int *p_err,
+			   int (*matcher)(const char *, const char *))
 {
 	static const char * const values_on_off[] = { "off", "on" };
 
-	return parse_one_of(msg, realval, values_on_off, ARRAY_SIZE(values_on_off), p_err);
+	return __parse_one_of(msg, realval, values_on_off,
+			      ARRAY_SIZE(values_on_off), p_err, matcher);
+}
+
+bool parse_on_off(const char *msg, const char *realval, int *p_err)
+{
+	return __parse_on_off(msg, realval, p_err, matches);
 }
 
 int parse_mapping_gen(int *argcp, char ***argvp,
-- 
2.41.0


