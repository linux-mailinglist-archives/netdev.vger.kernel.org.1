Return-Path: <netdev+bounces-259866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAqzEKnNmmkjjgMAu9opvQ
	(envelope-from <netdev+bounces-259866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 10:34:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 697EC16EC9A
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 10:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E288A30091FC
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E318154425;
	Sun, 22 Feb 2026 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rmw7chKn"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470229CEB
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771752868; cv=fail; b=JGDEEXA7Pw4rOFrfmFp0P6qki7L1jbSuu4f7ZvbD8talwMGPtmud8SaGCDCg7bpp5RWLc9b/lWkzWI+ds6A9N3IgdC6vAr8y+o/Gs2tu6nYbP70b8YvqxGQXrew0Ecsz5ZxZq/UFWWZt1nAV12nbQcJ3Cl6dIGHYOdUw12AYD7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771752868; c=relaxed/simple;
	bh=bX09m96Wh9g5rD5G6GvibS8zEsXX7vkqosqA/THKT7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sSy3NUWcfEp0aW3yoHSZ9jFp0HzaadHMwalRUj5p9AsN4Nn5pXsoUJnLPqCcf8LOGOlbZdTpJ6bIv8VY8qXh/YuyB67+/8QEAjmC7OfTc5FbF7yU1HpFwaaxEiyemfdTZNZO1S1g5XKtgjPdTiS8qiuNBbTHpj2Bb5PvV0/vjUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rmw7chKn; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I19Z2X0jhLiq2GOKiW/3T/NIsV0FnLjVyI2BGj5dL7abnJubKrDGtGSqHb24TIKqHGCG5eanbnROCNB30AGh3OPRiMbfhcFym+7J3+zbszPfQBfNj9wlt/Fko1lbotdmWDokC8JeyOYo3Z/GztJnyCYKut3IK6cvhmoXxfAiDf5DRE0SM2iLLuk6EG9Q+lvmLNboxI4ZuqwmsHQDHfzIgb1xgJXh4DVIs6PXMBdalWCY7D5EaC3x+F8xgRjXn5X966fnBqerHwDKQKoMc/WiFaIEz5JDFwRcV9GzGGQ8YoceuD6jts19uut8eDZzZXO0AT1rIwzwMW+9BkQFyXdeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX09m96Wh9g5rD5G6GvibS8zEsXX7vkqosqA/THKT7s=;
 b=gamlKKab8xu5DAbR4+8ziI6fa0pwaHtYltRK7vVp2zQioWRke8gw5BTO7vyzNpvrSMu5NxinV6OONWBq4uAPOfIy/Yq7Gz5PqJMz69eLTaMmbfX8lc35LU57mrQ+0iOVzLYUpFDt9okPWKBDwQb3Sm4R8mZGC71YJWdW5QzkPvOwUhqKTPlArfGF0tm0axdsbppons1ZoJOXYhwsPOeYCBGwacV4zYHCAZ7jn1Y4kWmMpPBQIHOSyhbXzbMFuK7GpB63X/QwYfLB8UZQsjsLVSppeK6GBpGwBaSYxlQoUPGF1FYY94FGFYbVac7hYZXT9PVuEI0v7iR9pSIAJ2bTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX09m96Wh9g5rD5G6GvibS8zEsXX7vkqosqA/THKT7s=;
 b=Rmw7chKndCnZvz+4ZT9ZsYaFI2YHdToDY/ty3lOKoEVJdbyYEpS2qyDeiF6/8Ok+VAlIE/7Pcm/7J88gw6s88EaxkAG48FicYN+U4AaT/PSED2KfzF+nAI8ydQUAsU1egAehgs6PW150UmuuqE3lpmGoD+B1blxCPir1IUdBOHhGctMJex/pCH1T/Xq71PiRntG6BCf45kgCpNJu9Xln+Ra8aiKY43PiB8s9TuOujS7tHiLkw/GvkrVzPBBZzibper0BxC+su1ART9hig0Ws9p02xxGao6tCqobVjSJ+PiNj59RpBosp93eprzb9Do6xrA4tmhToZL2Kh35z1wSnAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 09:34:23 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Sun, 22 Feb 2026
 09:34:23 +0000
Date: Sun, 22 Feb 2026 11:34:13 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Network Development <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net v2] team: avoid NETDEV_CHANGEMTU event when
 unregistering slave
Message-ID: <20260222093413.GA30085@shredder>
References: <4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp>
 <aXl_MwhS9AJXTYi4@mini-arch>
 <20260129191243.767e3005@kernel.org>
 <14ed1845-370f-4b28-83e2-d8424db3ab36@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ed1845-370f-4b28-83e2-d8424db3ab36@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d986e6-0f73-4139-b1dd-08de71f5902b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXKBTVYKX7g09k7NrkrSti5VgU3hYGRwstz5J338Ijiww+ftsvJXZXFT9a+t?=
 =?us-ascii?Q?THPTF1a7p88R30Q6EtmF+h3ZkxVWTl9GjeKEhmCdrrRKXgd0e+yWihblWzDk?=
 =?us-ascii?Q?KQWVNVqHrEl3cGQN6cVwKN8dl+muDWFrYc461N22AnUh15KLalM0ZehWTHCv?=
 =?us-ascii?Q?cbh/z4dn5j3eLpKZ85y0MwwSbY9hdpAXDFXvI2LVojT1Z4DkcJP/H/0eCnEQ?=
 =?us-ascii?Q?rq8yfFJgTMS015BDSQM35OxC32zGd5KpFoS6hrKOVgGRfT5JnTCBfm+gdJ4f?=
 =?us-ascii?Q?9DiNyQ5UZF2hVdBjmI3i0ruwfj0V09wzVKqobwAN5C7UpW7NP/cd4bZvQdZN?=
 =?us-ascii?Q?FCuVo7DTbWOj6GQumgGQu83qrm1ToBq1LTf7ptC9NgoQnLOP8lHSNTgkUUqw?=
 =?us-ascii?Q?X3KDGiVv+5i8rqhChEF2clzdKgcMvUAb4mWLBwhKLg69pyhFxdJAk+Q0jMk5?=
 =?us-ascii?Q?nU2z1oWeeYnO+GoXWuSx0rdo+MsPi3TmRsMlaCh+MEg77vS7Erd5asnue980?=
 =?us-ascii?Q?psVpeUa4wlS33lF03ofZka7IDZcNYWEDEjn9mX+ndVL06+ugRMpaIhBmKUrE?=
 =?us-ascii?Q?10K4wgfjeSoJXX0AVJDX2mSGzaPgnNax9/BFmI3/4SUgKvnFDCZVKLF/+QsG?=
 =?us-ascii?Q?5oZw/s+CNHIOLQ+JeB/ADc2H2SrpLDV1VNdOsw+lZ3vXLY+kIlwD0qTzmUrz?=
 =?us-ascii?Q?tDNOdgBFOIu6CGAw2CLqVIVxctygo8a4SEQNRbnwR+M1d/t2zJkg168K8b23?=
 =?us-ascii?Q?y2Qc2qD4rnyfDDrSH/b0oo6GFCYIDSVM1L0Fl8LamNNlmtv7XgAO7l5fE021?=
 =?us-ascii?Q?W7XC4fE3/2FShWYUYumGP8KIalS5vgPPVsTJYWChXOy0s4e1XjseYO/vtubB?=
 =?us-ascii?Q?3d7X7TGpm51y7nC0z7aPD2CtEwr4u/nxZ3HtUUbEblBmHuSaTUVrFvmKtGNr?=
 =?us-ascii?Q?JNwZnEwSgsDoAgmU+YU1QusPhY7J24Ve5cjE5co4K4HzArURaWHGhOjZnZiF?=
 =?us-ascii?Q?o9SD4z2wu/6WM9+T2Tx4smGsyoLuz8kS3vbTvFTiueoCg37dDA/FvbD18mvO?=
 =?us-ascii?Q?Sswyj2GIJHA34xUPAfY9MusgsYDPAjkdchmJoi+EJVKxOpjJnWsKdL3m1M0v?=
 =?us-ascii?Q?/0RYg53TEWNwIrDbsObsU94f7OSMacbYfZKUiufrGzP/7TdEp9ucwn4VNIt1?=
 =?us-ascii?Q?UEi1VdX+i29sjErGA7c1xIUNgvv8XRf2jSmqas1rmtlGs5KxUyvN/YT/TtYK?=
 =?us-ascii?Q?mCh/ZGstJGVcBRwsBed6hxw4+BfoK9t2B4N5cl2vwlEcaWJiFk3Tl96fYIGc?=
 =?us-ascii?Q?2HdW5dnhwNMlTycQpdQUpGF27rRf6JEceVNJbYWzZUBCrWgZxQa8nedNqyW2?=
 =?us-ascii?Q?djNxRUk5+3qWbp5FqNHnWZ3LCyieRJnahCknEvPyB2OgmvwaikFLTg3iW9hY?=
 =?us-ascii?Q?AnvuselaWXuoKBOg8hWMCDKKgdLCuwLTwVZ/VC6DDscO+YOmA1L62zFDmMt/?=
 =?us-ascii?Q?4uO7tnYfXZZC5g3yhMRglPZMxjXUqufhDuzVNIfEHWy7rYNEN32MyJ4jT/gR?=
 =?us-ascii?Q?lJZR73ormAsaM6DgGDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LmEBKpynjomKu0VJ5diTJF7N7Y13JLkK8qtbHGTeiZaCGzHZIsqbiNOAGec0?=
 =?us-ascii?Q?OE5jhoVqFmdGeJm93TZIiJYqQaijbTiPfKgREJLiBbtlsEh59LS3SMiyJen/?=
 =?us-ascii?Q?zy/Bv3r5wy1DamA3olguJQlrPuP+2N6XJO0mI5AyPgy1TNZcbxK3Beu0erqC?=
 =?us-ascii?Q?sUY/9LVTtQenkFgUo695Jj6iTgO4SuxjjHKOcSEM6Z9QXyI9U2OQ4v9hBJ+f?=
 =?us-ascii?Q?pnlvHd9R6KFqJCC/f0mSXqW7wvEVLTU4H1dBlYeIsDtAdy5Lpt9bpifi2xZa?=
 =?us-ascii?Q?s7P0Gzf6ns3vEqYdENbjY81wnROZTokF6lU+fxVhIM2TeEM9v+KwI3u7Pavl?=
 =?us-ascii?Q?0p9qEMffRw2QS1+0g5d4ELn+XFKOeZ+DUVMr8rfn5ugNZ2kwt2XWnaCt33/G?=
 =?us-ascii?Q?Vy/8sP3vY6C1s52zXGQXRBfv7YiCrITaYJmH1vKcaMZh7OE0Bwy0K0Pj3te9?=
 =?us-ascii?Q?bxByhGcEbJ27u2SJESDaJsi2CIBoiSEiJmQpx1NblKun9p4zRBuCGbFpaDSg?=
 =?us-ascii?Q?Fq601G2og+BCg0vX+E4E9skARH4IIyt/BCcd3/xnVf0UQgjy9t1dnNsWM5iE?=
 =?us-ascii?Q?lrpD850GCHLZCRs4b0IP0DsoXdLpX8CUuXWajFH4ADZ2whfMJ02j8ltRK9MC?=
 =?us-ascii?Q?Qw4E0m95EWGI6m70UlVyZVAETIT7mXARvIkQvGLfAT8p0TjMbbUTrJIKpg+W?=
 =?us-ascii?Q?LCLAwE47OHQSS9ZFXgb3oKFJKDqirt1pu81kLaiQRYzKjzjgJ+eESDLo9OPu?=
 =?us-ascii?Q?AxJP9tGMCIbHRVnFv80MM0Ji/bRSwChwSEQTJABUwBi+cbAE+/4hm05elJKx?=
 =?us-ascii?Q?6DDAE5D14Oz/PPm55CNk1+OUb8YboZuq4pzmeYOC1wiqqao8HFIA3yW6m8UH?=
 =?us-ascii?Q?u6r4Pqf667ZZovPfGRfosdJ5fwNU7fn/5x0PQNYZ25ogaShQcsCbCQsyb6YX?=
 =?us-ascii?Q?6bI39uVjdtvRWYU6ePYEMhtQVXqgVIHKuw1+rL4R7xn5wV4hC3C1Ke2k3Ku6?=
 =?us-ascii?Q?L80dNxsa/fPGajnd1r0GuMzqopcdKTyF81Cu0Csl5wE/iMfO8KVKx3VRPTHD?=
 =?us-ascii?Q?+13KWxeZ+M8uAQ6EbxfaXihlMx1atdSP+pcHJ6A93fYSQxuMjzxrzotDFAoq?=
 =?us-ascii?Q?AgpJMmxGj4vU5IIcKXCyvXsrkLeLzyKzSCTlgPZBTVuuAqLCFkrA2e54mFUq?=
 =?us-ascii?Q?T/j92fZzFGbgRHvOQqTmBB/Ddy6+K8YHlNNZ0yQkVoSCYN/+X7dFyETG/j/l?=
 =?us-ascii?Q?ag4OA07TYbgPTQgjXaazysB2tx4P+UUaBms1Q18GV4OoBNj6HOiU9jxh8eLm?=
 =?us-ascii?Q?di34VUtbYGUWwoxmfLXsoUo3WNnsT9EkIXSePsMewux+iTXCjn5Ihe8tC5Kf?=
 =?us-ascii?Q?fxCBxQMTP+eUMl+Qta0S4CsDUzB+LjUCCL5oYFerY7GqZLB0fDJeijYobh1q?=
 =?us-ascii?Q?4rhzadzaYeY0FUl2I3+RXmv6AJqp7k41eoarno4zGV3OGEO5HXOcv8lg4tQT?=
 =?us-ascii?Q?jiq8EV4Miu3onWQnZBJHACr11+ULBtKq1rFIR43A5uTZvQIiEJ32+2HmTX1/?=
 =?us-ascii?Q?rIFJxxItNZLIRaRcJ7nmI05CHwC45patZK4Q8CYZzbHnWT00jRCppnsWc1/S?=
 =?us-ascii?Q?yTe3pQ9D3QS5MHvd/5G6V06bs+tkox0bjYwOYgz1JC5e5iXHevW3zOgMZEZm?=
 =?us-ascii?Q?s8NQveHgPQTdDMl6JBStAvlrE5L+brOL2bZVQzfzzPamQxie?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d986e6-0f73-4139-b1dd-08de71f5902b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 09:34:23.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyaT1dgqAyDZqI0jshYpHgx7h/nvkL9OuSqHbeCWIoojHR4bYYRieFuhGiPGsb6+MFwtIzcnwaZGjFJzcP1Nkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259866-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,nvidia.com];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 697EC16EC9A
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 04:16:43PM +0900, Tetsuo Handa wrote:
> This patch seems stalling. Who is supposed to create a selftest?

The author of the fix (you).

But don't squash it into the same patch as the fix:
https://docs.kernel.org/process/maintainer-netdev.html#co-posting-selftests

