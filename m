Return-Path: <netdev+bounces-268958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFBTKct6ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:13:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EAA2B9B36
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80719311DF07
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4B63A784B;
	Wed, 18 Mar 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FgTprckj"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BF3BB9FD;
	Wed, 18 Mar 2026 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828631; cv=fail; b=Dl6BOWPFIqA8HoVmWHa6Awi0cbrk/gXhgV+2flXtiaStZceVizMlKPCpHUpd3rydLDFHBWN+XPbGgfhUR5VtpGw3DLh7AosTmG0tF4l90Og96nZ3x5MkcxzCIouqYPVyvWSwfjIA1MEejHxwIPwDrzXblT8uev/T/nvjXgz02HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828631; c=relaxed/simple;
	bh=mm+lT59oBVZd7lxlnRRS3GFMvogk01XnGc8CcEEASYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtsMQ/46D+bIkRHY0G8PhLSv8qjLcvaUGKPYBj29z+SQVJPtwxBty2C1VENEWzXXphlqaD46vff7GGceaoasN2SmUeP80AwjtWjhhvYxg8p6BXZmxAjWICfZXClaZ4bSLxLej1pmPBEehcOxe/di/F+pwB1XP9aGQKHqIXoz2e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FgTprckj; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBYBKOmmP7dwLuGoJeQbP02+whhynRX2RGhtS4drQGFn7M2xq2jTkgc3YGgUxEYrz5/r6gFdSBO2mwcKbPZFVs3r5CwKFWLZVVSFB0yDDgjmvHzDz9noisubmqiUZGi0xXaFAVsbcp2/pKEZd9ipgNRWh+GGpuco19ISuUfv4/hMIrSDes8UCebN/KEY/5DNJMimekXRPPtJ8PT9kf7acmdohgvhoWRbQWJY2qTIYou7/6br71kR1FErGAy4Ev9NR/s/RrfDKZXBIKfvf+Ja4udnTbTj1RfsIZTKrCua29QHkyLeNAp/rSdI4xlz7QYxH8VPRNSeXKNLC3WRAOZBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9a42PiAt89EuumJY3wn0e2M6sw+mLv/aB7QLyVs/2I=;
 b=wZZlm4QG0/u/+8Z/RY75xTDHy+Kf6PyANtVs/nbSqUtctY+br+BYW6BvTsDQos4Fsd3SU7dUR9mfXvjOyq+lmtCQppZYMfilN9eIUVy9jnutAtvFhnfY4fkJdfmhDNWpzaB5HTWrM6VBJuKx9WAl595kSxU7OMhQXn7vvcRbHcOw4pZNxInEfpgUymHB9pXSQlBTmPHXDv/LbGmjSwmDWwbsP9tMDVht66jMBp8weJE5VpSiPIPK+PZrPL4V+37Ln96GE/KiWf0AWoZwrmbzr/KfrKKwZumpGI+TMycbx6KiMz2rBE5lIgONBnYCnQewh2xz7IgNAxuAIm3MhSnVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9a42PiAt89EuumJY3wn0e2M6sw+mLv/aB7QLyVs/2I=;
 b=FgTprckj1Uxb049FVtO3UMwZUz6vPlnmDa4dcvUpI8pBu0HnqZYOBx53j4jt6SjgWBE1EuzCNSRN+xvH2fr0ofGe4p03fqaelMukRpSJqNBoE7ecs9RiSNc39f6SIs5EpIOQ+L2iVeFHHhSid5tcyeEssSP1lPqwYDfKQYxZc/k1cdVEEl14EhlyydoM63b5Bnox4N+S69hq4DyeMqjZwzp9PiIjv8ABjt7DLGzdaCaGjZjzJGSS6xpZhkwKRqsViHi3cK+Vesd/bbUWWLsyi1y021VAUqeoRUdt8i3kX/Sz7E4sF+JSd2TQ6y4ryiazPRR71BQLga/4tU+Wf4iZqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AMBPR04MB11744.eurprd04.prod.outlook.com (2603:10a6:20b:6f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 10:09:48 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:10:15 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/3] net: dpaa2-mac: export standard statistics
Date: Wed, 18 Mar 2026 12:10:05 +0200
Message-Id: <20260318101005.2088897-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318101005.2088897-1-ioana.ciornei@nxp.com>
References: <20260318101005.2088897-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0038.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::7) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AMBPR04MB11744:EE_
X-MS-Office365-Filtering-Correlation-Id: 90645d77-3849-4d59-8bc0-08de84d68cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JM4QwOwpQ6CDX9X9ftEIhfR+pf2kepURS0NIG/sFUrmUt683HGClJusABOm0mFoi2HTkIy976ORYndvv1NAJQrjCjY8VIsVp3JlmBn2fibw+zAbcxmijlr4n8ueqReJxyBFTIUgyvkY2KKxjDMVkTCyt9gupSAgDMd1XTkgkFttq7E3SMlfTOIJWoAuTOmsTKj+SRckCXY3/ODqEqxDf0GkvuEYbhevZoWsmNO34RtZTCHIqnGV/Z21Da2Hoq5NWV0CSVZaaupRm/YKQSnb9sKbz4TWMVyPhAxWk/czeCZZmK30IAlcfVH1OU4aGRa3CZ31KJFcg1XD+yTjVWq4HKAaqaTcTCWc2LZGKr2YcznEpaHXlgaDZshnZvKBE31U4M0FutdesqL023z8HkM4XyBuWSzA/USCKUMJQVDQrkFjsW6sXLsZ3cCXm7sh1/4EH4E6bNsyquaUlBON3J6HSyFd5O0LjuAkhtFHiMf8wT2kE3/dO9LbyFpDlT218AfQ3Vi/iiRoOIFGIlVfFReXTt+k9Xbk49EOotsZFXaaRfCzL35eRkwUV/jY6w9Big4e4w1WL6trDOlW0SOB9CWXaqUAzp+DFg1fyhqlvilt1DpvJPgW1ZVCF/uYGG37j825pWPqQWL9E4y7V9M4KuAcZKn4+lH2mJ3aYhIEbpiyJVUn8pr5NjAMErV9SR3tME8gziFax7TLv7RCe+TsSV3ouHbiSOoxkKTVxnW9rGNdUZ6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zh7Km4eQxkhlKuxqxf+/zQN20E0TaPYw7hivUpx+w/1mvHjbxq6ziiVWUDFX?=
 =?us-ascii?Q?xqz/xKPfWsNxjJ9sHghBDSO0gnuTm+JWXW7ozF5IsoHUwxmQcSS8p9noZ765?=
 =?us-ascii?Q?NiuVeSRsc5T8F6oerIWKeMjPMyAK9q1fd3pBNvwUrt7H+3rOmrezjgSAUMiP?=
 =?us-ascii?Q?eiFrtttCVdsu3Ms3YSnLFTEpBM1AONkp+zpGONkn2R5Mnu+aagnq7HTI/i8q?=
 =?us-ascii?Q?l9HBUV1k0Rmo+O9D+t2KsB+wLM4lYESu2B0lZakDEsLo9eRQLFibABE0qmYC?=
 =?us-ascii?Q?FJsOSlDy81XRqfW0beCdEARbJv4tXW8JGMV1jOQpseG7r5K/eAAG97nB8Uf0?=
 =?us-ascii?Q?pq//Khrr63vU62HZCIxsmkLL35mIx4FvdH6WR4pWMn8Yard40HFlCkBfQkiY?=
 =?us-ascii?Q?ImKGijgYEWm7rIxAsX2GOAzbDU6COtJMovQ1rW/GxNnSYfErWncTLZuAmrAL?=
 =?us-ascii?Q?qsOHt4hjEI9kRsd40rrwvq0uiBFyM/XQHJK2c1QkCkIrG8yJTA0twh8+Gn4j?=
 =?us-ascii?Q?CTdg4i3xwpz005pVYCD6cP+MZwPIChf44JG8JwObrQ+2rzQXc4eiCeuH/sC/?=
 =?us-ascii?Q?z48E7AxERuqfqRgS9YSwxCaSB6GLNwFvBOegGGzof900nu6+CbUYMyVcMpMp?=
 =?us-ascii?Q?9zuqIf8teSgpH3ZUSvKn7UvKBf5yk5BJcXlE+N7Ngi0Zdiz5Bb5l2wDg/Z9Y?=
 =?us-ascii?Q?+LoXzSZ0TSh0JvKpjLru2XX0miRI+C11yrav2HCgChdeu/1kCZycTFPey8HM?=
 =?us-ascii?Q?AN+3mc5z9KtKu4QeiWHRLoCV6w4yiDPJPeQVJMF/clBWhFHToqRaXFFKkWlv?=
 =?us-ascii?Q?F0JOBQEowJRXRuyd7dY7nauCkurV2N5H1CGVuIl06xToL8yL5GD9ekZLBi+7?=
 =?us-ascii?Q?O42akxJ4RVVuLPccI8QoMgBWVKM29t1A7h84w9EfAi5Bg0uVq0wp8fuP+WVd?=
 =?us-ascii?Q?qphQcDZN84mLk6xcW7tTR3xADQEC/F9LYRwzfU0+MeDV1a0svVue9WfSnrED?=
 =?us-ascii?Q?j53WPt26enGAPxW6vPz3K8C8w/llGfYtyZvQNm+TAlX+qws3oNEE4vZn1RJc?=
 =?us-ascii?Q?ClQSn9k97Bgsogar1qB9mnijuXqskmx5PXE4aWN6jGgwjRYCpUD7CBP7avq/?=
 =?us-ascii?Q?L9fCaSVj6lMXOJOobnoaBPPsjz4Qtr+CiwRq/M0R/p+vi4Ef1KH1zI5M2zSZ?=
 =?us-ascii?Q?AzksTP9aGZRMBuYU3gCbi1M9ZjFou8kzDX5jx2JaBJL731ZT+019TLhynx89?=
 =?us-ascii?Q?aQP+WTCGrH475oNo7zH5Juj0anUfeqBhT9onbpOnhUYiKxWTNRG+9ChRJ1Rh?=
 =?us-ascii?Q?q5JX9HEqZEe9NfnZ+uLgAHr8uIVPkWv16bhQH6ZuG8jSWWGMpifHb3kY1wnr?=
 =?us-ascii?Q?RcrTB2hjwShSC8RqVXCozGRB2UOa7OoPAT0kx3HYKrXJqiCaug4rYZp3s7U/?=
 =?us-ascii?Q?wRFlRFOH3+AVdvbVzYame5JLdU1AXr+jxGuQAcLIJSj8nB/+TB1M0eLTFN2H?=
 =?us-ascii?Q?pnlhW2gLFMKbqhyGaYTKJr5MiI0R17mvLr9WlSFNdsqiqyqx71wq6k7/V7YP?=
 =?us-ascii?Q?4TI88MS8th8JSYynoEWG0fqkU4f+AIwYzeOIagbwK2pbmOYyk/mbOrs9pR8f?=
 =?us-ascii?Q?sAXZIpErQkHvMZRah9FUKHEV0olu85hysGDC8QUn1+G5evQhEM2T/cgSoT2i?=
 =?us-ascii?Q?Y4Ru2j5Gep2Xt4wTOPW2gXhwhyNwvzCYB7Qz2bH+5ysrQ3/qi0P0FONjgzc0?=
 =?us-ascii?Q?PLYv44JwAA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90645d77-3849-4d59-8bc0-08de84d68cfc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:10:15.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oN8NLEmFrdhuRa44t2cZpaZ/w3JvYDgDqqXaO0ARUG9eOW+slg+4VtbWvm+uZEsYfaKPkfxNEbtBask9fNeBag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11744
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
	TAGGED_FROM(0.00)[bounces-268958-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14EAA2B9B36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Take advantage of all the newly added MAC counters available through the
MC API and export them through the standard statistics structures -
rmon, eth-ctrl, eth-mac and pause.

A new version based feature is added into dpaa2-mac -
DPAA2_MAC_FEATURE_STANDARD_STATS - and based on the two memory zones
needed for gathering the MAC counters are setup for each statistics
group.

The dpmac_counter structure is extended with a new field - size_t offset
- which is being used to instruct the dpaa2_mac_transfer_stats()
function where exactly to store a counter value inside the standard
statistics structure.

The newly added support is used both in the dpaa2-eth driver as well as
the dpaa2-switch one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- reduce the number of lines that have more than 80 chars
Changes in v2:
- none

 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  61 ++++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 210 ++++++++++++++++++
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  17 ++
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  48 +++-
 4 files changed, 334 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index baab4f1c908d..59f5c778df38 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2022 NXP
+ * Copyright 2016-2022, 2024-2026 NXP
  */
 
 #include <linux/net_tstamp.h>
@@ -938,6 +938,61 @@ static void dpaa2_eth_get_channels(struct net_device *net_dev,
 				   channels->other_count;
 }
 
+static void
+dpaa2_eth_get_rmon_stats(struct net_device *net_dev,
+			 struct ethtool_rmon_stats *rmon_stats,
+			 const struct ethtool_rmon_hist_range **ranges)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_rmon_stats(priv->mac, rmon_stats, ranges);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void dpaa2_eth_get_pause_stats(struct net_device *net_dev,
+				      struct ethtool_pause_stats *pause_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_pause_stats(priv->mac, pause_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void dpaa2_eth_get_ctrl_stats(struct net_device *net_dev,
+				     struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_ctrl_stats(priv->mac, ctrl_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void
+dpaa2_eth_get_eth_mac_stats(struct net_device *net_dev,
+			    struct ethtool_eth_mac_stats *eth_mac_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_eth_mac_stats(priv->mac, eth_mac_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
 const struct ethtool_ops dpaa2_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -962,4 +1017,8 @@ const struct ethtool_ops dpaa2_ethtool_ops = {
 	.get_coalesce = dpaa2_eth_get_coalesce,
 	.set_coalesce = dpaa2_eth_set_coalesce,
 	.get_channels = dpaa2_eth_get_channels,
+	.get_rmon_stats = dpaa2_eth_get_rmon_stats,
+	.get_pause_stats = dpaa2_eth_get_pause_stats,
+	.get_eth_ctrl_stats = dpaa2_eth_get_ctrl_stats,
+	.get_eth_mac_stats = dpaa2_eth_get_eth_mac_stats,
 };
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 2ac023d54531..7e014005de12 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -18,20 +18,43 @@
 #define DPMAC_STATS_BUNDLE_VER_MAJOR		4
 #define DPMAC_STATS_BUNDLE_VER_MINOR		10
 
+#define DPMAC_STANDARD_STATS_VER_MAJOR		4
+#define DPMAC_STANDARD_STATS_VER_MINOR		11
+
 #define DPAA2_MAC_FEATURE_PROTOCOL_CHANGE	BIT(0)
 #define DPAA2_MAC_FEATURE_STATS_BUNDLE		BIT(1)
+#define DPAA2_MAC_FEATURE_STANDARD_STATS	BIT(2)
 
 struct dpmac_counter {
 	enum dpmac_counter_id id;
+	size_t offset;
 	const char *name;
 };
 
+#define DPMAC_COUNTER(counter_id, struct_name, struct_offset)	\
+	{							\
+		.id = counter_id,				\
+		.offset = offsetof(struct_name, struct_offset),	\
+	}
+
 #define DPMAC_UNSTRUCTURED_COUNTER(counter_id, counter_name)	\
 	{							\
 		.id = counter_id,				\
 		.name = counter_name,				\
 	}
 
+#define DPMAC_RMON_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_rmon_stats, struct_offset)
+
+#define DPMAC_PAUSE_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_pause_stats, struct_offset)
+
+#define DPMAC_CTRL_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_eth_ctrl_stats, struct_offset)
+
+#define DPMAC_MAC_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_eth_mac_stats, struct_offset)
+
 static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
 	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALL_FRAME,  "[mac] rx all frames"),
 	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_GOOD_FRAME,  "[mac] rx frames ok"),
@@ -65,6 +88,60 @@ static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
 
 #define DPAA2_MAC_NUM_ETHTOOL_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
 
+static const struct dpmac_counter dpaa2_mac_rmon_stats[] = {
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_64, hist[0]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_127, hist[1]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_255, hist[2]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_511, hist[3]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1023, hist[4]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1518, hist[5]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, hist[6]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_64, hist_tx[0]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_127, hist_tx[1]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_255, hist_tx[2]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_511, hist_tx[3]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1023, hist_tx[4]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1518, hist_tx[5]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1519_MAX, hist_tx[6]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, undersize_pkts),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_OVERSIZED, oversize_pkts),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAG, fragments),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_JABBER, jabbers),
+};
+
+#define DPAA2_MAC_NUM_RMON_STATS	ARRAY_SIZE(dpaa2_mac_rmon_stats)
+
+static const struct dpmac_counter dpaa2_mac_pause_stats[] = {
+	DPMAC_PAUSE_COUNTER(DPMAC_CNT_ING_VALID_PAUSE_FRAME, rx_pause_frames),
+	DPMAC_PAUSE_COUNTER(DPMAC_CNT_EGR_VALID_PAUSE_FRAME, tx_pause_frames),
+};
+
+#define DPAA2_MAC_NUM_PAUSE_STATS	ARRAY_SIZE(dpaa2_mac_pause_stats)
+
+static const struct dpmac_counter dpaa2_mac_eth_ctrl_stats[] = {
+	DPMAC_CTRL_COUNTER(DPMAC_CNT_ING_CONTROL_FRAME, MACControlFramesReceived),
+	DPMAC_CTRL_COUNTER(DPMAC_CNT_EGR_CONTROL_FRAME, MACControlFramesTransmitted),
+};
+
+#define DPAA2_MAC_NUM_ETH_CTRL_STATS	ARRAY_SIZE(dpaa2_mac_eth_ctrl_stats)
+
+static const struct dpmac_counter dpaa2_mac_eth_mac_stats[] = {
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_GOOD_FRAME, FramesTransmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_GOOD_FRAME, FramesReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_FCS_ERR, FrameCheckSequenceErrors),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_ALIGN_ERR, AlignmentErrors),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_ALL_BYTE, OctetsTransmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_ERR_FRAME, FramesLostDueToIntMACXmitError),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_ALL_BYTE, OctetsReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC, FramesLostDueToIntMACRcvError),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_MCAST_FRAME, MulticastFramesXmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_BCAST_FRAME, BroadcastFramesXmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_MCAST_FRAME, MulticastFramesReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_BCAST_FRAME, BroadcastFramesReceivedOK),
+};
+
+#define DPAA2_MAC_NUM_ETH_MAC_STATS	ARRAY_SIZE(dpaa2_mac_eth_mac_stats)
+
 static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac,
 				  struct dpaa2_mac_stats *stats,
 				  size_t num_stats,
@@ -148,6 +225,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
 			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STANDARD_STATS_VER_MAJOR,
+			      DPMAC_STANDARD_STATS_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STANDARD_STATS;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -625,6 +706,24 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 				      DPAA2_MAC_NUM_ETHTOOL_STATS,
 				      dpaa2_mac_ethtool_stats);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
+		dpaa2_mac_setup_stats(mac, &mac->rmon_stats,
+				      DPAA2_MAC_NUM_RMON_STATS,
+				      dpaa2_mac_rmon_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->pause_stats,
+				      DPAA2_MAC_NUM_PAUSE_STATS,
+				      dpaa2_mac_pause_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->eth_ctrl_stats,
+				      DPAA2_MAC_NUM_ETH_CTRL_STATS,
+				      dpaa2_mac_eth_ctrl_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->eth_mac_stats,
+				      DPAA2_MAC_NUM_ETH_MAC_STATS,
+				      dpaa2_mac_eth_mac_stats);
+	}
+
 	return 0;
 
 err_close_dpmac:
@@ -640,11 +739,122 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats,
 				      DPAA2_MAC_NUM_ETHTOOL_STATS);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
+		dpaa2_mac_clear_stats(mac, &mac->rmon_stats,
+				      DPAA2_MAC_NUM_RMON_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->pause_stats,
+				      DPAA2_MAC_NUM_PAUSE_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->eth_ctrl_stats,
+				      DPAA2_MAC_NUM_ETH_CTRL_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->eth_mac_stats,
+				      DPAA2_MAC_NUM_ETH_MAC_STATS);
+	}
+
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
 
+static void dpaa2_mac_transfer_stats(const struct dpmac_counter *counters,
+				     size_t num_counters, void *s,
+				     __le64 *cnt_values)
+{
+	for (size_t i = 0; i < num_counters; i++) {
+		u64 *p = s + counters[i].offset;
+
+		*p = le64_to_cpu(cnt_values[i]);
+	}
+}
+
+static const struct ethtool_rmon_hist_range dpaa2_mac_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, DPAA2_ETH_MFL },
+	{},
+};
+
+static void dpaa2_mac_get_standard_stats(struct dpaa2_mac *mac,
+					 struct dpaa2_mac_stats *stats,
+					 size_t num_cnt,
+					 const struct dpmac_counter *counters,
+					 void *s)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	int err;
+
+	if (!(mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS))
+		return;
+
+	if (!stats->idx_dma_mem || !stats->values_dma_mem)
+		return;
+
+	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   stats->idx_iova, stats->values_iova,
+				   num_cnt);
+	if (err) {
+		netdev_err(mac->net_dev, "%s: dpmac_get_statistics() = %d\n",
+			   __func__, err);
+		return;
+	}
+
+	dma_sync_single_for_cpu(dev, stats->values_iova, num_cnt * sizeof(u64),
+				DMA_FROM_DEVICE);
+
+	dpaa2_mac_transfer_stats(counters, num_cnt, s, stats->values_dma_mem);
+}
+
+void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac,
+			      struct ethtool_rmon_stats *s,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->rmon_stats,
+				     DPAA2_MAC_NUM_RMON_STATS,
+				     dpaa2_mac_rmon_stats, s);
+
+	*ranges = dpaa2_mac_rmon_ranges;
+}
+
+void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac,
+			       struct ethtool_pause_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->pause_stats,
+				     DPAA2_MAC_NUM_PAUSE_STATS,
+				     dpaa2_mac_pause_stats, s);
+}
+
+void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac,
+			      struct ethtool_eth_ctrl_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->eth_ctrl_stats,
+				     DPAA2_MAC_NUM_ETH_CTRL_STATS,
+				     dpaa2_mac_eth_ctrl_stats, s);
+}
+
+void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac,
+				 struct ethtool_eth_mac_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->eth_mac_stats,
+				     DPAA2_MAC_NUM_ETH_MAC_STATS,
+				     dpaa2_mac_eth_mac_stats, s);
+}
+
 int dpaa2_mac_get_sset_count(void)
 {
 	return DPAA2_MAC_NUM_ETHTOOL_STATS;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 6f4981627961..98c725f609e9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
@@ -36,6 +36,10 @@ struct dpaa2_mac {
 	struct phy *serdes_phy;
 
 	struct dpaa2_mac_stats ethtool_stats;
+	struct dpaa2_mac_stats rmon_stats;
+	struct dpaa2_mac_stats pause_stats;
+	struct dpaa2_mac_stats eth_ctrl_stats;
+	struct dpaa2_mac_stats eth_mac_stats;
 };
 
 static inline bool dpaa2_mac_is_type_phy(struct dpaa2_mac *mac)
@@ -61,6 +65,19 @@ void dpaa2_mac_get_strings(u8 **data);
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data);
 
+void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac,
+			      struct ethtool_rmon_stats *s,
+			      const struct ethtool_rmon_hist_range **ranges);
+
+void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac,
+			       struct ethtool_pause_stats *s);
+
+void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac,
+			      struct ethtool_eth_ctrl_stats *s);
+
+void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac,
+				 struct ethtool_eth_mac_stats *s);
+
 void dpaa2_mac_start(struct dpaa2_mac *mac);
 
 void dpaa2_mac_stop(struct dpaa2_mac *mac);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
index a888f6e6e9b0..f5d9321c7ef9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
@@ -3,7 +3,7 @@
  * DPAA2 Ethernet Switch ethtool support
  *
  * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2018, 2024-2026 NXP
  *
  */
 
@@ -210,6 +210,49 @@ static void dpaa2_switch_ethtool_get_stats(struct net_device *netdev,
 	mutex_unlock(&port_priv->mac_lock);
 }
 
+static void
+dpaa2_switch_get_rmon_stats(struct net_device *netdev,
+			    struct ethtool_rmon_stats *rmon_stats,
+			    const struct ethtool_rmon_hist_range **ranges)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_rmon_stats(port_priv->mac, rmon_stats, ranges);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
+static void
+dpaa2_switch_get_ctrl_stats(struct net_device *net_dev,
+			    struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_ctrl_stats(port_priv->mac, ctrl_stats);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
+static void
+dpaa2_switch_get_eth_mac_stats(struct net_device *net_dev,
+			       struct ethtool_eth_mac_stats *eth_mac_stats)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_eth_mac_stats(port_priv->mac, eth_mac_stats);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
 const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
 	.get_drvinfo		= dpaa2_switch_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -218,4 +261,7 @@ const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
 	.get_strings		= dpaa2_switch_ethtool_get_strings,
 	.get_ethtool_stats	= dpaa2_switch_ethtool_get_stats,
 	.get_sset_count		= dpaa2_switch_ethtool_get_sset_count,
+	.get_rmon_stats		= dpaa2_switch_get_rmon_stats,
+	.get_eth_ctrl_stats	= dpaa2_switch_get_ctrl_stats,
+	.get_eth_mac_stats	= dpaa2_switch_get_eth_mac_stats,
 };
-- 
2.25.1


