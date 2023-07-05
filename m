Return-Path: <netdev+bounces-15515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C230E74828B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 12:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC86D1C20B1C
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB963B0;
	Wed,  5 Jul 2023 10:52:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BB2578
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 10:52:16 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527711AD
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 03:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8sIFkTj6QfmA76uE7gL8bWC1neOYcp59NXeo13GQ0Escys7A8EwGlX69t5SM+yRIJdP+ncRPi6bsGD49liN2rWqS3SwjldM3+d9i9+5IKaEPF2MjRM4piZxEi848fvvtR3E4n6vA/347WjVFMA2K8hF+JPB9eJLQ+N7rwgFppGJn4XLSZD4opejGN4D7EWK2xX6W/so+BYePWzsne+9UEpACycBZL2I1Ww3Bs6iIJ4hWwmoZ8EohNjUM5blofcr7RmCWYiFf0SzK8QczE/PSFWXFoQ1KjU087+8TJio0Ne6E27njMfEAnpfjvVLFtwIK95E6PQroqB8f77Lqp2mdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKee0ihTdHUEsoRXyrwuwDosTVbRUZQFsEOlinEv2uk=;
 b=QUs2Ww7u7sd+Iw78ON7lRxhR2RxRaobesMmalKxhH0eoyHoNxWNfMvU2ezYCXvVd2V93u+q+hb+UGefbHJLxaKwA/2736fMqcZ7Et4ya6jV7vx/r0t6Y97um20OqcHwvnMayObpHsA8OPmA8RxB1B1lPkIh9dfQRqSNY/X8SA4Ku2MWP9xS5cBAnRZPWkSU8EeE8fqzxEtZQWuiYT9rJRvwL55C6jVIwOvsmsvh6OUIUeM8YTdaWSifTBfs1oTSHXyR2bs0cbjaEMbbYAfNS8i99F5ZrumOQ7IqN2HLJSrGhG7F1SauAEFOCoh8Fi5cC+7jvdseHvMHmmnCctx4tIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKee0ihTdHUEsoRXyrwuwDosTVbRUZQFsEOlinEv2uk=;
 b=U1TV1qgZDxrfKcsDSQNV4Cv76pi3b7XUDDX9TqPCAwiC+QoGeRIPlgBs1YHPHpazL0IRwZ+pqBkDAqRlX0eF79J3g0thdRaEetplguqjyXzXgQy3hAcGbp8tK9y3p99sl/OrwjRanlwVPMDZI06zYtlwzSsHNfS0V5lCRlgGUvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9961.eurprd04.prod.outlook.com (2603:10a6:10:4ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 10:52:12 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 10:52:12 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] tc/taprio: fix parsing of "fp" option when it doesn't appear last
Date: Wed,  5 Jul 2023 13:51:55 +0300
Message-Id: <20230705105155.51490-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9961:EE_
X-MS-Office365-Filtering-Correlation-Id: faeb0710-8c86-406a-3707-08db7d45e371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FlKGMH9FUoev7SE6uAS5rZNzbrFkU4e+7Czp3h3S28to+pwRDI9kLaJ4oeDC8EsofR/ovVWC/6GrJkn+iVkZQcLXcVctFKWEo0zgJf9gp1ryND159O1g5ViZ/j/FqHVbfFMx10MKmRoYrnh6570gc6DmbV5Q2bkItG6tZa6QzXkVym3Pk8IAWw6ghhZAn/NJYa1ljIMFUO7x2GM+nGhsoaIFsyZHrb24bf5PNeB26VKZR1KM1x0z90Hnp5fec7sroWO+n4Bvuw9IshoxJ0Dpeb35fOQaPYRL5IJOasr5hFPZoFEZRXJdZpGwHKKxgRIRQXfgjmksjrM8QsG+ttcmUE7S/JGBGlpqsIkoT30lqVTAX9SH1IMktcrjYHyd7Lg/kTfO/j4+l8Bu2Kgv150UWtGeATmzLseBXcHSLPqnQMP7Ksk0R7B3eRHaabC6XLbUQk26QVNrhmM56fLN9LXGwpVrI7yaLwObQl4Z8CqmD/Np/XgnDWNPkgQrHziNQS9SY+XEzbBptleu4dWBLS1o5b/ENX/q9327aN6cOV0Ys6MW5BHoUcOKNKqhWiVe3Wxy9RAM3PM2p3eSHFUHBWx/UPti9HWqEkM6yXGFPXu/FhGTmSgQNBjEoY6QC8tN/jEC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(2616005)(4326008)(66946007)(38100700002)(66556008)(66476007)(38350700002)(6916009)(186003)(86362001)(478600001)(36756003)(52116002)(6666004)(6486002)(6512007)(6506007)(26005)(1076003)(8936002)(8676002)(54906003)(44832011)(5660300002)(2906002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AdlQ+nKfajd+/2fDqtR6iDJzo6KDFKRhpz+5w4vcqxNuLw6ElyRVOWNzxLVn?=
 =?us-ascii?Q?idqdixc4hSAhOZxCB9TMPFeapOuHXBKKThc34lRcK7sIg42+Ba/JI9yvrAde?=
 =?us-ascii?Q?L8a2Q/kaUwHiunYHVbFzM8fsSgH88H5ZVEkootxDkutu67ApgsN+epYTszqe?=
 =?us-ascii?Q?xVD6DQcF3Oote8h1GCitjXR1YJRsIb0MmFekZBDLkXEWCSTckab9OkeVydvP?=
 =?us-ascii?Q?CjQrCvsIc/jZdP97qD7yUF1nm/pUyN+ssjBF+u0xfXCbMNzIqSmkZgFU3XGl?=
 =?us-ascii?Q?371Q0kQQEwjQlb4Yqe9dS8OrFL7XTOdwvriK7dlnQsEkdFGtZIQaWfppDDWN?=
 =?us-ascii?Q?aNLu1QBXSvWTr2WT9gIS1l2XfM3VNJMthRqR8MUXVhCQ4GX701wAHg+Npb4f?=
 =?us-ascii?Q?F0D5t6Ltxv0KGSFukY87nH6ffYRGUOnh9+I/m8Hzth+M2EMdHKVWWtIbWsJu?=
 =?us-ascii?Q?OCeQucR05ovFGdhGqEdRW5mzRDhbU/injoVPpZH7aEo1d9oDsl3Z5M0jzP98?=
 =?us-ascii?Q?uvCGVQN/rQAuUnlAAy6JAzh0gz/HT9twrQMdtg8yoM2IXTwMbM3E7gYqC4DW?=
 =?us-ascii?Q?E/7pDmchy09Amn4kxDPZh8GnkJsvChSR2SZ30DscomPdOLPchayNtgus4bKF?=
 =?us-ascii?Q?TfulWqsRkwptv6LtMHcPv0D0q2FDcNXHfhDvcmzmUS87haEsY/Jxe7IKrGhn?=
 =?us-ascii?Q?knCfdovJUFkD/BeMJ7uMbRwX7DuHTbPR+M5HspPJC9XTkgoF8Yl1ouZ0nAXr?=
 =?us-ascii?Q?WVMM32cpcTLqiU+Htm/z+TW1oBPzngHLBlHCZ29l7DYwmPuVTUv11I7iR0BP?=
 =?us-ascii?Q?GUL1p52Cdwi6mBAXmbSKt16vPoI4f5yjSoLsvosogwKLlfvI1hDH2P5vZDM1?=
 =?us-ascii?Q?GUMnY0tLrZbuOyN5Y/MMWxwyHSS1qVcjD2EjaKnxEhTRRZtvuhdw61CzboOi?=
 =?us-ascii?Q?EOA58LKIrTieaZwXUjM6dGgvOPHkXF7YxN2+dOQd3uXm3HQZPODhlJ/qrInQ?=
 =?us-ascii?Q?9Lq+hi2KWq6xXRT+9+BTKGyuvlaV7bL3gI9fJFIoz8A8Ib4tSupYbhzW2t6h?=
 =?us-ascii?Q?fjGw4vJMYgnfYWQB3uXwb/T1SH/2a3B4WZIIkDQmGe7Py3xs3cu48gSdGJd6?=
 =?us-ascii?Q?QGzXXXgHImjgDJdkRMwn/0EdeFhtwbSGvRvEbXDtUJc1L7PSL4gxcRqi5jdV?=
 =?us-ascii?Q?Fsgz6bOKwHFts2WqLI3PvdhHz7/IS69lEouLa+dn8sVsLP7rRVGDPIVO+aka?=
 =?us-ascii?Q?4/VMOXezEatvhzqqvUcfdWUEYBNKM+P5etJkvPoEiGPMiXGslfQhR5fVM4cK?=
 =?us-ascii?Q?tmk1on0yj3b29IWXIjwCQ9hmRZDeb3rtb57o9tqAmbW5AAFxS/Zxvi9OmVuf?=
 =?us-ascii?Q?goUmaDbD0abLE79sB+5gFI2TPH4/ZuYz7NSX9T+PiE05g1bnLv9gjnDt50Rb?=
 =?us-ascii?Q?/mf8lBi52m2PVFioEYKR5Yzh162n9u/fIcUkrFP8navCR3/I5/XKyUejH5Kb?=
 =?us-ascii?Q?RhdYjsJDjE3LyJKpejwdnFVPrHixNIRxBH6wBOx/SxT15dIwmbVLtJQFdHTB?=
 =?us-ascii?Q?yu0MTRXjTHUpri2+PAjez9ZiLUk6zL4WFtFEbnZyJ+E95l3+/Jmx+8BvIHZ5?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faeb0710-8c86-406a-3707-08db7d45e371
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 10:52:12.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXKr95F7H/vBdBGvj7KFNnImTHU5F0CCFUdjsNCdyN+vRKiS9t8HXCcdKzfhXEMXjWt2O0VyBq6ihYcu4Z0X8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When installing a Qdisc this way:

tc qdisc replace dev $ifname handle 8001: parent root stab overhead 24 taprio \
	num_tc 8 \
	map 0 1 2 3 4 5 6 7 \
	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
	base-time 0 \
	sched-entry S 01 1216 \
	sched-entry S fe 12368 \
	fp P E E E E E E E \
	flags 0x2

the parser will error out when it tries to parse the "fp" array and it
finds "flags" as one of the elements, expecting it to be one of "P" or
"E".

The way this is handled in the parsing of other array arguments of
variable size (max-sdu, map, queues etc) is to not fail, call PREV_ARG()
and attempt re-parsing the argument as something else. Do that for "fp"
as well.

Apparently mqprio handles this case correctly, so I must have forgotten
to apply the same treatment for taprio as well, during development.

Fixes: 5fbca3b469ec ("tc/taprio: add support for preemptible traffic classes")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tc/q_taprio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index 65d0a30bd67f..913197f68caa 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -250,10 +250,8 @@ static int taprio_parse_opt(struct qdisc_util *qu, int argc,
 				} else if (strcmp(*argv, "P") == 0) {
 					fp[idx] = TC_FP_PREEMPTIBLE;
 				} else {
-					fprintf(stderr,
-						"Illegal \"fp\" value \"%s\", expected \"E\" or \"P\"\n",
-						*argv);
-					return -1;
+					PREV_ARG();
+					break;
 				}
 				num_fp_entries++;
 				idx++;
-- 
2.34.1


