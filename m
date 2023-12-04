Return-Path: <netdev+bounces-53546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4E803A6A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A741B20B7D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FA3C38;
	Mon,  4 Dec 2023 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oijplLuh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B7DCA
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:36:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9KB2S0ZX6H9gup4wknP1XQ6tIuYFBTC7aCY4OlEM8965zhAeR2AvQ5W+cyVrQ+nJyL0hIo2Xcx5w1ITvELT82GEU22CmGLkSIhfthxQ/Y8of8pf6aHWkiJcih++Xmt9V8bYrqSVYH0K2hvchBrn/qJLe6UsAtHnIN/u43cPXXLcZv1ameRh8akXhrEII1bNghL6WWSTy3FWZX5uXiOxEJGVOfG0aYoGU1hm31G4S5I1lOPpQuNG8G955iVCUK6JHJfu9+Mjn/TuId/+S1AOelYBclX7VcypxhLzW/hnrGDR5n/+lZy3omdf9vCnjyy+a3RcLR14P9IUa8JXLHY6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUE8GZ68xTTOVoU/v90/Cl6JJvcrftiS15qiYb3QFj0=;
 b=KL+/7jflE9WJzuDuod/5s+DZSmPO9ZGsfM0tkBlObj6lt5THnyovjDDDW0QGVj0yF/zk2WNZwF9vgvxnR7+05S4NVx4OpB9KaEqvPL7dbskrrRNeFkSaHT9gVx8/o+HSKqkbOkvyfHOdv0HJkLZ/dbpX9+KpAgWCN11f1C93FVYq8COTK6zw1rAh6VCYpzsXagaMz1bXKeEglE/ypqoaTVujKMPBndRGccXOBa5DgZBTSpjP2txuhTLwdeQKa+AxYVxaR8FKMIDDF2lYq/1gpYxeJPJ3YKQhargDtHKXeW1L0UrYXFUkzuB06YTHU0oYba5DqkTi0I7fShQbz0RYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUE8GZ68xTTOVoU/v90/Cl6JJvcrftiS15qiYb3QFj0=;
 b=oijplLuhy2lM/vZD5/+sR1onxCCtNTjZV+JdrajVp5R2vTdUYwxx51rkVcYvHSDbBTkymgZMpipiHLQzhn+HvuYVbMsUdeSjd3uSbfV65PnDqcUvMEsX3nTTCLNIFOmUJhQpVZmJJZez1i3iHt3EQCtD1Gut5DwmSCpENKNl9iI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:35:58 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:35:58 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/8] dpaa2-switch: declare the netdev as IFF_LIVE_ADDR_CHANGE capable
Date: Mon,  4 Dec 2023 18:35:22 +0200
Message-Id: <20231204163528.1797565-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: ce96b9a5-8948-462d-926a-08dbf4e71862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eh2XNjrDJaK5g65Q20ATT6buZYKcVXEERxLA9QnBpg2y6YJYZWcFHE61yfdib0UrfBZURlKIX/B7n68CCo6sf30MGnUuEdkDrzWG6n8nhnR7S0eDT/4a7Zgzx2CiXUqwxJWm23YTinbIx3Ed2W/DITY9mqy+xp+lpOMh8tW/vHYEsDgut7w23sYl3sX1cg1lKwsI/xs++olBv8PCcXgMGk1LurbWCSZQMHrlc/O06UjgdQncWcxU+/qZ76YLWIot3LEmYYmp/QckU0AGHswcuyRYNNcc9ikSepg0h7JgtcKterqb3wpcJDMOiby5vtp6fJCawnwy3PnGnBMbGnKFJD1diUJBnEN9bTpxvSGQxFbdZZWZ0N9ngTjS1q04VvNvuoJTnPXlLQnYZ6vDCE3wRFBi9+qFGTo/T0NyDv6k0BBsUaUzn1+uB4bhNSmeTkLwAVclLlSRSf/RKeIgQ20zVNTpoDrq5HmSS7SXRojQq53yUzUD/8PMVg7+rDwa9uz4SKipTF34w92HvwjqdcxEZQTGh66s/sNXFqPtKaBrAT5NGju9tojpaf9sAl7k6Y1x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(4744005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DtN2xxFxyLuNiwnadSzflnIqiplVS9as3wKiNDmIJZTVPqTp6wp3SCd0UzW3?=
 =?us-ascii?Q?Pf8/rD1MDpnVyCI3yUheMzbSMkl5ypZlqWgg1hgva1rqkpF1ussrolYmKpdF?=
 =?us-ascii?Q?jkribKJ9REhiVUeyElZvD/qpPGjcJgcHyk6TWOAlZimWukluOEQG/6hJxyks?=
 =?us-ascii?Q?ycVh1pb2MpY2wZN3v1PUfQgPEkQdkP4em7S8KUbNOPVAqP3V0L6nIhCqiMNl?=
 =?us-ascii?Q?lNKfgsZdR/ZZXQ7+ZKqZ3XOuDYlzpkwKVwZ/CEMhGIbnNHSRqwN5HUlbVV1e?=
 =?us-ascii?Q?CnmLXOC8VVQDP4MRtTeFw8C2PsDeg/5U8yCgTFEs51Fa5nOeyngWf+OZXFfg?=
 =?us-ascii?Q?mODIfAgJvIQz9XYPA8mtteP7wlTIS27RSlWIRUR0Z6iHLWg3g8dmWMpBOIh5?=
 =?us-ascii?Q?/kL+vehtTv3WYoC3meTzZyNmgysrMZqe9244TjBKku57hQiUDQ83uACKCJUq?=
 =?us-ascii?Q?56hL6tg075sQzDPnBihMagZQmAEDLmPJ3805fji7/u134wAF0e85J4jGCf4U?=
 =?us-ascii?Q?xl1UVUlfR3J/5HwIai3VBt6FnFP1JF8yXDYuvWKTiG2DiC4xMT0sAG/OJfaZ?=
 =?us-ascii?Q?QlyS3rsSdpNr9kUXMm2YO4vNrlX3tY3ePhy1NuV3rPd8NmkYXk2YFcS5piWx?=
 =?us-ascii?Q?ChMI3sEDjNZLTrZAiY9d8kPqnHUDeThNejIn7yhXqkXo3eY+TNn8+GWsYCXL?=
 =?us-ascii?Q?NxTUKc3+gudKlpZhNBg/Uv9u9UCP2wCHZJiA0fkBZMru3g2DUZr+cZMGr4pI?=
 =?us-ascii?Q?VNts1C+IAKksG5L1weApi4Gn/1fADcVmB42wQ4qTwU9K4Ayq3gZYHl/D55C5?=
 =?us-ascii?Q?jTM8cOAhHO/hxQaEZVt9TnMQHxYT/4fXz9HBz/MFXGdlnGByg+heOWZrrAuI?=
 =?us-ascii?Q?+jjVmoThmiq33KMGchI/NrD8566ZwmPUY0W3hscMkK+JBtNn1lzH5oNmB97z?=
 =?us-ascii?Q?qGIgirjTuT7Ttlqf6p5jwBzOTa0MdFxsDGuZvzEVMFUEXEAcl/iionT7MtKI?=
 =?us-ascii?Q?F4wqLXSwlW7+yt4a2XIL6CE4j8AlG+Bd9Mr9H/zMW7gCZUw3XYhpJ7H8Y4kH?=
 =?us-ascii?Q?0Mda29HNAJP0hs2jyXyDqAygTqb+g7Wc+g06fuc69hYgKqV2q445oeEFoq7j?=
 =?us-ascii?Q?qJHanI99fwfm31GSJ1+IO4iNPjZZLXAZdh6O9KtjCIvrIdVTD3PlsR3EaH23?=
 =?us-ascii?Q?hykgIxWGaaJ+clrp3GBd63e5CF3/3R7p0Wtbk4sjmmWr1uEIl3EtdfvmJGSA?=
 =?us-ascii?Q?tW8oGj60ZNpZqJueY/JJMuAPL4jaPWvOyCx00aI+JghuCmEHL4U15yTYpRRo?=
 =?us-ascii?Q?CfpGIBzqONLmfNN1Yef9qZzAHEnp4IyQWBj4TRxJwTxt6aYsPPy8utv3RU0u?=
 =?us-ascii?Q?XI9l1Pmos8DOVRFho6iWdAosmDejoJEvzjFyoSC8PQbYNG0imkk765p0gkEu?=
 =?us-ascii?Q?UQoNY74Vh9o5TeQNlmgLo2DhcDYifGyKF8Ls8BIRuh5I1HDVAWHQ2uan0dul?=
 =?us-ascii?Q?vaa+f5PPCJuwyx2XDFb/MEQKhirZPTGW0+7AmN8Tux8nMKABpr+njtPJH6r9?=
 =?us-ascii?Q?hLSta7lxoP+NUkgBoGFPVzdz8Cd/hq1cefmQaZWW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce96b9a5-8948-462d-926a-08dbf4e71862
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:35:58.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS2YqbHQE3jDrnJXq0K60AaMD6VY5tkYmWYT37s2b7PRgxsRqhn7nkwtgEZUduK4QUTZgdQM5AeDEyGCGE7Ldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

There is no restriction around the change of the MAC address on the
switch ports, thus declare the interface netdevs IFF_LIVE_ADDR_CHANGE
capable.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 08a4d64c1c7d..5b0ab06b40a7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3300,6 +3300,7 @@ static int dpaa2_switch_probe_port(struct ethsw_core *ethsw,
 	port_netdev->features = NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_FILTER |
 				NETIF_F_HW_TC;
+	port_netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	err = dpaa2_switch_port_init(port_priv, port_idx);
 	if (err)
-- 
2.25.1


