Return-Path: <netdev+bounces-272071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDhBDWA4xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:45:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DC33631F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF5F631EF6BD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063183EF66D;
	Thu, 26 Mar 2026 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OqQgriek"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B032C957;
	Thu, 26 Mar 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531750; cv=fail; b=htIZaKcesf6IdEVWyreB14CRHjg6iWWg26BUvbsHhvrYqIrhDb1UmRSzC07fTrGjsWYXmAz79D1LLuP4YDUp1UYjfipCPH96AmHAhisIZ0r7unAuPu6/zO+gwH/gfhOoSXnWROPTn8U0HCy0dXvZjmMT46eH3I1pi60GORP8cxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531750; c=relaxed/simple;
	bh=sQZ06AwnoyzqOuM8XP/zWDLnsjtFvVowTrxv2Pr3ssk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQsgKqQLV8Snvthrw3d5KcOZxjJqYUvHekVrGQS8HJP1jqkSL+wdWIEkz6CffL8T779l+d7yUootLeME1jJ7CD9IcBV5HT9oDH1ho7gAjWKFJJh9suzFz6BzM1P4zrmiPDPZbYCOasShXc2EwtunvEL9hwi6a+LLbCiWbzjiiqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OqQgriek; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtgUSlIC6lCsqG/m0kTgmVUov8v1MC1HDFapUSFam/ZQY0rAptkCNoNZ1mwFx3xoLkqgBLv0n8uPm5l7GuLOT72yo6ZHt0TIEEb5pRBoSEEx1ldWthxHOBm3eO6dswMl4I7n+zeTmL3PFP39oAyxO23Fh+KZ5z7734De0J5//WdthEPkGVbQzGjOvHbzRIBeB2MaWlOlu8TctTlc3951Anr7KZ7MFPoW08jQ+WRcmUY3J6ZoFMizlu+a+IMrEnFI2+Xe6kLgLHSBe23l0M+Thi+IYwwrDsjBX0TaQhb1cyIHGj17/xnWjIrRfy6bSr99xBNxhu0m5h0ObPWCi+e6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThMxmS218FsKDuvuCvlhoLwdRI1jbKT5Jrm4m8UM40U=;
 b=WTimUJoBWhoxMr7flcQ1WhXEj5gk2uAPODrG+HQYQoI/qJjQfes4lNP0mVTnmQZs1NSABuT3lFO45VcUmtms/WfyrIOYEY98hi5zCR2buBv7R9La7lUYbCGIVe9hVKzNagJYIhI3kq0r9om71JuUlkUf0+zHgwWfOna5pWIClVmmQfW6QOJhabxojQjR5VntvJB/yV8DMYDY3siPx5yXiXuSqZuAvczY7pOEASiv4b0HiSj3L5M/85WaIhZSd0ojhKvCfcVQy1PiJqkgebNq8cy/1HkbnIfQmU63Aw47UYnr3udBQ6VduAO5ObzNTh8BN0jX4E5Sisn8eSWwN1/dbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThMxmS218FsKDuvuCvlhoLwdRI1jbKT5Jrm4m8UM40U=;
 b=OqQgriekrmOCwn4Xnz5diE9ToSfnVKWsMEvpR4rQzQyge/ndN+ICZpeoH2L/ug10xfmtNAiRAse7tOJ0TqiVV1ekI5BwlB44aHxw/KEcRO80JsLekxIRXSfeXKiN8hzhlFe/Zxawi+WvNelDNJj0M1c3wktZgea8Iph5NtNJrVQOWeSy+CsGFy1nCpmKDQ6AwsTufQcLuje9Rt43pLxPkgWnKaN2lLzvMHyyJw9VdiaD08z+wqFbSRRi2d2uunHVERmCB0ay6hecfdZKR+Tr1THnkolZD2VRooRUlQ0x1dRa+GJrrYVpMu8F5Ev2cFmCLZa9AZ5yuk4YOXQXH0AmTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:29:01 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:29:01 +0000
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
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 08/10] selftests: drivers: hw: move to KTAP output
Date: Thu, 26 Mar 2026 15:28:26 +0200
Message-Id: <20260326132828.805703-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::10) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: d214abf9-4644-4eca-be0e-08de8b3ba45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wOFD7edCkpxr5670WppuiTp4ikkhGCVMbbnlcu77v6pecE17cQY2yis+alh3xA9qJbVXFsKGCU7hSHH2D/w6oscTZArPijVTKLmwe8jc3VyEcILhQN8VQqHQdfZSTNvw75WSE50anowsQpc49s3kFeYf4x2RyFWyTsxIObMEqpnjHz2vnH2K2Ppi60GnZMjMngo7cVi8xZNL8tSvTSzIRfar9n5WeqBTjcdy3NzpKKQGqfMdAHRlygHQNXuiIFc+2iCIcJe7oVs6/Vw65vJQkzUU6kFsUptIo99/5ac5OoJw3YQ9Rl8DDauzGdC2NgwjeF512Z1Zp0h/RpKSntHu69G1yUFs9XWcVARq2Or3TxaeTh66YYKSrKbWuYBpnzL297WWDTb4GBt0+XGf2yry43gwzEEKInI3+VSr/XBRqqwksCa7l/tUQpuY0H4T94Blstsl+swj86kpQh3lApyCkpMlgWCJNkKnOLP7Tgv01UW58BPp/ybJNWZk55CRSfQ8jhSlFrz7nALyox3CfsNF7VXkAJA3VfJ6BG6RnFn36UJhYGxC2jgbOR3ezFAXSNjRYIIkt/PUDGRdBZuBgpN6LkkAPrgWe1PjWHHDlmapwBN/KBzsI/YfoCxKPCFXtgQhrQYlrpXiX5A1NPqP1JhoMysnyX76N2vl82d5s2WJj+Uu8NW+FgM8aWqCPCGMBxXkKfBYbNKP6sC/EKpM9Jk9wnKCjTWYfBKfmQNSZ8GfMQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?beITlThCCVwlXQ19sBl93ozWfnQ7b/VRrXB+PnlBlx2/+cZWocN8Auw0DSgk?=
 =?us-ascii?Q?oCThjPRea4bh4vLarPa92jQOB0jkQM25byH0ymdzpECIhFmCNocRZCMWWzTr?=
 =?us-ascii?Q?un1VTMgVw/ULSXTtrdmEZbho5liEh2T+zWKdCfX+x8JFeVCv60Lm2UgqmkM1?=
 =?us-ascii?Q?MHGRg63nWsRIRV6lv4bt67KliYa2DybFQ0rCng4AkMQHfjitBJ+3LvjfkOXx?=
 =?us-ascii?Q?BxxYNy5vE+0RtATM/ecGdArX+RBmFsu6xjSyreOV8VyZYrTkRJmiCR1TGtVz?=
 =?us-ascii?Q?7oL3SYr/VKNTJtkg5iH9qaLB9Rtw0iDJjrOP2hk0NI3W1vMsDqZ8vLPaq+7d?=
 =?us-ascii?Q?ivdkQSZ4tJNrZxZB2lkAc6ngiRYtg9iCRqGlCl0wXbrbztXqtGY83eNFUWB+?=
 =?us-ascii?Q?RWFJih1DjtxcvsHotxe2vGsziD0C8WnvEfCij/Q5fbmkELiHN253LoZ4BUHp?=
 =?us-ascii?Q?PkVkziL1z4tdt13j1yW1oJbwwOoUdAP/kly+GblMUXCnzv52JUYLEdQGX5q3?=
 =?us-ascii?Q?vil4VHRS8c1gsAkzjrbgdR/TmC341NgS8XcoC8uYywduOdUYSyjYT+SWoDe4?=
 =?us-ascii?Q?X2iFx895IxQogK+UZpqMiAGNZw6+c75W3Fv04RCihx8Af273RsPIbkfkD9kH?=
 =?us-ascii?Q?ZC/QiSoFhoPF0owQ5kvgrRkwmFmbbtwtRego4x/d53DtgnlfqFkKsjIxNwmA?=
 =?us-ascii?Q?sSiSmzgivt2EL7WckX6ipUc2C/LiMwWPVx27Xcqa3k2U0D2OFjRUAG2ekyi2?=
 =?us-ascii?Q?E6z0VAaOSCio2Nrd/95A+qwBBgE5ZQuZXbK/TGSLzreI6guD4ncMI3ueF3QB?=
 =?us-ascii?Q?pdB00KsWPPrfnhfnWx7zOYLXyJNLsdM76kVNNDuadURs91cxxXfGTGqMUISC?=
 =?us-ascii?Q?Whaoc3mTaJ93jlsrtHrYYfsYvQGmpaFax9YaqNH+GlhE3Eg0SvPzt1XvtKIo?=
 =?us-ascii?Q?yRhfP+2RvS+7k+zTG+r/M0dk3XaTWAwdl4RUDB6+9bJiX62yNiVsg93vDvnq?=
 =?us-ascii?Q?Ute+1pgSPkOspSciCkl9jP9Y0nXqtdpzLVDR+c7RLu9HxBRoqyiohA1JwIZh?=
 =?us-ascii?Q?l18GVb9ZuM4PllLhSsMEjIkPePJljyDGzeAK5d8U7K1iVw6m0avXDaTSkT6J?=
 =?us-ascii?Q?hX/kp9yragLdybyvI9ipO7ffR3KpMh17VObK7ZaE2IB1YpX/oIsa7PBfSGD7?=
 =?us-ascii?Q?/L7ZV/KLuFe8awTAqGe2gXzFW35SHN+bP2AGbwdLiHAdIMaKsUCyOjBdKdLr?=
 =?us-ascii?Q?VTAlBoP47RlcPUPbNsNl6K7jd26ITBfCSJWA793oRwrFTBCwCNxuGlukFW/s?=
 =?us-ascii?Q?83G7pIvLFDIZd7NqX5eI4BMZRDkaml6N7967hTlqcZZDUsPd67HUrUOxVX45?=
 =?us-ascii?Q?lRQB9YdF8SLtKEV63w7cfM5HgNQVQOMpbDRSiQvn8+B76Zk0UeMy1TNta49I?=
 =?us-ascii?Q?nrrOhZFas4t7xHuUhAqt0Y+hbkK8e9JqJwOuVC2tTwCvpS45mwN2s/N8812q?=
 =?us-ascii?Q?101T2K1WaB3O8I4vTzzyOs1gsspzAN5EXkxhMciKxiodgWfFlVUd1VUmHX4d?=
 =?us-ascii?Q?c+rKcQ4/yUs8CeCWZ++wtSJBoUFSihovGAPaZCOxl54ryANDQnY+kN54XXAH?=
 =?us-ascii?Q?h+wO2v6LMJHPlpW0KMNf/nmNLwT2zTuUqMzraoM0vRWlBQDJqIGeUlZctnAL?=
 =?us-ascii?Q?X6jf/svh63CPbWXOIQ9o6UC22Zj9W1tfw4jfztpNrHUc6cTJK0szc6/+P/vm?=
 =?us-ascii?Q?HkIijzPaVA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d214abf9-4644-4eca-be0e-08de8b3ba45c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:29:01.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 738kLbnmDd8omDA6rL1Re+ad5tBVe3hBhmDqGCOgEnbnLBtbmqr1MMIKO6/F3zQ4M1dx4LU+r1a74yIXl4wxOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
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
	TAGGED_FROM(0.00)[bounces-272071-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_rmon.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,ktap_helpers.sh:url]
X-Rspamd-Queue-Id: BF9DC33631F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the ethtool_rmon.sh test so that it uses the KTAP format for its
output. This is achieved by using the helpers found in ktap_helpers.sh.
An example output can be found below.

 $ ./ethtool_rmon.sh endpmac3 endpmac4
 TAP version 13
 1..14
 ok 1 ethtool_rmon.rx-pkts64to64
 ok 2 ethtool_rmon.rx-pkts65to127
 ok 3 ethtool_rmon.rx-pkts128to255
 ok 4 ethtool_rmon.rx-pkts256to511
 ok 5 ethtool_rmon.rx-pkts512to1023
 ok 6 ethtool_rmon.rx-pkts1024to1518
 ok 7 ethtool_rmon.rx-pkts1519to10240
 ok 8 ethtool_rmon.tx-pkts64to64
 ok 9 ethtool_rmon.tx-pkts65to127
 ok 10 ethtool_rmon.tx-pkts128to255
 ok 11 ethtool_rmon.tx-pkts256to511
 ok 12 ethtool_rmon.tx-pkts512to1023
 ok 13 ethtool_rmon.tx-pkts1024to1518
 ok 14 ethtool_rmon.tx-pkts1519to10240
 # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- patch is added in this version so that ethtool_rmon.sh is converted to
  KTAP output

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index f290ce1832f1..ed81bdc33536 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -11,10 +11,12 @@ ALL_TESTS="
 NUM_NETIFS=2
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
+source "$lib_dir"/../../../kselftest/ktap_helpers.sh
 
 UINT32_MAX=$((2**32 - 1))
 ETH_FCS_LEN=4
 ETH_HLEN=$((6+6+2))
+TEST_NAME=$(basename "$0" .sh)
 
 declare -A netif_mtu
 
@@ -76,29 +78,28 @@ rmon_histogram()
 	local nbuckets=0
 	local step=
 
-	RET=0
-
 	while read -r -a bucket; do
-		step="$set-pkts${bucket[0]}to${bucket[1]} on $iface"
+		step="$set-pkts${bucket[0]}to${bucket[1]}"
 
 		for if in "$iface" "$neigh"; do
 			if ! ensure_mtu "$if" "${bucket[0]}"; then
-				log_test_xfail "$if does not support the required MTU for $step"
+				ktap_print_msg "$if does not support the required MTU for $step"
+				ktap_test_xfail "$TEST_NAME.$step"
 				return
 			fi
 		done
 
 		if ! bucket_test "$iface" "$neigh" "$set" "$nbuckets" "${bucket[0]}"; then
-			check_err 1 "$step failed"
+			ktap_test_fail "$TEST_NAME.$step"
 			return 1
 		fi
-		log_test "$step"
+		ktap_test_pass "$TEST_NAME.$step"
 		nbuckets=$((nbuckets + 1))
 	done < <(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
 	if [ "$nbuckets" -eq 0 ]; then
-		log_test_xfail "$iface does not support $set histogram counters"
+		ktap_print_msg "$iface does not support $set histogram counters"
 		return
 	fi
 }
@@ -139,9 +140,16 @@ cleanup()
 check_ethtool_counter_group_support
 trap cleanup EXIT
 
+bucket_count=$(ethtool --json -S "${NETIFS[p1]}" --groups rmon | \
+	jq -r '.[0].rmon |
+		"\((."rx-pktsNtoM" | length) +
+		   (."tx-pktsNtoM" | length))"')
+ktap_print_header
+ktap_set_plan "$bucket_count"
+
 setup_prepare
 setup_wait
 
 tests_run
 
-exit "$EXIT_STATUS"
+ktap_finished
-- 
2.25.1


