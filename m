Return-Path: <netdev+bounces-295101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vRlGFuI3IWoWBQEAu9opvQ
	(envelope-from <netdev+bounces-295101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:31:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4F63E026
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:31:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=J6i5bsIA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295101-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295101-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2E31307D922
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B4399377;
	Thu,  4 Jun 2026 08:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197E19A2A3;
	Thu,  4 Jun 2026 08:30:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561844; cv=fail; b=OBlYxEW9K8//Omlxb33zMHXDaRMbQc4I5YjEpnfSqz+FUcLpFbid7Vfv6ZoP7Mpl413uKEasIEqMNdZq++oYMtF3cpJNQ1mh77o9TMIBERy8LrlMUBijxSGI1e+lgmCotsGMMMjXgnba4yMGzvVJNcUV3zYtQQgXnCjEwJHVocU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561844; c=relaxed/simple;
	bh=JrVliSlbeKptO9eKXjEV84rVZHJHw+RmXy/fQR5J7mY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WCF7469DiQR52v66tq26py8BPqA3FBdbb50Kk6LKYtx8CQnsDoa+AEr0AzHHd2yzypmgJasywXJADhJLf7ft+ApFE53pM0w0HPjtAhwCTXHQhgGDdR5EqO1Y00rowWhghWtxh6J+zFqUdZEBFc9/EoB4NqZMOBa+lvl+17HH1d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=J6i5bsIA; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGKR7G0FFqsMFR2N8jXH34sK9JFQj7CbfsJ6KtVczcOS3ivDsL9C3cPnrn6MEKqliZ27KqY9Hzsny7L4THtve7pg3xccBPDCSxSnGuVQMZXtqu6XCyeXuC7kxl7k2LilwFskwcgGAUrpcWudjrQaLPLTKN1LpYPGPGr0FAfX13ZNuMOwuzRKMc76XZbKYlJx2cryL5hM67cQsDjTU5VmSb/x4AhyvhYYy4KnJUm1IVUMbJ6zE/UmHY2oShP9zFlL3xX1s+lwNS7Vs3cWU/VmHVM5f7plPMNHDBOwjoYltfVb9poqEwxj27rBAY7coz2jOlWRt6eFRo0oPzKC8m03EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWeXD5b3Mu0UToFxdMygz4f9aecflESnL2RYK3Wz5FE=;
 b=ldUUPRUFHnJ+/KsrboovXcn42AFeHsV1KjgqLTvNXwOq2eeJXDRTA0GHeueJaUrEi1VBYdjBO4LZzin7c02NX/FJ1br1VohCwUdq+Brlxsfs5nGHihxmgAmTINUTTUSRp9PHUbCQulxJ8H5fqvoYXZ7DJrcnJXPqtfT/W0SOMbdiHDMW1hJjF7hFBIpVCObvRitVNtsDYwRgBXQXiskcnfZbscIiNmv5+FAr+jsmYRE+6xFl72j3K7W6gCh/KYVkHUTHJW9vAbi40bhvP0U+B6aMT3S+/0rD0bAbQYKq9urPtXoWSerJbvD2R4exl16AobFFkZkDT8X8eSlBE4XlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWeXD5b3Mu0UToFxdMygz4f9aecflESnL2RYK3Wz5FE=;
 b=J6i5bsIAf5+Kwc9TWQNBxc1gPso3FtH27OTH8fAH5yLTjgQvvvFY6WPCTnE1kjva8AThFS/glKrrhRSAeidufDgBDUZua6aggbrG+ia7zjdx2kOhzY2z0PJS/42a4oeo4PO8VYJP3OVQBbXlnmpYb9jd/e2T8PEfYMsMcvxoQ1Q4NcACPvbsKGvVq2M/p9xHNEz1jjvjZ92s4CmbBu3vQX+fsZeXcLQ4MnO6YumcN8LLT8dwnJ5s3Pv+KAwgL0mEX05zn4+ojK/tqzW6+y7Se3RqK0ivdx4/g4BljYuDs0iz45mlpJm3tcX/lPrm4STo8xbljZiN+Pcs7LmRDqoXNg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 08:30:39 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 08:30:39 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: xgmac: report L3/L4 filter match count in ethtool stats
Date: Thu,  4 Jun 2026 01:30:37 -0700
Message-ID: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 1514ebb8-162c-4163-20b1-08dec2138efa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	GxObSr+v9xf23qOZWRRJ9yYcpjHgF0oB+VTSFpPV8thIkLHX8ZlOzZPw25kBqMEd75MTSzTZw5AxU7+wpCBxtBX0UlSVTwR/S57rL5X5qZlt1I6p6TwrVLBCWiDUNpy7JoXQaAdX5+RC6M1t1CUpkdGOddoLe+WpNsgVPw7p/b1kH92yynhvGdRvQUR32ehSJAS7V6WX8xRUy430obdB4AflAFhFKeXCVuwWuygkERpKY3aDgDu2XmiCCXEenPEKTdLwasGkzUSA4gVHWS5shvEA8vS50Q05YrVIltwF7h+hGhwK/8Lzhb4z8svtkKoffJsIaO/bg01h7iMVQfV6mVE2zQELw6tYDrTFt7WzQlaCcndqPIiHzL7bcV4JnKJZe8Fd3is0bcF2f3MqeiDdm/xp2V70S+kPFBX8ZSwvyBlQI6OMJyWuGtBYeCdrWJ7VLeV6nos2/HXnVbE2satwldBnrsnvdrUyT0L1ayLkRB4i8qIV8aX5ETks+pJWRUPDQGS/ohyX/WFw3YcGVmc0txK+DNuvHG7sLwEgtEApLfe5iKhMuNqiMTjYVMYr9yhTEkoEO5JR34FoRajfULBDQmrYSs1dFtPGyozX+LHG4BQLM9bF1/IBzUmuPd7sjoY4ih7p/UZKriZrz+hoZOHSYXdNYI9NoXm2W8bklGt/087b/a3YSV3Lv1SEsHlgeJ90
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uhrCcq2ZVsvLqyTJr4poH/8tl57SIlz7Boy3pz4uN1CPtd+fXf1ZpQhhzS/x?=
 =?us-ascii?Q?g6fSMzk/HMwk9d9x679nhHAOW0wVyhVS+chcRU7nK6TyysBgpcG2bEUjMBiC?=
 =?us-ascii?Q?yLQbWgMjT/jQi65z3XoDuTaFFJTWggRCOTxoXgd4hbqnGUZatIwGPazypkOj?=
 =?us-ascii?Q?1U5yGV/GVm/nj7UW7MVtvDp6oKEQduuUTnID8t2D1cEeuv2S/MAJ8liGfDrr?=
 =?us-ascii?Q?itOupZtVUuivqIwnqeoEbXHNfvgztSX97K11EJ3OcvONrEistZ0AFjiS1Xfl?=
 =?us-ascii?Q?WX23Y5sZ75HclJBJ3hLF0pF2jcRiIM4cW24HNEurmMujUD0GtnqC8KzJFVXy?=
 =?us-ascii?Q?oRHdBaoqeU4heYUN9zKMzy1qoLGlA7BSNG5iHrGS3kKlQ914y6TEwObbhGFc?=
 =?us-ascii?Q?1VhCsOuOyKf7ls2z12x9/ib7VGMz3FsiBdawISJmv+PpEaaxjDhJRI4qkqg5?=
 =?us-ascii?Q?RQzuBqbuuHBhx+YdjToAK/XHKdzaTjoS6cc01te9aSTAcD5/keT4+J+r6tyY?=
 =?us-ascii?Q?mkvQIMiSu8sGhhQ6FY++SqyyLHWgJsJHJURDJHK+A1ehPS3Idwm+aVyJrIC2?=
 =?us-ascii?Q?9bPITWe2/OQa1W7d3UEaW3DL2HNVnUPXWxsUekDbYB4YirUme/m1dMJgZSU+?=
 =?us-ascii?Q?J31oJ6HYUxgdz/zzzcmFr+5xXzht+A4NEPZD+ZGQJUx79A5KmT3SmLcO/RvT?=
 =?us-ascii?Q?UR+lEac3lD/rit7RFpM1ixNroU8X0MeXYsCR4irCXPAp0dQXeZ+liJno/feJ?=
 =?us-ascii?Q?5xjq82DPKIa/qIhHvySw/vrZ2mUgaSv29r9WfL9dExaoUeS84r2VQSTGHkSy?=
 =?us-ascii?Q?8zbtgnkDYcuRaRmNVuza9zRn0tTJ+ykAPC2t+7kS+U0AmwK6/RErIceAsrEX?=
 =?us-ascii?Q?qW1zkjkHBti4W0sJdMGjCoLc37zTnoW3885VynmXtqUCUrYkdPqtEzI8170g?=
 =?us-ascii?Q?0YaC+kECYuqHFpucfasqhUXJJFE0frXeKwC4bT9Ab7ZnEbPOfrFo4x5u85f9?=
 =?us-ascii?Q?5+EZIg6Y3WPKVhX3clQVFOFiMfzxYtJ2LtNjxQcmMeVij5fNrb3sAN6IlOaZ?=
 =?us-ascii?Q?1TDfI6sUDSzNXsJVkXtY2pUTVuwAgZC8hBKAkaru4uRew7vIUIZpqyLZ5M2M?=
 =?us-ascii?Q?sp573eOT+z/TwXoBc4MtsdHT5g8ATMmdgqJqZbmvy7quKd2+WnvGFpjDQH4o?=
 =?us-ascii?Q?Rbo1eD/CIqHacJreNVMk8WXDiEd2KH0BKzXHUxukAVi6pP2rbnSDxrnMxJxi?=
 =?us-ascii?Q?sy0csUIl26zN/1+z4DMTPXD/2F64DfpyN/UNJrnSsbuuHvU0NGchr0TtjLxp?=
 =?us-ascii?Q?/YaTGb5kL95hRJnFcApiHzmiqF/CHXRVEraSPaZjHHt8yq3hkSff0BIIpqci?=
 =?us-ascii?Q?ULJ9F/mf3xMdaXaXv4fNT0/z9KIb8ZVbWGqZ1m1mtPnvWVFd0WMK1ashyIS0?=
 =?us-ascii?Q?o3CQSll6l0sW93ZzdgSdQMVpg3ZGw7PNX8COD4SBCPUnWGU2Go84CnklgI/A?=
 =?us-ascii?Q?Pcs59fbVbx319LreqSRkpGvpc8ReIanyuF025saVYonMCI5+eJoGEKBzFHuN?=
 =?us-ascii?Q?P68qL2vPVua4j+2QTg0/wAJ81K8e4aQA6n4guoNytNQ5Po0o32TDo8P55SHb?=
 =?us-ascii?Q?GK6O/jjMiViXw79kTEPvEET5HWs/VLOOxqnOrk/K+Ppa8POtU4/RGLsGcP+X?=
 =?us-ascii?Q?rvTxX2rEwB7w7FWoHmQ8OeIyGCUAqtTZyYXlwKVaC0oshC5635s3pohISAhz?=
 =?us-ascii?Q?Jj9XQYcJxm7xiVLpeMyiHHy3fhOdnBxgmLaHHVrYDbtWHx7UaYeKTX3ti+Sz?=
X-MS-Exchange-AntiSpam-MessageData-1: 7zBphShBrn4F6Q==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1514ebb8-162c-4163-20b1-08dec2138efa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 08:30:39.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dcP/MYEnK2H22Cr1JfQLHRPbX4zn66/0TX1BXxADJ6wuVrIY0+0GSEIZckKm4KknoFs6fJ3YvQPTHOxfcTqx6RkZevKBA/2xeU26I4BsfYwbidKZ+n4rqUOJ2mO5y/dLlnQPDm8jILwngvFKqM1vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295101-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAF4F63E026

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Read the L3FM and L4FM bits from the RX descriptor status word (RDES2)
and increment the corresponding ethtool statistics counters. This allows
users to observe L3/L4 filter hit rates via ethtool -S.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..95fdf3133208 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -429,6 +429,8 @@
 #define XGMAC_TDES3_VLTV		BIT(16)
 #define XGMAC_TDES3_VT			GENMASK(15, 0)
 #define XGMAC_TDES3_FL			GENMASK(14, 0)
+#define XGMAC_RDES2_L4FM		BIT(28)
+#define XGMAC_RDES2_L3FM		BIT(27)
 #define XGMAC_RDES2_HL			GENMASK(9, 0)
 #define XGMAC_RDES3_OWN			BIT(31)
 #define XGMAC_RDES3_CTXT		BIT(30)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index b5f200a87484..6719ac6e395b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -27,6 +27,7 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
 				  struct dma_desc *p)
 {
 	u32 rdes3 = le32_to_cpu(p->des3);
+	u32 rdes2 = le32_to_cpu(p->des2);
 
 	if (unlikely(rdes3 & XGMAC_RDES3_OWN))
 		return dma_own;
@@ -37,6 +38,11 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
 	if (unlikely((rdes3 & XGMAC_RDES3_ES) && (rdes3 & XGMAC_RDES3_LD)))
 		return discard_frame;
 
+	if (rdes2 & XGMAC_RDES2_L3FM)
+		x->l3_filter_match++;
+	if (rdes2 & XGMAC_RDES2_L4FM)
+		x->l4_filter_match++;
+
 	return good_frame;
 }
 
-- 
2.43.7


