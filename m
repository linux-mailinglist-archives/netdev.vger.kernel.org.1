Return-Path: <netdev+bounces-144343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3699C6B9D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A7B2841A5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C76F1F80D2;
	Wed, 13 Nov 2024 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E+SrHQNg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D51F80BB;
	Wed, 13 Nov 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490677; cv=fail; b=YiQOFoiT5gBHhkQmbIr2tLnF3mUU1uTfWIMyrgx8FKCNFg3Ird2cO2i8k1R0vHOHK7/mY5xVcvDeP+WDdTb8mNsTM4NYPz7S+TMwyJKwB/kh+u6z/TyfDggsGKEEQc5+IiMmx3001s0eBiZA9SbzBb/KcpWpQ+kuDBmaUDFe/GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490677; c=relaxed/simple;
	bh=fXDHXOm1xvU3e8D/M1lSyFld6qYJREDw/6Nr2XphoJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LL6lr9BOYgt7vthnwPytKzdP7WPd4myNZ2zFtvYXhqKOFFSDqNmjtPzW1JH8VMu3AZTI0RRuB3R9NZ96wumri4HF87DOPcESL2RUm6u53fO/CYm5XVa0fMT4WiKjg+Cp4KzvEbFjPC90GmJ3K8huO1onNjKYD8CS0NwILUMnT5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E+SrHQNg; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPUC8JlKAWI7QJ6ZxMc9c2Pqtc7OujaRJy2CIptmAOfO3p0RfbsqKDIhgsRXEW9tLYICQn73fO0wPOAfsw0AmAY/cxs9XH2qHX9SfRP4ML18mOsGHyNXzQ3U6H4JEgYSsZrQmNsGW1jv3etq8bxt0d0FlQ3zSEK4/Qe/tAaPkf/hfk1OYfMnCbJA6oSArMtPU4WopjZT4QadLGmz5iXjStAwM0LpEJ8mwOeCTe9doFjQs4nbXHv6pa5XG0TvSW2SIbKfRhuQn/QChtYhV7fo4qYMOTOdeGsgxtOY0lKleLEYgonCwudehK06Te8o6jM0APzub9LXcMDZIpd9tlJ4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR3C9lC9eC0GUt2hTN2IxyBviykaaBFLJGFdhc0Hvjs=;
 b=O9y9QKHgXauZK9RtvRyRNNoIkFd+ATyYCTc5dB1Hw/Yi9S5GS7qwjtB/zxOzNm4qI7ExRWtixL8pBxqGvoiGcA104/6GTYc92hqlepccJU6Q0O4kuAJDpGeoILBCXbwCp/6VevJQyMOm1MZWvmMGddcN5IjGw6BX/RnUkCCcb8h0tUoPS0DLVc6YBrojybmyxued3qZzQSVTLe8TmE0CX09beCDBUhv6xjDPWAM5ANKeDkhQdYAiUg7CcpNqMnEfzho6CDCvQTmx+I8Y5SjWd/3Y59GNaZ2pBYm+2khoDrNLEvlGz9v7FddvuBfM5GhsSqG1v9KWpPXrpFVpeBrnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR3C9lC9eC0GUt2hTN2IxyBviykaaBFLJGFdhc0Hvjs=;
 b=E+SrHQNg/M5O3WDPPUUpob5GUpeGS0i6lyKMVMiYzX8N6Fxb5ecpnJ6qSuS3jin32H2UlJg8xfwUr17/y/NTNfj0fXRdHwAQLwHJVd0Zq9B6jvcEug2sAHYoxkmg2HAMUJgaGKeWs4MQva6c9p3gGNmfF4/4rAkRjgB6rJqVwBdJO+V1jgdA221D8LNbgtUJ/Y9wVCLWrERGeOrDARiQ8U2ac6cZWmM/7tN1Iv5WeEolBgsBoCCsQJ915xu91W8iaD0bQS31dcs7NWTM0jI6x/TYnZzp2K0uZ2T17U5VUT13iWES3RK2XF17bOy4PNlP1pzFxrRB/ruRVBS2KvH5Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 09:37:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 09:37:52 +0000
Date: Wed, 13 Nov 2024 11:37:42 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 net-next] net: mellanox: use ethtool string helpers
Message-ID: <ZzRzZpReQM0JCACW@shredder>
References: <20241112211711.7593-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112211711.7593-1-rosenp@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 73edfa1f-7591-44ae-6988-08dd03c6d874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+M+FSsFSxst9n+aM675ys1u7/MZNpqS0v1aaKCNopc87YF/vh7AUGYcDY0I6?=
 =?us-ascii?Q?XpLy3usWNBFKLWveoqPfUHs0axY6Be1f3hgU4VOTc0J0YX+bgiDUdBno1Qyw?=
 =?us-ascii?Q?0u1RGkkaUpD+9+ZvgP58570mCxVmocrR9FO2jXapEGcqxPxY5YDSmiHopeiK?=
 =?us-ascii?Q?JrOo4MAcbBDyDHYV06nG2jr6saLvM6mLdTdeYec2VRvL1U+tfNWb/6wYIYE7?=
 =?us-ascii?Q?wNTKeFuDjN9vHmjyyDmlMWQex/xVsfh7GKkRPz+rjuScn3yTMX7TVEcX90sK?=
 =?us-ascii?Q?dyYs1e3Y/Ez+bbjLpDBtfI8taNdDCrIbfQtE9Q4efRU0R3W5leYsJgxFq5Oy?=
 =?us-ascii?Q?0lDVjniTuVasgbdGJ1JMtKt++DamDZ4V1V0HfWc5voiL6ie7VrgrXaHnXizB?=
 =?us-ascii?Q?rSgtouqT9G8AaP0bcECOeEXUUpIkcJ1q+wOjKEy+dIk7Tsp2MbXW2kPtxgUF?=
 =?us-ascii?Q?9O7QtVZgQ+IrhfVH6IIQN6aSOFkSGMstDIICqMYiJW8v4cjslmLeYosqqehe?=
 =?us-ascii?Q?h4vgFyoc2VinFxSRYvvgvVnNHYKJInairEnsIi22bZP64EFUX28TxT3C0v3Y?=
 =?us-ascii?Q?kEs/wk/KEKc5oqt14z2aGgXfLWM+cuFppAd8mxqaqJaNpNz5X7mBR1CLg5XZ?=
 =?us-ascii?Q?lK3wf9wT3VQegD79sk+GdQs9POWLYyL5y1aqR3se0D7rAuetOkuqEtJPIMr/?=
 =?us-ascii?Q?KDfycXmT1GhO+KccUqrcIveP7AlEXIAe3GbP94QwcVBvZrU8SItHIDGlZKYs?=
 =?us-ascii?Q?JBOmoAkDqmAYM6yVzJUU+C8AjCFOjc2eyC60pqQEk7thVo5wgYKHhViz4PF4?=
 =?us-ascii?Q?DNv6qNEkowi5w0JXor8YzuB808xtUKrz0rBTpN5ePOpfiWPDQegWDJ7S/yXT?=
 =?us-ascii?Q?1XK/uzKwwK63AV3M6OJw/yHqfhQOz3gNRiF4iyJj6lgS1PquiebBXX+r6dXt?=
 =?us-ascii?Q?hzsUEnt/MyaBykfAMtX5r6QDfqCgZYdTViLzVShhXWSyN90sE7uzoSFdgI7m?=
 =?us-ascii?Q?faLX7dWo0pz10JYwEMZLZEALwXEeqAADF/ZC23vzhremqgHQlDy3vLrlDUlC?=
 =?us-ascii?Q?XGatgQNBvDn1yUfnzT2RwN95t/RcGjK9HuXsYc/fcIohC5HNh4jJeL+xxvk8?=
 =?us-ascii?Q?NN02R7VVej/ONejxV4f9MNHFw1HteqCzYW90R2q9qfYpfQALLy+4EP16JocS?=
 =?us-ascii?Q?YdSK/snT+JSNovnFn4tX3O3zMAIjPepjziFx+Z3i+FUPmSdV+iIc7VJU7gsv?=
 =?us-ascii?Q?WlgmnvcOH+tzGNIvGZT8nj7eTyxsP6e3S9fh4tClt/1/uqakwIAsYd6pGGxg?=
 =?us-ascii?Q?Vb0+7ubO+NQflDwngITMdvl8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQbW1giI32dFXUaBekxf//RA/mCb2OVdLYM6gR0vRBzFHko7oJX35l2IzUPg?=
 =?us-ascii?Q?UyPBJJSxVFue1j+ZbnqX/MZul100yM/+/SG8NpeDckH9+SAnjZbpZX1m76li?=
 =?us-ascii?Q?sflbwF6iLFDHAjQ6f57alc++3T3L4L68tCts4sZZM2GdDZ+QZ2PSZOyuKZuH?=
 =?us-ascii?Q?46lGhmMfXa4D7fYNXUW3QhX4R+KnGo7yVcfQTnmaOi4yoIjZN5/F5+Xoiy+k?=
 =?us-ascii?Q?hhMqC7W6DKBq3/GbDGkcJW2FIl+isH44od6e75cdUv73sisHWDhTMZ6MIOqr?=
 =?us-ascii?Q?UXdFM+AzAiSV0Glvy181o3f4qF8p1pd6TuKbVB7d+IqJbby9ePNy11UchUzu?=
 =?us-ascii?Q?l8qnI+W78F279TkTMlnaVg0c3xNSPb6L32CKo0CntcgH98qGsBUnX2S5R4nz?=
 =?us-ascii?Q?QYlMnC0lcMoCtuu8Ezon3hoa2cVOKSzeiGIwqzF+parLR/oY56hLNmlx3HCl?=
 =?us-ascii?Q?VsFHrLxfE91ipjeQnW9BYxQ1BnqOyIK2xF04l7/efMTIj8MlfRTNQUSjPWk4?=
 =?us-ascii?Q?dtVyp54MRUmYZxCX87bqtOgc9BDzS0nOQ+S+PHMnbzTQkHo9WGFLMCZHUE1F?=
 =?us-ascii?Q?RJ7Iulxe84WtO+a1qqLUkmiF0tBv1KuqFzrpmOK86rrcem2iNdZuTHH54vhB?=
 =?us-ascii?Q?H6Ukj4+CJPj1n21RtfHO/JQhzUXud8S0o1oyKONCcpPpknBlJso/tzU01k7r?=
 =?us-ascii?Q?4Y7sUC8V0Xvcimzefdj5ZRF+hulT7ux0NbEkRJRqXEQpNKVzfY0q/KRabUKS?=
 =?us-ascii?Q?drT/FEWt2Gqofo52nHkPV2kYi8UX3zgqosZxbPox03T3lao761FQY+39RJdr?=
 =?us-ascii?Q?U0Uyl5MBATUuGp5I/qdcMbcFmgUEnfPEFAK7br3ASiwhry19bBzsQaWbnWOG?=
 =?us-ascii?Q?Yo3Cve0xgodalThZP5lHy5njna1cVQCYPTLrKC9nRNVB/B6ZLkBgj5CXE5nR?=
 =?us-ascii?Q?ctsadxgqs9BaZuJCxwrfDAIxnMZ2m7KGCn2p+Lz+44BWakHX1dtH6U3zzrUv?=
 =?us-ascii?Q?Ob2JAWevEL6Bfg2ObV/mJmzO0UGPprVLcCUhcgIiX5XF2LHPgCLlsLRpNi0J?=
 =?us-ascii?Q?4vsHKplMlxak8YcZksXLTbW5LTgJg8a5HOsgG9NxzLc7wu2X0nYgnax5WxyQ?=
 =?us-ascii?Q?FWsgjG/OgxYNoNjdnYrf9IxSLIB9NYpqkJyLGeoY8D8X/1BTC+A/kD4yKr+B?=
 =?us-ascii?Q?7IZflSIqYx9Oai5tfOmhdkkZvj030W4Z8vy8cFzpPDeUGsvh9tOv+cXlc10K?=
 =?us-ascii?Q?naiMn6ni2Q+3u3eLO7iE1V5URooDWLOxITMocre2kpk0wU3tAtg0Qx+40em2?=
 =?us-ascii?Q?/BMRi8aX9FFYXy9dUifHK2YMBBxoVjUlLhSzlHLzskxLJcqFb9LoBXwH1fZG?=
 =?us-ascii?Q?O4MB1yCqoHV/xSC7EysZcJn0cAV+eqyYJEjpHf6U9nZTUokpJUz0aW+ozK0D?=
 =?us-ascii?Q?P0NVxk686uSVR/u8BaXFvIf9Vm/5tT1cTFdmom443tNn5vb6KwzfPkfxdkh4?=
 =?us-ascii?Q?QuHSQyKN+cNfRgtIktTtCmU/8119dn3QiSzu3b5r6laGdgy8kASqwoKGZ2J3?=
 =?us-ascii?Q?ejCSfUzC/xr6ryBwrlOuzECcKvZzoJEgA+OhXOSv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73edfa1f-7591-44ae-6988-08dd03c6d874
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:37:52.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41s8bHhIyCyhxesiKaL+VbHh+YK9Lr2McBYDj7JfDz6qvVCnIXKC+W1GGSlmjKeluWsYUo7rAqu+FyraN30hpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293

Thanks for the patch, but there are a few process issues.

On Tue, Nov 12, 2024 at 01:17:11PM -0800, Rosen Penev wrote:
> These are the preferred way to copy ethtool strings.
> 
> Avoids incrementing pointers all over the place.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I only tagged the mlxsw change. The mlxbf change is new.

> ---
>  v3: also convert memcpy.
>  v2: rebase to make it apply.
>  .../mellanox/mlxbf_gige/mlxbf_gige_ethtool.c  |  5 +-

Please split the mlxbf change to a different patch and copy the relevant
maintainers:

davthompson@nvidia.com
asmaa@nvidia.com

Use "mlxbf_gige:" prefix for the mlxbf patch and "mlxsw:" for the mlxsw
patch. You can keep my tag on the latter.


>  .../mellanox/mlxsw/spectrum_ethtool.c         | 83 +++++++------------
>  .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  7 +-
>  3 files changed, 33 insertions(+), 62 deletions(-)

