Return-Path: <netdev+bounces-252238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOCeJFnbcWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:10:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FAC62DBE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 850B74E77CF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89948122B;
	Thu, 22 Jan 2026 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PudwYNbE"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F06480329;
	Thu, 22 Jan 2026 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068857; cv=fail; b=iTLwrQQin0Tv3kYQMo2mMGHnBDoL3MJWbl2licdwGqJfMxDiwNg015DK5qiFf/HyObvfjOOuZ6ITj5egQLKVgB918OyNb04OsySnNTJMGPyfXafVmhUOavcPlaOQdeX9XSZ/HfFHP4Xciln/keTP30BDdzlC4kDuwzAAKDnS6Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068857; c=relaxed/simple;
	bh=t22JV5dEnAzysbx+QZvbAJFCmJ8OpFwaYT9+B+HtgFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DujuWBTbSL6D2JKEKb+Gq3QKm7pMrFzQLXjjpX6rPBm0qG73UKes/zNF9ucaYi1dhrokWb+QupFbxrPuJGalNTtb0Q4vboI75JhILorY6FvzS7tqshyD79bLDcVvFAF9bjRT7u8+0cxMQRTgbpPD4m690HmZNXvvRlNbid0AZUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PudwYNbE; arc=fail smtp.client-ip=40.107.200.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN7Pwas2r2YqCtmFWKdaSQ1bu7ikcGus9S4ECAIamsA1EprwckuWDThQ+i6xWrDrFVoo/9Qjzn0ya7D+4+402qkCe0f7a5u6xKGZEJHh9ZtFDlt3rxva0Kyzea8Ve4pHDvvXwHA66wJQrtrLCdthl2HFHNRyruym20upWIJsDiL4R6l18UaWGWyhBNfUKBsC3+0B/z7K9ouDGX1Up6ut1q0TIbZTRjH3QntqS8F13tyTuLjjK44unZN01HrecHI7C1Bw9zK4ilaBzTM4pTaPd6/2N+BK78GWXp7KW+tlhhulU9QpK8eV40O4DjaHi5/fIihjY5dH+PY2Yx2PeqConw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t22JV5dEnAzysbx+QZvbAJFCmJ8OpFwaYT9+B+HtgFo=;
 b=Ruh9VWGGoO5xsX7AxQ74ROM6zNemUAW+DiZp5AkQZcJB7Pk1C9hjw1Snc9jKd8vfHmbSb6umTzUx1iKjofaaM4KVg2CqzlcKncYekTWw/dAoBAFcmMZ6dhQZwa0UJ/I0ikzdVLz/s+yWGgkS4M5mq3HsBGZFeXTfByNije2g4kWY1q7WHt96n9Bzx2gM7irKItTGHvMerfo6OvJYWULhfs6w6m8goeqqTt02rVjpb/DLda9i4vlNeKYOx0f+IZ8yTnufemtLOlJIpbuBYO8b9ae2SxbMgR3Y6397mpzE/WP/uHdHbfKYvSrbVij/M9doACqDXFUf4ppKf90FRqc7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t22JV5dEnAzysbx+QZvbAJFCmJ8OpFwaYT9+B+HtgFo=;
 b=PudwYNbEwqui6r3uW0OZy/OwGlNglx5U3fPrfnaz6CnexME7OoV4sKmFFTBap8AFeD3GCrLUo6D1pnR9EetxTKobJE9p3QjdXvHxkT77A1wxImAGWYqcx+WpeqC3k0zMe3RleWln4Ho+iSOXz14F6sC57bji1HZ0MHrwWXC+yHLBOm53Own3QbwWdx99Cf6hcZDN+ZTlLSyCdxExha4G9wLsuy/BXJ+HYOtd1HEABg/2C125QvbRRZrEPeD8cNkCVgAcu7U8XPFjpTgxb9TxuUmfv1LBXU5xWdH+MZl8aFGlTpy1A1hRBL/YRBGLIg/2byilEY81EtOomKb6yJ7WSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 08:00:52 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 08:00:52 +0000
Date: Thu, 22 Jan 2026 10:00:43 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 0/4] u64_stats: Introduce u64_stats_copy()
Message-ID: <20260122080043.GA547381@shredder>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
 <20260121111635.GA447040@shredder>
 <aXELAazPe7G5M6am@krikkit>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXELAazPe7G5M6am@krikkit>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: ec17d784-1142-4cd8-984e-08de598c5d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JfpZwBX+0XkEwouwZsToRTxxzbbYPrZyPZfEBg7hl4/m867pyiRq/21G6Wbl?=
 =?us-ascii?Q?nAKmO7wqW0VljEnt8HcN7F8G0Bo6kwPuD9RHPqfQddo/TDQQH0cfKHns6Rnm?=
 =?us-ascii?Q?LjM4u1WEj6QSHA+m/PUD/KZiIIWbAfJ6E+Qa32acSyxo0hfvnB+GHYyCRsE7?=
 =?us-ascii?Q?zBPKswDx5MByrdF1KXCHDJGPst/PI89QenjSKkehLr4OhAIN36dHrQk4wAU/?=
 =?us-ascii?Q?2EkmVFHuQjFcYNB9dUzX5DN3aZXHgjCtMo+5fHHs6pi6Pn2j7R2ozkjSrL+q?=
 =?us-ascii?Q?aZMVk4lJqMplmRW+S8aImAuW9GsW2Aij6iDjRyXzCGQP2TZ+1aigOkuqPIZ4?=
 =?us-ascii?Q?vByMncHneQhdcbNbg2GgZakJZ0RkcZcLzHVcnlUHGDfEZeHIHxOTFAIcbotp?=
 =?us-ascii?Q?A93rFyWL3vr7UiVbXLEfoWwTr3ZWGyrJfomdJdRWvs5f8/RcwKT9zW2wEP2V?=
 =?us-ascii?Q?e5QTcVsNlPe2fCuHdvJzJv2l9rBZ2l87ZRcbwdfD3JEYWNV2UGnr9710zjAz?=
 =?us-ascii?Q?oyjqu1OHPpQ7n8SXdPSpsomX/sdq4NRk0/qJEmvLJmRgBbz0QhjqCsYmibZx?=
 =?us-ascii?Q?hNl9io1Rova0nZGdXPqbB5NpZE/wdyxrScpvF4+6lGR0YP2N9yN7u1/cxMJG?=
 =?us-ascii?Q?EiSSms6EiOo3fDHCsiOozQkBT08TJy3USFfmndRL3h9pdqj2rR+/7Bdckgo/?=
 =?us-ascii?Q?q1oePQ68ICjLWpzDxMaUnkYAv+IlSCIcGrVIq/cXE6m/UKrJvaFFJWnaRSfg?=
 =?us-ascii?Q?FXJJH6Y4gE1R0HZOFN3sodQeVOzXymA6ZdJtSahIxF3TesIfxH6JeumhcQcA?=
 =?us-ascii?Q?pEopUPIv54ATXw3+0PMF3UqfEeuykcHgqUVBsALDLWTCYnsr53x6geTB2bTP?=
 =?us-ascii?Q?M5qhEYZYvE2N4Bv7SDROVWf3fZ6chN/LSGqoEkcQFlDncKkLK7CPJIv0LOlB?=
 =?us-ascii?Q?86wXQyTZu06ruZbGkJ9fIuQzdiYkBob2RE4W5xDMy0UllXoxbNyB7XFW9wJ+?=
 =?us-ascii?Q?+Dgtyg2edDeB1tz9DlTC6lgh3NwbBacjlIm6Up78Cvf5wOaQfo60xCQmpfvJ?=
 =?us-ascii?Q?nbYmVJJPcH5qYv95c73x9F84YT9bB+CP9TREzqmpjw9oCsDd8kroYk3Ubwes?=
 =?us-ascii?Q?CBC5Mt/dL8nE3yrQBPA1OEfJQjPtT34WIlPRPIHFvwmpC6AgGIY3rHDbpAIa?=
 =?us-ascii?Q?8eCIxkWchsy+xHFLdF4CpO0H+2JIF5YyqCI5Z8WQlOkMlqat5cEug6WIU/EP?=
 =?us-ascii?Q?IInHqWX4oSQEQ4jt9GmTNw0Wp7AmpX95TRHc/n5D1weYfclkvgHH4iX/+9i6?=
 =?us-ascii?Q?yqARPCsPIP4ShjLCcwoDlxhv4gE72XFxXjlKBL1M1milCSIABLytyVSDu+lC?=
 =?us-ascii?Q?cs9+U6naDhpqdV6ajwusv7E/jrCvLjv2guMorOHj1b2U0u8iODegeHocvO74?=
 =?us-ascii?Q?VMbzzpZlnmxW+6VNboy+T1A8dx6gkjekgEnsrnqCBhUMrOxfMgUxzBBLWtoI?=
 =?us-ascii?Q?ptURK0tg+QK6lRxUGZDuEXpYwhMpZjegqBnym+OVj5QVNjurDQMJSyq/QHed?=
 =?us-ascii?Q?j7JIZ1qTCMivbNG3D7k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWjqmSxrhdEw6rt9TBiCoedUxVkMlNoyUgpW2pvHaInOQ91Ee41MC821y8/p?=
 =?us-ascii?Q?HUCCwK9odSO4MQnuUOT6heeZIa1eeglLi6bnjd1ISjF0wR3Op5t023Q52yj1?=
 =?us-ascii?Q?3F34ZAFnsazDEDi4wF8yC4eNavDY/6ib3AqcAQz6hqqJE0B/MvxumauKLN/I?=
 =?us-ascii?Q?8yPqrP9p9p7mUXSLA+1btjxKGuAlbpZCRRjsXDuJELxh/Afl2D9Bveatxd1m?=
 =?us-ascii?Q?YIXscZoRkD4A2Mq41it8j2cVCFUootyko8Nw61u/2+5weyZDq4KFoqlpZGNi?=
 =?us-ascii?Q?bmpU2vN2mqUZGNmRDCY+UhrBdCMlowQ9/i2C9Jhg3wSoHb9e4f/HEnQaFBjL?=
 =?us-ascii?Q?HoGK0G45GdbU6SCshV4NU7py5kG+uBKK4K2GHd+yJItDR+0Mul7kN2Rm6hL8?=
 =?us-ascii?Q?0hzd6LkhrqzCIW1mwrBxhej2ypCKc0lZ5VxyhmW6etL6rHN9nkKUEKdtS4FZ?=
 =?us-ascii?Q?NFVhb0KoJZqDcfFZ/YJmj6URXmbr2+95VXzs8g1ISWrG76BTiMppXw6w3yeo?=
 =?us-ascii?Q?UsoICNeIP6dTB3V2C9nEU8qHjnQHso374fQJeMiaJD7Tw8SbP0oPSB2VDfI5?=
 =?us-ascii?Q?EeUvxYCnSnI+0ZpL35r3RPPzZDJBAZ4t5eqkar8hJ7HKJiK4rYlg2cHexvVO?=
 =?us-ascii?Q?3xrBKcRWCvkKf6zyE1yv1VKTOzqj1Un5G/MM4oqeDxPUNEIA3j6tzQfoojnU?=
 =?us-ascii?Q?CN8CdRazDmH/1lKaEJcf1BdWwA28olj6jB7orxuLCsyAy/8rRWQZaDFWN3/d?=
 =?us-ascii?Q?GTM0FGrFnwhjtJ9DZHJEYywqKQ+fGnkywQrB9QTUJyxHN89Wggmu25H6Gxeo?=
 =?us-ascii?Q?sxRiX5iCkeeNbBPHwLc+GKx/vWydpTDzayXQVM4AVTaWycvjoCf2NAPY/R6O?=
 =?us-ascii?Q?l8d26G8UJvNqTA6wyT/4Ve+SwEWcpJUzoLluQ0gXH9zDzZAI1VBqX7pdRdI9?=
 =?us-ascii?Q?Y0Hb/PKN2G8SpRr4flrTZ7zU0MTXCX620OXLH+XpiARwr/sqj9vFv5y08wl1?=
 =?us-ascii?Q?mPPP7Tgjbn/wUvyfsmc2WFx9h8iIPAW59knM0S6HR8sqfG3KXGqwuu4U5DzW?=
 =?us-ascii?Q?eEYpCeIDBZ1S+CfA7ELsaruWaluGOK5uYPscvNqVWlbyCvEdNlMLcVfZ3HVV?=
 =?us-ascii?Q?6L5CAUGmgXTb9wgEBsQ6xGHbTSvCMC/PVrT84cjwK8K9azS4MOhNFTh8pzLb?=
 =?us-ascii?Q?Cpq0sHv2JzfS9mXvnX9XFm6M52E2RqIyx5IzJK52ME/41sW7FlD68+DuHp2H?=
 =?us-ascii?Q?sjIXgzUpLBOSk2fiKQ3eqBkOFpzQVeV3Hf3+ijmXUs68Et99+FMWBQOq1zEw?=
 =?us-ascii?Q?YRPL/zM+GtrBHIwXmvqHpR0moah6Qmes+s/qth3W7CBBan1YMysJPhLXaWnz?=
 =?us-ascii?Q?/vFNtfT5rD6TcMfeXOG/Hws24PrlE05G2+1UaRoN4ZcBoCtZQ6ItCIgOzZ+Y?=
 =?us-ascii?Q?YqFnJBYe+urRDEVU52g1FllYyfCeuRiej80J8kXqPNT9w3DlF9AbbiQuDLLW?=
 =?us-ascii?Q?gHNXSV+VEIDg3yysOFkn0PECBfnYu0kvhw3kilsgJ1zWcq35CIu6AtyaGAkf?=
 =?us-ascii?Q?SPS0wGcF8SWB+uFt1OQMzQdorNB7Rba5zCarKm+pQXi5xqI/p9vhB8PdCAt5?=
 =?us-ascii?Q?CdRny7S3KlMNkyx4Dbc1+fy5DwCyIN6RzFd6iopJrIMEmZ5z1HQMKGerA2ph?=
 =?us-ascii?Q?fLLrjaKPDrBL5YmxlSb9zfCJzAi2LbI3cUARAHTWXvFMnZ6gAR2zj1NuVHBx?=
 =?us-ascii?Q?Bm6yrmTiLw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec17d784-1142-4cd8-984e-08de598c5d00
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:00:52.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0Idrkgrum3gpDwfBJBrKxRwvEygvfE12NTQzCMxtN43ops+YGQQAQIy35/z2BCBLTVdbuPzADHAFOcM1msaAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252238-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,nvidia.com,fomichev.me,debian.org,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 33FAC62DBE
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 06:21:05PM +0100, Sabrina Dubroca wrote:
> No direct instances using memcpy, but do we need to also full structs
> copied within a u64_stats_fetch_begin/u64_stats_fetch_retry loop?

My understanding is that we cannot rely on the compiler to perform the
copy in any particular way. With the suggested helper it is at least
clear how the copy is done.

