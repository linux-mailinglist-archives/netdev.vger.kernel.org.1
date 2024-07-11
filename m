Return-Path: <netdev+bounces-110867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBD92EAAE
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 16:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68E3B20A02
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF9815ECCA;
	Thu, 11 Jul 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+RJEFiD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23483502A9;
	Thu, 11 Jul 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707863; cv=fail; b=a/DxiCpOoVxOsBTJ+Squ44p1OaLp4NVr1mqAhvX16M8RalWAVRAfSbGeLzUeVOAu0e6va0KzOJ+hx5KWD30PbLJUB5hiw6hW5In4eihOEnLHksW7Q/HVYziMyyy9sOMZW+nEP92uzpptTu3YFKTZM4lJEWha6hXTAEAiuKX77NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707863; c=relaxed/simple;
	bh=mX13EynGUtD6nTXRkjibDs0/ovN750mmPMPg3al7i6g=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VF8tphj++0Ml/5YTNBWsKMIqgXxCzzzDbqGDaps6imJFKYx3wYrPpHTDbceabbHSG0Dje0J/LzARU9gK+tIXJfm9KSWM2p0yeVYlSqLGx31tArUOhOukhpchtFPO221Lk9+4gqbrxeOm1CdkcKM1E+ScZZrFcxm461yuzUC+HDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+RJEFiD; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUJ4UehRDa3xqSwJWvq7pOw4G5RIKZzZn5au57RRCB41/dHnk/DJh9AvHr+MqS9uXvwqtFwxVZ1yxFfVIN4f+VZsRJ9Y1eiQvbpMyqEG0+uqPPcTtIEj9idPIG1vehbSw76GS34mvWhypxFl1smmRhD4rdc7WqVsLGOuUws3tux+QzPFd3J17ExgTxR+WTTx+439oQpaz0QJLWLQMOc1LKqhfTxGdDcm0avcCIG3GA+ChkOEMWbKd9WYgA+oSXZPoI2rhRYrZ9C22XbT0+XkbfRP48oWj92F2Zy2JGE3xYiGGMYQ17ukGYa7aMRKLViCH87s4pyWsZ/wob+OdUh/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX13EynGUtD6nTXRkjibDs0/ovN750mmPMPg3al7i6g=;
 b=UqFkyHX7wn7qXp5rD2Q08vld4ZfcDKxlMyca9gAqsWl/oqXRV1tAJmEgEwTQfOVuYWK9WVn2Kjjd0oFkGz9Cn+Q08a1OiwTSpHy07FNjvE4aqStT/oBZaxxxWVjvSfrp1/NymaH349vJYhvPgSL9jv8ms/08JgdJmV59Gl1+9J/Q1afAFYBKo0AJMnNjn4YfjK1Mua2L3KFVVJ0qPYw7f2TxgGsOuCCfO/K2P5ul2SX4vCgCk6XpBYEkFqalewqCajn2IZuYqthQsVXnbEOtNCrBNHf2wxxQArPKWHGvTn7tsaud9l9ve9WPkTWGzCIAw2yPLKQldL6m9cF8iZ56lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX13EynGUtD6nTXRkjibDs0/ovN750mmPMPg3al7i6g=;
 b=D+RJEFiDQNdbTgUaWnnG/vMetMKZeND6Vxlp0mStjL5A5+N949XzAT/kh0gp1wwaaelojJM+Iqqoq3wfIpFK55cH+Ove4zwdaV+0aD3kIyhuvd2rRjoVw7MaVnNC0Ed/QG1U18KGsjVaAjXSFTftAw6R9q7wNXT3usJw1vxuNYtHz2EKbdm4XkEfWmK3SwiPAsTLRqaTsnl4I6pw1a4hywKLxOFY3sVHzzlmT/V98AL4xUETanVBM6qVWTyFkU++sPsWnGEsruqdqXPrIXFXM7gIsynU+ZTw0FOkRBx7SOGb5afxpr0uL8xOhXUAi5yAdnapiB09BnyBRBjkm+8YBg==
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 14:24:11 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::7e) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Thu, 11 Jul 2024 14:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 14:24:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 07:23:57 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 07:23:52 -0700
References: <20240711080934.2071869-1-danieller@nvidia.com>
 <878qy8rpeq.fsf@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Danielle Ratson <danieller@nvidia.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <ecree.xilinx@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ethtool: Monotonically increase the
 message sequence number
Date: Thu, 11 Jul 2024 16:23:13 +0200
In-Reply-To: <878qy8rpeq.fsf@nvidia.com>
Message-ID: <874j8wror4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfee56b-2870-4ce0-bbc3-08dca1b5223a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtidSYi/qvihGuw3PiKBrYbGe8CuM1pJv6rSAmb9KDIQ+AVBq5K/3DEANIzO?=
 =?us-ascii?Q?2LpxbVpMWaOgIE0LTp9pz+bRQJ4Vp0onFZ7hsaq9CCMYPg2/GjrGOnFzhhmS?=
 =?us-ascii?Q?o/gtiH+D9tHtkWFLMkIbWwPEyZDSr29caGgbI9PMgp68bB8yXPX84lMxdNGd?=
 =?us-ascii?Q?OVzpIAtGCMMtLMvLplS+CvbrYcGWZnodolyibSlrmw2qloFoRwatkgsaNUmr?=
 =?us-ascii?Q?W2CWhHyRmNyZHlluKN7JNAQsvFYsAbpxk5IaA8lJagfQy9WWqauouKefJyZC?=
 =?us-ascii?Q?g+8XUCpU+Fg6YMzUE3pD7qD2UCnQshR6WZBneFDpwk7KCNqkQ3d/OkHE2vG3?=
 =?us-ascii?Q?qf2ekvw3A1Q3Nq0Z0t1zezCICokpqz97rpi9pQq7AaWNMsQaWv0qniIHtABc?=
 =?us-ascii?Q?S20N8uhO/JmBIhCaIuVVMbeAmCHPd6FVqOK83cVoUIecHts/Xa7RXQyGK1en?=
 =?us-ascii?Q?rr88l3u/TRTyKrsjP3Gbc6aZKBIrdz+T7m2jfejtSSH83AtNfYKXH+MKFJTE?=
 =?us-ascii?Q?+NnjTqv/wdbi/Ou1POdY0CDhUxbUolZMu81TkDxv4PfaPqfXC+LiAdNe9daj?=
 =?us-ascii?Q?Yuq52p2MhPjE8fj3AqGjLqhR/neCUPfMBuFM1F4ZitN8/t2Isjg5ECg0btCw?=
 =?us-ascii?Q?miHnENQQ+LzIfQAe5awE/YC+g3kTFHoleMuzWEIHsNrq8VD0JgVKV2n0zyH5?=
 =?us-ascii?Q?5aU3bNuzcYKNvS1Rd6jArRwToIghTgl2BEVQN3fnFuKiShpGgnhqcm8Ak4Gm?=
 =?us-ascii?Q?KGPmtYGVO/acwvMjNkZXV0CknK69L0q0PSKbRRJydD13uvpTNGy0quXbZRlU?=
 =?us-ascii?Q?S3QSbEn6fISODghbxdQyt/H1eZaE+OTpFmAGp4FKbDB7gWXZE4q6AvBrbQAC?=
 =?us-ascii?Q?TYH60VwgyxWrlIkGzU46ein+0giyFJYRGvD6VTDgrwBQtqf3dH9GvP88GXB4?=
 =?us-ascii?Q?uz5auxvRmRF5wwhkVSYS+rfU/qKNt4pvcMie0UEDrDLYnqMP07r786PERGOl?=
 =?us-ascii?Q?eGwDzgZx8VWQI9NUG6uYA21COEftGEK1UeSJoGPP+74m/VyheuEwSL6kDhLu?=
 =?us-ascii?Q?Z+CCrrEsUpHdVYOMuO/ZJssHsZeEzq5OZB+hIcOCFvn8f5TpscaNqKV/XXGX?=
 =?us-ascii?Q?XmTm5CB1/JjWgje6G3j30R4OSaG2++UTdifouFvCmcb4ogVd/rwU7E9th2PQ?=
 =?us-ascii?Q?zxac4O2ZkqoiqptSjt+UA7aYgqaGztS+ieE0KvtWtBl8WqHjFJkhRkI59LDF?=
 =?us-ascii?Q?H+Xv5Otxyr+h155xJUEv3UvVf/tnlScPRbfqa+5oZJnvvKwEQncWKVEW2O3E?=
 =?us-ascii?Q?fOcI6Qnc8ueVRujDbRzWBS3QT6x0maUcKu1f3tanRupTm+hTAG54Xy/PUrir?=
 =?us-ascii?Q?EE9Jp5rjdOPU/eZTWYwoqlz1x1NJGjIs1nE3EhbRc03Z0FhF891o4KqKekrR?=
 =?us-ascii?Q?bOB8DSGFA3vMvjcntfHEF28ignpwPWdj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:24:11.5038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfee56b-2870-4ce0-bbc3-08dca1b5223a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194


Petr Machata <petrm@nvidia.com> writes:

> Danielle Ratson <danieller@nvidia.com> writes:
>
>> Currently, during the module firmware flashing process, unicast
>> notifications are sent from the kernel using the same sequence number,
>> making it impossible for user space to track missed notifications.
>>
>> Monotonically increase the message sequence number, so the order of
>> notifications could be tracked effectively.
>>
>> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
>> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> Applied, thanks.

Oops, never mind, I was talking about our internal queue and the reply
shouldn't have gone public.

