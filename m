Return-Path: <netdev+bounces-86487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C089EF37
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723CD1C20C5A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474AB156C61;
	Wed, 10 Apr 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QkV+o/q4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2091.outbound.protection.outlook.com [40.107.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8B125CD
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742758; cv=fail; b=DXV8FphHf/+nLelEdzZJ6sCKfi0v+M/Ok5Uef+BKN69OkJkPSEKLDhE9Zs5hB3Yv1PvJ466vWqlBrA9N7zwFM+BIvDTKMc0brgSS7lfFTHJwJW3p5atavE67NiVAUjcsRyEqJDAVbay9DH1nN+xbmMmaMXAkqafTUtczfERky8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742758; c=relaxed/simple;
	bh=X1As/ptiYz0YFbSn+rFVPti7IMWTeizXvZyOAmxe3nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fl9iJd/kxxVI1393IzxZXGQdLp7008i+YTdLBhe70tp0KWrmqTfVfX7zx6URQBCceHI0t86MbqLEdv75MOCMCeGTYeLLttFNGUtSdIxycn5q7AWXZwnHLH00mCd7RZRmatxlwvRqV2VeCDXvcEJXKLpkSklUgrpkEI6NmFTTWEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QkV+o/q4; arc=fail smtp.client-ip=40.107.101.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6+qY2sHRxJUUFV+192yLhFaoifE20Xs2R7bxJxRGJ0AKUE3MXD0WjkwH1OWX2SX0XKrbBYySG2R4uqcM4PMjuKkk987GrVscVU++5dyYTqsVa3KK1jpV7s6qdwe32SgMzPRHSd5Q7J0dehdm8HHhFn1nMykgX3gJN2Qr5KNP3Lnc1WBoddoyOVPTZFuLInGiEWVlXWt8M6iGShrzTn9Z1XUr85qwukSs39cWc7/+IIn0CV/t19uL4J6Zm9iMxPcPNM4qOCuOaq3mwHRwsKhBMJX8J5Sxu7dJoMAMqIIDSGKUmNHvK+LB4v294NhLbnYSwwMe9ev+mo2KPsq4L09gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84iVCm276B4VbXmC+aevTqMMzbeyg3VhPnpipafSeoc=;
 b=kktSJ768mUwnwWBv/Z6sVjlDOGvqy16XkLw3xjvOAZWS5gt1xw3SFSOb+AlT+/5WZ+Lrb0CwrskqUW+xVFKoOM8gZpk2t3WaDln9kUc8X9JV7u+85m3Xp1Nm9puXTjSPLKW0o9xuOZal3mfjotSmHMKCoEd7PrFi3BYq1/uR7Lijev03NoDl9oiQqVyhMmzZruCtKrBkObS+ZUkMg1DIRUGUsBuJjGdyEo3SBetnDZhXlCqSahewLWJP0kF+rSt1prGutGpPxO6wKxV+A7soKlPoNt/Ggxkatz+muI6exouHNtoKrTI6+r7YK13tQ0a9Pzf6m7CMtPBkXG/7dZ0lUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84iVCm276B4VbXmC+aevTqMMzbeyg3VhPnpipafSeoc=;
 b=QkV+o/q4coSAwb0QKn6Q/OhibHM7rVN7Oqw3H1E+RLeH2iSqX7+JscD8/N35+Q06AgipTsuKyEBxk3UvkDZ8UpeWWVZ96OnAX2KQf3D4t0ptmuMZ0Lp1LbO/a2379ybwiXnLFawy+ut9VzPY5foW7q8704yz3HK9p4/lueyH0T70NyvIJ7tnelVLMa8d07yZdbW4rWGI2UWzJ2m89L8BgvMAbjWgS73c9nUf5dBEZPJnfaXvSCvxexWF2EFotgNPY/ZmmNhNvhHhOoApmskpjgQ/Pl34Uha4Ooo7Dv4Nze5Uoamt6vPii82DrdCiqD+XSeiKUNMM6Xyd2k5m9+eKdQ==
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 09:52:33 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 09:52:33 +0000
Date: Wed, 10 Apr 2024 12:52:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Bauer <mail@david-bauer.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, amcohen@nvidia.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] vxlan: drop packets from invalid src-address
Message-ID: <ZhZhXFdOVZ5QDfww@shredder>
References: <20240410010917.90115-1-mail@david-bauer.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410010917.90115-1-mail@david-bauer.net>
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CY8PR12MB7218:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BjdBmgyXRy+Vk2AS6BwQuKCxeCOGs6tBagopblH2H70g8JMfBFmdQCt2fEs9W6UEqPl5QJermSHIeSpXn4xzADwRIrfdlEGHYyVRolUWS0un9dMDXRtMdqXYH6yoGCn9z+WIKn3mVrLSSacjbKwzUMffteGIiS6Tw0j78Gnz1fWibCNUr/egtuNRmR2uxlgRMWUdFYlIyotklb3o3M83vV21ai+EIykoFduMsH9eyW1jPykxoY5UnRidTmAh7y+qjw1FFawMQvb0tRP4ZepO/GnqZ6eGDjZPoo8gVvBI6YhVH1cuLdILB9ycxYfiBVk+K5VnXGm2jFj1peYg/oyxonDct+ZypsAjacsexPI5rIbmxca7Xm0S8D/5eajwVT+XRG56FTKUe/+AS9P9xchfLF4UkTn6qgbaOHXtoFLERX0pM/uZeg8ykinaBSlEGlDnhKqAoEeOE0TP2tuiVGFJRi3Fa3U/gngfWpcBBz3d+Z8wnH2Ww2v+3Fc23ofl2umV5Gdni2s/n2nidrcZa3hA69YN9Rnx7ZABXpGdpQvUIyri7KuJyrBoyK+hqBmMpxs4aYUo+vysIN72+ynb+uQTnTO7duBf5R3J/0sdIfMAOT1+912cU4GqBV2IMaQ8I9iW7/xm4OPx9iys4eBmhMNGwE9xU3RtNc+pHqPP2/7UY94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wZi5bqcA7hutfsBQKSBhZRYiA/josf8ODvKzkJ9jYQMX9K4g5wPGZjBXx+3f?=
 =?us-ascii?Q?fPF30167z1A8ih48WDDV45juIrTpbTU/LCEYJfLqgmHWcN7LPKpxisZxOkB8?=
 =?us-ascii?Q?T2L88MmgenQWrxDiW6Lh0jOfPZSdOObAxZz26MtOy22oLSx9UxUalVTRtqAf?=
 =?us-ascii?Q?v623eJYs3s+z6JCWwPAOJvnyOECug8hxsTJ/rjqSeIsugmtAa5XWPGVkWp8/?=
 =?us-ascii?Q?66CLj+oqYJA5jJZQ0hM6XKZGEhNV3Imf8a9b0pOxZUasupSZeE+8WYruSgbO?=
 =?us-ascii?Q?CHVwr3xWoxPzvIciUI0XMelDBIe6JVmnpJmDWuGSPk3Jh9m1saC+I2/heIVY?=
 =?us-ascii?Q?fznmrgNGDf2+teGQ+mVzmsjXIFQul52pB8ZaP1Knyacoo6A/EIl5TDjcUB+F?=
 =?us-ascii?Q?LuRsdI3m7uPj9GEYpUCRKIgEh0lJdV3Bc/LDAlXMmWCETASeNdjHhhUKhUxY?=
 =?us-ascii?Q?DqanH844AdCo3s4LxpWaG2DFKjlZrPbpU3ZRwyoi2otHvtqkollnmq8N2kg9?=
 =?us-ascii?Q?+YZxWX1vvqp+dMGiWBnhDRyFT4pMO/yAo5nXa7AAhiYA2c3B4nbuEeqgv/dj?=
 =?us-ascii?Q?tiTFcTr/+ebHs2NdSPs2ShB0tG5VbVoljZ3QKE5I2EgrQ2Pxu8ZEcJfI+ul8?=
 =?us-ascii?Q?tmYir1hJwZx6GDJOPy4/qm7xMFabAhbqetbJTELAsm286dOQ99I8LlQFAzEm?=
 =?us-ascii?Q?iiCzsJ9QZtqO9tG/39Q+6BPG9De3nf3IkVMaF5SooNkBRqK2VbUJauLR1JIN?=
 =?us-ascii?Q?AA6+QAkVueVU9CoSDXdjNoHmc8HS/Amzmym4M8RImpFMppzoqdzA6mmDAexx?=
 =?us-ascii?Q?2QpY7U4FnL5++tFvv3cn1QrQT90mUg7F4eBB7ghXsohlZXZ5qvmISw9IFD/k?=
 =?us-ascii?Q?yj3W22duFYojr9X0DEbDj28X0gFvFUJG7opPpgHPsc/MTQ9H2FweCrfgy9jP?=
 =?us-ascii?Q?Cyx/nxzJlN0fQmS+ulelx968Qa9aGr8uey5g1hUjBTgWMjbhzpL98QWHSeMD?=
 =?us-ascii?Q?nfRx7SEQFUAiZzugCLitz0W7qFT0tltgIPAdb5H6xfqYYacGdIJiJ3fq6x7U?=
 =?us-ascii?Q?W7uvujjw5RhYPdgxYerwLcS5Q1hrfFWdW/oJ/gBfv7QlbxxSub2SAcpmSHzd?=
 =?us-ascii?Q?gd2Ii+r0jJwml+samhYhNrdsJqZ7CDOPJlwSkt2ADY1OXLv+GDNbBEdobS+9?=
 =?us-ascii?Q?D+RWwebuFsX3l2G+gtJ3p3JemG8r0k/WvPC7HXMyLbobiGXu933dek8pmtXn?=
 =?us-ascii?Q?GEHChMZ+5aBiFdWeBBz+8QFyRHuCR4D3P+nno2Lb/UOsVpwxo7x6mX4AGdCp?=
 =?us-ascii?Q?ryovLPpesJmOz3N7h/bMGS9AtQRcs1b1VoQh9bfpyfNhmAPtkiDiXaQbCSd5?=
 =?us-ascii?Q?Y66BN6UeTIPh5dTu7rxsK4w8HgfNhK0xUEy+QTDGEPMwr0UP/XFJQzISnPKq?=
 =?us-ascii?Q?ekX1dS8KCi4LqdrX7nuw73lxPx3cDk5ickmsKBgYfMgfsH9XcReyojI56cAh?=
 =?us-ascii?Q?c8EZJa1iLwLA8r3HuAN2hsbsW/3pHsjQMW6XrAUV6LtbKSgMGqfCBRAJ4Myv?=
 =?us-ascii?Q?GXxPfiCo61yR2y9W7TwXLerwShXilfs3qKwx6zUb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17833ad-13ee-4375-d0b7-08dc5943f184
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:52:33.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfooHuw7C14VDMe0DP7iXaPRrSB5QKvdsgHewTU9JhvER6XRqgGKuElIcGIfE4wxRLk6YtxIMcV6dSu2lcPGOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218

On Wed, Apr 10, 2024 at 03:09:17AM +0200, David Bauer wrote:
> The VXLAN driver currently does not check if the inner layer2
> source-address is valid.
> 
> In case source-address snooping/learning is enabled, a entry in the FDB
> for the invalid address is created with the layer3 address of the tunnel
> endpoint.
> 
> If the frame happens to have a non-unicast address set, all this
> non-unicast traffic is subsequently not flooded to the tunnel network
> but sent to the learnt host in the FDB. To make matters worse, this FDB
> entry does not expire.
> 
> Apply the same filtering for packets as it is done for bridges. This not
> only drops these invalid packets but avoids them from being learnt into
> the FDB.
> 
> Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: David Bauer <mail@david-bauer.net>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Code looks fine, but there shouldn't be a blank line between the Fixes
tag and the other tags. Please wait 24h before reposting unless one of
the maintainers says otherwise:

https://docs.kernel.org/process/maintainer-netdev.html

Thanks

