Return-Path: <netdev+bounces-59614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA69481B81E
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7711C2095F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EF3128143;
	Thu, 21 Dec 2023 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F1qr9lki"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F9127218
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqmAQnL+2YpDoL96XwVlifg7D0am5sPo65yqSYkvO7zrZd4ugQMXwBBtd2+e42qDYEiZW+XcHFOQoHv1UgWZktcFK/3rm67q1FuhuuFaUXK1pabtkUtreN6yxTvkpJoMJ63aZAGQCqVSvhTEQq2dJApxFdNBt01I0xl067PxYeMsd2udP53L07FcTRpN/aHwRNR/EUR401sU5ewxbIEGMJmt1zoOfzIG+l8LuTcuaq0wk4h6TooVCsqK0uYueJW4u9zxVM1aPZjvRrXwbvGZRzInJeQdPy0V72YTJc1C97ts/ro+ROChkhwJFwS2MLETvUXcl5N8BIoi9O3e6YNCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+dV01M2w6MbyIfe+zIOWHxUTbxxhRZmMXmuoNAQgbA=;
 b=eYQ12BLYoSEbrcgYiTENAcguUvftk3qG6Kk8jkZbfXH2V0zIQ5U7opw+OoNrI4ACj+pksCIIHONzN8Fw88QXxrDbnJ0e0qY5ictKYIwToLB/fjPhdcF8uBL7W19WVdmHHPha465UkkZ9MFqgOHWSCRclfG443pGusj7fyStMGHbD3fQhPJT3WjfZgaQaUq0KH8vspBoWrgmCsILqTibb+bs1B+yo7mGcTGvlZS4Vu0WmXtjRArAdYhSfY70wzERT0FYnsN1H0lyhid3H/RKEt5kOMbroHfc2Cc+8cUlpWvQzeagGJ/iRifT5qSsUvhFHVrwTF40o2wOvAKk6P3dTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+dV01M2w6MbyIfe+zIOWHxUTbxxhRZmMXmuoNAQgbA=;
 b=F1qr9lki7BQpKa0bB+2pDDl8z+ZYrWT6EL3xO+ERFlVEMzAf8c9CigrZdZVjeT83kiZsLqhrcxh7W0b3zHGmAV+pbxCftieLGbM2U0Gop7kmPtATrp5rhYjjE7dxhKBFYCiyPEsdVErBf0LKWhL6Tm++zp9GUTogL6teTexZp6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 13:25:42 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 13:25:42 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Subject: [RFC PATCH for-faizal 2/4] selftests: net: tsn: push --txtime out of isochron_do()
Date: Thu, 21 Dec 2023 15:25:19 +0200
Message-Id: <20231221132521.2314811-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
References: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e8fc9d-08e8-4bd6-b074-08dc022854a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TNJpfnD3Kf4wghUoNyhsmiN7XaBfx2EWvXzP3tjHbBSo+YGGeAlcTVVxJGbatskbK0NsbdH+e+OR9nqNfOQEiS6UsXCaQGOQTp7ahFZ1sO3pgX6XC9XxvNHEDTTL52PXJ/OjjSr6u4z3AIZ9Iey1zyfPuXoLosoYH9RZKD+rfFff2GRkojpbZMW6qSf8+fJRxExvmgsKiucXJqVM4SNiWFeZ2f/86baPMlI/Gfmeag5W1X3B88BO0FMtSONqOdmWFM7OKerpCNKvAJQIon4XHymA3tWQh9Mi5k/ZOCNzXG/Fp5aZGCMLIyFtflDdPSSKZKD41LXoeIz3nzN0lB0eGh4d3YwGbXksOZKcgh6tIzhqlYQD5ku6uPl6jdIL3JMSdnlgCPWHz97huKNBgbI5h4zYswYFeM+Kz+gbaS8rlJg7x6TafhppgzzTdAecD7DyQD5bDPj/nH2gQRUUmlklhBLuyOKdOlFtmQLCAX5c+Or9bENP06ksqqoJXcZTIibWjZYGpAuMhVcVu3wSdcBLDUGQLxMgq0kJ8MrGEaWqVIDdVBZlPx15HeDSvrK6lppOAOkhaFQvo8R+9RBOTaoYVgCoFpmEP6zeHDmV+4GlrnwLO7Od9TfBSArN2evcQQuT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(6512007)(86362001)(6506007)(52116002)(1076003)(6666004)(26005)(478600001)(66556008)(6916009)(316002)(66946007)(44832011)(66476007)(83380400001)(6486002)(38100700002)(8936002)(8676002)(4326008)(38350700005)(5660300002)(2906002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mjMMpzBzHksuTEtU9fXzYW0GtddndVFA1goriE1EJzV82NZLDD0RLjjomAek?=
 =?us-ascii?Q?2yuQ2p/1OSZ5ooC1Q3c0NAAQVGynES4fRm1zCgodB9CJDfBcz3jTX/YxOeoL?=
 =?us-ascii?Q?RskvZarkWOeDLWs8e5kRqBVz6jSfjk43T+SR5HH01+gIyPxQKYdqH4enceNG?=
 =?us-ascii?Q?UyiHqGkbBZw+jvZDSapnaILW1Qte2vcNuQVIjoEH0uO3ImbAqJ0lJAVsbDtX?=
 =?us-ascii?Q?Xw0db2j3N06WUHZdOFVnUNkLvksxiJm3z/gbCWtN0Zznrqi1dyabViuSY8yn?=
 =?us-ascii?Q?C+TgqtX/duVQpYRG9dtVWAe6b+23c9gvQz8023BHb7SEEE0Qge9oDKc8oGEY?=
 =?us-ascii?Q?y8uDqPd6A915rq/yArV3HjYS9WJglAm4eFfwpBIepPlVbdY5T9+jBPZeGMQW?=
 =?us-ascii?Q?D9MMJ42JAj+VxqGBWalaUTxcG/AfwLjZmVpM/xYiCYUUIXN7q+EQrmtYy13q?=
 =?us-ascii?Q?rtZzsqBH5bcJTf0yePBuRAvpWkRX7BCGdsSfnrbPdzcY1G5kzk5CGpoCj0Jr?=
 =?us-ascii?Q?vVaYB4oHRN9G3gaF7MeMicUROqXriER6ClLLeuEN5yd7a0YwCq9H8NdOzZ6G?=
 =?us-ascii?Q?gksYt0i3+MfJFCkmdnJVh74PmCsMncROWcdMC0Oc0HgFbcfZnilMU7MHVSe1?=
 =?us-ascii?Q?b0Tc+IoGvSX4YL66iiOnJx4NTCPztDQz+4M0OSvEts0RYDbfBi0bVn0oHQH0?=
 =?us-ascii?Q?N8h+XJYreKVgmgFRQInD+/31s6YW0c4rGnY7ufGAzzp7G6elESFas9x6Eqe3?=
 =?us-ascii?Q?dCKG7oidFgEYRU7s0oSX+aQfRKs/2jBKI6rqKop00X9qKVQi3oL++5PgKkjH?=
 =?us-ascii?Q?Eprq8L4L2ViTDJtSbczIHC17VscYluXUGiQa915PCMtxaZQwWyDYzscyzSgZ?=
 =?us-ascii?Q?tHSzngBP26wWW+GkkOfhXIL18x2o5txI10qmWAhJRUSY76pzdrU+9pBANumL?=
 =?us-ascii?Q?bamzY0D5ZuDsOLiWM0VYijvTwjZdPe7pVohVfngk/rmGxAB2Wfma6AcD4V1i?=
 =?us-ascii?Q?Qg+jS8+T2crY0R8MMFqnXvSYTpJqt0rbi6RXVUICrfAtg94nc5XTABiD1irY?=
 =?us-ascii?Q?qGkMJNwXHWVOFt/XkKCOcanBYLXNtvd0m2BtDAATIxpQ2KqXIyuMGUiw3AV6?=
 =?us-ascii?Q?8Lz1yvHE2ed3CGC8c2bNwjwY8QDKbJwyPIpJSYl0a52lYlT1Jr0Z46SVzzEl?=
 =?us-ascii?Q?TTa7joFZQEcu97V16V06Ioc42ZCJiZrNt6QGn2jyJa2yDPDe1b0MBDcK3H5T?=
 =?us-ascii?Q?t+PFRU6SY7dt1IcVkRE+elPkLnkfuXT0GC8dASghx2im+t45sg/opVUWM85b?=
 =?us-ascii?Q?YY8Cn29+MlU98oo0TZKcYq0trVFiG0VXNKnS4zDWdYMZbSyx0e1IKmxwONjt?=
 =?us-ascii?Q?x0iOlBrtgcIdht4tu5Iit+OYhkGRVZEDDF+d2XyTGLqWhSUIa2LwXbcN+tHr?=
 =?us-ascii?Q?cDgh6qzyKBS7IVBJxLktEUlj9dd2P18KJXZDzliUPRm37j8kQ5pGFAiIjk3J?=
 =?us-ascii?Q?bAAyKcNNkGRL/OCtJACiuLir16aPK4OKGeEi8+rYWUYECL5qCNc46V/L2m4z?=
 =?us-ascii?Q?lbXPmLVHgBbL/VvPWv4is+/+QzEXHkZqRgxQRqpvo7XCfDIxK0rKgIO34xY+?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e8fc9d-08e8-4bd6-b074-08dc022854a0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:25:42.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMuPFvFJxbGSNITJaqWuzeJC0NYgBDY+Ud97WjJIxGxJ9Ze1PZKWuT7xBWtP09ngRJt9j2PAw7c7KQORF1cPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058

Not all isochron tests should use the --txtime option. Make the
sender_extra_args and receiver_extra_args be provided by the caller, and
move --txtime to the ocelot psfp.sh test.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../selftests/drivers/net/ocelot/psfp.sh      |  1 +
 .../selftests/net/forwarding/tsn_lib.sh       | 21 +++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ocelot/psfp.sh b/tools/testing/selftests/drivers/net/ocelot/psfp.sh
index bed748dde4b0..e6042b678c09 100755
--- a/tools/testing/selftests/drivers/net/ocelot/psfp.sh
+++ b/tools/testing/selftests/drivers/net/ocelot/psfp.sh
@@ -270,6 +270,7 @@ run_test()
 		"${STREAM_VID}" \
 		"${STREAM_PRIO}" \
 		"" \
+		"--txtime" "" \
 		"${isochron_dat}"
 
 	# Count all received packets by looking at the non-zero RX timestamps
diff --git a/tools/testing/selftests/net/forwarding/tsn_lib.sh b/tools/testing/selftests/net/forwarding/tsn_lib.sh
index b91bcd8008a9..f081cebb1c65 100644
--- a/tools/testing/selftests/net/forwarding/tsn_lib.sh
+++ b/tools/testing/selftests/net/forwarding/tsn_lib.sh
@@ -186,9 +186,9 @@ isochron_do()
 	local vid=$1; shift
 	local priority=$1; shift
 	local dst_ip=$1; shift
+	local sender_extra_args="$1"; shift
+	local receiver_extra_args="$1"; shift
 	local isochron_dat=$1; shift
-	local extra_args=""
-	local receiver_extra_args=""
 	local vrf="$(master_name_get ${sender_if_name})"
 	local use_l2="true"
 
@@ -205,19 +205,19 @@ isochron_do()
 	fi
 
 	if [ -z "${receiver_uds}" ]; then
-		extra_args="${extra_args} --omit-remote-sync"
+		sender_extra_args="${sender_extra_args} --omit-remote-sync"
 	fi
 
 	if ! [ -z "${shift_time}" ]; then
-		extra_args="${extra_args} --shift-time=${shift_time}"
+		sender_extra_args="${sender_extra_args} --shift-time=${shift_time}"
 	fi
 
 	if [ "${use_l2}" = "true" ]; then
-		extra_args="${extra_args} --l2 --etype=0xdead ${vid}"
-		receiver_extra_args="--l2 --etype=0xdead"
+		sender_extra_args="${sender_extra_args} --l2 --etype=0xdead ${vid}"
+		receiver_extra_args="${receiver_extra_args} --l2 --etype=0xdead"
 	else
-		extra_args="${extra_args} --l4 --ip-destination=${dst_ip}"
-		receiver_extra_args="--l4"
+		sender_extra_args="${sender_extra_args} --l4 --ip-destination=${dst_ip}"
+		receiver_extra_args="${receiver_extra_args} --l4"
 	fi
 
 	cpufreq_max ${ISOCHRON_CPU}
@@ -232,7 +232,6 @@ isochron_do()
 		--cycle-time ${cycle_time} \
 		--num-frames ${num_pkts} \
 		--frame-size 64 \
-		--txtime \
 		--utc-tai-offset ${UTC_TAI_OFFSET} \
 		--cpu-mask $((1 << ${ISOCHRON_CPU})) \
 		--sched-fifo \
@@ -240,8 +239,8 @@ isochron_do()
 		--client 127.0.0.1 \
 		--sync-threshold 5000 \
 		--output-file ${isochron_dat} \
-		${extra_args} \
-		--quiet
+		--quiet \
+		${sender_extra_args}
 
 	isochron_recv_stop 5000
 
-- 
2.34.1


