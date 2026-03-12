Return-Path: <netdev+bounces-267085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sADkGs3LsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC827336F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F15B317A397
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4B367F4A;
	Thu, 12 Mar 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fGmLlmqI"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF73537D7;
	Thu, 12 Mar 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325120; cv=fail; b=QQN3afY4ZMCghx1Zsn7mIaTXnjZRkdSSE0hK9o+Hs/YsOcPtMSZ/UUIQldzwWlgu7uML577syBsXbJulYHKyxY7J5dlZc4XV0QoMtug5bEXsipfkidrE49mHIaFDakZB0o4u81ivT4KBIHPGuw2hCCRWVZ7AG4zFncWOQlLATrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325120; c=relaxed/simple;
	bh=63kVU1v1Y726by+Q8qtvBnqXwRSL72U/znkgDo91TTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jb9IgF7aB3OK5HmLLAv9NrEM2CoRSNSJQlB8qKEvWwjWVf6NLeC/dEQXsKEEmDQ7fAFKVyNVd2k1S5zdeoM/xhWcguxzt43/7p9+UoSOA0nZ9oo22yd7rk0N6QH6LhMaouQoRbRAg9UXxNCoygDM5fAW/wSB0LrOpQ3iK+8QC+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fGmLlmqI; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbkELVRv+zqw8b+2HDOc8FlIKC330ukYJWcFdhyARnQm/5yujOA8G9StzXz5rx4baL6+b+8tqS3LIAPbPWsdt94WEZbVdtFQYKzzCOEnUhdkRYQ6c7/sN7wCNxz5bP16UbJmBHm+yN64X72aDnQguMqN7DI5D8QmakckPjQvd8CLSZANbtQtB1D7BdXHbMDq8dmovOsIOfHH+QKLCSFpi6NTwjDzs42yseTbzdQPsKyPNb/tMn5A37nYLZxN+1S7BsB4IOxlplRorD2bU4X8mhcKCFwnU9u3ud3rZjld8fM0deroi+HZYEhGkD1j0uEoiNNmQWbLD4eigma0UdDntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg0l7tmb43Lm0QDhiA6s+KkKBb3+VlqIwJCImtr/2OI=;
 b=TTyebj9j0pAcOdsdmR+p5kKSgIVU1vaaDGHmNB7+tcBPEMI7pgP2yfNaX8gNClPnFheLJ2MtzD8+Ev/tl/17xRLVkyACX7+eu6OPKbNOlwmseTU/P8GujOW7GU1GZJ0eWODea4I2xihY6sIN27t5jAEAMC4fKlWpadDh8o+66BHrSCCGre6hyTvq2DU+ieDELRY5HskrYqVH5jNFdLWlh84pZ3SJ3ieD/BtDln77LROtR44Rb9JBiQ1SHYFesXobq8IOvy0gV/RZmDep0lqbLMVGgKs1L9zCdsKRGJkgRBvzh/RqnmeGWv4tvG7+i6yjOAKog9IKUYaRqdzlVQuxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg0l7tmb43Lm0QDhiA6s+KkKBb3+VlqIwJCImtr/2OI=;
 b=fGmLlmqIrUuBh5BCuzYROSLkHhH5iIQf9Qa/jh4RYDmpErUrIouA6iZ4+Z/t8G6wXH3erLOWo9J53OmYGIDmw1yZiB+E7Tqp1z8mFYUOu3ayiJK+q6hyvHggkZTgfkUtCgjdCAKa8HKNl9lZ5vbQQSQUEDHHQQxYQjl1YPrdjf9RHcznSBGNzovkssoxnZTh6BfmkSPBIfyEg00/GdVo7jbwMQ0yzXpYm+cV15VybGNp9HSlNB8SkwcLGBIQFmadF2KAHMyQKdU6r1KjwxBAkxE4weZYHcORETLoJ6rwBUlPAn/x4Y7ZxhuxPpHoxArrCmX6Mo/PSPxWdE2PM6bOYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:28 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:31 +0000
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
Subject: [PATCH net-next v2 2/9] selftests: net: extend lib.sh to parse drivers/net/net.config
Date: Thu, 12 Mar 2026 16:17:33 +0200
Message-Id: <20260312141740.295353-3-ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 581d8d60-c940-4d61-441f-08de80423cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ht2jbq8CA15TgMru5BnqOa2Pf9mWEtgeqyrv1JavjoVPfxOllmwc7CO6hPexb28GVJAusd0BLoPqsunbGtrzvbE7UfbvR/sLseymjXyecfev+4TpDJiLpax7naanDZGgaaNKv48GILTqTXVyXqWnv8oDHVU41HmA5zid2nk15XbnzjcLkclPEHkuSulbvNX9vCm/yceKZTthXNn4a2XfsdXspBYgNtvwu8BIihO9CxITE/RIdCNuBV3UIbtVD4za//kIQQycishD6cGs1+IKOf2pntfuY3PsAgqJbdqsntEkFP97Z3wOA/7caZWQaMBZZZpLAtX6HNgyJYV2JBz5Mj2PFOR/qYfrn5wWGxFU3Zh3xvvWx1Xfy9KY5BCOVRedAIAKONfMGmJdbgc/9cJ7Xjis/QOajZww1LNx5m4h41z8lDEmF1nC2uNDOYgP9Xd8ZZKOpT5RCiGdAIO8vAolFkjPUy3cpF/jxW6y0S/Jn17TDXlWGzUc+CABuZsh7H2nB4sf8KS2PUhS+bn1/5PS7LjklHo4fjNBFlHUe+1tkUiUJePovrvqERFYfXgz7iA47DjFboynqly7jBEZ+5gKABvQ9NHmooF57vjkAzJZVq+09tSWUW6XVQaE6QuWpHz69oMGQmHzy7uh8XTtwPBad7PEE6V1Or/cxkLTrS2p8nnS00kXqM134CwvS+rdHtY3bwoEfwFwxh75jT53eHOqCFA/+c9HrKgVg2rnyjpxQUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5C+Zz+ALsYHeBOSykPraCFVFFfRLhYnopHTcL+zFmqRpDdp9cWmUHsDvE/a6?=
 =?us-ascii?Q?2J/UrkqakGW9vLM/nAv1gCIbYpcJxbhNkQsohiKLrKTPtTgX8DmuuL/ETJQT?=
 =?us-ascii?Q?pi/sHpGs5p7vtL36DEtVOAo/3ZYV09rWPgmpQwSJzewc38mgEMdbXxecy8pK?=
 =?us-ascii?Q?V10ubP/lD69Zvj9Q3dnjY6GHrJ8ZwVLbuf7twidvKXLx51HAQLSmf2a1GR2Q?=
 =?us-ascii?Q?Az33JYkizuWq9qsMZzx0q1Ra+v0Af1Eykg7KgeMFpLYk3wFH0oxWX+b6Um7z?=
 =?us-ascii?Q?dROqt28xOYFhr8UMhL1y7nDC1GB1Od55LemfpKPvBhmf8EtKXwK7OUA7GUrU?=
 =?us-ascii?Q?gZITR7upsL/lAuoyINO+1rNm/3v9UOGCL1nHdx71S69Z1VaM+txobsnRBskF?=
 =?us-ascii?Q?sxZqiz+m4sa/t9LkEYM40gSiP06BO1KaD2QE6fRHEgTHksSaP2AXOAZU9wJc?=
 =?us-ascii?Q?tyWaOdp50b3tncHewVrkxNCTx+uiKgfaIl7Vcf1EZtKVVAvUYhbrfQWhRMtt?=
 =?us-ascii?Q?fknAap9IPhvTDL1Ty021HRM7a8SK1qdQccUFc1SslqT6S7+T9vvKcCr+36hK?=
 =?us-ascii?Q?5pD7pAi5TdaKKM9dZ73IqIWG0+3YZMu6Y3O6SCwmxZZgOpEQPwKcAVFGjZ1W?=
 =?us-ascii?Q?ETufWi16RVRxefxYgTqMpHRm/Nj2wGiQ74dYUNwXyqxInBNUt+OFev6armpw?=
 =?us-ascii?Q?tIpC5EeVQwqjhOH+9GVnxVErJFEh9boT/TMj8eJpQDiinoyoJC1Kc2FceDti?=
 =?us-ascii?Q?jdnoOiu5AljFjzb4llB0+F4jTSoTV/2J5A+bFyjevAuFeQN0GzNqUrM4nExZ?=
 =?us-ascii?Q?jfi8QT9L8sc2guuzx+QCYDQhWHlPFizkfqdy8sj6lYJqEummoJykhcjJcNxY?=
 =?us-ascii?Q?jd/OGkvxtszEmtTkv721UXQBJe1wbfKswxgN9x46V/FyXCqCCSJetJDUBLKG?=
 =?us-ascii?Q?NxURmBoiZGpovvEaS7DdC+RWb67TrVrGyazSQrFnzorqWsGpgdwwRlINlHS/?=
 =?us-ascii?Q?1SGTALP/nfarcUDekUIphPthD+d0JUzUqYV1MTX5xUq5gJ1cqU5xedjhb1tx?=
 =?us-ascii?Q?YueHvyXybJt+xS4gbIxjxC/4S5RlWxfS0Ow0KSonBa7Q/IxpV1ciRrUgEHZU?=
 =?us-ascii?Q?wNWXi+KsagbVnNHs7mDBWy+dnV5wva6l0kxV3l2KmX3nxkrkMtxD0MU5wazO?=
 =?us-ascii?Q?65rZzv/VuvWu9VJg2mvyg2n3lfbZkE4Ky9y3f//mNYhqPV4afVQUjV65BhcY?=
 =?us-ascii?Q?tsl98gDdp9S+BknTDtKno9uACkEmOe1VPyOOZS6FUJKIxLstThmI2DMsa7kX?=
 =?us-ascii?Q?q+ccRWydLdbGIB+pgNpK1dBwiXV2gPvj4N8FAA4HDN0F6R5+l0NpTwz0aZZT?=
 =?us-ascii?Q?0JQzU2IeDmekEAMLhkPOorYkFCYO3fk1x72M8jeXpNBP05ddQJjgg/Cw05Pu?=
 =?us-ascii?Q?fLapysdpPlDZR08qEafyflqHZ1LXyZu2iHuYaxQmQ3BjPbasxipz501r/poK?=
 =?us-ascii?Q?URFb951h5m/qjmIwa1+F10GCVfcG/tihmnP/hMmoo642AO85U6EO9ds1UMZm?=
 =?us-ascii?Q?2W9oQgzOdL1kt6g16TTsi2DCKFd0Pc0AsAGcfGGC5ETHiLe8+srG3M3zU4nF?=
 =?us-ascii?Q?2ADk7XtVuaDaz+cTdYbbgn8hIU4Jf18+CPRzgm5FWrMwlRUI3dXuOHeTmr2M?=
 =?us-ascii?Q?mcDxRp6nmywycLKwUD2gI0ndjHo01MLp+OvnQ0lKh4szBlu3Ouq9HBVGg1I/?=
 =?us-ascii?Q?Gnhj9FhT0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581d8d60-c940-4d61-441f-08de80423cc1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:30.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I+63vNMtWKlpRPBh/1iNZpXJPxvOlA/19iI2voAR3X8DkYSF4mYBloOuMijJ0xOYdIpe9+csjow5t1r4PKcgg==
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
	TAGGED_FROM(0.00)[bounces-267085-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 12EC827336F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend lib.sh so that it's able to parse driver/net/net.config and
environment variables such as NETIF, REMOTE_TYPE, LOCAL_V4 etc described
in drivers/net/README.rst.

In order to make the transition towards running with a single local
interface smoother for the bash networking driver tests, beside sourcing
the net.config file also translate the new env variables into the old
style based on the NETIFS array. Since the NETIFS array only holds the
network interface names, also add a new array - TARGETS - which keeps
track of the target on which a specific interfaces resides - local,
netns or accesible through an ssh command.

For example, a net.config which looks like below:

	NETIF=eth0
	LOCAL_V4=192.168.1.1
	REMOTE_V4=192.168.1.2
	REMOTE_TYPE=ssh
	REMOTE_ARGS=root@192.168.1.2

will generate the NETIFS and TARGETS arrays with the following data.

	NETIFS[p1]="eth0"
	NETIFS[p2]="eth2"
	be used for traffic

	TARGETS[eth0]="local:"
	TARGETS[eth2]="ssh:root@192.168.1.2"

The above will be true if on the remote target, the interface which has
the 192.168.1.2 address is named eth2.

Since the TARGETS array is indexed by the network interface name,
document a new restriction README.rst which states that the remote
interface cannot have the same name as the local one.

Also keep the old way of populating the NETIFS variable based on the
command line arguments. This will be invoked in case NETIF is not
defined.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- patch is new

 .../testing/selftests/drivers/net/README.rst  |   3 +
 tools/testing/selftests/net/forwarding/lib.sh | 117 ++++++++++++++++--
 2 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index c94992acf10b..8d8d9d62e763 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -26,6 +26,9 @@ The netdevice against which tests will be run must exist, be running
 Refer to list of :ref:`Variables` later in this file to set up running
 the tests against a real device.
 
+Also, make sure that if you are using a remote machine for traffic injection,
+the local and remote interfaces have different names.
+
 Both modes required
 ~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index cf40cb766c68..25b354da4d23 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -17,6 +17,15 @@ declare -A NETIFS=(
     [p10]=veth9
 )
 
+# Array indexed by the network interface name keeping track of the target on
+# which the interface resides. Values will be strings of the following format -
+# <type>:<args>.
+# TARGETS[eth0]="local:" - meaning that the eth0 interface is accessible locally
+# TARGETS[eth1]="netns:foo" - eth1 is in the foo netns
+# TARGETS[eth2]="ssh:root@10.0.0.2" - eth2 is accessible through running the
+# 'ssh root@10.0.0.2' command.
+declare -A TARGETS
+
 # Port that does not have a cable connected.
 : "${NETIF_NO_CABLE:=eth8}"
 
@@ -340,17 +349,107 @@ fi
 ##############################################################################
 # Command line options handling
 
-count=0
+check_env() {
+	local vars_needed=("LOCAL_V4,LOCAL_V6"
+			   "REMOTE_V4,REMOTE_V6"
+			   "REMOTE_TYPE"
+			   "REMOTE_ARGS")
+	local missing=()
+	local choice
+
+	# If a choice has multiple comma separated options, at least one must
+	# exist
+	for choice in "${vars_needed[@]}"; do
+		IFS=',' read -ra entries <<< "$choice"
+
+		local found=0
+		for entry in "${entries[@]}"; do
+			if [[ -n "${!entry}" ]]; then
+				found=1
+				break
+			fi
+		done
+
+		if [[ $found -eq 0 ]]; then
+			missing+=("$choice")
+		fi
+	done
+
+	# Make sure v4 / v6 configs are symmetric
+	if [[ (-n "${LOCAL_V6}" && -z "${REMOTE_V6}") || \
+	      (-z "${LOCAL_V6}" && -n "${REMOTE_V6}") ]]; then
+		missing+=("LOCAL_V6,REMOTE_V6")
+	fi
 
-while [[ $# -gt 0 ]]; do
-	if [[ "$count" -eq "0" ]]; then
-		unset NETIFS
-		declare -A NETIFS
+	if [[ (-n "${LOCAL_V4}" && -z "${REMOTE_V4}") || \
+	      (-z "${LOCAL_V4}" && -n "${REMOTE_V4}") ]]; then
+		missing+=("LOCAL_V4,REMOTE_V4")
 	fi
-	count=$((count + 1))
-	NETIFS[p$count]="$1"
-	shift
-done
+
+	if [[ ${#missing[@]} -gt 0 ]]; then
+		echo "SKIP: Invalid environment, missing configuration: ${missing[*]}"
+		echo "Please see tools/testing/selftests/drivers/net/README.rst"
+		exit $ksft_skip
+	fi
+}
+
+get_ifname_by_ip()
+{
+	local ip_addr=$1; shift
+
+	run_cmd ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
+}
+
+# If there is a configuration file, source it
+if [[ -f $net_forwarding_dir/../../drivers/net/net.config ]]; then
+	source "$net_forwarding_dir/../../drivers/net/net.config"
+fi
+
+# In case NETIF is specified, then the test expects to pass the arguments
+# through the variables specified in drivers/net/README.rst file. If not,
+# fallback on parsing the script arguments for interface names.
+if [[ -v NETIF ]]; then
+	if (( NUM_NETIFS > 2)); then
+		echo "SKIP: test uses NIC_SETUP=yes but NUM_NETIFS is bigger than 2"
+		exit $ksft_skip
+	fi
+
+	check_env
+
+	# Populate the NETIF and TARGETS arrays automatically based on the env variables
+	unset NETIFS
+	declare -A NETIFS
+
+	NETIFS[p1]="$NETIF"
+	TARGETS[$NETIF]="local:"
+
+	# Locate the name of the remote interface
+	if [[ -v REMOTE_V4 ]]; then
+		remote_netif=$(TARGET="$REMOTE_TYPE:$REMOTE_ARGS" get_ifname_by_ip "$REMOTE_V4")
+	else
+		remote_netif=$(TARGET="$REMOTE_TYPE:$REMOTE_ARGS" get_ifname_by_ip "$REMOTE_V6")
+	fi
+	if [[ ! -n "$remote_netif" ]]; then
+		echo "SKIP: cannot find remote interface"
+		exit $ksft_skip
+	fi
+
+	NETIFS[p2]="$remote_netif"
+	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
+else
+	count=0
+
+	while [[ $# -gt 0 ]]; do
+		if [[ "$count" -eq "0" ]]; then
+			unset NETIFS
+			declare -A NETIFS
+		fi
+		count=$((count + 1))
+		NETIFS[p$count]="$1"
+		TARGETS[$1]="local:"
+		shift
+	done
+fi
 
 ##############################################################################
 # Network interfaces configuration
-- 
2.25.1


