Return-Path: <netdev+bounces-110284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50E92BB99
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7030E1F218AD
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF55215E5B8;
	Tue,  9 Jul 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ADgmHoIZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485D15749F;
	Tue,  9 Jul 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532522; cv=fail; b=M40jGmiEYDWCS0+P6w3l+TYwGbtyDSL9lTrenc7n+yjCzT22QFZ/ItB+8dK+TENthASby41MWklUIuWZnfsCNFSw5aS83gS0Cep1xQnvV6SPyW6qbuY5Ow6KETdjZhPIoRLpk4fjGekKDE88a33dUcyK/IWoEDkrk/wFBWDJxOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532522; c=relaxed/simple;
	bh=Q7FSgH1+U/q4gbRzOqfQ84S5/ylbjdsvbfP7q0J5fRg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K4RIMGwxBsTNAdR8sUdtpbto3nGjEsC/cKU4taJeR6+cMljB4pvWHrxReV858ygU8ed/wNe2oN9c4TfU7JeYMSvxKq/PA29Xk4ELHDXMouFu7y8KV0hs/ONC+bO1Tz6IgfVpwLPU0qKbHZbxsxWbwPlAqFiSBqOCsZGfXk6ZYns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ADgmHoIZ; arc=fail smtp.client-ip=40.107.249.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UldQi4aWtRDqREJCLePuxcA4l5KuFkOdItrBqVe/yGP9PegDJPV77ooRs8RZ6vGVPpPePv6+JP3algWnK4O+NLcCEbSa1Om5R8ZhsagyKSLmV0gzNb+COqEcFBJNv/VPxX5N1qUp7bS34Odw8U3hLiK6vbOTNWFmQvJcvPBCdcGttA1OcuHZ7MwDsLPiR0quljL/59u5itX399TpnopCyRt3LdRZQqyUwM9YTVqitIOedi/3lKxzMz7oCzJsJvPZXaEdzuVP1UznBxm5JPNkOoPCJEIyzOXyXOjjm5zsLSyAoLuSO6UAO7gLFp9Dus7ujrURp/7Ss60B9i2MOYtoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gEhF1USxOzmB4xzAb4aj+nN/yRga7wz+2KD+KDTuYM=;
 b=Da2Jbzu9Oy+D/LQB3xDyrvpSnWzWH76BKtd6oqGTHFoCRK0VSsmG9M1KmnM7mPMRFI87MV2wYJgR5/EcM9SI6WcsvpkU3qeaH5r+4+jTzX1Mg7yldYcbTaUOWuwyty8pm+8vlXxFaacJg5ETE1chbYCNkFyGfQI2nbzeDFiXZVCxO4V5IFWt5F9Px8aPiZ1FV8fG/+OBsHh/wgz0pco+lTHBpjQ4S6Ja5mj12d6tVaVvDt3vp7KQbYrjXSws4C/WuMpUUxcGN+A0hYgRXZD2YW+WaH29EZd8PGlEQ12XkdobAKT0SNumOTB93a6ZULr8tDXU31wd1/2AbYjBZLhxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gEhF1USxOzmB4xzAb4aj+nN/yRga7wz+2KD+KDTuYM=;
 b=ADgmHoIZgcGWOG+QT+sZIZNP419bMbhI0037CPGXjrLDETtmL152VvtpsRAhJ0cz7R3SpAQzd2h8XpIv70mSnx5ANsWPXARQs/4qtHNK2nE7BlRCIEReHKTvczuLjTtWGPOpo7ntjL2E2hbdAzgRp53DQc99DOt8n+u1qJOCnV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9938.eurprd04.prod.outlook.com (2603:10a6:10:4ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:41:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:41:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] test/vsock: add install target
Date: Tue,  9 Jul 2024 21:50:51 +0800
Message-Id: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9938:EE_
X-MS-Office365-Filtering-Correlation-Id: e09918b3-5a95-4651-57c3-08dca01ce60a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRd8T3uus+5lrfdM68dRflTRvTmAjvtCT9u5tcCZEfuYUsDXnNyxFnzqsTgO?=
 =?us-ascii?Q?WxtB1IdjB+9KEblRQjiFEQsVWjxTWllmLMb1OAbD5slqSxKDFn1wC4Dkkt2n?=
 =?us-ascii?Q?taJkJs5UgEWVqAlIK1UptfMa3DRLAk6kEzcWYFyPnI1UTSQv32hb8jrfRuj3?=
 =?us-ascii?Q?7wabloDDHzRhV/0WttWINGxIo6s3JDXUNGlieM2Ef9fSs2Ct2emZQmZdmOwz?=
 =?us-ascii?Q?9tNdXPK34v4/2wQd8wNUL3JH37pGBTYUthyH7IGPDfhlZMEPzBC2Xoaa+dMH?=
 =?us-ascii?Q?4vC/b8Vsg0NirJIdzc3XgRXp6H99jn2JxaaTaEO02fosER9khZTJE9ejAbjC?=
 =?us-ascii?Q?FMnYGQBCFgnuD23a8rcJVCXGiRfXXHxes+AnUD0LPbV1NoOnjtIxF0hyBieD?=
 =?us-ascii?Q?fFO0IZ25tVLFFB2SiC/LfMwJ8WiauF8YGulN/wGqMllDqDoJyd+8ujcj7vtN?=
 =?us-ascii?Q?JaZXXx5mOO4+WmiApf8nd/fK6ca7oXf6qk3TbDxlNsVGYi0nsdm6XCStjJ15?=
 =?us-ascii?Q?uHWrRSZc72eAGiKPTZUdFKddlMR+9lPLFpbmlkZ5iPeYo7hQ+/Ql5X31we3h?=
 =?us-ascii?Q?g1ZzvH3rSZzG+6+FbfuIsc9KBidNnpfeOAh+pHuIRA0CZTbqiMN50G49SrMU?=
 =?us-ascii?Q?zrdyGVDyA3E8q7H9K43KEAipNS5KDQgigT9lIUCB2+QdZjAL7DnSR2zr2x6I?=
 =?us-ascii?Q?y/vLuUjlU372+7ipzSQ4ANZtFwmeiudlzQkc3QRyrPOU7iHtkZMlOHOHd1KL?=
 =?us-ascii?Q?qQMHXNm9Vg9IqM81yvHynNTjr1+gk4DhXtFXYY3a+7UUYa5Y6HAkEPVR+kIe?=
 =?us-ascii?Q?qKQK1wFeWqW1oSE7ZWcCfpPxCIrfwnwvb/H8EDJGE7MudMwPMusVCqAXyssb?=
 =?us-ascii?Q?NmmUDt540+uNGqLsYhgemclgVttvAUYBbCmQfIQGHgStecy0nYpk5cmXi0pW?=
 =?us-ascii?Q?wKRNyKky5+Wzjg4OGMryyDaHCcxiIZ73JHgUHD9KIRL8/W9czz7Ke0Q14Vck?=
 =?us-ascii?Q?r4wvP/usUNiw63+bBJ5pPuhy7goGBQviwDTslBXloAHyN9zC/RSYHHPINcf4?=
 =?us-ascii?Q?SQJsAxgKGa+ytAbHUA18AFL5fYXQFQZBhzVcQTq3+J+CRQfyvrcwM/GJ/zqK?=
 =?us-ascii?Q?YoApK5hinHkj0KYNxjc61MrgvKfWn6cceSmqjvxIOOOra+Y4Q/p+SDl0dVWE?=
 =?us-ascii?Q?npIlg+LieoGiuFcXTpXQk+d04KeTKwiEGRJ1zMAbAm8cbmbxoSZ14THEjDpX?=
 =?us-ascii?Q?oNlKB5TqfS/M9x4miNh9KrubsfEn6VFrtfRabBl1SRV3VyUoO3VQ4gjI/Stl?=
 =?us-ascii?Q?9iaivwjTjBvfOFi68L6lYojwt/Tt1zIrtjhmne8qNabveki6PYqy6FW8SniI?=
 =?us-ascii?Q?i2B0FW9gUzYiWMaVtld67Y/UJ8uedc6E7uix+Ba+oXU/xprZ4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NW9kBEItC+29lVtucHOtw6cr+vLpZFoZ9OHztxGT23ZtfpJzu7KLp94ETv8g?=
 =?us-ascii?Q?qF8o4wapV0eOycdA6UnWqtRuJowAcoNgmppXRKW0RBT68rh/WQPiv/D5djZo?=
 =?us-ascii?Q?mvWMkbOiKylgZOhUFtMKXFq9k26v0tkGoHINt2+iLNoGXay18g2kUcVAmHAw?=
 =?us-ascii?Q?y9TZnEKWoKYbtmTK4ROsJBm9gfwHMpBQHH+EpCdK8ya6o7WyfnC46f9P62Ja?=
 =?us-ascii?Q?3/FnN+A4vIxeQoMx0u/LaBh9e+HRjibFNPLVf33moGpWI1rG1LbDRLiOsO0P?=
 =?us-ascii?Q?EkCA3lHVz2yM6HmEWsDdechi6OkvpD+DKjkdH2uTc7+d7KtDXCCOAd6PHbOs?=
 =?us-ascii?Q?gVUiATpS75Yt1VmM/7Y09iT16USjCPlL1ElSXZMen0vsP6kUItws5x8ICiDY?=
 =?us-ascii?Q?BdV8JbpTPEV0O5HvaQPSEUAJ/1o9NRFdG4LvoNooUGY/6PEzFxNFNChg5qov?=
 =?us-ascii?Q?9mhoeIN4cVaHk19LmMlXKDquZqOpTnLPRrf1jkBOguJRDzmqZEsMvKP9DwYI?=
 =?us-ascii?Q?oucNNH11MVt7Twic0UcfEsU3zxCO3SYcqUQUiXaXtsVsF075NBlyuEtH6ufi?=
 =?us-ascii?Q?qq68JG7cPQvGqhOKshsL/7TRRCfTlotzUNyac4oYCWVGxM8yIot1TuL9Z5Sp?=
 =?us-ascii?Q?8em+5r3qRCgG3D449JxD/kuP8m2pr5kd3hiVBow5ie8YSroVXjCFZyUwVSsr?=
 =?us-ascii?Q?zbxhuf7wNvu4p4a5JhlgFeNEzHOAFyVU9SLFXuwVUl5SNgpr6dD9nMjEDxoX?=
 =?us-ascii?Q?+Se+2FJ28Bik0GxSaJ4vQ3hNKobwaeFNYihX6kGmDpJGjIxfEbbcFnDeS+x8?=
 =?us-ascii?Q?JMhMZGx38/y8B++6Kc7jg//4hT6T7isAk4gHDVdvUurOWNg1J+VwmlP7b7wH?=
 =?us-ascii?Q?mQMarfPpQPU+x9W5vKUt06cFkYUTjXnmbqZGiaBwO0kNSZpHrptBeOVFgac5?=
 =?us-ascii?Q?bzLHENpzXn9Te2at2rWZpAbjN1FFXw6j6J83taKzNct04BtsCVnH1HOEG1oU?=
 =?us-ascii?Q?TtAoB0zmzaPxQp7SXysVSMQcXRR8HD9YOP1PydyXKBHC73wJcClvPguFvtAE?=
 =?us-ascii?Q?ShHh9VJrVg/xnRwcOG5wai66v7g6Oz0jLZOLTMMRV5LFIVx3VMBwd1EQpxpe?=
 =?us-ascii?Q?CPuvGoiofxjZYrEtV/EII/4LIVfWZhvIJbENmgOLeGglIOhkEvo/dABnZF6F?=
 =?us-ascii?Q?sc/sWa3C8NLWB0uI22q8YZaLQucNdX9PrlV5qgW3TorBGHkOp5XzO3QIk5TJ?=
 =?us-ascii?Q?00ebDLcVvlrHjxFtlRJy8dNAlxL7NdykByCXRXgT0gvOt9H2FPvDSdP492Yn?=
 =?us-ascii?Q?+LWzShmXY7eGj+dfzl9sPM45xa5bTkMwqo8YDW1AAtmo5etFLNl/t70ogK0a?=
 =?us-ascii?Q?WC2cJs1t6Qoh/WOmjm30DJYRPdJua5tzvtK4iPnRXF4TtxC5oCGBh5cLf9qq?=
 =?us-ascii?Q?fybjjCN0b8uN9qnisbUPNuWKv8t16jZA6P49RWYafv7o1yCD3NQY5ym/T/GQ?=
 =?us-ascii?Q?xe+AzAHxyaPjWfqK9DhKoH+upmTI8rXpC7jKCURFy1BurEp30jjgZSkQNc8u?=
 =?us-ascii?Q?hwJ15fmlaP2zqJHk5Q+AuNltOg7/lUZDVf9wadGl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09918b3-5a95-4651-57c3-08dca01ce60a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:41:56.3685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOC12lyLG829weAco3JctSwKZjHiB8BGRuv/Ie4xhzohmo3GC/SbioGlLg5pFrshw0Yp9kyLWcpbeZA0QlO1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9938

From: Peng Fan <peng.fan@nxp.com>

Add install target for vsock to make Yocto easy to install the images.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/testing/vsock/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index a7f56a09ca9f..5c8442fa9460 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o msg_zerocopy_common.o
 vsock_uring_test: LDLIBS = -luring
 vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
 
+VSOCK_INSTALL_PATH ?= $(abspath .)
+# Avoid changing the rest of the logic here and lib.mk.
+INSTALL_PATH := $(VSOCK_INSTALL_PATH)
+
 CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
 .PHONY: all test clean
 clean:
 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf vsock_uring_test
 -include *.d
+
+install: all
+	@# Ask all targets to install their files
+	mkdir -p $(INSTALL_PATH)/vsock
+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/
-- 
2.37.1


