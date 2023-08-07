Return-Path: <netdev+bounces-25024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A52772A2E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED161C20B67
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1962311CBA;
	Mon,  7 Aug 2023 16:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DFE11CB4
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:09:03 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A10E76
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCqK1cTx8nrW+QfD6z7L4uye0cvr3utiZDM+q7JF7S7ilU6LKM0Ayhr57P/GWJnCjL5n/kzAouTfoXznpaJJ0lgcw6u1878p/pNuI7h51e+SJUhpy+HSU6fptCKzvlFB0VMxywiXced/pQrYgLc4eiApGZssiTyBe8NJsp/er5iA6s+vqrclz9p5MGFnEMjgfP0edtw+BOhy7flC5cc88QXKBhcBkTkv5vnDmxRc4WTVSllvOL/56OnbBWGg1WXjuHIeaIXHY9/chD13F14ZBspigFjBFSLSNBNycSJKGkQ8+DYcVNrBnb5w2adcC8l47F+CJDS8yHad1Pnuv7yKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K16O5we05p9UuONIMMsXCqT9D5j7HOPs1EUjw5cE6I=;
 b=SSqaXEx/pFq0G5xXiFBK99pG5z7Wmp60Ol5h542uXtIF5dFP7hw6DuLKqOymRXLAsfK0KczCdg5AiTCG7vm7IRrK3WhTs9k/jfC2g13fVQyQ8RBM2Cvl446Yr1HBoYP217UjAOviAZny9D+ofJfYCoswtQLe29B5xwCunxblpykZYVZ9qvONydcARjbFb/RnWIM0WdO+c2LLOGL7uz0WyY042eepIoQ7iSCjE7rNzeDYEF5cxPm5PbmskYDR7P/15ngUoQBWejlrRfGMiJsg1zpK0P9xKH/SgCJJwTL1wd5i8hwfGhQNt/Qk4yzPTLtaeMVlOnD1YCaxQY2k+YLfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K16O5we05p9UuONIMMsXCqT9D5j7HOPs1EUjw5cE6I=;
 b=rjWluqCXrnJmEzUzqYCFQ/qizwKZpVWyXZWrk1bHIf+5fm5q0YOsmbo5+O2V1BoBjdc02C8E2mfNrMI0yTX3Uwl9WwR7hy6gSmL32Zec+sO2l1NLfoQKAQEA1lkuJBk4M+g7LaF9zRMpuhYdvW8Wqvv4YWE0h4Bzb8FUZLnZLjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:08:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:08:44 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH iproute2 2/2] tc/taprio: fix JSON output when TCA_TAPRIO_ATTR_ADMIN_SCHED is present
Date: Mon,  7 Aug 2023 19:08:27 +0300
Message-Id: <20230807160827.4087483-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807160827.4087483-1-vladimir.oltean@nxp.com>
References: <20230807160827.4087483-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:205::35)
 To AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c1032a-13c2-4709-b46c-08db976092d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9bZ5xD8p27cjcnVnOs//k+wfHgJ+JkNiI2cgfE/2Nrvdu0y3Ii3boponvPcGD1jE7pL9t8WdfTnMSXp7s8Ve3UQc0/dXXB8Iw7fTfP3gcrRJd0wGbhBfX9c6ur8VEtG43ZxCs5xm0Ln4ayvp2C2wrk3ZPpVJlecz/oaFNkbA57V9D7qBnu230v5FEXziahESFy5rY3VgFW6gEJ+wg1ZGDTibGqMNWjsiG0IoJ5Gaaw5VF+sRf3JuNULvWzyX7U7a+CLPN5KX9Ikg/DOxZITLeK4j0W95oFMh7/Us0c1QbrBy8yND/R0z5AXZF6wTDs6I0dZ77htYppUk6R1L5YzDBFhDH3z4JXuDZqhQCrCUVYJ0RoXWHRr/J+EXuepCR2yDDiHHk9tFMsDqmutDMcsZATIwk/o9cs/Psyn0PNAXlUB6EsRjZFS8/cPogoscDfZis/A9vbse1I11ZnjMQFIuj/+mPIiiWKulcHZe7zk5brTnCueDyihLOBVv9+Zo85pcqNYSobf/t33yDdds5GZVuOOUOoFiaGWb7pd8C3lOm0lOs/kgNobh0qDgSxhc/bT87G/NVvPTahRK5M1POKuXt0MCDNrAYIg2zLkjgGtZo0Qown0U/RqLtoYgdl3wJ/Bb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(186006)(1800799003)(86362001)(44832011)(41300700001)(478600001)(1076003)(6506007)(8676002)(8936002)(26005)(52116002)(38100700002)(38350700002)(6486002)(6666004)(2616005)(5660300002)(83380400001)(2906002)(36756003)(54906003)(316002)(66556008)(66476007)(66946007)(6916009)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YOI0EzHQgfH8KS6ahOgQytA6VlYbdxE1bsGtk30C8ombSFrFwLvMxTSYqEYw?=
 =?us-ascii?Q?go3q6NY4sL6lqiOVN7NxXjbskwb13MGr+3c8FlSLw5pL9QwQcvd0+Vx9Zye+?=
 =?us-ascii?Q?3WhfXRLt3YLvY8Al80C/rBw/kTybEIuqN/w4U2UYmdrU7dTnFr1SzoYUciiZ?=
 =?us-ascii?Q?QSA1GGQ58OAc1oXqUdmG3PEua7d8U+9c9teaIOiPaSWlJskZ2EeqL/kcXrGe?=
 =?us-ascii?Q?CTvMA7N/cQhtvIQv4K8SGIxgr5CKUhpF/KjuC/MoCFps5ZPhDb9SNvvnvHQ3?=
 =?us-ascii?Q?jIgunrjBTogHu8UTWQHG5ilko3lhSAYAkkWKq/W8ILJRiRDqFy8zmLNkWsZJ?=
 =?us-ascii?Q?7GIn8htw43Y1k8b62T7iw4sPGJIDVlJt17QN5l7sTdJq83B2b7nRU3yx+P0h?=
 =?us-ascii?Q?MfGdw0ua9KqrrDQCuPb2vGvBKhfVIK37HDXWxdzNGBxHqZzvR5gL6+8XSlM2?=
 =?us-ascii?Q?h6QRDnwS6/07MPdb2Ri/tKxXi1IhQMZvJwXYkedjPxtwwsYHvaVauqwWHIZa?=
 =?us-ascii?Q?ffDGoJ24vpPB+FwPVWrF6J0CBbopEP+GFpjTqV42Q0XUIpMHlbBNfcMR1HAU?=
 =?us-ascii?Q?KTuVqgFxkefH4r2ZVwWauwrKNPLtZF1N79vtD2f2b57gGndBhm6BaaKaa5m4?=
 =?us-ascii?Q?punbTww8PDixf3e+w/PuNGu+vUdEw655rb7V5IuIcJGzvrVgclwtbjfjjrwG?=
 =?us-ascii?Q?8SV27r6bHtmm6fk3b13OiIu46XeHwnDnOic27AszM3nKwD+M0EDumxni/lQH?=
 =?us-ascii?Q?7jCTFnj0X/HbYl7CkQWszyaS1qOtHl8ekUBqisqX3AldaSAapy6G0uDwcQ8H?=
 =?us-ascii?Q?WZcpLBmiLQrJC+9kCr2X1mRjpxRGG88vGgxcJnG6D+ds6hGXvtfIdOoZH/Nw?=
 =?us-ascii?Q?cWfcNcODuaHEpMuhJScsoCacM5OUPB4DlvCkBIOA3CYTzNMAofcihQyj81iN?=
 =?us-ascii?Q?iN5IqqKQq5Bz3+sWVN5pn/Yw1nmYMMrhAITyqSY0qpliZ25Hq1g6oIsc58ug?=
 =?us-ascii?Q?MRltRr0zwF+n5bSJjgKijZoJs+ZO1oS6mZcaR0jdlQHrM6bpGZ9fUBRhXo+/?=
 =?us-ascii?Q?IussnPTvhvfYIh6sg/9rea81LW7+2evLCgsKtE9A7Xu+izKfkZQ/r0BtHtr7?=
 =?us-ascii?Q?HWFJ4wQuXgTTNY+lFJRlVDm9DHnp94GdfiTUo5w85UYk3OGNXi79eBjZGyhB?=
 =?us-ascii?Q?iNTDRoDndqUXZiXJNq3WmeXyir1O3tVwzszA2E1vTZ0LwqB0/zM8fv8ypZaZ?=
 =?us-ascii?Q?/sok3DCZrrQoqAQ0/4OHYzhruw69T87bOQHl1m7pNrl+IpIwu3gWpJfVKIjN?=
 =?us-ascii?Q?M6WxPvKCulDMZ0GBR1203/oKaQqnG2msnQUkeEZ9FJ8vbg2qTTbKGkfXQAHu?=
 =?us-ascii?Q?QbNYbkI40vHD2g7m+EltbcNiLzbJ1t6hHqI4NjR6YRL7nwnqCieMykp4B0Dc?=
 =?us-ascii?Q?kY9+3EP6RhTpUmNTIASOQpR7WIxc8QxbrJeG57zhv1tSLm4Jznv6kVDpWCG9?=
 =?us-ascii?Q?NSwgKC6SIuV0HfEaaTPeX0/gF7Y1Pokg3K4+lRLuihiPF6VMy7qOLksa6zGa?=
 =?us-ascii?Q?bP4sDiUR6q2zkeI+V9vR+eHyJbqhWtcwCAfhUTLkfLRsh5tAB+NzelraAvll?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c1032a-13c2-4709-b46c-08db976092d7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:08:44.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI5I5ErT9HcoLPBKmw1UrJk8RbVU8ckHO4nUSDb7PiLb15LVaKBw3lZ4TGG70fZti6VZDW/wg/+Z8eM2dHC96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the kernel reports that a configuration change is pending
(and that the schedule is still in the administrative state and
not yet operational), we (tc -j -p qdisc show) produce the following
output:

[ {
        "kind": "taprio",
        "handle": "8001:",
        "root": true,
        "refcnt": 9,
        "options": {
            "tc": 8,
            "map": [ 0,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0 ],
            "queues": [ {
                    "offset": 0,
                    "count": 1
                },{
                    "offset": 1,
                    "count": 1
                },{
                    "offset": 2,
                    "count": 1
                },{
                    "offset": 3,
                    "count": 1
                },{
                    "offset": 4,
                    "count": 1
                },{
                    "offset": 5,
                    "count": 1
                },{
                    "offset": 6,
                    "count": 1
                },{
                    "offset": 7,
                    "count": 1
                } ],
            "clockid": "TAI",
            "base_time": 0,
            "cycle_time": 20000000,
            "cycle_time_extension": 0,
            "schedule": [ {
                    "index": 0,
                    "cmd": "S",
                    "gatemask": "0xff",
                    "interval": 20000000
                } ],{
                "base_time": 1691160103110424418,
                "cycle_time": 20000000,
                "cycle_time_extension": 0,
                "schedule": [ {
                        "index": 0,
                        "cmd": "S",
                        "gatemask": "0xff",
                        "interval": 20000000
                    } ]
            },
            "max-sdu": [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ],
            "fp": [ "E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E" ]
        }
    } ]

which is invalid json, because the second group of "base_time",
"cycle_time", etc etc is placed in an unlabeled sub-object. If we pipe
it into jq, it complains:

parse error: Objects must consist of key:value pairs at line 53, column 14

Since it represents the administrative schedule, give this unnamed JSON
object the "admin" name. We now print valid JSON which looks like this:

[ {
        "kind": "taprio",
        "handle": "8001:",
        "root": true,
        "refcnt": 9,
        "options": {
            "tc": 8,
            "map": [ 0,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0 ],
            "queues": [ {
                    "offset": 0,
                    "count": 1
                },{
                    "offset": 1,
                    "count": 1
                },{
                    "offset": 2,
                    "count": 1
                },{
                    "offset": 3,
                    "count": 1
                },{
                    "offset": 4,
                    "count": 1
                },{
                    "offset": 5,
                    "count": 1
                },{
                    "offset": 6,
                    "count": 1
                },{
                    "offset": 7,
                    "count": 1
                } ],
            "clockid": "TAI",
            "base_time": 0,
            "cycle_time": 20000000,
            "cycle_time_extension": 0,
            "schedule": [ {
                    "index": 0,
                    "cmd": "S",
                    "gatemask": "0xff",
                    "interval": 20000000
                } ],
            "admin": {
                "base_time": 1691160511783528178,
                "cycle_time": 20000000,
                "cycle_time_extension": 0,
                "schedule": [ {
                        "index": 0,
                        "cmd": "S",
                        "gatemask": "0xff",
                        "interval": 20000000
                    } ]
            },
            "max-sdu": [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ],
            "fp": [ "E","E","E","E","E","E","E","E","E","E","E","E","E","E","E","E" ]
        }
    } ]

Fixes: 602fae856d80 ("taprio: Add support for changing schedules")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tc/q_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index 795c013c1c2a..16a4992d70d2 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -650,7 +650,7 @@ static int taprio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 		parse_rtattr_nested(t, TCA_TAPRIO_ATTR_MAX,
 				    tb[TCA_TAPRIO_ATTR_ADMIN_SCHED]);
 
-		open_json_object(NULL);
+		open_json_object("admin");
 
 		print_schedule(f, t);
 
-- 
2.34.1


