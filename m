Return-Path: <netdev+bounces-23610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26E676CB4B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A485D281CCD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DF63D7;
	Wed,  2 Aug 2023 10:52:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BE6D38
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:52:50 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186B1729
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgdCrkNkSSXGW8HxEUoWxhJ9CYaHxeq3QALn/GadeT6cZLLF8p+9h9l2jY/GDI6bibX7r4sCaLSyGhvNi/Z3AQkLK/e9/VXpeaxhy3AS8YLwa3Q0t0H47ithiAigHVQhyIiCpeZ9E5Vxya66Q4qUdqxwKQnISFwKofazCi0n92UXJrBQhtubhS+l6lOzYWjbut4tj0KMZSPNr8ZIaw7wi0kOB8H/TM60lJ7Hob0GA+pX6wXZJS0zH+a+uyHDCoy9hq0TpBsWOmtr5gz2PcqzfZv1Y7ZGKPsBO6GghYtsuaMvYBWEFt7iG2201HnsEDvUyjWJkI/V4PY9w4Y+qX4vZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b53/BlCyj7+/bb7uI+RwXV0so1tsukojNDg3fllRTJU=;
 b=XHpiJT6LeG1L8KH4ea5xArF7aD8AQeIDqIO1kJwxgn1MLgbVhAkUzMWxgp47Dh6TGJml7XJZMfgG1NLqqTeGCWySwE7R4S4QzjmmBmu2AMH+0+epqcqzLSjzbbXak57iXx07XSyMS3YdYaleRScliONyB7vLkJ+bidgLXJZNYQUxOHu0jZ6rDIstkYV3fexopApN6QMkDUnFs8VNS0TYwWEKuG2OSsmYaooAK4rqRYJUbFU6msRtnKeYCe0Al66hVBR10fJdAefriDGQfRzbFSUqvf6FGxPGRG6MF6IePrtF/XkB2f0UNDMKGjbKJiQivX6jIEjeEZzH+um5xORpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b53/BlCyj7+/bb7uI+RwXV0so1tsukojNDg3fllRTJU=;
 b=X7cJ2M/F5kpEJesUjZBZaVgc3bbgrRlEhNQMs5gzHwxol3DA3ya02aQk3C6oKZsx/ohjf4qvBX0yck+hI0Ox6rrYoY/o0BmlVBr9Im9tdbPV/vt+7xLOm37xbRLpJpRtzX/3D2F2MBWinx2J9ce+/4w7iA+evnBwn67aAFQfvwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9723.eurprd04.prod.outlook.com (2603:10a6:10:4ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 10:52:46 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 10:52:46 +0000
Date: Wed, 2 Aug 2023 13:52:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
	razor@blackwall.org, mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net 10/17] selftests: forwarding: ethtool_mm: Skip when
 using veth pairs
Message-ID: <20230802105243.nqwugrz5aof5fbbk@skbuf>
References: <20230802075118.409395-1-idosch@nvidia.com>
 <20230802075118.409395-11-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802075118.409395-11-idosch@nvidia.com>
X-ClientProxiedBy: VI1PR0902CA0030.eurprd09.prod.outlook.com
 (2603:10a6:802:1::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d2e36c-07d0-424a-7ff9-08db93469b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+fSp+ZfoCDwF1Dw59HZUBAwwZJO8ZY2d7vd93KBH2fF8O+idCSfLcxAdYk1ZHTVNaeyCydsNYmXOYiKHhFChV90mZU2aZnB3vl5rmENMAY3k4/d9wX2u5ccVKxGWkkkFbe9sPrap2mCrwSUsTK9eHHuqyXzrn9rWS4aOhIg3dMo0X7EqCwoIoJAkgHDtzURTgLb1qKn4RfLRTXJpM0vgw8SjYUaWqKgN27PRRUVPqcf7lRRTucCOTRXZrWCHu65BbSsd5vg4GtRLtIM0zMPXpUy1LvEZUtb+PIoO/41ZFS+zegJG/kMsA5usRDXsM29YcR4w/I61slsqGlVTolvPUgBDfWw255sOD/owGQ20oddrUusNrUHjXPFE9g+YXR76gRXF8XfO0wmgsYLjftSvZkZb/5w6W3TzKwKhnCeiI4SLYPmvI7IYFNaRFdHIoVguu9/wRjEhLZnBkx6DESFkoysElAdjC2PsMia98qqBMX3LNtxpRPKKS3iR9e6r1Hsy8ZccRqqMG3eNwGiOG7CosyErV1+g4KA26xOiLUaJ07A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6506007)(1076003)(38100700002)(26005)(186003)(83380400001)(9686003)(2906002)(5660300002)(8676002)(44832011)(478600001)(8936002)(6666004)(6512007)(966005)(86362001)(6486002)(41300700001)(316002)(33716001)(66476007)(66556008)(4326008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J7+LAYZJWncg5xsLKJCkjvl2Jobb/Q8tKDXC8iZ4PfV/xEKeSeqK/qvOYTmk?=
 =?us-ascii?Q?c59xuUXH3Cez3hc5KZrhXgX7H6FzH4qzWPCB/AmKWPFwy2RPFSB3+WswWwcH?=
 =?us-ascii?Q?C/+KQQzh4kDyMWs6JnW0i67eyQKSHLprjTB5NyFWZxlnHiu0x+BzR9Morxj/?=
 =?us-ascii?Q?odYIXvVukVQ1djtJwm+zaByJ+8+51oZw0jkNmsiz2ovdTSNZJhCVW6leV+st?=
 =?us-ascii?Q?ly7XpyyoIIsKpO5BQwHlyWT/LCu53M9P7FBYu2CFSYu378umaUzdqH30cpPF?=
 =?us-ascii?Q?NPPgIQ6JxfVE500ArZxBDLoNz6Jjx1Suy7RVIpsJv3Ex8UNJWJErzvL7N2zg?=
 =?us-ascii?Q?TMmhdLu9zWr+KnBnlrtOMeCdBQt89gps07PT9BbzDucy4iZI5srEBQDd2h5V?=
 =?us-ascii?Q?sGUoB2Qu6+bVbjK9I4dI5i2FHOI0/8nn0qFoBiDXfeqJaVnyQC+kQI8kLvIs?=
 =?us-ascii?Q?1afYQaV3FoSMkTV/iG2PPQJg6R2j7IcWFbSjKiSZj7sRj1UktwkKk0te8CyU?=
 =?us-ascii?Q?KKxG815wYFbbb989xBkPNT/XtJ528bzrl3P33ZlF7ZPi3+I92aC00myUgExK?=
 =?us-ascii?Q?wxOUvR6XNMbKYSl/GLcvsQcuMCmhuyPgO6wDKGnlkdyIHkVHntdviXqo1lv3?=
 =?us-ascii?Q?AXwYWpQWJ9sZxXgBnmO0Pk/V3wvSl1fKAZ+5m3ThJewzW2yvKpAH04T3jhmh?=
 =?us-ascii?Q?hgCIBCvaMV2xTC9AM7S8ISjhQywoUUEqShgloPJ/SAc3zWAzO464QIYrOMaj?=
 =?us-ascii?Q?R++XMPAP7IstgACXvdhSn+R0NnSmRPCQshRN3dc1PwNvULPVT7BMfz3SdKf2?=
 =?us-ascii?Q?pXBhPgCDYt8jjLpTukzHha/OanMQ7rhz050mDcKhWkIRk/hgzhv2gNDNxqxg?=
 =?us-ascii?Q?odU9ti8VNb/4jpg222PpvD9eF54tXly34DLW9rMZaEwC2QuhxzLTz0Q/b58a?=
 =?us-ascii?Q?2G3sc1IjTdbZgrrx6JZksN+UTdjKoPxDtrcLEqtG3AyT5r3ASFzjlKZR4NCE?=
 =?us-ascii?Q?KyYfFzHxvvbz3tUw+2STCS8oWz5nM/KlO+t3bsJ/E90J13dn8zdYWpVsR0qa?=
 =?us-ascii?Q?BMxWJNT0lNCxXnBcsIGeQdoTJeq4M+sIwd5lxA8OEqFDO6NtsoXqu/Sw4Jbi?=
 =?us-ascii?Q?zhX3PX6EbR4Wc89O5X2cK5fxjwsU7L5KsTaxVfjtrdV9utqGMH25zolqJdAa?=
 =?us-ascii?Q?PGh3mbLMh0kTxmzkY1fm86m/Kg2X1kUUprhLs/WujFK+Pkd9tiuZ61+nmaS3?=
 =?us-ascii?Q?YZsQ1Qc9SlLp25AmtiuUVZwnV7mH3/TU4N81ohTfbyUR1ms8QoRa+3oTG2r9?=
 =?us-ascii?Q?1a7ZqoTj2dhxeJUKtA+TIXluuVWJmaOsW9OZpIRuCuTEoNshPJB/CQi64knQ?=
 =?us-ascii?Q?Ps/JnxTo3KQnM9EYRiqHc+RU+6fjnTGShs2JHWDovoRkxalO6U8s2g0PQT1M?=
 =?us-ascii?Q?GnUPNrWZDZE+y5BXuwCn08ZhamWwlsm2mZjoGab/lh56IytJ+IbeiYzNQNvk?=
 =?us-ascii?Q?y0Si+kVaxCu5mO3/BU8N+RENW+9h+PJWl+hwS/2TkpjawrBw5h0mUs7TscS7?=
 =?us-ascii?Q?fOqVNImwea1CU+W+wBkRugLcXB03nBaglPIo7h0PUzXh+H3seZD9XHgdZIl1?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d2e36c-07d0-424a-7ff9-08db93469b25
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 10:52:46.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cchrlmMHBEaR/8AR7MsCqE5+uVAFh2wj+7e1d2ha7EalhWmMSSPW8UAeme9+5t3tRTwa/EoMwhSikLOKpH/Nlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9723
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ido,

On Wed, Aug 02, 2023 at 10:51:11AM +0300, Ido Schimmel wrote:
> MAC Merge cannot be tested with veth pairs, resulting in failures:
> 
>  # ./ethtool_mm.sh
>  [...]
>  TEST: Manual configuration with verification: swp1 to swp2          [FAIL]
>          Verification did not succeed
> 
> Fix by skipping the test when used with veth pairs.
> 
> Fixes: e6991384ace5 ("selftests: forwarding: add a test for MAC Merge layer")
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---

That will skip the selftest just for veth pairs. This will skip it for
any device that doesn't support the MAC Merge layer:

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index c580ad623848..5432848a3c59 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -224,6 +224,8 @@ h1_create()
 		hw 1

 	ethtool --set-mm $h1 pmac-enabled on tx-enabled off verify-enabled off
+
+	h1_created=yes
 }

 h2_create()
@@ -236,10 +238,16 @@ h2_create()
 		queues 1@0 1@1 1@2 1@3 \
 		fp P E E E \
 		hw 1
+
+	h2_created=yes
 }

 h1_destroy()
 {
+	if ! [[ $h1_created = yes ]]; then
+		return
+	fi
+
 	ethtool --set-mm $h1 pmac-enabled off tx-enabled off verify-enabled off

 	tc qdisc del dev $h1 root
@@ -249,6 +257,10 @@ h1_destroy()

 h2_destroy()
 {
+	if ! [[ $h2_created = yes ]]; then
+		return
+	fi
+
 	tc qdisc del dev $h2 root

 	ethtool --set-mm $h2 pmac-enabled off tx-enabled off verify-enabled off
@@ -266,6 +278,14 @@ setup_prepare()
 	h1=${NETIFS[p1]}
 	h2=${NETIFS[p2]}

+	for netif in ${NETIFS[@]}; do
+		ethtool --show-mm $netif 2>&1 &> /dev/null
+		if [[ $? -ne 0 ]]; then
+			echo "SKIP: $netif does not support MAC Merge"
+			exit $ksft_skip
+		fi
+	done
+
 	h1_create
 	h2_create
 }
--
2.34.1

I assume that both situations are equally problematic, and not just veth?

