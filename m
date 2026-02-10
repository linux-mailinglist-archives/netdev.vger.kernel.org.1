Return-Path: <netdev+bounces-258101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BLHLHZFi2mfRwAAu9opvQ
	(envelope-from <netdev+bounces-258101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:49:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A011C0F3
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 006753050922
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AF530AD10;
	Tue, 10 Feb 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AkCXvD1x"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB330C371
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734923; cv=fail; b=rOCDxSH7XgvXuo67ssChKM+XcXBykJSQ2vVz5m2MlQMtP626QX4z5X5b017v1uX4s33srhmU4vOFyo6igPR3EL/Uw/PwquI5J33Shu5ZG83OpH/qR+36E61v4wUd0Rq+pMBi4mNlozgl3y3sGxpGaeZo8cTMZLE53NxeL4SjZSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734923; c=relaxed/simple;
	bh=+pG73qOyGXU/5EWFffw3nIg9Pdh3YGDKaMtMmFzuoCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YoeNvmw3tq6KwpC2kewv9e4XEtKzcx7a1wqY1lqo31O0iEYBgOXeZ02s374rQ5KEO5k70SlRLY7X7qjgnH4C1bq7Pu6xlWwI0KXesAMCG4RRAZb/uVfVzPUoiVUIGxvWu/B01OxfWZetZkLYy/hoqOgb3ENTYTT9XVhFxudiToQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AkCXvD1x; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7uI09IiGdBzVWocQUrWJd2j1bd0P9NzKKNvB6pjH/47te2l/KbZthBtnX3xUJCZ5+CTZe1gfEwQNbVlk9GJJAxNLaGGHr3FiaUFFMMVOcP8sKKTkvgNh1OoqboS47bebuaR75iPd6U/M63yGPAzGY86IvLSnOpKKdizlRI3HILtWZ+5GA/ulnYl+tVndoM+swTfQfGX/S7Q6xm6Z9CmPNSDw7eHA7Xg7pPuAkNw0hunDsuItTyK8r9q6POweIyOEItq26lZTZ+z14yPIB+PyRDJV+2JewRUS05zxiVw5sCCarpfrXIRSD64aXpKb9/xYngF9wX5TZKFSCrPsvzPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u0+v1LdLWP5l1QbDw8Iwh+K7TLy3ZoPQMdxjHiOCWY=;
 b=fw8BdDRBhVBsHs0tB86ZaPoWcVRedioS0AlnhWP3DI7G6zGOHU3kK5LNX4P+mNGNoZKDa1xMfL8Hl37EZEhjm/x3IZsLdjMt2tfAvVzQ1sxElWa2MYbEFkptaN4aB68s4nYScxLqw4bWfWRMuLhKJc9Xb3DkQoj+AyTyaQpMQOQ91bRGTeijUHmibv8L1NjdIvI5kB4N+ipnWxzET5C80nueyu3DJcOezHxLQOHRdXLafH2bqqx4xX5pH58s8ysKt+FUvErUj/MAEupmUqqpqDM4dVLU+zTP17w/N/4BdBT/1G4ou8+UR4meFa9i7PJx1PPIsbNItovdQu/Zpoo7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u0+v1LdLWP5l1QbDw8Iwh+K7TLy3ZoPQMdxjHiOCWY=;
 b=AkCXvD1xFa45uWtya2sIsY4NezjttAW+qIOJgtM7Dj6nQMJTg2sLWhktmn6+d4PTSEl9t+MfAEeCYsF8kJzaZBL8mz2uacR4VHxu075DcPiQhttbYjhphkFNq03OvhCcTeHKMRx7uCXJg/ter/MsEkJrpPoK9HMHiF+byuW7FGJ+r5UPZXM3PzCDotkFHC/rDcY168cvbZFbQcn1J0G8gAmkolz9ov5xaI3Z+vr3PK0OQiibXMsJoUHZOEDqEZgmtlcjSo9Sa8cJYGmbjGz9kGNfqPQkT+huNx8ft7/Okg9ApAikMZBjDIGbqdwBgLCy7cF8axo3d4KZVAd+mGTNEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:48:38 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 14:48:38 +0000
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@nvidia.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCH net 2/2] selftests: forwarding: bridge_mdb_max: add tests for mdb_n_entries warning
Date: Tue, 10 Feb 2026 16:48:12 +0200
Message-ID: <20260210144812.1056554-3-nikolay@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210144812.1056554-1-nikolay@nvidia.com>
References: <20260210144812.1056554-1-nikolay@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::28) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 705c7f57-d728-4ae0-82d3-08de68b379ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WhHFtUB5SNHkoXg9c0KTdrpZllU8oiG5pbEMyhjfB4EVDuzkPCArz4k7VGVF?=
 =?us-ascii?Q?Xnv7SWQ0FrJ7huz1lN0uZIq5SsVfqXTKF9J3BOE3G1ANO3XE3ZNXM+6ONspM?=
 =?us-ascii?Q?9W+fVs7VFU3gMRT5Xwv9B/9HIZU672jM2ZU/xDTpGMkQBAhDeVpnZCqf7hFf?=
 =?us-ascii?Q?FQxbNBhC/E5GnmJ/idJJr46GU9Jcg55Y8PzIEsCb4NADthP04DxdkGp81BLP?=
 =?us-ascii?Q?70fzjt+qr5kjbro6JCWpYnNgZTrhsQkLGWWi3bbnWQEL46mxfAICHwOKvw93?=
 =?us-ascii?Q?+BuA31BqFE+bGiPkrKdbcLjuvpwRagY9iIxftJ2kDeXtf1wlLIqrTneb9tg4?=
 =?us-ascii?Q?86xmWoorpafawtvLvjxV3wR84ZgdLEbw10yG78opNSYPlWA+6WwbhgbABkdj?=
 =?us-ascii?Q?9De0Yrehdpqz+OweHhl5edQ43VjIE1yovD/of6VysaI3yEYMZftQ6hlrGA8r?=
 =?us-ascii?Q?57XwZcGo0/X4y56jSB1x2Q60wSmr4P9QPMwAM7nX+UxpjHvplQBJPN2MvAL2?=
 =?us-ascii?Q?BRbSXwK3s9u8ilycAn50mDyiGTyVpWDlmLRH3uOJswgLw5sa+leN9a9w8bZC?=
 =?us-ascii?Q?Vngxslqc4Euseq9eZwoEzgDXbGzwILPzu8RY6ExhUJeCuUsw/F8QZPQChKOG?=
 =?us-ascii?Q?pONujud5+Sc4BifZIvqIB+83psDOLgojT/xjLvRPiUg6KiuBafMCBoofm6dq?=
 =?us-ascii?Q?xL+xfrvt5MgN7MkXMf/5QjOOBaKe7cbuLqfk/LinxTGfGJBElzhKAVNuV7Df?=
 =?us-ascii?Q?ipOVSRW19bqvIFAptze9J/O7npi+JJVzD2+paSEMSCULW3zTyVxxX11BtZRy?=
 =?us-ascii?Q?WrNt8fhKKTmjh6I6h3vDV+zHoxZxNmX1OSDow9PQLh9pxMNZ6EjhuYh35aqW?=
 =?us-ascii?Q?seA3R7sJs16IFPE2Vbmi0Jv3Prhg0ax1+fqMO8u81dzHrFVGBoClRWYwyx1o?=
 =?us-ascii?Q?d5G0eRZ4EMfhAfmTMZO+2B2sxdBdc+drlaOZzp9QqE60Z0E5zOhTI99uj2xd?=
 =?us-ascii?Q?gxj+LndiD4Lx42oCtsr+LKaOPVcfNzbGRrLbqfRQRREWlMpqQNFKAZUFsCiu?=
 =?us-ascii?Q?C0WiHdCJlcqudKwiarpQcbI14WhMDPKlpbIwdkXDA7NYVQXPIPYGm3pbT9HC?=
 =?us-ascii?Q?0Q1QyWKs+q3z9szucHSrtFgiIT3dkfKXMeMfqPREnW7jCFsyZzNXAZdNXZSO?=
 =?us-ascii?Q?cyHeD5U7sFARlcfM0ctAIEjI/1YEfZKy61GsKyaiLv04WG8M4XCvqsf6SpAj?=
 =?us-ascii?Q?k3PUSFsQ8XU15pnTl/hyn7JsJrEQ9GqfWI9xzC3iQGPDO9uvMrkRYcWOzb8f?=
 =?us-ascii?Q?Em+LFTnV3E49aY0KG0/BF+BQJRUBrLjxsMEwyd5L+7oDlp9v/+U4gMfPZnXs?=
 =?us-ascii?Q?iQ+IqUqazx+NRy86J/X5982E5xhj1GjRX1jHRbTS+0qbf+Tf8dltj4oUDdW0?=
 =?us-ascii?Q?IGHVBsMPc1mCpZDzu0W4XSfx26EbD0RoFsvwJG465pth2GU0J/Qvye6RTbss?=
 =?us-ascii?Q?e5v1zrc1l/67GlihUtzo/hSRCDyD9nOJohrXvDCvG0sdbQ/We//D4TYA8C8+?=
 =?us-ascii?Q?AzczaGSqmdSMttVDvnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8gEsPU1HHDvxFBnFy2W3juEnaGiv6EJ/NPkOXVXS8H47wETQIpHYivqJ2zR?=
 =?us-ascii?Q?RnQ5joCBm8VE4k+Ryibxz9WL820CKgGpUSZtrajNEtVOPIgNLsNnuQLCqgSR?=
 =?us-ascii?Q?sjN689EEmXgVpojncLX6gi/YnszgJvqwEDNkT7yldkouw7B+3ythqd56FaSb?=
 =?us-ascii?Q?aqXicEgrPLTrl09eDXC2/M5YhJYRxkDcP1ajgi9JdEuDByCxhYgN2uo1eDOn?=
 =?us-ascii?Q?7wNRjE58DXXK5ZGmf9N+HxY+3fCUOjYANYCIs+b6sS30+ASgTP1yxc8dBGtQ?=
 =?us-ascii?Q?+wop0Qj9CnUQwUJ0DFZPY/Jzdn/+bJQxGVNYLQnqdyi6Z7l53WrWuF5XNIHb?=
 =?us-ascii?Q?WHYnPBrsorXnhcFwA50RLEeRQBFKD4AylF7r/X0IQGmMLr+H31dLzbF90Ils?=
 =?us-ascii?Q?gFEc4Bkfg8Tt1lvjI7RXm98SRhorGZe2XK/UBP5F5ULEcpLFfcCEKDD0rB/m?=
 =?us-ascii?Q?TXVanlWJYc5kqYWbzdZhw8eU2j2Q4IOKpW5EAauoO7NYbwZSX+ug6857v/eW?=
 =?us-ascii?Q?QLik8p4CYmUfe4y5lYmm5bSjOKN/NSdoAN5oYeqeSkp7071k10qwhwkhhWha?=
 =?us-ascii?Q?yXynxmtDeweA9gUTgba2wnlSW4T8NMyxvnatpfXySnhaEC94qFy5nFUxVqVD?=
 =?us-ascii?Q?KuWSfMRqdkOSPBCJ9iUflPCx6edu4yF9N7VP5IU7Bj0lkp+GXlCpPxB5C4rf?=
 =?us-ascii?Q?ZKmzCgtbA4Nhg//vxF3u+fSWRZ9dH2gRZuP7VgAq+BEVVHr//j3rrPYsyFOX?=
 =?us-ascii?Q?mYHy/fywy3ABcnCw4CmOgeBpAIloodcVW+m/ipanYrbEelJhgEK2tUo3t3l9?=
 =?us-ascii?Q?/22fZQeyojU0xNoitpqkWj1jmX2+mEE+beZbAhG//QCzHihdvQkaL5sOP9mM?=
 =?us-ascii?Q?LHhhl4moTkJtt+e6D0uHl3BvJqxaWzYtM731DOtwd7G1h8mvWliT+VgjLgwI?=
 =?us-ascii?Q?f5FhNSSqonxG/8ATP8YAPupBRngHrVWmODdrlrfL4Fn9UhxSCAG52RUFr8uY?=
 =?us-ascii?Q?pl/lQrfP4/1gYLpdH9lQTiVnJltNZQpJMFjnMHoc38/oDnpqwNOvZ7m9ARRR?=
 =?us-ascii?Q?dyeLXNMje3TEalWahBdkszJaqEdsFEuQP2UHh7CChRdEtLU78yCMRZAgmGJV?=
 =?us-ascii?Q?Z6P3y9pigKMV7ywpoXrPZt2AfoBA/tSo1T6RUvqXWaSNvz0c0+yTiTMn7rP/?=
 =?us-ascii?Q?jzpgwO2rsbp7OyiNW//OoJEbsBM1J3EnYjHBBKGJG/82idpO7YMRR0rEgeGf?=
 =?us-ascii?Q?nEIp0UAmxdemY98jTDYUHfGNkqe8exa4MNWMNQsYR3D6bO0N84d/oBTOJZZb?=
 =?us-ascii?Q?/S/6H7lpYlWILF46gXFXXK/qoej3NUJrQocvqERhoKvtHQRxwZ47vvXOdj5h?=
 =?us-ascii?Q?V55Dnxt+Bf5hfHKu+YOYVmPSf9khd32kTG+l99cmGdxHSju8+MO6yIxUJ3md?=
 =?us-ascii?Q?RD8IeBCZeUvJrFiOHzT851EkehVh0Ibd3BufkP2ZEy+WnVPTc7zFMVKxxrA8?=
 =?us-ascii?Q?mfYidResHYnyhuJlZWHUxKgsRsbnhN/Kj7LUwLRnpzHjIjr/1bdZPvc4ZX6w?=
 =?us-ascii?Q?Sns6dyIPIUTvWKInmmnXe3lWLJmarszXN79ELiG3hnFO55uEDwyfCGt0poZX?=
 =?us-ascii?Q?LSKIVrRaYWcxOxooHQlx4X8aQOen+L5tzRz0z+DLlXk5b0XnBg1wVUvplvFU?=
 =?us-ascii?Q?J+G02zWER9o+fsBGY1JRR4Fuein00ovOMMnz2xBdQDLmHmNUxynLUvIWASFL?=
 =?us-ascii?Q?yvv2x6axTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705c7f57-d728-4ae0-82d3-08de68b379ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:48:38.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnMzDjXIRqAL5f82NzoAsSXSO4vawhYOC7WN0mzAWzEVqjQmGAFrz20cHg+kVnJZ7yuktLdE2LwssaO4GM5FwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258101-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 3B1A011C0F3
X-Rspamd-Action: no action

Recently we were able to trigger a warning in the mdb_n_entries counting
code. Add tests that exercise different ways which used to trigger that
warning.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_mdb_max.sh          | 90 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index 3da9d93ab36f..cf7a2d43a81a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -28,6 +28,7 @@ ALL_TESTS="
 	test_8021d
 	test_8021q
 	test_8021qvs
+	test_mdb_count_warning
 "
 
 NUM_NETIFS=4
@@ -83,8 +84,6 @@ switch_create_8021q()
 {
 	local br_flags=$1; shift
 
-	log_info "802.1q $br_flags${br_flags:+ }tests"
-
 	ip link add name br0 type bridge vlan_filtering 1 vlan_default_pvid 0 \
 		mcast_snooping 1 $br_flags \
 		mcast_igmp_version 3 mcast_mld_version 2
@@ -106,6 +105,7 @@ switch_create_8021q()
 
 switch_create_8021qvs()
 {
+	log_info "802.1q mcast_vlan_snoopping 1 tests"
 	switch_create_8021q "mcast_vlan_snooping 1"
 	bridge vlan global set dev br0 vid 10 mcast_igmp_version 3
 	bridge vlan global set dev br0 vid 10 mcast_mld_version 2
@@ -1272,6 +1272,76 @@ test_8021qvs_toggle_vlan_snooping()
 	test_toggle_vlan_snooping_permanent
 }
 
+mdb_count_check_warn()
+{
+	local msg=$1; shift
+
+	dmesg | grep -q "WARNING:.*br_multicast_port_ngroups_dec.*"
+	check_fail $? "$msg"
+}
+
+test_mdb_count_mcast_vlan_snooping_flush()
+{
+	RET=0
+
+	# check if we already have a warning
+	mdb_count_check_warn "Check MDB entries count warning before test"
+
+	bridge mdb add dev br0 port "$swp1" grp 239.0.0.1 permanent vid 10
+	ip link set dev br0 down
+	ip link set dev br0 type bridge mcast_vlan_snooping 1
+	bridge mdb flush dev br0
+
+	mdb_count_check_warn "Check MDB entries count warning after test"
+
+	ip link set dev br0 type bridge mcast_vlan_snooping 0
+	ip link set dev br0 up
+
+	log_test "MDB count warning: mcast_vlan_snooping and MDB flush"
+}
+
+test_mdb_count_mcast_snooping_flush()
+{
+	RET=0
+
+	# check if we already have a warning
+	mdb_count_check_warn "Check MDB entries count warning before test"
+
+	bridge mdb add dev br0 port "$swp1" grp 239.0.0.1 permanent vid 10
+	ip link set dev br0 type bridge mcast_snooping 0
+	ip link set dev br0 type bridge mcast_vlan_snooping 1
+	bridge mdb flush dev br0
+
+	mdb_count_check_warn "Check MDB entries count warning after test"
+
+	ip link set dev br0 type bridge mcast_vlan_snooping 0
+	ip link set dev br0 type bridge mcast_snooping 1
+
+	log_test "MDB count warning: mcast_snooping and MDB flush"
+}
+
+test_mdb_count_vlan_state_flush()
+{
+	RET=0
+
+	# check if we already have a warning
+	mdb_count_check_warn "Check MDB entries count warning before test"
+
+	bridge mdb add dev br0 port "$swp1" grp 239.0.0.1 permanent vid 10
+	ip link set dev br0 down
+	bridge vlan set vid 10 dev "$swp1" state blocking
+	ip link set dev br0 type bridge mcast_vlan_snooping 1
+	ip link set dev br0 up
+	bridge mdb flush dev br0
+
+	mdb_count_check_warn "Check MDB entries count warning after test"
+
+	bridge vlan set vid 10 dev "$swp1" state forwarding
+	ip link set dev br0 type bridge mcast_vlan_snooping 0
+
+	log_test "MDB count warning: disabled vlan state and MDB flush"
+}
+
 # test groups
 
 test_8021d()
@@ -1297,6 +1367,7 @@ test_8021q()
 {
 	# Tests for vlan_filtering 1 mcast_vlan_snooping 0.
 
+	log_info "802.1q tests"
 	switch_create_8021q
 	setup_wait
 
@@ -1334,6 +1405,21 @@ test_8021qvs()
 	switch_destroy
 }
 
+test_mdb_count_warning()
+{
+	# Tests for mdb_n_count warning
+
+	log_info "MDB count warning tests"
+	switch_create_8021q
+	setup_wait
+
+	test_mdb_count_mcast_vlan_snooping_flush
+	test_mdb_count_mcast_snooping_flush
+	test_mdb_count_vlan_state_flush
+
+	switch_destroy
+}
+
 if ! bridge link help 2>&1 | grep -q "mcast_max_groups"; then
 	echo "SKIP: iproute2 too old, missing bridge \"mcast_max_groups\" support"
 	exit $ksft_skip
-- 
2.47.3


