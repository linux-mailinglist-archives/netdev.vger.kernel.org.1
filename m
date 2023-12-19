Return-Path: <netdev+bounces-58875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1808186D5
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DBD1C23D19
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4319171AF;
	Tue, 19 Dec 2023 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xu8G1bJe"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5118626
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NymTkx8OI2XqxcLV4dPht8TahjQ1DtHP/SrkeiaN281DcTnxMKXTGfNQJDDty5YfUGkMw5jWyRmqDKGrD6+lkczO2HVSvSPzFreUgvzdRYxAQuIbGcIqZ9rMgqJEF7rKCRk2MrxAeoFU8Rl3bKNM1CpYDnqdw4IC8x34PFS6ItwwUlX5rC3GJPZ/A7EgoycSgyp7D0VPOQq4p6DNwEoLm+mO3EA1SNkSbZ05BrQ5kbLCy3tayW+kHcST/tewGI7Pi/E6QxheNoa5NHqXRfTrb3OeC03M2y9zwQbij3wObCfceVVpmdPe2Dw1VK4wiU4E0zwvYLTC1dMdURKUpyXqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml/QR8p71UGT4txDZYHWWQ2kQryVnc0IASNACy26S2s=;
 b=dRXrPpieSL6/ihUWsFJ3bFvSSr7PdgbMec4lFe2iMZakQm0S/Bk5FPMnB4qmn05heZSVdBg3r5WbU6OdV8LXfCvos5K5kazN33FwORtjuWo+TIgJtX1XY5oBgGrFKZ0N5G6mASnLgWVyrU/j3KaqAkhC4NrVgzhNLgDHSk6ykmseCeWWTlvGcHn9T4BCxmhjfdwVqy/6NtmphFouCQQNONO5dINHhbS8l2RmRuQANmvbgrnTthgZZZGwV/if08upVIJlF6lRsfFN4BjcK3PR1XKVqgH/PHAYXeNKRlpgyoMQP19bAgzk9B705O6Ojlm+FIuTCQM2aSagFo70w9fxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml/QR8p71UGT4txDZYHWWQ2kQryVnc0IASNACy26S2s=;
 b=Xu8G1bJevvvENIaFQN5Fh4J1xztHtzqFvFDStxa+g6X8PAoHPVDi7VEaBFJjx1Plwtyb6QOFKHh/NK+SDOhbvWX0Gs1ZHE6f8cD3+K9cw8mfRQwAXdgF/HbETVZ6iv3XQ4kGjxyhtIGxCsAC1NSFdjakqKpy91d6wKgbnkE5jU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:00:03 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:00:03 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v3 4/8] dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
Date: Tue, 19 Dec 2023 13:59:29 +0200
Message-Id: <20231219115933.1480290-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::14) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a02911-2681-4b55-c46e-08dc008a08e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fg2If8gNFWEkcD7PzQuh8odE2uKPnL6hfHoAPUP/PLo3np7ca9IDM7H2m2jQ/YmiP2rYtK24HWmcxDCs2TZP2XL0gOCNo2y91Y304TPPnilARDmeMjyJN9Q9EEiyaJiS0ZAsiejP9t8vzjYiLuiZ61Yl+uzPVNVcZx1Fp1z0dSJftHsbuN2GVr1dBzgIPRICvt8jnHSf9h/AHQXz+8TKFxkvB4hHyESmVXyjd/kyR/DOOmZEJhTUoWSXhaLHdJ39Hx1PVmisIvXIqJI9eZ+dZQLrw/1lcezq6S7n5srVdPsRKOxsBUgAIm4jIb2/yEJ6HaT7qxQJqEVdHYe5Ry6Kj/rPW/5Rcos3V7o8WFJVxbkLXschEN+ZPpnmzQppCv5qKJ1JhlStw/V9T6UAOKhd/CJLqhkRBdrJNYvZnMo/KzJelbunFyz/om2dYCeXgkRqMYNyTzi1Z9O7i+FLhmivaFSY590v3uTEsOcGlJLQfagQXzcSxTpW4XeFsI4KxTyCbPPnl3tXnC5/epux/PELH0BR84dexews+k3GMZr9zoAJAt+HRpqF/ImQ/iXoF510
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(1076003)(2616005)(26005)(38100700002)(8936002)(8676002)(5660300002)(44832011)(4326008)(41300700001)(2906002)(66476007)(6506007)(66946007)(478600001)(6512007)(6486002)(66556008)(6666004)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w41bamxl7LxTo6UE7g34H7rxxynoTucDTXJ4oYkhY3XSTao//xyHrljCg5EK?=
 =?us-ascii?Q?/hMUW4zYzDkEx+4BXj7WggnFD4ihGg6jNXphzVysFTh/PzjHRJGMowWYOREo?=
 =?us-ascii?Q?0iHS0YomqMLh2qYHF3kxHjw0P513Jl1x1jbF3+WTRcpohbU4x8GeYLQ4ORHE?=
 =?us-ascii?Q?xr7wvFXlY1hr99+dxlNP+XRo2tPEuvn1uO2y/ruU6IJXwA3tLGhidGkdpDNr?=
 =?us-ascii?Q?iXSAReZEUWjJdQXeMwwKaDXZwoBB0odiw0WcA1E7/b2Oh8rtcQt6P59OlQzT?=
 =?us-ascii?Q?90zmUCmbPZEHQ94nUjUxbJrHuhJ9mEgxCgCIVtL54OyCwoKErQRkD74mSq2y?=
 =?us-ascii?Q?mSQCxpbY5FfWIjbhJ6diBTLQyVGK18J9T9/ARNLtpG6cEuOd9KUvLumLsSzy?=
 =?us-ascii?Q?M8HQtQ+TMD8J6vcn7Fu0Sb622YPsuW0lOBEZqvlx60SJC3oYfSxwEj4en/+5?=
 =?us-ascii?Q?3OHVasFhGZ7Bb8hVzC6RaAqvLu3Ia+q24n7t1TZEhaDbsU4SsJhmmtuwbJJ5?=
 =?us-ascii?Q?FoLpPKcuCSwfdNXF6XvmOhy+8swj7h57svPZ2bnKkPDDXuXNfSEMhlxENI2j?=
 =?us-ascii?Q?5Vvkrqg2aDQNXsWcafbFEp6AGstOjHNIjdpV1iZrZB9WQpn68QrCCiEF57Oe?=
 =?us-ascii?Q?o6GZTWiEzdYtBn6hq8nLmbBRFCMPVp/NxNzTTCGULP7e3mrpvtu+AG54gkwM?=
 =?us-ascii?Q?r/Xje8areepb+PPvNQ818JXjz4e3O3Pr5CJTUwQr6d0IkF6e2lZOaE24OIz1?=
 =?us-ascii?Q?br74Rzw4fqK7WjDBVMiI+nXW+ap6d+LgLRuTK2sx972zQLW3mr8lLb3OmKJS?=
 =?us-ascii?Q?UAVrAn4r1JbmErY+ZUyF1cFPJE0RTAlwJyKKrQIr/2G5RDWMsxZGXD6svA+O?=
 =?us-ascii?Q?V0TLPfBYy65Yl4Be1bISRfmR3ugJh5XXEEaV+RmPzZAMqYTEhONoUlfDxvfP?=
 =?us-ascii?Q?G3UBwNvWdg9ksrhINYnqw+mbQNTbsoslLvH65+bgTNQfhPtet+L7ytIZeH16?=
 =?us-ascii?Q?vAH97IS3UjwXttwtoGs58lXIzYmwY1JuayN0faL1X6dUcE1JAuNtj6A0gW/u?=
 =?us-ascii?Q?yZ1flcfENWGee/TG7/FitVtGC9dcUFYX6dymYtEMW1PQ0J+iYBQKzKBomIJa?=
 =?us-ascii?Q?vg+FL7wFdIvGOWyVL6FkGzAYbZh0gFqbGxkZWQjLCzJQLFFLbgkOdv3cU191?=
 =?us-ascii?Q?RvTteaTb44GKJMQou4pGSvJgetXevNHDeuDzkb65aUpmDN1TIUxTawDtW0vg?=
 =?us-ascii?Q?uQD47RstsLbaeeh9IDQBm8/9RjmqliP6KCSvWKxbJ2phGp+La2YAcM+pvAwW?=
 =?us-ascii?Q?yQFXgVWgAjvDtrSzsUnW6kpCkRW7TaF3bV4M9G3HPYBMlnohjttVPhNh+jQC?=
 =?us-ascii?Q?P8n8ZUOIwGSUfdiFAd6cqpB3+xl1o5K1vxutYyAtaPKWwWM+s944CHgJbxM2?=
 =?us-ascii?Q?oz4VKX0gogc3YkAl/YO1reaxe4Oz2pu475sMft4Bb6KFMcstxj/LRSne+mCw?=
 =?us-ascii?Q?p5lcfuSTMXvLVIewUh56vF/+4+GBwBgVOqIHUz6p1htIpchC+J2a1FA+U6VZ?=
 =?us-ascii?Q?0xYANaFY7x9Pyzmxi1vd0gc4KC2QfI9SO9+Ypr7L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a02911-2681-4b55-c46e-08dc008a08e5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:00:03.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp0kv7R8ezJKJdR4UdAjpm0YifTOdt6EYGvyEau6P+GHj9L4wEXWPXFrigu82Wzt1i4EsHvCI3TZUt3uyML5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

Commit 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
added support for MAC endpoints in the dpaa2-switch driver but omitted
to add the ENDPOINT_CHANGED irq to the list of interrupt sources. Fix
this by extending the list of events which can raise an interrupt by
extending the mask passed to the dpsw_set_irq_mask() firmware API.

There is no user visible impact even without this patch since whenever a
switch interface is connected/disconnected from an endpoint both events
are set (LINK_CHANGED and ENDPOINT_CHANGED) and, luckily, the
LINK_CHANGED event could actually raise the interrupt and thus get the
MAC/PHY SW configuration started.

Even with this, it's better to just not rely on undocumented firmware
behavior which can change.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- removed the fixes tag
Changes in v2:
- add a bit more info in the commit message

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 0f9103b13438..a355295468bd 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1550,9 +1550,9 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 
 static int dpaa2_switch_setup_irqs(struct fsl_mc_device *sw_dev)
 {
+	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED | DPSW_IRQ_EVENT_ENDPOINT_CHANGED;
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
-	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED;
 	struct fsl_mc_device_irq *irq;
 	int err;
 
-- 
2.25.1


