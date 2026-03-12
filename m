Return-Path: <netdev+bounces-267088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEs1D5nMsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:24:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CCB273497
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53F97321467E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B036B071;
	Thu, 12 Mar 2026 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ezQEfWeY"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D5366561;
	Thu, 12 Mar 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325135; cv=fail; b=AxjwRKcy5fCnU3iSK69EZTziyj4WNowza1XLBiQPQtwq/Co//v67aHjWq0+bGhV1kiY029FOEi7kkHdLwDf00tcoNmuhIz0Fp2zKWqdo6v3hkif/b7EYz2SrQVrSOdvx58Vg3Q8rY9gmwtiB/eFzk1oc2diYIFhrszpjY2B6x8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325135; c=relaxed/simple;
	bh=PEZfH3GLpipLTmvYrvaVuKWBw+TqZ7xrGpzznWRx2Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3m1mKhOlJ7jnVAGAm8PnCBNT9x5gTuzkP5JLXwpO1c33d86bsn2HSm1XS568nTUvwGCpJJ4j9GFpVz7qJgeHXEK2UyJ10dB85Mm085gw8Ps4HmFc58UacQC3QWd7H9sDjboXhmegA5YT1m1ZxX6IYvNd6GJ04DRMTbIcv6v9II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ezQEfWeY; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUGFV/q+la8JlDXR/KUcnASDO3/7inyCCCnJhWvrdV2oLJQRAodQJ4OrSMFNhgQuy3L/jK0J8PXcUDof+W/MztElLiOwtCGdq2GTDOBf+MfZf0gGuuw82oLbtVpEPx2gNPry+4PkVm4znTli1XyAV1Nq7q7/N3XDvDIFDF+wGeRLgeIiKRqsZ3djQivQJO37+9NEbD5MVPum22JwoPDsmZ5t8H+79pvHNCVECueGb4O2Ugcx77wjhGx/4pwXh00YuJKjMHWCfnaQ3ySkjJHIp4AruAzQtNKJUgFcT2Q/mBG8gV8vg4NxsuX6eTIjBaRmWaDtTsKN93zFAM0s+T04Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g1Q9vbkIHPS/SbcK26xf74Zn4t+ni/1CTC9Ne2a+L8=;
 b=jkQ65z4A3AE4HGuZeb/8URsXyGzifQAUmSyYbD0yGy5oK6A60Iz02xZY5JLQTUE1AOJhjaZ89yxEI3ff/ESbGjTq5Q+g3/UM5pOs9TghgkbyFFAc9mqLh1fvcEbS8nn8fF8jG6jtrkRxrNqBoUh279Sg/kMw6sqhxxRYmJA/JTSNJgic1eY6H1b/g3hSUisqoFLPz1t5JiFPRQ/2TLDXZiAk+oWRIOFCyOtSx0Uq2Fk2mwME8XGbwgIG7ZDuZFhk++9dRX0gRHtIvpSRdYE++wzMdNu1QH9V2YEqBC2vgHHja7lscEsdGRrzimmkGlGif03LGIAplfSXaU2JiSV1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g1Q9vbkIHPS/SbcK26xf74Zn4t+ni/1CTC9Ne2a+L8=;
 b=ezQEfWeYMJmo2iIajLJTShtI5dDeSIIAmDbLqSVhvIm3wy+YaO+N5Oh9JKYRpHHmObIHGlKLL6qGvPf0ySXNShdS4JI4OPs4jUcFV++vS7F8FNCnHqO/d7vB7sXMUbmRcq0u47W4gtJm28aneOrOxpSrA426xMDUfjaKn5PR8T9yA29dN7iDgfUNhPAxia2zXoSaBVecRZU3BVhQ6/7Lv0xtpG0b3G3Y7Wobx7YFU1LVaiOXqiMgFDuJt7MgOk42yDflDo3XRjTHLSuf3aFlsnlgGUX8FYwF8pCxUZoO1E2XMHjHhQhyj/7L4PfvpdkkQl/9vw1ZhmzHyVy0aEvTQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:36 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:38 +0000
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
Subject: [PATCH net-next v2 5/9] selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
Date: Thu, 12 Mar 2026 16:17:36 +0200
Message-Id: <20260312141740.295353-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 647c168b-fb54-40e3-c8c6-08de80424106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/d+FvIoihC0aHhdhOvrcy1vjTIofTWsdtAZvV1t3DBW6sta72jGwu7sg9Nu8MJ57isFTW3D5pHQRlAmGHrjpyuta8b6oQzctxXZWJK545a3cAUgdU9n2sZ+KzQ1hycnCyaRGvJsKze+eL3DhXHTLDIfEYhcNBxm63meSfRYbq4tmCSXqSgT/+s7QkjFYY/zn55/aeJLC07sbkmwZ7o1IJXTRqsBi65EkUPQ9agl57bU7WnyHw2kKHkVXxgXVhtcoFCeG2EX7+mqaUO+8jchkgBZf4CycQbh9F81U0HgJpTxNZTsQs/XQFes2aHRbgs8llN1M2Ws5jZ0OmKQPMZ5OK1z4bjF8tuJ2dBiLN1ER0928c8XJHmDWooriTyMfobFWOiYJoGOqadHzj7TLoinm8y3w0jfYkIISPz5WMwld1D1ZNWplHHu2c3G3OK1jsFxyMfQNIDC0Kqp6V/bfxHVv8AblcnHzY/A3CzbTlQHGEBm8hpA9O+SQZmOItfzB10kPkgCM/eT9bkzbcgGvHp0lSSpViQEWF7JiszNbuXdwW+mYxynnV9fA1CRuFl7aDmPG45T7MBpq02pwIWIMtBcU5RxCcjGhoNlz8kDa7bSyIkcdtN/yHKeTc3tnUr86Td9+CrmeKcTEC/qZPL08AItb3SpEPNiN8W91xwdtJQ3qobsHdriY8Q/sR6GLPuq4+h2lQ3dt/LrR93tFVI+MlCdkwFfFAzQvhXUE4btAvUHx0mg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0aY5Ka3jBQRigf1LXayp7KU0gXOFPnM2NQ1lHjfYZwsZv4w19nMCvD6cRYfJ?=
 =?us-ascii?Q?UURZR5AgRyPAgeaSlWBOUKGGaAe/IAPbQLRNkAQ/cn9ZW6Rvvq5pyLNvq9CB?=
 =?us-ascii?Q?Fo0yIdEXeZPhL0H2MCmZ+ubphVp/8cDE+jY4Idk8XTjwPGR84komk3KXioTK?=
 =?us-ascii?Q?nqvKr+DvI4oDTwk0IgwH8N0eGpFdrzfWFjV+oxeOpq7lftYH3vhr0GrlKOhE?=
 =?us-ascii?Q?Q5LMsq4mbrtNmqr8rmIOD4Yr6hHeic8dLo+etyr+Dcp0rT8LJc7Sx7tp8+CI?=
 =?us-ascii?Q?ZXjirJZYdoCapU7pMfgT0NFh6YQ7GV4dBEW2QNzXPStVEl96Pmg+T/aI24Xe?=
 =?us-ascii?Q?GE4UX89leqsWXbQaZUe0suFUG/FMKNtd75C9V72Psct1DgeT2I0QAuuB79w4?=
 =?us-ascii?Q?evZfXiH9SVW9YPOBrmmvDbwSL8fdbjMZpbl1+NXmgOr/2g1AupHbGVRaC/vX?=
 =?us-ascii?Q?WJsGNgwsPg+pOMaH88OflyveClq1Go6v4KEmKX3TU0QJGke0kKXT+TXLAFmK?=
 =?us-ascii?Q?a+3/uprLy7uHj9HI1wqE+dDLLeQhgEzJYdLnDg0hMZxBepkxTXXxF2RL0tTA?=
 =?us-ascii?Q?hVaWAu8Z1NNBzwxYBDFKJSs94iWRe7T6U1SdwL2lA0U6qTEVL1aagqzasqPp?=
 =?us-ascii?Q?XQUFs1wdWiGur4X7r6CZuPF9MlBq9trmRuoBfwC3roomnn6n/2Avs6GxoEDC?=
 =?us-ascii?Q?Y/44YxoDoumlK70I1cRpkJeXTXIMUW7Dl2oSlUxTBRdBEMqrmGSyaj9HX4rs?=
 =?us-ascii?Q?JX/hpJhdBFq/+DZ6UDH30tHAEbaMn6EhF9whqviW+WQT9fHdk4fM3fJLpbBS?=
 =?us-ascii?Q?fZ2hatTrKeCQpSLqv1yA6rgY1aS0FALRD22m/wwRMfzMhwgS1SMj1gd1F4XS?=
 =?us-ascii?Q?8Lh1KLRjmysjmEbkiu9QnkDTaFvypKlfB8OtLo/WHtGi11OIN1pr1yw2AH1y?=
 =?us-ascii?Q?yBeKLzZK2P9IwyIstNwQnjJfExYx2V5/pijiVRWIgLtrnV3lxYcxYeNZZ863?=
 =?us-ascii?Q?la8+Fum030C4XWfX8u3B28XrY/YnSkkH5iPwCt3Pssy8sCf/epf4j6dmAmBU?=
 =?us-ascii?Q?XFsdm5vseQ8Mj1U5+fd/63LutarFnlEh4dNV+9VTIXnO5L4OiA83eaVWq2rn?=
 =?us-ascii?Q?DPDxYtMFMbd9lKmOr19E+zC3lXsvzM2Y7yNE5ZHQdBl8MngW7PoEzHa4xQq6?=
 =?us-ascii?Q?Jl2N08AEVXtznAgIIfMOSxBKXp7AQ6PS0Gf5WLDhozWkf7D4Ss5yRBqWSBrq?=
 =?us-ascii?Q?cHKdwGVATupUmtK0vyGj06OGHC2Z53tclGRUJiOHjvUBTIU9MgRAJs0QkdIG?=
 =?us-ascii?Q?mDVI7T6XHK1eshpzYpi0hcOmc7fk3bYP+1o33ekoKYqw0jlZc/ySIUYbF63J?=
 =?us-ascii?Q?sO9YMEBZGPOp2kwfF0aG/EmYtMYu9OKe3Kp2zrDwU+DNw054g8Qn5zbxvrt1?=
 =?us-ascii?Q?ozH9HGeUYAl/xYEudKcXSSEZI5fyFJqt55AyZtEcoPe0Ge/72QWU5xzgNgvX?=
 =?us-ascii?Q?79Q6wGAx7B1v56dUS/CAG29gxxYdzbjObV+aUSDf2LX5DZS+/zKgfCqjbBwf?=
 =?us-ascii?Q?SpwWx4bg4ZGrEWxHyigT88kAv5PAixcU85h/IGTnyB19lXcFbQ088xSEAa02?=
 =?us-ascii?Q?2e0TIA5hI4p2p1QvAiCNtL4qFkbXsD4Z/xlI2/e34Gu98svoEWiYQOH4TKwG?=
 =?us-ascii?Q?Mh/vjhnSsVTPXaMZCDis0Ria+YTwBudXiz5YeeZs+IKZlULv7kIncS0e/LDM?=
 =?us-ascii?Q?BcO9FHrOEw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647c168b-fb54-40e3-c8c6-08de80424106
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:38.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2H0lE4EjZxIZpLNH1jJ5SRwNR0hBk46bHmbjYO/nugbUb1oV1NDtjxx+p/JsCxzbwNGNOMpnfhaIvgaP38fLA==
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
	TAGGED_FROM(0.00)[bounces-267088-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: A9CCB273497
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If run on the ethtool_rmon.sh script, shellcheck generates a bunch of
false positive errors. Suppress those checks that generate them.

Also cleanup the remaining warnings by using double quoting around the
used variables.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- patch is new

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 53 ++++++++++---------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 8f60c1685ad4..417627e7a592 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -1,5 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
+#shellcheck disable=SC2034 # SC does not see the global variables
+#shellcheck disable=SC2317,SC2329 # unused functions
 
 ALL_TESTS="
 	rmon_rx_histogram
@@ -19,11 +21,12 @@ ensure_mtu()
 {
 	local iface=$1; shift
 	local len=$1; shift
-	local current=$(ip -j link show dev $iface | jq -r '.[0].mtu')
 	local required=$((len - ETH_HLEN - ETH_FCS_LEN))
+	local current
 
-	if [ $current -lt $required ]; then
-		ip link set dev $iface mtu $required || return 1
+	current=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+	if [ "$current" -lt "$required" ]; then
+		ip link set dev "$iface" mtu "$required" || return 1
 	fi
 }
 
@@ -46,23 +49,23 @@ bucket_test()
 	len=$((len - ETH_FCS_LEN))
 	len=$((len > 0 ? len : 0))
 
-	before=$(ethtool --json -S $iface --groups rmon | \
+	before=$(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	# Send 10k one way and 20k in the other, to detect counters
 	# mapped to the wrong direction
-	$MZ $neigh -q -c $num_rx -p $len -a own -b bcast -d 10us
-	$MZ $iface -q -c $num_tx -p $len -a own -b bcast -d 10us
+	"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
+	"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
 
-	after=$(ethtool --json -S $iface --groups rmon | \
+	after=$(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	delta=$((after - before))
 
-	expected=$([ $set = rx ] && echo $num_rx || echo $num_tx)
+	expected=$([ "$set" = rx ] && echo "$num_rx" || echo "$num_tx")
 
 	# Allow some extra tolerance for other packets sent by the stack
-	[ $delta -ge $expected ] && [ $delta -le $((expected + 100)) ]
+	[ "$delta" -ge "$expected" ] && [ "$delta" -le $((expected + 100)) ]
 }
 
 rmon_histogram()
@@ -78,23 +81,23 @@ rmon_histogram()
 	while read -r -a bucket; do
 		step="$set-pkts${bucket[0]}to${bucket[1]} on $iface"
 
-		for if in $iface $neigh; do
-			if ! ensure_mtu $if ${bucket[0]}; then
+		for if in "$iface" "$neigh"; do
+			if ! ensure_mtu "$if" "${bucket[0]}"; then
 				log_test_xfail "$if does not support the required MTU for $step"
 				return
 			fi
 		done
 
-		if ! bucket_test $iface $neigh $set $nbuckets ${bucket[0]}; then
+		if ! bucket_test "$iface" "$neigh" "$set" "$nbuckets" "${bucket[0]}"; then
 			check_err 1 "$step failed"
 			return 1
 		fi
 		log_test "$step"
 		nbuckets=$((nbuckets + 1))
-	done < <(ethtool --json -S $iface --groups rmon | \
+	done < <(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
-	if [ $nbuckets -eq 0 ]; then
+	if [ "$nbuckets" -eq 0 ]; then
 		log_test_xfail "$iface does not support $set histogram counters"
 		return
 	fi
@@ -102,14 +105,14 @@ rmon_histogram()
 
 rmon_rx_histogram()
 {
-	rmon_histogram $h1 $h2 rx
-	rmon_histogram $h2 $h1 rx
+	rmon_histogram "$h1" "$h2" rx
+	rmon_histogram "$h2" "$h1" rx
 }
 
 rmon_tx_histogram()
 {
-	rmon_histogram $h1 $h2 tx
-	rmon_histogram $h2 $h1 tx
+	rmon_histogram "$h1" "$h2" tx
+	rmon_histogram "$h2" "$h1" tx
 }
 
 setup_prepare()
@@ -117,9 +120,9 @@ setup_prepare()
 	h1=${NETIFS[p1]}
 	h2=${NETIFS[p2]}
 
-	for iface in $h1 $h2; do
-		netif_mtu[$iface]=$(ip -j link show dev $iface | jq -r '.[0].mtu')
-		ip link set dev $iface up
+	for iface in "$h1" "$h2"; do
+		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+		ip link set dev "$iface" up
 	done
 }
 
@@ -127,9 +130,9 @@ cleanup()
 {
 	pre_cleanup
 
-	for iface in $h2 $h1; do
-		ip link set dev $iface \
-			mtu ${netif_mtu[$iface]} \
+	for iface in "$h2" "$h1"; do
+		ip link set dev "$iface" \
+			mtu "${netif_mtu[$iface]}" \
 			down
 	done
 }
@@ -142,4 +145,4 @@ setup_wait
 
 tests_run
 
-exit $EXIT_STATUS
+exit "$EXIT_STATUS"
-- 
2.25.1


