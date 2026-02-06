Return-Path: <netdev+bounces-257570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIV9DZ4ChmmyJAQAu9opvQ
	(envelope-from <netdev+bounces-257570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:02:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C817CFF684
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE753014133
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B3273D76;
	Fri,  6 Feb 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ASaA1LEn"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B902701D9;
	Fri,  6 Feb 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390170; cv=fail; b=HoXPslLwOBF4XTfCTGgtIXkT7Ur5uajfA15UTSwhSRSvBXtxZnTMgLE8NEU90T5SzB/1HKWsK4Ex7iY1lFBAdECgzvwFEHGCIHUv2cWDy4AO/H7KEY18ehptrCtrKK/v77hPDhwu4vE6k9L0IU2hF3NLWAyZnFf4ACaVhibJkP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390170; c=relaxed/simple;
	bh=wJXodzYuFYJ6aXKIV5Do/rMt6Q2Gu1aOu8wqn6mw4AU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qlBFqdeTc4nakO0JK7TeETvLtQ4eU4D1G2Jqff7KToWDQOioznC07Ap4DBYh1fNUWc9c1SnfE7TSzzWlQwk+oYCwIaDDInpv8sWiAFJWvfztfoHpvQhCb3KL6L6KNV0pkP5mJc3eYRopz4jaqTNzYn9eYE7toj52dJUUiDEh7V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ASaA1LEn; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTAKp0SOL6J6NODV/Gxz3l6LqiogVFKiJO/I8FeByb1MMI32zdyqgk61fLSA8AX9uBNesK0Kk/RmWB8jjkBoK5CgkHFV4egB/B4orRaCfWm2bfShU68cX+IY1D+/eiDmB3p+TYgNtoDg3NAUllkxDC3TZWImW9kFdU6hRRcIM3joIgjCnZN5gw7R9w4u5DhdRuN/k3IsQC5SyrXsctzqqs/y+75f8Z0xvcp4uKzYvYo6Jz4yhjdixs7HYaxKhf8H8dGBEsgQxkNiRZE+XFnnUqODY4cy0AKaHb52RXxD3ePl6H6tVkN5xOC7aG47L/l+dplJmgRKReiSfYnlI6mvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJXodzYuFYJ6aXKIV5Do/rMt6Q2Gu1aOu8wqn6mw4AU=;
 b=RfsoNpIOFeh9norrr7Sb4+FQYdhmghB+pOIQkAIXBcK6GD9rnFs6mjTcl8aqc+RzTlsOcwO2YddDaFJjW0hgHm30QCreHEB6X97QG3fSWfNCRdeKmnyoXJUX8Qx1LKYJRyc2yEWNg47qED6zJlujckGYH8/3+aKJH0Ws2/U2lodJGGX/dhXtLrqRyNd9q/ooWxIX8oG4EkRiC43Dmjz9v+cLY5R+4SRdTwn+kAcvoOo6yOOPgm0LoQ1l1gT1Wj3vIAHjNPTVE5NQVaWEmoV6BsAb/ta34BDikWPm9bHdc354N8Uxm2VYEqKf57WQxoQVkr7lfTcBItDQNQ3fc+SbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJXodzYuFYJ6aXKIV5Do/rMt6Q2Gu1aOu8wqn6mw4AU=;
 b=ASaA1LEnWoGHrnuiccspFTcJ494hmLL0Db8hI8+hrImD9fdUui589Twas+xlbWFqtzU3nNn4b/dA8dfZjOMLIM52dGalhjGc77D+D+VolPA+vydvYD80AQGVFzDIML98w1TLnEexIdfZAC6qyb1u8KIhN0ID6G9J7UTs7DyEx3/zG7RMMB2ZqvseaKrgdgosAcmsJqE+maDHq1flYtmOF7+g6nbmKd9gYVcdU0w+N1qZ0R7b9dDVXkwOa4IPoX8QJ1RG54jQ+uip3/2mDXC5UH1UYaY+o8xcOAwNYA+DO/4O9dC5Ja0YWenlQ+24e9txyLVaeufZHc/808l6dop9TA==
Received: from SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::28)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 15:02:37 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::68) by SJ0P220CA0018.outlook.office365.com
 (2603:10b6:a03:41b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 15:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 15:02:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:02:08 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:02:02 -0800
References: <20260205220541.2992807-1-kuba@kernel.org>
 <20260205220541.2992807-5-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<donald.hunter@gmail.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 4/9] selftests: net: move gro to lib for HW vs
 SW reuse
Date: Fri, 6 Feb 2026 16:01:47 +0100
In-Reply-To: <20260205220541.2992807-5-kuba@kernel.org>
Message-ID: <87h5rt29w9.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: f014ed23-6dbe-45e4-bfcd-08de6590c39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dtWdaQ4iMTMGz1yyQyuzHwEMb3P8qhQr30cyzpc1WyWhxJ2joCzx+u4PMcKQ?=
 =?us-ascii?Q?edVSHT5gUFHy4KGXF8hxtKSoyAyagKrEgiJEutplZCyANp1SCNy6JQ4pIQoN?=
 =?us-ascii?Q?+1lUfRwHFBb3NZ9GW9fEANYzf0LLHNiJ/qGM5egO6JZHTbRtfcoZEZvjGIJ7?=
 =?us-ascii?Q?6cZBIne+cIxXl70l5LghRyoztBiXzG3H0eftQXxnc2o4nSYabghoq/W9SpSw?=
 =?us-ascii?Q?+INYG1tvHPmxtS6+3HjDdSV6OFi9VDBDl5HSTnrpmDPkSRGBSmQBm2+gZOQ4?=
 =?us-ascii?Q?doMKXOfssagTSJreIjdPIcOdmJAoyHhd9rtKWqBO6Uydn6xDgIkA0JJnQo+Z?=
 =?us-ascii?Q?ZsgrlQavIxpcRUhWVk15u0F4dvGnRwbQLeUNdwFOU71KfkVbyaJoELRvDl/n?=
 =?us-ascii?Q?k+CbDmLSuWXQe4h41kD5zhukZLloW/DHMSj1kCJ9+ZCVJm8NbY484ib3THZ6?=
 =?us-ascii?Q?Q88U3VPhTDyJpdWboZsfy2KCKf6/wtSJ3EmQjTPH9MtMOr0GAzY4JOnVu8+m?=
 =?us-ascii?Q?sHBiSg4SxEP8ibqJwY+UXw7HHcyr+XIfgF8E4RhtaalwbFrhd9jYfCNIIL2H?=
 =?us-ascii?Q?I4bM31SPEvuOquUoNpgpfyZhQCjYQKl3itZvE7356qSQVJEeh2qP3aJmve4x?=
 =?us-ascii?Q?DXAxKj/S+4S+1yGLuK/6CZr59oss3wHlPYH14oyNAYVl/8pGe/2SwleAlFJC?=
 =?us-ascii?Q?gQPPxLfEDFZ+5kb4UajNJeZdXLOPhg2W884MXkxB5SbS84li4zeTALUmNMm3?=
 =?us-ascii?Q?oFPE4h6Ani9aX0ImzGfPkLBCtDE11WeiTJ8aDNen7lLZHzLvXsGIFXTnx9g5?=
 =?us-ascii?Q?/hAUnH1mvwmx8KyWqP5U9iMd37vb+FXKKfP5/tdEti+KqgxV31/cw8+m5xdg?=
 =?us-ascii?Q?V8FMQA0kBKLjdO6M3TFHODz/ccYi8uTgCzT7nE3Wl45V+RTOWBcru9qv5ZDR?=
 =?us-ascii?Q?h9lZcFMzl+eBoXMzLNS5JIXF6K6eyrK6bZXO7ATM91Dp6tMPO9d/PiJtj7uX?=
 =?us-ascii?Q?/T9/4FchMc6DEoJScSwfpKfZtuD3ft/EHduTCD5hVj9/hbTGqeNXCH4Zg9nT?=
 =?us-ascii?Q?xJ7MqazvY1iU5HxR4IduuTV2dYfTvorkwWjshXYtQo0SFGcHMnqz42qUHt8a?=
 =?us-ascii?Q?cTaTuG0N0wAfhtu1Usr0LyWjugp9U/HWByHfYXTbkocgiWoeks/Buf4NuRBz?=
 =?us-ascii?Q?Zr4BTpxIC2XI3a2mXMQFpphUjkTA2g453WJCk7FAR3xmW58mxBboqnCD57TU?=
 =?us-ascii?Q?PA6ndANU0vtDVhbMiA1V93NFDzi1B4T+6SEPdDsrwz4ln8Ek26ClADZ8LL7p?=
 =?us-ascii?Q?sV/x8ZDKG/UOPnKKpYcd3Y2b7cRtPyv4azSCkXY/ckrKZTtsJ8xU++Vaz0oM?=
 =?us-ascii?Q?HaxHDKdbh9prIvRFGp+avLWjSkRkESrRd65DCnD/oaDmSmaue/M5WOeDfe27?=
 =?us-ascii?Q?gPAxoasyg+DC7QlQpHUSW5tleifpW4o/JWImGislsa5cV/K+W3JI/S8vpW/E?=
 =?us-ascii?Q?awazq0HBM0grNjNUiMHmscICD05TLd4+jRioK7FlUfSFsLObhEhqRQpxC+qo?=
 =?us-ascii?Q?BJ8Dy/UNMCnP3Ix4D8DR/eAytBOcT3k7gdZBGyNFyu/bforjeCATyrGuSG0m?=
 =?us-ascii?Q?+LseGMIK9fYUqtgiwuMyfnDw6f39E/KNnNpprdzR4f+7ZjciA7223aiK2EFR?=
 =?us-ascii?Q?btUn7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sJpRlrhmnLXuWqFzEL9p4+QvMZA2gtV/jYCd872vKYKvKxjHnDTdT5H2j0mdMgLFCtSt9pDLqXEx8JHaSzaeDZS4KzAPlHoXQW0Agan7jSRl7k3pHOqd0J3A3VRrMQ7h9fuWmb2wV5LG5RhAOw5eX2fiXCYdJQyrELQtSSmf9I1qWYQHMOrnllvouESCK20xvMVeNfYb6O8qd09xdLQKB2o+sI8OT59PABMxtrpZqiIJ+YhMwImy9i4YYBX+ihqC2jUmuX6+b5HhQuJJFmtB4GAYSAzfE3iEcNBu+ZddtqZijEgXosxWlG1Gblab64tq+LkxgUL1wT1Sz4PlnjzVRFrvfphfBY089+gyB6J2OyWJtv879+FFCWVRDiNAxZhdSvZe1aoGZ2oW7is62/t3Pgwot7lfYrTWNJPYapcvc/nXf52QmdACOmUYPviSz1G7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:02:36.3490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f014ed23-6dbe-45e4-bfcd-08de6590c39f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257570-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C817CFF684
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> The gro.c packet sender is used for SW testing but bulk of incoming
> new tests will be HW-specific. So it's better to put them under
> drivers/net/hw/, to avoid tip-toeing around netdevsim. Move gro.c
> to lib so we can reuse it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

