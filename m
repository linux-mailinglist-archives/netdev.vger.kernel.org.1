Return-Path: <netdev+bounces-267086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAhvK/zLsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A942733BC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16539319E790
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3A364EBF;
	Thu, 12 Mar 2026 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ey5odMIY"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02D347BDB;
	Thu, 12 Mar 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325124; cv=fail; b=a6Xa25IS1pkU07xvxC3GX6WRZUto4KHavy5pgYeO6b0ZkevxjDosRqjgdUBv1jTfx1b8yjK/LZRWPcz3nrcp0qV3vxErQrIXwuJHvN5tpLuepADXJP6bDmRKCsHW7u2IsSBiCJ9puKbUyA9ij6huOvHHwSjUHz0QYDwIHrBMQZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325124; c=relaxed/simple;
	bh=Sh3EkptYIoxUIqWphxi2/4unHXicG3lj+gILo6hNwCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YgwoX0BOnBGEZczrZIa1S7vopxQuntRpmu6rPZJnjnS/cjWz7roKOs8GWQBsT0dMwyYvz/nXQiPSpiydADBIOhiKNKbt7KQiJi3WtLG13ejYPkhCrgHmMP3f6I4zXGybHoh/VtdE+ToezcpSlWdxBkHwVAtDoygU68otlfex6NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ey5odMIY; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqSlF4U6db+OXOBy+HFOVO+BSfNkLyCITnj/iznbTR6KQ9suFvyMlDJxkLyIZQ1nNLaNBJrgyFp4trHlJfmFp0KCDqOW9ArCFz5JayX7oaM7DszBOnu2q10+k6egrbzE/5MFb0tQ7RoF9R31BsjOJ3Cg87mUawuILYbvl4Wd+s1608OdWZ+1IJui+Mat19Y7L4t/Zve93nYlu1AQ728KwjCqy4vomos1uiH5cVbUZFHUXqj66eOOKC+x58Oh8z4s39FtECvpqEmF7B+cm7NfvSEuNlbyoXnMyDDjrGiJ12DAN6ygyKgILATBghYnr7MIJU/YOSUp4Zx0Db12jM3OIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ4CX72482yRGebrcmn6+zLhHBpCX1S1Bj9YJcZ3pAI=;
 b=x5OWNd+HS3k4YMJhFNC92DrKYW0kn2JaRG0/75Fg7MPfIbX5GHixn4Qymw0snO6rw1VUBA4tNgLNIr1AMOmirlK3AdiOk3OMNddmaJ/semxhRiR3gSxR2RhaCxVUDiWmkqdSypQPMPcKstNc6cFDH++G844yTCAgH999e26gh9u/v1QbPBWjNbeLN0XJs3X7T8JhZCiHHkjbAI/trz0gkkA7RwSkTqgKgpHZGAeNuijiGEuBPVVHPO5d2Mv78N1xwr226DY3I1iYh05bmsGaUyL6pQnk7NFFhygCQYfCDdognoIBgRwjhIhEWOfGpFzd6MRoS5g+2vKkNHSn8QC2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ4CX72482yRGebrcmn6+zLhHBpCX1S1Bj9YJcZ3pAI=;
 b=ey5odMIYrzLIDsh13QlgeiDZBD1cHJDO5WyR+sJ/0wWnPx/cIRsDJiNcDckTYI8+g39x2UCI89OBvsfMgSyjPN5ZMACoImJyp/AiT6KmogrCs5nldBYilz1tiC+5Y/nJLFC4NRD96Ql3ZrOHK9aePpIg9/X1S0nYGA1JMwP0zRJNJ5T65/R9GyRfXitx6bizQvjI8MUf3TS/RRVuX308uLf58lZUAzz42yo8q11Cwc4suqUyJOxav1g53zze0/0/PknTS4Y70OBy8u4QtBUEpZlDurWiWDjl8gnNwo0gp6Iyu7irlllKWLkEEbKFEM2e+Ig9Byd7Bm/MDWrxdj7S0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:31 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:33 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 3/9] selftests: net: add helpers for running a command on other targets
Date: Thu, 12 Mar 2026 16:17:34 +0200
Message-Id: <20260312141740.295353-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: f48af268-14ae-4d4b-5405-08de80423e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dNnwXzF8idRaSOzu+808o04THFgeRAvqaZ6yHOXkJ1ihtAv0azXynNym6B+a0NOHlcqHITKhxzjXSUjG82pYDtLvGbjTx+GiesyVUa8+WdeOaNhzJ/lQYOFYaMQZlg/K4rZojmJTNbDoEy0NNHty7kD9+blgImFghSdrPQqpgyJX9NeR9UN3uxeV+a8X5PBYCwxzUDAPBHC7RjqaAekpV8bK7WlDbFFWMr6tb7JDGt0of7R92TCbOXjZwhuUyHYf3YNTVjP/AaF7jZLGmlWFuZdBuHpfJzNIi16IY8bSxmq8OHRwscbkdimzJaF36vxK98UFQOfHNpgVPqaGCCCTsbCvyjtq+jVNd/ksJt7IHZJvTzvLwyKrtRUxauCO2CiArtRYhdMZitBPCgGn8Lc547SrQySEJ7s+cGII5yqlg4G4hpnJNtkfBa6YbOQUyg3voGWss3OLFWPCLpww6aU5b/AgRhUe6xGaeql1Bh34FAugOaTjJpSrYm9MV+Y6kLzWuHDzANzZ56Azp28VEEmadcrM4SK4sTh4SmfUsyRcD49odkjagzuSoRlY6uxVV0jSX1tPLJeC8eW3tsUjQ0Fs+eNztxjQZenpoc0PFQNuy/rcGKPrpH80Zptvdwy/IgnGHJYY8nxRqgkCiOEbxteZovr/voOIoWOvBaKbV2QXvLhNM1hgCNhlhcFRpQUx39Ml8G2GdLJ144qa3aCRcb+SrfzITAtl3IF1t4dPCVEn214=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2fhwpx928ykE3zgvLSWz/4I+xWL56Ur8wzWvN6WYRrjjzPcrEmomQ6Ibiorv?=
 =?us-ascii?Q?0OZ722CRjDbjl7rYX6K3bYmeYgTvnG7BzzDptxl6EBClkDD/F2RLNuQzriXC?=
 =?us-ascii?Q?JG3AIyDLJBFI/9jQIue8r+T1OtL2vPSvM+Fg4JyFjAZ3O49/6Kng/lE+r4IE?=
 =?us-ascii?Q?Yw6E/D52Hhfn/6qGm/+XMG2FjVxsu61LtO/7TiNQ0hyowRkRqRQM7W6M8Mc1?=
 =?us-ascii?Q?sYrGH89N/acCVQ7irbtcElmWSksC1CURF+DCg9vnHomUVo+5wVWrYTREQKwu?=
 =?us-ascii?Q?W8fZgPpuDsSVZHJxESv/Qax3YwdrKd/+RE53Y0u/dCbL9L85vK9cIC0Ij/ZN?=
 =?us-ascii?Q?XCVyHDgEwnO24OQsAZIJB45wg61pW4035E6pf58ZUzEbrj3JKQs2Tx9uW3SX?=
 =?us-ascii?Q?UoCiz2olPPlpbPUHoR+rbooq9V0S/XHeXMN57IpyG6lkGNASUhg0qQzbuxhV?=
 =?us-ascii?Q?X3PwZ8C/ba32IkPzJmsndGGpyaV80WhIoD5RxPfiXUMDIhbiVbEzZGw9ylbM?=
 =?us-ascii?Q?ceh3iL5PhWePBliflisiFF3xkAIt/FNQ5B9CgrruZKZvUDLmYJcQHe/6yYI2?=
 =?us-ascii?Q?AXKMrXhtzOtf/3W0DEhYGioOll/IpPyPeAu+AXptUtIFSoyGNtkSOYCusR1c?=
 =?us-ascii?Q?50xctv7hJa8ZPGY+WiUBfELJRxilxDSXm4fhXu0W+aQ5oaAHV8Q38tcH46aC?=
 =?us-ascii?Q?F6WyTCkGohevLhnYb02QdHJdZ3dAHfAqWyiq/ShNLYG8hop2SQI4ajiFvmyq?=
 =?us-ascii?Q?Qt5nqWdDk9ztNTx4Hnvg9L5MfsrQR6OQhZKm/ihkn99r9bEgo1NHeEJh05MT?=
 =?us-ascii?Q?voLF9viJ3dovXTHPiDJgsWhR/1M2dFQvTOtYSM+XLmZvLM4hHhTpiKYmJYLS?=
 =?us-ascii?Q?KdbIFxbQAljYT0TIMxKC0m3tHQGFlFwK0Mid5doIqklWJYVZ7KClvc7j7QQH?=
 =?us-ascii?Q?zXcXDZ1vQOtKlkJD0wHa21f+k9G4wQRh4sZa7+/VCEocEFgPh4IpF1fEqnab?=
 =?us-ascii?Q?VclVhYnkgtIsmi+TReAPR3THo6IWuc4+LhuKOltut/vo0LmGkC6nlxHsxD35?=
 =?us-ascii?Q?WjlZKTua9d4NdKbQKe1JRHw+nxej8Z8FeUpp7nTqf7elUPh/RSfSWSK0kWEL?=
 =?us-ascii?Q?hJWhfYAq63xbpFCuH0+2s+lzsnWmb2jufouJ/GC8tYVJdvKt3muA5si9J7BP?=
 =?us-ascii?Q?8SPdpPp0udTQX+I5vv4Bx3gFs5WvgOmHdUbRojC/SiDEyRMm6lXLMvaNuFn6?=
 =?us-ascii?Q?DdMnnbGTs9r9pLJZECsDiP4/9/84y+AgIuhdD9FnjeTPvPNPIOP9NtjkSxNe?=
 =?us-ascii?Q?aR6vR+HBC0g7hoSytMnICIN+NdZLkRmcaFRiS/vGSeNwCrq7Gjbnkz8sqnII?=
 =?us-ascii?Q?Tai9RceWIVH36wmA4nIB/xqoskQi2Cm+lALjDqVn+98ZFd5h5KsgQqM5+cXe?=
 =?us-ascii?Q?veM4oV0JE9MuyiMQvQI635mDqnuOBb5l2gH25Lc4eR785igUACdiLmHobgog?=
 =?us-ascii?Q?5UXo7F0DlX5eAZxxOB4pUEeIqmYyTmohr0RY6d+gd6DlNn6TEAhn0/YjJOVe?=
 =?us-ascii?Q?VXNjkYOsqloai2g01vnkTlDfcoh6Xlpp6do4QCz5um2YIrMRNatRec0xyggp?=
 =?us-ascii?Q?kF+dQ14ektLgP9jNZ6yfk5n3Zl9qzFke3luvgo+aXgWatdGJ513D23rerrpY?=
 =?us-ascii?Q?13Lb2nCDcwHd2jGR7xq6X8/kQZTcaog0DNGsSaW2/UkkmLCYAtM5R/9oNc7b?=
 =?us-ascii?Q?YDWS0ryX3A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48af268-14ae-4d4b-5405-08de80423e28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:33.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icy3jj/N2Y3Pyn3E366i2foNU5otLU2dNvelrV9Ypl+QsHxmmnAMpxyflUg3PUTyk4/nvPv+1QFi6eBFrTh6Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267086-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,host:email]
X-Rspamd-Queue-Id: 52A942733BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a couple of helpers which can be used by tests which need to run a
specific bash command on a different target than the local system, be it
either another netns or a remote system accessible through ssh.

The run_cmd() function decides where to execute the command passed
through $@ based on the env variable TARGET value while run_on() will
receive the target through its first argument.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- patch is new

tools/testing/selftests/net/lib.sh | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b40694573f4c..51d232552e37 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -28,6 +28,10 @@ EXIT_STATUS=0
 # Per-test return value. Clear at the beginning of each test.
 RET=0
 
+# If a specific command needs to be executed on another target than local, set
+# this appropriately before calling run_cmd
+TARGET="local:"
+
 ##############################################################################
 # Helpers
 
@@ -670,3 +674,36 @@ cmd_jq()
 	# return success only in case of non-empty output
 	[ ! -z "$output" ]
 }
+
+run_cmd()
+{
+	IFS=':' read -r type args <<< "$TARGET"
+
+	case "$type" in
+		local)
+			# Execute command locally
+			"$@"
+			;;
+		netns)
+			# Execute command in network namespace
+			# args contains the namespace name
+			ip netns exec "$args" "$@"
+			;;
+		ssh)
+			# Execute command via SSH args contains user@host
+			ssh -n "$args" "$@"
+			;;
+		*)
+			echo "Error: Unknown type '$type'" >&2
+			return 1
+			;;
+	esac
+}
+
+run_on()
+{
+	local iface=$1; shift
+
+	TARGET="${TARGETS[$iface]}"
+	run_cmd $@
+}
-- 
2.25.1


