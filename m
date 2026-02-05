Return-Path: <netdev+bounces-257359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHyBACEfhWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:52:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5816AF8393
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F8C9307013D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFB333A6FF;
	Thu,  5 Feb 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ugkmPPz1"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934283376A9
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331677; cv=fail; b=Ot1E4ImvbB7zEqXY6z9oHtTQNEANCm4OXv2C5T2+tTZhTruwk4KZNZcYGgA21jHeYPHDZZ+RqiHOeP3K/SfNqUuswNNA2oEQCGoO662MiGIFJN/2fqpUxk2xriqZZmVC1mBY2YAXzgFG42d4wAkUT5Vgip4BxcQGn7+eGWKCgqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331677; c=relaxed/simple;
	bh=5oe1nXGi3E+gGMDVFF3qYsKmk1k27GVgn2xR9ysqahw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duLadX1354WTToNqMG/Zx8gZkSjJexpsopvdjQMRUXEHE8o5sR1ZMkaOqWZ6svRj9YHI7y/RTfIuc4ptkHzniWAtCtX9r3YK93cPtvsqs8kFSrJFJw24oY2OKYvQjqPcAozZtTSjljhNOCSDnG8zhtbEMjtoCkAV5PIT61BoNK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ugkmPPz1; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzU/zgH6vNo+83UbrWKDuUBVLlkPjp7GDbbNYEyg9XRrPizCJC0hT34dWHu23UjGZnt8tTlE5K+wGofa/25qoFVJUeSkmMygegOHhcGoylFi+tU9gXJqK4eSPtK71ZBCgD4gQhVRKQIo48dYwJBs9LI90I8ePRSKItYFxEQL9JHtqlWb73/Hsj4Ff7Vnafqk9M0yqfjvjNNVq9ctM2ntKoGXKImD2jrMD8A7FNOM3U/SPWZ7nXFf/2E/NsYJUAhducBB7tXi5XT1xlJSq9CLr0YunvMqgp+GoAhpMyD+aFl/CL1peWMQxWGUGsZrzrulOtIlc9Afqei57Fb8oKQeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohwOjv+NSzMEm5Bz4uQz2APcJHHvtzWsrGQBotNnWkk=;
 b=qLo3PUm6y1szKz7BIJL8UOAuEuZbZAgrTOTq+m4cyZxaOYSmNP5iXRBe07ayk37vgpKmiXSMfcN4GWdrizfdTnPDXLp7YIt8nb2QKqYIkpEi0uTslxg1f6+1v6bW/Voa/MxKa3Vcyx1RUDoCyIG+Uus6i/0yTYyvS5tqhofmGDk2JsWJgBP/FdhfSrhvRvqlLo1NP2MeUC6JbjmawnkJbTasoDZDZuhPD4TE0bvDglI61FTVHFYTb+LUsUCy52aCoXH9k5YI07XC9qbeUsqOyIv6k58uDYm18jc2UH1D3HE3kOmYWHHrdG24eajBCFhzngwzmGUNPLjFnBhOIfmzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohwOjv+NSzMEm5Bz4uQz2APcJHHvtzWsrGQBotNnWkk=;
 b=ugkmPPz1RO5XjiBbYEyJ5SNMUsELoLHGncTHJ2dHvYfnsZIHud1fiSs4ccvsvOVDfeJeuQMze+oy2cWGDEI0XI1QBk9q9BF6oDByBL9E+nSdByklhoyUdsIvLWx0L6LuPWEY5Bodde2vUqVq/Q8P4hpn2uhF9KoMZG2r838pTyKSU9YLtCDnS13CoygMNXGXa24iZGLRxro4yyl+lA0PaYXQ5ttVgKpNO8atyUR6+TFVPXRm/kk2BoGWM/Js4kxa9frrZGzG2JOFI/7sdtvdEl1uqwFVmvmtv79Qo0OEJLYGi0UQ4FYwqLfI2MKe9IayYUAk4svE3CCI1Q6T/qMl+w==
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 22:47:48 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Thu,
 5 Feb 2026 22:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:33 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:31 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 12/12] virtio_net: Add get ethtool flow rules ops
Date: Thu, 5 Feb 2026 16:47:07 -0600
Message-ID: <20260205224707.16995-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 647ce77d-1d17-4b82-467a-08de65089601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KNn/G0lAWttOiLjll2+ItJC2jHxRtA8IsYAeH4Db2QUdZU/i1YJ2R3N7r8Dp?=
 =?us-ascii?Q?wd2FJ5UI2bSOgYPSPyzNy34aPTSAdUbN5kZ+rgTKJC1z5bSdNL5HEYVeWiSN?=
 =?us-ascii?Q?OGE+ZXKxzB/anLW6S9/IKELywQIoWgKkEuCu4PwVJ0wegME5THu1WpruEcNO?=
 =?us-ascii?Q?iNgjkjFLRbzc1HlZFS9OTAAJasAo/MpczhNPMi/wYkKgpcupxNRB1pZnU9Bt?=
 =?us-ascii?Q?eeU7bQH40Mu+SxlwW52Ay9PypxPtK1h+1NxnDpXmdI0ZLudPHlO71CxoRf1A?=
 =?us-ascii?Q?nYozN3y87FS1TxAz8/DoHOi0xWff8uLfRnBkF0LTU/+T+kvsRQYPIe4JrQpy?=
 =?us-ascii?Q?OmSNVfL3L/AykUSPHxQoB1Q6gfd3ipxkR/dZ8N0V5o8ZH7QQb2qFqHkKu0+V?=
 =?us-ascii?Q?LsBDq5I7VbF4dM9e9LoDL4XMlr7G7x+oP0CE3OebLrzIsBjKjuJG4rq7gsZM?=
 =?us-ascii?Q?vff8ad5FB3qnfE6s4spB3orwMs5GwVcbk/Dwl45Ok9mM8AEMfNA/pRYzRStF?=
 =?us-ascii?Q?0zFmn2sqZNff/dzsoy75q9GQ6OvQvfTZ1+9cx2FuKZ3PhHmoHHZ/NcAhTOh+?=
 =?us-ascii?Q?niNgmlna4rerd0mhf+hOLFC8RSjrwwCZjm1sxxJ7jVq+DXWb/ME1gzMysQ+q?=
 =?us-ascii?Q?Z4ohH39LRco43Eik8+nDTEmqdEQw4ihZKV5ruyAlwKFU1zThw7jX7H79WaeX?=
 =?us-ascii?Q?LBjXYDvwcpZ6CIg527uzc/idBhmdo01JnsFPytjgNu8R9m5vYj9KjBt0HY92?=
 =?us-ascii?Q?OEfy7iNYOPqNAxJsDAotjpEslTzXJ7d8+eFPlu36I3Y/jAzkvoQfmEx5RkM7?=
 =?us-ascii?Q?0w/dw92dkVSCSlr7NEfd4dUZ94LnYzIEvAR15AS/Jifj9V519uYfvFFEwXsX?=
 =?us-ascii?Q?0iWsJu6lYJwzi+lm7ylxCPihqBr62aGGkbIcGNkQ3ZmnV0j6MV1jEVJV1yKH?=
 =?us-ascii?Q?3NyF9c6IE0cwZLH+fq5kLTdIOkUY3LLgkFKiJzbSrHsYc/zUE9R0mTLy1oyl?=
 =?us-ascii?Q?QL2e/87JWp+byk80XcdouUX4PsNRXfbnnX3GuPncRqDdq68BlAjTR7d/LtdO?=
 =?us-ascii?Q?YLv2Ui1LfLgK/UsGBBwG10q1UN55F5bJXxnbpQDK5I1ShlUGgZ0KzHv/I/JW?=
 =?us-ascii?Q?+L5p4kLVSPFqvFaaobft4kYv43MCzGwNX/HTA4iYGb+FB1VbzOWXpGAm849H?=
 =?us-ascii?Q?mo7kAzIi9nN/yDwij7UYIi6M2hH/o3N7InZ+naWDyLTEsXqZSF5TKouQyTf3?=
 =?us-ascii?Q?K4yJFnH6EJnDf6+2Si7Kg+ozoYN6yXBOW0pG37zJ9dRNeSyGfqcOrV34XGrs?=
 =?us-ascii?Q?k4evCjQ/vmSJ2+9Ozma2wElml9aWKtlhZlukZ1gdwSDfOIgTqvdbDhSoA5uh?=
 =?us-ascii?Q?EVXnKsvvLBOTIq7+ch31mPNhgYCG2L0XsBsEgo/aXQ6TqHo4McWPxCWH37xX?=
 =?us-ascii?Q?kXz2Y/FEDyayEfj+wyX2zCDwZDCJDUfMlIspIeSwf0KlixcWHZak+IV1byrc?=
 =?us-ascii?Q?10aBgvYimCyqDnCW2KqbmS4rNH218A6qP9o/rENy77S3s0oIy8o8EQYx+IqP?=
 =?us-ascii?Q?nIZWdDffKQfGhruugrbhKfme8KAnYKN6E/4vj+Ong8Z6jZrPUX1xNeaJ5ui3?=
 =?us-ascii?Q?j0nEUWhxwjrTrwETcm3HUi8AVMpQXUzqiYk0pDXnHFUNvJmjYTs/l85RKJHP?=
 =?us-ascii?Q?BUSrTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2t2Sbvc80WoPp40xgJFBhd7nmX3uqXTztqdSm8CvUrWdjuMlpwv16Gx/6xajPhvA36OGuLdsmsYaKC2kJM+Zzcnt/N3tdlvuif2Nhmhd2AHMeD80r8vFCO6PL45ROlKipxcWqwmPjPqi/a9oozNPp1ldYRz/UdN0pUASWYujVEAd9JNcy1pBXlmC1NPeBiljh+777dWsMVQiQhBTwFHVHSHRFlXX9M7aFyDZLylaMGKmZr/CZDsrg4Q0+TkVjMdTJFmN8uRVox5NeZT2keN/4vSMCXWi+HudGGAKxlEgpy7LwXNhL2yxjrWjgcpIcSGh66iglf1/IwXw0NjGApUGX8lu/Ol/h/I+pFA9hVFcWzqEPsW9mKUvVErvL0VOtST4LkZY/qARX3CfFDY5CLwPA61/Sg+ZLgjjO7j1Zj8pXHLt8g7Wf3oRaN91buYqnDv1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:48.3732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647ce77d-1d17-4b82-467a-08de65089601
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257359-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5816AF8393
X-Rspamd-Action: no action

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Answered questions about rules_limit overflow with no changes.

v12:
  - Use and set rule_cnt in virtnet_ethtool_get_all_flows. MST
  - Leave rc uninitiazed at the top of virtnet_get_rxnfc. MST
---
---
 drivers/net/virtio_net.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 155f0ceab006..24e586ff6b14 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -313,6 +313,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				       struct ethtool_rx_flow_spec *fs,
 				       u16 curr_queue_pairs);
 static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info);
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info);
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs);
 
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
@@ -5596,6 +5603,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5637,6 +5666,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6568,6 +6598,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


