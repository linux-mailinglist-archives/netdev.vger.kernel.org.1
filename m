Return-Path: <netdev+bounces-255621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIWcGBpvf2nNqQIAu9opvQ
	(envelope-from <netdev+bounces-255621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:19:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B86ABC64FA
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46203005743
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8B1EEA5F;
	Sun,  1 Feb 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CERqomDp"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF61DF25F;
	Sun,  1 Feb 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769959162; cv=fail; b=oNqt7VaKoUv1AloaxKRT5Rv9lDMTJXkgshKBzmEbwylBylf2TFQv/e8TuXo1q2srZ2ELAQUzD7f+5VM4/qcIdiqOwlrxs2YkrYFcplxWRW4+TDdPYnIqrc+EKXNaWaJT6H6rdK0/QjBns2hTwKneSKlTR8aQct1mc2qyEY4+5UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769959162; c=relaxed/simple;
	bh=9dc/4yAuZnVrXPKBzqzCbXFIRdPpYh6oKpQ9idtT+nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9rGaT1yxkxpcPl8NpOfVTxLVFSb2Us8EwjDaeIgTqg0lc6FUU8rdOQhFmyBxyKLv6VTxKg7kZgn84L96puPUO3T+3eWjvjRBBILGFMCHMFjpnGlp0nWBG35jftto09LaKfZ7ED8xhRk209JiAREb4yqEZMYREIP+WsCrDa881U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CERqomDp; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA1UZa6VLQ/bKoTmQFycdKNKoXBquFB0JFAXqDyfv9f3kPesr28yY71k386lIOym4in80RsIz+wTc4v3Opq6G+Pr3N0ZovxKDxAMB6/E4vnw9Rz/mxekmdxFfD/Hy35pEnpr2zdBDJBS8W5YvTs0Kyn4A5gFoMVmQduKcQol8ieSZveFBusSAGYveej7JTFfJzZPVesaNyv2Mqft6gsH2seeNqWejDC8xZb1zXO9+pqeEtPDMDaEZkukSU96uW0HJuiSkvDsZyJeSOo+srGMpKxRbPnhplZqnDUH1PUk+Mq0XO3i2p4ZgFhQuDQPiqHfyBzgG9TX52cPT3qi4Z80Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnuEI5vbO/xCfD8+ltw/JJlL/eiMv/27Hi/fByB4POg=;
 b=cieZ2twjUb70e21cpibB51g3RSWoWOswB2aFFbWvBp+vAIMTge0Uk/oinhVI+sy0ISLdm5j175wBwONO6+ZvvcHXUX5sY/zJS+y86pecJHrjhNRTl5joh5FmTafBFWboYbgAuJPrbuFQhJK//7xbYJcKUlgqBeGDaPGtRZrDsTXAXuYc3T6F7ziDZglNjASwNOsZFOznSZMwik6PUv5ofGKjUG3HRobiQ7/XAUBl+AlKjDp64Ai3NUYFtOY+K5pNrMz0rZBD6knQAUZWRLXdYGE9JiS6/rI8QdXqOJFjNmktIKkHSy0Bq9kqa5A7zilxX6RRk7egSbQo7TX9Ho7m9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnuEI5vbO/xCfD8+ltw/JJlL/eiMv/27Hi/fByB4POg=;
 b=CERqomDpKvR5a1pmlqSne8xPBl8vfaGhh6SczUFowDweSeSlkQSeXi0xZb3goddn1JGYPh+G5j1+nSk2MR4exQ3gN8Mkw1mmKlcIdGdK0YP7xTyk1xuWhM6tOb73Hu/S6crGRZtclEHoXWdcbnbhjr65Gl4VzdlitLqW8O3nACfxb6vQHnTQIw3QL/ePi3ERqemvE9/JmCt9UFraea4pvYYaShvibp09AM93/L2j/Wch3EYMBteVuxlcMQg7V81IS7ax9z1ytkFOjYdMA19QYEiz5VgRVh2cdBkQ83P9YsmPLM8JaeSpvSgmdunABr5ohTZPm166KLZEPGCfJvyqsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:19:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9564.013; Sun, 1 Feb 2026
 15:19:18 +0000
Date: Sun, 1 Feb 2026 17:19:10 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Corvaglia <david@corvaglia.dev>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: use sysfs_emit instead of sprintf
Message-ID: <20260201151910.GA139675@shredder>
References: <0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca31e9e-ac70-4418-72e3-08de61a544ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2DdN5eCW+EUcOmZA5goOGWy7vtGHrIziqXuY9x3DVqbkB9JSPP9TQ5VgcuQ9?=
 =?us-ascii?Q?Ub9G8AFHTuIGSedFCR7LwBxuRY+uf5/I/bz6Ly998tmO72O3btayL7Y2NOha?=
 =?us-ascii?Q?uPtocE2z4GGv0EjWruNUC9vKAN+h79lskUYyjsJbLkWjAjocdFydXkGTPhnq?=
 =?us-ascii?Q?njIntzmEorYpJ7BJEUlrcByS7dPnsqaJ7nAmerPdWGNrHsP8CITrIG1G65fj?=
 =?us-ascii?Q?TJzOY2iRXLmMibbSVHaS/66L8DUedz0mek8pa6WYuAfiyEwZeigA6HjfPkGJ?=
 =?us-ascii?Q?9IdF2vH60v1Nqgf9dx9BNNX9ESS7jQIBugvkHndbRHEBFWly3Oc7hmwHJXlA?=
 =?us-ascii?Q?kPrpm0rgsrnIdy5Lu08Ju56bgsqke9g8Bq8DbauyJKt+ZK7WRd4L1OeaZeBE?=
 =?us-ascii?Q?39kTTKffCVoXXC3nOaOlV3AbIvG3u/NGfFQn769iFHDVuZpwE88E9yUX0zKV?=
 =?us-ascii?Q?Cpcml90ibBmfKFTEfS4Z3FWEKUTUFFZF5kUYpnZY0ntc+ZQji1fMh4km4Pr/?=
 =?us-ascii?Q?552hTDIzHrUk7awTy9qrZ1rKFQtx0aC0AVazZrqQPcR4l+hPqUKg1u5UI547?=
 =?us-ascii?Q?4DazoqRbL0fYL+eaBI1J6erjuc1CkZho29eBCg0S6xAU8uPHn9eqoDJuvjL0?=
 =?us-ascii?Q?uQFdzZQTQdNmRhtKnUbu/ZQodU5I3UhskFndRveBIEmmPxzWYD86fJmkbxLx?=
 =?us-ascii?Q?OeO8lU02GfY0Y2NMSoEiyqXJOJZsIkWSXGtZQeLvu5OjcyaLaf5kxlLCp2sF?=
 =?us-ascii?Q?M+D7u6ThZ+GJ0CfwpbEuIeL9yd3sRlebukKBG5GUgTLhxdEeDU9Hu9m7MzYz?=
 =?us-ascii?Q?0okQ7eSlujgrlGI9NOjwTgwWmK+MXDlfOZZ9Ax7VQDkgLOU+CcNcGapqzxr6?=
 =?us-ascii?Q?YCcLdisNMDXAN3os3CelGkNQrMsf8VxlpkdGCwFQl8JmC/eQ9viOrJi/bh8/?=
 =?us-ascii?Q?SRa0eslhbGcVk3F8P9/8bEBYAT7W1UWZgpVzRJVXY9Bh8FnPr0MAn4+kGRTx?=
 =?us-ascii?Q?9rjgMAJAdwlJzfmJ95NN0CqTp3eoXCi9neAcINDvRuzAparw9GFVTEe5xao+?=
 =?us-ascii?Q?PSUZOu0TS3iS1ZK+qUQ1rcMtKAO2s+KieJvUDBSmiLrcmNRBqphoejgfF2/a?=
 =?us-ascii?Q?E/1FihAAARaBfnBZbdA1d4/BS6pllOXRHuzv1IhfFCapRVw0HQTOxf9padft?=
 =?us-ascii?Q?vv7GNvfNZ+t9GpIy4G9jUHapvwuw+kNUXKtKWzwZyPUG/NqrPF47KpEeASz6?=
 =?us-ascii?Q?N4iA3PBTAqbjixwPP6G8AsuzcnlsJ4/jplVCcACvaFA45f0KnzM5IyUkYjMS?=
 =?us-ascii?Q?yAEENJBINr7YqXZQtYmjFLcOkm+9NSiylYfxj6rwD0M+j4ijBIqcxutMOUw3?=
 =?us-ascii?Q?sHNeNDC10S+/s828QuMvtNqOsM1Mz6VftmoummihYsl655hYo8EQfQE/JB/c?=
 =?us-ascii?Q?JKaM6gxQ3wB6E9w5gDJPPWoG96P0edKyZaY3rsIU5XS7FBCbcQxCuj7KqI5X?=
 =?us-ascii?Q?ipJy9sho2DUXAsj9WVIJ34Xn+2dB+QpGtzX+e2///KmzWPckityVz1FB0RTq?=
 =?us-ascii?Q?m59M3SdE64Pi8j279U8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOh2FsGuEdUpCwuLRl8xH6drbqMVokpakcTr2IthR3T0jsWhhWktnx6OU077?=
 =?us-ascii?Q?xroMMApxOqPGJi+lBwBK6qSggfO6lGabfDagHkb1A1fWFoSPUuvitD46mHEc?=
 =?us-ascii?Q?a2bS8Q+eSRIvCkFvRhhqUBPO+9sHowlED9hs0WzY2dPEwdmY/LtwDvmec2b4?=
 =?us-ascii?Q?JWkYo1gSFOTife/0qVAkIRPqdtJiJTRGX5vx2FuTa3zhSiAerGnzrA8wZj8e?=
 =?us-ascii?Q?axSonv0okNT+1v73iHAdX1mdPqB8SQXSwCxwEkvFunA+pZtWE4QSEolIIlXC?=
 =?us-ascii?Q?4sGmMrp3Yjbqh31paJTLU+2Ue24IrFYjs+PChassXsVwKWDVvwb6Rby+uW08?=
 =?us-ascii?Q?O9KZQaFlSoJQOK+q6vwEU0uAC+/yBDVScWfsk5zH81ogKR/PODLKoXqiBMnz?=
 =?us-ascii?Q?0w3VfddMYcthww2HzzKtfkW1PoR6L+Fm2UdGPK69SWP27PZfKm/jwUJhiKni?=
 =?us-ascii?Q?PVgDXDljhclZhC9lGnezGse5yI9GuMpYZ6yiAlighJXNScHeLERE/sly0d6f?=
 =?us-ascii?Q?xO535ZCD1Mbucjf8+ti3vcOhxzJmRIghoGQkJ8WcczQUmtCor0EtVoyGYq2D?=
 =?us-ascii?Q?nF+61SKfvWSNT3t1JXRHzGAdH7zVoAz4aHZ827h5mCHQgeH9O22KdzSIkFsA?=
 =?us-ascii?Q?JEmTJ8QszE9wzJJT1ECHjQ6+JC+SPKPfSu2EdiVBKisLnTyxiLv6OmZDVnwh?=
 =?us-ascii?Q?VKNFyWVqeccd8NF+M25BSWnMxhsPQD96LmX2U5l89/LhgJSXmTqgi94++9gV?=
 =?us-ascii?Q?5pO4dwWHUo/1Z05DhzIewOrKaeFgJAgFys1Ge8BgqSl1kF+9UuUo7uYvvi6Y?=
 =?us-ascii?Q?1hjDqWE8/h+1h2hI99viqyz7MGt6LS/OXABjz3+Z0nkyT0hveghwFxlat2nK?=
 =?us-ascii?Q?i664B9rI8M1LvTHTYmuCu8ykKiXt67VmcFuQDAoxgi+zLfgEQnvqvctLmhnC?=
 =?us-ascii?Q?cGM2RF8jUfL81fxHEYbIeOrE8YmggacrdkXPzo+tdVMEy0xmsogA/T22CivN?=
 =?us-ascii?Q?+Gdk+cA1HftyJv5+5i2ohpM1NDhVTd+b9r/VGkm/IX8K8NyU+YgR8DAykvFx?=
 =?us-ascii?Q?jsDBaue5NL/zwEM6yrwEkW21Mjnfp02koerrReTCVXR1c8IMfKDcYO5zOnV5?=
 =?us-ascii?Q?UTA4hJ2loM32oUNF5V3wSe9m7pbpkSi3V1pO1JgASg+T9kPWYDSkCUuNtxV/?=
 =?us-ascii?Q?N/pprx0P4VM9pE7sFSerUdJvIsXtTPjMLtOnsNCbfxT9mBEEJLlzJjZzYTod?=
 =?us-ascii?Q?PPgz0zrp9lIP/qNDlXOmc2UMVecKjlAwucj/cK19GzJ/siK5Zs4OXK2vtCSy?=
 =?us-ascii?Q?iqKcEJ52k7VzjQJgI3Y12ScloPSB/3qa6UhXKlo0y3TN172+N7p/UgAjZKug?=
 =?us-ascii?Q?zyAjKkUX9N5iYqpJHgoQFK5DEGJjivXm8R1hHPheMjQKYUqexxmG7B67vr0V?=
 =?us-ascii?Q?9XOezH5ZhtcWpe6eGV4bAZlug/tsalyB/c7CKTkXOqRKlQH00vqt6Cz96ckx?=
 =?us-ascii?Q?Jjl9qR/J/pcnJ1m5VEmvH2LCD4ptAxKinI8Ail77KAgyIqQsHAuezCC4JtQ1?=
 =?us-ascii?Q?MTZG/fTGjG660KArq3YAiU4JTSM369A9Hvk+qhfxRCug7n7FSFQXN0oKkQId?=
 =?us-ascii?Q?rMwCRlQrMmht+32Zf/JdrHNljC8FYRlK2bCoJURQkqOs5ZzE79TTnao33DYP?=
 =?us-ascii?Q?44PRmzUXp+k7nAN3oW3xsWu8IbP80I2W02dexBwVnT5chsI7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca31e9e-ac70-4418-72e3-08de61a544ab
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:19:18.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HREEd8tdejIsZstszOY/nWX3upMt5qdwTIIEwV/LO8kbRJvyXKoN0+89s2m+qEbJ1FJCnGgHGdSgWZmS6mIKEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255621-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,corvaglia.dev:email]
X-Rspamd-Queue-Id: B86ABC64FA
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 04:53:09PM +0000, David Corvaglia wrote:
> Replace sprintf with sysfs_emit in sysfs show() methods as outlined in
> Documentation/filesystems/sysfs.rst. sysfs_emit is preferred to sprintf 
> in sysfs show() methods as it is safer with buffer handling.
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

But the patch is introducing a few alignment issues and it would be good
to fix them in v2. See below.

[...]

> @@ -87,7 +87,7 @@ static DEVICE_ATTR_RW(forward_delay);
>  static ssize_t hello_time_show(struct device *d, struct device_attribute *attr,
>  			       char *buf)
>  {
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       jiffies_to_clock_t(to_bridge(d)->hello_time));

Here

>  }
>  
> @@ -108,7 +108,7 @@ static DEVICE_ATTR_RW(hello_time);
>  static ssize_t max_age_show(struct device *d, struct device_attribute *attr,
>  			    char *buf)
>  {
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       jiffies_to_clock_t(to_bridge(d)->max_age));

Here

>  }
>  

[...]

>  static int set_group_fwd_mask(struct net_bridge *br, unsigned long val,
> @@ -200,7 +200,7 @@ static ssize_t priority_show(struct device *d, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  		       (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1]);

Here

>  }

[...]

> @@ -425,7 +425,7 @@ static ssize_t multicast_query_use_ifaddr_show(struct device *d,
>  					       char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  		       br_opt_get(br, BROPT_MULTICAST_QUERY_USE_IFADDR));

Here

>  }

> @@ -583,7 +583,7 @@ static ssize_t multicast_last_member_interval_show(
>  	struct device *d, struct device_attribute *attr, char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval));

Here

>  }
>  
> @@ -606,7 +606,7 @@ static ssize_t multicast_membership_interval_show(
>  	struct device *d, struct device_attribute *attr, char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       jiffies_to_clock_t(br->multicast_ctx.multicast_membership_interval));

Here

>  }
>  
> @@ -630,7 +630,7 @@ static ssize_t multicast_querier_interval_show(struct device *d,
>  					       char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       jiffies_to_clock_t(br->multicast_ctx.multicast_querier_interval));

Here

>  }
>  
> @@ -654,7 +654,7 @@ static ssize_t multicast_query_interval_show(struct device *d,
>  					     char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       jiffies_to_clock_t(br->multicast_ctx.multicast_query_interval));

Here

>  }

[...]

> @@ -727,7 +727,7 @@ static ssize_t multicast_stats_enabled_show(struct device *d,
>  {
>  	struct net_bridge *br = to_bridge(d);
>  
> -	return sprintf(buf, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  		       br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED));

Here

>  }

