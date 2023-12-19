Return-Path: <netdev+bounces-58873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887288186D3
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876B31C23B4B
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E3182A0;
	Tue, 19 Dec 2023 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EysnXaLB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62E171AF
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkG9lxOinWb11iOsNsTZP+tEcFYBXWCEMRxFMjghJZUq4Ln2ySaqjouF4HOQdgjLGd5QXfTptFOLKiPIaOzUWtgFcq2AjZcaTTf4OIZTk04Z2T6pY7X19nCFHewRlAuAm9PLbEcgSiWYKo+mOiYRK58u7oZTTo8yhRVaCymEUCxkn59P7l3Q/YTy/NcETKAUWXE/7wh8USrl3+3gxAO6KKNZ5R9V6eOJvO9PGAFWU3qrdqBnorkWcPwzOdT4OjwN+ogVsY1/ToXCJ4g9pwk44dQ7dMHLGrj6IiVMu9RzWqW/NA89y5jPLt/JWGiGSCgDVkrwvC5bQuHpMIUlqDLCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eo9z29urSqhljxJRrc6QpnFmcGjCqK5/Yb9pRH4c9A=;
 b=ZS1QDpRTMIOnAbUJCZe3WqYr3Vvft3E5Edlcylx/TpwwXMroYJQ/jAs+UXC2d2iGOKn+0ySUCAy3Jd4Ley9a7+NqnSzMHCB8hlSyMoBU/KGtT3WDhi9TJgsZDfNXHfzBZlM/fhgQRjGz8cSwIPjmNwfgU7eKaVjmRkuHSyVRRerRFaPa8jZZBxVXIFoD2kLdbf+fpOnKQOrE0y2RuJeGAviSAxlwqKNQsnwjmygV0MbDizWF29u9uoHh2uulojx1s+KMTT4HpJEYX84eHqaiD8H97J0Gv4wuIxYW6XQgdqoees562HGh69RUqkdy7D6Au4GzkEq1ElUOVskq+aYb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eo9z29urSqhljxJRrc6QpnFmcGjCqK5/Yb9pRH4c9A=;
 b=EysnXaLBRpdb5rYR86S0tLFFxFku9f9GRlic8yBpKHtXm2ejPS6RPt5oi3ftgQDOb+23jEGMQJaJItm+lpxcxYWpk4oE7uL2b6ug2ugQAub+OSXbYTkac2xX3zByxRIG/fw+axXzQ82WCL4RNrX36KAqYdJaBqHo4+4nrkKcN1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB8786.eurprd04.prod.outlook.com (2603:10a6:20b:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:59:58 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 11:59:58 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 1/8] dpaa2-switch: set interface MAC address only on endpoint change
Date: Tue, 19 Dec 2023 13:59:26 +0200
Message-Id: <20231219115933.1480290-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::13) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1a7383-4998-4853-c510-08dc008a055b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5RBu2Dq6q4KzEPgbcQzT0Rvm1AILc4FIS3KIVMfy7EXuU7rRwekvl7aUKlkCapuu9jyson4HX4qZOlMZvPNSzKgD0s3dv/7AAZO3nyiC7OJkpn91I6RnWtdhl+j7vcxuC+WGfCf5zErfgofWRrabsIeZYGTqGHpPMBFt0mMMfXW1K3MSugBe5CIbhlkmLjL0xfDnaQSaUMbWTEQwWYLjo2zfO96ZPcGUVa/atLGhDyBvPAIxMndCtzcaSt9xyN2XKIlV3UjvrmuacsObdzGnOnPNA/NuKH21JXAm8yh4D1rvEqO3cWvGFUDncGoDejbzLkRFmbl18iuRv3yMTTfCCwIcuxOG4Y6BlQjEIiSB1Dc2CBpDbGTKT3L783nUzFT1Crp0I2qXsvDUfRZv6MTGCcZnkBM+Bi80GdLvYLu3NSk3AA4C4RVzrj9Xtg1DBtlK3DWklOhRCwvuu660XZQgrvbAUR7Oo9uU0iK8c4ZbYKPNea2SXv8LdebDCyBbabT1b9+qlmf0+yz8caKMCkSoXXPQb3XcywbrWhy1UXhFWr5gLVsCBwkCNYTPEyqdVrqq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(8676002)(316002)(4326008)(86362001)(8936002)(44832011)(6486002)(478600001)(66476007)(66946007)(66556008)(54906003)(41300700001)(2906002)(36756003)(5660300002)(38100700002)(6512007)(2616005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJKvjpOORV0E9Ugc/C9c21ZNQEMJvKTvKSaCTbFykSTSNBK5GowubE05BOzG?=
 =?us-ascii?Q?H3ZyudJqfKL883Gn8kb1wKYIEHp5aHGuYNHfdBHEmyLAJWR9FvoxgADZo6RA?=
 =?us-ascii?Q?+2OhHJmMkjpEGVyRDuoEaFTFbTIdojTVMCKTqj/gjIB8NijacQeygeamNIj3?=
 =?us-ascii?Q?11V1QUjs4UhQCYOvuIsZrNB3KN6Q6b0/Hb3lhiic+94Mp/SI9EW5eXu6yUax?=
 =?us-ascii?Q?bJpztN2qibFLIPrm2K2J7gg8R5mlnIqecO55rvwBtrDWcADiuFZSUwKqGMb9?=
 =?us-ascii?Q?O8JlVocz+lYF8c4OihM5ryVDldIjnp8bZ1lM9SoAWJUmYdO+CbPF+3mlKh+N?=
 =?us-ascii?Q?N3VIn3gnLh3DTY3k5yejiIzw4haDa3pQlMp4v2PipZrraxNn4NitvjTkIAn2?=
 =?us-ascii?Q?ekvBu2iyx16TwC/MSQHGPYhqiJdGEPnZkMeyUe413PyfRGWncvVKjTdhN8ZJ?=
 =?us-ascii?Q?v54jjFOZ71Zm3lt5RbJQTOT9mwyGiVb7hNFHiD5mgE/qNuLq8bNayT9VUMhz?=
 =?us-ascii?Q?cnTF9knMTOhAt3BL9Oj9oF39j5TWorDLtIM8KuVb5cmvZTSa6dxdu0PQLtib?=
 =?us-ascii?Q?WzYhmb6XAucG51gRRFY20lDJcqSjvMzU6ymjhSF695wNLiQNd4lp0utUlJNF?=
 =?us-ascii?Q?+MwT7quZwBHpUcESA7bOfO68oh9QG8R9I3Zrizd+V0HUpLf6oDMkKGhCmr+w?=
 =?us-ascii?Q?r3hCcLKIKds/MElydLnJWOWcR7JNF47dRX3UofeO+tbEPTvmmM1GckDhVVn0?=
 =?us-ascii?Q?2PUqpNtbhAkIqkvmDWEIsSsMyCVMhuQsKTJJYUru8HoNt/tbFl23MpAUSBkO?=
 =?us-ascii?Q?JlyNZmc8UXwBYAWXYoOaVoFWBfUvKYPd/3rGWFQDgB9Z10asGqQazQc4qvT6?=
 =?us-ascii?Q?0D6lGJO1FqVUnDPpo3le+PXJF5nR0GS+4TlBLjWJ7CiKhFztBHoTeduaWTOi?=
 =?us-ascii?Q?xAAzgCazmm/qgroIgYJBLw/jRh8r0uqW7V8SsOnrDo+lCvYRWRnfthbFR0HM?=
 =?us-ascii?Q?2+ZhWTLXkLGOaoQFYF4CgmGOjYXTxSxlk7niSHBOLafuoRA0pO3B5CYgZ+AT?=
 =?us-ascii?Q?KC3TOVMqVyHAmcuJo2F4A67oeBFRa8Zlm0JJqRTz9MPEhyrEx5OomIfb/faE?=
 =?us-ascii?Q?RvmrI15sHvf4UPHnMJw0ILUyFZJwV60EQwAU/kHzaHeeivFjYgO5t46YxOyc?=
 =?us-ascii?Q?F+yrMryNXa6Fv3erM2Y3TdNBXjKkoss+uyKXg9yQXP/ex1+l4+v68h2x07zq?=
 =?us-ascii?Q?cc1y84a+4VHbjB9RYPsRdrwBb4PCftzPHwRdFGCRyzpuorTozDpH/4Gi31CE?=
 =?us-ascii?Q?ZSkHURI1XdQRA36HEJ4ceUX6Re07sqZCutUuEjM8klSKhySFyLcyQF6K95fw?=
 =?us-ascii?Q?fG0ssFcJPnj+jH5h9uEA9zj3SRdvF25p2chPRd4KgKpkOeSVkv1akb8hhFDY?=
 =?us-ascii?Q?uNnDKreZXwxEqMc2bt34KmTUq+uGUP9e3sCFIkZOE8Tc5T6WaXA5/Vn/mwJJ?=
 =?us-ascii?Q?t/EjCSti5/mdjiq3cMFHiNY6H7AEF4ls/NdMtOi26+1Gr/1Sd6/dehE/PDwN?=
 =?us-ascii?Q?P9cUivV9NB2MSXE6kpw9chi/cLGwF+IraEd4fZCD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1a7383-4998-4853-c510-08dc008a055b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:59:58.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkRWpC0sJHIIF61b4oRgeMgkQhOWK5oQWzp7zCgzWXNcZi7HjD91u/7fJxrHfHZ6jvnpkjcrOOpMR7krKH2W9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8786

There is no point in updating the MAC address of a switch interface each
time the link state changes, this only needs to happen in case the
endpoint changes (the switch interface is [dis]connected from/to a MAC).

Just move the call to dpaa2_switch_port_set_mac_addr() under
DPSW_IRQ_EVENT_ENDPOINT_CHANGED.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- none

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index e01a246124ac..811e2cfe6c93 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1523,12 +1523,11 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	if_id = (status & 0xFFFF0000) >> 16;
 	port_priv = ethsw->ports[if_id];
 
-	if (status & DPSW_IRQ_EVENT_LINK_CHANGED) {
+	if (status & DPSW_IRQ_EVENT_LINK_CHANGED)
 		dpaa2_switch_port_link_state_update(port_priv->netdev);
-		dpaa2_switch_port_set_mac_addr(port_priv);
-	}
 
 	if (status & DPSW_IRQ_EVENT_ENDPOINT_CHANGED) {
+		dpaa2_switch_port_set_mac_addr(port_priv);
 		/* We can avoid locking because the "endpoint changed" IRQ
 		 * handler is the only one who changes priv->mac at runtime,
 		 * so we are not racing with anyone.
-- 
2.25.1


