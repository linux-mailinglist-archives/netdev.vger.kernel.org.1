Return-Path: <netdev+bounces-269523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MFaIZIgvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:13:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9972CE855
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF50B305A61D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC343DBD6B;
	Thu, 19 Mar 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GKu8dsD3"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D33E9F73;
	Thu, 19 Mar 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936268; cv=fail; b=AtK0rBVOfeBJ7AWJp6EYknMpoWBmviiPmFwjkTl0QeDY2YGWMaeiKRZC5NBCl8JYcxiK+jm9hVvVWAfTEJRNexzx0yptqYZxARRMIJErJhaCXhJeURwuPO84ULgaNbAmQYcTCxHRDtzlCk8PDIDpAd4N+1NWZc5EnwzmB6/lNds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936268; c=relaxed/simple;
	bh=BAYrRC0xjYPB9vniLQ5p69F6DkfqCDoFUMRYVfoFK7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIOlObhuUX+u/7NsIPblkE1o3/n7M7KrikL/rhDd///FEEEDtXaVTn5Ff/C+DmR7Srv0Dau/moSeMSjsQKWJEHdwILzS1P4KCHhpQ3fEum1DyL6LTcBOomIsQgPT9Askp+yzi7buhf87O3GbCtjE7iviA5HahejI33rp0nvAQm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GKu8dsD3; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1aY3ImhoitPL8KdsKteO4nbIxPDnLL61/GQpiwR613O92BTSlkGeEyV+D4gHzzw0bbQq2iDrxKzZO/6ax/DJ574TlW6MWWnXDhsHIFC7tr+InEMAboXhz93pV2M+JE8BZOt/xYtkN53XdDSSaVf61HC0YnPG3FXI4i7JO6H/BHVZ3M/YgXSgKKqaBbHzpPtS9/CQOaJgnhjEzqrAqOfpvOlB6KpAHbH/GA+XtliqFQhxB28rnl71eDVUXokjTiuZuuMtNp/CKd/D+Y/lsGZMbhQloz6ryAW5qQ1a7jQMcC4Qtib451C/qYAEuyoxM54h+qx+z825zt2Py/zXH5gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL+N+ygwOiY9yepiYgeKH8tzpRc1klNRTLoBiqbXTFs=;
 b=gAwOXTej/Pcf0riJkGh+2soaewgu/dkWepLbwhY0VWGcmHKjyg7Y26iHhqmZLMCFTIjctuqibwSCYDE06gOPzJY8zHwzznDo7TyPh452B5c+XED3X93IP9f24eCpBUbd0Fevhseo4pHLiaoIckPpW6fsV/JtEchsBHXLmJEGGVCo0SayPNpOJGCdwwPQRAN9peiPQAxuHiJNnUWxs6OApfgXRU63G+Ypwu4jiSjT8hexPgS08yPi94SJvCCWkphN07K1GfDzEs1wlYGdfI44WN0Bb/zJHbn8/SwezeeXjU3om/0vVoLCEsgtpvC+1q8moTCWKaZ/Mf6h5M3qOA+ZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL+N+ygwOiY9yepiYgeKH8tzpRc1klNRTLoBiqbXTFs=;
 b=GKu8dsD3w1td7GvcQw/NxQkJ3HtRP9a04rjq9Bm1phGBD84OjxGPaxAnVUGv7zMwToqUYrpA1PIex2St5o8D/iira0+5KOwDzXlQR4LndkadoeIa6J22CEZfXoqoEs0T7dbBI9aH0oWVQY2prGbIpmBOZ/aw/DOixvYE7jjC/sFlMLSjWaTT3JjUtjkyx5U51D6sn+Vlw+KMdUOsP8+tmWclIKkG5iuHH/nfLiVuPziAzyFBGnZDkRMKexK6konfbvkAgEggsKoNS4WyEc99VCIU7YpXu6AUFllqf8wxisPn5jYd5ew0e6acZ83MFJw7qwpnw5D5WwzQOHw/A3lG0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:11 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:21 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com
Subject: [PATCH net-next v3 2/9] selftests: net: add helpers for running a command on other targets
Date: Thu, 19 Mar 2026 18:04:03 +0200
Message-Id: <20260319160410.2515105-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0325.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::20) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: a748e876-a029-405a-8f98-08de85d12f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	olNCc0DVu5E6ks4SvEDR4K9bRrIDfzW3poirN9qJ6UByUAjW8sx4R1mqI9QDxGFuYp2GU+01B935dEnz5AQjJvVcSCYa/yF8gPS3UzbnysWc0uFDMuKAxL8J5NgpSN/GSfoSriEdIxnC2NVWdM0OblTbCnWO51H9WHrzSWdW++yMFIBRsi61Pk77qVGe0gPAdcrGIlZAyYzHEY0Ymb+nIBMuKctYuSsHY1yASn3ANUs7CsCCqrjVF1vL5WbKIYOfM9mjBZgsfUehphvNs+ZEs7U5ytvRBGY7vv5Bfpr0rOE56m1IvwxtQv75WnX5SVzzbASd2u9cohzOfbowgTNdLI6z1CO8TI+JBnrD8XYgN9gsViV99JCVja3lF0COpHPQXSTAFKTG+00Da791MPGrOiHceYv8Q3tvgDpUHu8jyqefCxuqmm92BOhgFjN7LMe73GPnxJJ6KFp8gCIqHgPrhtbZaPg9m1qizGuc9mNnBA4mUS3KNTaGMJqRjoiwf6WO+kGrNjyQypqvHhU8TkdWuimB7VkkmgBeMN9uAxqZnh2MipIGSM3OyzY6g7W2Ux0hfBNspBHiMMF9aCqad/3DJs+7XudeMnmjfd6y21cjh/41sseJ94PivJZpqlzIAFa2eXS5cThzMpePJ+j34G6IOdA9wgTFSak1FM9PtY+Hr4Tmb69vBpYrmdIRkBsWDfMFB9KlXbTCYAJ4yCFSfy3wp/X76LFAqQjqLpvUyoi3piw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BfnWI2q1bOmkG/ZV+fI3ZOXIwVgCjvP93Ajqw9apruBn9+kKgg5WU030CmUD?=
 =?us-ascii?Q?8tsPBaJC6xtVQSFzOs6umwI3+/w013UEg5AK7A58vrCMr39R+/ZzBswH0qvO?=
 =?us-ascii?Q?oTIJwA7dCb6EUU5kpDIeTYmB1XjSIi7bDQxYL4vRIz8X7S1tD7+eqTZQ3Qzl?=
 =?us-ascii?Q?0GONqR3TvlE9pv/JsWClRkiwa2L3M1prSyDtFOW8cz/zwoSOagh/+mOkjSri?=
 =?us-ascii?Q?jHYanUBNjpeVl1V+VU0e8SxhF4mZYmNpWzU6ggQsPPclcXnEnoMzIYNes64C?=
 =?us-ascii?Q?birqZCs6KFo/XinTy3/NimWt8uE5zlhGqiJ7HwmVNygeKBfrSNOZEZNXHs/o?=
 =?us-ascii?Q?D/tZ9YkIL5cXrGHh9DTqPZgHtrkiGLYOcBplg7eRtzpnJw5C4PH5pWVhIZ3t?=
 =?us-ascii?Q?8Acy45H6W/6xMt6v/o63AJW54bh3kFfcaVsSMgOCtQUvHSQ7qi5Mth4C62Hb?=
 =?us-ascii?Q?wBATHjUptifTZc13IC1OaBKFbAtutmpSyyGHNC1+AubCOyaS+bfjZa0th0ey?=
 =?us-ascii?Q?bOJEvJwWNK85EzQg+a8qFH5LIONL220gYHhSCl07WnynMo7ZcsyxSS5NDXNv?=
 =?us-ascii?Q?IHM8iNjH/smh7l30A4tykHCYKQF8U9NHnTYPQa2GBqRQPDEnGPpbuKDnX4C3?=
 =?us-ascii?Q?26dczPVxCnlGtc51s0i9Rr0fXBTiazdEUkmpNoHNt+loqnYHJLskW4xClkdv?=
 =?us-ascii?Q?G9+0+ZgeYQG31F8Lfz2xCUvA/51dSHHJSat8WiVxeXX6zK6oYJCklbDNLfZ0?=
 =?us-ascii?Q?YnpksQEpEgA1kWpI1fD3+OnFLCCx3FOSvro7n4Fu7y+pUfCvmNy3VjHqlrjX?=
 =?us-ascii?Q?/HjyJ7xG9+jhQfHGR3cdLC1Hh7XS9r/fznnTVDtT1wtULdmnkL3WTO9l5gqW?=
 =?us-ascii?Q?h+P2/Jqephf41xfD5WdMY1ek8CUyZKxIS7d6nmZebpcOXEZUWZX1Qzzv63fY?=
 =?us-ascii?Q?0x2V7qZJHVya1UNdn9QJbo0tRuNvxquqnhONxb+nq4t+xQftlaBbmpKs5/+Z?=
 =?us-ascii?Q?bVUu3n08ErcLsZv+Mo3KU3i3F1MVA/BFVnW8VSmNqRk4/TrLhwjQskq4QOJP?=
 =?us-ascii?Q?hbIxFl3VzGHp0nMtbQHREVhiz/oa3MHy21EFrz523I29Di4gCwT7GwDfpAFu?=
 =?us-ascii?Q?EL5UKl/F94Dp9EsqcL0Or/vQ0CBin8PN2WnmbwCFuCojW7snapoSj2KpXygt?=
 =?us-ascii?Q?qLjFOF7QD9toHm9phU9uElwAHvmagBm1NAJMiDET5BRby7BNRyvt+WEXd81K?=
 =?us-ascii?Q?uGFaqcsFuYaWb3Q7vL99LpCJZaWQ2yLI3ADAHQixatROFlxksGdTZXZeENAU?=
 =?us-ascii?Q?d8Z8hcsns0CKw6fgYmdJROiIeiuwza59K3a15VaFtjoeg0vwQWbwGxP1cjv4?=
 =?us-ascii?Q?Hlv9iH/2AKUJIqms3S5NQiKk+st2cNGdwAxgzp1yVqgioaEF96YV6yLKW2Uj?=
 =?us-ascii?Q?ghIc4NwJ0Kngu2qq7ZIyCWOIHa1HZ1DnfdhVgwQf3todm7KfUf6rgdZSg2nF?=
 =?us-ascii?Q?Rvxeg122mQxvAYKXznrarUIRf/qWT8MdB0e6iuStJsvUmDHsfkFKWBVWXowz?=
 =?us-ascii?Q?/LiOevnN9C6YUE6NIfObdwHr11UHrLhGK4B6wqvGxfNyfeqENEhau3o8OUR5?=
 =?us-ascii?Q?ee1I2xrxyr8AXVYmNI6YZah5OgiEfk4eptoxkLgY6AdTXJ1u0ar/IvHkzxa8?=
 =?us-ascii?Q?7n7rMUIVbrpuK7lrCeILbtvE8HOVEht+4VnWjvwYtHkTNfyl6Ip0lPv83Y2T?=
 =?us-ascii?Q?vO2ofyGpfA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a748e876-a029-405a-8f98-08de85d12f02
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:21.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJfOA+fvuydlWIVpgehCoyiAFowdCDfNwYyzzloVdQmoWwieHcEInK6ASOU0+mWx9g5mkGVYiRZ2LcCYJNOLXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11451
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269523-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,host:email]
X-Rspamd-Queue-Id: 2E9972CE855
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
Changes in v3:
- s/TARGET/CUR_TARGET
- always fallback on running a command locally when either TARGETS is
  not declared or there is no entry for a specific interface
Changes in v2:
- patch is new

 tools/testing/selftests/net/lib.sh | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b40694573f4c..f7c54d05758e 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -28,6 +28,10 @@ EXIT_STATUS=0
 # Per-test return value. Clear at the beginning of each test.
 RET=0
 
+# If a specific command needs to be executed on another target than local, set
+# this appropriately before calling run_cmd
+CUR_TARGET="local:"
+
 ##############################################################################
 # Helpers
 
@@ -670,3 +674,38 @@ cmd_jq()
 	# return success only in case of non-empty output
 	[ ! -z "$output" ]
 }
+
+run_cmd()
+{
+	IFS=':' read -r type args <<< "$CUR_TARGET"
+
+	case "$type" in
+		netns)
+			# Execute command in network namespace
+			# args contains the namespace name
+			ip netns exec "$args" "$@"
+			;;
+		ssh)
+			# Execute command via SSH args contains user@host
+			ssh -n "$args" "$@"
+			;;
+		local|*)
+			# Execute command locally. This is also the fallback
+			# case in case the CUR_TARGET is not set.
+			"$@"
+			;;
+	esac
+}
+
+run_on()
+{
+	local iface=$1; shift
+
+	if declare -p TARGETS &>/dev/null; then
+		CUR_TARGET="${TARGETS[$iface]}"
+	else
+		CUR_TARGET="local:"
+	fi
+
+	run_cmd "$@"
+}
-- 
2.25.1


