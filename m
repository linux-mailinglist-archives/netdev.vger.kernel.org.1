Return-Path: <netdev+bounces-25178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD617732DB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEF71C20AF4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225C17AAA;
	Mon,  7 Aug 2023 22:15:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B313AE6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 22:15:19 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14771B1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 15:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctbgL/adJAS/1OolwKFEVceTnnsuJoc6/YaOZ5T2LVxhNFGi3HXwot6JavzSoxhlJygwZTB1KbNlnJDZ5tElwubA+YdnIw53oR64Zny12UZzD2GuFZRmksQpQ+9ClioJU0rqHU0qKvN/DGtwv+rxAnjR12pHDDEHCj+UG3I1Dc4B/QgTvYCXUiH2uRlrMrlqXWshtNpgUL2L8P3pcCh/f1Cu2ro+b7kcSFoQ1h2yj4h3fwfrnUg0Ayd1quK1s2EExPpPRci4fRrydVzwiS2Bws53hGUOrkawxinzoh8U5NqCxSQ73OSvH+XJLToXo9jLPGaWw/sc/7bS21PFx6EDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez7iTS9zJLdBrhJvk76pKbB56xg6+2bJRYU04SJyYak=;
 b=DKNWjnK34cp/zUFMEjMNn06CMMqBMXYkErReRmpv8KBGfQA2Iz/ks0UWkVDlcVLxI8NwF/mpNmFD/2cIvZ7iXq7Tp/9E6FLdMeDaTleLNWxcYrt+5B/320iwYudIbDrn5uxhtMac1bUacUXzhZ7YJH6ZehKeA8jnSP7uX13ZIDYEJ0ksmCTpQP3LqVlltvQ0aPgXSJ/brJImejNnwy01wI2l6NY10buzslTmXL1pfO7/E4HPShh99St7WaTYfkwjy65nnRopgnKo+BfG121p1Rl6TJON3SbdDTE8LtCB/8UX4se+jCTohIBL7XbTr+WNA6R4SrTzzNFjx5pM4k6qnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez7iTS9zJLdBrhJvk76pKbB56xg6+2bJRYU04SJyYak=;
 b=X7Fgk5yhGKB9ZvlnaNQ+V7634SGcs9I4Jqsi/2wXT8rQCGgVE8CNAfnV0L+YaNZZ2MeKTDg2XHCwYYFrtyI0FHWylzci5ysIItaqejYJ3002Eg0/4eU1GiwQGWOHHp12yPwC+yoiqvsHx3PbYwv8K1xZcmuivyy2fszh0GRTH+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 22:09:48 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 22:09:47 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 iproute2 2/2] tc/taprio: fix JSON output when TCA_TAPRIO_ATTR_ADMIN_SCHED is present
Date: Tue,  8 Aug 2023 01:09:36 +0300
Message-Id: <20230807220936.4164355-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807220936.4164355-1-vladimir.oltean@nxp.com>
References: <20230807220936.4164355-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6b32b9-29d8-415f-ea5d-08db9793037d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tvT1BG0BikA98GkUSE9d9K9KYpFaNqHyWo0EnbkaXs29/UcjZfvZZW/tk5lYI2HsCUREc2NVzAx8DSWcu+bC44bNtb2mgYfzY9qi103dNv4Z8ZjFU8f2O5vcfv5fYIQQ+uiqVojYmp+UkbFkno0IrU3S/WXCbMmeyMDAVNoyI3l1eQg75z5qUuT9oRSpnd22HAsyV6lFsIMAhp5TrNwDERh+i4Wl5qi01qIT7Kx3DqwesPGfsKpVLaRadOx/M61KfSaAtlnNXh+GkLSUb6YLU4BMywRDN7eSdkMNkWZ1OhuaPLWijL4QCMacVTvajJmtULJthW7iaSMafaNy+utA4Cb7KqNWIB7RZBXXttB/emaYFkCw7UgaUA3RsGESsS1cYQZI2NsFRglnvKit3yFuNB0jD3/WgtpAhiowJzqdC3FvI3OTZYvoDeU/Pkk+M/g1dmKfZu7Vq+BreMf/+s67Ns6ajTT3lrloISrxUal3ZmSfbPMdPeKgjhfv3JMCy39tC0xr5amTSw/A90NENccGQjFBRzKFyyVJxsticbPWtGtVMzw56d3n/DcMIWUaEX3LXHpVAENsaj8T9VbuturhE4hI/hMPWs8NYoMyp1pu0bJsO29jKkC0VGtKCWMJ70zz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(44832011)(83380400001)(5660300002)(8936002)(8676002)(2616005)(478600001)(6916009)(86362001)(6506007)(316002)(38350700002)(38100700002)(54906003)(6486002)(66476007)(66556008)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLioN+5qQYzLfcMPxAV0w6NKy3IgVjuVAIU/wfGV4u6Ftl5QVDTQkP1SpVbh?=
 =?us-ascii?Q?20VCSWi0HklhuK1qGuNDbNPTZxCXZ98GFLT5OTA7vtsD91vJWWD3Zy7XEmwC?=
 =?us-ascii?Q?RqBDzjeFsuly5lwxRmXXfJCEZg9jG8vciFsOfJxroiG8j91+VBhP7Y5HzTUR?=
 =?us-ascii?Q?Iv28eo6VXaVOGYIIb4iRUnQllLlgCY0rCnm0QGIt2ckmGyUGe0m3+TZhJXyk?=
 =?us-ascii?Q?ocE73sANFU1z9GnGp0GgnBM5GOSPJlh0F3XrXsxQd9kp+jIVHT0U+pINx1A5?=
 =?us-ascii?Q?DdtT101lhttKxyQJsEsdOc8PVYHFznu++cB/0I1mfMXUnU0dMze7utGitqVH?=
 =?us-ascii?Q?TSFwshMS+GQ2hLwZoGVVtYZp6DQ0nTviFf4DkqUA8HS2TyN+L/bUhepkVu48?=
 =?us-ascii?Q?VOEnZ/+ENX9U0yTFI8TA6qAes3ZtuLeBn9N1NQwmmypqWbnPGzMXnwx6E8yT?=
 =?us-ascii?Q?eS8HWh0TS0gh0bB2ayBIrTUO/X9Ib3gt9z4LJ9Z3F00276IvNW2FwQv0mmub?=
 =?us-ascii?Q?O8Jmws+Bk7ZR/iIFtj2/ljgkJ0WmLkbFy/krMuOT2o0Wcu0wL4E+zJyXLoU3?=
 =?us-ascii?Q?hXFgfB10hj7H4PhdqZuE3n93WgxrHl24KcLzaXaPWj+5zvleLDLch3EmVFYJ?=
 =?us-ascii?Q?oORGMf97wBvuoOtzlkWE7TC2bU8itsDSn/cyxRwFUwutgO9sNJqP2OGd575J?=
 =?us-ascii?Q?8V5NVW/TmnIPunnvMr59rG4OvnonYqVEW5GMwftWTpyeYOqsIyR7vcPmHIj4?=
 =?us-ascii?Q?yBaX/DPShrq5OqIrqmPif0+hYkJb/8xt1M7y2JeODf3NnfW/u0bbYS0vbp/s?=
 =?us-ascii?Q?CjX4jvdB+e1xPjAKg2p/UuVeyoLtoK+2Vo3otquhe+reN14K48H0X2FFZ27B?=
 =?us-ascii?Q?xj2XZYsbWTmfOvB80PjcYV/pWrsX2vQ1mhab8vq5M+PBlFn3P/EXV3J4gyuO?=
 =?us-ascii?Q?RXABnpgJ+7dkR6Ma3x4CuJuHSQ1Rk+eY+eqgPJ0w/30fTksroeonqUcfh/5t?=
 =?us-ascii?Q?pz58BsOR4J4CxeycG7ivNUeaQ3g1i4tHVD2iL88THn6LkF2O31LPXlhPU0QE?=
 =?us-ascii?Q?1IRbd/jucJ3wKf8HtMn3sjPM4o3rC2LIiBDu6emRABPt+S33OTjGh/zR7oek?=
 =?us-ascii?Q?hQOi5SLx03ycN05Q2oLN6OuBc9hYxKpgCaNk4vZ5tPo5ShvEHvGcrgn527Va?=
 =?us-ascii?Q?ut6htvp2868kANlFmeohtw+LJeaweR8FL4u3vNZ6dJhbC0rQFvs2K3sfxMn5?=
 =?us-ascii?Q?LeEGuVPfqWLuAQLEMD1xE85xrczTaNjh3+GwsG0r5rdzYHHHXVSiwcT0TATV?=
 =?us-ascii?Q?XtiLxHqtq50oPw9AoatT3XcADDm3GHWxxxseeeAe+vXteaiD7aLK3RoKxgu2?=
 =?us-ascii?Q?ADBd7z4ho7BomYWVAMyS9gzglC5M9R6UQRM27PuJP2QY7BXI1QI4fAgMix9E?=
 =?us-ascii?Q?g1zzE63W7/5ne0J/rh6tA7NIklEqQlfouvRnKi+aUPbEyRWceHtD25vG89xX?=
 =?us-ascii?Q?spnLG6/EQC+SXwPuBHsLbAIBshL1UT5xbn67mw4y/xZm8NDNtvC3339gSWSg?=
 =?us-ascii?Q?6v00qH6C595hHB7OCbVWc1H5DngY3oBaWGoQrU9zlnh0KWbccd0ydWopRS0a?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6b32b9-29d8-415f-ea5d-08db9793037d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:09:47.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67EtI1RqYUiNzjwK8TOOMHI9PzvywE96BjWyUUm7nUSES4T2mV4EHufRe3vKd8tftrWje3FmqopXSQQvgVZQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963
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
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
v1->v2: none

 tc/q_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index 6250871fb5f2..ef8fc7a05fc2 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -654,7 +654,7 @@ static int taprio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 		parse_rtattr_nested(t, TCA_TAPRIO_ATTR_MAX,
 				    tb[TCA_TAPRIO_ATTR_ADMIN_SCHED]);
 
-		open_json_object(NULL);
+		open_json_object("admin");
 
 		print_schedule(f, t);
 
-- 
2.34.1


