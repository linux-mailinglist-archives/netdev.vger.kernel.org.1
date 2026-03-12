Return-Path: <netdev+bounces-267091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAXmHfvLsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C972733AE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C19F03087C09
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76332370D67;
	Thu, 12 Mar 2026 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/XXSTDv"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7F83148DD;
	Thu, 12 Mar 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325146; cv=fail; b=Bc513W8wLyGpWrxuHYTp4IBhccegghuwdksHlIUiOIYwoWcAOFnJN4lD4phSvvU/f0K89duVXdVP1ZAvDmHsJOpk8zIuMJruQ2wIwRm1zrCK8ONZM/uvrMZNUUAMS30LJG6HQ04IRAHretPwZrZj3GjaN0GgTKpEnhvz9MrHim4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325146; c=relaxed/simple;
	bh=dUdfu8PjzBBI3/Sh+H+zYVEbHEiygTixy85UYqtD+sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VsdHSCsrLklyLT6F3mY/heDCmA69u0mVR4GWvF8OAlpGdeU6+5e7avf7snYUIwPrqUu34McfsyDYvQEn8vy1bFaWhokphrvwUyaXolDd028ds+YnCnenavM31s9n63Hi8FiFrh+P5GqRb7oLTT61BjfQnQ7GUr0bRQe3Z/RbwAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/XXSTDv; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdkj69MuNZD2HMbhNXJq73anFAVqlTvanXxQeSfm/BjE8N96O1W3Sdi+dJXTMBIX3SHyLUwCe2jPLdbavwW26WxMp6r7YXP7070FBL7toeP05L1guyMvbhfNWBck7DuYJXnEZKSFOQ4PO5l5Bv5vzHKMlNMon0vtAZNXoCfv2HRQwijfK2hYYficrKZKnpj1Sjk/rsq5cnIKm0GCb5f2jiIw3IWWBws8oolBARpapGasVSDjdnR2mSM3f9+fGZPD/VNedJjIfB7VLr/XFLtYypXazr0jartz6z4yAxu22Lm/JPagSH6x7sM8/rAqy7SLazTek5KiZAQ/uRfFpViw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ODs4a4MWhzPw4y0Au2nCFTlerB6nRq1Kv1sJrrf1Y8=;
 b=RKsL/q3Qe4KCSf1OZ/fp52Tc78toi6PTPXWWvjCP663hj8Iwnooo1+IZwGuABv6BblcWP4ZeIF7TmQJbsdIfNjVmgXRueMxLmnHCGedHBKMP+gPP7zEwkqVyWWSzmYtBM73OVQZK8xlDblRlcs/2k18HHQ+NQRk+9ZdmZ38PTFMS70vsSmTH8AECjmYxHKsroNzjB/T7Off/EwUgddWg8o/yT29AomdEqOlvnSzQBrdTStVQGlNnpE0dQrjy3hnDIF7BZtrZV7lmj11RYfdZNcljWUnP7/SOwwfLuxeVNPSLg0E11pmzZHFX2B5VVamOJFeNORvAvvBdt6h9IObdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ODs4a4MWhzPw4y0Au2nCFTlerB6nRq1Kv1sJrrf1Y8=;
 b=D/XXSTDviS75EEfvHDLPQ95rrmw4IVU9KVBrN65meBgNqpBBUl7zIuGPPDFdZvvg7QLYaMRDRwk1xiAUWU7/8eAPdQu08G2yj3zuB2OB8NqJ8Y4Cq6qVoTWAyNwlmJLrz5o7wfSpO0tmqqYJ0tLX6T0Vl1WkvjS4on702TABBIlOE3ThzaBxi2ktSuSdT1OZ9CZvttSumkWdMsHWg6qztwev2Si1WzHvQGKjQMM8s0KIWV8lKfGrXZe9piqUpsEWahaleSvs0oPWog5M5b/Qyovif4jaJ5rC8rrJ86H+lTzAh1Yx7AffxdjqilfmcMXBgkAy+Xd6xMkBqX8LdVbMWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:40 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:43 +0000
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
Subject: [PATCH net-next v2 7/9] selftests: drivers: hw: replace counter upper limit with UINT32_MAX in rmon test
Date: Thu, 12 Mar 2026 16:17:38 +0200
Message-Id: <20260312141740.295353-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::11) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe1b92d-6347-4fc9-09d1-08de804243ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mr+RQWTThT3EKC6RS/Ms1gf8ZcDTtx2RkmR4+yfBwJaVslQyPNQwjp2z5SrhiyNcJfi36Fdx54oL2ZmWg5s59xi9he6n9dbovdZ2NmqNbOBpUkku8mm04/oJ6ZmPDJQ3B0Fk7c8ZyppJBhHZC2r0jddOmBwPikZ+sl7tUeng/0MpF00ZK24H2/VIkIPuvkkqtG4SA1dVP5By9S1xAGBcc+06Qbe36QGOPjvJEjFb+4j+xs7MLiKsuZMnwRjixKWg/Un/oUt4ONsgeeSzAbAYhxhbHqQlG+8HRuoEzlVzZ5W1XZF3qAzCrukC+8YoR5X5HzrqJj6sU/4mwvIWYIBW78HhdxhKFRSb/DZ29Ty51xjjRgibFz4myfCL/DfyvWyWG819ZpGvJy3AhzTjJ6I3k+m+r1/HfyZ8NYNU48wumrAkCprInpfYVp32cfgTNA6FcZjSRGoG19YF3CDMs1T0DOoks/g8/n+oxwORZtEugAiBrGrqKLN+D1Y7kvOkt9kkc5DwcTycBWbOiKYPzLkYzIPUtDEgd22Z8zyytLLfU7g1wgVWx+OcpdG0vJxZoPbSwX0b1VSXs8kpkwITO2gkYdL+Ql/5rbSkQkIF189fQ/MduEZdRm/96o3QodU7nwEfXtmmvqUU3+0tpVgnO+Ds8W3oub94sZ8oSoO82oN/K+V/14z/4KnqR3o0Sr4UAUAm5P//IpSrOHygKAMpoJqGkQKkzeeC5/nAzDnGniXm0QE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m0Y+V1k/82ROfyhVUJj1JaTcx4R5jn40uAQmzCgd23T6OSluvoszrrCbAYJT?=
 =?us-ascii?Q?EP+ZJl3RYVpuOfFJrFBhvHkQNCJ4Rb4kJfO3KD1lQie8vzjrSxWRp6DcsPB0?=
 =?us-ascii?Q?96L7umH4P7yRTO5kO4W9t+sH7HPSE1qJIg6OpEljzCYmtJemRv+JSh73sjDN?=
 =?us-ascii?Q?ZzE+3jXTGhmDwi8otmXc8h3XgfUV1NPHkov+JlEAjMx13H4Er0EFq10TxmEF?=
 =?us-ascii?Q?NfEae0L+0qZGIid5Pc3+QWmSSa05ZhStbouhd6djoC8KWzMCdXgDTXsl7ITP?=
 =?us-ascii?Q?GzAS/i5p0L0x6AsCAwynORuFlAhyiT6Xx6syW+q+vRIb4M9FL621Gq8i3ZDD?=
 =?us-ascii?Q?cQCT9OCpUrW2daLRn5ry6OmdD/BWKvGzwUiu/cWBfglWjHUvI480lqWsyICg?=
 =?us-ascii?Q?HBbNl/6m7CC7hOoe3rnN96Jq1UfY1ykuoSEUsShV7+occeK77APKq/HecDAF?=
 =?us-ascii?Q?4lM9tcI0v9ZklCIhTOSnrecnc2kKV9GSCb61n1Mp4uKfvj2gFBrvE50rYZ66?=
 =?us-ascii?Q?YLi5St/tT9E0g9aI+/BR78MoOOuPoUCo/ldD+TaHQp7sPg9c8NezvJUXXoKz?=
 =?us-ascii?Q?a6mEnvJJxZqD2/olNesHD4nfiXGpEoHNg83ydYFwpzQkgMlkVM2dAWvMmtEx?=
 =?us-ascii?Q?LcDlFlIX/xoNxS7DDUd7y5W2CEVaFVHXjaaxbZ3XTpDIpR2DjvioCx98npU3?=
 =?us-ascii?Q?MitlYEqTKc8qy9PDfpuOVQ6AqjK+Sl0qEaNgc3eZ0Yz6zcspTGYw/P304Qw/?=
 =?us-ascii?Q?2SsIf0URHOkLh65xEarj/guzrUhb9NE0QBUb3bH+2hbawt6CWU2cyOaJXFv3?=
 =?us-ascii?Q?JNE5DdIWFuHCigRssR01X0HVsvZVgvlKW9E7KIuBhTj6O/VJbKlXqwoR2CJH?=
 =?us-ascii?Q?61T2Od7s+i9jChd8tgkCM5nuWqENdbZ3vjMCMTqSoMzse0JJSkgGLQ3BOD3B?=
 =?us-ascii?Q?nQPIeB8NgOOKs343RprbbNnGtq6c26AHShD9yAyOM9/puTXg9BTrf13Z9obr?=
 =?us-ascii?Q?N0CUgkSymCS875vclztgpk3edpT141pPZDJ4XguVnyFhp/q+3a+19S540q2G?=
 =?us-ascii?Q?S1JPLGTsAC3vkG+GrQyXN4khPRtFDH8douoIG4P8TY7oXTSCoM+0F5qkT9Zs?=
 =?us-ascii?Q?mUWmdI7mRUMx/ufv6+oMcNSK7x0HFzBGPq54g4H6wM09uDx/e1bXZEy0XDnH?=
 =?us-ascii?Q?+dCe6wKGbrT1bY2dKxUZxiVbqUe1iKcmhOmQAiKYQ0OVtzgsoNDyPNEFn0nh?=
 =?us-ascii?Q?bW6BtuHkR0zA9f+Gx/1aPZH/W0t57YQh/WaYPLSj5UVPypHmzW5YaRrfSkUH?=
 =?us-ascii?Q?faWTVvCv+mS0a+Kh9cCEKADDj0zkSp0w978KkibO5nC9Um7bQpisFL/i9CQ9?=
 =?us-ascii?Q?mcGaEOj00F58BSuAxpHra+c3NSvxKEUdL4jgyGei4BtXEZ0MNuUj9BDmdzbh?=
 =?us-ascii?Q?Z07hojMUxWZ1d9/Xc8Zv9r1SZqU3l9Qt4Anvb4DCCz3Othji5rrYfmBGqMF1?=
 =?us-ascii?Q?NrUxQIUSWgbBumbnjuxK/F+mH+/w+RH3wlN5BQZ2dGWiVeAsEyI5fGCiujGg?=
 =?us-ascii?Q?iTkEOuyDGPY7tns7qwSEOYO0E/Q/ZUh+ObYCHNw17YS9WIKGEfG94SSBdFJp?=
 =?us-ascii?Q?E2PWUt9u8XIIq1+MJXj8SOp4TJQr/MAdRi7uxjozoOnS+QCXW2SfFcvU8Qds?=
 =?us-ascii?Q?kBreV9FZNIulKZaO1KTphlgTVQokTJwO9x2lbyODLSytb+p6KcpJLV1F8qDe?=
 =?us-ascii?Q?FjaHl1yr2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe1b92d-6347-4fc9-09d1-08de804243ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:43.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIsALMYJfIydQNjD2SHZklrAqFTVTkUrC3kps7+VG55zQlYfSiFtejyktz4f/B+SkijPzaSOJ3gTLGutdson6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267091-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,ethtool_rmon.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18C972733AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ethtool_rmon.sh script checks that the number of packets sent /
received during a test matches the expected value with a 1% tolerance.

Since in the next patches this test will gain the capability to also be
run on systems with a single interface where the traffic generator is
accesible through ssh, use the UINT32_MAX as the upper limit. This is
necessary since the same interface will be used also for control traffic
(the ssh commands) as well as the mausezahn generated one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- patch is new

 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 636429018b6b..1baaaab3c3a4 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -12,6 +12,7 @@ NUM_NETIFS=2
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
 
+UINT32_MAX=$((2**32 - 1))
 ETH_FCS_LEN=4
 ETH_HLEN=$((6+6+2))
 
@@ -64,8 +65,7 @@ bucket_test()
 
 	expected=$([ "$set" = rx ] && echo "$num_rx" || echo "$num_tx")
 
-	# Allow some extra tolerance for other packets sent by the stack
-	[ "$delta" -ge "$expected" ] && [ "$delta" -le $((expected + 100)) ]
+	[ "$delta" -ge "$expected" ] && [ "$delta" -le "$UINT32_MAX" ]
 }
 
 rmon_histogram()
-- 
2.25.1


