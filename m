Return-Path: <netdev+bounces-91005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB68B0E22
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB13E1F21275
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC20315FA68;
	Wed, 24 Apr 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TDymtX6W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FE15B97E
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972527; cv=fail; b=M1PUjD7lVhMCEClvgMyYKCVVdfmL/rxbiuVid+2k5KirgQOint9pu2GpY0URLR877345kqRcK4fpDT63jPGGU8nZxFZluNCzVLNLtAfEa/7O0Vw5itOqZ6nM1WZ/WUFUr0s78/XkvIFPw+N9XEjFNA/b93KMZ1VSYlTzykWPAFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972527; c=relaxed/simple;
	bh=iTLYRnFplfIEhuEfvCzEzlB1mBcYhCIfvn2ZGP+5zn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZH4Qb3/15Ji5p5mW9Uy+5eBw9enMpXchT3Zhw64cHSeesrrXraZCAdymgGVPiSVWMsTRrrq6t9TWyj3VAXsnefy6pV1QkW8+/U/wRIvjJiRh+b2fq+gpayKQ79NFh7UHdORByKCNfGJ95ZsWmWi4Y1I4dS8L42QgKMupr/Xr7cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TDymtX6W; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkZwyNWqwIxlIJxo9wAsNsg0g4SCAVQxldDIWbsHM0S1/PfBTsJFNCM7rFp1ykfmIwrKOtNR33Q7xrsTnkvnd0tFInMgEseNJUZ3CqX9vdeS3cwl8SmTxA5Oi3YstMRT9xgE9FOVyKMAH9hWtXPNRQ3Ze9JZ3sJ7OqVNpKIFD0pwNvQsPbDrPk85hy0CCu3j8nglwYxZDlkO02KXI5oJyVLaoydPadNcIFpknRH4m1tfXVKwhHigg70BjoB4bQ2FFcHxMHNAc2LKB8ZUyJoaH+/6NcO69G8AmGoSZuHrT+3OgVhGHMShnZM+hsiMKnbwVq98gQ5/+jCAw+kDFK2inA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLRk/NjQDJfOaOOPhZjKAQBy6rmeS9wOlRODGoR47Fk=;
 b=OpntICcrTkni7uYF0wPtWW8upgN89/p4/UwzT7Z6OOa3yxO2zLXQn95EsCm4MWRQLYVyImEx5g98IDIVTqbo9i0S2YZGIY29GeymaPakeS2H6/UL+4hOzmRyxFs0Q0ebfFbfMJCSaenbStwKbTnxxDsTRClPcTwSxDJlhKAIkeADg362uaKdC543koTvZmoiLmaNz8zSqfWNuqzZOzwd8y8KDvlRGV+Lf1WiahRmR/GA4rQFN+tkUumsd3d0ofX3qCG1720380MgkQsqnl1w01+/Ri3ZtxMDVJIZ/cDYUTrpesL05zhBFK+UQM2ARHhr8mcmBs4n7P6o4HnhRLsirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLRk/NjQDJfOaOOPhZjKAQBy6rmeS9wOlRODGoR47Fk=;
 b=TDymtX6W62ojXOdZD2ubRR8OqGg2HF6QW1zezgTTsNodGOhy/4ApMJ7/iDHFlP7DraoHXNK3hjHojJetN2Jk+A8YBwzF5mD8S12+to4jFYiWvdcWzIYQ9Cc+Mr6BDjP/EIZEF0BymhCJB4irEGRpvZX9y6+8+LD5fLq0U03z4HwEuMdkkbdAbqL+xjqitYOHMbX9bw6jiIaDeiI4BZS07m9pTn3z5HhcW1eleVR5lYXSJjKRBuBptZeRZydMza3g5LY9Lvq/zHa25D90IA5Gp1sG49UuWMBGX/Mi8e22QT4ggnvooFQwzFC56RiUD3K5QFD37PYcOOpaZgf3B5bLkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:28:42 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e%3]) with mapi id 15.20.7519.023; Wed, 24 Apr 2024
 15:28:42 +0000
Date: Wed, 24 Apr 2024 11:28:40 -0400
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v6 4/5] selftests: forwarding: add
 wait_for_dev() helper
Message-ID: <ZiklKADJzFoetPtJ@f4>
References: <20240424104049.3935572-1-jiri@resnulli.us>
 <20240424104049.3935572-5-jiri@resnulli.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424104049.3935572-5-jiri@resnulli.us>
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: d0502785-3608-4e8f-1547-08dc6473394b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8aCctei4+SKLAyX+IEXRkc1HErExm46iUtGRhqANY2gsOYjUHbpP1f9ON1vb?=
 =?us-ascii?Q?zvdCUePBdKhVgVWWNdyQ2dgyW5F/eClfH0Rnqgx3KQmKAb+TmwB+IrJpB0wx?=
 =?us-ascii?Q?ZfoqqFADmSy7154i0cSY5avO/wfaiTvYjCI+6ZnrylMFPpUOFX8KZI+XAJKB?=
 =?us-ascii?Q?6WuZOWNp3S+H+vDBg2YFJ6brVALFYeNGk7k7UnZewyVPWUXD4YBa8RQ74YSx?=
 =?us-ascii?Q?RA3EWZ+V1pLRffUAFq0qE6WoijTNCErQ8B2VzyxA/RI9MUYXogSY3IDSjJln?=
 =?us-ascii?Q?riQn3FT8gsmQVS2hIveW1rEYyPooJv1kYllWOUEhEhul3APudOsgPi5PXNPz?=
 =?us-ascii?Q?DMkLBDmCyO1x5nsiabDn8aSaVcsk5R5m90y2e2HzEqN2bs9sv//4feOoVk09?=
 =?us-ascii?Q?KoJEXrHFzeJuAU4rd+uLbcZdI7OeyiH4Z+wbBZ9hPufum5tKfbQs73S4w0hU?=
 =?us-ascii?Q?nmDJY4A6zTJklxjcrpOirSimSb3/LkOqdJfeP6GJ4eGYyITJp9CSChfJZk4I?=
 =?us-ascii?Q?ijKCPk9VsXaRU14SonCBSJTNu4bzsHspxNR8bB9VQBy0SNrVoQXQu3nQL+7X?=
 =?us-ascii?Q?EYrRK8ZJkC8FPISvBgM0Nhp/IOAEo/2y04+xgvYdaxu31sVdESnGb52QEmVJ?=
 =?us-ascii?Q?gvmgOsV1+BsocC2InUDOfszfifEvWpPmPsqjToUiXH2OXb1ACPEUrrLIajGA?=
 =?us-ascii?Q?n75ZWPH2DEiREGtzOrkfV1UAamxFMug+bPqPcaNv2wbPrLTuQSzgvcMy70WG?=
 =?us-ascii?Q?KQzKteS1q+T5yJgnt4gg6eKFx7+PUODfIqmjk9UOIUyHP6MNVsddRHeEs1Zg?=
 =?us-ascii?Q?A2FCPmjlFvW5iLC/cdLN9yQ0lUOzHaxzO2x0oTZ7g+SbUuSE4rb2bADqxwVY?=
 =?us-ascii?Q?nSkzqthMtMlHQ1gtavj5iZYrvIGM97D7I4sTInwosGOCx6Pdz5zh4n3FoZFY?=
 =?us-ascii?Q?PDGIT/vjKA+5gesvFtZMSrBeEG2383oyKTLwA4ivZeej9OMNXr2yQFCEBUiQ?=
 =?us-ascii?Q?/ZkFzUA8RjRfXj9vaKvG4Gq4Z9WGi54JpbbRnIHE+N7H0YSNBsZLf7RGnPkr?=
 =?us-ascii?Q?WV73ZRm0RD914SYNxUEvDI6STH+YlzNMpymB0VC4Rwp1tjlje4HOQGXrOr1u?=
 =?us-ascii?Q?6SLq1Fb12gT1In3XnE8NH1h2LII7MarW+4D34F8pBubYyL53og6FroR6sNxi?=
 =?us-ascii?Q?i/5TzqOwhAqq2nCip3ommcKOlfwXAEPImLTvUkyqiMiuMub60YX/6NylRmvD?=
 =?us-ascii?Q?6qLUFDVWys9nd6bdcNHNlZwWru9Oxc4Vl4iCMBTlWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ib+HqZTXpzvs3JGHjZh4Vgs9R8BVrYCyLptGiS+cFX8mLCbKLQNyD5Yuz5T/?=
 =?us-ascii?Q?DjwKY0Yv1xJvFhQK/r7hz0XOK9weP7MES4fTkf2lSUn23FDOYX2PwscYrKTC?=
 =?us-ascii?Q?Ea8xZyphVZfeDv1eIQdz9uKSsVPyMcGSA0N5rOhF0WRrzak0VxlsiN+r9KiU?=
 =?us-ascii?Q?8sGY2hs0QpDJOgc9yADvnzFAOd4Az8QiTDBTvBELY0FGD3lBReqsrYrNSoeh?=
 =?us-ascii?Q?cTc31eh2Z+UgpU6QYu7ZY0pF0/oMCJFidj+hmwIlhEiotkw36V687TEPhrnd?=
 =?us-ascii?Q?9/Becp3tnmBPRya6ZjgZPxU8bZcgClXPYrvTZJbnQzAp1t2e1xGqo+bWDmvd?=
 =?us-ascii?Q?vOZA3VaNxiBkf0MbsVkZfMwP/r7TqTC/QqJHAplI1XjVQTWEUg6faUCUqY3V?=
 =?us-ascii?Q?LDBa+Bbr3rlQAjRISt6plVBqyLWWGv6uIRhbv3BRmYRSC3A+pOPNaa6Z0kYO?=
 =?us-ascii?Q?eHVzwaZgICRC4n5bgXzvqwFU3g0+ui4/8ruLuDXMP2a0xrpJz+hupwBJFfI+?=
 =?us-ascii?Q?SvFzi7/VTBVlOEvbny+9EjsM0nn33jq+s8GpZKxEnhCNWXtr1E3blAlhzBfO?=
 =?us-ascii?Q?/mfbJIPDpBf1+3jRUpasf3DP5FaMRafJIh5m9a91bldFk24KoLn6sNXRryg5?=
 =?us-ascii?Q?S+kVIO9d3pYDNST9dAEQcdPW00wkWBUHZX+JoJpfAKqRz2AxbNWyz6RXs1DH?=
 =?us-ascii?Q?m6Opkg2TFU0zMEFLF/VeYIHSyj8HDhiP3JdT8NPaKc9SAC9zH1Ur81wqS4SO?=
 =?us-ascii?Q?IOqn0AsIxBFnvIAr+e6vpCl5/T81KgAsUBiXPJpxo0STUQP8z07mgL7MbEFo?=
 =?us-ascii?Q?hAa1CI7EzKnU0TU3juVs468e/rSMCPLoW1bhLDlUlKx7bZaLaPOGnhbC317G?=
 =?us-ascii?Q?oJPYmlrTmmZCHYqE1X6xQSq+mZKArZgUGToAalsfpaUACeWf3u3+wHJfgIEs?=
 =?us-ascii?Q?SUVzM6iAVZSEU9dE+qJ8wz0oueqMTvSioz91CKIth3IBXs7Tj3d7CuKXm4Sl?=
 =?us-ascii?Q?WW46jYPuvWKKXZjmbPVRa764IvfFsg6uKKdTlzuEa9GBaDhmwXnPqwSUvdBc?=
 =?us-ascii?Q?EWWWm6Zg7gyIBb9mISMyqhHy/hptQFqcptTMqDcw4W1PY9jrKwtGjOs6nBaY?=
 =?us-ascii?Q?BFIWaY2Shhwd32eCbFCEErNHygsD/7dg9J6gdhO9lhcxIJQylGy4N8arEI2W?=
 =?us-ascii?Q?7NqWvxtOYdel9wT6qbLJ/5p5/xrB/7gxUGWUAae74QUi+yTBe5xDTia6Cf/5?=
 =?us-ascii?Q?SJmqk5bWF1tYZOTbokuxYDk3ryvZM3G8imhGc27l9oypvThFmtruzxWHZSyB?=
 =?us-ascii?Q?Ui2M406+YnBUPKZm8gvPQC4kgbi1mKQu+AjKgd+vaBAqnbjNp6IykdmRjQWn?=
 =?us-ascii?Q?rma8u1NZVGWeBxf/T2PKkFRTXctbHcYjmaqLWmCD6geqV53PUy2vKo8R94GJ?=
 =?us-ascii?Q?XLO9yoFebPR5636EgKIgAClNmeIJetQHC3CV8podaWr6AGy/H/wrOAMmRI1C?=
 =?us-ascii?Q?3QYsvKDIMNVG+6NZ89qqsly+ZAgmNHjqPT2iqPeJm3O1Flftc1q2PNSkJqSK?=
 =?us-ascii?Q?Z6kkh5YKqR1CIoNEMsuRudnvUCswPAZnmfGufElX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0502785-3608-4e8f-1547-08dc6473394b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:28:42.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8KbvsaygUP9/TmTBf9nQZ+qa/gmOeixC7Sq60rgOG4Jtivttd2Nztr+8hmvqITrxsR338DeEXCbMAtmiXLSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

On 2024-04-24 12:40 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The existing setup_wait*() helper family check the status of the
> interface to be up. Introduce wait_for_dev() to wait for the netdevice
> to appear, for example after test script does manual device bind.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---

Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>

