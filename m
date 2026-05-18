Return-Path: <netdev+bounces-289133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFb6EitFC2qsFAUAu9opvQ
	(envelope-from <netdev+bounces-289133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:58:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B758571547
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB247303F734
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FAC495519;
	Mon, 18 May 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lETC3MHm"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA349252A;
	Mon, 18 May 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123433; cv=fail; b=p2JimwCcJ4xmwCCRfR3rJBGdaA3dT4zWSnGuAF68MUw7yO2BT3GyvYY02qXbfnEDiTbGnB//K+hbi662YvpM89Km/DbiYcuymsjT81rQE8KG+TTSt+s0M5j6u8lITLqQZ/5ld8DKnygdeGaarSWeKxD+uwBCI4Oisl2LIeT1pzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123433; c=relaxed/simple;
	bh=HBJ+3unn089UWCPjKKORwN720rbz7P5P4G1hJUcahj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVcxy5dSBKsRwuOCneT84kw8Epup4RLO4rfoFuPBoKpdiNXWDz0ySS6BO3fYiN1vL+qbFEXBadX3899l6fEILyxYnGZV9u2rhUjDNtjjcN5VZg0s7xEuY12ugJgUAO0N/uWLmcpMJJpIiFCnDmefvWGMq1mTE66EuuUbwZWCiYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lETC3MHm; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ma0aFOMwG6bo9V4AHxLAlHQFrkJuDU9WA/BCv8e7wB0Vop0aiE7AZlp4IJIvC/YQV3B61zQ4Tl7y0U9kWlGuPrj7q24MIo22yuNoyeNb36cBCkkxnxguOcK/MQrAeHCyFsVX1wKeqLdSU1WEoBvonL9ewLeiQoQqbvT8ht445jzplrO00MrCZ5CgWCMq35vOGmP8epxDzrRaO82ulxe/01hArKXlLUz+4JJ3/s1KO1xWeThDssRb7ZUJWr70qZJ8u1rTmJ9Ux/ALKZxOclwcHiUGoDqNJA5KUGcWg0VYwJrisKQxNKyKrLpiY535pih0dv4J4xVXoMSPfDEvTPx56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIT2U/njn9FDxJoIGAF9nYQk1ETPctpzvDzuFiJzjyQ=;
 b=oftVwtv3f20JUyJH5odk5jHlgJD0k7cjO0VQanBoIHrfxAD31gHhnDIy27thg3hCWSw1o10pwDRkKXHJ6Go6O0lB+t4XtJc19SaONFrigFbNBHdsZ9jBdhCb64KZGIaTWsGOEVLJD9v+MN3zS8YIuzO1NLw7tdACSMTyl4es8cc+bRdjdmIQSKbyS/uMN/YxcKMBr1JHLCCDO4De3L4VhytXH9y7A6zTWWbYxyHPboyzdXHguXoIs3HMwHcmBljokPghTOr6ESjCI3KBr33p6KFIoqSvx/OyoqeGvZYLmKqufM+m/Z4dB63O3gxFxW8ivcbz3ULYJPH83iAy5N/RyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIT2U/njn9FDxJoIGAF9nYQk1ETPctpzvDzuFiJzjyQ=;
 b=lETC3MHmf4zd/3bDIpezJ6NrW8EWe4+Vjbkm5o2+d1XW5wkXIAYcYqhFwQc5vVXGpTBZ3meQYKOQvmVQE0Ykc9Te9LFpmc6/GNuun+nMZI65pt20bt5kkDbPXjluBNpwYVsDByxTIiIdu+tuxviY3O4bYmuE/AUoedUaoYWh7wa4bWsSlxlRndUUgnu3k5nQNCbItV2ReM2HONO2Da3cW5e6YxyeGeGFHZAsjKcWhujYkkIIivrCJXWJE/zijk5tFqiNX4d00Mpy1gHfBcogq1CbIEDwoPhwrR9J5n2dI7BTE/tpgw5TYkNmg+9ogiIK6Qn1R2PVeWj1nmNc+VlYaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 16:57:07 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:57:07 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Roopa Prabhu <roopa@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Chirag Shah <chirag@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] vxlan: vnifilter: fix spurious notification on VNI update
Date: Mon, 18 May 2026 09:56:59 -0700
Message-ID: <20260518165700.1975478-3-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518165700.1975478-1-aroulin@nvidia.com>
References: <20260518165700.1975478-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:806:f2::26) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b786611-b56f-4769-e91d-08deb4fe7ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	TObU8qQfLMHDl+0+KBii073Wm7o+skxoUh2a9l5MM21x/cvbebO36B53iItBEgXQMFLs4ACqVzKzwRuqK4Cp5xWNREmZURQvd14j1SMuRNAuOtVd6+wIK2BN7aRWpUXDp4I209zLvqsYOpZ5ht0VwBuwokJgoJcw4Rky5Qt93BHvKvBgd5xja4j8qQzhz2rfcLxRiHVmYF7lnnB0ZrPRWAIpHyUawPQpjkOcs8c5BvRlREOxdoDusNt6sYIAWOZ24i3xn7Ulxe8IN8ajzi8zUKYxh/e8axUO67EWuNHBAc3nvL2QrS8U5Lq/PhLu+U2ulN51IbJ1w2OxRxNsatl2QR5uIHODzspVDuHIQnzCjVL7QUwsuw4NUdWL52+F/Lbng2J7xPb5rZC1uVZ/f4h0v9tL9jttYbWSpPIQJF72ItJMwrtvxnL86k3yOY7/RqoAkhz+DqVnOys2Yun1CFbCSVViRjw9I0PU464wYtZiNf+3cf5WiQ5jQy3m0f3vbeMdxz7gltMfTbWpawiIXdsb3gSZWyRNmK5KrXTkMZgChvERTEAJHncHhNRXvDNBIWYtwmQ5DO/VRttmilAkn9ZoANItESEogpI/JjOahxXyRGk+QLasZtPJNEB5RcZzMdrWjWFepOREj51y0qn/tDVC0gk6ZMijHxRls2UomgNjUar47ags63gxCeK2Xkx8wUQ1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJXc/ROMOxGb4O/s7lsdOBB3YOY0TMs1/riRsr5OkuEZAy/HpcYjrqawcUTT?=
 =?us-ascii?Q?KNOfZ15txRCPZb6WKFTTankHC/9EHoT0mOYDvtbt1u8dZbw2Zz1Ja1HIofgP?=
 =?us-ascii?Q?3EpEdCsa78EuaVKoYP2t3rkvanUgQdjcFfwS+9hnF7pR0/YbaA41eGR1YCn3?=
 =?us-ascii?Q?RrRb6ktj1AjCiMRDtr4kYWAFYQ5SCIi6CBYn5nrX0NpDauFrCa8q5Ni3+JuY?=
 =?us-ascii?Q?MuDC8qL8+WbDXdnK5q5NSZ4DbsxCwLuQJdChchFMQJApVnTprSXMYyo4We5j?=
 =?us-ascii?Q?ROu9QZZFiyfXirV3DW/sTO8RtaLy+C/BieFAzdVtePhaRhWwNi/H0qrACfpy?=
 =?us-ascii?Q?XuaAZU5V0WAw8DQtPpQwzFz95SLXbTGLYDhrUA8enKou+rUCsGXIUkx9MlT4?=
 =?us-ascii?Q?1pJacEYLoXflUD6wYAKXW9uNEQxNpNkQ/Ut6+fmoIW7ImiQM1oJHU2BwPThm?=
 =?us-ascii?Q?8YLeFKDNXfV/Gx3ag9Ijvt3hVmC++HOco0Vd+Cp/zbEnVUbe5EX8Q8xrhEOY?=
 =?us-ascii?Q?Z54jevzAV74pcOxeUIbon5xSHUrCDf5Z3cPdd3IjblbKp9c2ET5HrinKRY8n?=
 =?us-ascii?Q?la+oY9kk2GwCJEr0ZrEHPRM3LLjfk+DSJDhaX1omq+kqNlrYzjPK6RIF2s+a?=
 =?us-ascii?Q?G516Z7awYc1yaT2vPUnNPrICZ1i5m7ysVymyIA3mg3lTWEWgK5PXrLg/4yE8?=
 =?us-ascii?Q?zBU2WlUSDBPkYghlgJYEauCjJuGeqZg+gGMpVr7gcj9RJCcTFof+jz0JNOHV?=
 =?us-ascii?Q?x0FEZJBQLrOuSY2lCl0IvjxX7btgbCOtxDu55cIRL0A/OnUYBZALmv/Vq9zL?=
 =?us-ascii?Q?bwGMkkC/vWZdUPexEln0c3t/FhCATa2SOvdpZn4eoB3BkhIgiArc7KUHqdgj?=
 =?us-ascii?Q?FNE2HS0WV7NstvSE5KOuxMYqykIxm/DOL1j0LbD7zQyYAGMotmmX1NO5Le97?=
 =?us-ascii?Q?QBVJUOvZQZF6gtq6j1MaYEXyGA+0EWiPqluK8mKGhYuauMPiS1nlWKkVHeDc?=
 =?us-ascii?Q?HecCO1SO3QeCRo+FuoFgTZUGkwoOzY4biXxOLUsUegjb/o1HzobOVOnWlKky?=
 =?us-ascii?Q?BDnH21xkus2L0WcYa89GcvIwBeZH6h3AYE1Scnpztxk7vASQClD6DXqwfbA4?=
 =?us-ascii?Q?rpu/gq+NaSOVVXPw83bbPfUBGTZ59AWp8wEYWQ5oH/Cvzc88VMmcrLgnCFht?=
 =?us-ascii?Q?LVq723jaKojx7LVZZAIaAfDyLxURvmmOOjQ3WHEDUtXzaMD2vV7b3oU8xjU0?=
 =?us-ascii?Q?7J5rRTiYV6qSyf3DbPUCgmJQ9uAZKpGQoBq9b9yxB2yXidmV6zSMdhWx62Ma?=
 =?us-ascii?Q?5tNIo8i0KClUVWFoOHDnUcR+1itiDP4hVc4IdAlIZrSaa/Hk2eO+820V9HkE?=
 =?us-ascii?Q?7J/BHP9hFUNBt1WE8ablzNWyb8IQE46rQfrasWrz86fR2auMXEMw39np9Osb?=
 =?us-ascii?Q?BkhhvDw+dWLUBb47JvawCEdlQA8DicEB8USbvKeUm30AyluwQG7E248fuIDu?=
 =?us-ascii?Q?p81GR2lhWfsND5j4KS/b8yGdAPh73dwuqABifsQTx3/qHMmEXjrXYem7irTY?=
 =?us-ascii?Q?Ps6w27WkbuE7P+kEZj90VsWF+DB2g0decqGwxcHu88QfkN7s5yrpxTAEa77k?=
 =?us-ascii?Q?B/EPYWfjjCJW6fNXx14XBvbYHCX/ioNMKNGhMwPIGySmf7VYlLeAxM2UwUh0?=
 =?us-ascii?Q?ZOmUSuC5Lh3wG6W+r14sTmsSDLrSN39LZjyaHwHfUG8chdKyt7nLW1bv0aEj?=
 =?us-ascii?Q?D+FKK5dN8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b786611-b56f-4769-e91d-08deb4fe7ec7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:57:07.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsgUqSIuJ3DkQu5X3GJLLTW2bL0gCgUL8muP3k4FcrSe5epoTEUkayNQ0L4USlyec+DWSesrkLWtpiTcrBRhzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289133-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 0B758571547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a VNI is re-added with the same attributes (e.g. same group or no
group), vxlan_vni_update() sends a spurious RTM_NEWTUNNEL notification
even though nothing changed.

The bug is that 'if (changed)' tests whether the pointer is non-NULL,
not the bool value it points to. Since every caller passes a valid
pointer, the condition is always true and the notification fires
unconditionally.

Fix by dereferencing the pointer: 'if (*changed)'.

Reproducer:

 # ip link add vxlan100 type vxlan dstport 4789 local 10.0.0.1 \
      nolearning external vnifilter
 # ip link set vxlan100 up
 # bridge monitor vni &
 # bridge vni add vni 1000 dev vxlan100
 # bridge vni add vni 1000 dev vxlan100  # spurious notification

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index f2a202d468928..3e76f4e210944 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -661,7 +661,7 @@ static int vxlan_vni_update(struct vxlan_dev *vxlan,
 	if (ret)
 		return ret;
 
-	if (changed)
+	if (*changed)
 		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
 
 	return 0;
-- 
2.43.0


